# openfold monomer inference

## purpose

i reproduce one openfold protein-structure inference run. The output is a predicted pdb structure and model confidence data for `6KWC_1`.

## method

| item | value |
|---|---|
| target | `6KWC_1` |
| input | `inputs/6KWC_1.fasta` |
| alignments | openfold example alignments |
| configuration | `model_3_ptm` |
| checkpoint | `finetuning_no_templ_ptm_1.pt` |
| template mode | template-free |
| seed | `0` |
| relaxation | off |
| compute | 1 gpu, 4 cpus, 32 gb ram, 2 hours |

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

## files

| path | contents |
|---|---|
| `environment.yml` | conda packages and versions |
| `.env.example` | local paths for source, checkpoint, inputs, and output |
| `inputs/` | fasta, artifact sources, checksums |
| `scripts/setup_check.sh` | cuda and path check |
| `scripts/run_inference.sh` | openfold inference command |
| `scripts/validate_output.py` | pdb file, atom, residue, and confidence check |
| `jobs/openfold_inference.sbatch` | slurm resource request and job command |
| `docs/CLUSTER_COMMANDS.md` | cluster command blocks and command purpose |
| `docs/PROVENANCE.md` | software, model, input, and reference values |
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
