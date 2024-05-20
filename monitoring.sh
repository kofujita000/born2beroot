#!/bin/bash

# OSのアーキテクチャを取得する
OS_ARCHITECTURE=$(uname -m)
# OSのカーネルのバージョンを取得する
OS_KERNEL_VERSION=$(uname -r)
# CPU情報を取得する
LSCPU_INFO=$(lscpu)
# 物理CPUの数を取得する
PHYSICS_CPU_COUNT=$(echo "${LSCPU_INFO}" | grep "Socket(s)" | awk '{print $2}')
# 仮想CPUの数を取得する
VIRTUAL_CPU_COUNT=$(echo "${LSCPU_INFO}" | grep "^CPU(s):" | awk '{print $2}')
# メモリ情報を取得する
FREE_INFO=$(free)
# RAMメモリのトータル情報を取得する
FREE_INFO_RAM_TOTAL=$(echo "${FREE_INFO}" | grep "Mem:" | awk '{print $2}')
# RAMメモリの解放されている情報を取得する
FREE_INFO_RAM_AVAILABLE=$(echo "${FREE_INFO}" | grep "Mem:" | awk '{print $7}')
# RAMメモリの使用量
FREE_INFO_RAM_USED=$((FREE_INFO_RAM_TOTAL - FREE_INFO_RAM_AVAILABLE))
# RAMメモリの％情報
FREE_INFO_RAM_PERCENT=$((FREE_INFO_RAM_USED * 100 / FREE_INFO_RAM_TOTAL))
# ディスクの最大容量
DISC_MAX=$(df --output=size / | tail -n 1 | tr -d ' ')
# ディスクの使用容量
DISC_USE=$(df --output=used / | tail -n 1 | tr -d ' ')
# ディスクの％
DISC_PERCENT=$(df --output=pcent / | tail -n 1 | tr -d ' ' | tr -d '%')
# CPUの情報を取得する
MPSTAT_ALL_INFO=$(mpstat | grep "all")
MPSTAT_ALL_IDLE=$(echo ${MPSTAT_ALL_INFO} | awk '{print $13}')
MPSTAT_ALL_USE=$(echo "scale=2; (100 - ${MPSTAT_ALL_IDLE})" | bc)
# 最終ブート時間を取得する
LAST_BOOT=$(who -b | awk '{print $3, $4}')
# LVMがアクティブかどうかを調べる
LVM_ACTIVE=$(lvs >/dev/null 2>&1 && echo "yes" || echo "no")
# アクティブな接続数
CONNECT_ACTIVE=$(netstat -an --tcp | grep -E 'ESTABLISHED|CLOSE_WAIT' | wc -l)
# サーバを利用しているユーザの数
USE_USER_COUNT=$(who | wc -l)
# サーバのIPv4とMAC情報
IPV4_MAC_INFO=$(ip addr show | awk '/inet / {ip=$2; next} /link\/ether/ {print "IP " ip " (" $2 ")"}')
# SUDOのカウント数
SUDO_COUNT=$(cat /var/log/sudo/sudo_config | grep COMMAND | wc -l)

# 出力処理
echo "Broadcast message from root@wil (tty1) ($(date +'%a %b %d %H:%M:%S %Y')):"
echo "#Architecture: Linux ${OS_ARCHITECTURE} ${OS_KERNEL_VERSION}"
echo "#CPU physical : ${PHYSICS_CPU_COUNT}"
echo "#vCPU : ${VIRTUAL_CPU_COUNT}"
echo "#Memory Usage: $((FREE_INFO_RAM_USED / 1024))/$((FREE_INFO_RAM_TOTAL / 1024))mb (${FREE_INFO_RAM_PERCENT}%)"
echo "#Disk Usage: $(printf "%1.2f" $(echo "scale=2; (${DISC_USE} / (1024 * 1024))" | bc))/$(printf "%1.2f" $(echo "scale=2; (${DISC_MAX} / (1024 * 1024))" | bc))Gb (${DISC_PERCENT}%)"
echo "#CPU load: $(printf "%1.2f" ${MPSTAT_ALL_USE})%"
echo "#Last boot: ${LAST_BOOT}"
echo "#LVM use: ${LVM_ACTIVE}"
echo "#Connections TCP : ${CONNECT_ACTIVE} ESTABLISHED"
echo "#User log: ${USE_USER_COUNT}"
echo "#Network: ${IPV4_MAC_INFO}"
echo "#Sudo : ${SUDO_COUNT} cmd"

