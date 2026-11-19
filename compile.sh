#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUKA_INTERFACE_DIR="/Users/xiongzheng/software/geant4/examples/extended/hadronic/FlukaCern/FlukaInterface"
GEANT4_DIR="/Users/xiongzheng/software/build/geant4-v11.4.3-install/lib/cmake/Geant4"
BUILD_DIR="${BUILD_DIR:-/private/tmp/Hadr03-FLUKA-build}"

# Load the Geant4, FLUKA, compiler and library settings already declared by the user.
source "${HOME}/.bashrc"

if [[ -z "${FLUKA_PATH:-}" || ! -d "${FLUKA_PATH}/lib" ]]; then
  echo "FLUKA_PATH is unset or invalid: ${FLUKA_PATH:-<unset>}" >&2
  exit 1
fi
if [[ -z "${FLUKAInterface_INCLUDE_DIR:-}" || -z "${FLUKAInterface_LIBRARIES:-}" ]]; then
  echo "FLUKA interface environment was not loaded by ${HOME}/.bashrc" >&2
  exit 1
fi
if [[ ! -d "${GEANT4_DIR}" ]]; then
  echo "Geant4 package directory not found: ${GEANT4_DIR}" >&2
  exit 1
fi

cmake -S "${PROJECT_DIR}" -B "${BUILD_DIR}" \
  -DGeant4_DIR="${GEANT4_DIR}" \
  -DG4_USE_FLUKA=ON \
  -DWITH_GEANT4_UIVIS=ON
cmake --build "${BUILD_DIR}" --parallel "${JOBS:-10}"

echo "Build succeeded: ${BUILD_DIR}/Hadr03"
