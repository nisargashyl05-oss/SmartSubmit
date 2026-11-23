# Installation and Setup Guide

## Student Assignment Submission and Plagiarism Monitoring System

### 1. System Requirements

The system runs on any POSIX-compliant Unix/Linux operating environment.

#### Supported Environments
- **GitHub Codespaces** (Ubuntu Linux container) - Recommended
- **Ubuntu Linux** (20.04 LTS, 22.04 LTS, 24.04 LTS)
- **Debian / Fedora / CentOS / Arch Linux**
- **macOS** (with Bash 4+ and GNU coreutils)
- **Windows Subsystem for Linux (WSL / WSL2)**

#### Core Dependencies
The system relies exclusively on GNU standard command-line tools:
- `bash` (GNU Bourne-Again Shell, version 4.4 or newer)
- `awk` (GNU Awk `gawk` or `mawk`)
- `sed` (GNU stream editor)
- `grep` (GNU grep)
- `sha256sum` (GNU coreutils cryptographic checksum)
- `date`, `cut`, `tr`, `wc`, `find`, `mktemp`

---

### 2. GitHub Codespaces Setup (Step-by-Step)

1. **Repository Access**: Open the repository on GitHub.
2. **Launch Codespace**: Click **Code** -> **Codespaces** -> **Create codespace on main**.
3. **Automatic Provisioning**: GitHub automatically reads `.devcontainer/devcontainer.json`, launches an Ubuntu 22.04 LTS container, installs Bash IDE tools, and configures the environment.
4. **Execution Permissions**:
   ```bash
   chmod +x install.sh run.sh src/*.sh tests/*.sh
   ```
5. **Run Installer**:
   ```bash
   ./install.sh
   ```
6. **Launch Application**:
   ```bash
   ./run.sh
   ```

---

### 3. Local Ubuntu / Debian Linux Setup

```bash
# 1. Update package manager
sudo apt-get update

# 2. Ensure core tools are installed
sudo apt-get install -y bash coreutils gawk sed grep

# 3. Clone or extract the project archive
unzip Student_Assignment_Management_System.zip
cd Student_Assignment_Management_System

# 4. Set execution permissions
chmod +x install.sh run.sh src/*.sh tests/*.sh

# 5. Run installation script
./install.sh

# 6. Execute application
./run.sh
```

---

### 4. Running the Automated Test Suite

To verify that all system dependencies and logical assertions function as expected:

```bash
bash tests/test_project.sh
```

Expected output:
```
================================================================================
 AUTOMATED TEST RESULTS SUMMARY
================================================================================
 Total Passed: 28
 Total Failed: 0
>> ALL AUTOMATED TEST CASES PASSED SUCCESSFULLY (100% PASS RATE)! <<
```

---

### 5. Verification Checklist

- [x] All 8 scripts in `src/` have execute permissions (`chmod +x`).
- [x] Directories `data/`, `uploads/submissions/`, `reports/`, `screenshots/` exist.
- [x] `data/students.db`, `data/assignments.db`, `data/submissions.db`, `data/reviews.db` initialized with pipe-delimited headers.
- [x] Test suite reports 100% pass rate.
