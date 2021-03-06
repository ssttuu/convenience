#!/usr/bin/env bash

set -euo pipefail

CONVENIENCE_VERSION="${1:-${VERSION}}"
CONVENIENCE_ROOT="${CONVENIENCE_ROOT:-"${HOME}/.convenience"}"
CONVENIENCE_SCRIPTS_PATH="${CONVENIENCE_ROOT}/${CONVENIENCE_VERSION}"

if [[ ! -f "${CONVENIENCE_SCRIPTS_PATH}/source" ]]; then
    curl -fLsS "https://github.com/ssttuu/convenience/releases/download/${CONVENIENCE_VERSION}/install.sh" | bash
fi

source "${CONVENIENCE_SCRIPTS_PATH}/source"
