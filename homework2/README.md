# devops-netology
Домашние задания по курсу Dev-Ops

------

1. `$(strace /bin/bash -c 'cd /tmp') &> output.txt`

   `$vi output.txt`
   
   `/\/tmp`

		chdir("/tmp")


2. Попробовал. Команда хранит данные в файле `magic`, поэтому:

   `$(strace file) &> output2.txt`

   `$vi output2.txt`

   `/magic`

		openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3

		openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3


3. `$rm output2.txt`

   `$rm .output2.txt.swp`

   `$pgrep vi`

   `$lsof -p 1001`

		vi      1001 vagrant    4u   REG  253,0    16384 431113 /home/vagrant/.output2.txt.swp (deleted)

   `$echo '' >/proc/1001/fd/4`


4. Зомби не занимают ресурсов, но блокируют место в таблице процессов. 

   Можно попробовать освободить таблицу от процессов зомби перезапустив родительское приложение и ли отправив ему `$kill -s SIGCHLD PPID`.


5. `$sudo /usr/sbin/opensnoop-bpfcc -d5`

		PID    COMM               FD ERR PATH
		815    vminfo              4   0 /var/run/utmp
		551    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
		551    dbus-daemon        18   0 /usr/share/dbus-1/system-services
		551    dbus-daemon        -1   2 /lib/dbus-1/system-services
		551    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/


6. `uname -a` использует системный вызов `uname()`.

   `$sudo apt install manpages-dev`

   `$man 2 uname`

   `/\/proc`
   
		Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.


7. Разница между `;` и `&&` заключается в том, что `;` выполняет команды по порядку вне зависимости от вывода, а `&&` исполняет следующую команду только при успешном выполненни первой.

   `set -e` прерывает цепочку выполнения задач получив вывод отличный от 0, имеем смысл использовать с `;`.


8. `$set --help`

   `-e`  Прерывать исполнение если команда заканчивает с ненулевым статусом.

   `-u`  Выводить ошибку в случае подстановки неверных переменных.

   `-x`  Выводить команды и их аргументы по мере выполнения.

   `-o` Добавить опцию

   `pipefail` выводит как статутс, значение последней выполненной с ненулевым статусом команды, или 0 если все команды отработали успешно.

   Такой вывод сильно повышает информативность исполнения команды на всех этапах и остановит ее при наличии ошибок. 

   Вероятно является полезным инструментом при отладке сложных bash скриптов. 


9. Наиболее часто встречающийся статус у процессов в системе - `Ss` и `R+`.

   Заглавная буква описыает статус процесса (`R` - исполняеимый), строчная используется для указания дополнительной характеристики процесса (`+` - в фоне) либо для BSD-подобного формата вывода.

   