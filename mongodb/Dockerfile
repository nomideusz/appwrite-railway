FROM mongo:8

COPY mongo-init.js /docker-entrypoint-initdb.d/mongo-init.js
COPY entrypoint.sh /usr/local/bin/railway-entrypoint.sh
RUN chmod +x /usr/local/bin/railway-entrypoint.sh

ENTRYPOINT ["railway-entrypoint.sh"]
