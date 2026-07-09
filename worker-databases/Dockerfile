FROM appwrite/appwrite:1.9

ENV _APP_ENV=production \
    _APP_EDITION=self-hosted \
    _APP_WORKER_PER_CORE=2 \
    _APP_CPU_NUM=4 \
    _APP_POOL_ADAPTER=stack \
    _APP_DB_ADAPTER=mongodb \
    _APP_DB_PORT=27017 \
    _APP_DB_SCHEMA=appwrite \
    _APP_DB_USER=appwrite \
    _APP_DB_ADAPTER_DOCUMENTSDB=mongodb \
    _APP_DB_ADAPTER_VECTORSDB=postgresql \
    _APP_DB_SCHEMA_VECTORSDB=appwrite \
    _APP_DB_USER_VECTORSDB=appwrite \
    _APP_REDIS_PORT=6379 \
    _APP_OPTIONS_FORCE_HTTPS=disabled \
    _APP_OPTIONS_ABUSE=enabled \
    _APP_USAGE_STATS=disabled \
    _APP_EXECUTOR_SECRET=executor-not-deployed-on-railway \
    _APP_EXECUTOR_HOST=http://executor-not-deployed/v1

ENV _APP_WORKERS_NUM=1 _APP_WORKER_MAX_COROUTINES=1

CMD ["worker-databases"]
