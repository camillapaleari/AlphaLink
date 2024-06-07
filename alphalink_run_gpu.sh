#!/bin/bash  
#SBATCH -n 1
#SBATCH --cpus-per-task=8
#SBATCH --gpus=1                
#SBATCH --time=8:00              # Time limit hrs:min:sec
#SBATCH --mem-per-cpu=2000
#SBATCH  --tmp=4000
#SBATCH --job-name=alphalink
#SBATCH --output=OUTPUT.out
#SBATCH --error=ERROR.err
# Load necessary modules
#module load python/3.7             
module load cuda               
module load gcc              

export PYTHON_PATH=$PYTHON_PATH:/cluster/home/cpaleari/miniconda3/envs/alphalink_env2/bin/python3.7
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cluster/home/cpaleari/miniconda3/envs/alphalink_env2/lib/ # Adjust the path to your virtual environment

python /cluster/scratch/cpaleari/AlphaLink/predict_with_crosslinks.py /cluster/scratch/cpaleari/AlphaLink/PGK1_P00560/P00560.fasta /cluster/scratch/cpaleari/AlphaLink/PGK1_P00560/50kglu/restraint_distributions.csv --distograms --checkpoint_path /cluster/scratch/cpaleari/resources/Alphalink_params/finetuning_model_5_ptm_distogram.pt --uniref90_database_path  /cluster/project/alphafold/uniref90/uniref90.fasta --mgnify_database_path /cluster/project/alphafold/mgnify/mgy_clusters_2022_05.fa  --pdb70_database_path /cluster/project/alphafold/pdb70 --uniclust30_database_path /cluster/project/alphafold/uniclust30/uniclust30_2018_08 --jackhmmer_binary_path /cluster/home/cpaleari/miniconda3/envs/openfold_env/bin/jackhmmer  --hhblits_binary_path /cluster/home/cpaleari/miniconda3/envs/openfold_env/bin/hhblits  --hhsearch_binary_path /cluster/home/cpaleari/miniconda3/envs/openfold_env/bin/hhsearch  --kalign_binary_path /cluster/home/cpaleari/miniconda3/envs/openfold_env/bin/kalign