# keenetic-openvpn-monitor
Scripts for automatically restarting OpenVPN if it becomes unresponsive on Asus Keenetic routers. Tested on models KN-1810 and KN-1811.

1. Install [ssh](https://help.keenetic.com/hc/en-us/articles/360000387189-SSH-remote-access-to-the-Keenetic-command-line) and [OPKG](https://help.keenetic.com/hc/en-us/articles/360021888880-Installing-OPKG-Entware-in-the-router-s-internal-memory) file system on your router and login to sh
```shell
ssh root@router_ip
exec sh
```

2. Copy monitor_vpn.sh to /opt/bin/monitor_openvpn. You can just copy-paste code using vi
```shell
vi /opt/bin/monitor_openvpn.sh
```

4. Make it executable
```shell
chmod +x /opt/bin/monitor_openvpn.sh
```

5. Now make a daemon that will start automaticall on the reboot of the router.
Copy S99VPNChecker.sh to /opt/etc/init.d/S99VPNChecker. 
```shell
vi /opt/etc/init.d/S99VPNChecker
```

Scripts located in /opt/etc/init.d/ are automatically started when the system boots up if their name begins with S. The number in the name, such as S99, determines the order of startup (the higher the number, the later the process will be started).

6. Make it executable
```shell
chmod +x /opt/etc/init.d/S99VPNChecker
```

7. Run the daemon (or reboot the router) 
```shell
/opt/etc/init.d/S99VPNChecker start
```
