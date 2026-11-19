#!/bin/bash
set -euo pipefail

# Locations
project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
build_dir="$project_dir/build-fluka"
macro_dir="$project_dir/Macro2"
exe="$build_dir/Hadr03"
geant4_bin="/Users/xiongzheng/software/build/geant4-v11.4.3-install/bin"
geant4_env="$geant4_bin/geant4.sh"
fluka_bin="/Users/xiongzheng/software/fluka4-5.2/bin"
fluka_env="$project_dir/../FlukaCern/FlukaInterface/env_FLUKA_G4_interface.sh"

# FLUKA environment
export PATH="$geant4_bin:$fluka_bin:$PATH"
source "$geant4_env"
source "$fluka_env"
export G4RUN_MANAGER_TYPE=Serial

# if (( $# == 0 )); then
#   echo "Usage: $0 <macro-file> [macro-file ...]" >&2
#   echo "Example: $0 Deuteron_12GeV.mac He4_10GeV.mac" >&2
#   exit 2
# fi

# macros_to_run=()
# for macro in "$@"; do
#   if [[ -f "$macro" ]]; then
#     macro_path="$(cd -- "$(dirname -- "$macro")" && pwd)/$(basename -- "$macro")"
#   elif [[ -f "$macro_dir/$macro" ]]; then
#     macro_path="$macro_dir/$macro"
#   else
#     echo "Macro not found: $macro" >&2
#     exit 2
#   fi
#   if [[ "$macro_path" != *.mac ]]; then
#     echo "Expected a .mac file: $macro_path" >&2
#     exit 2
#   fi
#   if [[ ! -x "$exe" ]]; then
#     echo "Executable not found or not executable: $exe" >&2
#     exit 2
#   fi
#   macros_to_run+=("$macro_path")
# done

# Run from build-fluka because the macros write ROOT files to ../Root2.
cd "$build_dir"
# for macro_path in "${macros_to_run[@]}"; do
#   "$exe" "$macro_path"
# done

# One macro per command can also be run by passing its filename above.
# $exe $macro_dir/Proton_10GeV.mac
# $exe $macro_dir/Proton_12GeV.mac
# $exe $macro_dir/Proton_16GeV.mac
# $exe $macro_dir/Proton_20GeV.mac
# $exe $macro_dir/Proton_25GeV.mac
# $exe $macro_dir/Proton_32GeV.mac
# $exe $macro_dir/Proton_49GeV.mac
# $exe $macro_dir/Proton_50GeV.mac
# $exe $macro_dir/Proton_63GeV.mac
# $exe $macro_dir/Proton_80GeV.mac
# $exe $macro_dir/Proton_100GeV.mac
# $exe $macro_dir/Proton_120GeV.mac
# $exe $macro_dir/Proton_160GeV.mac
# $exe $macro_dir/Proton_200GeV.mac
# $exe $macro_dir/Proton_250GeV.mac
# $exe $macro_dir/Proton_320GeV.mac
# $exe $macro_dir/Proton_490GeV.mac
# $exe $macro_dir/Proton_500GeV.mac
# $exe $macro_dir/Proton_630GeV.mac
# $exe $macro_dir/Proton_800GeV.mac
# $exe $macro_dir/Proton_1000GeV.mac
# $exe $macro_dir/Proton_1200GeV.mac
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

# $exe $macro_dir/Deuteron_10GeV.mac
# $exe $macro_dir/Deuteron_12GeV.mac
# $exe $macro_dir/Deuteron_16GeV.mac
# $exe $macro_dir/Deuteron_20GeV.mac
# $exe $macro_dir/Deuteron_25GeV.mac
# $exe $macro_dir/Deuteron_32GeV.mac
# $exe $macro_dir/Deuteron_49GeV.mac
# $exe $macro_dir/Deuteron_50GeV.mac
# $exe $macro_dir/Deuteron_63GeV.mac
# $exe $macro_dir/Deuteron_80GeV.mac
# $exe $macro_dir/Deuteron_100GeV.mac
# $exe $macro_dir/Deuteron_120GeV.mac
# $exe $macro_dir/Deuteron_160GeV.mac
# $exe $macro_dir/Deuteron_200GeV.mac
# $exe $macro_dir/Deuteron_250GeV.mac
# $exe $macro_dir/Deuteron_320GeV.mac
# $exe $macro_dir/Deuteron_490GeV.mac
# $exe $macro_dir/Deuteron_500GeV.mac
# $exe $macro_dir/Deuteron_630GeV.mac
# $exe $macro_dir/Deuteron_800GeV.mac
# $exe $macro_dir/Deuteron_1000GeV.mac
# $exe $macro_dir/Deuteron_1200GeV.mac
# $exe $macro_dir/Deuteron_1600GeV.mac
# $exe $macro_dir/Deuteron_2000GeV.mac
# $exe $macro_dir/Deuteron_2500GeV.mac
# $exe $macro_dir/Deuteron_3200GeV.mac
# $exe $macro_dir/Deuteron_4900GeV.mac
# $exe $macro_dir/Deuteron_5000GeV.mac
# $exe $macro_dir/Deuteron_6300GeV.mac
# $exe $macro_dir/Deuteron_8000GeV.mac
# $exe $macro_dir/Deuteron_10000GeV.mac
# $exe $macro_dir/Deuteron_12000GeV.mac
# $exe $macro_dir/Deuteron_16000GeV.mac
# $exe $macro_dir/Deuteron_20000GeV.mac
# $exe $macro_dir/Deuteron_24000GeV.mac
# $exe $macro_dir/Deuteron_25000GeV.mac
# $exe $macro_dir/Deuteron_25001GeV.mac
# $exe $macro_dir/Deuteron_26000GeV.mac
# $exe $macro_dir/Deuteron_32000GeV.mac
# $exe $macro_dir/Deuteron_49000GeV.mac
# $exe $macro_dir/Deuteron_50000GeV.mac
# $exe $macro_dir/Deuteron_63000GeV.mac
# $exe $macro_dir/Deuteron_80000GeV.mac
# $exe $macro_dir/Deuteron_100000GeV.mac

# $exe $macro_dir/He4_10GeV.mac
# $exe $macro_dir/He4_12GeV.mac
# $exe $macro_dir/He4_16GeV.mac
# $exe $macro_dir/He4_20GeV.mac
# $exe $macro_dir/He4_25GeV.mac
# $exe $macro_dir/He4_32GeV.mac
# $exe $macro_dir/He4_49GeV.mac
# $exe $macro_dir/He4_50GeV.mac
# $exe $macro_dir/He4_63GeV.mac
# $exe $macro_dir/He4_80GeV.mac
# $exe $macro_dir/He4_100GeV.mac
# $exe $macro_dir/He4_120GeV.mac
# $exe $macro_dir/He4_160GeV.mac
# $exe $macro_dir/He4_200GeV.mac
# $exe $macro_dir/He4_250GeV.mac
# $exe $macro_dir/He4_320GeV.mac
# $exe $macro_dir/He4_490GeV.mac
# $exe $macro_dir/He4_500GeV.mac
# $exe $macro_dir/He4_630GeV.mac
# $exe $macro_dir/He4_800GeV.mac
# $exe $macro_dir/He4_1000GeV.mac
# $exe $macro_dir/He4_1200GeV.mac
# $exe $macro_dir/He4_1600GeV.mac
# $exe $macro_dir/He4_2000GeV.mac
# $exe $macro_dir/He4_2500GeV.mac
# $exe $macro_dir/He4_3200GeV.mac
# $exe $macro_dir/He4_4900GeV.mac
# $exe $macro_dir/He4_5000GeV.mac
# $exe $macro_dir/He4_6300GeV.mac
# $exe $macro_dir/He4_8000GeV.mac
# $exe $macro_dir/He4_10000GeV.mac
# $exe $macro_dir/He4_12000GeV.mac
# $exe $macro_dir/He4_16000GeV.mac
# $exe $macro_dir/He4_20000GeV.mac
# $exe $macro_dir/He4_24000GeV.mac
# $exe $macro_dir/He4_25000GeV.mac
# $exe $macro_dir/He4_25001GeV.mac
# $exe $macro_dir/He4_26000GeV.mac
# $exe $macro_dir/He4_32000GeV.mac
# $exe $macro_dir/He4_49000GeV.mac
# $exe $macro_dir/He4_50000GeV.mac
# $exe $macro_dir/He4_63000GeV.mac
# $exe $macro_dir/He4_80000GeV.mac
# $exe $macro_dir/He4_100000GeV.mac

git add -A
git commit -m "Auto update $(date '+%F %T')" || true
git push
