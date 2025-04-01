#!/bin/bash

Linux System Administration Tool Selector

Author: Claude

Date: April 1, 2025

Define color codes

RED='\e[31m' GREEN='\e[32m' YELLOW='\e[33m' BLUE='\e[34m' CYAN='\e[36m' RESET='\e[0m'

Clear the screen

clear

Function to display the introduction screen

display_intro() { echo -e "${CYAN}============================================================" echo "         LINUX SYSTEM ADMINISTRATION TOOL SELECTOR          " echo -e "============================================================${RESET}" echo "" echo -e "${GREEN}Author: Claude${RESET}" echo -e "${YELLOW}Date: $(date +"%B %d, %Y")${RESET}" echo "" echo -e "${BLUE}Description:${RESET}" echo "This script provides an easy-to-use interface for accessing" echo "common system administration tools and commands." echo "" echo -e "${BLUE}Requirements:${RESET}" echo "- Root/sudo privileges for system-level operations" echo "- Internet connection for update/upgrade operations" echo "- Bash shell environment" echo "" echo -e "${CYAN}============================================================${RESET}" echo "" read -p "Press Enter to continue..." clear }

Function to display an error message

display_error() { echo -e "\n${RED}Error: $1${RESET}\n" sleep 2 }

Function to execute a command

execute_command() { clear echo -e "${YELLOW}Executing: $1${RESET}" echo -e "${CYAN}============================================================${RESET}" echo "" eval "$1" echo "\n${CYAN}============================================================${RESET}" echo -e "${GREEN}Command execution completed.${RESET}" echo "" read -p "Press Enter to return to the main menu..." clear }

Function for custom command input

custom_command() { clear echo -e "${CYAN}Custom Command Entry${RESET}" echo -e "${CYAN}============================================================${RESET}" echo "Enter your custom command below. Type 'exit' to return to main menu." echo "" while true; do read -p "$ " cmd if [ "$cmd" = "exit" ]; then break elif [ -z "$cmd" ]; then display_error "Empty command. Please try again or type 'exit'." else execute_command "$cmd" break fi done }

Function to check and install necessary packages

install_package() { if ! command -v "$1" &>/dev/null; then echo -e "${YELLOW}$1 not found. Installing now...${RESET}" sudo apt install -y "$1" fi }

Function to display the main menu and handle user input

main_menu() { while true; do echo -e "${CYAN}============================================================${RESET}" echo -e "${BLUE}                      MAIN MENU                             ${RESET}" echo -e "${CYAN}============================================================${RESET}" echo "" echo -e "${GREEN}Select an option to execute:${RESET}" echo "" echo "  1) System Update & Upgrade" echo "  2) Disk Space Usage" echo "  3) Memory Usage" echo "  4) Process Monitor (htop)" echo "  5) Network Connections" echo "  6) System Services Status" echo "  7) User Account Management" echo "  8) Firewall Status" echo "  9) System Logs Viewer" echo " 10) Hardware Information" echo " 11) Custom Command" echo " 12) Exit" echo "" read -p "Enter your choice (1-12): " choice case $choice in 1) execute_command "sudo apt update && sudo apt upgrade -y" ;; 2) execute_command "df -h" ;; 3) execute_command "free -m" ;; 4) install_package "htop" && execute_command "htop" ;; 5) execute_command "sudo netstat -tuln" ;; 6) execute_command "sudo systemctl list-units --type=service" ;; 7) execute_command "sudo awk -F: '{print $1}' /etc/passwd" ;; 8) execute_command "sudo ufw status verbose" ;; 9) execute_command "sudo journalctl -n 50" ;; 10) install_package "lshw" && execute_command "sudo lshw -short" ;; 11) custom_command ;; 12) echo -e "${RED}Exiting script. Goodbye!${RESET}"; exit 0 ;; *) display_error "Invalid option. Please enter a number between 1 and 12." ;; esac done }

Check if script is run as root or with sudo

check_privileges() { if ! command -v sudo &>/dev/null; then echo -e "${RED}Warning: sudo is not installed. Some commands may fail.${RESET}" elif [ "$(id -u)" -ne 0 ]; then echo -e "${YELLOW}Some functions of this script require root privileges.${RESET}" echo "You may be prompted for your password when executing certain commands." echo "" read -p "Press Enter to continue..." fi }

Main script execution

display_intro check_privileges main_menu

