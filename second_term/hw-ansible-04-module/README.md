# devops-netology
Домашние задания по курсу Dev-Ops

------

# Домашнее задание к занятию "08.04 Создание собственных modules"


## Задача 1

1. В виртуальном окружении создать новый `my_own_module.py` файл

```bash
(venv) > $ touch my_own_module.py
```

2. Наполнить его содержимым:

  Наполнил

3. Заполните файл в соответствии с требованиями `ansible` так, чтобы он выполнял основную задачу: `module` должен создавать текстовый файл на удалённом хосте по пути, определённом в параметре `path`, с содержимым, определённым в параметре `content`.

  Заполнил

4. Проверьте `module` на исполняемость локально.

```bash
(venv) > $ python -m ansible.modules.my_own_module args.json                                                                                     [±devel ●]

{"changed": true, "original_message": "test successfully passed", "message": "file successfully written", "invocation": {"module_args": {"path": "/tmp/module_output", "content": "test successfully passed"}}}
```

5. Напишите `single task playbook` и используйте `module` в нём.

```bash
> $ cat testmod.yml                                                                                          [±devel ●]
---
  - name: test my own module
    hosts: localhost
    collections:
      - ansible.modules
    tasks:
    - name: run my own module
      my_own_module:
        path: "/tmp/module_output"
        content: "test successfully passed"
      register: testout
    - name: dump test output
      debug:
        msg: '{{ testout }}':
```

```bash
(venv) > $ ansible-playbook ./testmod.yml                                                                                                        [±devel ●]
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the Ansible engine, or trying
out features under development. This is a rapidly changing source of code and can become unstable at any point.
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

PLAY [test my own module] **********************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************************
ok: [localhost]

TASK [run my own module] ***********************************************************************************************************************************
ok: [localhost]

TASK [dump test output] ************************************************************************************************************************************
ok: [localhost] => {
    "msg": {
        "changed": false,
        "failed": false,
        "message": "file already exists",
        "original_message": "test successfully passed"
    }
}

PLAY RECAP *************************************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

6. Проверьте через `playbook` на идемпотентность.

```bash
(venv) > $ ansible-playbook ./testmod.yml                                                                                                        [±devel ●]
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the Ansible engine, or trying
out features under development. This is a rapidly changing source of code and can become unstable at any point.
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

PLAY [test my own module] **********************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************************
ok: [localhost]

TASK [run my own module] ***********************************************************************************************************************************
ok: [localhost]

TASK [dump test output] ************************************************************************************************************************************
ok: [localhost] => {
    "msg": {
        "changed": false,
        "failed": false,
        "message": "file already exists",
        "original_message": "test successfully passed"
    }
}

PLAY RECAP *************************************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

7. Выйдите из виртуального окружения.

```bash
(venv) > $ deactivate
```

8. Инициализируйте новую `collection`: `ansible-galaxy collection init my_own_namespace.my_own_collection`

```bash
> $ pwd                                                                                                      [±main ●●]
/mnt/c/Users/kotov/Documents/Education/Git/devops-netology/second_term/hw-ansible-04-module/src/my_own_namespace/my_own_collection
```

9. В данную `collection` перенесите свой `module` в соответствующую директорию.

```bash
> $ ll plugins/modules                                                                                       [±main ●●]
total 8.0K
-rwxrwxrwx 1 nieles nieles 4.4K Aug  6 16:42 my_own_module.py
```

10. `Single task playbook` преобразуйте в `single task role` и перенесите в `collection`. У `role` должны быть `default` всех параметров `module`

  Преобразовал

11. Создайте `playbook` для использования этой `role`.

  Создал

12. Заполните всю документацию по `collection`, выложите в свой репозиторий, поставьте тег 1.0.0 на этот коммит.

  Сделал

13. Создайте `.tar.gz` этой `collection`: `ansible-galaxy collection build` в корневой директории `collection`.

```bash
> $ ansible-galaxy collection build                                                                         [±master ●]
[WARNING]: Ansible is being run in a world writable directory
(/mnt/c/Users/kotov/Documents/Education/Ansible/8.4/my_own_namespace/my_own_collection), ignoring it as an ansible.cfg
source. For more information see https://docs.ansible.com/ansible/devel/reference_appendices/config.html#cfg-in-world-
writable-dir
Created collection for my_own_namespace.my_own_collection at /mnt/c/Users/kotov/Documents/Education/Ansible/8.4/my_own_namespace/my_own_collection/my_own_namespace-my_own_collection-1.0.0.tar.gz
```

14. Создайте ещё одну директорию любого наименования, перенесите туда `single task playbook` и архив c `collection`.

```bash
> $ ll                                                                                                      [±master ●]
total 8.0K
-rwxrwxrwx 1 nieles nieles 5.1K Aug  7 13:18 my_own_collection.tar.gz
-rwxrwxrwx 1 nieles nieles  135 Aug  6 20:07 site.yml
```

15. Установите `collection` из локального архива: `ansible-galaxy collection install <archivename>.tar.gz`

```bash
> $ ansible-galaxy collection install my_own_namespace-my_own_collection-1.0.0.tar.gz -p ./my_own_collection
Starting galaxy collection install process
[WARNING]: The specified collections path '/mnt/c/Users/kotov/Documents/Education/Ansible/Test2/my_own_collection' is
not part of the configured Ansible collections paths
'/home/nieles/.ansible/collections:/usr/share/ansible/collections'. The installed collection won't be picked up in an
Ansible run.
Process install dependency map
Starting collection install process
Installing 'my_own_namespace.my_own_collection:1.0.0' to '/mnt/c/Users/kotov/Documents/Education/Ansible/Test2/my_own_collection/ansible_collections/my_own_namespace/my_own_collection'
my_own_namespace.my_own_collection:1.0.0 was installed successfully
```

16. Запустите `playbook`, убедитесь, что он работает.

```bash
> $ ansible-playbook -i inventory/test.yml site.yml

PLAY [test my own module] **********************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [myrole : test my own module] *************************************************************************************
ok: [localhost]

PLAY RECAP *************************************************************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

17. В ответ необходимо прислать ссылку на репозиторий с `collection`

[Ссылка](https://github.com/L1qu1dVacuum/my_own_collection)
