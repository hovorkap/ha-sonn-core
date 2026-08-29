FROM ghcr.io/sonn-audio/core:4.0.0-beta.19

RUN mkdir -p /opt/sonn-public \
    && cp -a /app/public/. /opt/sonn-public/

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]
