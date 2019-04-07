#!/usr/bin/env bash

source ./gcp.sh

function stash() {
    local path="${1}"
    gsutil rsync -r ${path} "gs://convenience-assets/$(get-version)/$(githash-short)/${path}"
}

function unstash() {
    local path="${1}"
    gsutil rsync -r "gs://convenience-assets/$(get-version)/$(githash-short)/${path}/" ${path}
    cloud-sdk chmod -R 777 ${path}
}
