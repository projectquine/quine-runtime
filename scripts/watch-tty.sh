#!/bin/bash

# Initialize the list of folder names
prev_folder_names=($(sudo ls -1 /sys/class/tty))

# Loop indefinitely
while true; do
    # Get the list of folder names in /sys/class/tty
    folder_names=($(sudo ls -1 /sys/class/tty))

    # Check for new folder names
    for folder_name in "${folder_names[@]}"; do
        if [[ ! " ${prev_folder_names[@]} " =~ " ${folder_name} " ]]; then
            # A new folder has appeared
            echo "New folder: /sys/class/tty/$folder_name"
	    echo "Creating symlink to /dev/klipper"
	    sudo ln -s /dev/$folder_name /dev/klipper
	    sudo chmod 777 /dev/klipper
        fi
    done

    # Check for removed folder names
    for prev_folder_name in "${prev_folder_names[@]}"; do
        if [[ ! " ${folder_names[@]} " =~ " ${prev_folder_name} " ]]; then
            # A folder has disappeared
            echo "Folder disappeared: /sys/class/tty/$prev_folder_name"
	    echo "removing symlink to /dev/klipper"
	    sudo rm /dev/klipper
        fi
    done

    # Update the previous list of folder names
    prev_folder_names=("${folder_names[@]}")

    # Wait for 1 second before checking again
    sleep 1
done
