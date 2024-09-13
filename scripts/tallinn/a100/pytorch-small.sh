#!/bin/bash
#SBATCH --partition gpu
#SBATCH --gres gpu:mig:1
#SBATCH --mem-per-gpu 60G
#SBATCH -o logs/slurm-%x-%j-%N.out

IMG=/home/software/singularity/pytorch.simg:2024-08-18
cd ~/particleflow

env

ulimit -n 10000
singularity exec -B /scratch/persistent --nv \
    --env PYTHONPATH=hep_tfds \
    --env KERAS_BACKEND=torch \
    $IMG python3 mlpf/pyg_pipeline.py --dataset cms --gpus 1 \
    --data-dir /scratch/persistent/joosep/tensorflow_datasets --config parameters/pytorch/pyg-cms.yaml \
    --train --test --make-plots --conv-type attention --attention-type flash --gpu-batch-multiplier 2 --num-workers 1 --prefetch-factor 10 --dtype bfloat16 --checkpoint-freq -1 --ntrain $1 --nvalid 1000 --ntest 1000
