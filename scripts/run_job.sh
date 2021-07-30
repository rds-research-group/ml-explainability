# !/bin/bash
echo "****** Getting latest changes from GitHub ******"
git pull --ff-only origin main

echo "****** Installing dependencies ******"
module purge
module load python/intel/3.8.6

pip install --no-index --upgrade pip
pip install -U jupyter

echo "****** Convert notebook file to script ******"
jupyter nbconvert --to script $HOME/ml-explainability/$2.ipynb

echo "****** Starting postgres slurm job ******"
cp $HOME/ml-explainability/scripts/postgresql.sbatch $SCRATCH/postgresql.sbatch
cd $SCRATCH
mkdir -p logs
sbatch --mail-user=$1 --time=$3 --output=$SCRATCH/logs/postgres-%J.log postgresql.sbatch

echo "****** Starting jupyter notebook slurm job ******"
cd -
mkdir -p $HOME/ml-explainability/scripts/logs
sbatch --mail-user=$1 --time=$3 --output=$HOME/ml-explainability/scripts/logs/jupyter-notebook-%J.log notebook.sbatch $2