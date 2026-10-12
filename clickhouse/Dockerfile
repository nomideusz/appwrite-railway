# Usage store (Appwrite 2.x keeps usage metrics in ClickHouse only). Same quiet
# config as the langfuse template: console logs, self-telemetry tables off.
FROM clickhouse/clickhouse-server:26.4.3-alpine

COPY railway.xml /etc/clickhouse-server/config.d/railway.xml
# Stock file binds :: and 0.0.0.0; on Railway :: is already dual-stack, so the
# second bind warns on every boot. Overwritten, not deleted.
COPY listen.xml /etc/clickhouse-server/config.d/docker_related_config.xml

# Railway hosts run transparent huge pages "always": jemalloc frees 4K pages
# inside 2 MB huge pages that stay charged, so idle ClickHouse creeps ~25 MB/min.
ENV CLICKHOUSE_DB=appwrite \
    CLICKHOUSE_USER=appwrite \
    CLICKHOUSE_DEFAULT_ACCESS_MANAGEMENT=1 \
    MALLOC_CONF=thp:never
