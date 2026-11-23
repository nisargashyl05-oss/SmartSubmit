#!/usr/bin/env bash
# ==============================================================================
# STUDENT ASSIGNMENT SUBMISSION & PLAGIARISM MONITORING SYSTEM
# File: install.sh
# Purpose: Environment preparation, permission setup, and dependency verification
# Compatibility: Ubuntu / Linux / GitHub Codespaces / POSIX Bash
# ==============================================================================

set -e
export PATH="/usr/bin:/bin:$PATH"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

echo "================================================================================"
echo " INSTALLING STUDENT ASSIGNMENT SUBMISSION & PLAGIARISM MONITORING SYSTEM"
echo " Target Environment: Linux / GitHub Codespaces"
echo "================================================================================"

echo ""
echo "[1/4] Setting execution permissions on shell scripts..."
chmod +x install.sh run.sh src/*.sh tests/*.sh 2>/dev/null || true
echo "      -> Permissions successfully updated."

echo ""
echo "[2/4] Verifying required Unix utilities..."
for tool in bash awk sed grep sha256sum date; do
    if command -v "$tool" >/dev/null 2>&1; then
        tool_version=$("$tool" --version 2>&1 | head -n 1 || echo "Available")
        echo "      [OK] $tool : $tool_version"
    else
        echo "      [WARNING] $tool is missing from PATH."
    fi
done

echo ""
echo "[3/4] Initializing required project directories..."
mkdir -p data \
         uploads/submissions \
         uploads/assignment_samples \
         reports \
         screenshots \
         documentation \
         tests
echo "      -> Directories verified: data, uploads, reports, screenshots, documentation."

echo ""
echo "[4/4] Initializing database tables..."
source src/utils.sh
init_database
echo "      -> Flat-file databases verified: students.db, assignments.db, submissions.db, reviews.db."

echo ""
echo "================================================================================"
echo " INSTALLATION COMPLETE! READY TO SUBMIT AND EXECUTE."
echo " To start the application, run:"
echo "     ./run.sh"
echo " or"
echo "     bash run.sh"
echo "================================================================================"
