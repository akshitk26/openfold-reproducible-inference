# validation

## smoke test

the smoke test checks the openfold import, cuda access, and required paths before inference.

| item | expected | observed | evidence |
|---|---|---|---|
| openfold import | module path | `pending` | `evidence/smoke-test.log` |
| cuda | available gpu | `pending` | `evidence/smoke-test.log` |
| input paths | fasta, alignments, checkpoint, mmcif directory | `pending` | `evidence/smoke-test.log` |

## pdb output

the pdb check confirms a non-empty coordinate file with atom records and predicted residues.

| item | expected | observed | evidence |
|---|---|---|---|
| pdb file | non-empty `.pdb` file | `pending` | `evidence/validation.log` |
| atom records | one or more | `pending` | `evidence/validation.log` |
| residue count | close to fasta length | `pending` | `evidence/validation.log` |

## scientific check

mean plddt measures per-residue confidence. tm-score or rmsd compares the predicted structure with an experimental reference.

| item | value |
|---|---|
| method | tm-score, rmsd, or mean plddt |
| command or tool | `pending` |
| observed value | `pending` |
| reference structure | `pending` |
| result note | `pending` |
