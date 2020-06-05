# Create the OS container
FROM ubuntu:rolling
LABEL maintainer="RavenX8"
ARG GCC_VERSION=9

RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
  apt-get -q -y install g++-${GCC_VERSION} cmake git curl libcurl4-gnutls-dev wget unzip autoconf libtool libssl-dev python python2-dev perl mysql-client libmysqlclient-dev libncurses5-dev libreadline-dev \
  && apt-get clean && curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py && python get-pip.py && pip install --user pyparsing

ENV CC=gcc-${GCC_VERSION}
ENV CXX=g++-${GCC_VERSION}

WORKDIR /usr
RUN git clone https://github.com/ninja-build/ninja.git /usr/ninja && cd ninja && \
    git checkout release && \
	  ./configure.py --bootstrap && \
	  cd ..
	  
ENV PATH="/usr/ninja:${PATH}"
