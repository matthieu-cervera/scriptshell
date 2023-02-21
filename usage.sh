#!/bin/bash
#SBATCH --account=def-pesantg
#SBATCH --mem=5G
#SBATCH --mail-user=matthieu.cervera@hotmail.com
#SBATCH --mail-type=ALL
#SBATCH --time=00:10:00

cp requirements.txt $SLURM_TMPDIR/
cp usage.py $SLURM_TMPDIR/


module load python/3.8
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --upgrade pip --no-index
pip install -r requirements.txt

cd $SLURM_TMPDIR/


ls
python $SLURM_TMPDIR/usage.py

exit