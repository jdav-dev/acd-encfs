FROM alpine:3.5

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.name="acd-encfs" \
      org.label-schema.description="Mount EncFS from Amazon Cloud Drive using Docker." \
      org.label-schema.vcs-url="https://github.com/jdavis92/acd-encfs.git" \
      org.label-schema.docker.cmd="docker run --cap-add SYS_ADMIN --device /dev/fuse -e ENCFS6_PASSWORD='<EncFS Password>' -v /local/path/to/.encfs6.xml:/etc/.encfs6.xml:ro -v /local/path/to/acd_cli:/root/.cache/acd_cli -v /local/mount/target:/mnt/encrypted:shared jdavis92/acd-encfs" \
      org.label-schema.docker.param="ACD_MOUNT_SUBDIR=Encrypted directory to mount relative to ACD_MOUNT_SUBDIR, ACD_MOUNT_SUBDIR=ACD directory to mount, ENCFS6_CONFIG=Location of EncFS config, ENCFS6_PASSWORD=Password for decrypting EncFS, USER_UID=UID for mounted files, USER_GID=GID for mounted files"

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
    ENCFS6_PASSWORD='' \
    USER_UID="1000" \
    USER_GID="1000"

VOLUME "/mnt/encrypted"

CMD ["s6-svscan", "/etc/s6"]
