import logging, os

import warnings
warnings.filterwarnings("ignore")

logging.disable(logging.WARNING)
os.environ["TF_CPP_MIN_LOG_LEVEL"] = "3"

import argparse
import numpy as np
import tensorflow as tf
import time
import pickle

import maddpg.common.tf_util as U
from maddpg.trainer.macl import MACLAgentTrainer
import tensorflow.contrib.layers as layers

# python train_hanabi.py --num-episode 100000 --good-mic 0.001 --save-dir ./Hanabi/MACL/0p001/a1/ --plots-dir ./Hanabi/MACL/0p001/a1/ --exp-name a1_0p001

# python train_hanabi.py --num-episode 100000 --good-mic 0 --save-dir ./Hanabi/DDPG/a1/ --plots-dir ./Hanabi/DDPG/a1/ --exp-name a1

# python train_hanabi.py --num-episode 100000 --good-mic 0 --save-dir ./Hanabi/Test/a1/ --plots-dir ./Hanabi/Test/a1/ --exp-name test1

def parse_args():
    parser = argparse.ArgumentParser("Reinforcement Learning experiments for multiagent environments")
    # Environment
    parser.add_argument("--num-episodes", type=int, default=100000, help="number of episodes")
    parser.add_argument("--good-policy", type=str, default="maddpg", help="policy for good agents")
    parser.add_argument("--good-mic", type=str, default=1e-3, help="mutual information coefficient for good agents")
    parser.add_argument("--max-episode-len", type=int, default=100, help="maximum episode length, not used to limit game length" )
    # Core training parameters
    parser.add_argument("--lr", type=float, default=1e-2, help="learning rate for Adam optimizer")
    parser.add_argument("--gamma", type=float, default=0.99, help="discount factor")
    parser.add_argument("--batch-size", type=int, default=1024, help="number of episodes to optimize at the same time")
    parser.add_argument("--num-units", type=int, default=128, help="number of units in the mlp")
    parser.add_argument("--sleep-regimen", action="store_true", default=False, help="only use mic while sleeping")
    # Checkpointing
    parser.add_argument("--exp-name", type=str, default="a1", help="name of the experiment")
    parser.add_argument("--save-dir", type=str, default="./tmp/policy/", help="directory in which training state and model should be saved")
    parser.add_argument("--save-rate", type=int, default=1000, help="save model once every time this many episodes are completed")
    parser.add_argument("--load-dir", type=str, default="", help="directory in which training state and model are loaded")
    # Evaluation
    parser.add_argument("--restore", action="store_true", default=False)
    parser.add_argument("--display", action="store_true", default=False)
    parser.add_argument("--benchmark", action="store_true", default=False)
    parser.add_argument("--benchmark-iters", type=int, default=10000, help="number of iterations run for benchmarking")
    parser.add_argument("--benchmark-dir", type=str, default="./benchmark_files/", help="directory where benchmark data is saved")
    parser.add_argument("--plots-dir", type=str, default="./Hanabi/", help="directory where plot data is saved")
    return parser.parse_args()

def mlp_model(input, num_outputs, scope, reuse=False, num_units=64, rnn_cell=None):
    # This model takes as input an observation and returns values of all actions
    with tf.variable_scope(scope, reuse=reuse):
        out = input
        out = layers.fully_connected(out, num_outputs=num_units, activation_fn=tf.nn.relu)
        out = layers.fully_connected(out, num_outputs=num_units, activation_fn=tf.nn.relu)
        out = layers.fully_connected(out, num_outputs=num_outputs, activation_fn=None)
        return out

def make_env(arglist, benchmark=False):
    from multiagent.scenarios.simple_hanabi import HanabiEnv

    env = HanabiEnv()
    return env

def get_trainers(env, obs_shape_n, arglist):
    trainers = []
    model = mlp_model
    trainer = MACLAgentTrainer
    for i in range(env.n):
        act_shape_n = [env.action_space for i in range(env.n)]
        trainers.append(trainer(
            "agent_%d" % i, model, obs_shape_n, act_shape_n, i, arglist, agent_type="good",
            local_q_func=(arglist.good_policy=='ddpg')))
    return trainers

def train(arglist):
    with U.single_threaded_session():
        # Create environment
        env = make_env(arglist, arglist.benchmark)
        
        # Create agent trainers
        obs_shape_n = [env.observation_space.shape for i in range(env.n)]
        trainers = get_trainers(env, obs_shape_n, arglist)
        print('Using good policy {}'.format(arglist.good_policy))

        # Initialize
        U.initialize()

        # Load previous results, if necessary
        if arglist.load_dir == "":
            arglist.load_dir = arglist.save_dir
        if arglist.display or arglist.restore or arglist.benchmark:
            print('Loading previous state...')
            U.load_state(arglist.load_dir)
        
        episode_rewards = [0.0]  # sum of rewards for all agents
        agent_rewards = [[0.0] for _ in range(env.n)]  # individual agent reward
        final_ep_rewards = []  # sum of rewards for training curve
        final_ep_ag_rewards = []  # agent rewards for training curve
        agent_info = [[[]]]  # placeholder for benchmarking info
        saver = tf.train.Saver()
        obs_n = env.reset()
        episode_step = 0
        train_step = 0
        t_start = time.time()
        done = 0
        current_player_index = 0

        no_op_actions = False 

        print('Starting iterations...')
        while True:
            # get action
            current_player_obs = np.asarray(obs_n)
            original_action = trainers[current_player_index].action(current_player_obs)

            if(no_op_actions):
                action = np.random.choice(np.linspace(0, env.action_space.n-1, num=env.action_space.n, dtype=int), 1, p=original_action)[0] 
                mask = env.getValidActions()

                while(mask[action] == 0):
                    action = np.random.choice(np.linspace(0, env.action_space.n-1, num=env.action_space.n, dtype=int), 1, p=original_action)[0] 
            else:
                # get action mask
                mask = env.getValidActions()
                # zero out invalid options 
                masked_actions = mask * original_action
                # normalize 
                masked_actions = masked_actions / np.nansum(masked_actions)
                # Get action with given probability 
                if(np.isnan(masked_actions).any()):
                    print(current_player_obs)
                    print(masked_actions)
                    print(np.nansum(masked_actions))
                    print(original_action)
                try:
                    action = np.random.choice(np.linspace(0, env.action_space.n-1, num=env.action_space.n, dtype=int), 1, p=masked_actions)[0] 
                except: 
                    print("Exception: choosing random action")
                    action = np.random.choice(np.linspace(0, env.action_space.n-1, num=env.action_space.n, dtype=int), 1)[0]

            new_obs, rew, done, info = env.step(action)

            #trainers[current_player_index].experience(current_player_obs, original_action, mask, rew, new_obs, done)
            trainers[current_player_index].experience(current_player_obs, masked_actions, mask, rew, new_obs, done)

            current_player_index += 1
            if(current_player_index >= len(trainers)):
                current_player_index = 0
                
            
            obs_n = new_obs

            episode_rewards[-1] += rew
            agent_rewards[current_player_index][-1] += rew

            if done:
                obs_n = env.reset()
                episode_step = 0
                episode_rewards.append(0)
                for a in agent_rewards:
                    a.append(0)
                agent_info.append([[]])
                current_player_index = 0

            # increment global step counter
            train_step += 1

            # for benchmarking learned policies
            if arglist.benchmark:
                for i, info in enumerate(info_n):
                    agent_info[-1][i].append(info_n['n'])
                if train_step > arglist.benchmark_iters and (done):
                    file_name = arglist.benchmark_dir + arglist.exp_name + '.pkl'
                    print('Finished benchmarking, now saving...')
                    with open(file_name, 'wb') as fp:
                        pickle.dump(agent_info[:-1], fp)
                    break
                continue

            # for displaying learned policies
            if arglist.display:
                time.sleep(0.1)
                env.render()
                continue

            # update all trainers, if not in display or benchmark mode
            loss = None
            for agent in trainers:
                agent.preupdate()
            for agent in trainers:
                loss = agent.update(trainers, train_step)
                if(loss is not None and agent.sleep_regimen and agent.agent_mic != 0 and train_step % 100 == 0): # Change sleep frequency here if desired
                    original_policy_loss = loss[1]
                    new_loss = agent.update(trainers, train_step, sleeping=True)[1]
                    sleep_iteration = 0
                    while((sleep_iteration < 10) and (new_loss < original_policy_loss * 1.05)):
                        new_loss = agent.update(trainers, train_step, sleeping=True)[1]
                        sleep_iteration += 1 
                        #print("sleep walking")

            # save model, display training output
            if done and  (len(episode_rewards) % arglist.save_rate == 0):
                U.save_state(arglist.save_dir, saver=saver)
                print("steps: {}, episodes: {}, mean episode reward: {}, time: {}".format(
                    train_step, len(episode_rewards), np.mean(episode_rewards[-arglist.save_rate:]), round(time.time()-t_start, 3)))
                t_start = time.time()
                # Keep track of final episode reward
                final_ep_rewards.append(np.mean(episode_rewards[-arglist.save_rate:]))
                for rew in agent_rewards:
                    final_ep_ag_rewards.append(np.mean(rew[-arglist.save_rate:]))

            # saves final episode reward for plotting training curve later
            if len(episode_rewards) > arglist.num_episodes:
                print(arglist.plots_dir)
                print(arglist.exp_name)

                rew_file_name = arglist.plots_dir + arglist.exp_name + '_rewards.pkl'
                with open(rew_file_name, 'wb') as fp:
                    pickle.dump(final_ep_rewards, fp)
                agrew_file_name = arglist.plots_dir + arglist.exp_name + '_agrewards.pkl'
                with open(agrew_file_name, 'wb') as fp:
                    pickle.dump(final_ep_ag_rewards, fp)
                print('...Finished total of {} episodes.'.format(len(episode_rewards)))
                break

if __name__ == '__main__':
    arglist = parse_args()
    train(arglist)
