#!/bin/bash
set -euo pipefail

# Locations
project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
build_dir="$project_dir/build-fluka"
macro_dir="$project_dir/Macro2"
exe="$build_dir/Hadr03"
geant4_bin="/Users/xiongzheng/software/build/geant4-v11.4.0-install/bin"
fluka_bin="/Users/xiongzheng/software/fluka4-5.2/bin"
fluka_env="$project_dir/../FlukaCern/FlukaInterface/env_FLUKA_G4_interface.sh"

# FLUKA environment
export PATH="$geant4_bin:$fluka_bin:$PATH"
source "$fluka_env"
export G4RUN_MANAGER_TYPE=Serial

# Run from build-fluka because the macros write ROOT files to ../Root2.
cd "$build_dir"

# One macro per command. Copy this line to add more runs.
# $exe $macro_dir/Deuteron_10GeV.mac
# "$exe" "$macro_dir/He4_10GeV.mac"
$exe $macro_dir/Proton_10GeV.mac
$exe $macro_dir/Proton_12GeV.mac
$exe $macro_dir/Proton_16GeV.mac
$exe $macro_dir/Proton_20GeV.mac
$exe $macro_dir/Proton_25GeV.mac
$exe $macro_dir/Proton_32GeV.mac
$exe $macro_dir/Proton_49GeV.mac
$exe $macro_dir/Proton_50GeV.mac
$exe $macro_dir/Proton_63GeV.mac
$exe $macro_dir/Proton_80GeV.mac
$exe $macro_dir/Proton_100GeV.mac
$exe $macro_dir/Proton_120GeV.mac
$exe $macro_dir/Proton_160GeV.mac
$exe $macro_dir/Proton_200GeV.mac
$exe $macro_dir/Proton_250GeV.mac
$exe $macro_dir/Proton_320GeV.mac
$exe $macro_dir/Proton_490GeV.mac
$exe $macro_dir/Proton_500GeV.mac
$exe $macro_dir/Proton_630GeV.mac
$exe $macro_dir/Proton_800GeV.mac
$exe $macro_dir/Proton_1000GeV.mac
$exe $macro_dir/Proton_1200GeV.mac
$exe $macro_dir/Proton_1600GeV.mac
$exe $macro_dir/Proton_2000GeV.mac
$exe $macro_dir/Proton_2500GeV.mac
$exe $macro_dir/Proton_3200GeV.mac
$exe $macro_dir/Proton_4900GeV.mac
$exe $macro_dir/Proton_5000GeV.mac
$exe $macro_dir/Proton_6300GeV.mac
$exe $macro_dir/Proton_8000GeV.mac
$exe $macro_dir/Proton_10000GeV.mac
$exe $macro_dir/Proton_12000GeV.mac
$exe $macro_dir/Proton_16000GeV.mac
$exe $macro_dir/Proton_20000GeV.mac
$exe $macro_dir/Proton_24000GeV.mac
$exe $macro_dir/Proton_25000GeV.mac
$exe $macro_dir/Proton_25001GeV.mac
$exe $macro_dir/Proton_26000GeV.mac
$exe $macro_dir/Proton_32000GeV.mac
$exe $macro_dir/Proton_49000GeV.mac
$exe $macro_dir/Proton_50000GeV.mac
$exe $macro_dir/Proton_63000GeV.mac
$exe $macro_dir/Proton_80000GeV.mac
$exe $macro_dir/Proton_100000GeV.mac
