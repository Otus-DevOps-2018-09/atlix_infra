# atlix_infra
[![Build Status](https://travis-ci.com/Otus-DevOps-2018-09/atlix_infra.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2018-09/atlix_infra)

## Infrastructure repository. Otus DevOps.

##### [Homework 3](#hw3) 
 * [One-line connect](#hw31)  
 * [Alias](#hw32) 
 * [IP info](#hw33)
#### [Homework 4](#hw4)
 * [Make an instance](#hw41)  
 * [Adding firewall rule](#hw42)

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