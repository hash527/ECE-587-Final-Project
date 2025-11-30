#!/bin/bash

# -----------------------------------------
# Script to extract stats from .out files
# -----------------------------------------

BASE_DIR="results/project"

PRED_LIST=(
  "GAg"
  "GAp"
  "PAg"
  "PAp"
  "Gshare"
  "Comb_bimodal+gshare"
  "Alpha21264"
  "Base"
)

OUTPUT="$BASE_DIR/summary.csv"

echo "Predictor,Benchmark,IPC,CPI,Instructions,DirRate,AddrRate,Misses,Lookups" > $OUTPUT

# -----------------------------------------
# Loop through all predictors
# -----------------------------------------

for pred in "${PRED_LIST[@]}"; do
    pred_dir="$BASE_DIR/$pred"

    echo "Processing predictor: $pred"

    # Each predictor folder has 3 .out files
    for outfile in "$pred_dir"/*.out; do
        bench=$(basename "$outfile" .out)

        # Extract fields using grep + awk or cut
        ipc=$(grep -m1 "sim_IPC" "$outfile" | awk '{print $2}')
        cpi=$(grep -m1 "sim_CPI" "$outfile" | awk '{print $2}')
        insn=$(grep -m1 "sim_num_insn" "$outfile" | awk '{print $2}')

        # Predictor-specific names vary, so use wildcard
        dir_rate=$(grep -m1 "bpred_.*\.bpred_dir_rate" "$outfile" | awk '{print $2}')
        addr_rate=$(grep -m1 "bpred_.*\.bpred_addr_rate" "$outfile" | awk '{print $2}')
        misses=$(grep -m1 "bpred_.*\.misses" "$outfile" | awk '{print $2}')
        lookups=$(grep -m1 "bpred_.*\.lookups" "$outfile" | awk '{print $2}')

        # Append to CSV
        echo "$pred,$bench,$ipc,$cpi,$insn,$dir_rate,$addr_rate,$misses,$lookups" >> $OUTPUT
    done

done

echo "---------------------------------------------"
echo " Summary saved to: $OUTPUT"
echo "---------------------------------------------"
