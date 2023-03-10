#!/bin/bash
#SBATCH --account=def-pesantg
#SBATCH --mail-user=matthieu.cervera@hotmail.com
#SBATCH --mail-type=ALL
#SBATCH --output=training-%J.out
#SBATCH --gres=gpu:v100l:1 # Request GPU "generic resources"
#SBATCH --mem=9000M       # Memory proportional to GPUs: 32000 Cedar, 64000 Graham.
#SBATCH --time=0-10:00

cp requirements.txt usage-train-thread.csv $SLURM_TMPDIR/

module load python/3.8
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --upgrade pip --no-index
pip install -q -r requirements.txt

cd $SLURM_TMPDIR/
unzip -q /home/matt3c/projects/def-pesantg/matt3c/scriptshell/CMT-train-thread.zip -d $SLURM_TMPDIR/
unzip -q /home/matt3c/scratch/pkl_files_EWLD.zip -d $SLURM_TMPDIR/

python $SLURM_TMPDIR/run_w_threads.py --idx 2 --gpu_index 0 --ngpu 1 --optim_name adam --restore_epoch -1 --seed 42

zip -q -r resultscheap.zip results/idx002/


cp resultscheap.zip /home/matt3c/projects/def-pesantg/matt3c/scriptshell/
cp usage-train-thread.csv /home/matt3c/projects/def-pesantg/matt3c/scriptshell/
cp results/idx002/sampling_results/epoch_-100/epoch100_sample1997.mid /home/matt3c/projects/def-pesantg/matt3c/scriptshell/
cp results/idx002/sampling_results/epoch_-100/epoch100_sample1998.mid /home/matt3c/projects/def-pesantg/matt3c/scriptshell/

exit