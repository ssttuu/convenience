#!/usr/bin/env bash

source ./gcp.sh

function stash() {
    local path="${1}"
    gsutil rsync -dr ${path} "gs://convenience-assets/$(get-version)/$(githash-short)/${path}"
}

function unstash() {
    local path="${1}"
    mkdir -p "${path}"
    gsutil rsync -r "gs://convenience-assets/$(get-version)/$(githash-short)/${path}" ./${path}
    # FIXME: this is terrible
    cloud-sdk chmod -R 777 ${path}
}
