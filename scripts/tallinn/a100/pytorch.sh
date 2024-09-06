#!/bin/bash
#SBATCH --partition gpu
#SBATCH --gres gpu:a100:1
#SBATCH --mem-per-gpu 250G
#SBATCH -o logs/slurm-%x-%j-%N.out

IMG=/home/software/singularity/pytorch.simg:2024-08-18
cd ~/particleflow

ulimit -n 10000
singularity exec -B /scratch/persistent --nv \
    --env PYTHONPATH=hep_tfds \
    --env KERAS_BACKEND=torch \
    $IMG python3 mlpf/pyg_pipeline.py --dataset cms --gpus 1 \
    --data-dir /scratch/persistent/joosep/tensorflow_datasets --config parameters/pytorch/pyg-cms.yaml \
    --train --test --make-plots --num-epochs 100 --conv-type attention \
    --num-epochs 5 \
    --gpu-batch-multiplier 32 --checkpoint-freq 1 --num-workers 16 --prefetch-factor 50 --comet
