# cluster work

## platform

- [ ] gpu partition, account, wall-time limit, gpu type
- [ ] `evidence/platform.txt`: host, gpu, modules, python, conda, git
- [ ] slurm request: 1 gpu, 4 cpus, 32 gb ram, 2 hours

## source and inputs

- [ ] openfold clone at `be2ec1841f16c966c65ae0e7599ebbadc725757d`
- [ ] `inputs/6KWC_1.fasta` sha-256
- [ ] `alignments/6KWC_1/` file list and directory sha-256
- [ ] template-free empty mmcif directory

## environment and checkpoint

- [ ] `environment.yml` environment
- [ ] editable openfold install
- [ ] `evidence/pip-freeze.txt`
- [ ] `evidence/conda-explicit.txt`
- [ ] checkpoint url, file size, sha-256, license
- [ ] `.env` paths

## execution

- [ ] `evidence/smoke-test.log`
- [ ] slurm job id
- [ ] `slurm-<jobid>.out`, `slurm-<jobid>.err`, `inference-<jobid>.log`
- [ ] start time, end time, elapsed time, gpu name, peak gpu memory
- [ ] predicted pdb, timings, confidence files

## validation

- [ ] pdb file size, atom count, residue count
- [ ] model confidence or structure comparison
- [ ] `evidence/validation.log`
- [ ] `docs/VALIDATION.md` observed values
- [ ] `docs/TROUBLESHOOTING.md` error and fix records
