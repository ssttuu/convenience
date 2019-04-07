#!/usr/bin/env bash

source ./constants.sh

function gcloud-config() {
    docker volume create gcloud-config
    docker run --rm -i -v "gcloud-config:/config" alpine:3.9.2 sh -c "$(cat <<EOF
    mkdir -p /config/myconfig/configurations
    printf "[auth]\ncredential_file_override = /config/svc_account.json\n" > /config/myconfig/configurations/config_default
    echo -E '${GCP_SERVICE_ACCOUNT_CREDENTIALS}' > /config/svc_account.json
EOF
    )"
}

function gcloud-activate-service-account() {
    gcloud auth activate-service-account --key-file=/config/svc_account.json
}

function cloud-sdk() {
    docker run --rm -i \
        -v "$(pwd):$(pwd)" \
        -w "$(pwd)" \
        -v "gcloud-config:/config" \
        -e CLOUDSDK_CONFIG=/config/myconfig \
        "google/cloud-sdk:241.0.0-alpine" "${@}"
}

function gcloud() {
    cloud-sdk gcloud "${@:-}"
}

function gsutil() {
    cloud-sdk gsutil "${@:-}"
}
