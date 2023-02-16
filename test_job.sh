#!/bin/bash
#SBATCH --time=00:02:00
#SBATCH --account=def-pesantg	
#SBATCH --output=test-%J.out

echo "Hello World"
exit