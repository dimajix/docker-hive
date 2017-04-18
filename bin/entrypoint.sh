#!/bin/bash
set -eo pipefail

# Setup environment
source /opt/docker/libexec/hive-init.sh


check_metadb() {
    mysql -u${HIVE_JDO_USERNAME} -p${HIVE_JDO_PASSWORD} -h${HIVE_JDO_HOST}  -e "USE hive; SELECT * FROM VERSION;"
    return $?
}

create_metadb() {
    olddir=$(pwd)
    cd  ${HIVE_HOME}/scripts/metastore/upgrade/mysql
    mysql -u${HIVE_JDO_USERNAME} -p${HIVE_JDO_PASSWORD} -h${HIVE_JDO_HOST}  -e "USE hive; SOURCE hive-schema-2.1.0.mysql.sql;"
    result=$?
    cd $olddir
    return $result
}


start_metastore() {
    if ! check_metadb; then
        create_metadb
    fi

    hive --service metastore
}


main() {
  case "$1" in
    metastore)
      start_metastore
      ;;
    *)
      exec $@
      exit $?
      ;;
  esac
}

main "$@"
