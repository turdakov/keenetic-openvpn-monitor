#!/bin/sh
# Start/stop monitor_openvpn

case "$1" in
    start)
        echo "Starting monitor_openvpn"
        /opt/bin/monitor_openvpn.sh &
        echo $! > /var/run/monitor_openvpn.pid
        ;;
    stop)
        echo "Stopping monitor_openvpn"
        if [ -f /var/run/monitor_openvpn.pid ]; then
            PID=$(cat /var/run/monitor_openvpn.pid)
            kill $PID
            rm /var/run/monitor_openvpn.pid
        else
            echo "monitor_openvpn is not running"
        fi
        ;;
    restart)
        $0 stop
        $0 start
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac

exit 0
