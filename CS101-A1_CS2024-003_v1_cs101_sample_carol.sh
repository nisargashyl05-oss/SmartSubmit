#!/usr/bin/env bash
# ==============================================================================
# FICTIONAL DEMONSTRATION DATA - NOT REAL STUDENT WORK
# Course: CS101 - Introduction to Unix Systems & Shell Scripting
# Assignment: Lab 1 - Word Counter and Text Analyzer
# Student: Carol Danvers (Roll No: CS2024-003)
# ==============================================================================

input_path="${1:-document.txt}"

if [ ! -r "$input_path" ]; then
    printf "Error: Cannot read target file '%s'\n" "$input_path" >&2
    exit 2
fi

printf "Document Statistics for %s:\n" "$input_path"
awk '
    { lines++; words += NF; chars += length($0) + 1 }
    END {
        print "Line Count:      " lines
        print "Word Count:      " words
        print "Character Count: " chars
    }
' "$input_path"
