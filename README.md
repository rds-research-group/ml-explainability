# ML-Explainability

Shared drive files [here](https://drive.google.com/drive/folders/17yneYJ8NzbSN5tS2RLCpaxA35sVmoP5h?usp=sharing).

## Singularity and conda setup

1. Check to see singularity is installed `which singularity`
2. Check version `singularity version`
3. Copy the gzipped overlay image into your `home/<NET_ID>` directory `cp -rp /scratch/work/public/overlay-fs-ext3/overlay-5GB-200K.ext3.gz .`
4. Unzip image `gunzip overlay-5GB-200K.ext3.gz`
5. Launch container interactively `singularity exec --overlay overlay-5GB-200K.ext3 /scratch/work/public/singularity/cuda11.0-cudnn8-devel-ubuntu18.04.sif /bin/bash`
6. Inside container, install miniconda into /ext3/miniconda3 `wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh`
   1. `sh Miniconda3-latest-Linux-x86_64.sh -b -p /ext3/miniconda3`
   2. `export PATH=/ext3/miniconda3/bin:$PATH`
   3. `conda update -n base conda -y`
7. Setup pathing run `bash`
   1. Run/reload file `source /ext3/miniconda3/etc/profile.d/conda.sh`
   2. Export path to `.bash_profile` by running `export PATH=/ext3/miniconda3/bin:$PATH`
      1. Troubleshooting, this may not work and you may need to set this manually
      2. Manually set path, in home root `vi .bash_profile`
      3. Add `export PATH=/ext3/miniconda3/bin:$PATH` to file (vim cheatsheet here: https://vim.rtorr.com/)
      4. After saving and quiting reload file `source .bash_profile`
8. Exit container
9. Relaunch Container `singularity exec --overlay overlay-5GB-200K.ext3 /scratch/work/public/singularity/cuda10.1-cudnn7-devel-ubuntu18.04.sif /bin/bash`
10. source `/ext3/env.sh` or source `.bash_profile` depending on how you resolved pathing
11. Test to see dependencies are installed correctly `which python`
12. Check version `python --version`
13. Update version `conda install python`
14. Install additional dependencies in singularity container `pip install jupyter pandas matplotlib scipy scikit-learn seaborn`
15. Profit

### Testing jupyter notebooks locally

1. In container run `jupyter notebook --no-browser --port 8870`
2. On local machine run `ssh -NfL 8870:localhost:8870 <NET_ID>@greene.hpc.nyu.edu`
3. Open brower tab with localhost address/port (in container log statements)
