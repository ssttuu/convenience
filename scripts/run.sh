#!/usr/bin/env bash

set -euo pipefail

source .convenience/source "${VERSION}"

GIT_ORG="your-git-org"
GIT_REPO="your-git-repo"

"$@"
