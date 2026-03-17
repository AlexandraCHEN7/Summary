import os
import subprocess
import pandas as pd

base_root = "poses"
targets = ["1LP1", "3MZW", "5DJT", "5DJU", "5EFW"]
methods = ["ClusPro", "HADDOCK3", "LightDock", "native"]

rows = []

for target in targets:
    for method in methods:
        method_dir = os.path.join(base_root, target, method)
        if not os.path.isdir(method_dir):
            continue
        
        for f in os.listdir(method_dir):
            if not f.endswith(".pdb"):
                continue
            
            pdb_path = os.path.join(method_dir, f)
            pose_id = f[:-4]

            result = subprocess.run(
                ["prodigy", "-q", pdb_path],
                stdout=subprocess.PIPE,
                stderr=None,
                text=True,
            )

            line = result.stdout.strip()
            if not line:
                continue
            name, score_str = line.split()
            dG = float(score_str)

            rows.append([target, method, pose_id, pdb_path, dG])

df = pd.DataFrame(rows, columns=["target", "method", "pose_id", "pdb_path", "prodigy_dG"])
df.to_csv("/home/mc2571/repos/sabdl/notebooks/Docking/prodigy_scores_all.csv", index=False)

print("DONE: prodigy_scores_all.csv")
