#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --mem=5G
#SBATCH --account=def-pesantg	
#SBATCH --output=test-%J.out
#SBATCH --mail-user=matthieu.cervera@hotmail.com
#SBATCH --mail-type=ALL

cp requirements.txt $SLURM_TMPDIR/

module load python/3.8
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --upgrade pip --no-index
pip install -r requirements.txt

cd $SLURM_TMPDIR/
unzip CMT_test.zip -d $SLURM_TMPDIR/
unzip /home/matt3c/scratch/pkl_files_EWLD.zip -d $SLURM_TMPDIR/

ls 
exit