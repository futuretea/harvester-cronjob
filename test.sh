#!/usr/bin/env bash
[[ -n $DEBUG ]] && set -x
set -eou pipefail

usage() {
    cat <<HELP
USAGE:
    test.sh 
HELP
}

exit_err() {
    echo >&2 "${1}"
    exit 1
}

if [ $# -lt 0 ]; then
    usage
    exit 1
fi

kubectl -n default create cm harvester-clean --from-file harvester-clean.sh
kubectl -n default create secret generic harvester-clean --from-file harv-102.config
kubectl apply -f harvester-auto-clean.yaml
kubectl -n default create job --from=cronjob/harvester-auto-clean test-harvester-auto-clean
