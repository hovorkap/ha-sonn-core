FROM ghcr.io/sonn-audio/core:beta

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential \
        gcc \
        g++ \
        make \
        python3 \
    && rm -rf /var/lib/apt/lists/* \
    && if [ -d /app/data ]; then mkdir -p /opt/sonn-data-default && cp -a /app/data/. /opt/sonn-data-default/; fi

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]
