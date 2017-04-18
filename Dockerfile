FROM dimajix/hadoop:2.7.3
MAINTAINER k.kupferschmidt@dimajix.de

ARG BUILD_HIVE_VERSION=2.1.1

USER root

# Common Environment variables
ENV HIVE_HOME=/opt/hive \
    HIVE_CONF_DIR=/etc/hive \
    HCAT_CONF_DIR=/etc/hive

# Download and install Hive
RUN curl -sL --retry 3 "http://www-us.apache.org/dist/hive/hive-${BUILD_HIVE_VERSION}/apache-hive-${BUILD_HIVE_VERSION}-bin.tar.gz" \
  | tar xz -C /opt \
 && ln -s /opt/apache-hive-${BUILD_HIVE_VERSION}-bin ${HIVE_HOME} \
 && chown -R root:root ${HIVE_HOME} \
 && mkdir -p ${HIVE_CONF_DIR}

RUN apt-get install -y libmysql-java mariadb-client \
 && ln -s /usr/share/java/mysql-connector-java.jar $HIVE_HOME/lib/mysql-connector-java.jar \
 && apt-get clean

# copy configs and binaries
COPY bin/ /opt/docker/bin/
COPY libexec/ /opt/docker/libexec/
COPY conf/ /opt/docker/conf/hive/

ENV PATH=$PATH:${HIVE_HOME}/bin

ENTRYPOINT ["/opt/docker/bin/entrypoint.sh"]
CMD ["bash"]
