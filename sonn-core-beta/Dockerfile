FROM ghcr.io/sonn-audio/core:beta

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential \
        gcc \
        g++ \
        make \
        python3 \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /opt/sonn-public /opt/sonn-data \
    && cp -a /app/public/. /opt/sonn-public/ \
    && if [ -d /app/data ]; then cp -a /app/data/. /opt/sonn-data/; fi

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]
