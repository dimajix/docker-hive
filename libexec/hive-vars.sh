#!/usr/bin/env bash

export HIVE_WAREHOUSE=/user/hive/warehouse
export HIVE_METASTORE_HOST=${HIVE_METASTORE_HOST=localhost}
export HIVE_METASTORE_PORT=${HIVE_METASTORE_PORT=9083}

export HIVE_SERVER2_PORT=${HIVE_SERVER2_PORT=10000}

export HIVE_JDO_DRIVER=${HIVE_JDO_DRIVER=org.apache.derby.jdbc.EmbeddedDriver}
export HIVE_JDO_CONNECTION=${HIVE_JDO_CONNECTION=jdbc:derby:;databaseName=/tmp/metastore_db;create=true}
export HIVE_JDO_USERNAME=${HIVE_JDO_USERNAME=hive}
export HIVE_JDO_PASSWORD=${HIVE_JDO_PASSWORD=hive}

# Derive hostname and database from connection string
export HIVE_JDO_HOST=${HIVE_JDO_HOST=$(echo $HIVE_JDO_CONNECTION | sed -n 's#.*//\(.*\)/.*#\1#p')}
export HIVE_JDO_DATABASE=${HIVE_JDO_DATABASE=$(echo $HIVE_JDO_CONNECTION | sed -n 's#.*//.*/\(.*\)\(\?.*\)#\1#p')}
