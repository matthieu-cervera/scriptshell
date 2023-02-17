#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --memory=5G
#SBATCH --account=def-pesantg	
#SBATCH --output=test-%J.out
#SBATCH --mail-user=matthieu.cervera@hotmail.com
#SBATCH --mail-type=ALL

python3 -m venv pyth-env
source pyth-env/bin/activate
python3 -m pip install -r requirements.txt
echo 'Python environment in place'
deactivate


exit