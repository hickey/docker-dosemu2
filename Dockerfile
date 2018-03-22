FROM debian:stretch

ENV \
  LANG="C.UTF-8" \
  LC_ALL="C.UTF-8"

COPY dosemu2_amd64.deb /tmp/dosemu2.deb
COPY f83v2-ms.lzh /tmp/f83v2-ms.lzh

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl gpm libsdl2-2.0-0 libslang2 locales man unzip wget && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen C.UTF-8 en_US.UTF-8 en_us && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales && \
    update-locale LANG=C.UTF-8 && \
    dpkg -i /tmp/dosemu2.deb && rm -rf /tmp/dosemu2.deb &&
    apt-get update && apt-get install lhasa && \
    cd /etc/dosemu/drives/c && \
    lhasa -x /tmp/f83v2-ms.lzh && rm /tmp/f83v2-ms.lzh
    

ENTRYPOINT ["dosemu", "-E", "f83"]
