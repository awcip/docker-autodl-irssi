FROM alpine

ENV HOME /home/user

ENV LANG C.UTF-8

RUN set -eux; \
    apk --no-cache add \
        ca-certificates \
        irssi \
        irssi-perl \
        unzip;

RUN set -eux; \
    adduser -u 1000 -D -h "$HOME" user; \
    mkdir -p "$HOME/.irssi/scripts/autorun"; \
    mkdir -p "$HOME/.autodl"; \
    touch "$HOME/.autodl/autodl.cfg"; \
    cd "$HOME/.irssi/scripts"; \
    wget https://github.com/autodl-community/autodl-irssi/releases/download/2.6.2/autodl-irssi-v2.6.2.zip; \
    unzip -o autodl-irssi-v2.6.2.zip; \
    rm autodl-irssi.zip; \
    cp autodl-irssi.pl autorun; \
    chown -R user:user "$HOME"

WORKDIR $HOME

USER user

CMD ["irssi"]
