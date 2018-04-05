# Create the OS container
FROM ubuntu:artful

LABEL maintainer "RavenX8"

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get -q -y install g++-7 cmake git curl libcurl4-gnutls-dev wget unzip autoconf libtool libssl-dev python python-pip perl mysql-client libmysqlclient-dev \
  && apt-get clean

RUN pip install --user pyparsing

#ENTRYPOINT [ "/bin/sh" ]
