#!/bin/bash

# Specify the base directory where the gene_protein folders are located
BASE_DIR="/cluster/scratch/cpaleari/AlphaLink" 
# Iterate through each main folder in the base directory
for main_folder in $BASE_DIR/*; do
  if [[ -d "$main_folder" ]]; then
    # Extract gene name and protein ID from the folder name
    folder_name=$(basename "$main_folder")
    IFS='_' read -r GENE_NAME PROTEIN_ID <<< "$folder_name"

    # Iterate through each subfolder in the main folder
    for subfolder in "$main_folder"/*; do
      if [[ -d "$subfolder" ]]; then
        # Extract the subfolder name
        SUBFOLDER_NAME=$(basename "$subfolder")

        # Call your SLURM batch script with the extracted parameters
        sbatch ./general_alphalink_run_gpu.sh "$GENE_NAME" "$PROTEIN_ID" "$SUBFOLDER_NAME"
      fi
    done
  fi
done
