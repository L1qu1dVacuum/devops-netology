# devops-netology
Домашние задания по курсу Dev-Ops

------

1. `$telnet route-views.routeviews.org`

   `$rviews`

   `$sh ip route 78.107.xxx.70`

		Routing entry for 78.106.0.0/15
		  Known via "bgp 6447", distance 20, metric 0
		  Tag 3356, type external
		  Last update from 4.68.4.46 03:19:32 ago
		  Routing Descriptor Blocks:
		  * 4.68.4.46, from 4.68.4.46, 03:19:32 ago
		      Route metric is 0, traffic share count is 1
		      AS Hops 3
		      Route tag 3356
		      MPLS label: none

   `$sh bgp 78.107.xxx.70`

		BGP routing table entry for 78.106.0.0/15, version 1397083950
		Paths: (24 available, best #11, table default)
		  Not advertised to any peer
		  Refresh Epoch 3
		  3303 3216 8402
		    217.192.89.50 from 217.192.89.50 (138.187.128.158)
		      Origin IGP, localpref 100, valid, external
		      Community: 3216:1000 3216:1004 3216:2001 3216:5000 3216:5010 3216:5020 3216:5030 3216:5040 3216:5050 3216:5060 3216:5070 3216:5080 3216:5090 3216:5100 3216:5110 3216:5130 3216:5140 3216:5200 3216:5210 3216:5220 3216:5230 3216:5240 3216:5250 3216:5260 3216:5270 3216:5280 3216:5290 3216:5310 3216:5320 3216:5330 3216:5340 3216:5350 3216:5360 3216:5370 3216:5380 3216:5390 3216:5400 3216:5410 3216:5500 3216:5600 3216:5610 3216:5620 3303:1004 3303:1006 3303:1030 3303:3051 8402:900 8402:904
		      path 7FE144BABE50 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  4901 6079 3356 8402 8402
		    162.250.137.254 from 162.250.137.254 (162.250.137.254)
		      Origin IGP, localpref 100, valid, external
		      Community: 65000:10100 65000:10300 65000:10400
		      path 7FE126964688 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  7660 2516 6762 8402 8402
		    203.181.248.168 from 203.181.248.168 (203.181.248.168)
		      Origin IGP, localpref 100, valid, external
		      Community: 2516:1030 7660:9003
		      path 7FE0F12CE768 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  3267 3356 8402 8402
		    194.85.40.15 from 194.85.40.15 (185.141.126.1)
		      Origin IGP, metric 0, localpref 100, valid, external
		      path 7FE1536F4770 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  57866 3356 8402 8402
		    37.139.139.17 from 37.139.139.17 (37.139.139.17)
		      Origin IGP, metric 0, localpref 100, valid, external
		      Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065 8402:900 8402:904
		      path 7FE0BF55B2F0 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  7018 3356 8402 8402
		    12.0.1.63 from 12.0.1.63 (12.0.1.63)
		      Origin IGP, localpref 100, valid, external
		      Community: 7018:5000 7018:37232
		      path 7FE0E86C4930 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  3333 6762 8402 8402
		    193.0.0.56 from 193.0.0.56 (193.0.0.56)
		      Origin IGP, localpref 100, valid, external
		      Community: 6762:1 6762:92 6762:14900
		      path 7FE12E8021E8 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  49788 12552 3216 8402
		    91.218.184.60 from 91.218.184.60 (91.218.184.60)
		      Origin IGP, localpref 100, valid, external
		      Community: 12552:12000 12552:12700 12552:12701 12552:22000
		      Extended Community: 0x43:100:1
		      path 7FE09288D6E0 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  20912 3257 3356 8402 8402
		    212.66.96.126 from 212.66.96.126 (212.66.96.126)
		      Origin IGP, localpref 100, valid, external
		      Community: 3257:8070 3257:30515 3257:50001 3257:53900 3257:53902 20912:65004
		      path 7FE0A121A628 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  8283 6762 8402 8402
		    94.142.247.3 from 94.142.247.3 (94.142.247.3)
		      Origin IGP, metric 0, localpref 100, valid, external
		      Community: 6762:1 6762:92 6762:14900 8283:1 8283:101
		      unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
		        value 0000 205B 0000 0000 0000 0001 0000 205B
		              0000 0005 0000 0001
		      path 7FE12A3B93F0 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  3356 8402 8402
		    4.68.4.46 from 4.68.4.46 (4.69.184.201)
		      Origin IGP, metric 0, localpref 100, valid, external, best
		      Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065 8402:900 8402:904
		      path 7FE03789CA58 RPKI State not found
		      rx pathid: 0, tx pathid: 0x0
		  Refresh Epoch 1
		  1221 4637 6762 8402 8402
		    203.62.252.83 from 203.62.252.83 (203.62.252.83)
		      Origin IGP, localpref 100, valid, external
		      path 7FE047730638 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  2497 3356 8402 8402
		    202.232.0.2 from 202.232.0.2 (58.138.96.254)
		      Origin IGP, localpref 100, valid, external
		      path 7FE133D00EE0 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  852 3356 8402 8402
		    154.11.12.212 from 154.11.12.212 (96.1.209.43)
		      Origin IGP, metric 0, localpref 100, valid, external
		      path 7FE004B78638 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  20130 6939 3216 8402
		    140.192.8.16 from 140.192.8.16 (140.192.8.16)
		      Origin IGP, localpref 100, valid, external
		      path 7FE16D0DDB08 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  701 1273 8402 8402 8402
		    137.39.3.55 from 137.39.3.55 (137.39.3.55)
		      Origin IGP, localpref 100, valid, external
		      path 7FE0517BBEA8 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  3257 3356 8402 8402
		    89.149.178.10 from 89.149.178.10 (213.200.83.26)
		      Origin IGP, metric 10, localpref 100, valid, external
		      Community: 3257:8794 3257:30043 3257:50001 3257:54900 3257:54901
		      path 7FE07E9E9F40 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  3549 3356 8402 8402
		    208.51.134.254 from 208.51.134.254 (67.16.168.191)
		      Origin IGP, metric 0, localpref 100, valid, external
		      Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065 3549:2581 3549:30840 8402:900 8402:904
		      path 7FE126F89318 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  53767 14315 6453 6453 3356 8402 8402
		    162.251.163.2 from 162.251.163.2 (162.251.162.3)
		      Origin IGP, localpref 100, valid, external
		      Community: 14315:5000 53767:5000
		      path 7FE147ACF570 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  101 3356 8402 8402
		    209.124.176.223 from 209.124.176.223 (209.124.176.223)
		      Origin IGP, localpref 100, valid, external
		      Community: 101:20100 101:20110 101:22100 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065 8402:900 8402:904
		      Extended Community: RT:101:22100
		      path 7FE0B3C28DA8 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  6939 3216 8402
		    64.71.137.241 from 64.71.137.241 (216.218.252.164)
		      Origin IGP, localpref 100, valid, external
		      path 7FE0EBBAF500 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  3561 3910 3356 8402 8402
		    206.24.210.80 from 206.24.210.80 (206.24.210.80)
		      Origin IGP, localpref 100, valid, external
		      path 7FE13F1FC1A0 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  1351 6939 3216 8402
		    132.198.255.253 from 132.198.255.253 (132.198.255.253)
		      Origin IGP, localpref 100, valid, external
		      path 7FE11EA25870 RPKI State not found
		      rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  19214 3257 3356 8402 8402
		    208.74.64.40 from 208.74.64.40 (208.74.64.40)
		      Origin IGP, localpref 100, valid, external
		      Community: 3257:8108 3257:30048 3257:50002 3257:51200 3257:51203
		      path 7FE1435AD120 RPKI State not found
		      rx pathid: 0, tx pathid: 0


2. `$sudo echo "dummy" >> sudo /etc/modules`

   `$sudo echo "options dummy numdummies=2" > sudo /etc/modprobe.d/dummy.conf`

   `$lsmod | grep dummy`

        dummy			16384  0

   `$ifconfig -a | grep dummy`

        dummy0: flags=195<UP,BROADCAST,RUNNING,NOARP>  mtu 1500
        dummy1: flags=195<UP,BROADCAST,RUNNING,NOARP>  mtu 1500

   `$sudo ip addr add 10.0.0.101/24 dev dummy0`

   `$sudo ip addr add 10.0.0.102/24 dev dummy0`

   `$routel | grep dummy0`

            target            gateway          source    proto    scope    dev tbl
        10.0.0.101              local        10.0.0.1   kernel     host dummy0 local
        10.0.0.102              local        10.0.0.1   kernel     host dummy0 local


3. `$sudo lsof -nP -i | grep LISTEN`

	    systemd      1            root   35u  IPv4  16554      0t0  TCP *:111 (LISTEN)
    	systemd      1            root   37u  IPv6  16558      0t0  TCP *:111 (LISTEN)
    	rpcbind    559            _rpc    4u  IPv4  16554      0t0  TCP *:111 (LISTEN)
    	rpcbind    559            _rpc    6u  IPv6  16558      0t0  TCP *:111 (LISTEN)
    	systemd-r  560 systemd-resolve   13u  IPv4  22319      0t0  TCP 127.0.0.53:53 (LISTEN)
    	sshd       800            root    3u  IPv4  24861      0t0  TCP *:22 (LISTEN)
    	sshd       800            root    4u  IPv6  24872      0t0  TCP *:22 (LISTEN)


4. `$sudo lsof -nP -i | grep UDP`

    	systemd      1            root   36u  IPv4  16555      0t0  UDP *:111
    	systemd      1            root   38u  IPv6  16561      0t0  UDP *:111
    	systemd-n  405 systemd-network   19u  IPv4  21231      0t0  UDP 10.0.2.15:68
    	rpcbind    559            _rpc    5u  IPv4  16555      0t0  UDP *:111
    	rpcbind    559            _rpc    7u  IPv6  16561      0t0  UDP *:111
    	systemd-r  560 systemd-resolve   12u  IPv4  22318      0t0  UDP 127.0.0.53:53


5. [Сделал](https://drive.google.com/file/d/1mjr1UUA11ch_ccLJHJuDgGaB60H7Fyli/view?usp=sharing). 

   
   
