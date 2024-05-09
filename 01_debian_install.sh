#!/bin/bash
echo Create iso directory ...
mkdir iso
echo debian.iso to download ...
wget -O ./iso/debian.iso https://gemmei.ftp.acc.umu.se/debian-cd/current/amd64/iso
-cd/debian-12.5.0-amd64-netinst.iso
echo Finish !!
