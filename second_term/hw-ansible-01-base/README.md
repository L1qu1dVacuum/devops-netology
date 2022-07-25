# devops-netology
Домашние задания по курсу Dev-Ops

------

# Домашнее задание к занятию "08.01 Введение в Ansible"


## Задача 1

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте какое значение имеет факт `some_fact` для указанного хоста при выполнении playbook'a.

```bash
$ ansible-playbook site.yml -i inventory/test.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Print OS] ********************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP *************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

`some_fact` имеет значение `12`

2. Найдите файл с переменными `group_vars` в котором задаётся найденное в первом пункте значение и поменяйте его на ``'all default fact'``.

```yaml
---
  some_fact: all default fact
```

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.

```bash
> $ docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED              STATUS              PORTS     NAMES
3697c9cc555d   ubuntu    "/bin/bash"   About a minute ago   Up About a minute             ubuntu
7ffbacb37904   centos    "/bin/bash"   52 minutes ago       Up 52 minutes                 centos7
```

4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.

```bash
...
redirecting (type: connection) ansible.builtin.docker to community.docker.docker
ok: [centos7] => {
    "msg": "el"
}
redirecting (type: connection) ansible.builtin.docker to community.docker.docker
ok: [ubuntu] => {
    "msg": "deb"
}
...
```

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились следующие значения: для `deb` - ``'deb default fact'``, для `el` - ``'el default fact'``.

```bash
> $ cat ./group_vars/deb/examp.yml                                                                           [±main ●●]
---
  some_fact: "deb default fact"

> $ cat ./group_vars/el/examp.yml                                                                            [±main ●●]
---
  some_fact: "el default fact"
```

6. Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

```bash
...
redirecting (type: connection) ansible.builtin.docker to community.docker.docker
ok: [centos7] => {
    "msg": "el default fact"
}
redirecting (type: connection) ansible.builtin.docker to community.docker.docker
ok: [ubuntu] => {
    "msg": "deb default fact"
}
...
```

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем netology.

```bash
> $ ansible-vault encrypt group_vars/deb/examp.yml                                                           [±main ●●]
New Vault password:
Confirm New Vault password:
Encryption successful

> $ ansible-vault encrypt group_vars/el/examp.yml                                                            [±main ●●]
New Vault password:
Confirm New Vault password:
Encryption successful
```

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

```bash
> $ ansible-playbook site.yml -i inventory/prod.yml --ask-vault-pass                                         [±main ●●]
Vault password:

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ********************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

```bash
ansible-doc --list
...
```

Подходящим для работы на `control node` является плагин `ansible.builtin.local`

10. В `prod.yml` добавьте новую группу хостов с именем `local`, в ней разместите `localhost` с необходимым типом подключения.

```bash
> $ cat ./inventory/prod.yml                                                                                                                     [±main ●●]
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  my:
    hosts:
      localhost:
        ansible_connection: local
```

11. Запустите `playbook` на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь что факты `some_fact` для каждого из хостов определены из верных `group_vars`.

```bash
> $ ansible-playbook site.yml -i inventory/prod.yml --ask-vault-pass                                                                             [±main ●●]
Vault password:

PLAY [Print os facts] **************************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]
ok: [localhost]

TASK [Print OS] ********************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "my default fact"
}

PLAY RECAP *************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

Соответственно если не специфицировать `group_vars` для `localhost` он попадет в категорию `all`.

12. Done
