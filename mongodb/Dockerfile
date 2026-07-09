FROM mongo:8

ENV MONGO_INITDB_ROOT_USERNAME=root \
    MONGO_INITDB_DATABASE=appwrite \
    MONGO_INITDB_USERNAME=appwrite

COPY mongo-init.js /docker-entrypoint-initdb.d/mongo-init.js
COPY entrypoint.sh /usr/local/bin/railway-entrypoint.sh
RUN chmod +x /usr/local/bin/railway-entrypoint.sh

ENTRYPOINT ["railway-entrypoint.sh"]
