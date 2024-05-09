#!/bin/bash
# 仮想マシンの名前
VM_NAME="Born2beroot"
# ストレージコントローラーの名前
STORAGE_CONTROLLER_NAME="SATA Controller"
# VDIファイルのパス
VID_NAME="./vdi/born2beroot.vdi"
# VDIのサイズ（MB単位）
VID_SIZE="5120"
# メモリのサイズ（MB単位）
MEMORY_SIZE="1024"
# CPUのスレッド数
CPUS="1"
# 保存ディレクトリパス
VM_DIRECTORY="$(dirname $(realpath ${0}))/virtual"

# 仮想マシンの削除
echo "Delete virtual machine"
VBoxManage unregistervm "${VM_NAME}" --delete

# 仮想マシンの作成
echo "Create virtual machine"
VBoxManage createvm --name "${VM_NAME}" --basefolder "${VM_DIRECTORY}" --ostype Debian_64 --register 

# ストレージコントローラーの追加
echo "Add storage controller"
VBoxManage storagectl "${VM_NAME}" --name "${STORAGE_CONTROLLER_NAME}" --add sata

# ISOイメージの接続
echo "Attach ISO image"
VBoxManage storageattach "${VM_NAME}" --storagectl "${STORAGE_CONTROLLER_NAME}" --port 0 --device 0 --type dvddrive --medium "./iso/debian.iso"

# VDIの作成
echo "Create VDI disk"
VBoxManage createmedium disk --filename "${VID_NAME}" --size ${VID_SIZE} --format VDI

# VDIのストレージコントローラーへの接続
echo "Attach VDI disk to storage controller"
VBoxManage storageattach "${VM_NAME}" --storagectl "${STORAGE_CONTROLLER_NAME}" --port 1 --device 0 --type hdd --medium "${VID_NAME}"

# メモリの設定
echo "Set memory size"
VBoxManage modifyvm "${VM_NAME}" --memory ${MEMORY_SIZE}

# CPUのスレッド数の設定
echo "Set CPU threads"
VBoxManage modifyvm "${VM_NAME}" --cpus ${CPUS}

echo "Virtual machine setup completed"
