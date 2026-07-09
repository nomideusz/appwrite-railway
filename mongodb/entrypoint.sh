#!/bin/bash
# Appwrite needs mongod as a single-member replica set with auth.
# Railway allows one volume (mounted at /data): dbpath lives at /data/db,
# the replica-set keyfile at /data/keyfile — both on the same volume.
set -e

KEYFILE=/data/keyfile/mongo-keyfile
mkdir -p /data/keyfile
if [ ! -f "$KEYFILE" ]; then
  openssl rand -base64 756 > "$KEYFILE"
fi
chmod 400 "$KEYFILE"
chown 999:999 "$KEYFILE" 2>/dev/null || true

# Upstream compose initiates the replica set from a healthcheck side effect;
# Railway has none, so do it here once mongod answers.
(
  until mongosh --quiet -u root -p "$MONGO_INITDB_ROOT_PASSWORD" --eval 'db.adminCommand({ping:1})' >/dev/null 2>&1; do
    sleep 2
  done
  mongosh --quiet -u root -p "$MONGO_INITDB_ROOT_PASSWORD" --eval "
    try { rs.status() } catch (e) {
      rs.initiate({_id: 'rs0', members: [{_id: 0, host: '${RAILWAY_PRIVATE_DOMAIN:-localhost}:27017'}]})
    }"
) &

exec docker-entrypoint.sh mongod --replSet rs0 --bind_ip_all --auth --keyFile "$KEYFILE"
