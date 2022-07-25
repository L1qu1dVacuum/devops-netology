# devops-netology
Домашние задания по курсу Dev-Ops

------

# Домашнее задание к занятию "08.02 Работа с Playbook"


## Задача 1

1. Приготовьте свой собственный inventory файл `prod.yml`.

```yml
---
elasticsearch:
  hosts:
    elastic_host:
      ansible_connection: docker
kibana:
  hosts:
    kibana_host:
      ansible_connection: docker
```

2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает `kibana`.

```yml
- name: Install Kibana
  hosts: kibana_host
  tasks:
    - name: Upload tar.gz Kibana from remote URL
      get_url:
        url: "https://artifacts.elastic.co/downloads/kibana/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        dest: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        mode: 0755
        timeout: 60
        force: true
        validate_certs: false
      register: get_kibana
      until: get_kibana is succeeded
      tags: kibana
    - name: Create directrory for Kibana
      file:
        state: directory
        path: "{{ kibana_home }}"
      tags: kibana
    - name: Extract Kibana in the installation directory
      become: true
      unarchive:
        copy: false
        src: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        dest: "{{ kibana_home }}"
        extra_opts: [--strip-components=1]
        creates: "{{ kibana_home }}/bin/kibana"
      tags:
        - kibana
    - name: Set environment Kibana
      become: true
      template:
        src: templates/kib.sh.j2
        dest: /etc/profile.d/kib.sh
      tags: kibana
```

3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.

  Использовал

4. Tasks должны: скачать нужной версии дистрибутив, выполнить распаковку в выбранную директорию, сгенерировать конфигурацию с параметрами.

```bash
> $ ansible-playbook site.yml -i inventory/prod.yml                                                          [±main ●●]

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
[WARNING]: Platform linux on host elastic_host is using the discovered Python interpreter at /usr/bin/python3.10, but
future installation of another Python interpreter could change the meaning of that path. See
https://docs.ansible.com/ansible-core/2.13/reference_appendices/interpreter_discovery.html for more information.
ok: [elastic_host]
[WARNING]: Platform linux on host kibana_host is using the discovered Python interpreter at /usr/bin/python3.10, but
future installation of another Python interpreter could change the meaning of that path. See
https://docs.ansible.com/ansible-core/2.13/reference_appendices/interpreter_discovery.html for more information.
ok: [kibana_host]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [elastic_host]
ok: [kibana_host]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
changed: [elastic_host]
changed: [kibana_host]

TASK [Ensure installation dir exists] **********************************************************************************
changed: [elastic_host]
changed: [kibana_host]

TASK [Extract java in the installation directory] **********************************************************************
changed: [elastic_host]
changed: [kibana_host]

TASK [Export environment variables] ************************************************************************************
changed: [elastic_host]
changed: [kibana_host]

PLAY [Install Elasticsearch] *******************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [elastic_host]

TASK [Upload tar.gz Elasticsearch from remote URL] *********************************************************************
changed: [elastic_host]

TASK [Create directrory for Elasticsearch] *****************************************************************************
changed: [elastic_host]

TASK [Extract Elasticsearch in the installation directory] *************************************************************
changed: [elastic_host]

TASK [Set environment Elastic] *****************************************************************************************
changed: [elastic_host]

PLAY [Install Kibana] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [kibana_host]

TASK [Upload tar.gz Kibana from remote URL] ****************************************************************************
changed: [kibana_host]

TASK [Create directrory for Kibana] ************************************************************************************
changed: [kibana_host]

TASK [Extract Kibana in the installation directory] ********************************************************************
changed: [kibana_host]

TASK [Set environment Kibana] ******************************************************************************************
changed: [kibana_host]

PLAY RECAP *************************************************************************************************************
elastic_host               : ok=11   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
kibana_host                : ok=11   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.

```bash
> $ ansible-lint site.yml -vvv                                                                               [±main ●●]
Examining site.yml of type playbook
```

Все отлично

6. Попробуйте запустить playbook на этом окружении с флагом `--check`.

```bash
> $ ansible-playbook site.yml -i inventory/prod.yml --check                                                  [±main ●●]

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
[WARNING]: Platform linux on host elastic_host is using the discovered Python interpreter at /usr/bin/python3.10, but
future installation of another Python interpreter could change the meaning of that path. See
https://docs.ansible.com/ansible-core/2.13/reference_appendices/interpreter_discovery.html for more information.
ok: [elastic_host]
[WARNING]: Platform linux on host kibana_host is using the discovered Python interpreter at /usr/bin/python3.10, but
future installation of another Python interpreter could change the meaning of that path. See
https://docs.ansible.com/ansible-core/2.13/reference_appendices/interpreter_discovery.html for more information.
ok: [kibana_host]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [elastic_host]
ok: [kibana_host]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
changed: [kibana_host]
changed: [elastic_host]

TASK [Ensure installation dir exists] **********************************************************************************
changed: [elastic_host]
changed: [kibana_host]

TASK [Extract java in the installation directory] **********************************************************************
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: NoneType: None
fatal: [elastic_host]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/18.0.2' must be an existing dir"}
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: NoneType: None
fatal: [kibana_host]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/18.0.2' must be an existing dir"}

PLAY RECAP *************************************************************************************************************
elastic_host               : ok=4    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0
kibana_host                : ok=4    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0
```

7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.

```bash
> $ ansible-playbook site.yml -i inventory/prod.yml --diff                                                   [±main ●●]

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

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [elastic_host]
ok: [kibana_host]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
ok: [kibana_host]
ok: [elastic_host]

TASK [Ensure installation dir exists] **********************************************************************************
ok: [elastic_host]
ok: [kibana_host]

TASK [Extract java in the installation directory] **********************************************************************
skipping: [elastic_host]
skipping: [kibana_host]

TASK [Export environment variables] ************************************************************************************
ok: [elastic_host]
ok: [kibana_host]

PLAY [Install Elasticsearch] *******************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [elastic_host]

TASK [Upload tar.gz Elasticsearch from remote URL] *********************************************************************
ok: [elastic_host]

TASK [Create directrory for Elasticsearch] *****************************************************************************
ok: [elastic_host]

TASK [Extract Elasticsearch in the installation directory] *************************************************************
skipping: [elastic_host]

TASK [Set environment Elastic] *****************************************************************************************
ok: [elastic_host]

PLAY [Install Kibana] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [kibana_host]

TASK [Upload tar.gz Kibana from remote URL] ****************************************************************************
changed: [kibana_host]

TASK [Create directrory for Kibana] ************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/kibana/8.3.2",
-    "state": "absent"
+    "state": "directory"
 }

changed: [kibana_host]

TASK [Extract Kibana in the installation directory] ********************************************************************
changed: [kibana_host]

TASK [Set environment Kibana] ******************************************************************************************
--- before
+++ after: /home/nieles/.ansible/tmp/ansible-local-16171uim_235j/tmp6dpd4ttj/kib.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export ES_HOME=/opt/kibana/8.3.2
+export PATH=$PATH:$ES_HOME/bin
\ No newline at end of file

changed: [kibana_host]

PLAY RECAP *************************************************************************************************************
elastic_host               : ok=9    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
kibana_host                : ok=10   changed=4    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
```

8. Повторно запустите playbook с флагом --diff и убедитесь, что playbook идемпотентен.

```bash
> $ ansible-playbook site.yml -i inventory/prod.yml --diff                                                   [±main ●●]

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
[WARNING]: Platform linux on host elastic_host is using the discovered Python interpreter at /usr/bin/python3.10, but
future installation of another Python interpreter could change the meaning of that path. See
https://docs.ansible.com/ansible-core/2.13/reference_appendices/interpreter_discovery.html for more information.
ok: [elastic_host]
[WARNING]: Platform linux on host kibana_host is using the discovered Python interpreter at /usr/bin/python3.10, but
future installation of another Python interpreter could change the meaning of that path. See
https://docs.ansible.com/ansible-core/2.13/reference_appendices/interpreter_discovery.html for more information.
ok: [kibana_host]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [elastic_host]
ok: [kibana_host]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
ok: [elastic_host]
ok: [kibana_host]

TASK [Ensure installation dir exists] **********************************************************************************
ok: [elastic_host]
ok: [kibana_host]

TASK [Extract java in the installation directory] **********************************************************************
skipping: [elastic_host]
skipping: [kibana_host]

TASK [Export environment variables] ************************************************************************************
ok: [elastic_host]
ok: [kibana_host]

PLAY [Install Elasticsearch] *******************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [elastic_host]

TASK [Upload tar.gz Elasticsearch from remote URL] *********************************************************************
ok: [elastic_host]

TASK [Create directrory for Elasticsearch] *****************************************************************************
ok: [elastic_host]

TASK [Extract Elasticsearch in the installation directory] *************************************************************
skipping: [elastic_host]

TASK [Set environment Elastic] *****************************************************************************************
ok: [elastic_host]

PLAY [Install Kibana] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [kibana_host]

TASK [Upload tar.gz Kibana from remote URL] ****************************************************************************
ok: [kibana_host]

TASK [Create directrory for Kibana] ************************************************************************************
ok: [kibana_host]

TASK [Extract Kibana in the installation directory] ********************************************************************
skipping: [kibana_host]

TASK [Set environment Kibana] ******************************************************************************************
ok: [kibana_host]

PLAY RECAP *************************************************************************************************************
elastic_host               : ok=9    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
kibana_host                : ok=9    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
```

9. Подготовьте `README.md` файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.

  Done

10. Готовый playbook выложите в свой репозиторий, в ответ предоставьте ссылку на него.

  Done
