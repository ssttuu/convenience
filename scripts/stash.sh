#!/usr/bin/env bash

source ./gcp.sh

function stash() {
    local name="${1}"
    local path="${2}"
    gsutil rsync -r ${path} "gs://convenience-assets/$(get-version)/$(githash-short)/${name}/${path}"
}

function unstash() {
    local name="${1}"
    gsutil rsync -r "gs://convenience-assets/$(get-version)/$(githash-short)/${name}/" ./
}
