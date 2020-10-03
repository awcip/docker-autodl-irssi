FROM irssi

USER root
RUN set -x \
&& apk --no-cache add \
    perl-archive-zip \
    perl-digest-sha1 \
    perl-html-parser \
    perl-json \
    perl-net-ssleay \
    perl-xml-libxml

USER user
RUN wget https://github.com/autodl-community/autodl-irssi/releases/download/${version}/autodl-irssi-v${version}.zip -O /tmp/autodl-irssi.zip \
    && mkdir -p ${HOME}/.irssi/scripts/autorun \
    && unzip -o /tmp/autodl-irssi.zip -d ${HOME}/.irssi/scripts \
    && cp ${HOME}/.irssi/scripts/autodl-irssi.pl ${HOME}/.irssi/scripts/autorun/autodl-irssi.pl \
    && mkdir ${HOME}/.autodl \
    && rm /tmp/autodl-irssi.zip

CMD ["irssi"]
