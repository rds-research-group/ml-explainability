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
singularity exec \
	    --overlay $HOME/overlay-5GB-200K.ext3 \
	    /scratch/work/public/singularity/cuda11.0-cudnn8-devel-ubuntu18.04.sif \
	    /bin/bash -c "source ~/.bash_profile; python $HOME/ml-explainability/$1.py"