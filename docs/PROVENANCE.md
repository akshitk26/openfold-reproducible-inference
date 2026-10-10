# provenance

run-specific software, model, input, and reference values.

## software

| item | value | source |
|---|---|---|
| openfold repository | https://github.com/aqlaboratory/openfold | git remote |
| openfold commit | `be2ec1841f16c966c65ae0e7599ebbadc725757d` | `git rev-parse HEAD` |
| Python | `pending` | `python --version` |
| PyTorch | `pending` | `python -c "import torch; print(torch.__version__)"` |
| CUDA runtime | `pending` | `python -c "import torch; print(torch.version.cuda)"` |
| NVIDIA driver | `pending` | `nvidia-smi` |
| gpu model | `pending` | `nvidia-smi` |
| cluster | `pending` | login node name |

## model

| item | value | source |
|---|---|---|
| configuration preset | `model_3_ptm` | `scripts/run_inference.sh` |
| checkpoint file | `finetuning_no_templ_ptm_1.pt` | openfold parameters |
| download url | `pending` | download command |
| sha-256 | `pending` | `evidence/checksums.txt` |
| license | `pending` | checkpoint source |

## input and reference

| item | value | source |
|---|---|---|
| query id | `6KWC_1` | fasta header |
| fasta sha-256 | `pending` | `evidence/checksums.txt` |
| alignment source | openfold `examples/monomer/alignments/6KWC_1` | pinned source clone |
| alignment directory checksum | `pending` | `evidence/checksums.txt` |
| experimental reference | `pending` | RCSB PDB |
| reference download url | `pending` | RCSB PDB |

## command record

| item | value |
|---|---|
| environment command | `pending` |
| checkpoint command | `pending` |
| slurm submission command | `pending` |
| inference command | `pending` |
