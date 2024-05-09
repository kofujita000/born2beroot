# Born2beroot手順書

1. debianをインストールする
```bash
mkdir iso
wget -O ./iso/debian.iso https://gemmei.ftp.acc.umu.se/debian-cd/current/amd64/iso
-cd/debian-12.5.0-amd64-netinst.iso
```

<br>


2. VirtualBoxを設定する
```bash
VM_NAME="Born2beroot"
STORAGE_CONTROLLER_NAME="SATA Controller"
VID_NAME="./vdi/born2beroot.vdi"
VID_SIZE="5120"
MEMORY_SIZE="1024"
CPUS="1"
VM_DIRECTORY="$(dirname $(realpath ${0}))/virtual"

VBoxManage unregistervm "${VM_NAME}" --delete

VBoxManage createvm --name "${VM_NAME}" --basefolder "${VM_DIRECTORY}" --ostype Debian_64 --register 

VBoxManage storagectl "${VM_NAME}" --name "${STORAGE_CONTROLLER_NAME}" --add sata

VBoxManage storageattach "${VM_NAME}" --storagectl "${STORAGE_CONTROLLER_NAME}" --port 0 --device 0 --type dvddrive --medium "./iso/debian.iso"

VBoxManage createmedium disk --filename "${VID_NAME}" --size ${VID_SIZE} --format VDI

VBoxManage storageattach "${VM_NAME}" --storagectl "${STORAGE_CONTROLLER_NAME}" --port 1 --device 0 --type hdd --medium "${VID_NAME}"

VBoxManage modifyvm "${VM_NAME}" --memory ${MEMORY_SIZE}

VBoxManage modifyvm "${VM_NAME}" --cpus ${CPUS}
```

<br>

3. Debianの初期設定を行う
- 仮想マシンを立ち上げる
```bash
VBoxManage startvm Born2beroot
```

- 仮想増し心の初期設定は次のとおりである
> 1. Select a language => `English - English` を選択する
> 2. Select your location => `other` -> `Asia` -> `Japan` を選択する
> 3. Configure locales => `United States - en_US.UTF-8` を選択する
> 4. Configure the keyboard => `American English` を選択する
> 5. Configure the network => `Hostname` -> "(ユーザ名)42" と入力する
> 6. Configure the network => `Domain name` -> "" と入力する
> 7. Set up users and passwords => `Root password` -> "asdfghkl;Z1" と入力する
> 8. Set up users and passwords => `Re-enter password to verify` -> "asdfghkl;Z1" と入力する
> 9. Set up users and passwords => `Full name for the new user` -> "(ユーザ名)" と入力する
>> ユーザ名 == 42で利用している自分のID
> 10. Set up users and passwords => `Username for your account` -> "(ユーザ名)" と入力する
> 11. Set up users and passwords => `Choose a password for the new user` -> "asdfghkl;Z12" と入力する
> 12. Set up users and passwords => `Re-enter password to verify` -> "asdfghkl;Z12" と入力する
> 13. Partition disks => `Manual` を選択する
> 14. Partition disks => `SCSI2 (0,0,0) (sda) - 5.4 GB ATA VBOX HARDDISK` を選択する
> 15. Partition disks => `Yes` を選択する
> 16. Partition disks => `pri/log 5.4 GB  FREE SPACE` を選択する
> 17. Partition disks => `Create a new Partition` を選択する
> 18. Partition disks => `New Partition size` -> "500M" と入力する
> 19. Partition disks => `Primary` を選択する
> 20. Partition disks => `Beginning` を選択する
> 21. Partition disks => `Mount point` -> `/boot` を選択する
> 22. Partition disks => `Done setting up the Partition` を選択する
> 23. Partition disks => `pri/log 4.9 GB  FREE SPACE` を選択する
> 24. Partition disks => `Create a new Partition` を選択する
> 25. Partition disks => `New Partition size` -> "1M" と入力する
> 26. Partition disks => `Primary` を選択する
> 27. Partition disks => `Beginning` を選択する
> 28. Partition disks => `Use as` -> `do not use` を選択する
> 29. Partition disks => `Done setting up the Partition` を選択する
> 30. Partition disks => `pri/log 4.9 GB  FREE SPACE` を選択する
> 31. Partition disks => `Create a new Partition` を選択する
> 32. Partition disks => `New Partition size` -> "max" と入力する
> 33. Partition disks => `Logical` を選択する
> 34. Partition disks => `Mount point` -> `Do not mount it` を選択する
> 35. Partition disks => `Done setting up the Partition` を選択する
> 36. Partition disks => `Configure encrypted volumes` を選択する
> 37. Partition disks => `Yes` を選択する
> 38. Partition disks => `Create encrypted volumes` を選択する
> 39. Partition disks => `/dev/sda5` にチェックを入れて選択をする
> 40. Partition disks => `Finish` を選択する
> 41. Partition disks => `Partition disks` を選択する
>> 多少の時間がかかる
> 42. Partition disks => `Encryption passphrase` => "asdfghkl;ZX12" と入力する
> 43. Partition disks => `Re-enter passphrase to verify` => "asdfghkl;ZX12" と入力する
> 44. Partition disks => `Configure the Logical Volume Manager` を選択する
> 45. Partition disks => `Yes` を選択する
> 46. Partition disks => `Create volume group` を選択する
> 47. Partition disks => `Volume group name` -> "LVMGroup" と入力する
> 48. Partition disks => `/dev/mapper/sda5_crypt` にチェックを入れて選択する
> 49. Partition disks => `Create logical volume` を選択する
> 50. Partition disks => `LVMGroup` を選択する
> 51. Partition disks => `Logical volume name` -> "root" を入力する
> 52. Partition disks => `Logical volume size` -> "1G" を入力する
> 53. Partition disks => `Create logical volume` を選択する
> 54. Partition disks => `LVMGroup` を選択する
> 55. Partition disks => `Logical volume name` -> "swap" を入力する
> 56. Partition disks => `Logical volume size` -> "100M" を入力する
> 57. Partition disks => `Create logical volume` を選択する
> 58. Partition disks => `LVMGroup` を選択する
> 59. Partition disks => `Logical volume name` -> "home" を入力する
> 60. Partition disks => `Logical volume size` -> "1G" を入力する
> 61. Partition disks => `Create logical volume` を選択する
> 62. Partition disks => `LVMGroup` を選択する
> 63. Partition disks => `Logical volume name` -> "var" を入力する
> 64. Partition disks => `Logical volume size` -> "1G" を入力する
> 65. Partition disks => `Create logical volume` を選択する
> 66. Partition disks => `LVMGroup` を選択する
> 67. Partition disks => `Logical volume name` -> "srv" を入力する
> 68. Partition disks => `Logical volume size` -> "300M" を入力する
> 69. Partition disks => `Create logical volume` を選択する
> 70. Partition disks => `LVMGroup` を選択する
> 71. Partition disks => `Logical volume name` -> "tmp" を入力する
> 72. Partition disks => `Logical volume size` -> "800M" を入力する
> 73. Partition disks => `Create logical volume` を選択する
> 74. Partition disks => `LVMGroup` を選択する
> 75. Partition disks => `Logical volume name` -> "var--log" を入力する
> 76. Partition disks => `Logical volume size` -> "658M" を入力する
> 77. Partition disks => `Finish` を選択する
> 78. Partition disks => `LV home の #1 998.2 MB` を選択する
> 79. Partition disks => `Use as: do not use` を選択する
> 80. Partition disks => `Ext4 journaling file system` を選択する
> 81. Partition disks => `Mount point` -> `home` を選択する
> 82. Partition disks => `Done setting up the Partition` を選択する
> 83. Partition disks => `LV root の #1 998.2 MB` を選択する
> 84. Partition disks => `Use as: do not use` を選択する
> 85. Partition disks => `Ext4 journaling file system` を選択する
> 86. Partition disks => `Mount point` -> `root` を選択する
> 87. Partition disks => `Done setting up the Partition` を選択する
> 83. Partition disks => `LV srv の #1 297.8 MB` を選択する
> 84. Partition disks => `Use as: do not use` を選択する
> 85. Partition disks => `Ext4 journaling file system` を選択する
> 86. Partition disks => `Mount point` -> `srv` を選択する
> 87. Partition disks => `Done setting up the Partition` を選択する
> 88. Partition disks => `LV swp の #1 96.5 MB` を選択する
> 89. Partition disks => `Use as: do not use` を選択する
> 90. Partition disks => `swap area` を選択する
> 91. Partition disks => `Done setting up the Partition` を選択する
> 92. Partition disks => `LV tmp の #1 796.9 MB` を選択する
> 93. Partition disks => `Use as: do not use` を選択する
> 94. Partition disks => `Ext4 journaling file system` を選択する
> 95. Partition disks => `Mount point` -> `tmp` を選択する
> 96. Partition disks => `Done setting up the Partition` を選択する
> 97. Partition disks => `LV var の #1 998.2 MB` を選択する
> 98. Partition disks => `Use as: do not use` を選択する
> 99. Partition disks => `Ext4 journaling file system` を選択する
> 100. Partition disks => `Mount point` -> `var` を選択する
> 101. Partition disks => `Done setting up the Partition` を選択する
> 102. Partition disks => `LV var--log の #1 796.9 MB` を選択する
> 103. Partition disks => `Use as: do not use` を選択する
> 104. Partition disks => `Ext4 journaling file system` を選択する
> 105. Partition disks => `Enter manually` -> "/var/log" を入力して選択する
> 106. Partition disks => `Done setting up the Partition` を選択する
> 107. Partition disks => `Finish Partitioning and write changes to disk` を選択する
> 108. Partition disks => `Yes` を選択する


