#!/usr/bin/env bash
# slurm settings
#SBATCH --job-name=openfold-6KWC1
#SBATCH --account=REPLACE_ACCOUNT
#SBATCH --partition=REPLACE_GPU_PARTITION
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --gpus=1
#SBATCH --time=02:00:00
#SBATCH --output=evidence/slurm-%j.out
#SBATCH --error=evidence/slurm-%j.err

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR"

# module purge
# module load cuda/REPLACE
# module load miniforge/REPLACE

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate openfold-repro

mkdir -p evidence
date
hostname
nvidia-smi

bash scripts/setup_check.sh
{ /usr/bin/time -v bash scripts/run_inference.sh; } 2>&1 | tee "evidence/inference-${SLURM_JOB_ID}.log"

date
