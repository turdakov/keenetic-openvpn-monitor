# keenetic-openvpn-monitor
Scripts for automatically restarting OpenVPN if it becomes unresponsive on Asus Keenetic routers. Tested on models KN-1810 and KN-1811.

1. Install [ssh](https://help.keenetic.com/hc/en-us/articles/360000387189-SSH-remote-access-to-the-Keenetic-command-line) and [OPKG](https://help.keenetic.com/hc/en-us/articles/360021888880-Installing-OPKG-Entware-in-the-router-s-internal-memory) file system on your router and login to sh
> ssh root@router's_ip

> exec sh

2. Copy monitor_vpn.sh to /opt/bin/monitor_openvpn. You can just copy-paste code using vi
> vi /opt/bin/monitor_openvpn.sh

3. Make it executable
> chmod +x /opt/bin/monitor_openvpn

4. Now make a daemon that will start automaticall on the reboot of the router: copy S99VPNChecker.sh to /opt/etc/init.d/S99VPNChecker. Scripts located in /opt/etc/init.d/ are automatically started when the system boots up if their name begins with S. The number in the name, such as S99, determines the order of startup (the higher the number, the later the process will be started).
> chmod +x /opt/etc/init.d/S99VPNChecker

5. run the daemon (or reboot the router) 
> /opt/etc/init.d/S99VPNChecker start
