#!/bin/bash

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes postfix ssl-cert libsasl2-modules sasl2-bin

cat <<E >/tmp/main.cf
myhostname = merlot.strk.jp #host
mydomain = $myhostname
mydestination = $myhostname, localhost

mynetworks = 127.0.0.0/8,localhost,localhost.localdomain,merlot.strk.jp

inet_interfaces = $mydestination

unknown_local_recipient_reject_code = 550

smtpd_sasl_path = smtpd
smtpd_sasl_auth_enable = yes
#smtpd_sasl_local_domain = $myhostname
smtpd_sasl_local_domain = $mydomain
smtpd_recipient_restrictions =
    permit_mynetworks
    reject_unauth_destination
    #permit_sasl_authenticated
E
sudo mv /tmp/main.cf /etc/postfix/main.cf
sudo postalias /etc/aliases
sudo chgrp postfix /etc/sasldb2
sudo chmod 640 /etc/sasldb2
sudo ln -f /etc/sasldb2 /var/spool/postfix/etc/
sudo /etc/init.d/postfix restart
