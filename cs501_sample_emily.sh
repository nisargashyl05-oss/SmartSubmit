#!/usr/bin/env bash
# ==============================================================================
# FICTIONAL DEMONSTRATION DATA - NOT REAL STUDENT WORK
# Course: CS501 - Advanced Unix System Programming
# Assignment: Lab 2 - Web Server Access Log Analyzer in AWK
# Student: Emily Watson (Roll No: CS2024-005)
# ==============================================================================

logfile="${1:-/var/log/nginx/access.log}"

if [[ ! -f "$logfile" ]]; then
    echo "Log file not found: $logfile"
    exit 1
fi

echo "Top 5 IP Addresses:"
awk '{ ip[$1]++ } END { for (i in ip) print ip[i], i }' "$logfile" | sort -rn | head -n 5

echo "HTTP Status Code Distribution:"
awk '{ status[$9]++ } END { for (s in status) print s ": " status[s] }' "$logfile"
