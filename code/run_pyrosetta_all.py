import pyrosetta
pyrosetta.init()

from pyrosetta import pose_from_pdb, get_fa_scorefxn
import pandas as pd

scorefxn = get_fa_scorefxn()

df = pd.read_csv("/home/mc2571/repos/sabdl/notebooks/Docking/pose_list_all.csv")
results = []

for _, row in df.iterrows():
    target = row["target"]
    method = row["method"]
    pose_id = row["pose_id"]
    pdb_path = row["pdb_path"]

    try:
        pose = pose_from_pdb(pdb_path)
        score = scorefxn(pose)
    except Exception as e:
        print(f"[ERROR] {target} {method} {pose_id} : {e}")
        score = float("nan")

    results.append([target, method, pose_id, pdb_path, score])

out_df = pd.DataFrame(results, columns=[
    "target", "method", "pose_id", "pdb_path", "pyrosetta_total_score"
])
out_df.to_csv("/home/mc2571/repos/sabdl/notebooks/Docking/pyrosetta_scores_all.csv", index=False)

print("DONE: pyrosetta_scores_all.csv")
