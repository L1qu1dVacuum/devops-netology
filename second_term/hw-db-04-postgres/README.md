# devops-netology
Домашние задания по курсу Dev-Ops

------

# Домашнее задание к занятию "6.4. PostgreSQL"


## Задача 1


```yaml
version: '2.1'
services:
  db:
    image: postgres:13
    restart: always
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
    ports:
      - '5432:5432'
    volumes:
      - vol1:/var/lib/postgresql/data
volumes:
  vol1:
```

```bash
$ docker exec -it postgresql2_db_1 /bin/bash

# psql -U postgres

> \?
```

**Найдите и приведите** управляющие команды для:
- вывода списка БД 

    \l

- подключения к БД 

    \c tablename -USER username

- вывода списка таблиц 

    \dt

- вывода описания содержимого таблиц
 
    \d tablename

- выхода из psql

    \q


## Задача 2


```bash
# CREATE DATABASE test_database;

$ wget https://raw.githubusercontent.com/netology-code/virt-homeworks/master/06-db-04-postgresql/test_data/test_dump.sql

$ docker exec -i postgresql2_db_1 psql -U postgres test_database < test_dump.sql

$ docker exec -it postgresql2_db_1 /bin/bash

# psql -U postgres test_database

> \dt

> ANALYZE VERBOSE public.orders;

> SELECT avg_width FROM pg_stats WHERE tablename='orders';
```

![SQL_04](https://github.com/L1qu1dVacuum/devops-netology/blob/main/second_term/hw-db-04-postgres/Images/2022-04-22.png?raw=true)


## Задача 3


```bash
> START TRANSACTION;

> ALTER TABLE orders RENAME TO orders_temp;

> CREATE TABLE orders (id integer, title varchar(80), price integer);

> CREATE TABLE orders_1 ( CHECK ( price > 499 ) ) INHERITS (orders);

> CREATE RULE price_more_499 AS ON INSERT TO orders WHERE ( price > 499 ) DO INSTEAD INSERT INTO orders_1 VALUES (NEW.*);

> CREATE TABLE orders_2 ( CHECK ( price <= 499 ) ) INHERITS (orders);

> CREATE RULE price_less_499 AS ON INSERT TO orders WHERE ( price <= 499 ) DO INSTEAD INSERT INTO orders_2 VALUES (NEW.*);

> INSERT INTO orders (id, title, price) SELECT * FROM orders_temp;

> COMMIT;
```

![SQL_04](https://github.com/L1qu1dVacuum/devops-netology/blob/main/second_term/hw-db-04-postgres/Images/2022-04-22%20(2).png?raw=true)

"Ручное" разбиение можно было изначально исключить при проектировании таблицы orders, проанализировав предполагаемую наполенность price и превентивно применив вышеизложенные правила заполнения.


## Задача 4


```bash
$ docker exec -i postgresql2_db_1 pg_dump -U postgres test_database > test_database_dump.sql
```

Для создания уникальности, значения title можно проиндексировать. 
