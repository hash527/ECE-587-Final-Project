import pandas as pd
import matplotlib.pyplot as plt
import os

# ---------------------------------------------
# Load CSV
# ---------------------------------------------
CSV_PATH = "results/project/summary.csv"
df = pd.read_csv(CSV_PATH)

# ---------------------------------------------
# Compute MPKI for each row
# ---------------------------------------------
df['MPKI'] = (df['Misses'] / df['Instructions']) * 1000

# ---------------------------------------------
# Compute average IPC & MPKI per predictor
# ---------------------------------------------
grouped = df.groupby("Predictor").agg({
    "IPC": "mean",
    "MPKI": "mean"
}).reset_index()

print(grouped)

# ---------------------------------------------
# Create output directory
# ---------------------------------------------
OUT_DIR = "results/project"
os.makedirs(OUT_DIR, exist_ok=True)

# ---------------------------------------------
# Plot IPC vs Predictor
# ---------------------------------------------
plt.figure(figsize=(10, 6))
plt.bar(grouped["Predictor"], grouped["IPC"], color="skyblue")
plt.title("IPC vs Predictor", fontsize=16)
plt.ylabel("IPC", fontsize=14)
plt.xticks(rotation=45, ha="right")
plt.tight_layout()
plt.savefig(f"{OUT_DIR}/ipc_vs_predictor.png")
plt.close()

print("Saved: ipc_vs_predictor.png")

# ---------------------------------------------
# Plot MPKI vs Predictor
# ---------------------------------------------
plt.figure(figsize=(10, 6))
plt.bar(grouped["Predictor"], grouped["MPKI"], color="salmon")
plt.title("MPKI vs Predictor", fontsize=16)
plt.ylabel("MPKI", fontsize=14)
plt.xticks(rotation=45, ha="right")
plt.tight_layout()
plt.savefig(f"{OUT_DIR}/mpki_vs_predictor.png")
plt.close()

print("Saved: mpki_vs_predictor.png")
