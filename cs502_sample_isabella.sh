#!/usr/bin/env bash
# ==============================================================================
# FICTIONAL DEMONSTRATION DATA - NOT REAL STUDENT WORK
# Course: CS502 - Operating Systems & Process Scheduling
# Assignment: Lab 3 - Process Memory and CPU Monitor using SED & PS
# Student: Henry Cavill (Roll No: CS2024-008)
# ==============================================================================

echo "=== System Process Snapshot Monitor ==="
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 10 | sed '1s/^/PROCESS SUMMARY TABLE:\n/'
