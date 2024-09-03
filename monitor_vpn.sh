#!/bin/sh

# VPN server IP address
VPN_SERVER_IP="XXX.XXX.XXX.XXX" # Replace with your VPN server's IP address

# Check interval in seconds
CHECK_INTERVAL=60

# Path to log file
LOG_FILE="/var/log/openvpn_monitor.log"

# Log file size
MAX_LOG_SIZE=$((1024 * 1024))  # 1 MB

# Function to check if OpenVPN is connected to the server using ping

is_openvpn_running() {
    # Attempt to ping the VPN server
    ping -c 1 -W 5 $VPN_SERVER_IP > /dev/null 2>&1
    return $?
}

# Function to restart OpenVPN
restart_openvpn() {
    echo "Restarting OpenVPN..."
    ndmc -c interface OpenVPN0 down
    ndmc -c interface OpenVPN0 up
}

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

# Function to get file size in a cross-platform way
get_file_size() {
    if [ -f "$1" ]; then
        wc -c < "$1"
    else
        echo "0"
    fi
}

# Function to rotate log file if it exceeds MAX_LOG_SIZE
rotate_log() {
    if [ -f "$LOG_FILE" ] && [ $(get_file_size "$LOG_FILE") -gt $MAX_LOG_SIZE ]; then
        mv "$LOG_FILE" "${LOG_FILE}.old"
        log_message "Log file rotated."
    fi
}

# Main logic
log_message "OpenVPN monitoring script started."

while true; do
        rotate_log

        if is_openvpn_running; then
        log_message "OpenVPN is connected and responsive."
    else
        log_message "OpenVPN is not connected or not responsive. Restarting..."
        restart_openvpn

        # Wait for a moment to allow the connection to establish
        sleep 10

        # Check again after restart
        if is_openvpn_running; then
            log_message "OpenVPN successfully reconnected."
        else
            log_message "OpenVPN failed to reconnect. Please check your configuration."
        fi
    fi
    
    # Wait for the next check
    sleep $CHECK_INTERVAL
done
