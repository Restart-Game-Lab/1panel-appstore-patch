#!/bin/bash

if [ -f ./data/PG_VERSION ]; then
    exit 0
fi

mkdir -p ./data

cat > ./init-extensions.sh << 'EOF'
#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" << 'SQL'
-- Shared preload libraries
ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements, auto_explain, pg_cron';

-- pg_stat_statements
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- auto_explain settings
ALTER SYSTEM SET auto_explain.log_min_duration = '1s';
ALTER SYSTEM SET auto_explain.log_analyze = true;

-- pg_cron
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Common extensions
CREATE EXTENSION IF NOT EXISTS vector;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS hstore;
CREATE EXTENSION IF NOT EXISTS pg_prewarm;
CREATE EXTENSION IF NOT EXISTS pg_visibility;
CREATE EXTENSION IF NOT EXISTS pg_freespacemap;
CREATE EXTENSION IF NOT EXISTS pageinspect;

-- PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;

-- pg_repack (requires superuser)
-- CREATE EXTENSION IF NOT EXISTS pg_repack;

SELECT pg_reload_conf();
SQL
EOF

chmod +x ./init-extensions.sh
