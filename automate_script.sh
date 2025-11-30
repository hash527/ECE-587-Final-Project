#!/bin/bash

# -------------------------
# Configuration
# -------------------------

SIM="$HOME/simulator/ss3/sim-outorder"
RUN="./Run.pl -db ./bench.db"
BASE_ARGS="-fastfwd 50000000 -max:inst 10000000"

BENCHMARKS=("gcc" "go" "li")

# Predictor list (name ? command)
declare -A PREDICTORS
# PREDICTORS["GAg"]="-bpred 2lev -bpred:2lev 1 1024 10 0"
# PREDICTORS["GAp"]="-bpred 2lev -bpred:2lev 1 4096 10 0"
# PREDICTORS["PAg"]="-bpred 2lev -bpred:2lev 1024 1024 10 0"
# PREDICTORS["PAp"]="-bpred 2lev -bpred:2lev 16 256 4 0"
# PREDICTORS["Gshare"]="-bpred 2lev -bpred:2lev 1 1024 10 1"
# PREDICTORS["Comb_bimodal_gshare"]="-bpred comb -bpred:bimod 4096 -bpred:2lev 1 1024 10 1 -bpred:comb 4096"

PREDICTORS["Base"]=""

# -------------------------
# Execution
# -------------------------

for pred in "${!PREDICTORS[@]}"; do
    pred_cmd="${PREDICTORS[$pred]}"

    # Create output directory for this predictor
    outdir="results/project/$pred"
    mkdir -p "$outdir"

    echo "=========================================="
    echo " Running Predictor: $pred"
    echo "=========================================="

    for bench in "${BENCHMARKS[@]}"; do
        outfile="$outdir/${bench}.out"

        echo "Running: Predictor=$pred  Benchmark=$bench"
        echo "Output ? $outfile"

        cmd="$RUN -dir results/gcc1 \
            -benchmark $bench \
            -sim $SIM \
            -args \"$BASE_ARGS $pred_cmd\" \
            >& $outfile"

        # Execute command
        eval $cmd
    done
done
