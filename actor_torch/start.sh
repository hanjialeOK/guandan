#!/bin/bash
mkdir -p /aiarena/nas/guandan_tog/learner_torch/ckpt_bak
# rm -rf /aiarena/nas/guandan_tog/actor_results/actor_$RANK/
# mkdir -p /aiarena/nas/guandan_tog/actor_results/actor_$RANK/
chmod +x /aiarena/nas/guandan_tog/actor_torch/danserver
nohup /aiarena/nas/guandan_tog/actor_torch/danserver 100000 > /home/root/danserver.log 2>&1 &
sleep 3s
nohup /root/miniconda3/envs/guandan/bin/python -u /aiarena/nas/guandan_tog/actor_torch/actor.py --ip $MASTER_ADDR > /home/root/actor_out.log 2>&1 &
sleep 0.5s
# 这里使用追加写，判断每次游戏连接是否正常
echo -e "\nrun game:" >> /home/root/game_out.log
nohup /root/miniconda3/envs/guandan/bin/python -u /aiarena/nas/guandan_tog/actor_torch/game.py >> /home/root/game_out.log 2>&1 &
sleep 0.5s 
nohup /root/miniconda3/envs/guandan/bin/python -u /aiarena/nas/guandan_tog/actor_torch/restart.py > /home/root/restart_out.log 2>&1 &