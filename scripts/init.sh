#!/usr/bin/env bash

set -euo pipefail

# TODO: make configurable
CONVENIENCE_VERSION="${CONVENIENCE_VERSION:-${VERSION}}"

# Local directory
local_convenience_dir=".convenience"
if [[ ! -d "${local_convenience_dir}" ]]; then
    mkdir -p "${local_convenience_dir}"
fi

# Convenience source file
local_convenience_source_file="${local_convenience_dir}/source"
if [[ ! -f "${local_convenience_source_file}" ]]; then
    curl -fLsS --output "${local_convenience_source_file}" "https://github.com/ssttuu/convenience/releases/download/${CONVENIENCE_VERSION}/source.sh"
else
    (>&2 printf "${local_convenience_source_file} already exists\n")
fi

# Version file
if [[ ! -f "./VERSION" ]]; then
    printf "v0.1.0\n" > ./VERSION
fi

# Run script
local_run_script_path="./run"
if [[ ! -f "${local_run_script_path}" ]]; then
    curl -fLsS --output "${local_run_script_path}" "https://github.com/ssttuu/convenience/releases/download/${CONVENIENCE_VERSION}/run.sh"
    chmod +x "${local_run_script_path}"
    (>&2 printf "Initialized Convenience scripts.\n")
else
    (>&2 printf "Initialized.  Add the following at the top of your run script\n\n")
    (>&2 printf "\tsource ${local_convenience_source_file}\n\n")
fi
