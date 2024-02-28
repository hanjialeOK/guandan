#!/bin/bash
pip install mpi4py -i https://pypi.tuna.tsinghua.edu.cn/simple
mkdir -p /aiarena/nas/guandan_tog/learner_torch/ckpt_bak
rm /aiarena/nas/guandan_tog/learner_torch/ckpt_bak/*.pth
python -u /aiarena/nas/guandan_tog/learner_torch/learner.py