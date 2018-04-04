# Create the OS container
FROM ubuntu:artful as builder

LABEL maintainer "RavenX8"

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get -q -y install g++-7 cmake git curl libcurl4-gnutls-dev wget unzip autoconf libtool libssl-dev python python-pip perl mysql-client libmysqlclient-dev \
  && apt-get clean

  
# Build the Target Server
FROM builder as build
WORKDIR /

RUN git clone https://github.com/dev-osrose/osIROSE-new.git
RUN pip install --user pyparsing

WORKDIR /osIROSE-new
RUN git checkout node_server
RUN git submodule update --init --recursive

RUN mkdir /build
WORKDIR /build
RUN CC=gcc-7 CXX=g++-7 cmake -DOFFICIAL_BUILD=ON /osIROSE-new \
    && CC=gcc-7 CXX=g++-7 cmake --build . --config ${build_config:-Release} \
    && mkdir /server \
    && cp -r /build/bin/* /server \
    && cp /osIROSE-new/cmake/scripts/docker_start_server.sh /server/start.sh
RUN chmod -R 777 /server/

# Run the final output
FROM ubuntu:artful
COPY --from=build /server/ /

RUN apt-get update && apt-get install -y libmysqlclient-dev libcurl3

ARG CONFIG_FILE=/config/server.json
ARG SERVER=LoginServer

ENV CONFIG_FILE $CONFIG_FILE
ENV SERVER $SERVER

VOLUME ["/data"]
VOLUME ["/config"]
VOLUME ["/symbols"]

# Default Server client port
EXPOSE 29000 29100 29200

# Default ISC Server port
EXPOSE 29010 29110 29210

ENTRYPOINT [ "/start.sh" ]
