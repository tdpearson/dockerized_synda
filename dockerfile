FROM debian:buster as build

RUN apt-get update \
  && apt-get install -y \
    bc \
    gcc \
    python \
    python-pip \
    python-dev \
    libssl-dev \
    sqlite3 \
    libsqlite-dev \
    libxslt-dev \
    libxml2-dev \
    libz-dev \
    libffi-dev \
    dumb-init \
    wget

ARG SYNDA_VERSION=3.13

RUN wget --no-check-certificate https://raw.githubusercontent.com/Prodiguer/synda/$SYNDA_VERSION/sdc/install.sh \
  && chmod +x ./install.sh \
  && ./install.sh || tail //install.log

ENV ST_HOME=/root/sdt
ENV PATH=/root/sdt/bin:${PATH}

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["synda", "daemon", "start"]


