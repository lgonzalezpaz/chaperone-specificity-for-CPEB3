#!/usr/bin/env bash
# PRISM-J: full pipeline. Requires hmmer, mafft and iqtree2 on PATH.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p data results figures tables ext

echo "== external parameter tables =="
[ -d ext/calvados ] || git clone --depth 1 https://github.com/KULL-Centre/CALVADOS.git ext/calvados
cp ext/calvados/examples/two_IDR/input/residues_CALVADOS2.csv data/
cp ext/calvados/examples/two_IDR_MDP/input/residues_CALVADOS3.csv data/

echo "== Pfam PF00226 profile HMM =="
mkdir -p data/hmm
curl -sS -o data/hmm/PF00226.hmm.gz \
  "https://www.ebi.ac.uk/interpro/wwwapi//entry/pfam/PF00226/?annotation=hmm"
gunzip -f data/hmm/PF00226.hmm.gz

echo "== Human Protein Atlas subcellular location =="
mkdir -p data/hpa
curl -sS -o data/hpa/subcellular_location.tsv.zip \
  "https://www.proteinatlas.org/download/tsv/subcellular_location.tsv.zip"
unzip -o -q data/hpa/subcellular_location.tsv.zip -d data/hpa

echo "== external validation set (Rozales et al. 2022 Source Data) =="
mkdir -p ext/rozales
curl -sS --max-time 900 -o ext/rozales_supp.zip \
  "https://www.ebi.ac.uk/europepmc/webservices/rest/PMC8792056/supplementaryFiles"
unzip -o -q ext/rozales_supp.zip -d ext/rozales

echo "== cryo-EM models =="
mkdir -p data/structures
for id in 6VPS 8YAC 8SPA 9PX8 9PZD 9Q37 9Q7J 9Y1V 9Y9X 9YWA; do
  curl -sS -o "data/structures/${id}.cif" "https://files.rcsb.org/download/${id}.cif"
done

echo "== engine verification =="
python3 scripts/test_engine_vs_openmm.py

echo "== layers 1-3 =="
for s in 01_fetch_sequences 02_phylogenomics 03_client_grammar \
         04_validation_dataset 05_fetch_panel 06_grammar_model \
         07_grammar_diagnostics 08_expression_context; do
  echo "-- $s"; python3 "scripts/${s}.py"
done

echo "== layer 4: association thermodynamics (2 workers) =="
python3 scripts/09_cg_binding.py --worker 0 --nworkers 2 &
python3 scripts/09_cg_binding.py --worker 1 --nworkers 2 &
wait

echo "== layer 4b: grammar titration =="
python3 scripts/10_cg_grammar_ladder.py --worker 0 --nworkers 2 &
python3 scripts/10_cg_grammar_ladder.py --worker 1 --nworkers 2 &
wait

echo "== layer 4c: interface maps and alanine scan =="
python3 scripts/11_hotspots_and_scan.py --stage ensemble --worker 0 --nworkers 2 &
python3 scripts/11_hotspots_and_scan.py --stage ensemble --worker 1 --nworkers 2 &
wait
python3 scripts/11_hotspots_and_scan.py --stage scan --chap DNAJB2 --client hCPEB3_core

echo "== integration, figures, tables, verification =="
python3 scripts/12_integrate.py
python3 scripts/13_figures.py
python3 scripts/14_figures_cg.py
python3 scripts/15_verify.py
echo "done"
