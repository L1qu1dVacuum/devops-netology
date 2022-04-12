# devops-netology
Домашние задания по курсу Dev-Ops

------

# Домашнее задание к занятию "6.2. SQL"


## Задача 1


```yaml
version: '2.1'
services:
  db:
    image: postgres:12
    restart: always
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
    ports:
      - '5432:5432'
    volumes:
      - vol1:/var/lib/postgresql/data
      - vol2:/var/lib/postgresql/backup
volumes:
  vol1:
  vol2:
```

![SQL_02]()


## Задача 2


```bash
postgres=\# CREATE DATABASE test_db;

test_db=\# CREATE ROLE "test-admin-user" SUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;

test_db=\# CREATE ROLE "test-simple-user" NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;

test_db=\# CREATE TABLE orders (id INTEGER PRIMARY KEY, name TEXT, price INTEGER);

test_db=\# CREATE TABLE clients (id INTEGER PRIMARY KEY, second_name TEXT, country TEXT, booking INTEGER, FOREIGN KEY (booking) REFERENCES orders (id));

test_db=\# GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.clients TO "test-simple-user";

test_db=\# GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.orders TO "test-simple-user";
```

![SQL_02]()
![SQL_02]()
![SQL_02]()
![SQL_02]()


## Задача 3


```bash
test_db=\# INSERT INTO orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);

test_db=\# INSERT INTO clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');

test_db=\# SELECT COUNT (*) FROM orders;

test_db=\# SELECT COUNT (*) FROM clients;
```

![SQL_02]()
![SQL_02]()


## Задача 4


```bash
test_db=\# UPDATE clients SET booking = 3 WHERE id = 1;

test_db=\# UPDATE clients SET booking = 4 WHERE id = 2;

test_db=\# UPDATE clients SET booking = 5 WHERE id = 3;

test_db=\# SELECT * FROM clients WHERE booking IS NOT NULL;
```

![SQL_02]()


## Задача 5


```bash
test_db=\# EXPLAIN SELECT * FROM clients WHERE booking IS NOT NULL;
```

![SQL_02]()

Было произведено последовательное сканирование таблицы клиентов, показаны затраты времени и ресурсов, и фильтр на основании которого выводились данные.


## Задача 6


```bash
$ docker exec -t postgresql_db_1 pg_dump -U postgres test_db -f /var/lib/postgresql/backup/backup_01.sql

$ docker container stop postgresql_db_1

$ run -d --rm --name postgresql_db_2 -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v vol1:/var/lib/postgresql/data -v vol2:/var/lib/postgresql/backup postgres:12

$ docker exec -i postgresql_db_2 psql -U postgres -d test_db -f /var/lib/postgresql/backup/backup_01.sql
```

![SQL_02]()
