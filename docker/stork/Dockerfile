FROM debian

ENV STORK_VERSION v0.6.0

RUN apt-get update && apt-get install -y wget \
  rake \
  xz-utils

RUN wget -O /tmp/stork.tar.gz https://gitlab.isc.org/isc-projects/stork/-/archive/${STORK_VERSION}/stork-${STORK_VERSION}.tar.gz && \
  tar xvfz /tmp/stork.tar.gz -C /tmp/

RUN cd /tmp/stork-${STORK_VERSION} && rake install_server DESTDIR=/stork

CMD ["ls", "/stork"]
