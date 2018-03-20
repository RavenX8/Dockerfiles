# Create the OS container
FROM ubuntu:artful as builder

LABEL maintainer "RavenX8"

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get -q -y install g++-7 cmake git curl wget unzip autoconf libtool libssl-dev python python-pip perl mysql-client libmysqlclient-dev \
  && apt-get clean

  
# Build the Target Server
FROM builder as build
WORKDIR /

RUN git clone https://github.com/dev-osrose/osIROSE-new.git
RUN pip install --user pyparsing

WORKDIR /osIROSE-new
RUN git submodule update --init --recursive

RUN mkdir /build
WORKDIR /build
RUN CC=gcc-7 CXX=g++-7 cmake -DOFFICIAL_BUILD=ON /osIROSE-new
RUN CC=gcc-7 CXX=g++-7 cmake --build . --config ${build_config:-Release} --target LoginServer \
    && mkdir /server \
    && cp -r /build/bin/ /server/

# Run the final output
FROM ubuntu:artful
COPY --from=build /server/ ./

VOLUME ["/data"]

CMD [ "/LoginServer" ]
