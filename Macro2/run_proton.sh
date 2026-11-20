#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
build_dir="$project_dir/build-fluka"
macro_dir="$project_dir/Macro2"
exe="$build_dir/Hadr03"
geant4_bin="/Users/xiongzheng/software/build/geant4-v11.4.3-install/bin"
geant4_env="$geant4_bin/geant4.sh"
fluka_bin="/Users/xiongzheng/software/fluka4-5.2/bin"
fluka_env="/Users/xiongzheng/software/geant4/examples/extended/hadronic/FlukaCern/FlukaInterface/env_FLUKA_G4_interface.sh"

macro="${1:-Deuteron_20GeV.mac}"
if [[ -f "$macro" ]]; then
  macro_path="$(cd -- "$(dirname -- "$macro")" && pwd)/$(basename -- "$macro")"
elif [[ -f "$macro_dir/$macro" ]]; then
  macro_path="$macro_dir/$macro"
else
  echo "Macro not found: $macro" >&2
  echo "Usage: $0 [macro-file]" >&2
  exit 2
fi

if [[ ! -x "$exe" ]]; then
  echo "Executable not found or not executable: $exe" >&2
  echo "Build it first with: $project_dir/compile.sh" >&2
  exit 2
fi
if [[ ! -f "$geant4_env" || ! -f "$fluka_env" ]]; then
  echo "Geant4 or FLUKA environment script is missing." >&2
  exit 2
fi

export PATH="$geant4_bin:$fluka_bin:$PATH"
source "$geant4_env"
source "$fluka_env"
export G4RUN_MANAGER_TYPE=Serial

# The macros write ROOT files relative to build-fluka.
cd "$build_dir"
exec "$exe" "$macro_path"
