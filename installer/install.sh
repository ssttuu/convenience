#!/usr/bin/env bash

CONVENIENCE_SCRIPTS_PATH="${CONVENIENCE_ROOT:-"${HOME}/.convenience"}/${VERSION}"

mkdir -p "${CONVENIENCE_SCRIPTS_PATH}"
curl -fLsS --output "${CONVENIENCE_SCRIPTS_PATH}/scripts.zip" "https://github.com/ssttuu/convenience/releases/download/${VERSION}/scripts.zip"
(>&2 unzip -oq ${CONVENIENCE_SCRIPTS_PATH}/scripts.zip -d ${CONVENIENCE_SCRIPTS_PATH})
(>&2 printf "\e[32mInstalled Convenience scripts at ${CONVENIENCE_SCRIPTS_PATH}\e[39m\n")
