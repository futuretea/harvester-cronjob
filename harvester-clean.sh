#!/usr/bin/env bash
[[ -n $DEBUG ]] && set -x
set -eou pipefail

usage() {
    cat <<HELP
USAGE:
    harvester-clean.sh NAMESPACES
HELP
}

exit_err() {
    echo >&2 "${1}"
    exit 1
}

if [ $# -lt 1 ]; then
    usage
    exit 1
fi

NAMESPACES=$@

for NAMESPACE in ${NAMESPACES}; do
for RESOURCE in vm pvc; do
kubectl -n ${NAMESPACE} delete ${RESOURCE} --all
done
done
