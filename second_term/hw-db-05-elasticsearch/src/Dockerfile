FROM centos:7

LABEL netology_test 0.2

RUN yum install wget -y &&\
    yum install perl-Digest-SHA -y && \
    yum clean all

RUN wget --no-check-certificate --no-cache --no-cookies https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.0-linux-x86_64.tar.gz && \
    wget --no-check-certificate --no-cache --no-cookies https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.0-linux-x86_64.tar.gz.sha512 && \
    shasum -a 512 -c elasticsearch-8.2.0-linux-x86_64.tar.gz.sha512 && \
    tar -xzf elasticsearch-8.2.0-linux-x86_64.tar.gz && \
    rm -rf ./elasticsearch-8.2.0-linux-x86_64.tar.gz && \
    rm -rf ./elasticsearch-8.2.0-linux-x86_64.tar.gz.sha512

ENV ES_HOME=/elasticsearch-8.2.0

ENV JAVA_HOME=/elasticsearch-8.2.0/jdk/

ENV PATH=$PATH:/elasticsearch-8.2.0/bin/

RUN groupadd -g 1000 elasticsearch && useradd elasticsearch -u 1000 -g 1000

COPY ./elasticsearch.yml /elasticsearch-8.2.0/config/

COPY ./logging.yml /elasticsearch-8.2.0/config/

RUN mkdir /var/lib/logs && \
    mkdir /var/lib/data && \
    mkdir /elasticsearch-8.2.0/snapshots && \
    chown -R elasticsearch:elasticsearch /elasticsearch-8.2.0 && \
    chown elasticsearch:elasticsearch /var/lib/logs && \
    chown elasticsearch:elasticsearch /var/lib/data

USER elasticsearch

CMD ["elasticsearch"]

EXPOSE 9200 9300
