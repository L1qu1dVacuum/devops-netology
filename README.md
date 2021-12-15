# devops-netology
Домашние задания по курсу Dev-Ops

------

1. [Установил](https://drive.google.com/file/d/1enVkKmxYwYsEqXMuiIPbFjA1I5yp3IjM/view?usp=sharing), зарегистрировался, [сохранил](https://drive.google.com/file/d/1D4GaleIWBEUooxuvHmY-yhBqc9W1rWrZ/view?usp=sharing).


2. Установил, [настроил](https://drive.google.com/file/d/1iqzdpfNuxetH9_Z3o4iopyLC_7nc6W2d/view?usp=sharing).


3. `$apt install apache2`

   `$a2enmod ssl`

   `$systemctl restart apache2`

   `$openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt`

        ...
        Common Name (e.g. server FQDN or YOUR name) []:192.168.88.233
        ...

   `$nano /etc/apache2/sites-available/default-ssl.conf`

   Вот тут поправил

        ...
        <VirtualHost 192.168.88.233:443>
        ...

   И вот тут

        ...
        SSLCertificateFile /etc/apache2/ssl/apache.crt
        SSLCertificateKeyFile /etc/apache2/ssl/apache.key
        ...

   Закинул рандомный макет сайта

   `$a2ensite default-ssl`

   `$service apache2 reload`

   [https://192.168.88.233/](https://drive.google.com/file/d/1WOI3Q0dCw0remcuFygW_6yEy2Mpp-DBJ/view?usp=sharing)


4. `$git clone --depth 1 https://github.com/drwetter/testssl.sh.git`

   `$cd testssl.sh`

   `$./testssl.sh -p --parallel --sneaky https://www.netology.ru/`

		...
		Testing protocols via sockets except NPN+ALPN 

 		SSLv2      not offered (OK)
 		SSLv3      not offered (OK)
 		TLS 1      offered (deprecated)
 		TLS 1.1    offered (deprecated)
 		TLS 1.2    offered (OK)
 		TLS 1.3    offered (OK): final
 		NPN/SPDY   h2, http/1.1 (advertised)
		ALPN/HTTP2 h2, http/1.1 (offered)
		...

   Вообще как я понял у Нетологии балансировка происходит между 3мя серверами, но вывод везде одинаковый.


5. `$apt install openssh-server`

   `$systemctl start sshd.service`

   `$systemctl enable sshd.service`

   `$ssh-copy-id pi@192.168.88.228`

   `$ssh -i ~/.ssh/id_rsa pi@192.168.88.228`

		...
		pi@raspberrypi:~ $


6. `$mv id_rsa kluchi`

   `$mv id_rsa.pub kluchi.pub   `

   `$touch ~/.ssh/config && chmod 600 ~/.ssh/config`

   `$nano ~/.ssh/config`

		Host raspberrypi
		User pi
		HostName 192.168.88.228
		Port 22
		IdentityFile ~/.ssh/kluchi

   `$ssh raspberrypi`

		pi@raspberrypi:~ $


7. `$sudo tcpdump -i eth0 -s 65535 -c 100 -w capture100` 

   [Открыл](https://drive.google.com/file/d/1fSb8YfrayoZaOWnIzxKD6z3vhYBNbsPa/view?usp=sharing) 


8. `$sudo nmap -sV scanme.nmap.org`

        ...
        PORT      STATE  SERVICE       VERSION
        21/tcp    closed ftp
        22/tcp    open   ssh           OpenSSH 6.6.1p1 Ubuntu 2ubuntu2.13 (Ubuntu Linux; protocol 2.0)
        80/tcp    open   http          Apache httpd 2.4.7 ((Ubuntu))
        81/tcp    closed hosts2-ns
        82/tcp    closed xfer
        135/tcp   closed msrpc
        199/tcp   closed smux
        443/tcp   open   tcpwrapped
        981/tcp   closed unknown
        1875/tcp  closed westell-stats
        2030/tcp  closed device2
        2323/tcp  closed 3d-nfsd
        3260/tcp  closed iscsi
        5060/tcp  open   tcpwrapped
        5900/tcp  closed vnc
        7676/tcp  closed imqbrokerd
        7921/tcp  closed unknown
        8080/tcp  open   tcpwrapped
        8089/tcp  closed unknown
        8701/tcp  closed unknown
        9103/tcp  closed jetdirect
        9666/tcp  closed zoomcp
        16012/tcp closed unknown
        Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
        ...

9. `$apt install ufw`

   `$ufw enable`

   `$ufw default deny incoming`

   `$ufw default allow outgoing`

   `$ufw allow 22 && ufw allow 80 && ufw allow 443`

   `$ufw status verbose`

		Status: active
	    Logging: on (low)
	    efault: deny (incoming), allow (outgoing), deny (routed)
	    New profiles: skip

	    To                         Action      From
	    --                         ------      ----
	    22                         ALLOW IN    Anywhere                  
	    80                         ALLOW IN    Anywhere                  
	    443                        ALLOW IN    Anywhere                  
	    22 (v6)                    ALLOW IN    Anywhere (v6)             
	    80 (v6)                    ALLOW IN    Anywhere (v6)             
	    443 (v6)                   ALLOW IN    Anywhere (v6)    

   
   Ну и пробуем сделать `nmap` с другой машины, получаем:
   
		Nmap scan report for 192.168.88.233
		Host is up (0.024s latency).
		Not shown: 997 filtered ports
		PORT    STATE SERVICE
		22/tcp  open  ssh
		80/tcp  open  http
		443/tcp open  https