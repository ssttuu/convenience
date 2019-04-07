#!/usr/bin/env bash

source ./constants.sh

function zip() {
    docker run --rm -i \
        -u "${UID}:${GID}" \
        -v "$(pwd):$(pwd)" \
        -w "$(pwd)" \
        "kramos/alpine-zip:latest" ${@:-}
}

function unzip() {
    docker run --rm -i \
        -u "${UID}:${GID}" \
        -v "$(pwd):$(pwd)" \
        -w "$(pwd)" \
        --entrypoint unzip \
        "kramos/alpine-zip:latest" ${@:-}
}
