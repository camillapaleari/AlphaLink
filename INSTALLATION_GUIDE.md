# AlphaLink Installation Guide

This guide provides step-by-step instructions for installing AlphaLink, including setting up the necessary Miniconda environment and preparing the OpenFold environment.

## Step 1: Install Miniconda

1. **Create a directory for Miniconda**:
    ```bash
    mkdir -p ~/miniconda3
    ```

2. **Download the latest version of Miniconda**:
    ```bash
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    ```

3. **Run the install script**:
    ```bash
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    ```

4. **Delete the install script**:
    ```bash
    rm -rf ~/miniconda3/miniconda.sh
    ```

5. **Add a conda initialize to your bash**:
    ```bash
    ~/miniconda3/bin/conda init bash
    ```

6. **Verify the installation**:
    ```bash
    conda list
    ```

7. **Install Mamba via conda** (for faster dependency resolution):
    ```bash
    conda install conda-forge::mamba
    ```
## Step 3: Clone AlphaLink
0. **Move to scratch directory**:
    ```bash
    cd cluster/scratch/username
    ```
1. **Clone the AlphaLink repository**:
    ```bash
    git clone https://github.com/lhatsk/AlphaLink.git
    ```

2. **Change directory to AlphaLink**:
    ```bash
    cd AlphaLink
    ```

3. **Create the AlphaLink environment using Mamba**:
    ```bash
    mamba env create -n alphalink_env -f environment.yml
    ```

4. **Activate the AlphaLink environment**:
    ```bash
    conda activate alphalink_env
    ```

## Step 4: Download Weights

1. **Prepare the resources directory**:
    ```bash
    mkdir resources
    cd resources
    ```

2. **Download the weights** (ensure you have enough space):
    ```bash
    wget -O finetuning_model_5_ptm_distogram.pt.gz "https://www.dropbox.com/s/5jmb8pxmt5rr751/finetuning_model_5_ptm_distogram.pt.gz?dl=1"
    ```

3. **Extract the weights**:
    ```bash
    gunzip finetuning_model_5_ptm_distogram.pt.gz
    ```

## Step 5: Prepare Input Files and Run AlphaLink

1. **Put in the FASTA file and a CSV called `restraints.csv`** with pairs of residues and distance distributions. Format for `restraints.csv`:
    ```
    residueFrom,residueTo,meanDistance,standard deviation, distribution type (normal/log-normal)
    ```
    Example:
    ```
    12,135,15.0,5.0,normal
    ```

2. **Create the distograms** using the provided Python script:
    ```bash
    python preprocessing_distributions.py --infile /path/to/restraints.csv --outfile /path/to/output/
    ```

3. **Run the `.sh` script with `sbatch`** (adjust script and paths as necessary for your computing environment).
    ```bash
    sbatch alphalink_run_gpu.sh
    ```
