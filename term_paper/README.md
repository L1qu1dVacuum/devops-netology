# devops-netology

# Курсовая работа по итогам модуля "DevOps и системное администрирование"

------

## 1. Создайте виртуальную машину Linux.


 `$ vagrant init` 

 Создал базовый Vagrantfile, присвоил статический адрес:

    Vagrant.configure("2") do |config|
        config.vm.box = "bento/ubuntu-20.04"
        config.vm.network "public_network", ip: "192.168.88.202"
        end

 `$ vagrant up` 
 	
 `$ vagrant ssh`
 
  В идеале стоит наверное создать для Voult и Nginx отдельных пользователей со своими правами, но так как требований по этому вопросу небыло, будем для простоты работать из-под суперюзера:

 `$ sudo su`

 Для дальнейшего удобства создал общую директорию и смонтировал ее по адресу /media/shared


## 2. Установите ufw и разрешите к этой машине сессии на порты 22 и 443, при этом трафик на интерфейсе localhost (lo) должен ходить свободно на все порты.


 `$ apt install ufw -y`
 
  По умолчанию как оказывается ufw уже поставляется с ubuntu 20.04 но не активен.

 `$ ufw status`

    Status: inactive

 `$ ufw enable`

    Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
    Firewall is active and enabled on system startup

 По умолчанию запрещаем входящий трафик по всем портам:

 `$ ufw default deny incoming`

 И разрешаем исходищий:

`$ ufw default allow outgoing`

 Открываем порты 22 и 433:

 `$ ufw allow 22`

 `$ ufw allow 443`
 
 Разрешаем трафик по всем портам на локалхосте:

 `$ ufw allow from 127.0.0.1` 
 
 Проверяем что получилось:

 `$ ufw status`

    Status: active

    To                         Action      From
    --                         ------      ----
    22                         ALLOW       Anywhere
    443                        ALLOW       Anywhere
    22 (v6)                    ALLOW       Anywhere (v6)
    443 (v6)                   ALLOW       Anywhere (v6)
    Anywhere                   ALLOW       127.0.0.1


## 3. Установите hashicorp vault.

 Подключаем официальный репозиторий:

 `$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -`

    OK

 `$ apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"`

    ...
    Reading package lists... Done
 
  Устанавливаем Vault:

 `$ apt-get update && sudo apt-get install vault -y`

    ...
    Vault TLS key and self-signed certificate have been generated in '/opt/vault/tls'.

	
## 4. Cоздайте центр сертификации по инструкции и выпустите сертификат для использования его в настройке веб-сервера nginx (срок жизни сертификата - месяц).


 Для начала устанавливаем JSON процессор jq, он понадобится позднее.

 `$ apt install jq -y`

    ...
    Processing triggers for libc-bin (2.31-0ubuntu9.2) ...

 Разрешаем Vault'y автоматический запуск:

 `$ systemctl enable vault --now`
 
 Изменям конфиг чтобы иметь возможность подключиться по http не создавая сертификатов.

 `$ nano /etc/vault.d/vault.hcl`

 Раскоментировал доступ по http:

    # HTTP listener
    listener "tcp" {
      address = "127.0.0.1:8200"
      tls_disable = 1
    }

 Закоментировал доступ по https:

    # HTTPS listener
    #listener "tcp" {
    #  address       = "0.0.0.0:8200"
    #  tls_cert_file = "/opt/vault/tls/tls.crt"
    #  tls_key_file  = "/opt/vault/tls/tls.key"
    #}

  Добвляем переменную среды с адресом Vault'а, чтобы иметь возможность подключиться.
 
 `$ export VAULT_ADDR=http://127.0.0.1:8200`

 `$ systemctl restart vault`

  Добавил адрес Волта в системные переменные для восстановления доступа при старте системы:
 
 `$ nano /etc/environment`

    VAULT_ADDR=http://127.0.0.1:8200

 `$ vault status`

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
	
 Выполняем инициализацию отператора, чтобы получить ключи от печати и root-токен:	
	
 `$ vault operator init`

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

 Снимаем первую печать:

 `$ vault operator unseal`

 `> Unseal Key (will be hidden): 7JqCXRPALfaQVahC//e1APE/0Yc5W2Zn5Gs43EN5irZE`

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

 Снимаем вторую печать:

 `$ vault operator unseal`

 `> Unseal Key (will be hidden): m+YazcQ6JmMFs4Iy3kRLlztHd/3EC2IHVMJQsC6tXFKp`

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

 Снимаем третью печать:

 `$ vault operator unseal` 

 `> Unseal Key (will be hidden): K15rEGSxsTHfOKxlodlCtxygMdGZeTSw6HkMTVT7fxAK`

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

 Логинимся в хранилище:

 `$ vault login`

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

 Включаем secrets-engine:
 
 `$ vault secrets enable pki`

    Success! Enabled the pki secrets engine at: pki/
    
 Устанавливаем ttl сертификата:

 `$ vault secrets tune -max-lease-ttl=87600h pki`

    Success! Tuned the secrets engine at: pki/
    
 Генерируем и сохраняем сертификат стразу в общую директорию:

 `$ vault write -field=certificate pki/root/generate/internal \`
     	    
 `> common_name="term.paper" \`

 `> ttl=87600h > /media/shared/CA_cert.crt`
    
 Создаем пути для невалидных сертификатов и точек дистрибуции:

 `$ vault write pki/config/urls \`

 `> issuing_certificates="$VAULT_ADDR/v1/pki/ca" \`

 `> crl_distribution_points="$VAULT_ADDR/v1/pki/crl"`

    Success! Data written to: pki/config/urls

 Создаем промежуточный сертификат:

 `$ vault secrets enable -path=pki_int pki`
	
    Success! Enabled the pki secrets engine at: pki_int/

 `$ vault secrets tune -max-lease-ttl=43800h pki_int`

    Success! Tuned the secrets engine at: pki_int/

 `$ vault write -format=json pki_int/intermediate/generate/internal \`

 `> common_name="term.paper Intermediate Authority" \`

 `> | jq -r '.data.csr' > pki_intermediate.csr`

 `$ vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \`

 `> format=pem_bundle ttl="43800h" \`

 `> | jq -r '.data.certificate' > intermediate.cert.pem`

 `$ vault write pki_int/intermediate/set-signed \` 

 `> certificate=@intermediate.cert.pem`

    Success! Data written to: pki_int/intermediate/set-signed

 Создаем роль:

 `$ vault write pki_int/roles/term-dot-paper \`

 `> allowed_domains="term.paper" \`

 `> allow_subdomains=true \`

 `> max_ttl="720h"`

    Success! Data written to: pki_int/roles/term-dot-paper

 Запрашиваем сертификат конечного субьекта сразу в необходимую директорию и бьем его на необходимые Nginx'y pem и key:

 `$ vault write -format=json pki_int/issue/term-dot-paper common_name="test.term.paper" ttl="730h" > /etc/ssl/website.crt \`

 `> cat /etc/ssl/website.crt | jq -r .data.certificate > /etc/ssl/website.pem \`
 
 `> cat /etc/ssl/website.crt | jq -r .data.ca_chain[] >> /etc/ssl/website.pem \`
 
 `> cat /etc/ssl/website.crt | jq -r .data.private_key > /etc/ssl/website.key`


## 5. Установите корневой сертификат созданного центра сертификации в доверенные в хостовой системе.


 Из ранее соданной общей папки забираем корневой сертификат.

![CA install 01](https://github.com/L1qu1dVacuum/devops-netology/blob/main/term_paper/Images/%D0%9A%D0%BE%D1%80%D0%BD%D0%B5%D0%B2%D0%BE%D0%B9_01.png)
 
 Тут он у выглядит уже принятым, потому что я прошел этот путь перед тем как все задокументировать. 

![CA install 02](https://github.com/L1qu1dVacuum/devops-netology/blob/main/term_paper/Images/%D0%9A%D0%BE%D1%80%D0%BD%D0%B5%D0%B2%D0%BE%D0%B9_02.png)

 На локальный компьютер
	
![CA install 03](https://github.com/L1qu1dVacuum/devops-netology/blob/main/term_paper/Images/%D0%9A%D0%BE%D1%80%D0%BD%D0%B5%D0%B2%D0%BE%D0%B9_03.png)

 Помещаем в доверенные корневые центры сертификации

![CA install 04](https://github.com/L1qu1dVacuum/devops-netology/blob/main/term_paper/Images/%D0%9A%D0%BE%D1%80%D0%BD%D0%B5%D0%B2%D0%BE%D0%B9_04.png)

 Все готово

![CA install 05](https://github.com/L1qu1dVacuum/devops-netology/blob/main/term_paper/Images/%D0%9A%D0%BE%D1%80%D0%BD%D0%B5%D0%B2%D0%BE%D0%B9_05.png)


## 6. Установите nginx.


 Устанавливаем 	Nginx и разрешаем ему автоматический запуск:

 `$ apt install nginx -y`

 `$ systemctl enable nginx`

    Synchronizing state of nginx.service with SysV service script with /lib/systemd/systemd-sysv-install.
    Executing: /lib/systemd/systemd-sysv-install enable nginx

 Проверяем работает ли служба, запускаем сервер и проверяем его статус:
 
 `$ systemctl is-enabled nginx`

    enabled

 `$ service nginx start`

 `$ service nginx status`

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

 Все отлично


## 7. По инструкции настройте nginx на https, используя ранее подготовленный сертификат:


 Добавляем блок с информацией о том какие порты слушать, имени сервера, откуда забирать сертификатыо, протоколах и типах шифрования в .config файл nginx:

 `$ nano /etc/nginx/nginx.conf`

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

 Делаем обновление конфигруции без перезагрузки.

 `$ service nginx reload`
 

## 8. Откройте в браузере на хосте https адрес страницы, которую обслуживает сервер nginx.


 В файл C:\Windows\System32\drivers\etc\hosts добавил строку:

    ...
    192.168.88.205  test.term.paper
    
 Открываем Chrome, заходим на test.term.paper, подключение безопасное, сертификат действительный.
    
![Https proof 01](https://github.com/L1qu1dVacuum/devops-netology/blob/main/term_paper/Images/https_01.png)

 Все черезвычайно безопасно.

![Https proof 02](https://github.com/L1qu1dVacuum/devops-netology/blob/main/term_paper/Images/https_02.png)
![Https proof 03](https://github.com/L1qu1dVacuum/devops-netology/blob/main/term_paper/Images/https_03.png)

 По сертификату видно что он выдан 18.01.22 сроком на месяц.

![CA proof 01](https://github.com/L1qu1dVacuum/devops-netology/blob/main/term_paper/Images/%D0%A1%D0%B5%D1%80%D1%82%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%82%20%D1%81%D1%80%D0%BE%D0%BA.png)

 Цепь из трех сертификатов выстроилась правильная, прямо как в инструкции HashiCorp. 

![CA proof 02](https://github.com/L1qu1dVacuum/devops-netology/blob/main/term_paper/Images/%D0%A1%D0%B5%D1%80%D1%82%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%82%20%D1%86%D0%B5%D0%BF%D0%BE%D1%87%D0%BA%D0%B0.png)


## 9. Создайте скрипт, который будет генерировать новый сертификат в vault:


 - генерируем новый сертификат так, чтобы не переписывать конфиг nginx;
 - перезапускаем nginx для применения нового сертификата.

 Создаем файл, делаем его исполняемым. 
 
 `$ mkdir /etc/scripts`

 `$ touch /etc/scripts/reissue.sh`

 `$ chmod +x /etc/scripts/reissue.sh`
 
 Так как автоматически распечатывать хранилище не безопасно, то эта процедура будет проводиться в ручном режиме.

 Пишем скрипт который проверяет хралилище на распечатанность, генерирует сертификаты и обновляет конфигурацию nginx.
 
 `$ nano /etc/scripts/reissue.sh`

```bash
#!/usr/bin/env bash

#export VAULT_ADDR=http://127.0.0.1:8200

#export VAULT_TOKEN=$(cat /root/.vault-token)

crt_war="/etc/ssl/website.crt"

vault status &> /dev/null
    if [[ ! $? == "0" ]]
    then
        echo "VaultSealManager-[$(date +'%X %x')]-[ERROR]: Local Vault is sealed." | tee -a /root/vault.log
        exit 1
    else
        vault write -format=json pki_int/issue/term-dot-paper common_name="test.term.paper" ttl="730h" > $crt_war
        cat $crt_war | jq -r .data.certificate > /etc/ssl/website.pem
        cat $crt_war | jq -r .data.ca_chain[] >> /etc/ssl/website.pem
        cat $crt_war | jq -r .data.private_key > /etc/ssl/website.key
        rm $crt_war
        systemctl reload nginx
        exit 0
    fi
```

 В случае если хранилище оказывается запечатанным скрипт выдаст в stdout сообщение следующего содержания:

    VaultSealManager-[09:37:01 PM 01/24/2022]-[ERROR]: Local Vault is sealed.

 А так же продублирует его файл vault.log c сохранением хронолонии неудачных попыток.


## 10. Поместите скрипт в crontab, чтобы сертификат обновлялся какого-то числа каждого месяца в удобное для вас время.


 Добавил строку на запуск в 17 минут 01 час каждого 19го числа, и проверяем что получилось: 

 `$ crontab -e`

    17 1 19 * * /etc/scripts/reissue.sh
    
 `$ crontab -l` 
 
    17 1 19 * * /etc/scripts/reissue.sh 
    
 По выведеному времени видно, что скрипт отработал и директория пополнилась сертификатами.
    
![Cron working](https://github.com/L1qu1dVacuum/devops-netology/blob/main/term_paper/Images/Cron.png)

 Открываем Chrome, обновляем страницу, подключение безопасное, сертификат действительный.

![Cron working result 01](https://github.com/L1qu1dVacuum/devops-netology/blob/main/term_paper/Images/19.01_01.png)

 По сертификату видно что выдан он уже 19.01.22 сроком на месяц.

![Cron working result 02](https://github.com/L1qu1dVacuum/devops-netology/blob/main/term_paper/Images/19.01_02.png)
