# ice workflow

## gpu allocation

```bash
salloc --account=coc --partition=ice-gpu --nodes=1 --ntasks=1 --cpus-per-task=4 --mem=32G --gpus=1 --time=02:00:00
```

## modules and conda

```bash
module purge
module load gcc/12.3.0
module load cuda/12.1.1
module load anaconda3
```

## project and source

```bash
git clone https://github.com/akshitk26/openfold-reproducible-inference.git
cd openfold-reproducible-inference
mkdir -p artifacts/params artifacts/template_mmcif artifacts/alignments_no_templates/6KWC_1 evidence results/run-001

git clone https://github.com/aqlaboratory/openfold.git artifacts/openfold
git -C artifacts/openfold checkout v2.2.0
git -C artifacts/openfold rev-parse HEAD
```

## environment

```bash
conda env create -f environment.yml
conda activate openfold-repro

mkdir -p /home/hice1/akumar3097/openfold-tmp
TMPDIR=/home/hice1/akumar3097/openfold-tmp \
  python -m pip install --no-build-isolation flash-attn
```

## openfold extension

```bash
cd artifacts/openfold

wget -N --no-check-certificate -P openfold/resources \
  https://git.scicore.unibas.ch/schwede/openstructure/-/raw/7102c63615b64735c4941278d92b554ec94415f8/modules/mol/alg/src/stereo_chemical_props.txt
mkdir -p tests/test_data/alphafold/common
ln -rs openfold/resources/stereo_chemical_props.txt tests/test_data/alphafold/common
gunzip -c tests/test_data/sample_feats.pickle.gz > tests/test_data/sample_feats.pickle
git clone https://github.com/NVIDIA/cutlass --branch v3.6.0 --depth 1
conda env config vars set CUTLASS_PATH="$PWD/cutlass"
conda env config vars set KMP_AFFINITY=none

export CC=/usr/local/pace-apps/spack/packages/linux-rhel9-x86_64_v3/gcc-11.3.1/gcc-12.3.0-ukkkutsxfl5kpnnaxflpkq2jtliwthfz/bin/gcc
export CXX=/usr/local/pace-apps/spack/packages/linux-rhel9-x86_64_v3/gcc-11.3.1/gcc-12.3.0-ukkkutsxfl5kpnnaxflpkq2jtliwthfz/bin/g++
export CUDAHOSTCXX="$CXX"
export CUTLASS_PATH="$PWD/cutlass"
export LIBRARY_PATH="$CONDA_PREFIX/lib:${LIBRARY_PATH:-}"
export LD_LIBRARY_PATH="$CONDA_PREFIX/lib/python3.10/site-packages/torch/lib:$CONDA_PREFIX/lib:${LD_LIBRARY_PATH:-}"

TMPDIR=/home/hice1/akumar3097/openfold-tmp MAX_JOBS=4 python setup.py install
cd ../..
```

## checkpoint and alignments

```bash
aws s3 cp --no-sign-request --region us-east-1 \
  s3://openfold/openfold_params/finetuning_no_templ_ptm_1.pt \
  artifacts/params/finetuning_no_templ_ptm_1.pt

cp artifacts/openfold/examples/monomer/alignments/6KWC_1/mgnify_hits.sto \
  artifacts/alignments_no_templates/6KWC_1/
cp artifacts/openfold/examples/monomer/alignments/6KWC_1/uniref90_hits.sto \
  artifacts/alignments_no_templates/6KWC_1/

for pdb in 2dfb 3akq 1te1 1h1a; do
  curl -fL --retry 3 -o "artifacts/template_mmcif/${pdb}.cif" \
    "https://files.rcsb.org/download/${pdb}.cif"
done
```

`model_3_ptm` disables templates. the alignment copy has no `hhsearch_output.hhr`, so the v2.2 data pipeline creates empty template features. the mmcif directory contains files required when the openfold runner initializes.

## local paths

```bash
cp .env.example .env
```

```text
OPENFOLD_DIR=/home/hice1/akumar3097/openfold-reproducible-inference/artifacts/openfold
ARTIFACT_DIR=/home/hice1/akumar3097/openfold-reproducible-inference/artifacts
FASTA_DIR=/home/hice1/akumar3097/openfold-reproducible-inference/inputs
ALIGNMENT_DIR=/home/hice1/akumar3097/openfold-reproducible-inference/artifacts/alignments_no_templates
TEMPLATE_MMCIF_DIR=/home/hice1/akumar3097/openfold-reproducible-inference/artifacts/template_mmcif
CHECKPOINT_PATH=/home/hice1/akumar3097/openfold-reproducible-inference/artifacts/params/finetuning_no_templ_ptm_1.pt
OUTPUT_DIR=/home/hice1/akumar3097/openfold-reproducible-inference/results/run-001
CONDA_ENV=openfold-repro
OPENFOLD_COMMIT=e938c184a291bf053af3b14c1e3e8bb29aee57e2
CONFIG_PRESET=model_3_ptm
```

## evidence and inference

```bash
conda activate openfold-repro
git -C artifacts/openfold rev-parse HEAD > evidence/openfold-commit.txt
conda list --explicit > evidence/conda-explicit.txt
python -m pip freeze > evidence/pip-freeze.txt
sha256sum inputs/6KWC_1.fasta artifacts/params/finetuning_no_templ_ptm_1.pt > evidence/checksums.txt
sha256sum artifacts/params/finetuning_no_templ_ptm_1.pt > evidence/checkpoint-sha256.txt
sha256sum artifacts/template_mmcif/*.cif > evidence/template-mmcif-sha256.txt
bash scripts/setup_check.sh | tee evidence/smoke-test.log
{ /usr/bin/time -v bash scripts/run_inference.sh; } 2>&1 | tee evidence/inference-interactive.log
```

## output validation

```bash
python scripts/validate_output.py \
  results/run-001/predictions/6KWC_1_model_3_ptm_unrelaxed.pdb \
  | tee evidence/validation.log

mkdir -p inputs/reference
curl -fL --retry 3 -o inputs/reference/6kwc.pdb \
  https://files.rcsb.org/download/6KWC.pdb
sha256sum inputs/reference/6kwc.pdb > evidence/reference-sha256.txt
python scripts/compare_ca_rmsd.py \
  results/run-001/predictions/6KWC_1_model_3_ptm_unrelaxed.pdb A \
  inputs/reference/6kwc.pdb A \
  | tee evidence/structure-comparison.log
```

## batch job

```bash
sbatch jobs/openfold_inference.sbatch
```
