#!/usr/bin/env python3
from __future__ import print_function

import os

outdir = "/local/joosep/mlpf/cms/v3_2"

samples = [
#    ("TTbar_14TeV_TuneCUETP8M1_cfi",                           100000, 100010, "genjob_pu55to75.sh", outdir + "/pu55to75"),
    ("TTbar_14TeV_TuneCUETP8M1_cfi",                           701000, 705000, "genjob_nopu.sh", outdir + "/nopu"),
#    ("TTbar_14TeV_TuneCUETP8M1_cfi",                           100000, 120010, "genjob_pu55to75.sh", outdir + "/pu55to75"),
#    ("ZTT_All_hadronic_14TeV_TuneCUETP8M1_cfi",                200000, 220010, "genjob_pu55to75.sh", outdir + "/pu55to75"),
#    ("QCDForPF_14TeV_TuneCUETP8M1_cfi",                        300000, 320010, "genjob_pu55to75.sh", outdir + "/pu55to75"),
#    ("QCD_Pt_3000_7000_14TeV_TuneCUETP8M1_cfi",                400000, 420010, "genjob_pu55to75.sh", outdir + "/pu55to75"),
#    ("SMS-T1tttt_mGl-1500_mLSP-100_TuneCP5_14TeV_pythia8_cfi", 500000, 520010, "genjob_pu55to75.sh", outdir + "/pu55to75"),
#    ("ZpTT_1500_14TeV_TuneCP5_cfi",                            600000, 620010, "genjob_pu55to75.sh", outdir + "/pu55to75"),
#    ("VBF_TuneCP5_14TeV_pythia8_cfi",                         1700000,1720010, "genjob_pu55to75.sh", outdir + "/pu55to75"),
#
#    ("TTbar_14TeV_TuneCUETP8M1_cfi",                           700000, 710000, "genjob_nopu.sh", outdir + "/nopu"),
#    ("MultiParticlePFGun50_cfi",                               800000, 850000, "genjob_nopu.sh", outdir + "/nopu"),
#    ("SingleElectronFlatPt1To1000_pythia8_cfi",                900000, 910000, "genjob_nopu.sh", outdir + "/nopu"),
#    ("SingleGammaFlatPt1To1000_pythia8_cfi",                  1000000,1010000, "genjob_nopu.sh", outdir + "/nopu"),
#    ("SingleMuFlatPt1To1000_pythia8_cfi",                     1100000,1110000, "genjob_nopu.sh", outdir + "/nopu"),
#    ("SingleNeutronFlatPt0p7To1000_cfi",                      1200000,1210000, "genjob_nopu.sh", outdir + "/nopu"),
#    ("SinglePi0Pt1To1000_pythia8_cfi",                        1300000,1310000, "genjob_nopu.sh", outdir + "/nopu"),
#    ("SinglePiMinusFlatPt0p7To1000_cfi",                      1400000,1410000, "genjob_nopu.sh", outdir + "/nopu"),
#    ("SingleProtonMinusFlatPt0p7To1000_cfi",                  1500000,1510000, "genjob_nopu.sh", outdir + "/nopu"),
#    ("SingleTauFlatPt1To1000_cfi",                            1600000,1610000, "genjob_nopu.sh", outdir + "/nopu"),
]

if __name__ == "__main__":

    for samp, seed0, seed1, script, this_outdir in samples:
        os.makedirs(this_outdir + "/" + samp + "/raw", exist_ok=True)
        os.makedirs(this_outdir + "/" + samp + "/root", exist_ok=True)

        for seed in range(seed0, seed1):
            p = this_outdir + "/" + samp + "/raw/pfntuple_{}.pkl.bz2".format(seed)
            #if not os.path.isfile(p):
            if True:
                print(f"sbatch scripts/tallinn/cmssw-el8.sh mlpf/data_cms/{script} {samp} {seed}")
