#!/usr/bin/env bash


DATE_NOW=$(date +'%m/%d/%Y - %r')
COMMIT_SHA=${CI_COMMIT_SHA:0:8}
WORK_DIR="/opt/projects/monitoring"


function deploy(){
    SRV=$1
    echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
    echo ${PATH}

    ssh -T ${SRV} << ENDSSH
    mkdir -p ${WORK_DIR} && echo "${DATE_NOW}: ${COMMIT_SHA}" >> ${WORK_DIR}/deploy-log.txt
ENDSSH

    scp -rp ~/scripts/${CI_PROJECT_NAME}/* ${SRV}:${WORK_DIR}
}

if [ $# ]; then for SERVER in $@; do deploy ${SERVER};
    echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
    done
fi

exit ${DEPLOY_STATUS}