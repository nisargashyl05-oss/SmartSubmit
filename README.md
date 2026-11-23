# Student Assignment Submission and Plagiarism Monitoring System

An MS-level academic software engineering project built natively using **Unix/Linux Bash Shell Scripting**, **AWK**, **SED**, **GREP**, and **SHA-256** cryptographic utilities. Fully configured and tested for **1-click execution in GitHub Codespaces** and standard Ubuntu/Linux distributions.

---

## 1. Project Overview

The **Student Assignment Submission and Plagiarism Monitoring System** is an enterprise-grade terminal-based academic management platform designed for educational institutions. The system provides automated workflows for:
1. **Student Record Lifecycle Management**: Complete registration, profile management, and duplicate roll-number prevention.
2. **Assignment Scheduling & Deadline Management**: Automated deadline enforcement, on-time verification, and overdue submission detection.
3. **Multi-Version Submission Processing**: Automated file integrity verification, zero-byte file detection, and non-existent path flagging without accusatory bias.
4. **Cryptographic Duplicate & Plagiarism Monitoring**: Cryptographic SHA-256 content hashing to detect identical file submissions across students, providing faculty review workflows.
5. **Academic Grading & Faculty Remarks**: Structured evaluation criteria, grade assignments, status progression, and comprehensive audit history.
6. **Analytical Reporting**: Comprehensive summary statistics, audit logs, formatted plain text reports, and spreadsheet-ready RFC-4180 CSV exports.

---

## 2. HOW TO RUN THIS PROJECT IN GITHUB CODESPACES

The project includes pre-configured `.devcontainer/devcontainer.json` files for instant launch in GitHub Codespaces.

### Step 1: Open the Repository in Codespaces
1. Open your repository on GitHub.
2. Click the green **Code** button.
3. Select the **Codespaces** tab and click **Create codespace on main**.
4. GitHub Codespaces will automatically spin up an Ubuntu Linux environment and set file permissions.

### Step 2: One-Step Installation & Verification
In the integrated Linux terminal, run:

```bash
chmod +x install.sh run.sh src/*.sh tests/*.sh
./install.sh
```

This validates required Unix tools (`bash`, `awk`, `sed`, `grep`, `sha256sum`), verifies directory permissions, and initializes the flat-file databases.

### Step 3: Launch the Application
Run:

```bash
./run.sh
```
*(Alternatively, run `bash run.sh`)*

### Step 4: Run the Complete Automated Test Suite
To verify all 10 modules and 28 automated test assertions:

```bash
bash tests/test_project.sh
```

---

## 3. Folder Structure

```
Student_Assignment_Management_System/
│
├── .devcontainer/
│   └── devcontainer.json            # Codespaces environment configuration
│
├── src/                             # Core Application Modules (Bash)
│   ├── main.sh                      # Master CLI dashboard & 19-option menu
│   ├── utils.sh                     # Color formatting, date comparison, DB helpers
│   ├── students.sh                  # Module 1: Student CRUD & duplicate roll check
│   ├── assignments.sh               # Module 2: Assignment creation & deadlines
│   ├── submissions.sh               # Modules 3, 4, 6: Submissions, versions, fake checks
│   ├── plagiarism.sh                # Module 7: SHA-256 duplicate collision detection
│   ├── remarks.sh                   # Modules 8, 9: Faculty grading, review, remarks
│   └── reports.sh                   # Modules 5, 10: Reports, CSV/TXT exports, dashboard
│
├── data/                            # Persistent Flat-File Databases
│   ├── students.db                  # RollNo|Name|Department|Email|RegDate
│   ├── assignments.db               # AssignmentID|Title|Subject|Deadline|CreatedDate
│   ├── submissions.db               # SubID|RollNo|AssgnID|FilePath|Time|SHA256|Ver|Status|Late
│   └── reviews.db                   # RevID|SubID|RollNo|AssgnID|Faculty|Status|Grade|Outcome|Remarks|Date
│
├── uploads/                         # File Storage
│   ├── assignment_samples/          # Realistic fictional test assignments
│   └── submissions/                 # Archived student submissions with versioning
│
├── reports/                         # Generated Reports
│   ├── submission_report.txt        # Detailed formatted human-readable report
│   ├── submission_report.csv        # Tabular export for Excel/spreadsheets
│   └── duplicate_detection_log.txt  # Plagiarism audit cluster logs
│
├── screenshots/                     # Actual Terminal Execution Captures
│   ├── 01_main_menu.png
│   ├── 02_student_registration.png
│   ├── 03_assignment_creation.png
│   ├── 04_assignment_submission.png
│   ├── 05_late_submission_detection.png
│   ├── 06_empty_and_fake_file_check.png
│   ├── 07_duplicate_detection_sha256.png
│   ├── 08_faculty_plagiarism_review.png
│   ├── 09_faculty_remarks_and_grading.png
│   └── 10_final_submission_report.png
│
├── documentation/                   # Complete Academic Project Documentation
│   ├── Project_Report.docx          # MS-Level 31-Section Academic Project Report
│   ├── Project_Report.pdf           # Formatted Academic Report PDF
│   ├── README.md                    # Detailed Guide
│   ├── Installation_Guide.md        # Environment Setup and Prerequisites
│   ├── Testing_Report.md            # Detailed Test Cases & Execution Logs
│   └── Viva_Questions.md            # 30+ Viva Voce Questions & Answers
│
├── tests/
│   └── test_project.sh              # 28-Assertion Automated Test Suite
│
├── install.sh                       # Environment Setup & Dependency Verification
├── run.sh                           # Application Launcher Script
└── Student_Assignment_Management_System.zip # Complete Submission Archive
```

---

## 4. Technical Requirements

- **Operating System**: Linux (Ubuntu 20.04 LTS or newer recommended), GitHub Codespaces, or WSL2.
- **Shell**: GNU Bash 4.4+ (Standard POSIX shell syntax).
- **Core Utilities**:
  - `awk` (GNU Awk / mawk)
  - `sed` (GNU Sed)
  - `grep` (GNU Grep)
  - `sha256sum` (GNU coreutils)
  - `date`, `wc`, `cat`, `cut`, `mktemp`
