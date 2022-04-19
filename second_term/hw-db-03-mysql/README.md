# devops-netology
Домашние задания по курсу Dev-Ops

------

# Домашнее задание к занятию "6.3. MySQL"


## Задача 1


```yaml
version: '2.1'
services:
  db:
    image: mysql:8.0
    restart: always
    environment:
      MYSQL_DATABASE: test_db
      MYSQL_ROOT_PASSWORD: mysql
    ports:
      - '3306:3306'
    volumes:
      - vol1:/etc/mysql/
volumes:
  vol1:
```

```bash
$ wget https://raw.githubusercontent.com/netology-code/virt-homeworks/master/06-db-03-mysql/test_data/test_dump.sql

$ docker exec -i mysql_db_1 sh -c 'exec mysql -u root --password=mysql test_db' < ./test_dump.sql

$ docker exec -it mysql_db_1 /bin/bash

\# mysql -u root -p test_db --password=mysql

mysql> \s
```
    ...
    Server version:         8.0.28 MySQL Community Server - GPL
    ...

```bash
mysql> SHOW TABLES FROM test_db;

mysql> SELECT COUNT(*) FROM orders WHERE price >300;
```

![SQL_03]()
![SQL_03]()


## Задача 2


```bash
mysql> CREATE USER 'test'@'localhost' IDENTIFIED BY 'test-pass';

mysql> ALTER USER 'test'@'localhost'
    -> IDENTIFIED BY 'test-pass'
    -> WITH
    -> MAX_QUERIES_PER_HOUR 100
    -> PASSWORD EXPIRE INTERVAL 180 DAY
    -> FAILED_LOGIN_ATTEMPTS 3
    -> ATTRIBUTE '{"fname":"James", "lname":"Pretty"}';

mysql> GRANT SELECT ON test_db.orders TO 'test'@'localhost';

mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
```

![SQL_03]()


## Задача 3


```bash
mysql> SET profiling = 1

mysql> SELECT TABLE_NAME,ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc;

mysql> ALTER TABLE orders ENGINE = MyISAM;

mysql> ALTER TABLE orders ENGINE = InnoDB;

mysql> SHOW PROFILES;
```

![SQL_03]()
![SQL_03]()
![SQL_03]()
![SQL_03]()


## Задача 4


```bash
\# cat << EOF >> /etc/mysql/my.cnf

> innodb_flush_log_at_trx_commit=0

> innodb_file_format=Barracuda

> innodb_log_buffer_size=1M

> key_buffer_size=2048M

> max_binlog_size=100M

> EOF

\# cat /etc/mysql/my.cnf
```

![SQL_03]()
