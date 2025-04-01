#!/bin/bash
#
# Linux System Administration Tool Selector
# Author: Claude
# Description: An interactive menu-based script for common system administration tasks
# Date: April 1, 2025

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
RESET='\033[0m'

# Clear the screen
clear

# Function to display the introduction screen
display_intro() {
    echo -e "${BLUE}============================================================${RESET}"
    echo -e "${BOLD}${CYAN}         LINUX SYSTEM ADMINISTRATION TOOL SELECTOR          ${RESET}"
    echo -e "${BLUE}============================================================${RESET}"
    echo ""
    echo -e "${GREEN}Author:${RESET} Claude"
    echo -e "${GREEN}Date:${RESET} $(date +"%B %d, %Y")"
    echo ""
    echo -e "${YELLOW}Description:${RESET}"
    echo -e "This script provides an easy-to-use interface for accessing"
    echo -e "common system administration tools and commands."
    echo ""
    echo -e "${MAGENTA}Requirements:${RESET}"
    echo -e "- ${CYAN}Root/sudo privileges${RESET} for system-level operations"
    echo -e "- ${CYAN}Internet connection${RESET} for update/upgrade operations"
    echo -e "- ${CYAN}Bash shell environment${RESET}"
    echo ""
    echo -e "${BLUE}============================================================${RESET}"
    echo ""
    echo -e "${YELLOW}Press Enter to continue...${RESET}"
    read input
    clear
}

# Function to display an error message
display_error() {
    echo ""
    echo -e "${RED}Error: $1${RESET}"
    echo ""
    sleep 2
}

# Function to execute a command
execute_command() {
    clear
    echo -e "${YELLOW}Executing:${RESET} ${CYAN}$1${RESET}"
    echo -e "${BLUE}============================================================${RESET}"
    echo ""
    
    # Execute the command
    eval "$1"
    
    echo ""
    echo -e "${BLUE}============================================================${RESET}"
    echo -e "${GREEN}Command execution completed.${RESET}"
    echo ""
    echo -e "${YELLOW}Press Enter to return to the main menu...${RESET}"
    read input
    clear
}

# Function for custom command input
custom_command() {
    clear
    echo -e "${CYAN}${BOLD}Custom Command Entry${RESET}"
    echo -e "${BLUE}============================================================${RESET}"
    echo -e "${WHITE}Enter your custom command below. Type '${YELLOW}exit${WHITE}' to return to main menu.${RESET}"
    echo -e "${RED}Warning: Commands will be executed with sudo privileges if necessary.${RESET}"
    echo ""
    
    while true; do
        echo -ne "${GREEN}$ sudo ${RESET}"
        read cmd
        
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
        echo -e "${BLUE}============================================================${RESET}"
        echo -e "${BOLD}${CYAN}                      MAIN MENU                             ${RESET}"
        echo -e "${BLUE}============================================================${RESET}"
        echo ""
        echo -e "${YELLOW}Select an option to execute:${RESET}"
        echo ""
        echo -e "  ${GREEN}1)${RESET} ${WHITE}System Update & Upgrade${RESET}"
        echo -e "  ${GREEN}2)${RESET} ${WHITE}Disk Space Usage${RESET}"
        echo -e "  ${GREEN}3)${RESET} ${WHITE}Memory Usage${RESET}"
        echo -e "  ${GREEN}4)${RESET} ${WHITE}Process Monitor (htop)${RESET}"
        echo -e "  ${GREEN}5)${RESET} ${WHITE}Network Connections${RESET}"
        echo -e "  ${GREEN}6)${RESET} ${WHITE}System Services Status${RESET}"
        echo -e "  ${GREEN}7)${RESET} ${WHITE}User Account Management${RESET}"
        echo -e "  ${GREEN}8)${RESET} ${WHITE}Firewall Status${RESET}"
        echo -e "  ${GREEN}9)${RESET} ${WHITE}System Logs Viewer${RESET}"
        echo -e " ${GREEN}10)${RESET} ${WHITE}Hardware Information${RESET}"
        echo ""
        echo -e " ${MAGENTA}11)${RESET} ${CYAN}Custom Command${RESET}"
        echo -e " ${RED}12)${RESET} ${BOLD}Exit${RESET}"
        echo ""
        echo -ne "${YELLOW}Enter your choice (1-12):${RESET} "
        read choice
        
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
                echo -e "${GREEN}Exiting script. Goodbye!${RESET}"
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
        echo -e "${YELLOW}Some functions of this script require root privileges.${RESET}"
        echo -e "${YELLOW}You may be prompted for your password when executing certain commands.${RESET}"
        echo ""
        echo -e "${CYAN}Press Enter to continue...${RESET}"
        read input
    fi
}

# Function to install Termux packages
install_termux_packages() {
    clear
    echo -e "${BLUE}============================================================${RESET}"
    echo -e "${BOLD}${CYAN}             INSTALLING TERMUX BASIC PACKAGES               ${RESET}"
    echo -e "${BLUE}============================================================${RESET}"
    echo ""
    echo -e "${YELLOW}This will install multiple essential packages in Termux.${RESET}"
    echo -e "${YELLOW}The process may take some time depending on your connection.${RESET}"
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
    echo -e "${BLUE}============================================================${RESET}"
    echo -e "${GREEN}${BOLD}Package installation completed.${RESET}"
    echo ""
    echo -e "${YELLOW}Press Enter to continue to the main menu...${RESET}"
    read input
    clear
}

# Main script execution
display_intro
install_termux_packages
check_privileges
main_menu
