# openfold monomer inference

## purpose

i reproduce one openfold monomer inference for `6KWC_1` on ICE.

## completed run

| item | value |
|---|---|
| target | `6KWC_1` |
| input | `inputs/6KWC_1.fasta` |
| source | openfold `v2.2.0`, `e938c184a291bf053af3b14c1e3e8bb29aee57e2` |
| alignments | openfold example MSA files without HHsearch template hits |
| configuration | `model_3_ptm` |
| checkpoint | `finetuning_no_templ_ptm_1.pt` |
| template mode | template-free |
| seed | `0` |
| relaxation | off |
| batch job | `6190401` |
| gpu | RTX 6000 |
| inference time | 26.21 seconds |
| batch elapsed time | 78 seconds |
| peak gpu memory | 6433 MiB |
| output | `results/run-001/predictions/6KWC_1_model_3_ptm_unrelaxed.pdb` |
| predicted residues | 191 |
| mean predicted confidence | 96.66 |

## flow

```text
fasta + precomputed alignments + checkpoint
                    ↓
             openfold inference
                    ↓
     predicted pdb + confidence + timings + logs
                    ↓
        file checks + confidence or structure comparison
```

## repository files

| path | contents |
|---|---|
| `environment.yml` | conda packages and versions |
| `.env.example` | local paths for source, checkpoint, inputs, and output |
| `inputs/MANIFEST.md` | source urls, versions, and artifact paths |
| `inputs/` | fasta, artifact sources, checksums |
| `scripts/setup_check.sh` | cuda and path check |
| `scripts/run_inference.sh` | openfold inference command |
| `scripts/validate_output.py` | pdb file, atom, residue, and confidence check |
| `scripts/compare_ca_rmsd.py` | ca rmsd against the `6kwc` experimental structure |
| `jobs/openfold_inference.sbatch` | slurm resource request and job command |
| `docs/CLUSTER_COMMANDS.md` | ICE environment, artifacts, inference, and validation |
| `docs/PROVENANCE.md` | software, model, input, and reference values |
| `docs/EXECUTION_RECORD.md` | completed interactive and batch runs |
| `docs/VALIDATION.md` | smoke test and result values |
| `evidence/` | logs, package lists, checksums, and run metadata |
| `results/` | predicted structure and confidence output |

## outputs

| output | meaning |
|---|---|
| `predictions/*.pdb` | predicted atomic coordinates |
| `timings.json` | inference and relaxation time |
| confidence output | plddt and ptm values when saved by the selected run |
| slurm logs | job command, software messages, errors, and runtime |

## reproduction

`docs/CLUSTER_COMMANDS.md` contains the ICE command sequence. `jobs/openfold_inference.sbatch` contains the batch request. `.env.example` contains the path variables.
