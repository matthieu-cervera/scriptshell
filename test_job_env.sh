#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --account=def-pesantg	
#SBATCH --output=testenv-%J.out
#SBATCH --mail-user=matthieu.cervera@hotmail.com
#SBATCH --mail-type=ALL

source pyth-env/bin/activate
python3 pip freeze > installed.txt
echo 'Python environment still here'
deactivate


exit