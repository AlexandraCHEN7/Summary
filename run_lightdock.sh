#!/bin/bash
#SBATCH --job-name=lightdock
#SBATCH --output=/spinning1/scratch/mc2571/model_outputs/1LP1.out
#SBATCH --error=/spinning1/scratch/mc2571/model_outputs/1LP1.err
#SBATCH --nodes=1
#SBATCH --partition=cpu
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --chdir=/spinning1/scratch/mc2571/model_outputs/test_case/1LP1

eval "$(conda shell.bash hook)"
conda activate lightdock311

lightdock3_setup.py LOV2_A.pdb affibody_B.pdb --noxt --noh --now
lightdock3.py setup.json 50 -s fastdfire -c 4

for s in swarm_*/; do
    cd "$s"
    lgd_generate_conformations.py ../Z_A.pdb ../affibody_B.pdb gso_50.out 200
    lgd_cluster_bsas.py gso_50.out
    cd ..
done

lgd_rank.py 50 50

lgd_top.py LOV2_A.pdb affibody_B.pdb rank_by_scoring.list 10
