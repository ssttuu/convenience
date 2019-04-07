#!/usr/bin/env bash

function date() {
    echo "$(TZ=UTC command date --rfc-3339=seconds | sed 's/ /T/')Z"
}

function get-version() {
    local part="${1:-major-minor-patch}"
    local version="$(_version)"
    case "${part}" in
        "major")
            echo "${version}" | cut -d. -f1
            ;;
        "minor")
            echo "${version}" | cut -d. -f2
            ;;
        "patch")
            echo "${version}" | cut -d. -f3
            ;;
        "major-minor")
            echo "$(get-version major).$(get-version minor)"
            ;;
        "major-minor-patch")
            echo "${version}"
            ;;
        *)
            (>&2 printf "invalid argument: ${1}\n")
            return 1
            ;;
    esac
}

function _version() {
    cat ./VERSION
}
