#!/usr/bin/env bash

# For example, cron record
# */1	*	*	*	*   cd /opt/project/ && ./app ./config 2>&1 >> /var/log/monitoring.log

set -o nounset
set -o errexit

date_now=$(date +'%Y/%m/%d %r')

work_dir=$(pwd)

if [[ $1 ]]
then
    config_name="$1"   # all app configs in here
    config_path="${work_dir}/${config_name}" && source ${config_path}
else
    echo "You need config file to run this. \
Example: \"${0} ./example_config.sh\"" && exit 1

fi

export date_now
export config_path
export work_dir


function main(){

    checks/diskSpaceCheck
    checks/usedMemoryCheck
    checks/replicaSetCheck
    checks/servicesCheck ${services_array[*]}

}

main