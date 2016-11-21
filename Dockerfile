FROM maven:3-jdk-8
ENV JMX_EXPORTER_VERSION=0.7
ENV REPO_TAG=parent-${JMX_EXPORTER_VERSION}
EXPOSE 80

# Install java
RUN apt-get update && \
    apt-get -y install \
        libsctp1 \
        tzdata \
        tzdata-java \
        openjdk-7-jre-headless \
        openjdk-7-jre && \

# Build and install https://github.com/prometheus/jmx_exporter
    cd /opt && \
    git clone --branch ${REPO_TAG} https://github.com/prometheus/jmx_exporter.git && \
    cd /opt/jmx_exporter && \
    mvn package && \
    dpkg -i /opt/jmx_exporter/jmx_prometheus_httpserver/target/jmx_prometheus_httpserver_${JMX_EXPORTER_VERSION}_all.deb && \

# Clean up
    rm -rf /opt/jmx_exporter && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Mount your own config here to override the default
# VOLUME /etc/jmx_exporter

ENTRYPOINT [ "/usr/bin/jmx_exporter" ]
CMD [ "80", "/etc/jmx_exporter/jmx_exporter.yaml" ]
