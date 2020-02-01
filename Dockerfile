from debian:stretch as build

workdir /kea

run apt-get update && apt-get install -y automake \
  checkinstall \
  libtool \
  pkg-config \
  build-essential \
  ccache \
  postgresql-server-dev-all \
  libpq-dev \
  libboost-dev \
  libboost-system-dev \
  liblog4cplus-dev \
  libssl-dev \
  wget

run wget -O /tmp/kea-1.7.4.tar.gz https://ftp.isc.org/isc/kea/1.7.4/kea-1.7.4.tar.gz && \
  tar -xf /tmp/kea-1.7.4.tar.gz -C /kea --strip-components=1

#export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig
# export CC="ccache gcc" CXX="ccache g++"
#declare -x PATH="/usr/lib64/ccache:$PATH"
run autoreconf --install && \
  ./configure --with-pgsql && \
  make -j4 && \
  checkinstall --install=no -D make install && \
  mv kea*.deb kea.deb

from debian:stretch

copy --from=build /kea/kea.deb /tmp/kea.deb

run dpkg -i /tmp/kea.deb && \
  echo "/usr/local/lib/hooks" > /etc/ld.so.conf.d/kea.conf && \
  ldconfig

copy kea-dhcp4.conf /usr/local/etc/kea/kea-dhcp4.conf
run mkdir -p /var/lib/kea
# copy keactrl.conf .

cmd ["/usr/local/sbin/kea-dhcp4", "-c", "/usr/local/etc/kea/kea-dhcp4.conf"]

#cmd ["keactrl", "start", "-c", "./keactrl.conf"]
