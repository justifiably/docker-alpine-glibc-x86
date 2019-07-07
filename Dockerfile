FROM alpine:latest

ENV GLIB_VERSION=2.29-3

ADD ./ld.so.conf ./tmp/ld.so.conf

RUN apk add --update --no-cache wget tar xz && \
    mkdir -p lib32-glibc-${GLIB_VERSION} glibc-${GLIB_VERSION} \
    /usr/glibc && \
    ln -s /bin/bash /usr/bin/bash && \
    wget http://mirrors.kernel.org/archlinux/core/os/x86_64/glibc-${GLIB_VERSION}-x86_64.pkg.tar.xz -O glibc-${GLIB_VERSION}-x86_64.pkg.tar.xz && \
    wget http://mirrors.kernel.org/archlinux/core/os/x86_64/lib32-glibc-${GLIB_VERSION}-x86_64.pkg.tar.xz -O lib32-glibc-${GLIB_VERSION}-x86_64.pkg.tar.xz
RUN tar xf lib32-glibc-${GLIB_VERSION}-x86_64.pkg.tar.xz -C lib32-glibc-${GLIB_VERSION} && \
    tar xf glibc-${GLIB_VERSION}-x86_64.pkg.tar.xz -C glibc-${GLIB_VERSION} && \
    mv tmp/ld.so.conf /etc/ld.so.conf && \
    cp -a lib32-glibc-${GLIB_VERSION}/usr/ /usr/glibc/ && \
    cp -a glibc-${GLIB_VERSION}/usr/ /usr/glibc/ && \    
    glibc-${GLIB_VERSION}/usr/bin/ldconfig /usr/glibc/usr /usr/glibc/usr/lib /usr/glibc/usr/lib32 && \
    ln -s /usr/glibc/usr/lib/ld-linux.so.2 /lib/ld-linux.so.2  && \
    rm -Rf lib32-glibc-${GLIB_VERSION} lib32-glibc-${GLIB_VERSION}-x86_64.pkg.tar.xz && \
    rm -Rf glibc-${GLIB_VERSION} glibc-${GLIB_VERSION}-x86_64.pkg.tar.xz && \ 
    apk del wget tar xz
