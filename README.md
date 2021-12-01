# devops-netology
Домашние задания по курсу Dev-Ops

------

1. `$telnet stackoverflow.com 80`

	GET /questions HTTP/1.0
	HOST: stackoverflow.com

		HTTP/1.1 301 Moved Permanently
		cache-control: no-cache, no-store, must-revalidate
		location: https://stackoverflow.com/questions
		x-request-guid: 51dd2d93-8f3c-4472-a7b3-166df28bcd94
		feature-policy: microphone 'none'; speaker 'none'
		content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
		Accept-Ranges: bytes
		Date: Wed, 01 Dec 2021 10:23:38 GMT
		Via: 1.1 varnish
		Connection: close
		X-Served-By: cache-bma1676-BMA
		X-Cache: MISS
		X-Cache-Hits: 0
		X-Timer: S1638354219.828623,VS0,VE101
		Vary: Fastly-SSL
		X-DNS-Prefetch-Control: off
		Set-Cookie: prov=93b49433-0823-645a-89d5-e8d636e907a6; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly

   Ошибка 301 - это код состояния HTTP, сообщающий, что страница, к которой клиент обращается, перемещена по новому адресу и старый адрес следует считать устаревшим. 


2. Сделал, полученный код - `Status Code: 200` 

   Время загрузки страницы 367ms.

   Дольше всего выполнялся запрос скрипта beacon.js - 94ms.

   [Скриншот](https://drive.google.com/file/d/1SzKhxpROnEr7HZGXOFchatD_aWphwwPk/view?usp=sharing)

3. Мой IP адрес 89.113.46.95

4. `$sudo whois 89.113.46.95`

        ...
        descr:          PJSC VimpelCom
        origin:         AS3216
        ...

   Провайдер ВымпелКом, автономная система - 3216.


5. `$traceroute -AIn 8.8.8.8`

		 traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 		 1  192.168.88.1 [*]  1.602 ms  5.913 ms  8.083 ms
 		 2  100.126.0.1 [*]  8.465 ms  9.108 ms  9.203 ms
 		 3  * * *
 		 4  85.21.225.13 [AS8402]  15.471 ms  16.444 ms  16.443 ms
 		 5  * * *
 		 6  72.14.198.182 [AS15169]  16.300 ms  13.548 ms  19.509 ms
 		 7  172.253.68.13 [AS15169]  19.721 ms  20.056 ms  20.328 ms
 		 8  108.170.250.113 [AS15169]  20.462 ms  20.602 ms  33.349 ms
 		 9  142.251.49.158 [AS15169]  33.973 ms * *
		10  216.239.43.20 [AS15169]  34.177 ms  34.446 ms  34.586 ms
		11  142.250.56.127 [AS15169]  37.946 ms  38.408 ms  38.094 ms
		12  * * *
		13  * * *
		14  * * *
		15  * * *
		16  * * *
		17  * * *
		18  * * *
		19  * * *
		20  * * *
		21  8.8.8.8 [AS15169]  72.242 ms  72.025 ms  72.300 ms

   Пакет проходит через NAT-сеть провайдера, сеть Карбины привязанные к [AS8402] и далее через цепочку сетей Googl'а привязанных к [AS15169]. 


6. `$mtr -zn 8.8.8.8`
                                                                               Packets               Pings
 		Host                                                                        Loss%   Snt   Last   Avg  Best  Wrst StDev
		...
		6. AS15169  72.14.198.182                                                    0.0%    35   15.0  18.6  10.4  93.8  14.1
		...

   Вот на этом участке наибольшая задержка.


7. `$dig dns.google +noall +answer`

		dns.google.             1567    IN      A       8.8.8.8
		dns.google.             1567    IN      A       8.8.4.4


8. `$dig -x 8.8.8.8 +noall +answer`

		8.8.8.8.in-addr.arpa.   12190   IN      PTR     dns.google.

   `$dig -x 8.8.4.4 +noall +answer`

		4.4.8.8.in-addr.arpa.   37139   IN      PTR     dns.google.