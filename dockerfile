FROM python:3.10-slim-buster as runstage
ARG BUILD_CONCURRENCY
RUN apt-get update && apt-get install -y locales  && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
RUN mkdir -p /src  && mkdir -p /opt
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates libboost-program-options1.67.0 build-essential libboost-regex1.67.0 libboost-date-time1.67.0 libboost-chrono1.67.0 libboost-filesystem1.67.0 autoconf libboost-iostreams1.67.0 libboost-thread1.67.0 expat liblua5.2-0 libtbb2 git libboost-dev  libzmq5-dev swig cmake automake libtool
WORKDIR /
RUN wget https://github.com/GMLC-TDC/HELICS/releases/download/v2.8.0/Helics-v2.8.0-source.tar.gz
RUN mkdir helics
WORKDIR helics
RUN tar -xzvf ../Helics-v2.8.0-source.tar.gz 
#2.8 does not work
RUN mkdir build
WORKDIR /helics/build
RUN cmake -DBUILD_PYTHON_INTERFACE=ON -DCMAKE_CXX_FLAGS="-fPIC -std=c++14" ..
RUN  NPROC=${BUILD_CONCURRENCY:-$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)} && make -j${NPROC} install
RUN wget http://apache.mirrors.pair.com//xerces/c/3/sources/xerces-c-3.2.3.tar.gz
RUN tar -xzf xerces-c-3.2.3.tar.gz
WORKDIR xerces-c-3.2.3
RUN ./configure CFLAGS="-Wno-error" CPPFLAGS="-Wno-error"
RUN NPROC=${BUILD_CONCURRENCY:-$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)} && make -j${NPROC} install
WORKDIR /
RUN git clone https://github.com/gridlab-d/gridlab-d.git gridlab-d
#RUN mkdir gridlab-d
WORKDIR gridlab-d
RUN git checkout develop
#RUN wget https://github.com/gridlab-d/gridlab-d/archive/refs/tags/v4.1.0.tar.gz
#RUN tar -xzvf ../v4.1.0.tar.gz
#WORKDIR gridlab-d-4.1.0
RUN autoreconf -fi
RUN ./configure --with-helics --with-xerces --enable-silent-rules "CFLAGS=-g -O0 -w" "CXXFLAGS=-g -O0 -w -std=c++14" "LDFLAGS=-g -O0 -w"
RUN NPROC=${BUILD_CONCURRENCY:-$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)} && make -j${NPROC} install
WORKDIR /
COPY start-session.sh /
RUN chmod +x start-session.sh
RUN pip install pytz
RUN apt-get update && \
    apt-get install -y --no-install-recommends tmux
ENV PYTHONPATH "${PYTHONPATH}:/usr/local/python"
RUN git clone https://github.com/adubey14/HELICS-Tutorial.git gridlab-tutorial
