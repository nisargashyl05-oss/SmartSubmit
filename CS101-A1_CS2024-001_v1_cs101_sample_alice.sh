#!/usr/bin/env bash
# ==============================================================================
# FICTIONAL DEMONSTRATION DATA - NOT REAL STUDENT WORK
# Course: CS101 - Introduction to Unix Systems & Shell Scripting
# Assignment: Lab 1 - Word Counter and Text Analyzer
# Student: Alice Johnson (Roll No: CS2024-001)
# ==============================================================================

echo "=== Text File Analyzer v1.0 ==="
target_file="${1:-sample.txt}"

if [[ ! -f "$target_file" ]]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

lines=$(wc -l < "$target_file")
words=$(wc -w < "$target_file")
chars=$(wc -m < "$target_file")

echo "File: $target_file"
echo "Total Lines: $lines"
echo "Total Words: $words"
echo "Total Characters: $chars"
