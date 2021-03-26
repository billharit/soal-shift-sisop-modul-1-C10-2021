#!/bin/bash

Raw_Data='syslog.log'

#1a
jenis_log=$(grep -oP "(INFO|ERROR)" "$Raw_Data")

pesan_log=$(grep -oP "(?<=[INFO|ERROR] ).*(?<=\ )" "$Raw_Data")

user_log=$(grep -oP "(?<=\().*(?=\))" "$Raw_Data")

#1b
error_message=$(grep -oP "(?<=ERROR ).*(?<=\ )" "$Raw_Data" | sort | uniq -c| sort -nr)

#1c
error_seluruh_user=$(grep -oP "(?<=ERROR ).*(?<=\))" "$Raw_Data")
info_seluruh_user=$(grep -oP "(?<=INFO ).*(?<=\))" "$Raw_Data")

#1d
echo "ERROR,COUNT" > "error_message.csv"
grep -oP "(?<=ERROR ).*(?<=\ )" "$Raw_Data" | sort | uniq -c | sort -nr | while read count pesan_log;
do
        printf "%s,%d\n" "$pesan_log" "$count" >> "error_message.csv"
done

#1e
echo "Username,INFO,ERROR" > "user_statistic.csv"
grep -oP "(?<=\().*(?=\))" "$Raw_Data" | sort | uniq | while read user;
do
    info_tiap_user=$(grep "$user" <<< "$info_seluruh_user" | wc -l);
    error_tiap_user=$(grep "$user" <<< "$error_seluruh_user" | wc -l);
    printf "%s,%d,%d\n" "$user" "$info_tiap_user" "$error_tiap_user" >> "user_statistic.csv"
done
