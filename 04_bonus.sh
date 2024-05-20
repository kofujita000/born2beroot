#!/bin/bash

apt update
apt install -y php8.2 php-common php-cgi php-cli php-mysql lighttpd
apt purge apache2

