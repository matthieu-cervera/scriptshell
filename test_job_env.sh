#!/bin/bash
#SBATCH --time=00:01:00
#SBATCH --account=def-pesantg	
#SBATCH --output=testenv-%J.out
#SBATCH --mail-user=matthieu.cervera@hotmail.com
#SBATCH --mail-type=ALL

source pyth-env/bin/activate
python3 -m pip freeze > installed.txt
echo 'Python environment still here'
deactivate
zip -r CMT_test.zip projects/def-pesantg/matt3c/virasone_project/CMT_CPBP/


exit