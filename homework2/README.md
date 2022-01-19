# devops-netology

# Курсовая работа по итогам модуля "DevOps и системное администрирование"

------

## 1. Создайте виртуальную машину Linux.


 $ vagrant init #Инициализируем Vagrantfile

 Изменил создал базовый Vagrantfile, присвоил статику:

		Vagrant.configure("2") do |config|
			config.vm.box = "bento/ubuntu-20.04"
			config.vm.network "public_network", ip: "192.168.88.202"
			end

 $ vagrant up 
 	
 $ vagrant ssh

 $ sudo su

 Для дальнейшего удобства создал общую дирректорию и смонтировал ее по адресу /media/shared

## 2. Установите ufw и разрешите к этой машине сессии на порты 22 и 443, при этом трафик на интерфейсе localhost (lo) должен ходить свободно на все порты.


 $ apt install ufw -y

 $ ufw status

        Status: inactive

 $ ufw enable

		Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
		Firewall is active and enabled on system startup

 $ ufw default deny incoming

 $ ufw default allow outgoing

 $ ufw allow 22

 $ ufw allow 443

 $ ufw allow from 127.0.0.1 

 $ ufw status

        Status: active

		To                         Action      From
		--                         ------      ----
		22                         ALLOW       Anywhere
		443                        ALLOW       Anywhere
		22 (v6)                    ALLOW       Anywhere (v6)
		443 (v6)                   ALLOW       Anywhere (v6)
		Anywhere                   ALLOW       127.0.0.1


## 3. Установите hashicorp vault.


 $ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

		OK

 $ apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

		...
		Reading package lists... Done

 $ apt-get update && sudo apt-get install vault -y

		...
		Vault TLS key and self-signed certificate have been generated in '/opt/vault/tls'.

	
## 4. Cоздайте центр сертификации по инструкции и выпустите сертификат для использования его в настройке веб-сервера nginx (срок жизни сертификата - месяц).


 $ apt install jq -y

		...
		Processing triggers for libc-bin (2.31-0ubuntu9.2) ...

 $ systemctl enable vault --now

 $ nano /etc/vault.d/vault.hcl

 Раскоментировал доступ к Волту по http:

		# HTTP listener
		listener "tcp" {
		  address = "127.0.0.1:8200"
		  tls_disable = 1
		}

 Закоментировал доступ к Волту по https:

		# HTTPS listener
		#listener "tcp" {
		#  address       = "0.0.0.0:8200"
		#  tls_cert_file = "/opt/vault/tls/tls.crt"
		#  tls_key_file  = "/opt/vault/tls/tls.key"
		#}

 $ systemctl restart vault

 $ export VAULT_ADDR=http://127.0.0.1:8200

 $ nano /etc/environment

 Добавил адрес Волта в системные переменные для восстановления доступа при старте

		VAULT_ADDR=http://127.0.0.1:8200

 $ vault status

		Key                Value
		---                -----
		Seal Type          shamir
		Initialized        true
		Sealed             true
		Total Shares       5
		Threshold          3
		Unseal Progress    0/3
		Unseal Nonce       n/a
		Version            1.9.2
		Storage Type       file
		HA Enabled         false
	
 $ vault operator init

		Unseal Key 1: 7JqCXRPALfaQVahC//e1APE/0Yc5W2Zn5Gs43EN5irZE
		Unseal Key 2: m+YazcQ6JmMFs4Iy3kRLlztHd/3EC2IHVMJQsC6tXFKp
		Unseal Key 3: K15rEGSxsTHfOKxlodlCtxygMdGZeTSw6HkMTVT7fxAK
		Unseal Key 4: 8hpgrFuG9Owj7w5DxRRLWkeKET+E7+K5eUioafT3K/l5
		Unseal Key 5: gzlNC1MEgEEFBcN3hTOFh5+UnvlgUqcVn0eE2v/1cb7Q

		Initial Root Token: s.RC8LjL6O71wVmiuRvtLsEPX2

		Vault initialized with 5 key shares and a key threshold of 3. Please securely
		distribute the key shares printed above. When the Vault is re-sealed,
		restarted, or stopped, you must supply at least 3 of these keys to unseal it
		before it can start servicing requests.

		Vault does not store the generated master key. Without at least 3 keys to
		reconstruct the master key, Vault will remain permanently sealed!

		It is possible to generate new unseal keys, provided you have a quorum of
		existing unseal keys shares. See "vault operator rekey" for more information.

 $ vault operator unseal

 > Unseal Key (will be hidden): 7JqCXRPALfaQVahC//e1APE/0Yc5W2Zn5Gs43EN5irZE

		Unseal Key (will be hidden):
		Key                Value
		---                -----
		Seal Type          shamir
		Initialized        true
		Sealed             true
		Total Shares       5
		Threshold          3
		Unseal Progress    1/3
		Unseal Nonce       2e23ffca-c59b-3fdb-bc6d-f397ef38106a
		Version            1.9.2
		Storage Type       file
		HA Enabled         false

 $ vault operator unseal

 > Unseal Key (will be hidden): m+YazcQ6JmMFs4Iy3kRLlztHd/3EC2IHVMJQsC6tXFKp

		Unseal Key (will be hidden):
		Key                Value
		---                -----
		Seal Type          shamir
		Initialized        true
		Sealed             true
		Total Shares       5
		Threshold          3
		Unseal Progress    2/3
		Unseal Nonce       2e23ffca-c59b-3fdb-bc6d-f397ef38106a
		Version            1.9.2
		Storage Type       file
		HA Enabled         false 

 $ vault operator unseal 
 
 Снимаем третью печать

 > Unseal Key (will be hidden): K15rEGSxsTHfOKxlodlCtxygMdGZeTSw6HkMTVT7fxAK

		Unseal Key (will be hidden):
		Key                Value
		---                -----
		Seal Type          shamir
		Initialized        true
		Sealed             false
		Total Shares       5
		Threshold          3
		Unseal Progress    3/3
		Unseal Nonce       2e23ffca-c59b-3fdb-bc6d-f397ef38106a
		Version            1.9.2
		Storage Type       file
		HA Enabled         false 

 $ vault login #Логинимся в хранилище

		Token (will be hidden): s.RC8LjL6O71wVmiuRvtLsEPX2

		Success! You are now authenticated. The token information displayed below
		is already stored in the token helper. You do NOT need to run "vault login"
		again. Future Vault requests will automatically use this token.

		Key                  Value
		---                  -----
		token                s.RC8LjL6O71wVmiuRvtLsEPX2
		token_accessor       LAegWUxSVcrHobb95UUVj0OL
		token_duration       ∞
		token_renewable      false
		token_policies       ["root"]
		identity_policies    []
		policies             ["root"]

 Создаем корневой сертификат:

 $ vault secrets enable pki

		Success! Enabled the pki secrets engine at: pki/

 $ vault secrets tune -max-lease-ttl=87600h pki

		Success! Tuned the secrets engine at: pki/

 $ vault write -field=certificate pki/root/generate/internal \
     	    
	    common_name="term.paper" \

     	    ttl=87600h > /media/shared/CA_cert.crt

 $ vault write pki/config/urls \

	    issuing_certificates="$VAULT_ADDR/v1/pki/ca" \

	    crl_distribution_points="$VAULT_ADDR/v1/pki/crl"

		Success! Data written to: pki/config/urls

 Создаем промежуточный сертификат:

 $ vault secrets enable -path=pki_int pki
	
		Success! Enabled the pki secrets engine at: pki_int/

 $ vault secrets tune -max-lease-ttl=43800h pki_int

		Success! Tuned the secrets engine at: pki_int/

 $ vault write -format=json pki_int/intermediate/generate/internal \

	     common_name="term.paper Intermediate Authority" \

	     | jq -r '.data.csr' > pki_intermediate.csr

 $ vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \

	     format=pem_bundle ttl="43800h" \

	     | jq -r '.data.certificate' > intermediate.cert.pem

 $ vault write pki_int/intermediate/set-signed \ 

	     certificate=@intermediate.cert.pem

		Success! Data written to: pki_int/intermediate/set-signed

 Создаем роль:

 $ vault write pki_int/roles/term-dot-paper \

	     allowed_domains="term.paper" \

	     allow_subdomains=true \

	     max_ttl="720h"

		Success! Data written to: pki_int/roles/term-dot-paper

 Запрашиваем сертификаты конечного субьекта сразу в необходимую директорию:

 $ vault write -format=json pki_int/issue/term-dot-paper common_name="test.term.paper" ttl="730h" > /etc/ssl/website.crt \

	    cat /etc/ssl/website.crt | jq -r .data.certificate > /etc/ssl/website.pem \
	    cat /etc/ssl/website.crt | jq -r .data.ca_chain[] >> /etc/ssl/website.pem \
	    cat /etc/ssl/website.crt | jq -r .data.private_key > /etc/ssl/website.key


## 5. Установите корневой сертификат созданного центра сертификации в доверенные в хостовой системе.

	Тык

	Тык

	Тык
	

	


## 6. Установите nginx.


 $ apt install nginx -y

 $ systemctl enable nginx

		Synchronizing state of nginx.service with SysV service script with /lib/systemd/systemd-sysv-install.
		Executing: /lib/systemd/systemd-sysv-install enable nginx

 $ systemctl is-enabled nginx

		enabled

 $ service nginx start

 $ service nginx status

		● nginx.service - A high performance web server and a reverse proxy server
		     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
		     Active: active (running) since Tue 2022-01-18 13:38:40 UTC; 44s ago
		       Docs: man:nginx(8)
		   Main PID: 2070 (nginx)
		      Tasks: 3 (limit: 1071)
		     Memory: 5.1M
		     CGroup: /system.slice/nginx.service
		             ├─2070 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
		             ├─2071 nginx: worker process
		             └─2072 nginx: worker process

		Jan 18 13:38:40 vagrant systemd[1]: Starting A high performance web server and a reverse proxy server...
		Jan 18 13:38:40 vagrant systemd[1]: Started A high performance web server and a reverse proxy server.


## 7. По инструкции настройте nginx на https, используя ранее подготовленный сертификат:


 $ nano /etc/nginx/nginx.conf

 Добавил блок:

		...
		server {
		    listen              443 ssl;
		    server_name         test.term.paper;
		    ssl_certificate     /etc/ssl/website.pem;
		    ssl_certificate_key /etc/ssl/website.key;
		    ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
		    ssl_ciphers         HIGH:!aNULL:!MD5;
		}
		...

 $ service nginx reload


## 8. Откройте в браузере на хосте https адрес страницы, которую обслуживает сервер nginx.

 В файл C:\Windows\System32\drivers\etc\hosts добавил строку:

		...
		192.168.88.205  test.term.paper


## 9. Создайте скрипт, который будет генерировать новый сертификат в vault:


 - генерируем новый сертификат так, чтобы не переписывать конфиг nginx;
 - перезапускаем nginx для применения нового сертификата.
 
 $ mkdir /etc/scripts

 $ touch /etc/scripts/reissue.sh

 $ chmod +x /etc/scripts/reissue.sh

 $ nano /etc/scripts/reissue.sh

        ```bash
        #!/usr/bin/env bash

        vault operator unseal 7JqCXRPALfaQVahC//e1APE/0Yc5W2Zn5Gs43EN5irZE > /dev/null 2>&1
        vault operator unseal m+YazcQ6JmMFs4Iy3kRLlztHd/3EC2IHVMJQsC6tXFKp > /dev/null 2>&1
        vault operator unseal K15rEGSxsTHfOKxlodlCtxygMdGZeTSw6HkMTVT7fxAK > /dev/null 2>&1
        vault write -format=json pki_int/issue/term-dot-paper common_name="test.term.paper" ttl="730h" > /etc/ssl/website.crt
        cat /etc/ssl/website.crt | jq -r .data.certificate > /etc/ssl/website.pem
        cat /etc/ssl/website.crt | jq -r .data.ca_chain[] >> /etc/ssl/website.pem
        cat /etc/ssl/website.crt | jq -r .data.private_key > /etc/ssl/website.key
        rm /etc/ssl/website.crt
        systemctl reload nginx
        ```


## 10. Поместите скрипт в crontab, чтобы сертификат обновлялся какого-то числа каждого месяца в удобное для вас время.


 $ crontab -e

 Добавил строку на запуск в 17 минут 01 час каждого 19го числа: 

		17 1 19 * * /etc/scripts/reissue.sh

