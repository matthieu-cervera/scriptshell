#!/bin/bash
#SBATCH --account=def-pesantg
#SBATCH --mail-user=matthieu.cervera@hotmail.com
#SBATCH --mail-type=ALL
#SBATCH --gres=gpu:v100l:1 # Request GPU "generic resources"
#SBATCH --mem=5000M
#SBATCH --cpus-per-task=1  # Cores proportional to GPUs: 6 on Cedar, 16 on Graham.
#SBATCH --time=0-00:45

cp requirements.txt usage-thread.csv $SLURM_TMPDIR/

module load python/3.8
module load scipy-stack
module load java
module load maven
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --upgrade pip --no-index
pip install -q -r requirements.txt

java -Xms256m -Xmx4g -version
unset JAVA_TOOL_OPTIONS

cd $SLURM_TMPDIR/

unzip -q /home/matt3c/projects/def-pesantg/matt3c/scriptshell/CMT-thread.zip -d $SLURM_TMPDIR/
unzip -q /home/matt3c/projects/def-pesantg/matt3c/scriptshell/results.zip -d $SLURM_TMPDIR/
unzip -q /home/matt3c/scratch/pkl_files_EWLD.zip -d $SLURM_TMPDIR/

rm -r results/idx002/sampling_results/

cd $SLURM_TMPDIR/

python $SLURM_TMPDIR/run_w_threads.py --idx 2 --gpu_index 0 --ngpu 1 --optim_name adam --restore_epoch -100 --seed 42 --load_rhythm --sample


cd $SLURM_TMPDIR/

zip -q -r results_sampling.zip results/idx002/sampling_results/


cp results_sampling.zip /home/matt3c/projects/def-pesantg/matt3c/scriptshell/
cp usage-thread.csv /home/matt3c/projects/def-pesantg/matt3c/scriptshell/

exit
