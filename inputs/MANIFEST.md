# artifact manifest

artifact source, version, checksum, and local location.

| artifact | value | source | version / checksum | local path |
|---|---|---|---|---|
| openfold source | `aqlaboratory/openfold` | https://github.com/aqlaboratory/openfold | commit: `be2ec1841f16c966c65ae0e7599ebbadc725757d` | `$OPENFOLD_DIR` |
| query fasta | `6KWC_1` | openfold `examples/monomer/fasta_dir/6kwc.fasta` | git blob: `4fbcc4f33528dc49d7c13f4f7734123ac5637598`; sha-256: `pending` | `inputs/6KWC_1.fasta` |
| precomputed alignments | `6KWC_1` | openfold `examples/monomer/alignments` | source commit + directory sha-256: `pending` | `$ALIGNMENT_DIR/6KWC_1` |
| checkpoint | `finetuning_no_templ_ptm_1.pt` | `s3://openfold/openfold_params/` | file size + sha-256: `pending` | `$CHECKPOINT_PATH` |
| template mmcif directory | empty | local directory | n/a | `$TEMPLATE_MMCIF_DIR` |
| reference structure | `6KWC` chain `pending` | RCSB PDB | url + sha-256: `pending` | `inputs/reference/` |

## checksums

`sha256sum` and `shasum -a 256` create file checksums. `evidence/checksums.txt` stores the output.

```bash
sha256sum FILE
shasum -a 256 FILE
```
