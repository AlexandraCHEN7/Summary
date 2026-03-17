#!/bin/bash
#SBATCH --job-name=prodigy
#SBATCH --output=/spinning1/scratch/mc2571/model_outputs/prodigy.out
#SBATCH --error=/spinning1/scratch/mc2571/model_outputs/prodigy.err
#SBATCH --nodes=1
#SBATCH --partition=cpu
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8

eval "$(conda shell.bash hook)"
conda activate haddock3

python /home/mc2571/repos/sabdl/notebooks/Docking/run_prodigy_all.py
