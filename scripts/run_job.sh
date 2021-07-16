# !/bin/bash
echo "****** Getting latest changes from GitHub ******"
git pull --ff-only origin main

echo "****** Installing dependencies ******"
module purge
module load python/intel/3.8.6

pip install --no-index --upgrade pip
pip install -U jupyter

echo "****** Convert notebook file to script ******"
jupyter nbconvert --to script $HOME/scripts/$2.ipynb

echo "****** Starting postgres slurm job ******"
cd $SCRATCH
mkdir -p logs

sbatch --mail-user=$1 --time=$3 --output=$SCRATCH/logs/postgres-%J.log postgresql.sbatch

echo "****** Starting jupyter notebook slurm job ******"
cd -
mkdir -p logs

sbatch <<EOT
#!/bin/bash

#SBATCH --job-name=jupyter
#SBATCH --mail-user=$1
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=64GB
#SBATCH --time=$3
#SBATCH --output=$HOME/scripts/logs/jupyter-notebook-%J.log

module purge
module load python/intel/3.8.6

pip install --no-index --upgrade pip
pip install --no-index -r requirements.txt
python $HOME/scripts/$2.py
EOT
