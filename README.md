# devops-netology
Домашние задания по курсу Dev-Ops

------

1. Проверил.

	Windows: `$ipconfig /all`

	Linux: `$ip a`


2. Для распознавания соседа по сетевому интерфейсу используется протокол LLDP.

   В Linux есть пакет `lldpd`, и команда `lldpctl`. 

   Если не ошибаюсь, можно еще воспользоваться протоколом ARP и сделать что-то подобное: `$ip -4 neigh`


3. Для разделения L2 коммутатора на несколько виртуальных сетей используется технология VLAN.

   Для этого можно использовать пакет `vlan` и утилиту `vconfig`.

   `$cat /proc/net/vlan/config`

		VLAN Dev name    | VLAN ID
		Name-Type: VLAN_NAME_TYPE_RAW_PLUS_VID_NO_PAD
		eth2.100       | 100  | eth2

   `$cat /etc/network/interfaces`

		...
		auto eth2.100
		iface eth2.100 inet static
        		address 192.168.1.1
        		netmask 255.255.255.0
       			vlan_raw_device eth0


4. Для агрегации сетевых интерфейсов в Linux существует метод LAG. Для балансировки нагрузки автоматически существует протокол LACP, или Port Trunking для мануальной балансировки.

   `$cat /etc/network/interfaces`

		...
		auto bond0
		iface bond0 inet static
		  address 192.168.88.228/24
		  gateway 192.168.88.1
		  bond-slaves wlan0 eth0
		  bond-mode active-backup
		  bond-miimon 100
		  bond-lacp-rate 1 


5. 6 IP адресов. 

   32шт. /29 подсетей можно получить из сети с маской /24.

   `10.10.10.1`

   `10.10.10.7`

   `10.10.10.13`


6. Адрес допустимо взять из CG-NAT подсети.

   `100.64.0.0/26`
   

7. Воспользоваться утилитой arp

  ` $arp -a` Вывести все записи в ARP таблице

   `$arp -d <hostname>` удалить выбранный ip

   `$arp -da` очистить таблицу полностью 

   Если нужно прям совсем очистить таблицу, можно воспользоваться утилитой ip:

   `$sudo ip neig flush all`


8. Задания на lldp, vlan, bonding выполнял на raspberry-pi в процессе выполнения домашнего задания, вывод брал оттуда.

   EVE-ng поставил после по инструкции для проработки темы.


   
   
