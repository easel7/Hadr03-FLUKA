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
"$exe" "$macro_dir/Proton_10GeV.mac"
