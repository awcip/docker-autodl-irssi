FROM alpine

ENV HOME /home/user

ENV LANG C.UTF-8

RUN set -eux; \
    apk --no-cache add \
        curl \
        irssi \
        irssi-perl \
        unzip;

RUN set -eux; \
    adduser -u 1000 -D -h "$HOME" user; \
    mkdir -p "$HOME/.irssi/scripts/autorun"; \
    mkdir -p "$HOME/.autodl"; \
    touch "$HOME/.autodl/autodl.cfg"; \
    cd "$HOME/.irssi/scripts"; \
    curl -sL https://github.com/autodl-community/autodl-irssi/releases/download/2.6.2/autodl-irssi-v2.6.2.zip \
         --output autodl-irssi.zip; \
    unzip -o autodl-irssi.zip; \
    rm autodl-irssi.zip; \
    cp autodl-irssi.pl autorun; \
    chown -R user:user "$HOME"

WORKDIR $HOME

USER user

CMD ["irssi"]
