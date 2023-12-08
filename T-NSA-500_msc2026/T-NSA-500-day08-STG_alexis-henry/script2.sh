#!/bin/bash

# Function to check if a user exists
verify_user_exists() {
    read -p "Enter username to verify: " username
    if id "$username" &>/dev/null; then
        echo "User '$username' exists."
    else
        echo "User '$username' does not exist."
    fi
}

# Function to get UID of a user
get_user_uid() {
    read -p "Enter username to get UID: " username
    if id -u "$username" &>/dev/null; then
        uid=$(id -u "$username")
        echo "UID of user '$username' is $uid."
    else
        echo "User '$username' does not exist."
    fi
}

# Display menu options
while true; do
    echo -e "\033[1;36mT-NSA-500>\033[0m MENU:"
    echo "1. Verify user exists"
    echo "2. Check UID"
    echo "q. Exit"
    read -p "" choice
    case $choice in
        1)
            verify_user_exists
            ;;
        2)
            get_user_uid
            ;;
        q)
            exit 0
            ;;
    esac
done