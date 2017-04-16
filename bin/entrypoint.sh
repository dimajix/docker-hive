#!/bin/bash
set -eo pipefail

# Setup environment
source /opt/docker/libexec/hive-init.sh


start_metastore() {
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
