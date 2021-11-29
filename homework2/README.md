# devops-netology
Домашние задания по курсу Dev-Ops

------

1. Узнал, ознакомился.


2. Файлы, являющиеся жесткой ссылкой на один объект, не могут иметь разные права доступа и владельца, так как ссылаются на один inode и по сути являются одним и тем же файлом.


3. Сделал `vagrant destroy`. Изменил Vagrantfile, поднял новую виртуальную машину. (Крашится на VB 6.1.28)


4. Разбил.

		...
		Device     Boot   Start     End Sectors  Size Id Type
		/dev/sdb1          2048 4196351 4194304    2G 83 Linux
		/dev/sdb2       4196352 5242879 1046528  511M 83 Linux	
		...


5. `$sudo sfdisk -d /dev/sdb | sudo sfdisk /dev/sdc`

   `$sudo fdisk -l`

		...
		Device     Boot   Start     End Sectors  Size Id Type
		/dev/sdc1          2048 4196351 4194304    2G 83 Linux
		/dev/sdc2       4196352 5242879 1046528  511M 83 Linux	
		...


6. `$sudo mdadm --create /dev/md0 --level=1  --raid-devices=2 /dev/sdb1 /dev/sdc1`

		sdb                    8:16   0  2.5G  0 disk		
		├─sdb1                 8:17   0    2G  0 part
		│ └─md0                9:0    0    2G  0 raid1
		└─sdb2                 8:18   0  511M  0 part

		sdc                    8:32   0  2.5G  0 disk
		├─sdc1                 8:33   0    2G  0 part
		│ └─md0                9:0    0    2G  0 raid1
		└─sdc2                 8:34   0  511M  0 part


7. `$sudo mdadm --create /dev/md1 --level=0  --raid-devices=2 /dev/sdb2 /dev/sdc2`

		sdb                    8:16   0  2.5G  0 disk
		├─sdb1                 8:17   0    2G  0 part
		│ └─md0                9:0    0    2G  0 raid1
		└─sdb2                 8:18   0  511M  0 part
		  └─md1                9:1    0 1018M  0 raid0
		sdc                    8:32   0  2.5G  0 disk
		├─sdc1                 8:33   0    2G  0 part
		│ └─md0                9:0    0    2G  0 raid1
		└─sdc2                 8:34   0  511M  0 part
		  └─md1                9:1    0 1018M  0 raid0

8. `$sudo pvcreate /dev/md0 /dev/md1`

		Physical volume "/dev/md0" successfully created.
  		Physical volume "/dev/md1" successfully created.


9. `$sudo vgcreate vg0 /dev/md0 /dev/md1`

		Volume group "vg0" successfully created


10. `$sudo lvcreate -L 100M vg0 /dev/md1`

		Logical volume "lvol0" created


11. `$sudo mkfs.ext4 /dev/vg0/lvol0`


12. `$mkdir /tmp/new`

    `$sudo mount /dev/vg0/lvol0 /tmp/new`


13. `$sudo wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`


14. `$sudo lsblk`

		NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
		sda                    8:0    0   64G  0 disk
		├─sda1                 8:1    0  512M  0 part  /boot/efi
		├─sda2                 8:2    0    1K  0 part
		└─sda5                 8:5    0 63.5G  0 part
		  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
		  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
		sdb                    8:16   0  2.5G  0 disk
		├─sdb1                 8:17   0    2G  0 part
		│ └─md0                9:0    0    2G  0 raid1
		└─sdb2                 8:18   0  511M  0 part
		  └─md1                9:1    0 1018M  0 raid0
		    └─vg0-lvol0      253:2    0  100M  0 lvm   /tmp/new
		sdc                    8:32   0  2.5G  0 disk
		├─sdc1                 8:33   0    2G  0 part
		│ └─md0                9:0    0    2G  0 raid1
		└─sdc2                 8:34   0  511M  0 part
		  └─md1                9:1    0 1018M  0 raid0
		    └─vg0-lvol0      253:2    0  100M  0 lvm   /tmp/new


15. `$gzip -t /tmp/new/test.gz && echo $?`

		0


16. `$sudo pvmove /dev/md1 /dev/md0`

		/dev/md1: Moved: 16.00%
		/dev/md1: Moved: 100.00%	


17. `$sudo mdadm /dev/md0 -f /dev/sdb1`

		mdadm: set /dev/sdb1 faulty in /dev/md0


18. `$dmesg |grep -P 'md0|failure'`

		[  949.895748] md/raid1:md0: not clean -- starting background reconstruction
		[  949.895750] md/raid1:md0: active with 2 out of 2 mirrors
		[  949.895764] md0: detected capacity change from 0 to 2144337920
		[  949.898997] md: resync of RAID array md0
		[  962.582830] md: md0: resync done.
		[ 4490.572347] md/raid1:md0: Disk failure on sdb1, disabling device.
		               md/raid1:md0: Operation continuing on 1 devices.


19. `$gzip -t /tmp/new/test.gz && echo $?`

		0


20. `$^D`

    `$vagrant destroy`