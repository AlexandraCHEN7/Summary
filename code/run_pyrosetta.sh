#!/bin/bash
#SBATCH --job-name=pyrosetta
#SBATCH --output=/spinning1/scratch/mc2571/model_outputs/pyrosetta.out
#SBATCH --error=/spinning1/scratch/mc2571/model_outputs/pyrosetta.err
#SBATCH --nodes=1
#SBATCH --partition=cpu
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8

eval "$(conda shell.bash hook)"
conda activate haddock3

python /home/mc2571/repos/sabdl/notebooks/Docking/run_pyrosetta_all.py
