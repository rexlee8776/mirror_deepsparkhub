# Copyright (c) 2022 Iluvatar CoreX. All rights reserved.
# Copyright Declaration: This software, including all of its code and documentation,
# except for the third-party software it contains, is a copyrighted work of Shanghai Iluvatar CoreX
# Semiconductor Co., Ltd. and its affiliates ("Iluvatar CoreX") in accordance with the PRC Copyright
# Law and relevant international treaties, and all rights contained therein are enjoyed by Iluvatar
# CoreX. No user of this software shall have any right, ownership or interest in this software and
# any use of this software shall be in compliance with the terms and conditions of the End User
# License Agreement.
#!/bin/bash -ex
# Modify me
if [ -z "$IMAGENETTE" ];then
	DATA_PATH=${DATA_PATH:-"/home/datasets/cv/imagenet"}
else
	# for quick test
	DATA_PATH="/home/datasets/cv/imagenette"
fi

# Don't modify
CURRENT_DIR=$(cd `dirname $0`; pwd)
ROOT_DIR=${CURRENT_DIR}
PYTHONARG='-m torch.distributed.launch --nproc_per_node auto --use_env --master_port 10002'
# For debugging
if [ ! -z "${DEBUG}" ];then
	PYTHONAR="${PYTHONAR} -m pdb"
fi
cd ${ROOT_DIR}
python3  $PYTHONARG ${ROOT_DIR}/run_train.py  \
	--model mobilenet_v3_large --dali --dali-cpu   \
	--data-path $DATA_PATH  \
	--opt rmsprop --batch-size 64  \
	--lr 0.001 --wd 0.00001 --lr-step-size 2 --lr-gamma 0.973  \
	--amp --auto-augment imagenet --random-erase 0.2 "$@"
