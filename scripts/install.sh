#!/usr/bin/env bash

CONVENIENCE_VERSION="${CONVENIENCE_VERSION:-${VERSION}}"
CONVENIENCE_ROOT="${CONVENIENCE_ROOT:-"${HOME}/.convenience"}"
CONVENIENCE_SCRIPTS_PATH="${CONVENIENCE_ROOT}/${CONVENIENCE_VERSION}"

mkdir -p "${CONVENIENCE_SCRIPTS_PATH}"
curl -fLsS --output "${CONVENIENCE_SCRIPTS_PATH}/convenience.zip" "https://github.com/ssttuu/convenience/releases/download/${CONVENIENCE_VERSION}/convenience.zip"
(>&2 unzip -oq ${CONVENIENCE_SCRIPTS_PATH}/scripts.zip -d ${CONVENIENCE_SCRIPTS_PATH})
(>&2 printf "\e[32mInstalled Convenience convenience at ${CONVENIENCE_SCRIPTS_PATH}\e[39m\n")
