#!/bin/bash
nohup /aiarena/nas/guandan_tog/actor_torch/danserver 100000 >/dev/null 2>&1 &
sleep 3s
nohup /root/miniconda3/envs/guandan/bin/python -u /aiarena/nas/guandan_tog/actor_torch/actor.py --ip $MASTER_ADDR > /home/root/actor_out.log 2>&1 &
sleep 1s
# 这里使用追加写，判断每次游戏连接是否正常
echo -e "\nrun game:" >> /home/root/game_out.log
nohup /root/miniconda3/envs/guandan/bin/python -u /aiarena/nas/guandan_tog/actor_torch/game.py >> /home/root/game_out.log 2>&1 &
