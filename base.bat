@echo off

set agent=%1

python .\game.py --save-dir ./Data/Spread/0/%agent%/        --scenario Spread --plots-dir ./Data/Spread/0/%agent%/      --exp-name %agent% --num-adversaries 0 --good-mic 0  --adv-mic 0 
python .\game.py --save-dir ./Data/Spread/1e-1/%agent%/     --scenario Spread --plots-dir ./Data/Spread/1e-1/%agent%/   --exp-name %agent% --num-adversaries 0 --good-mic 1e-1  --adv-mic 0 
python .\game.py --save-dir ./Data/Spread/1e-2/%agent%/     --scenario Spread --plots-dir ./Data/Spread/1e-2/%agent%/   --exp-name %agent% --num-adversaries 0 --good-mic 1e-2 --adv-mic 0
python .\game.py --save-dir ./Data/Spread/1e-3/%agent%/     --scenario Spread --plots-dir ./Data/Spread/1e-3/%agent%/   --exp-name %agent% --num-adversaries 0 --good-mic 1e-3 --adv-mic 0 
python .\game.py --save-dir ./Data/Spread/1e-4/%agent%/     --scenario Spread --plots-dir ./Data/Spread/1e-4/%agent%/   --exp-name %agent% --num-adversaries 0 --good-mic 1e-4 --adv-mic 0 

python .\game.py --save-dir ./Data/Crypto/0/%agent%/        --scenario Crypto --plots-dir ./Data/Crypto/0/%agent%/      --exp-name %agent% --num-adversaries 1 --good-mic 0  --adv-mic 0 
python .\game.py --save-dir ./Data/Crypto/1e-1/%agent%/     --scenario Crypto --plots-dir ./Data/Crypto/1e-1/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-1  --adv-mic 0 
python .\game.py --save-dir ./Data/Crypto/1e-2/%agent%/     --scenario Crypto --plots-dir ./Data/Crypto/1e-2/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-2 --adv-mic 0
python .\game.py --save-dir ./Data/Crypto/1e-3/%agent%/     --scenario Crypto --plots-dir ./Data/Crypto/1e-3/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-3 --adv-mic 0 
python .\game.py --save-dir ./Data/Crypto/1e-4/%agent%/     --scenario Crypto --plots-dir ./Data/Crypto/1e-4/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-4 --adv-mic 0 

python .\game.py --save-dir ./Data/Adversary/0/%agent%/        --scenario Adversary --plots-dir ./Data/Adversary/0/%agent%/      --exp-name %agent% --num-adversaries 1 --good-mic 0    --adv-mic 0 
python .\game.py --save-dir ./Data/Adversary/1e-1/%agent%/     --scenario Adversary --plots-dir ./Data/Adversary/1e-1/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-1  --adv-mic 0 
python .\game.py --save-dir ./Data/Adversary/1e-2/%agent%/     --scenario Adversary --plots-dir ./Data/Adversary/1e-2/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-2 --adv-mic 0
python .\game.py --save-dir ./Data/Adversary/1e-3/%agent%/     --scenario Adversary --plots-dir ./Data/Adversary/1e-3/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-3 --adv-mic 0 
python .\game.py --save-dir ./Data/Adversary/1e-4/%agent%/     --scenario Adversary --plots-dir ./Data/Adversary/1e-4/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-4 --adv-mic 0 

python .\game.py --save-dir ./Data/SpeakerListener/0/%agent%/        --scenario SpeakerListener --plots-dir ./Data/SpeakerListener/0/%agent%/      --exp-name %agent% --num-adversaries 0 --good-mic 0  --adv-mic 0 
python .\game.py --save-dir ./Data/SpeakerListener/1e-1/%agent%/     --scenario SpeakerListener --plots-dir ./Data/SpeakerListener/1e-1/%agent%/   --exp-name %agent% --num-adversaries 0 --good-mic 1e-1  --adv-mic 0 
python .\game.py --save-dir ./Data/SpeakerListener/1e-2/%agent%/     --scenario SpeakerListener --plots-dir ./Data/SpeakerListener/1e-2/%agent%/   --exp-name %agent% --num-adversaries 0 --good-mic 1e-2 --adv-mic 0
python .\game.py --save-dir ./Data/SpeakerListener/1e-3/%agent%/     --scenario SpeakerListener --plots-dir ./Data/SpeakerListener/1e-3/%agent%/   --exp-name %agent% --num-adversaries 0 --good-mic 1e-3 --adv-mic 0 
python .\game.py --save-dir ./Data/SpeakerListener/1e-4/%agent%/     --scenario SpeakerListener --plots-dir ./Data/SpeakerListener/1e-4/%agent%/   --exp-name %agent% --num-adversaries 0 --good-mic 1e-4 --adv-mic 0 

python .\game.py --save-dir ./Data/WorldCom/0/%agent%/        --scenario WorldCom --plots-dir ./Data/WorldCom/0/%agent%/      --exp-name %agent% --num-adversaries 3 --good-mic 0  --adv-mic 0 
python .\game.py --save-dir ./Data/WorldCom/1e-1/%agent%/     --scenario WorldCom --plots-dir ./Data/WorldCom/1e-1/%agent%/   --exp-name %agent% --num-adversaries 3 --good-mic 1e-1  --adv-mic 0 
python .\game.py --save-dir ./Data/WorldCom/1e-2/%agent%/     --scenario WorldCom --plots-dir ./Data/WorldCom/1e-2/%agent%/   --exp-name %agent% --num-adversaries 3 --good-mic 1e-2 --adv-mic 0
python .\game.py --save-dir ./Data/WorldCom/1e-3/%agent%/     --scenario WorldCom --plots-dir ./Data/WorldCom/1e-3/%agent%/   --exp-name %agent% --num-adversaries 3 --good-mic 1e-3 --adv-mic 0 
python .\game.py --save-dir ./Data/WorldCom/1e-4/%agent%/     --scenario WorldCom --plots-dir ./Data/WorldCom/1e-4/%agent%/   --exp-name %agent% --num-adversaries 3 --good-mic 1e-4 --adv-mic 0 

python .\game.py --save-dir ./Data/Uno/0/%agent%/        --scenario Uno --plots-dir ./Data/Uno/0/%agent%/      --exp-name %agent% --num-adversaries 1 --good-mic 0  --adv-mic 0 
python .\game.py --save-dir ./Data/Uno/1e-1/%agent%/     --scenario Uno --plots-dir ./Data/Uno/1e-1/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-1  --adv-mic 0 
python .\game.py --save-dir ./Data/Uno/1e-2/%agent%/     --scenario Uno --plots-dir ./Data/Uno/1e-2/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-2 --adv-mic 0
python .\game.py --save-dir ./Data/Uno/1e-3/%agent%/     --scenario Uno --plots-dir ./Data/Uno/1e-3/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-3 --adv-mic 0 
python .\game.py --save-dir ./Data/Uno/1e-4/%agent%/     --scenario Uno --plots-dir ./Data/Uno/1e-4/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-4 --adv-mic 0 

python .\game.py --save-dir ./Data/Texas/0/%agent%/        --scenario Texas --plots-dir ./Data/Texas/0/%agent%/      --exp-name %agent% --num-adversaries 1 --good-mic 0  --adv-mic 0 
python .\game.py --save-dir ./Data/Texas/1e-1/%agent%/     --scenario Texas --plots-dir ./Data/Texas/1e-1/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-1  --adv-mic 0 
python .\game.py --save-dir ./Data/Texas/1e-2/%agent%/     --scenario Texas --plots-dir ./Data/Texas/1e-2/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-2 --adv-mic 0
python .\game.py --save-dir ./Data/Texas/1e-3/%agent%/     --scenario Texas --plots-dir ./Data/Texas/1e-3/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-3 --adv-mic 0 
python .\game.py --save-dir ./Data/Texas/1e-4/%agent%/     --scenario Texas --plots-dir ./Data/Texas/1e-4/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-4 --adv-mic 0 

python .\game.py --save-dir ./Data/Limit/0/%agent%/        --scenario Limit --plots-dir ./Data/Limit/0/%agent%/      --exp-name %agent% --num-adversaries 1 --good-mic 0  --adv-mic 0 
python .\game.py --save-dir ./Data/Limit/1e-1/%agent%/     --scenario Limit --plots-dir ./Data/Limit/1e-1/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-1  --adv-mic 0 
python .\game.py --save-dir ./Data/Limit/1e-2/%agent%/     --scenario Limit --plots-dir ./Data/Limit/1e-2/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-2 --adv-mic 0
python .\game.py --save-dir ./Data/Limit/1e-3/%agent%/     --scenario Limit --plots-dir ./Data/Limit/1e-3/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-3 --adv-mic 0 
python .\game.py --save-dir ./Data/Limit/1e-4/%agent%/     --scenario Limit --plots-dir ./Data/Limit/1e-4/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-4 --adv-mic 0 

python .\game.py --save-dir ./Data/Leduc/0/%agent%/        --scenario Leduc --plots-dir ./Data/Leduc/0/%agent%/      --exp-name %agent% --num-adversaries 1 --good-mic 0  --adv-mic 0 
python .\game.py --save-dir ./Data/Leduc/1e-1/%agent%/     --scenario Leduc --plots-dir ./Data/Leduc/1e-1/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-1  --adv-mic 0 
python .\game.py --save-dir ./Data/Leduc/1e-2/%agent%/     --scenario Leduc --plots-dir ./Data/Leduc/1e-2/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-2 --adv-mic 0
python .\game.py --save-dir ./Data/Leduc/1e-3/%agent%/     --scenario Leduc --plots-dir ./Data/Leduc/1e-3/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-3 --adv-mic 0 
python .\game.py --save-dir ./Data/Leduc/1e-4/%agent%/     --scenario Leduc --plots-dir ./Data/Leduc/1e-4/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-4 --adv-mic 0 

python .\game.py --save-dir ./Data/Backgammon/0/%agent%/        --scenario Backgammon --plots-dir ./Data/Backgammon/0/%agent%/      --exp-name %agent% --num-adversaries 1 --good-mic 0  --adv-mic 0 
python .\game.py --save-dir ./Data/Backgammon/1e-1/%agent%/     --scenario Backgammon --plots-dir ./Data/Backgammon/1e-1/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-1  --adv-mic 0 
python .\game.py --save-dir ./Data/Backgammon/1e-2/%agent%/     --scenario Backgammon --plots-dir ./Data/Backgammon/1e-2/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-2 --adv-mic 0
python .\game.py --save-dir ./Data/Backgammon/1e-3/%agent%/     --scenario Backgammon --plots-dir ./Data/Backgammon/1e-3/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-3 --adv-mic 0 
python .\game.py --save-dir ./Data/Backgammon/1e-4/%agent%/     --scenario Backgammon --plots-dir ./Data/Backgammon/1e-4/%agent%/   --exp-name %agent% --num-adversaries 1 --good-mic 1e-4 --adv-mic 0 


