# devops-netology
Домашние задания по курсу Dev-Ops

------

# Домашнее задание к занятию "08.02 Работа с Playbook"


## Задача 1

1. Создать в старой версии playbook файл `requirements.yml` и заполнить его следующим содержимым:

```bash
> $ cat requirements.yml                                                                                     [±main ●●]
---
  - src: git@github.com:netology-code/mnt-homeworks-ansible.git
    scm: git
    version: "1.0.1"
    name: java
```

2. При помощи `ansible-galaxy` скачать себе эту роль. Запустите `molecule test`, посмотрите на вывод команды.

```bash
> $ ansible-galaxy install -r requirements.yml --roles-path ./                                               [±main ●●]
Starting galaxy role install process
- java (1.0.1) is already installed, skipping.
```

```bash
> $ molecule test
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
...
...
TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```

3. Перейдите в каталог с ролью `elastic-role` и создайте сценарий тестирования по умолчаню при помощи `molecule init scenario --driver-name docker`.

```bash
> $ molecule init scenario --driver-name docker                                                              [±main ●●]
INFO     Initializing new scenario default...
INFO     Initialized scenario in /mnt/c/Users/kotov/Documents/Education/Git/devops-netology/second_term/hw-ansible-03-role/src/elastic-role/molecule/molecule/default successfully.
```

4. Добавьте несколько разных дистрибутивов `(centos:8, ubuntu:latest)` для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.

```bash
> $ molecule test                                                                                            [±main ●●]
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
...
...
TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=ubuntu)
changed: [localhost] => (item=instance)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```

5. Создайте новый каталог с ролью при помощи `molecule init role --driver-name docker kibana-role`. Можете использовать другой драйвер, который более удобен вам.

```bash
> $ molecule init role --driver-name docker acme.kibana_role                                                 [±main ●●]
INFO     Initializing new role kibana_role...
No config file found; using defaults
- Role kibana_role was created successfully
Invalid -W option ignored: unknown warning category: 'CryptographyDeprecationWarning'
Invalid -W option ignored: unknown warning category: 'CryptographyDeprecationWarning'
[WARNING]: No inventory was parsed, only implicit localhost is available
localhost | CHANGED => {"backup": "","changed": true,"msg": "line added"}
INFO     Initialized role in /mnt/c/Users/kotov/Documents/Education/Git/devops-netology/second_term/hw-ansible-03-role/src/playbook/kibana_role successfully.
```

6. На основе tasks из старого playbook заполните новую role. Разнесите переменные между vars и default. Проведите тестирование на разных дистрибитивах (centos:7, centos:8, ubuntu).

```bash
> $ molecule test                                                                                            [±main ●●]
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
...
...
TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item=centos7)
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=ubuntu)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```

7. Выложите все roles в репозитории. Проставьте тэги, используя семантическую нумерацию.

  Done

8. Добавьте roles в requirements.yml в playbook.

```yaml
---
- name: Install Java
  hosts: all
  roles:
    - java
    - elastic-role
    - kibana_role
```

9. Переработайте playbook на использование roles.

  Переработал

 ```bash
 > $ ansible-playbook -i inventory/prod.yml site.yml                                                          [±main ●●]

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
[WARNING]: Platform linux on host kibana_host is using the discovered Python interpreter at /usr/bin/python3.10, but
future installation of another Python interpreter could change the meaning of that path. See
https://docs.ansible.com/ansible-core/2.13/reference_appendices/interpreter_discovery.html for more information.
ok: [kibana_host]
[WARNING]: Platform linux on host elastic_host is using the discovered Python interpreter at /usr/bin/python3.10, but
future installation of another Python interpreter could change the meaning of that path. See
https://docs.ansible.com/ansible-core/2.13/reference_appendices/interpreter_discovery.html for more information.
ok: [elastic_host]

TASK [java : Upload .tar.gz file containing binaries from local storage] ***********************************************
skipping: [elastic_host]
skipping: [kibana_host]

TASK [java : Upload .tar.gz file conaining binaries from remote storage] ***********************************************
changed: [kibana_host]
changed: [elastic_host]

TASK [java : Ensure installation dir exists] ***************************************************************************
changed: [kibana_host]
changed: [elastic_host]

TASK [java : Extract java in the installation directory] ***************************************************************
changed: [elastic_host]
changed: [kibana_host]

TASK [java : Export environment variables] *****************************************************************************
changed: [kibana_host]
changed: [elastic_host]

TASK [elastic-role : Upload tar.gz Elasticsearch from remote URL] ******************************************************
changed: [kibana_host]
changed: [elastic_host]

TASK [elastic-role : Create directrory for Elasticsearch] **************************************************************
changed: [elastic_host]
changed: [kibana_host]

TASK [elastic-role : Extract Elasticsearch in the installation directory] **********************************************
changed: [kibana_host]
changed: [elastic_host]

TASK [elastic-role : Set environment Elastic] **************************************************************************
changed: [elastic_host]
changed: [kibana_host]

TASK [kibana_role : Upload tar.gz Kibana from remote URL] **************************************************************
changed: [elastic_host]
changed: [kibana_host]

TASK [kibana_role : Create directrory for Kibana] **********************************************************************
changed: [elastic_host]
changed: [kibana_host]

TASK [kibana_role : Extract Kibana in the installation directory] ******************************************************
changed: [elastic_host]
changed: [kibana_host]

TASK [kibana_role : Set environment Kibana] ****************************************************************************
changed: [elastic_host]
changed: [kibana_host]

PLAY RECAP *************************************************************************************************************
elastic_host               : ok=13   changed=12   unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
kibana_host                : ok=13   changed=12   unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
```

10. Выложите playbook в репозиторий.

  Done

11. В ответ приведите ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.

  Done
