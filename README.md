# devops-netology
Домашние задания по курсу Dev-Ops

------

# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
##!/usr/bin/env python3

import socket
import time
import json
import yaml

services = {'drive.google.com': ' ', 'mail.google.com': ' ', 'google.com': ' '}

while True:
    temp = []
    for host in services:
        ip = socket.gethostbyname(host)
        if ip == services[host]:
            print(str(host) + '-' + ip)
            temp.append({host:ip})
            with open('dump.json', 'w') as outfile:
                outfile.write(json.dumps(temp, indent=2))
            with open('dump.yaml', 'w') as outfile:
                outfile.write(yaml.dump(temp))
            time.sleep(1)
        elif ip != services[host]:
            print(str('[ERROR]') + str(host) + ' IP mistmatch: ' + services[host] + ' ' + ip)
            time.sleep(1)
            services[host] = ip
    time.sleep(30)
```

### Вывод скрипта при запуске при тестировании:
```
$ sudo python3 web.py

	[ERROR]drive.google.com IP mistmatch:   216.58.210.142
	[ERROR]mail.google.com IP mistmatch:   216.58.210.165
	[ERROR]google.com IP mistmatch:   216.58.209.206
	drive.google.com-216.58.210.142
	mail.google.com-216.58.210.165
	google.com-216.58.209.206
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
	[
	  {
	    "drive.google.com": "216.58.210.142"
	  },
	  {
	    "mail.google.com": "216.58.209.165"
	  },
	  {
	    "google.com": "216.58.209.206"
	  }
	]

```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
	- drive.google.com: 216.58.210.142
	- mail.google.com: 216.58.209.165
	- google.com: 216.58.209.206

```
