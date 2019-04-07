#!/usr/bin/env bash

function get-docker-image-name() {
    local tag="${1}"
    echo "${IMAGE_REPO}/${IMAGE_NAME}:${tag}"
}

function get-labels() {
    echo "org.label-schema.build-date=$(date)"
    echo "org.label-schema.name=${IMAGE_NAME}"
    echo "org.label-schema.version=$(get-version)"
    echo "org.label-schema.schema-version=1.0"
    echo "version.githash=$(githash)"
    echo "version.githash-short=$(githash-short)"
    echo "version.major-minor-patch=$(get-version)"
}

function get-tags() {
    echo "$(githash)"
    echo "$(githash-short)"
    echo "$(get-version major-minor-patch)"
    echo "$(get-version major-minor)"
    echo "$(get-version major)"
    echo "latest"
}

function docker-login-with-json-key() {
    docker login -u _json_key --password-stdin https://gcr.io < ${1}
}

function docker-build() {
    local docker_formatted_labels=""
    for label in $(get-labels)
    do
        docker_formatted_labels="${docker_formatted_labels}--label ${label} "
    done

    local docker_formatted_tags=""
    for tag in $(get-tags)
    do
        docker_formatted_tags="${docker_formatted_tags}-t $(get-docker-image-name ${tag}) "
    done

    docker build ${docker_formatted_labels} ${docker_formatted_tags} .

}

function docker-push() {
    local tag="${1}"
    if [[ "${tag}" != "" ]]; then
        docker push "$(get-docker-image-name ${tag})"
    fi

    for tag in $(get-tags)
    do
        docker push "$(get-docker-image-name ${tag})"
    done
}
