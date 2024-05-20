#!/bin/bash

# apt を設定するためのコマンド
echo "deb http://deb.debian.org/debian/ bookworm main non-free-firmware" > "/etc/apt/sources.list"

# パッケージマネージャをアップデートする
apt update
apt install -y ssh sudo vim


