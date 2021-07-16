#!/bin/bash

#SBATCH --job-name=postgres
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8GB
#SBATCH --dependency=singleton

export DB_DIR=$SCRATCH/db

module purge
module load postgresql/intel/13.2

postgres -i -D $DB_DIR