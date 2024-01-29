#!/bin/sh
#
# Replace ACCOUNT with your account name before submitting.
#
#SBATCH --account=myers          # Replace ACCOUNT with your group account name
#SBATCH --job-name=rh2825CXIOQ2  # The job name
#SBATCH --cpus-per-task=16       # Number of nodes
#SBATCH --time=0-12:00           # The time the job will take to run in D-HH:MM
#SBATCH --mem=50G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=[CUID]4@columbia.edu

echo "Launching a feb run"
date

# Capture environment information
echo "Running on node: $(hostname)"
echo "User: $USER"

module purge
module load DefaultModules gcc/10.2.0 mvapich2/gcc/64 openblas anaconda
module list

# Remove prior files if exist
rm -f calibration_eq_IT.out dakota_tabular.txt LHS* force.txt disp.txt

# Run Dakota with debugging output
echo "Running Dakota..."
dakota -i calibration_eq_IT.in

# to re-run dakota after time
