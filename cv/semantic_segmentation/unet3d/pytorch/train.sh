SEED=1234
MAX_EPOCHS=5000
QUALITY_THRESHOLD="0.908"
START_EVAL_AT=1000
EVALUATE_EVERY=20
LEARNING_RATE="0.8"
LR_WARMUP_EPOCHS=200
BATCH_SIZE=4
GRADIENT_ACCUMULATION_STEPS=1
SAVE_CKPT="./ckpt_full"
LOG_NAME='full_train_log.json'

if [ ! -d ${SAVE_CKPT} ]; then
    mkdir ${SAVE_CKPT};
fi

CUDA_VISIBLE_DEVICES=0 python3 -u main.py \
--data_dir data/kits19/train \
--epochs ${MAX_EPOCHS} \
--evaluate_every ${EVALUATE_EVERY} \
--start_eval_at ${START_EVAL_AT} \
--quality_threshold ${QUALITY_THRESHOLD} \
--batch_size ${BATCH_SIZE} \
--optimizer sgd \
--ga_steps ${GRADIENT_ACCUMULATION_STEPS} \
--learning_rate ${LEARNING_RATE} \
--seed ${SEED} \
--lr_warmup_epochs ${LR_WARMUP_EPOCHS} \
--output-dir ${SAVE_CKPT} \
--log_name ${LOG_NAME} \
"$@"

if [ $? -eq 0 ];then
    echo 'converged to the target value 0.908 of epoch 3820 in full train, stage-wise training succeed'
    exit 0
else
    echo 'not converged to the target value, training fail'
    exit 1
fi

