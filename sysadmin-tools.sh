#!/bin/bash
#
# Linux System Administration Tool Selector
# Author: Claude
# Description: An interactive menu-based script for common system administration tasks
# Date: April 1, 2025

# Clear the screen
clear

# Function to display the introduction screen
display_intro() {
    echo "============================================================"
    echo "         LINUX SYSTEM ADMINISTRATION TOOL SELECTOR          "
    echo "============================================================"
    echo ""
    echo "Author: Claude"
    echo "Date: $(date +"%B %d, %Y")"
    echo ""
    echo "Description:"
    echo "This script provides an easy-to-use interface for accessing"
    echo "common system administration tools and commands."
    echo ""
    echo "Requirements:"
    echo "- Root/sudo privileges for system-level operations"
    echo "- Internet connection for update/upgrade operations"
    echo "- Bash shell environment"
    echo ""
    echo "============================================================"
    echo ""
    read -p "Press Enter to continue..." input
    clear
}

# Function to display an error message
display_error() {
    echo ""
    echo "Error: $1"
    echo ""
    sleep 2
}

# Function to execute a command
execute_command() {
    clear
    echo "Executing: $1"
    echo "============================================================"
    echo ""
    
    # Execute the command
    eval "$1"
    
    echo ""
    echo "============================================================"
    echo "Command execution completed."
    echo ""
    read -p "Press Enter to return to the main menu..." input
    clear
}

# Function for custom command input
custom_command() {
    clear
    echo "Custom Command Entry"
    echo "============================================================"
    echo "Enter your custom command below. Type 'exit' to return to main menu."
    echo "Warning: Commands will be executed with sudo privileges if necessary."
    echo ""
    
    while true; do
        read -p "$ sudo " cmd
        
        if [ "$cmd" = "exit" ]; then
            break
        elif [ -z "$cmd" ]; then
            display_error "Empty command. Please try again or type 'exit'."
        else
            execute_command "sudo $cmd"
            break
        fi
    done
}

# Function to display the main menu and handle user input
main_menu() {
    while true; do
        echo "============================================================"
        echo "                      MAIN MENU                             "
        echo "============================================================"
        echo ""
        echo "Select an option to execute:"
        echo ""
        echo "  1) System Update & Upgrade"
        echo "  2) Disk Space Usage"
        echo "  3) Memory Usage"
        echo "  4) Process Monitor (htop)"
        echo "  5) Network Connections"
        echo "  6) System Services Status"
        echo "  7) User Account Management"
        echo "  8) Firewall Status"
        echo "  9) System Logs Viewer"
        echo " 10) Hardware Information"
        echo ""
        echo " 11) Custom Command"
        echo " 12) Exit"
        echo ""
        read -p "Enter your choice (1-12): " choice
        
        case $choice in
            1)
                execute_command "sudo apt update && sudo apt upgrade -y"
                ;;
            2)
                execute_command "df -h"
                ;;
            3)
                execute_command "free -m"
                ;;
            4)
                execute_command "if command -v htop >/dev/null; then sudo htop; else echo 'htop is not installed. Installing now...'; sudo apt install htop -y; sudo htop; fi"
                ;;
            5)
                execute_command "sudo netstat -tuln"
                ;;
            6)
                execute_command "sudo systemctl list-units --type=service"
                ;;
            7)
                execute_command "sudo cat /etc/passwd | grep -v nologin | grep -v false"
                ;;
            8)
                execute_command "sudo ufw status verbose"
                ;;
            9)
                execute_command "sudo journalctl -n 50"
                ;;
            10)
                execute_command "sudo lshw -short"
                ;;
            11)
                custom_command
                ;;
            12)
                echo "Exiting script. Goodbye!"
                exit 0
                ;;
            *)
                display_error "Invalid option. Please enter a number between 1 and 12."
                ;;
        esac
    done
}

# Check if script is run as root or with sudo
check_privileges() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Some functions of this script require root privileges."
        echo "You may be prompted for your password when executing certain commands."
        echo ""
        read -p "Press Enter to continue..." input
    fi
}

# Function to install Termux packages
install_termux_packages() {
    clear
    echo "============================================================"
    echo "             INSTALLING TERMUX BASIC PACKAGES               "
    echo "============================================================"
    echo ""
    echo "This will install multiple essential packages in Termux."
    echo "The process may take some time depending on your connection."
    echo ""
    
    # Execute the package installation commands
    pkg update -y && 
    pkg upgrade -y &&
    pkg install python -y &&
    pkg install python2 -y &&
    pkg install python2-dev -y &&
    pkg install python3 -y &&
    pkg install java -y &&
    pkg install fish -y &&
    pkg install ruby -y &&
    pkg install help -y &&
    pkg install git -y &&
    pkg install host -y &&
    pkg install php -y &&
    pkg install perl -y &&
    pkg install nmap -y &&
    pkg install bash -y &&
    pkg install clang -y &&
    pkg install nano -y &&
    pkg install w3m -y &&
    pkg install havij -y &&
    pkg install hydra -y &&
    pkg install figlet -y &&
    pkg install cowsay -y &&
    pkg install curl -y &&
    pkg install tar -y &&
    pkg install zip -y &&
    pkg install unzip -y &&
    pkg install tor -y &&
    pkg install google -y &&
    pkg install sudo -y &&
    pkg install wget -y &&
    pkg install wireshark -y &&
    pkg install wgetrc -y &&
    pkg install wcalc -y &&
    pkg install bmon -y &&
    pkg install vpn -y &&
    pkg install unrar -y &&
    pkg install toilet -y &&
    pkg install proot -y &&
    pkg install net-tools -y &&
    pkg install golang -y &&
    pkg install chroot -y &&
    termux-chroot -y &&
    pkg install macchanger -y &&
    pkg install openssl -y &&
    pkg install cmatrix -y &&
    pkg install openssh -y &&
    pkg install wireshark -y &&
    termux-setup-storage -y &&
    pkg install macchanger -y &&
    apt update && apt upgrade -y
    
    echo ""
    echo "============================================================"
    echo "Package installation completed."
    echo ""
    read -p "Press Enter to continue to the main menu..." input
    clear
}

# Main script execution
display_intro
install_termux_packages
check_privileges
main_menu
