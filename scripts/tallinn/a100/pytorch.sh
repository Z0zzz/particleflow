#!/bin/bash
#SBATCH --partition gpu
#SBATCH --gres gpu:a100:1
#SBATCH --mem-per-gpu 250G
#SBATCH -o logs/slurm-%x-%j-%N.out

IMG=/home/software/singularity/pytorch.simg:2024-12-03
cd ~/particleflow

ulimit -n 10000
singularity exec -B /scratch/persistent --nv \
    --env PYTHONPATH=`pwd` \
    --env KERAS_BACKEND=torch \
    $IMG python3 mlpf/pipeline.py --gpus 1 \
    --data-dir /scratch/persistent/joosep/tensorflow_datasets --config parameters/pytorch/pyg-cms.yaml \
    --train --test --make-plots --conv-type attention \
    --gpu-batch-multiplier 5 --checkpoint-freq 1 --num-workers 5 --prefetch-factor 30 --comet --num-epochs 5 --ntrain 10000 --ntest 10000 --nvalid 10000
