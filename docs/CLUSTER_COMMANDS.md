# cluster commands

`REPLACE_*`: repository url, slurm account, gpu partition

## project copy

clones this repository and creates paths for downloaded artifacts, logs, and results.

```bash
git clone REPLACE_REPOSITORY_URL openfold-reproducible-inference
cd openfold-reproducible-inference
mkdir -p artifacts template_mmcif_dir evidence results/run-001
```

## openfold source

clones openfold and pins the source revision used by this run.

```bash
git clone https://github.com/aqlaboratory/openfold.git artifacts/openfold
cd artifacts/openfold
git checkout be2ec1841f16c966c65ae0e7599ebbadc725757d
git rev-parse HEAD
cd ../..
```

## environment

creates the conda environment and installs openfold from the pinned local clone.

```bash
conda env create -f environment.yml
conda activate openfold-repro
cd artifacts/openfold
pip install -e .
cd ../..
```

## checkpoint

downloads the official openfold parameter files. `find` prints the selected template-free pTM checkpoint path.

```bash
conda activate openfold-repro
cd artifacts/openfold
bash scripts/download_openfold_params.sh ../params
find ../params -name 'finetuning_no_templ_ptm_1.pt' -type f
cd ../..
```

## precomputed alignments

lists the alignment files used instead of database alignment generation.

```bash
find artifacts/openfold/examples/monomer/alignments/6KWC_1 -maxdepth 1 -type f -print
```

## local paths

creates `.env`, the local path file used by setup and inference scripts.

```bash
cp .env.example .env
```

```text
OPENFOLD_DIR=/full/path/openfold-reproducible-inference/artifacts/openfold
ARTIFACT_DIR=/full/path/openfold-reproducible-inference/artifacts
FASTA_DIR=/full/path/openfold-reproducible-inference/inputs
ALIGNMENT_DIR=/full/path/openfold-reproducible-inference/artifacts/openfold/examples/monomer/alignments
TEMPLATE_MMCIF_DIR=/full/path/openfold-reproducible-inference/template_mmcif_dir
CHECKPOINT_PATH=/full/path/openfold-reproducible-inference/artifacts/params/openfold_params/finetuning_no_templ_ptm_1.pt
OUTPUT_DIR=/full/path/openfold-reproducible-inference/results/run-001
CONDA_ENV=openfold-repro
OPENFOLD_COMMIT=be2ec1841f16c966c65ae0e7599ebbadc725757d
CONFIG_PRESET=model_3_ptm
```

## smoke test

checks the environment, gpu access, and required paths. `tee` saves the terminal output.

```bash
conda activate openfold-repro
bash scripts/setup_check.sh | tee evidence/smoke-test.log
```

## inference job

submits the slurm job. `jobs/openfold_inference.sbatch` contains the resource request and inference command.

```bash
sbatch jobs/openfold_inference.sbatch
```

## validation

checks the predicted pdb file and writes the values to `evidence/validation.log`.

```bash
python scripts/validate_output.py results/run-001/predictions/6KWC_1_model_3_ptm.pdb | tee evidence/validation.log
find results/run-001 -name '*.pdb'
```
