#!/bin/bash
set -e

rm -Rf data/TTbar_14TeV_TuneCUETP8M1_cfi

mkdir -p data/TTbar_14TeV_TuneCUETP8M1_cfi/root
cd data/TTbar_14TeV_TuneCUETP8M1_cfi/root

#Only CMS-internal use is permitted by CMS rules
wget --no-check-certificate -nc https://jpata.web.cern.ch/jpata/particleflow/TTbar_14TeV_TuneCUETP8M1_cfi/pfntuple_1.root
wget --no-check-certificate -nc https://jpata.web.cern.ch/jpata/particleflow/TTbar_14TeV_TuneCUETP8M1_cfi/pfntuple_2.root
wget --no-check-certificate -nc https://jpata.web.cern.ch/jpata/particleflow/TTbar_14TeV_TuneCUETP8M1_cfi/pfntuple_3.root

cd ../../..

#Create the ntuples
rm -Rf data/TTbar_14TeV_TuneCUETP8M1_cfi/raw
mkdir -p data/TTbar_14TeV_TuneCUETP8M1_cfi/raw
for file in `\ls -1 data/TTbar_14TeV_TuneCUETP8M1_cfi/root/*.root`; do
	python3 mlpf/data/postprocessing2.py \
	  --input $file \
	  --outpath data/TTbar_14TeV_TuneCUETP8M1_cfi/raw \
	  --save-normalized-table --events-per-file 5
done

#Set aside some data for validation
mkdir -p data/TTbar_14TeV_TuneCUETP8M1_cfi/val
mv data/TTbar_14TeV_TuneCUETP8M1_cfi/raw/pfntuple_3_0.pkl data/TTbar_14TeV_TuneCUETP8M1_cfi/val/

mkdir -p experiments
rm -Rf experiments/test-*

#Run a simple training on a few events
rm -Rf data/TTbar_14TeV_TuneCUETP8M1_cfi/tfr
python3 mlpf/launcher.py --model-spec parameters/test-cms.yaml --action data

#Run a simple training on a few events
python3 mlpf/launcher.py --model-spec parameters/test-cms.yaml --action train

#Generate the pred.npz file of predictions
python3 mlpf/launcher.py --model-spec parameters/test-cms.yaml --action eval --weights ./experiments/test-*/weights.02-*.hdf5
