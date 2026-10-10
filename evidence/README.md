# evidence

files from the actual cluster run.

| file | contents | purpose |
|---|---|---|
| `platform.txt` | host, gpu, modules, software versions | cluster environment |
| `smoke-test.log` | setup check output | openfold, cuda, and path check |
| `pip-freeze.txt` | Python package versions | Python environment |
| `conda-explicit.txt` | conda package versions | conda environment |
| `checksums.txt` | input and checkpoint sha-256 values | artifact identity |
| `slurm-<jobid>.out` | standard job output | scheduler and program output |
| `slurm-<jobid>.err` | standard job error output | scheduler and program errors |
| `inference-<jobid>.log` | inference terminal output | model load, input, output, runtime |
| `run-metadata.md` | job id, resources, start/end time, gpu memory | run summary |
| `validation.log` | pdb validation output | output file checks |
