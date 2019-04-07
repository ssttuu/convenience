#!/usr/bin/env bash

set -euo pipefail

source ./.convenience/source "${VERSION}"

GIT_ORG="Your Git Organization"
GIT_REPO="Your Git Repository"

"$@"
