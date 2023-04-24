#!/data/data/com.termux/files/usr/bin/bash

# Function to handle errors
error_handler() {
    echo "Error occurred in the script. Exiting." >&2
    exit 1
}

# Trap errors and call error_handler function
trap error_handler ERR

# Function to run commands with sudo and redirect output
run_sudo() {
    if [ "$1" = "dockerd" ]; then
        sudo sh -c "stdbuf -oL $1 > '$OUTPUT_LOG' 2>&1"
    else
        sudo sh -c "$1 > '$OUTPUT_LOG' 2>&1"
    fi
}

# Get the directory of the current script
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Define the output log file
OUTPUT_LOG="$SCRIPT_DIR/docker-output.log"

# Make storage writable to add some files and folders Docker requires
run_sudo "mount -o remount,rw /"

# Make cgroup mountable, as existing processes in dockerd cannot mount properly
run_sudo "mount -t tmpfs -o mode=755 tmpfs /sys/fs/cgroup"
run_sudo "mkdir -p /sys/fs/cgroup/devices"
run_sudo "mount -t cgroup -o devices cgroup /sys/fs/cgroup/devices"

# Now gracefully start Docker
# iptables command not required as we have now network access
run_sudo "dockerd" # --iptables=false
