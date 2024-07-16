#!/bin/bash

# SLURM directives
#SBATCH -n 1
#SBATCH --cpus-per-task=16
#SBATCH --gpus=1
#SBATCH --time=00:30:00              # Time limit hrs:min:sec
#SBATCH --mem-per-cpu=2000
#SBATCH --tmp=4000
sleep 2
# Load necessary modules
# module load python/3.7
module load cuda
module load gcc

# Define variables for easy changes
GENE_NAME=$1
PROTEIN_ID=$2
FOLDER_NAME="Alphalink1_only_true2/${GENE_NAME}_${PROTEIN_ID}"  # Construct folder name dynamically
SUBFOLDER_NAME=$3

PYTHON_ENV_PATH="/cluster/home/cpaleari/miniconda3/envs/alphalink_env2"
RESOURCES_PATH="/cluster/scratch/cpaleari/resources"
ALPHAFOLD_DB_PATH="/cluster/project/alphafold"
OUTPUT_POSTFIX="${SUBFOLDER_NAME}_neff5"

export PYTHON_PATH=$PYTHON_PATH:${PYTHON_ENV_PATH}/bin/python3.7
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${PYTHON_ENV_PATH}/lib

#cd /cluster/scratch/cpaleari/AlphaLink/${FOLDER_NAME}/
# Download protein fasta file
#wget https://rest.uniprot.org/uniprotkb/${PROTEIN_ID}.fasta

cd /cluster/scratch/cpaleari/AlphaLink/

#Process distribution from restraint.csv
python preprocessing_distributions.py --infile /cluster/scratch/cpaleari/AlphaLink/${FOLDER_NAME}/${SUBFOLDER_NAME}/restraints.csv --outfile /cluster/scratch/cpaleari/AlphaLink/${FOLDER_NAME}/${SUBFOLDER_NAME}/restraint_distributions.csv


python predict_with_crosslinks.py /cluster/scratch/cpaleari/AlphaLink/${FOLDER_NAME}/${PROTEIN_ID}.fasta /cluster/scratch/cpaleari/AlphaLink/${FOLDER_NAME}/${SUBFOLDER_NAME}/restraint_distributions.csv --distograms --data_random_seed 0 --neff 5 --checkpoint_path ${RESOURCES_PATH}/Alphalink_params/finetuning_model_5_ptm_distogram.pt --output_dir /cluster/scratch/cpaleari/AlphaLink/${FOLDER_NAME}/${SUBFOLDER_NAME}/ --output_postfix ${OUTPUT_POSTFIX} --uniref90_database_path ${ALPHAFOLD_DB_PATH}/uniref90/uniref90.fasta --mgnify_database_path ${ALPHAFOLD_DB_PATH}/mgnify/mgy_clusters_2022_05.fa  --pdb70_database_path ${ALPHAFOLD_DB_PATH}/pdb70/pdb70 --uniclust30_database_path ${ALPHAFOLD_DB_PATH}/uniclust30/uniclust30_2018_08 --jackhmmer_binary_path ${PYTHON_ENV_PATH}/bin/jackhmmer  --hhblits_binary_path ${PYTHON_ENV_PATH}/bin/hhblits  --hhsearch_binary_path ${PYTHON_ENV_PATH}/bin/hhsearch  --kalign_binary_path ${PYTHON_ENV_PATH}/bin/kalign
