FROM alpine:3.5

RUN apk add --no-cache \
    ca-certificates \
    elinks \
    encfs \
    fuse \
    python3 \
    s6 \
    && pip3 install acdcli

ADD ./s6 /etc/s6

ENV ACD_ENCRYPTED_SUBDIR="/" \
    ACD_MOUNT_SUBDIR="/" \
    ENCFS6_CONFIG="/etc/.encfs6.xml" \
    ENCFS6_PASSWORD="" \
    USER_UID="1000" \
    USER_GID="1000"

VOLUME "/mnt/encrypted"

CMD ["s6-svscan", "/etc/s6"]
