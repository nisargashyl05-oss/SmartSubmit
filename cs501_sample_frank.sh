#!/usr/bin/env bash
# ==============================================================================
# FICTIONAL DEMONSTRATION DATA - NOT REAL STUDENT WORK
# Course: CS501 - Advanced Unix System Programming
# Assignment: Lab 2 - Web Server Access Log Analyzer in AWK
# Student: Frank Castle (Roll No: CS2024-006)
# ==============================================================================

input_log="${1:-access.log}"

echo "Processing Web Access Statistics for $input_log..."
awk -F' ' '
    $9 ~ /200/ { success++ }
    $9 ~ /404/ { notfound++ }
    $9 ~ /500/ { servererr++ }
    END {
        print "Total 200 OK:        " success
        print "Total 404 Not Found: " notfound
        print "Total 500 Server Err:" servererr
    }
' "$input_log"
