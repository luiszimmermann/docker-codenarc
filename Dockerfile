FROM groovy:3.0.6

USER root

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y git && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

USER groovy

ENV CODENARC_VER=2.0.0
ENV SLF4J_VER=1.7.30
ENV GMETRICS_VERSION=1.1
ENV GROOVY_JAR=$GROOVY_HOME/lib/*
ENV HOME_JARS=/home/groovy/*

COPY CodeNarc-$CODENARC_VER.jar CodeNarc-$CODENARC_VER.jar
RUN wget https://repo1.maven.org/maven2/org/slf4j/slf4j-api/$SLF4J_VER/slf4j-api-$SLF4J_VER.jar
RUN wget https://repo1.maven.org/maven2/org/slf4j/slf4j-simple/$SLF4J_VER/slf4j-simple-$SLF4J_VER.jar
RUN wget https://github.com/dx42/gmetrics/releases/download/v$GMETRICS_VERSION/gmetrics-$GMETRICS_VERSION.jar

COPY codenarc /usr/bin

WORKDIR /app

ENTRYPOINT ["codenarc"]
