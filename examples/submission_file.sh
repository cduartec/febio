#!/bin/sh
#
# Replace ACCOUNT with your account name before submitting.
#
#SBATCH --account=myers          # Replace ACCOUNT with your group account name
#SBATCH --job-name=neo_hookean   # The job name
#SBATCH -c 1                     # Number of cpu cores to use
#SBATCH --time=0-12:00           # The time the job will take to run in D-HH:MM
#SBATCH --mem-per-cpu=15gb       # The memory the job will use per cpu core
#SBATCH --mail-type=ALL
#SBATCH --mail-user=cad2244@columbia.edu # Change with personal e-mail

echo "Launching a feb run"
date

module purge
module load DefaultModules gcc/10.2.0 mvapich2/gcc/64 openblas anaconda
module list

mpiexec /burg/myers/projects/febio/febio35/bin/febio3 neo_hookean_dynamic.feb