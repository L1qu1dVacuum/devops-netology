# devops-netology
Домашние задания по курсу Dev-Ops

------

1. `$type cd`  cd является интегрированной командой оболочки 


2. альтернатива команде без pipe `$grep -c 2 README.md`, ознакомился


3. `$pstree -p` родителем для всех процессов в виртуальной машине является systemd


4. `$ls 2>/dev/pts/1`


5. `$ls -lha | tee ls.txt | less`


6. -Логин в машину по ssh

    `$tty`
		
        /dev/pts/0

   -Логин в машину физически (или через virtualbox)

    `$tty`

        /dev/tty1

   `$echo 'Hello World' > /dev/tty1`

        Hello World


7. Мы создали файловый дискриптор 5 в который перенаправили stdout, а затем отправили в него echo netology, которая отработала как стандартный вывод.


8. `$bash 5>&1`
	
   `$ls -lhй 2>&1>/proc/$$/fd/5 | cat>output.txt`

   `$nano output.txt`

		ls: invalid option -- 'й'
		Try 'ls --help' for more information.


9. Переменные окружения. 

   `$tail /proc/$$/environ`


10. `/proc/<PID>/cmdline` содержит в себе командную строку для для процесса с одноименным PID.

    `/proc/<PID>/exe` содержит в себе символическую ссылку на исполняемою одноименным процессом команду 


11. `$cat /proc/cpuinfo | grep -om 1 sse...`

           sse ss
           sse3 f
           sse4_1
           sse4_2


12. Ошибка возникает, потому что по умолчанию для ssh сеансов не выделяются сессии псевдотерминала, т.к. удаленный пользователь по умолчанию не является аутентифицированным.
    
    `$ssh -t localhost 'tty'` ключ -t позволяет принудительно назначить сессию псевдотерминала.


13. pts/0:

    `$sudo su`

    `$echo 0 > /proc/sys/kernel/yama/ptrace_scope`

    `$^D`

    `$top`

    `$^C`

    `$bg`

    `$disown top`
	
        -bash: warning: deleting stopped job 2 with process group 1141
		
    pts/1:

    `$reptyr 1141`


14. Команда tee принимает стандартный ввод и производит одновременный стандартный вывод и запись в файл.

    Вероятно команда работает, потому что для перенаправления использует stdin stdout, а не процессы shell'a	 