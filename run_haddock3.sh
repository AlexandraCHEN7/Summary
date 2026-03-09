#!/bin/bash
#SBATCH --job-name=haddock3
#SBATCH --output=/spinning1/scratch/mc2571/model_outputs/1LP1.out
#SBATCH --error=/spinning1/scratch/mc2571/model_outputs/1LP1.err
#SBATCH --nodes=1
#SBATCH --partition=cpu
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8

eval "$(conda shell.bash hook)"
conda activate haddock3

haddock3 haddock3.cfg


