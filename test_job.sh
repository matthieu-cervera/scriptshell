#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --mem=5G
#SBATCH --account=def-pesantg	
#SBATCH --output=test-%J.out
#SBATCH --mail-user=matthieu.cervera@hotmail.com
#SBATCH --mail-type=ALL

cp requirements.txt $SLURM_TMPDIR/

cd $SLURM_TMPDIR/
module load python/3.8
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --upgrade pip --no-index
pip install -r requirements.txt
pip freeze > installed.txt


cp installed.txt projects/def-pesantg/matt3c/scriptshell

exit