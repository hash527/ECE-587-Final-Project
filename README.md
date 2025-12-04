**<h1>SimpleScalar sim-outorder simulator with Alpha 21264 Branch Predictor</h1>**

We implement the Alpha 21264 tournament branch predictor as shown in the figure below

<img width="942" height="400" alt="image" src="https://github.com/user-attachments/assets/125684df-ca8b-4531-b0d4-5506bf93465e" />

The current Simplscalar uses 2-bit up-down saturating counter arrays for all counter tables. We modified one of the tables (the local PHT) to employ 3-bit up-down saturating counters.

The local predictor, global predictor, and meta (or choice) predictor in the original Simplescalar used some PC bits to index; we modify the original code to use the global history.

**<h2>Compilation</h2>**
make clean

make "CFLAGS += -DALPHA_21264_BP" #new simulator 

make #old simulator

**<h2>Simulation</h2>**
Run the shell script automate script.sh

