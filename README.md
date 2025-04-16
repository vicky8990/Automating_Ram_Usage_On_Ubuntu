# Automating_Ram_Usage_On_Ubuntu

📌 Project Overview
This project automates the process of monitoring RAM usage on an Ubuntu system. It logs memory usage at regular intervals and sends an alert to your private email when usage crosses a predefined threshold.

🧰 Tools & Technologies
Ubuntu (WSL or full install)
Bash scripting
Cron jobs
Sendmail / mailutils
Log rotation (optional)

📂 Project Structure
VickyDevops/
├── ram_monitor.sh         # Main script to monitor RAM
└── README.md              # Project documentation

🔧 Setup Instructions
1. 🖥️ Clone/Copy the Script
Create the script in your preferred directory:
nano ~/ram_monitor.sh

Paste the following:
#!/bin/bash

THRESHOLD=80
EMAIL="yourname@example.com"
LOGFILE="/root/ram_usage.log"

# Get current RAM usage
USAGE=$(free | awk '/Mem/{printf("%.0f"), $3/$2 * 100.0}')

# Log usage
echo "$(date): RAM Usage is ${USAGE}%" >> "$LOGFILE"

# Send mail if usage exceeds threshold
if [ "$USAGE" -ge "$THRESHOLD" ]; then
    echo "Alert: High RAM usage detected - ${USAGE}%!" | mail -s "RAM Alert on $(hostname)" "$EMAIL"
fi


2. ✅ Make It Executable
    chmod +x ~/ram_monitor.sh

🕒 3. Set up a Cron Job
    sudo crontab -e
    
Add this line to run every 5 minutes:
   */5 * * * * /root/ram_monitor.sh > /dev/null 2>&1
   
Move the script to root:
  sudo mv ~/ram_monitor.sh /root/

📧 4. Setup Email Notifications
Option A: Install mailutils
   sudo apt update
   sudo apt install mailutils

Configure sendmail properly:
   sudo sendmailconfig

Optionally test it:
   echo "Test Email Body" | mail -s "Test Subject" yourname@example.com

Ensure port 25 is not blocked by your ISP (or use tools like msmtp or SMTP relays like Gmail with App Passwords).

📄 5. Check RAM Logs
   sudo cat /root/ram_usage.log

✅ Optional: Log Rotation
To prevent the log file from growing indefinitely, set up logrotate.

Create /etc/logrotate.d/ram_monitor:
  sudo nano /etc/logrotate.d/ram_monitor

 Paste:
  /root/ram_usage.log {
    daily
    missingok
    rotate 7
    compress
    notifempty
    create 640 root root
}


🚨 Email Alert Example
You'll receive an email like:
  Subject: RAM Alert on LAPTOP-G28L2EJ3
  Body: Alert: High RAM usage detected - 82%!


🧪 Testing
Force high RAM or temporarily lower the threshold to verify alerts:
    # Temporarily set threshold to 1% to test:
        THRESHOLD=1

The Output Should Look like this.
      
 2025-04-16 19:11:07 - Used: 613Mi, Free: 3.0Gi
 2025-04-16 19:11:16 - Used: 612Mi, Free: 3.0Gi
 2025-04-16 19:11:24 - Used: 613Mi, Free: 3.0Gi
 2025-04-16 19:12:06 - Used: 613Mi, Free: 3.0Gi
 2025-04-16 19:13:05 - Used: 613Mi, Free: 3.0Gi
 2025-04-16 19:14:07 - Used: 612Mi, Free: 3.0Gi
 2025-04-16 19:15:07 - Used: 615Mi, Free: 3.0Gi
 RAM usage at Wed Apr 16 19:16:02 UTC 2025:
 Mem:           3.7Gi       610Mi       3.0Gi       3.8Mi       244Mi       3.1Gi
 -------------------------------
 RAM usage at Wed Apr 16 19:16:07 UTC 2025:
 Mem:           3.7Gi       611Mi       3.0Gi       3.8Mi       244Mi       3.1Gi
 -------------------------------
 RAM usage at Wed Apr 16 19:17:04 UTC 2025:
 Mem:           3.7Gi       611Mi       3.0Gi       3.8Mi       244Mi       3.1Gi
 -------------------------------
 RAM usage at Wed Apr 16 19:17:20 UTC 2025:
 Mem:           3.7Gi       611Mi       3.0Gi       3.8Mi       244Mi       3.1Gi
 -------------------------------
 RAM usage at Wed Apr 16 19:17:24 UTC 2025:
 Mem:           3.7Gi       611Mi       3.0Gi       3.8Mi       244Mi       3.1Gi
 -------------------------------
 RAM usage at Wed Apr 16 19:18:07 UTC 2025:
 Mem:           3.7Gi       611Mi       3.0Gi       3.8Mi       244Mi       3.1Gi

     
