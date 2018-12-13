# atlix_infra
[![Build Status](https://travis-ci.com/Otus-DevOps-2018-09/atlix_infra.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2018-09/atlix_infra)

## Infrastructure repository. Otus DevOps.

##### [Homework 3](#hw3) 
 * [One-line connect](#hw31)  
 * [Alias](#hw32) 
 * [IP info](#hw33)
##### [Homework 4](#hw4)
 * [Make an instance](#hw41)  
 * [Adding firewall rule](#hw42)
##### [Homework 5](#hw5)
 * [Templates](#hw51)  
 * [Creating image](#hw52)
 * [Deploying app](#hw53)
##### [Homework 6](#hw6)
 * [Main task](#hw61)  
 * [Additional task *](#hw62)
 * [Additional task **](#hw63)
##### [Homework 7](#hw7)
 * [Main task](#hw71)  
 * [Additional task *](#hw72)
 * [Additional task **](#hw73)
##### [Homework 8](#hw8)
 * [Main task](#hw81)  
 * [Additional task *](#hw82)
##### [Homework 9](#hw9)
 * [Main task](#hw91)  
 * [Additional task *](#hw92)
##### [Homework 10](#hw10)
 * [Main task](#hw101)  
 * [Additional task *](#hw102)
##### [Homework 11](#hw11)
 * [Main task](#hw111)  
 * [Additional task *](#hw112)
-----------------------------------

<a name="hw3"></a>
## Homework 3 / Cloud bastion host / 
<a name="hw31"></a>
##### One-line connect:
```bash 
ssh -i ~/.ssh/appuser -o ProxyCommand="ssh -W %h:%p appuser@35.234.123.86" appuser@10.156.0.3
```
<a name="hw32"></a>
##### Alias:
```bash 
$ cat ~/.ssh/config`

Host *
ForwardAgent yes

Host bastion
Hostname 35.234.123.86
User appuser
IdentityFile ~/.ssh/appuser

Host someinternalhost
User appuser
HostName 10.156.0.3
IdentityFile ~/.ssh/appuser
ProxyCommand ssh -W %h:%p bastion
```
`$ ssh someinternalhost`
<a name="hw33"></a>
##### IP info
Connection info:

bastion_IP = 35.234.123.86
someinternalhost_IP = 10.156.0.3

-----------------------------------
<a name="hw4"></a>
## Homework 4 / Cloud test app / 
<a name="hw41"></a>
##### Make an instance
```
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata startup-script='wget -O - https://gist.githubusercontent.com/atlix/6c42d225e8ff093c1ab235562f6ed1c2/raw/ad4981251c9c25300f053b03eae2189ec0360ccc/startup_script.sh | bash'
```
<a name="hw42"></a>
##### Adding firewall rule
```
gcloud compute --project=infra-219310 firewall-rules create default-puma-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server
```
testapp_IP = 35.241.224.247
testapp_port = 9292

-----------------------------------
<a name="hw5"></a>
## Homework 5 / Packer / 
<a name="hw51"></a>
##### Templates
Созданы шаблоны ubuntu16.json (reddit-base) & immutable.json (reddit-full)
<a name="hw52"></a>
##### Creating image
base:
```
cd packer && packer build ubuntu16.json
```
full:
```
cd packer && packer build -var-file=variables.json immutable.json
```
<a name="hw53"></a>
##### Deploying app
```
config-scripts/create-reddit-vm.sh
```

-----------------------------------
<a name="hw6"></a>
## Homework 6 / Terraform-1 / 
<a name="hw61"></a>
##### Main task
Создана директория terraform, добавлены конфигурационные файлы, поправлен .gitignore. Добавлена конфигурация для деплоя тестового приложения reddit в GCP

<a name="hw62"></a>
##### Additional task *
Добавлены ssh-ключи для нескольких пользователей. Получен наглядный вывод о том, что не стоит настраивать ssh-ключи через web-консоль, если управление ими производится через terraform

<a name="hw63"></a>
##### Additional task **
Добавлена конфигурация для деплоя нескольких серверов приложений. Создан lb.tf с примером конфигруации GCP LoadBalancer, позволяющий проксировать трафик на несколько серверов приложений. Проведена проверка, что при отключении приложения на одной VM, не происходит отказа в обслуживании - трафик балансируется на "живой" сервер за счет healthcheck.

-----------------------------------
<a name="hw7"></a>
## Homework 7 / Terraform-2 / 
<a name="hw71"></a>
##### Main task
- Изучен способ импортирования существующей инфраструктуры в terraform
- Конфигурация terraform разбита на модули
- Созданы stage и prod среды
- Добавлены правила fw
<a name="hw72"></a>
##### Additional task *
- Создан storage-bucket для хранения tfstate
- Настроен удаленный tfstate-backend для stage и prod сред
<a name="hw73"></a>
##### Additional task **
- Приложение деплоится на 2 VM (reddit-app и reddit-db)

-----------------------------------
<a name="hw8"></a>
## Homework 8 / Ansible-1 / 
<a name="hw81"></a>
##### Main task
- Установлен Ansible
- Создана директория ansible, добавлены файлы конфигурации и inventory-файлы
<a name="hw72"></a>
##### Additional task *
- Создан inventory.json и добавлен bash-скрипт inventory.sh для транслирования его ansbile

-----------------------------------
<a name="hw9"></a>
## Homework 9 / Ansible-2 / 
<a name="hw91"></a>
##### Main task
- Созданы различные вариации playbook'ов для провижининга и деплоя приложения
- Изменен способ провижининга образов с shell на ansible в конфигурации packer, собраны новые образы reddit-app-base и reddit-db-base
- Изменения протестированы на примере создания stage-инфраструктуры
<a name="hw92"></a>
##### Additional task *
- Подключен скрипт динамического инвентори gce.py

-----------------------------------
<a name="hw10"></a>
## Homework 10 / Ansible-3 / 
<a name="hw101"></a>
##### Main task
- Реорганизован каталог ansible
- Созданы роли app/db
- Добавлены окружения stage/prod
<a name="hw102"></a>
##### Additional task *
- Динамические инвентори для prod/stage через gce.py
- Добавлены тесты 

-----------------------------------
<a name="hw11"></a>
## Homework 11 / Ansible-4 / 
<a name="hw111"></a>
##### Main task
- Установлены Vagrant, Virtualbox, Molecule
- Изменена конфигурация ролей; роли добавлены в плейбуки
- Добавлен тест для mongo
<a name="hw112"></a>
##### Additional task *
- Настройка Nginx через Vargant

