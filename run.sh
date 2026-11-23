#!/usr/bin/env bash
# ==============================================================================
# STUDENT ASSIGNMENT SUBMISSION & PLAGIARISM MONITORING SYSTEM
# File: run.sh
# Purpose: Master application launcher script
# Compatibility: Ubuntu / Linux / GitHub Codespaces / POSIX Bash
# ==============================================================================

export PATH="/usr/bin:/bin:$PATH"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

# Ensure execute permissions on internal scripts
chmod +x src/*.sh 2>/dev/null || true

# Launch master CLI application
exec bash "${SCRIPT_DIR}/src/main.sh" "$@"
