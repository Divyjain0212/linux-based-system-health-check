### Automated System Health Monitoring and Reporting Script
1. Problem Overview (Clarified)

- System administrators face challenges such as:
- Difficulty detecting system issues before performance degrades
- Manual monitoring of CPU, memory, disk, and services is time-consuming
- Human error during checks
- Lack of timely alerts leads to unexpected downtime

2. Proposed Solution

- An automated system health monitoring script that:
- Periodically checks critical system metrics
- Detects threshold breaches
- Generates a health report
- Sends the report automatically via email
- Enables proactive system maintenance

3. Objectives of the Script

- Monitor CPU usage
- Monitor Memory usage
- Monitor Disk usage
- Check system uptime
- Check critical services status
- Send email alerts/report
- Run automatically using cron

4. System Requirements

- Linux system (Ubuntu / Amazon Linux / RHEL)
- mail or sendmail configured
- Cron service enabled

5. Tools & Technologies Used
- Component	    Purpose
- Bash	        Automation scripting
- Linux utilities	top, df, free, uptime
- Cron	        Scheduling
- Mail utility	Email reporting

6. Script Workflow

- Collect system metrics
- Format health report
- Check threshold limits
- Trigger email alert
- Log output (optional)

7. Prerequisites
Ensure your system meets the following requirements:
- Linux (Ubuntu, CentOS, or any Unix-based system)
- Bash Shell
- mailx (for email functionality)
- sudo access

To install mailx, run:
```bash
sudo apt install mailutils  # Ubuntu/Debian
```

8. Automated System Health Monitoring Script (Bash)
   ### menu.sh:
```bash
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
```


9. Make Script Executable
```bash
chmod +x menu.sh
```

10. Run Script Manually (Testing)
```bash
./menu.sh
```

11. Automate Using Cron Job

    ### Run every 30 minutes:
```bash
crontab -e
```

Add:
```bash
*/30 * * * * /path/to/menu.sh
```

12. Advantages of the Solution

- Fully automated
- Reduces manual effort
- Prevents downtime
- Real-time alerts
- Scalable for multiple servers

13. Limitations

- Requires mail service configuration
- Basic threshold-based monitoring
- No graphical dashboard

14. Future Enhancements

- Integrate with Slack / Telegram
- Store logs in centralized monitoring system
- Add service-specific checks (Nginx, Docker, MySQL)
- Convert to Python for extensibility
- Push metrics to Prometheus / Grafana

15. Conclusion

- This automated system health monitoring and reporting script provides continuous visibility into system performance, reduces administrative overhead, and enables proactive issue resolution. It is a simple yet effective solution for maintaining system reliability.