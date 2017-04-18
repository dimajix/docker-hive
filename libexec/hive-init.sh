#!/usr/bin/env bash
set -eo pipefail

# Setup environment
source /opt/docker/libexec/hadoop-init.sh
source /opt/docker/libexec/hive-vars.sh

render_templates /opt/docker/conf/hive ${HIVE_CONF_DIR}
