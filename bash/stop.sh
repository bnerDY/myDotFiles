#!/usr/bin/env bash


BASE_NAME=$(basename $0)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}

ARGS=$@

function change_delimiter() {
    echo $1 | sed "s/$2/$3/g"
}

function exit_with_usage() {
    echo "./${BASE_NAME} [docker compose commands | help]"
    exit $1
}

function git_branch_name() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

STAGE=$(git_branch_name)
if [[ ${STAGE} == feature* ]]; then
    STAGE="feature"
elif [[ ${STAGE} == hotfix* ]]; then
    STAGE="feature"
elif [[ ${STAGE} == develop* ]]; then
    STAGE="develop"
elif [[ ${STAGE} == master* ]]; then
    STAGE="prod"
elif [[ ${STAGE} == release* ]]; then
    STAGE="prod"
else
    echo "Internal error: cannot find the appropriate stage."
fi


export SML_RUNTIME_STAGE=${STAGE}
export SML_RUNTIME_MODE="deploy"

#export SPIDER_LOG_FLUENTD_ADDRESS="10.176.16.57:24224"


function docker_compose_deploy() {
    docker-compose -f docker-compose.base.yml \
                   -f docker-compose.${STAGE}.yml \
                   $@
}

if [[ -z ${ARGS} ]]; then
    docker_compose_deploy down --remove-orphans
else
    docker_compose_deploy ${ARGS}
fi