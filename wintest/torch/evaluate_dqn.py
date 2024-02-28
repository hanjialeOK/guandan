import os
import time


def copy():
    path = '/aiarena/nas/guandan_tog/learner_torch/LEARNER-2024-01-08-13-32-33/ckpt/'
    files = os.listdir(path)
    dic = {}
    for name in files:
        form = name.split('.')[0]
        num = int(form[3:]) - 500
        if num > 0 and num % 5000 == 0:
            k = num // 5000
            dic[k] = path + name

    dest = '/aiarena/nas/guandan_tog/wintest/torch/models'
    if not os.path.exists(dest):
        # 创建路径
        os.makedirs(dest)
    exist = os.listdir(dest)
    for k, v in dic.items():
        if v.split('/')[-1] not in exist:
            os.system('cp ' + v + ' '+ dest)
    res = os.listdir(dest)
    return len(res)


def current_log(oppo):
    path = '/aiarena/nas/guandan_tog/wintest/torch/'
    files = os.listdir(path)
    tested = []
    for name in files:
        latter = oppo + '.log'
        if latter in name and 'res' in name:
            val = int(name.split('v')[0][3:])
            tested.append(val)
    return tested


def check(num, oppo):
    tested = current_log(oppo)
    if num not in tested:
        return False
    else:
        return True


oppo = 'dqn'
while True:
    flag = 0
    nums = copy()
    time.sleep(10)
    tested = current_log(oppo)
    time.sleep(10)
    print(nums, tested)
    for i in range(1, nums+1):
        if i not in tested:
            flag = 1
            break
    if flag == 1:
        os.system('bash testvsdqn.sh ' + str(i))
        print('testing {}'.format(i))
        time.sleep(10)
        res = check(i, oppo)
        while not res:
            time.sleep(300)
            res = check(i, oppo)
        os.system('bash kill_auto.sh')
        print('model index {} test finish'.format(i))
        time.sleep(10)
    else:
        time.sleep(600)
