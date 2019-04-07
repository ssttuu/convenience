#!/usr/bin/env bash

function githash() {
    git rev-parse HEAD
}

function githash-short() {
    git rev-parse --short=10 HEAD
}

function git-tag() {
    git tag -a "$(get-version)" -m "$(get-version)" ${@:-}
}

function git-tag-push() {
    git push origin "$(get-version)" ${@:-}
}

function git-release() {
    curl -L -X POST \
        -u "${GIT_USER}:${GIT_PASSWORD}" \
        -H "Content-Type: application/json" \
        -d @- \
        "https://api.github.com/repos/${GIT_ORG}/${GIT_REPO}/releases"
}

function git-release-asset() {
    local release_id="${1}"
    local asset_name="${2}"
    local asset_path="${3}"
    curl -L -X POST \
        -u "${GIT_USER}:${GIT_PASSWORD}" \
        -H "Content-Type: $(file -b --mime-type ${asset_path})" \
        --data-binary @${asset_path} \
        "https://uploads.github.com/repos/${GIT_ORG}/${GIT_REPO}/releases/${release_id}/assets?name=${asset_name}"
}
