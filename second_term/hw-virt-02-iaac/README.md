# devops-netology
Домашние задания по курсу Dev-Ops

------

# Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"


## Задача 1


 - Опишите своими словами основные преимущества применения на практике IaaC паттернов.

   Основные преимущества IaaC это упрощение и ускорение и автоматизация предоставления разработчикам инфраструктуры. 
   
   Стабильность, безопасность и воспроизводимость сред разработки, тестирования и деплоя. 

   Возможность непрерывной поставки продукта отвечающего пожеланиям клиента/заказчика. 

 - Какой из принципов IaaC является основополагающим?

   Идемпотентность - является основопологающим принципом IaaC, так как подразумевает под собой воспроизводимость всех паттеронов при любом количестве повторных выполнений. 


## Задача 2


 - Чем Ansible выгодно отличается от других систем управление конфигурациями?

   Тем, что не требует доустановки специфического окружения для работы и функционирует через существующие ssh подключения.

 - Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

   Каждый тип подхода может быть эффективным в рамках разной инфрастуктуры и кол-ва серверов. 

   Для среднего парка серверов с большой вероятностью человеческого вмешательства лучше подойдет метод push. 

   Для гигантского парка однообразного оборудования выполенющего типовые задачи и требующего регулярного обновления конфигураций, вероятно метод pull. 


## Задача 3


 Установить на личный компьютер:

 VirtualBox

	```console
	**nieles@debian:~$** VBoxManage -v
	6.1.26r145957
	```

 Vagrant

	```console
	**nieles@debian:~$** vagrant -v
	Vagrant 2.2.19
	```
	
 Ansible

	```console
	**nieles@debian:~$** ansible --version
	ansible [core 2.12.2]
	  config file = None
	  configured module search path = ['/home/nieles/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
	  ansible python module location = /usr/local/lib/python3.9/dist-packages/ansible
	  ansible collection location = /home/nieles/.ansible/collections:/usr/share/ansible/collections
	  executable location = /usr/local/bin/ansible
	  python version = 3.9.2 (default, Feb 28 2021, 17:03:44) [GCC 10.2.1 20210110]
	  jinja version = 3.0.3
	  libyaml = True
	```


## Задача 4


```bash
	nieles@debian:~/education/vagrant$ vagrant ssh
	Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)

	 * Documentation:  https://help.ubuntu.com
	 * Management:     https://landscape.canonical.com
	 * Support:        https://ubuntu.com/advantage

	 System information disabled due to load higher than 1.0


	This system is built by the Bento project by Chef Software
	More information can be found at https://github.com/chef/bento
	Last login: Tue Feb  1 15:22:36 2022 from 10.0.2.2
	**vagrant@server1:~$** docker ps
	CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
