# devops-netology
Домашние задания по курсу Dev-Ops

------

1. Установленно


2. Установленно


3. Выбрал PoverShell

	Проблемы:
		-SSL/TLS ошибок не возникло
		-MobaXterm не использовался
		-Все пути на латинице
		-Hyper-V отключил
		-От WSL2 отказался на время задания
		-Аппаратная виртуализация включена в BIOS
		-Искользую Windows, не актуально


4. Создан базовый файл, запущена Ubuntu.

	-Создан каталог, выполнен `vagrant init`: 

	 	C:\Users\xxxxx\Documents\Education\Vagrant
 	 	Mode                 LastWriteTime         Length Name
	 	----                 -------------         ------ ----
	 	d-----        11.11.2021     15:55                .vagrant
	 	-a----        11.11.2021     15:55             80 Vagrantfile
	
	-Содержимое Varantfile заменено:

 	 	Vagrant.configure("2") do |config|
 			 config.vm.box = "bento/ubuntu-20.04"
  	    end	

	-В дирректории выполнена команда `vagrant up`

	-Поэксперементировал c командами `vagrant suspend` и `vagrant halt`


5. Машине выделено 2 ядра, 64Гб места на диске, 1Гб оперативной памяти, 1Гб Swap, 4Мб видеопамяти.


6. Ознакомился, добавил ресурсов, сделал `vagrant relod`:

		Vagrant.configure("2") do |config|
			config.vm.box = "bento/ubuntu-20.04"
			config.vm.provider "virtualbox" do |v|
				v.memory = 4096
				v.cpus = 4
			end
		end


7. Подключился к машине с помощью `ssh`


8. Ознакомился, почитал.
	-Переменная `HISTFILESIZE`, 846 строка.
	-`export HISTCONTROL=ignoreboth` позволяет не сохранять в историю команда начатые с пробела и дубли команд


9. `{}` используются для записи групповых команд исполняемых в текущей среде shell, 257 строка.


10. `touch file{1..100000}`
	-получится если увеличить обьем стека хотя бы до 32Мб. 


11. `[[ ]]`  возвращает булево значение. В контексте вопроса вероятно наличе/отсутствие дирректории `/tmp`


12. Решение:

	`$ mkdir /tmp/new_path_directory/`
	`$ cp /usr/bin/bash /tmp/new_path_directory/`
	`$ PATH=/tmp/new_path_directory:$PATH`

	    >>> bash is /tmp/new_path_directory/bash
		    bash is /usr/bin/bash
		    bash is /bin/bash


13. `at` - позволяет выполнить команду однократоно в запланированное время
    `batch` - позволяет выполнить команду однократоно при загрузке системы ниже определенного значения


14. `$^D` 
    `$vagrant halt`