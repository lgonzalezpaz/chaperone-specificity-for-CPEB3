# PRISM-J

**Precision structural, phylogenomic and interactomic mapping of J-domain proteins.**

Reproducibility package for the manuscript

> *Client-grammar divergence uncouples sequence orthology from functional
> orthology in chaperone control of the human memory amyloid CPEB3.*

PRISM-J asks which human J-domain protein (JDP) could perform, for human CPEB3,
the function that Funes (CG10375) performs for *Drosophila* Orb2: promoting the
conversion of oligomers into translation-competent functional amyloid. It
answers the question in four layers, each of which can be run and audited on its
own, and it reports the layers separately rather than collapsing them into a
single score.

| Layer | Question | Script |
|---|---|---|
| 1 | Which human JDP conserves the Funes Hsp70-coupling module? | `02_phylogenomics.py` |
| 2 | What chemistry does each client present, and does composition-level complementarity predict engagement? | `03_client_grammar.py`, `06_grammar_model.py`, `07_grammar_diagnostics.py` |
| 3 | Which JDPs are in the right cells and compartments? | `08_expression_context.py` |
| 4 | What are the association thermodynamics? | `09_cg_binding.py`, `10_cg_grammar_ladder.py`, `11_hotspots_and_scan.py` |

Everything runs on two CPU cores in a few hours. No GPU, no licensed software,
no private data.

## Quick start

```bash
git clone https://github.com/<OWNER>/prism-j.git
cd prism-j
conda env create -f environment.yml      # or: pip install -r requirements.txt
conda activate prism-j
bash run_all.sh
```

`run_all.sh` downloads every input from public endpoints, runs the full
pipeline, and writes `results/`, `figures/` and `tables/`.

## External tools

`hmmer` (>= 3.3), `mafft` (>= 7.4) and `iqtree2` (>= 2.0) must be on `PATH`.
On Debian or Ubuntu:

```bash
sudo apt-get install -y hmmer mafft iqtree
```

## Input data, all public

| Source | What is taken | Endpoint |
|---|---|---|
| UniProtKB | Funes (Q9VCH9), Orb2 (Q9VSR3), human CPEB1–4, the reviewed human DNAJ complement, the Rozales chaperone panel, huntingtin (P42858), FUS (P35637) | `rest.uniprot.org` |
| RCSB PDB | 6VPS, 8YAC, 8SPA, 9PX8, 9PZD, 9Q37, 9Q7J, 9Y1V, 9Y9X, 9YWA | `files.rcsb.org` |
| InterPro / Pfam | PF00226 DnaJ-domain profile HMM | `ebi.ac.uk/interpro` |
| GTEx portal v8 | median gene-level TPM for 54 tissues | `gtexportal.org/api/v2` |
| Human Protein Atlas | subcellular location table | `proteinatlas.org/download` |
| Europe PMC | Source Data of Rozales *et al.* 2022 (PMC8792056) | `ebi.ac.uk/europepmc` |
| KULL-Centre/CALVADOS | CALVADOS 2 and 3 residue parameters (GPL-3.0) | GitHub |

No input file is redistributed in this repository; every one is fetched at run
time from the endpoint above, so the provenance of each number is explicit.

## Pipeline

```
01_fetch_sequences.py      sequences from UniProtKB
02_phylogenomics.py        Layer 1: J-domain HMM, MSA, ML tree, Funes-likeness
03_client_grammar.py       Layer 2a: core chemistry and SASA from cryo-EM models
04_validation_dataset.py   external screen scores (Rozales et al. 2022)
05_fetch_panel.py          chaperone panel and client aggregation-prone regions
06_grammar_model.py        Layer 2b: composition model, cross-validated
07_grammar_diagnostics.py  nested-model controls and permutation tests
08_expression_context.py   Layer 3: GTEx and Human Protein Atlas
09_cg_binding.py           Layer 4: umbrella sampling, WHAM, dG
10_cg_grammar_ladder.py    Layer 4b: grammar titration on an invariant scaffold
11_hotspots_and_scan.py    Layer 4c: interface maps and in-silico alanine scan
12_integrate.py            integration, Pareto analysis, dissociation statistics
13_figures.py              figures 1-4 and tables
14_figures_cg.py           figures 5-7
15_verify.py               checks every numeric claim in the manuscript
```

Library modules:

```
calvados_cg.py             reference CALVADOS 2 implementation on OpenMM
cg_engine.py               just-in-time Langevin engine (same potential)
cg_setup.py                system construction, WHAM, standard-state dG
test_engine_vs_openmm.py   verifies the engine against the OpenMM reference
```

## Verifying the physics before trusting it

```bash
python3 scripts/test_engine_vs_openmm.py
```

This builds the same two-chain system in the reference OpenMM implementation
and in the just-in-time engine and compares potential energies and forces. The
test asserts a relative energy difference below 1e-5 and a relative force
difference below 1e-4, and it fails loudly otherwise. Run it before any
production simulation.

## What each layer outputs

`results/` holds one tab-separated file per analysis plus the JSON files that
carry the headline statistics quoted in the manuscript
(`diagnostics.json`, `integration.json`, `grammar_model.json`). Simulation
trajectories are not stored; each system's potential of mean force, window
histograms and contact maps are kept in `results/cg/<system>.npz`, which is
what the figures read.

## Determinism

Every stochastic step takes an explicit seed derived from the system name, so
re-running reproduces the published numbers bit for bit on the same platform.
Across platforms, free energies agree to within the reported bootstrap
uncertainty.

## Compute budget

| Stage | Wall time, 2 cores |
|---|---|
| Layers 1-3 and all downloads | about 25 min |
| Layer 4 main set, 14 systems | about 2 h |
| Layer 4 grammar ladder, 6 systems | about 45 min |
| Layer 4 interface maps and alanine scan | about 45 min |
| Figures and tables | about 2 min |

## Citation

If you use this code, please cite the manuscript and the upstream resources it
depends on, in particular the CALVADOS 2 model, the Pfam PF00226 profile, the
deposited cryo-EM models listed above, and the Rozales *et al.* 2022 screen
whose Source Data provides the external validation set.

## Licence

Code in this repository is released under the MIT licence (`LICENSE`). The
CALVADOS residue-parameter tables fetched at run time are distributed by their
authors under GPL-3.0 and are not redistributed here.
