#!/bin/bash

#SBATCH --job-name=jupyter
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=64GB

module purge
module load python/intel/3.8.6

pip install --no-index --upgrade pip
pip install --no-index -r requirements.txt
python $HOME/scripts/$1.py