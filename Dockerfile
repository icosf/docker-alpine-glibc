FROM alpine:3.12

ENV LANG=C.UTF-8

RUN ALPINE_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" && \
    ALPINE_GLIBC_PACKAGE_VERSION="2.32-r0" && \
    ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_DEV_PACKAGE_FILENAME="glibc-dev-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    apk add --no-cache ca-certificates wget && \
    wget \
        -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_DEV_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" &&\
    apk add --no-cache \
        $ALPINE_GLIBC_BASE_PACKAGE_FILENAME \
        $ALPINE_GLIBC_BIN_PACKAGE_FILENAME \
        $ALPINE_GLIBC_DEV_PACKAGE_FILENAME \
        $ALPINE_GLIBC_I18N_PACKAGE_FILENAME &&\
    /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 &&\
    rm "/etc/apk/keys/sgerrand.rsa.pub" && \
    rm "/root/.wget-hsts" &&\
    rm -f \
        $ALPINE_GLIBC_BASE_PACKAGE_FILENAME \
        $ALPINE_GLIBC_BIN_PACKAGE_FILENAME \
        $ALPINE_GLIBC_DEV_PACKAGE_FILENAME \
        $ALPINE_GLIBC_I18N_PACKAGE_FILENAME
