#!/bin/bash
LOG_FILE="/var/log/system_health.log"
EMAIL="divyj12349@gmail.com"
REPORT_FILE="/tmp/system_health_report.txt"

check_disk_usage() {
    echo "Checking Disk Usage..."
    df -h
}

check_running_services() {
    echo "Listing Running Services..."
    systemctl list-units --type=service --state=running
}

check_memory_usage() {
    echo "Checking Memory Usage..."
    free -m
}

check_cpu_usage() {
    echo "Checking CPU Usage..."
    top -bn1 | grep "Cpu"
}

send_system_report() {
    echo "Generating System Health Report..."

    {
        echo "================================="
        echo "        SYSTEM HEALTH REPORT"
        echo "================================="
        echo "Hostname : $(hostname)"
        echo "Date     : $(date)"
        echo ""
        echo "---- Disk Usage ----"
        df -h
        echo ""
        echo "---- Running Services ----"
        systemctl list-units --type=service --state=running
        echo ""
        echo "---- Memory Usage ----"
        free -m
        echo ""
        echo "---- CPU Usage ----"
        top -bn1 | grep "Cpu"
    } > "$REPORT_FILE"

    mail -s "System Health Report - $(hostname)" "$EMAIL" < "$REPORT_FILE"

    echo "Report sent successfully to $EMAIL"
}

# Menu Loop
while true; do
    clear
    echo "================================="
    echo "     SYSTEM HEALTH CHECK MENU"
    echo "================================="
    echo "1. Check Disk Usage"
    echo "2. Check Running Services"
    echo "3. Check Memory Usage"
    echo "4. Check CPU Usage"
    echo "5. Send Full System Report (Email)"
    echo "6. Exit"
    echo "================================="

    read -p "Enter your choice: " choice

    case $choice in
        1) check_disk_usage ;;
        2) check_running_services ;;
        3) check_memory_usage ;;
        4) check_cpu_usage ;;
        5) send_system_report ;;
        6) echo "Exiting System Monitor..."; exit 0 ;;
        *) echo "Invalid option. Please select again." ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
done
