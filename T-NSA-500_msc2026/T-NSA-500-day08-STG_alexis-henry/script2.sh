#!/bin/bash

user_exists() {
    read -p "Enter username to verify: " username
    if id "$username" &>/dev/null; then
        echo "User '$username' exists."
    else
        echo "User '$username' does not exist."
    fi
}

user_uid() {
    read -p "Enter username to get UID: " username
    if id -u "$username" &>/dev/null; then
        uid=$(id -u "$username")
        echo "UID of user '$username' is $uid."
    else
        echo "User '$username' does not exist."
    fi
}

while true; do
    echo -e "\033[1;36mT-NSA-500>\033[0m MENU:"
    echo "1. Verify user exists"
    echo "2. Check UID"
    echo "q. Exit"
    read -p "" choice
    case $choice in
        1)
            user_exists
            ;;
        2)
            get_uid
            ;;
        q)
            exit 0
            ;;
    esac
done
