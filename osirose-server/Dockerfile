# Build the Target Server
FROM ravenx8/ubuntu-dev as build
WORKDIR /

RUN git clone https://github.com/dev-osrose/osIROSE-new.git

WORKDIR /osIROSE-new
RUN git submodule update --init --recursive

RUN mkdir /build
WORKDIR /build
RUN CC=gcc-8 CXX=g++-8 cmake -DOFFICIAL_BUILD=ON /osIROSE-new \
    && CC=gcc-8 CXX=g++-8 cmake --build . --config ${build_config:-Release} \
    && mkdir /server \
    && cp -r /build/3rdparty/*.so* /server \
    && cp -r /build/bin/* /server \
    && rm -r /server/symbols \
    && cp /osIROSE-new/cmake/scripts/docker_start_server.sh /server/start.sh \
    && chmod -R 777 /server/

# Run the final output
FROM ubuntu:artful
COPY --from=build /server/ /opt/osirose/

RUN apt-get update && apt-get install -y libmysqlclient-dev libcurl4-gnutls-dev

ARG CONFIG_FILE=/config/server.json
ARG SERVER=LoginServer

ENV CONFIG_FILE $CONFIG_FILE
ENV SERVER $SERVER

VOLUME ["/opt/osirose/scripts"]
VOLUME ["/config"]

# Default Server client port
EXPOSE 29000/tcp 29100/tcp 29200-29300

# Default ISC Server port
EXPOSE 29010/tcp 29110/tcp 29210/tcp

ENTRYPOINT [ "/opt/osirose/start.sh" ]
