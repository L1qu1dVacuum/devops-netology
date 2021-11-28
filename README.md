# devops-netology
Домашние задания по курсу Dev-Ops

------

1. Установил node_exporter. Из-за ошибки пришлось пробросить программе порт 9100 в Vagrantfile.
   
   Переместил файл по адресу `/usr/local/bin`

   Создал unit-файл в `/etc/systemd/system/node_exporter.service`

   		[Unit]  
   		Description=Node Exporter  
  
   		[Service]  
   		EnvironmentFile=-/etc/sysconfig/node_exporter  
   		ExecStart=/usr/local/bin/node_exporter $OPTIONS  
  
   		[Install]  
   		WantedBy=multi-user.target

   Добавил node_exporter в автозагрузку:

    `$sudo systemctl daemon-reload`

    `$sudo systemctl enable --now node_exporter`

   Соответсвенно по аналогии с cron к запускаемому процессу через node_export.service можно добавить опции.

   	Например выделить отдельных User и Group, или добавить Restart=on-failure, или что-либо по потребностям. 

   Проверил, что что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.  

    `$ps -e | grep node_exporter` 

		627 ?        00:00:00 node_exporter

	`$systemctl stop node_exporter`

		==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
		Authentication is required to stop 'node_exporter.service'.
		Authenticating as: vagrant,,, (vagrant)
		Password:
	
	`$ps -e | grep node_exporter` 

		ничего

	`$systemctl start node_exporter`

		==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
		Authentication is required to start 'node_exporter.service'.
		Authenticating as: vagrant,,, (vagrant)
		Password:

	`$ps -e | grep node_exporter`

		1233 ?        00:00:00 node_exporter

	`$sudo reboot`

	`$ps -e | grep node_exporter`

		614 ?        00:00:00 node_exporter


2. `$curl http://localhost:9100/metrics | grep "node_cpu_seconds_total" | cat > metrics.cpu.txt`

   `$curl http://localhost:9100/metrics | grep "node_memory_Mem" | cat > metrics.memory.txt`

   `$curl http://localhost:9100/metrics | grep -P 'node_disk_io|node_disk_read|node_disk_write' | cat > metrics.disk.txt`

   `$curl http://localhost:9100/metrics | grep -P 'network_receive_packets|network_transmit_packets|dropped_total' | cat > metrics.network.txt`


3. Netdata установил.

   Кофигурационный файл netdata.conf изменил.

   Порт в Vagrantfile пробросил.

   ВМ перезагрузил. 

   Зашел с машины-хоста по localhost:19999, попал в вебинтерфейс Netdata (красивое...).


4. `$dmesg |grep virtual`

		[    0.003491] CPU MTRRs all blank - virtualized system.
		[    0.054361] Booting paravirtualized kernel on KVM
		[    6.087474] systemd[1]: Detected virtualization oracle.

   Да, понять можно. Да, в даннмом конкретном случае система осознает что виртуализирована.


5. `$sysctl -n fs.nr_open`

		1048576

   Это лимит на кол-во открытых дискрипторов.

   `$ulimit -Sn`

		1024

   По умолчанию софт лимит на кол-во открытых дискрипторов не позволит достичь такого числа.


6. `$sudo unshare -fp --mount-proc sleep 1h`

   `$^Z`

   `$ps -e | grep sleep`

        1321 pts/0    00:00:00 sleep

   `$sudo nsenter -t $1321 -m -p`

   `$ps`

        PID TTY          TIME CMD
         1 pts/0    00:00:00 sleep
         2 pts/0    00:00:00 bash
        11 pts/0    00:00:00 ps

	
7. Команда `$:(){ :|:& };:` по сути является простой разновидностью форкбомбы. 

        310.512344] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-5.scope

   По умолчанию когда кол-во форков процесса достигает 7925шт. (в моем случае) стабатывет ограничение кол-ва PIDов для текущего пользователя. 

   Если изменить `ulimit -u` до небольшого значения (100 например), то отсечка сработает раньше.  