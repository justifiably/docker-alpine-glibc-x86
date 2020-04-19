FROM alpine:3.11

ENV GLIBC_VERSION=2.31-2

ADD ./ld.so.conf ./tmp/ld.so.conf

RUN apk add --update --no-cache wget tar zstd && \
    mkdir -p lib32-glibc-${GLIBC_VERSION} glibc-${GLIBC_VERSION} \
    /usr/glibc && \
    ln -s /bin/bash /usr/bin/bash && \
    wget http://mirrors.kernel.org/archlinux/core/os/x86_64/glibc-${GLIBC_VERSION}-x86_64.pkg.tar.zst -O glibc-${GLIBC_VERSION}-x86_64.pkg.tar.zst && \
    wget http://mirrors.kernel.org/archlinux/core/os/x86_64/lib32-glibc-${GLIBC_VERSION}-x86_64.pkg.tar.zst -O lib32-glibc-${GLIBC_VERSION}-x86_64.pkg.tar.zst
RUN tar xf lib32-glibc-${GLIBC_VERSION}-x86_64.pkg.tar.zst -C lib32-glibc-${GLIBC_VERSION} && \
    tar xf glibc-${GLIBC_VERSION}-x86_64.pkg.tar.zst -C glibc-${GLIBC_VERSION} && \
    mv tmp/ld.so.conf /etc/ld.so.conf && \
    cp -a lib32-glibc-${GLIBC_VERSION}/usr/ /usr/glibc/ && \
    cp -a glibc-${GLIBC_VERSION}/usr/ /usr/glibc/ && \    
    glibc-${GLIBC_VERSION}/usr/bin/ldconfig /usr/glibc/usr /usr/glibc/usr/lib /usr/glibc/usr/lib32 && \
    ln -s /usr/glibc/usr/lib/ld-linux.so.2 /lib/ld-linux.so.2  && \
    rm -Rf lib32-glibc-${GLIBC_VERSION} lib32-glibc-${GLIBC_VERSION}-x86_64.pkg.tar.zst && \
    rm -Rf glibc-${GLIBC_VERSION} glibc-${GLIBC_VERSION}-x86_64.pkg.tar.zst && \ 
    apk del wget tar zstd
