# devops-netology
Домашние задания по курсу Dev-Ops

------

# Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"


## Задача 1


 $ docker run -t -d -p 80:80 nginx

 $ docker ps -a

 	CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                NAMES
 	2eb5f96ea170   nginx     "/docker-entrypoint.…"   13 seconds ago   Up 12 seconds   0.0.0.0:80->80/tcp 	loving_black

 $ cat index.html

 	<html>
 	<head>
	Hey, Netology
	</head>
	<body>
	<h1>I’m DevOps Engineer!</h1>
	</body>
	</html>

 $ docker cp index.html 2eb5f96ea170:/usr/share/nginx/html/index.html

 $ docker commit 2eb5f96ea170  l1qu1dvacuum/nginx_image:version_0.1

	sha256:36707114bd738e1184cbfef27035e03403031837104b7994143ece58b3db2c08

 [Ссылка на форк](https://hub.docker.com/r/l1qu1dvacuum/nginx_image/tags)


## Задача 2


 Высоконагруженное монолитное java веб-приложение - нет не обходимости, но в целях изоляции тяжелого и плохо масштабируемого прилоения от системы, можно запустить его в контейнере;
 
 Nodejs веб-приложение - можно разбить на сервисы и зупустить все в отдельных контейнерах, для лучшей масштабируемости и повышения отказоустойчивости; 
 
 Мобильное приложение c версиями для Android и iOS - подойдет. Даст возможность разработчикам и QI работать в референсной среде, и выстроить процесс cd/ci;
 
 Шина данных на базе Apache Kafka - так как принцип действия кафки предролагает распределенный доступ к большому кол-ву брокеров, то тут будет очень умеcтным развернуть все это в виде контейнеров, это будет относительно быстро, позволит получить высокодоступность и отказоустойчивость; 
 
 Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana - если я все правльно понял то возможна организация всего описанного в виде docker swarm, для отказоустойчивости, балансировки нагрузки и развертки;
 
 Мониторинг-стек на базе Prometheus и Grafana - отлично подойдет для помещения в контейнеры, быстрая развертка, возможность интегрировать почти в любую существующую инфраструктуру;
 
 MongoDB, как основное хранилище данных для java-приложения - нет не обходимости, но можно обеспечить работу в контейнерах для того чтобы сделать БД переносимой и масштабируемой;
 
 Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry - имеет смысл, т.к. у GitLab уже имеются собранные образы контейнеров для этого сценария. Можно сократить время и человекочасы на развертку и натройку. 


## Задача 3


 $ mkdir data
 
 $ docker run  -v ./data:/data -t -d centos

 $ docker run  -v ./data:/data -t -d debian

 $ docker ps -a

	CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS          PORTS     NAMES
	5f99c2176e32   debian    "bash"        8 seconds ago    Up 7 seconds              exciting_heyrovsky
	2894b81fcdbc   centos    "/bin/bash"   56 seconds ago   Up 56 seconds             fervent_dubinsky

 $ docker exec -it 2894b81fcdbc bash

 # echo "hello netology" > /data/hellofile

 ^D

 $ docker exec -it 5f99c2176e32 bash

 # ls -lha /data

	total 12K
	drwxr-xr-x 2 root root 4.0K Feb  8 11:34 .
	drwxr-xr-x 1 root root 4.0K Feb  8 11:32 ..
	-rw-r--r-- 1 root root   15 Feb  8 11:34 hellofile

 # cat /data/hellofile

	hello netology


## Задача 4


 $ nano Dockerfile

	FROM alpine:3.15

	RUN CARGO_NET_GIT_FETCH_WITH_CLI=1 && \
	    apk --no-cache add \
	        sudo \
	        python3\
	        py3-pip \
	        openssl \
	        ca-certificates \
	        sshpass \
	        openssh-client \
	        rsync \
	        git && \
	    apk --no-cache add --virtual build-dependencies \
	        python3-dev \
	        libffi-dev \
	        musl-dev \
	        gcc \
	        cargo \
	        openssl-dev \
	        libressl-dev \
	        build-base && \
	    pip install --upgrade pip wheel && \
	    pip install --upgrade cryptography cffi && \
	    pip install ansible==2.10.7 && \
	    pip install mitogen ansible-lint jmespath && \
	    pip install --upgrade pywinrm && \
	    apk del build-dependencies && \
	    rm -rf /var/cache/apk/* && \
	    rm -rf /root/.cache/pip && \
	    rm -rf /root/.cargo

	RUN mkdir /ansible && \
	    mkdir -p /etc/ansible && \
	    echo 'localhost' > /etc/ansible/hosts

	WORKDIR /ansible

	CMD [ "ansible-playbook", "--version" ]

 $ docker build -t l1qu1dvacuum/ansible:2.10.7 .

	...
	Successfully tagged l1qu1dvacuum/ansible:2.10.7

 $ docker push l1qu1dvacuum/ansible:2.10.7

 [Ссылка на образ](https://hub.docker.com/r/l1qu1dvacuum/ansible)

