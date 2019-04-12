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
    docker login -u _json_key --password-stdin https://${IMAGE_HOST}
}

function docker-build() {
    local docker_tag="${1:-}"

    local docker_formatted_labels=""
    for label in $(get-labels)
    do
        docker_formatted_labels="${docker_formatted_labels}--label ${label} "
    done

    local docker_formatted_tags=""
    if [[ "${docker_tag}" != "" ]]; then
        docker_formatted_tags="-t $(get-docker-image-name ${docker_tag}) "
    else
        for tag in $(get-tags)
        do
            docker_formatted_tags="${docker_formatted_tags}-t $(get-docker-image-name ${tag}) "
        done
    fi

    docker build ${docker_formatted_labels} ${docker_formatted_tags} .
}

function docker-pull() {
    local tag="${1}"
    docker pull "$(get-docker-image-name ${tag})"
}

function docker-push() {
    local tag="${1:-}"
    if [[ "${tag}" != "" ]]; then
        docker push "$(get-docker-image-name ${tag})"
        return 0
    fi

    for tag in $(get-tags)
    do
        docker push "$(get-docker-image-name ${tag})"
    done
}

function docker-tag() {
    local tag="${1}"
    local target_tags="${@:2}"
    if [[ "${target_tags}" = "" ]];then
        (>&2 printf "must pass target tags to docker-tag command\n")
        return 1
    fi

    for target_tag in ${target_tags}
    do
        docker tag "$(get-docker-image-name ${tag})" "$(get-docker-image-name ${target_tag})"
    done
}
