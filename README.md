# Ansible-drupal Role

Ansible's Role to install secure LEMP stack + drupal + civiCRM. 

## Requirements

1. `python-dev` 
2. `python-pip`
3. `python-openssl`
4. `ansible 2.2+`

## Setup

### Install ansible & dependencies

The following commands will install ansible (via pip) in your system.

1. `git clone https://github.com/mauhftw/ansible-drupal`
2. `chmod +x setup_ansible.sh`
3. `sudo ./setup_ansible.sh`

## Roles

Ansible-drupal contains the following roles:

- `common`	Installs basic tools & dependencies
- `ufw`		Installs ufw and basic rules (HTTP/s, SSH)
- `ssh`		Configures SSH
- `no_spoofing`	Prevents IP spoofing
- `fail2ban` 	Installs and configures fail2ban (SSH)
- `sendmail`	Setups MTA sendmail (sendonly emails)
- `letsencrypt`	Install letsencrypt certificates
- `nginx`		Install nginx-full & nginx-extras + secure drupal configs
- `mysql`		Install mysql
- `php`		Install php7.0
- `drupal`	Install drupal
- `civicrm`	Install civiCRM module
- `backup`	Install schedules configurable backups cronjobs to AWS S3

## Ansible Vars

Before you run the ansible role, please configure your group_vars. In the next paragraph basic notes about vars will be given.

- `TIP`: Use default local.yml values for references


### SSH
- `ssh_users:`	  Users allowed to ssh your current system (AllowUsers)
  
### Fail2ban
- `fail2ban_default_bantime:`     Default Fail2ban's Bantime
- `fail2ban_default_findtime:`    Default Fail2ban's findtime
- `fail2ban_default_destemail:`   Email address for notifications
- `fail2ban_default_sendername:`  Email name for notifications
- `fail2ban_default_maxretries:`  Max number of retries
- `fail2ban_ssh_port:`            Default SSH port
- `fail2ban_default_ssh_path:`    SSH's log path
- `fail2ban_mta:`                 Default MTA

### Sendmail
- `sendmail_user:` Account's username for sendmail

### Letsencrypt
- `webroot_dir:` Webroot directory name (e.g project)
- `letsencrypt_webroot_path:` Webroot path (e.g /var/www/project)
- `letsencrypt_email:` mail@yourdomain.app

### Nginx
- `nginx_worker_processes:` Number of worker processes
- `domain:` Domain name (e.g yourdomain.app)
- `domain_www:` www domain name (e.g www.yourdomain.app)
- `resolver:` Default resolver's ip

### Mysql
- `mysql_port:` Mysql's port
- `mysql_bind_address:` Mysql's bind address
- `mysql_password:` Mysql's password. Edit this entry in vault_file.txt 
- `mysql_packages:` Mysql's packages to install

### Php
- `php_repo:` PHP's repo
- `php_packages:` PHP's packages to install


### Drupal
- `drupal_db:` Drupal database
- `drupal_user:` Drupal database user
- `drupal_password:` Drupal database password. Edit this entry in vault_file.txt
- `drupal_docroot:` Webroot path withour project's directory (eg. /var/www)
- `drupal_version:` Drupal version to install (e.g drupal-7.54)
- `drupal_dir:` Webroot directory name (e.g project)
- `drupal_absolute_docroot:` Webroot path (e.g /var/www/project)
- `site_mail:` Drupal's email for notification purposes
- `site_name:` Drupal's site name. 
- `account_mail:` Drupal's main account
- `user:` Admin username 
- `password:` Admin password. Edit this entry in vault_file.txt 

### CiviCRM
- `rootdir:` Webroot directory name (e.g project)
- `civicrm_db:` Civicrm database
- `civicrm_user:` Civicrm database user
- `civicrm_password:` Civicrm database password.Edit this entry in vault_file.txt 
- `civicrm_url:` Civicrm download page
- `civicrm_destination:` Civicrm temporal directory for configuration purpose

### Backup  -- Backups files to AWS S3 --
- `aws_access_key:` Your AWS's access key
- `aws_access_secret:` Your AWS's access secret key
- `region:` AWS's region
- `s3_bucket:` S3's bucket name
- `s3_prefix:` S3's bucket prefix name
- `backup_name:` Backup name
- `backup_tmp_dest:` Backup temporal destination (e.g /tmp/dump)

### Cronjob parameters

- `cronjob_name:` Cronjob's backup name

- `cronjob_schedule_minute:` 
- `cronjob_schedule_hour:` 
- `cronjob_schedule_day:` 
- `cronjob_schedule_month:` 
- `cronjob_schedule_weekday:` 

This parameters works like a conventional unix-like cronjob.


Field	| Required | Allowed values |	Allowed special characters |	Remarks |
------|----------| ---------------|----------------------------|----------|
Minutes |	Yes |	0-59	* , -	- | |
Hours |	Yes | 	0-23	* , -	- | |
Day of month |	Yes |	1-31	* , - ? L W |	- |
Month |	Yes |	1-12 or JAN-DEC	* , - |	- |
Day of week |	Yes |	0-6 or SUN-SAT	* , - ? L # |	- |
Year |	No | 	1970–2099	* , - |	This field is not supported in standard/default implementations. |


For more information, please visit: https://en.wikipedia.org/wiki/Cron


## Ansible vault

Ansible-Vault is a feature of ansible that allows keeping sensitive data such as passwords or keys in encrypted files, rather than as plaintext in your playbooks or roles. To edit the vault file, please use the following command

- `$ ansible-vault edit vault_password.txt`

ENTER your VAULT PASSWORD: supersecret2314! (in this example)
 
And then you can edit your encrypted vars.

If you want to use vault, please use the following flag `--ask-vault-pass` or for automating processing place the password in a file and use `-vault-password-file=/path/to/vault_file` flag

### Changing vault password

If you wish to change your password on a vault-encrypted file or files, you can do so with the rekey command:

- `$ ansible-vault rekey vault_password.txt`

For more information, please check ansible-vault docs: 

## Basic Usage

Before Running the Role please configure and check your hosts, group_vars, sudo password, vault password.

- `$ ansible-playbook -i hosts/testing.yml master.yml --ask-become-pass --vault-password-file=vault_password.txt`


