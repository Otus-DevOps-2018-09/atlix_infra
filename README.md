# atlix_infra
[![Build Status](https://travis-ci.com/Otus-DevOps-2018-09/atlix_infra.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2018-09/atlix_infra)

## Infrastructure repository. Otus DevOps.

##### [Homework 4](#hw4) 
 * [One-line connect](#hw41)  
 * [Alias](#hw42) 
 * [IP info](#hw43) 

-----------------------------------

<a name="hw4"></a>
## Homework 4 / Cloud bastion host / 
<a name="hw41"></a>
##### One-line connect:
```bash 
ssh -i ~/.ssh/appuser -o ProxyCommand="ssh -W %h:%p appuser@35.234.123.86" appuser@10.156.0.3
```
<a name="hw42"></a>
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
<a name="hw43"></a>
##### IP info
Connection info:

bastion_IP = 35.234.123.86
someinternalhost_IP = 10.156.0.3
