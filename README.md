acd-encfs
=========
[![](https://images.microbadger.com/badges/version/jdavis92/acd-encfs.svg)](https://microbadger.com/images/jdavis92/acd-encfs) [![](https://images.microbadger.com/badges/image/jdavis92/acd-encfs.svg)](https://microbadger.com/images/jdavis92/acd-encfs)

Mount EncFS stored in Amazon Cloud Drive using Docker.

```
docker run -d --name acd-encfs \
    --cap-add SYS_ADMIN \
    --device /dev/fuse \
    -e ENCFS6_PASSWORD='<EncFS Password>' \
    -v /local/path/to/.encfs6.xml:/etc/.encfs6.xml:ro \
    -v /local/path/to/acd_cli:/root/.cache/acd_cli \
    -v /local/mount/target:/mnt/encrypted:shared \
    jdavis92/acd-encfs
```

### Required:

Password for decrypting EncFS:
```
-e ENCFS6_PASSWORD=''
```

EncFS config (default target is /etc/.encfs6.xml, see below to change it):
```
-v /local/path/to/.encfs6.xml:/etc/.encfs6.xml:ro
```

Writable directory for acd_cli cache, must contain oauth_data:
```
-v /local/path/to/acd_cli:/root/.cache/acd_cli
```

Directory to mount the unencrypted files:
```
-v /local/mount/target:/mnt/encrypted:shared
```

### Optional:

Choose the directory in Amazon Cloud Drive to mount (leading forward slash required):
```
-e ACD_MOUNT_SUBDIR="/"
```

Location of the encrypted directory within the mounted Amazon Cloud Drive directory (leading forward slash required):
```
-e ACD_ENCRYPTED_SUBDIR="/"
```

Change the EncFS config location in the container:
```
-e ENCFS6_CONFIG="/etc/.encfs6.xml"
```

Change UID and GID of mounted files:
```
-e MOUNT_UID="1000" \
-e MOUNT_GID="1000"
```
