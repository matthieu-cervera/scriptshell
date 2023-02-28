#!/bin/bash
#SBATCH --account=def-pesantg
#SBATCH --mail-user=matthieu.cervera@hotmail.com
#SBATCH --mail-type=ALL
#SBATCH --gres=gpu:v100l:1 # Request GPU "generic resources"
#SBATCH --cpus-per-task=8  # Cores proportional to GPUs: 6 on Cedar, 16 on Graham.
#SBATCH --mem=48000M       # Memory proportional to GPUs: 32000 Cedar, 64000 Graham.
#SBATCH --time=0-10:00

cp requirements.txt $SLURM_TMPDIR/

module load python/3.8
module load scipy-stack
module load java
module load maven
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --upgrade pip --no-index
pip install -r requirements.txt

java -Xms256m -Xmx4g -version
unset JAVA_TOOL_OPTIONS

cd $SLURM_TMPDIR/
#unzip /home/manibod/scratch/CMTCP_R7_P3_6token3_refactor.zip -d $SLURM_TMPDIR/
#unzip /home/manibod/projects/def-pesantg/manibod/static_data.zip -d $SLURM_TMPDIR/
unzip /home/matt3c/projects/def-pesantg/matt3c/scriptshell/CMT-usagelog-csv.zip -d $SLURM_TMPDIR/
unzip /home/matt3c/scratch/pkl_files_EWLD.zip -d $SLURM_TMPDIR/

python $SLURM_TMPDIR/run.py --idx 2 --gpu_index 0 --ngpu 1 --optim_name adam --restore_epoch -100 --seed 42 --load_rhythm --sample

zip -r results.zip results/idx002/

zip -r /home/manibod/scratch/CMTCP_R7_P3_6token3_refactor_results results/idx001/sampling_results/

cp results.zip /home/matt3c/projects/def-pesantg/matt3c/scriptshell/
cp usage_gen.csv /home/matt3c/projects/def-pesantg/matt3c/scriptshell/

exit