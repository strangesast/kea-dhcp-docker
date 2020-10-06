from debian

ENV KEA_VERSION 1.6.2

RUN apt-get update && apt-get install -y wget \
  automake \
  libtool \
  pkg-config \
  build-essential \
  ccache \
  libboost-dev \
  libboost-system-dev \
  liblog4cplus-dev \
  libssl-dev \
  postgresql-server-dev-all \
  libpq-dev

RUN wget -O /tmp/kea.tar.gz https://downloads.isc.org/isc/kea/${KEA_VERSION}/kea-${KEA_VERSION}.tar.gz && \
  tar xvfz /tmp/kea.tar.gz -C /tmp/

RUN cd /tmp/kea-${KEA_VERSION} && \
  PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig PATH="/usr/lib64/ccache:$PATH" autoreconf --install && \
  ./configure --with-pgsql && \
  make -j4 && \
  make install && \
  echo "/usr/local/lib/hooks" > /etc/ld.so.conf.d/kea.conf && \
  ldconfig
