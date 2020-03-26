#!/usr/bin/env bash

set -x

PARTITION=$1
JOB_NAME=$2
CONFIG=$3
WORK_DIR=$4
GPUS=${5:-8}
GPUS_PER_NODE=$GPUS
CPUS_PER_TASK=$GPUS
SRUN_ARGS=${SRUN_ARGS:-""}
PY_ARGS=${PY_ARGS:-"--validate"}

srun -p ${PARTITION} \
    --job-name=${JOB_NAME} \
    --gres=gpu:${GPUS_PER_NODE} \
    --ntasks=${GPUS} \
    --ntasks-per-node=${GPUS_PER_NODE} \
    --cpus-per-task=${CPUS_PER_TASK} \
    --kill-on-bad-exit=1 \
    ${SRUN_ARGS} \
    python -u tools/train.py ${CONFIG} --work_dir=${WORK_DIR} --launcher="slurm" ${PY_ARGS}