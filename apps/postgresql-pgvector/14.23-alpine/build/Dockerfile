ARG PG_VERSION
ARG POSTGIS_VERSION=3.5.3
ARG PGVECTOR_VERSION=0.8.0

FROM postgres:${PG_VERSION}-alpine AS builder

RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    git \
    zlib-dev \
    openssl-dev \
    lz4-dev \
    zstd-dev \
    curl-dev \
    gawk \
    flex \
    bison \
    curl \
    perl \
    cmake \
    geos-dev \
    proj-dev \
    protobuf-c-dev \
    json-c-dev \
    libxml2-dev \
    sqlite-dev \
    tiff-dev \
    gdal-dev

RUN sed -i 's/with_llvm[[:space:]]*=[[:space:]]*yes/with_llvm = no/g' /usr/local/lib/postgresql/pgxs/src/Makefile.global \
    && ln -sf /usr/lib/libz.so /usr/local/lib/libz.so \
    && ln -sf /usr/lib/libssl.so /usr/local/lib/libssl.so \
    && ln -sf /usr/lib/libcrypto.so /usr/local/lib/libcrypto.so

RUN mkdir -p /tmp/extensions-build

# 1. pgvector
RUN cd /tmp \
    && git clone --branch v${PGVECTOR_VERSION} --depth 1 https://github.com/pgvector/pgvector.git \
    && cd pgvector \
    && make OPTFLAGS="" -j$(nproc) \
    && make OPTFLAGS="" install \
    && cp $(pg_config --sharedir)/extension/vector* /tmp/extensions-build/ \
    && cp $(pg_config --pkglibdir)/vector.so /tmp/extensions-build/

# 2. pg_repack
RUN cd /tmp \
    && git clone --depth 1 https://github.com/reorg/pg_repack.git \
    && cd pg_repack \
    && make -j$(nproc) \
    && make install \
    && cp $(pg_config --sharedir)/extension/pg_repack* /tmp/extensions-build/ \
    && cp $(pg_config --pkglibdir)/pg_repack.so /tmp/extensions-build/

# 3. pg_cron
RUN cd /tmp \
    && git clone --depth 1 https://github.com/citusdata/pg_cron.git \
    && cd pg_cron \
    && make -j$(nproc) \
    && make install \
    && cp $(pg_config --sharedir)/extension/pg_cron* /tmp/extensions-build/ \
    && cp $(pg_config --pkglibdir)/pg_cron.so /tmp/extensions-build/

# 4. pg_hint_plan
RUN PG_MAJOR=$(echo "${PG_VERSION}" | cut -d. -f1) \
    && cd /tmp \
    && git clone --branch PG${PG_MAJOR} --depth 1 https://github.com/ossc-db/pg_hint_plan.git \
    && cd pg_hint_plan \
    && make -j$(nproc) \
    && make install \
    && cp $(pg_config --sharedir)/extension/pg_hint_plan* /tmp/extensions-build/ \
    && cp $(pg_config --pkglibdir)/pg_hint_plan.so /tmp/extensions-build/

# 5. PostGIS (compile from source, strip raster to avoid build errors)
RUN cd /tmp \
    && curl -fsSL "https://download.osgeo.org/postgis/source/postgis-${POSTGIS_VERSION}.tar.gz" -o postgis.tar.gz \
    && tar xzf postgis.tar.gz \
    && cd postgis-${POSTGIS_VERSION} \
    && ./configure --with-pgconfig=$(which pg_config) --without-raster --without-sfcgal --without-topology \
    && find . -name Makefile -exec sed -i 's/\braster\b//g' {} \; 2>/dev/null || true \
    && make -j$(nproc) \
    && make install \
    && cp $(pg_config --sharedir)/extension/postgis* /tmp/extensions-build/ \
    && cp $(pg_config --pkglibdir)/postgis*.so /tmp/extensions-build/

FROM postgres:${PG_VERSION}-alpine

RUN apk add --no-cache \
    geos \
    proj \
    gdal \
    protobuf-c \
    json-c \
    libxml2 \
    sqlite-libs

COPY --from=builder /tmp/extensions-build/*.so /usr/local/lib/postgresql/
COPY --from=builder /tmp/extensions-build/*.control /usr/local/share/postgresql/extension/
COPY --from=builder /tmp/extensions-build/*.sql /usr/local/share/postgresql/extension/

COPY init-extensions.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init-extensions.sh

RUN echo "shared_preload_libraries = 'pg_cron,pg_hint_plan'" >> /usr/local/share/postgresql/postgresql.conf.sample

LABEL pg.version="${PG_VERSION}" \
      extensions.postgis.version="${POSTGIS_VERSION}" \
      extensions.pgvector.version="${PGVECTOR_VERSION}"

RUN echo "=== Installed extensions ===" \
    && for ctrl in /usr/local/share/postgresql/extension/*.control; do \
         basename "$ctrl" .control; done \
    && echo "=== .so files ===" \
    && ls /usr/local/lib/postgresql/*.so 2>/dev/null || true
