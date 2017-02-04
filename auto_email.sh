#!/bin/bash

######################################################
#   ________.__                                      #
#  /  _____/|__| _________    _____________   ____   # 
# /   \  ___|  |/ ___\__  \  /  ___/\_  __ \_/ ___\  # 
# \    \_\  \  / /_/  > __ \_\___ \  |  | \/\  \___  # 
#  \______  /__\___  (____  /____  > |__|    \___  > #
#          \/  /_____/     \/     \/              \/ # 
# ___________              .__.__                    # 
# \_   _____/ _____ _____  |__|  |   ___________     # 
#  |    __)_ /     \\__  \ |  |  | _/ __ \_  __ \    #  
#  |        \  Y Y  \/ __ \|  |  |_\  ___/|  | \/    #
# /_______  /__|_|  (____  /__|____/\___  >__|       #
#         \/      \/     \/             \/           #
#                                                    #
######################################################
######################################################
##
## Author: John Ciavarella
## 
## Changelog
## 
## Jan-18-2013: Beta created
##
######################################################
######################################################

#######################################
#
# Pre Check
#
#######################################
pre_check(){
echo lol
}
#######################################
#
# Main Body  
#
#######################################

from_email="logs@gigasrc.com"
to_email="email@gmail.com"
filename="NULL"
hostname=$(hostname)

squidlogs (){
        filename="squid_logs.tar"
        file_loc="/var/log/squid3/*"
        sudo tar cvfP $filename $file_loc
        echo "sudo tar -cvf $filename $file_loc"
        echo "Logs created"
        (cat /tmp/mail.temp ;uuencode $filename $filename) |mail -s "Auto Report Squid - $hostname" $to_email -- -r $from_email
}

sysinfo (){
        filename="sysinfo.txt"
        ipinfo=$(ifconfig | grep inet | grep --invert-match inet6 |  grep --invert-match 127.0.0.1)
        vmstat=$(vmstat -S m|tail -1)
        echo -e "Hostname:$hostname\nIP Address:$ipinfo\n\nVMStat Info:\n r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa\n$vmstat" > $filename
        (cat /tmp/mail.temp ;uuencode $filename $filename) |mail -s "Auto Report Sysinfo - $hostname" $to_email -- -r $from_email
}



#######################################
#
# Actually calls the reports
#
#######################################

# Uncomment the following options as desired.

sysinfo
#squidlogs




























