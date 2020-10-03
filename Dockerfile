FROM irssi

USER root
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    unzip \
    libarchive-zip-perl \
    libdigest-sha-perl \
    libhtml-html5-entities-perl \
    libjson-perl \
    libcrypt-ssleay-perl \
    libxml-libxml-perl; \
    rm -rf /var/lib/apt/lists/*

USER user
RUN wget https://github.com/autodl-community/autodl-irssi/releases/download/2.6.2/autodl-irssi-v2.6.2.zip -O /tmp/autodl-irssi.zip \
    && mkdir -p ${HOME}/.irssi/scripts/autorun \
    && unzip -o /tmp/autodl-irssi.zip -d ${HOME}/.irssi/scripts \
    && cp ${HOME}/.irssi/scripts/autodl-irssi.pl ${HOME}/.irssi/scripts/autorun/autodl-irssi.pl \
    && mkdir ${HOME}/.autodl \
    && rm /tmp/autodl-irssi.zip

CMD ["irssi"]
