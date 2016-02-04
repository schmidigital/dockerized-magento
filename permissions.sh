#!/bin/bash
set -e

# Script to workaround docker-machine/boot2docker OSX host volume issues: https://github.com/docker-library/mysql/issues/99

echo '* Working around permission errors locally by making sure that "mysql" uses the same uid and gid as the host volume'
TARGET_UID=$(stat -c "%u" $FOLDER)
echo '-- Setting mysql user to use uid '$TARGET_UID
usermod -o -u $TARGET_UID $USER || true

TARGET_GID=$(stat -c "%g" $FOLDER)
echo '-- Setting mysql group to use gid '$TARGET_GID
groupmod -o -g $TARGET_GID $USER || true

echo
echo '* Starting Entrypoint'
echo $ENTRYPOINT
#chown -R mysql:root /var/run/mysqld/

$ENTRYPOINT
