#!/bin/bash
echo "****** Getting latest changes from GitHub ******"
git pull --ff-only origin main

echo "****** Installing dependencies ******"
module purge
module load python/intel/3.8.6

pip install --no-index --upgrade pip
pip install -U jupyter

echo "****** Convert notebook file to script ******"
jupyter nbconvert --to script ./$2.ipynb

echo "****** Starting slurm batch job ******"
sbatch <<EOT
#!/bin/sh

#SBATCH --mail-user=$1
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=64GB
#SBATCH --time=$3
#SBATCH --output=/scripts/logs/jupyter-notebook-%J.log

module purge
module load python/intel/3.8.6

pip install --no-index --upgrade pip
pip install --no-index -r requirements.txt
python ./$2.py
EOT
