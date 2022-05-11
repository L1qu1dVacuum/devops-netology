# devops-netology
Домашние задания по курсу Dev-Ops

------

# Домашнее задание к занятию "6.5. Elasticsearch"


## Задача 1


Текст Dockerfile манифеста:

```bash
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
```

Ссылка на образ в репозитории dockerhub:

[Ссылку на образ в репозитории dockerhub](https://hub.docker.com/repository/docker/l1qu1dvacuum/elasticsearch)

Ответ `elasticsearch` на запрос пути `/` в json виде

```bash
$ docker run -p 9200:9200 -d netology_test:0.2

$ curl -X GET http://localhost:9200/

{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "HGJPUFXXQKOIh_i3wYj3iA",
  "version" : {
    "number" : "8.2.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "b174af62e8dd9f4ac4d25875e9381ffe2b9282c5",
    "build_date" : "2022-04-20T10:35:10.180408517Z",
    "build_snapshot" : false,
    "lucene_version" : "9.1.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```


## Задача 2


Добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

```bash
$ curl -X PUT localhost:9200/ind-1 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'

$ curl -X PUT localhost:9200/ind-2 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 2,  "number_of_replicas": 1 }}'

$ curl -X PUT localhost:9200/ind-3 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 4,  "number_of_replicas": 2 }}'
```

Получите список индексов и их статусов:

```bash
$ curl -X GET 'http://localhost:9200/_cat/indices?v'

    health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
    yellow open   ind-3 sLp6SS6cQdSLLZ2ZjUAsnw   4   2          0            0       900b           900b
    yellow open   ind-2 LdhbkT7pTNWRAGPpkzi_Vw   2   1          0            0       450b           450b
    green  open   ind-1 Fys4J0zJRvK7dTAEeX7JIw   1   0          0            0       225b           225b
```

Получите состояние кластера:

```bash
$ curl -X GET 'http://localhost:9200/_cluster/health/ind-1?pretty'

    {
      "cluster_name" : "elasticsearch",
      "status" : "green",
      "timed_out" : false,
      "number_of_nodes" : 1,
      "number_of_data_nodes" : 1,
      "active_primary_shards" : 1,
      "active_shards" : 1,
      "relocating_shards" : 0,
      "initializing_shards" : 0,
      "unassigned_shards" : 0,
      "delayed_unassigned_shards" : 0,
      "number_of_pending_tasks" : 0,
      "number_of_in_flight_fetch" : 0,
      "task_max_waiting_in_queue_millis" : 0,
      "active_shards_percent_as_number" : 100.0
    }

$ curl -X GET 'http://localhost:9200/_cluster/health/ind-2?pretty'

  {
    "cluster_name" : "elasticsearch",
    "status" : "yellow",
    "timed_out" : false,
    "number_of_nodes" : 1,
    "number_of_data_nodes" : 1,
    "active_primary_shards" : 2,
    "active_shards" : 2,
    "relocating_shards" : 0,
    "initializing_shards" : 0,
    "unassigned_shards" : 2,
    "delayed_unassigned_shards" : 0,
    "number_of_pending_tasks" : 0,
    "number_of_in_flight_fetch" : 0,
    "task_max_waiting_in_queue_millis" : 0,
    "active_shards_percent_as_number" : 44.44444444444444
  }

$ curl -X GET 'http://localhost:9200/_cluster/health/ind-3?pretty'

  {
    "cluster_name" : "elasticsearch",
    "status" : "yellow",
    "timed_out" : false,
    "number_of_nodes" : 1,
    "number_of_data_nodes" : 1,
    "active_primary_shards" : 4,
    "active_shards" : 4,
    "relocating_shards" : 0,
    "initializing_shards" : 0,
    "unassigned_shards" : 8,
    "delayed_unassigned_shards" : 0,
    "number_of_pending_tasks" : 0,
    "number_of_in_flight_fetch" : 0,
    "task_max_waiting_in_queue_millis" : 0,
    "active_shards_percent_as_number" : 44.44444444444444
```

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

`Индексы имеют "желтый" статус потому, что не могут реплицироваться кол-во раз указанное при создании.`

Удалите все индексы.

```bash
$ curl -X DELETE 'http://localhost:9200/ind-1?pretty'

$ curl -X DELETE 'http://localhost:9200/ind-2?pretty'

$ curl -X DELETE 'http://localhost:9200/ind-3?pretty'
```


## Задача 3


Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`:

`Изменил Dockerfile`

Используя API зарегистрируйте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots` как `snapshot repository` c именем `netology_backup`:

```bash
$ curl -X POST "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d' { "type": "fs", "settings": { "location": "/elasticsearch-8.2.0/snapshots" }}'

$ curl -X GET 'http://localhost:9200/_snapshot/netology_backup?pretty'

    {
        "netology_backup" : {
            "type" : "fs",
            "settings" : {
                  "location" : "/elasticsearch-8.2.0/snapshots"
            }
        }
    }
```

Создайте индекс `test` с 0 реплик и 1 шардом:

```bash
$ curl -X PUT localhost:9200/test -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'

    {"acknowledged":true,"shards_acknowledged":true,"index":"test"}%

$ curl -X GET 'http://localhost:9200/_cat/indices?v'

    health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
    green  open   test SmdOVzQ3SYeiIGZbGPZDiA   1   0          0            0       225b           225b
```

Создайте `snapshot` состояния кластера `elasticsearch`:

```bash
$ curl -X PUT 'localhost:9200/_snapshot/netology_backup/elasticsearch?wait_for_completion=true'
```

Приведите в ответе список файлов в директории со `snapshotами`:

```bash
$ ls -lha

    total 48K
    drwxr-xr-x 1 elasticsearch elasticsearch 4.0K May 11 14:43 .
    drwxr-xr-x 1 elasticsearch elasticsearch 4.0K May 10 20:16 ..
    -rw-r--r-- 1 elasticsearch elasticsearch  846 May 11 14:43 index-0
    -rw-r--r-- 1 elasticsearch elasticsearch    8 May 11 14:43 index.latest
    drwxr-xr-x 4 elasticsearch elasticsearch 4.0K May 11 14:43 indices
    -rw-r--r-- 1 elasticsearch elasticsearch  18K May 11 14:43 meta-vsd36btYTLaUvGyjvieFXA.dat
    -rw-r--r-- 1 elasticsearch elasticsearch  354 May 11 14:43 snap-vsd36btYTLaUvGyjvieFXA.dat
```

Удалите индекс `test` и создайте индекс `test-2`:

```bash
$ curl -X DELETE 'http://localhost:9200/test?pretty'

$ curl -X PUT localhost:9200/test-2 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "nu
mber_of_replicas": 0 }}'

$ curl -X GET 'http://localhost:9200/_cat/indices?v'

    health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
    green  open   test-2 DCJ88Ce1T9O_cKJsLMiSVw   1   0          0            0       225b           225b
```

Восстановите состояние кластера elasticsearch из snapshot, созданного ранее:

```bash
$ curl -X POST localhost:9200/_snapshot/netology_backup/elasticsearch/_restore -H 'Content-Type: application/json' -d'{"include_global_state":true}'

    {"accepted":true}%

$ curl -X GET 'http://localhost:9200/_cat/indices?v'

    health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
    green  open   test   SmdOVzQ3SYeiIGZbGPZDiA   1   0          0            0       225b           225b
    green  open   test-2 DCJ88Ce1T9O_cKJsLMiSVw   1   0          0            0       225b           225b
```
