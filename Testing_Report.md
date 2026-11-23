# Comprehensive Software Testing & Verification Report

## Student Assignment Submission and Plagiarism Monitoring System

**Document Version**: 2.0  
**Testing Framework**: Native Automated Shell Assertion Suite (`tests/test_project.sh`)  
**Target Environment**: GitHub Codespaces (Ubuntu Linux 22.04 LTS / GNU Bash 5.2)  
**Overall Result**: 28 Passed / 0 Failed (100% Pass Rate)  

---

### 1. Testing Methodology & Strategy

The project adopts a multi-tier testing strategy comprising:
1. **Static Analysis & Syntax Validation**: Validation of all shell scripts using `bash -n` to ensure syntax conformance before runtime.
2. **Unit & Module Testing**: Individual validation of functions across student management, assignment scheduling, submission ingestion, and hash calculation.
3. **Integration & Flow Testing**: Testing end-to-end user workflows: student registration -> assignment creation -> submission ingestion -> SHA-256 collision detection -> faculty evaluation -> report generation.
4. **Boundary & Edge Case Testing**: Evaluating resilience against 0-byte files, non-existent paths, invalid date strings, duplicate primary keys, and versioning increments.
5. **Data Persistence Testing**: Validating flat-file persistence and consistency across simulated system restarts.

---

### 2. Static Code Syntax Validation Results

The command `bash -n <script>` compiles and validates shell syntax without execution.

| Script Name | Path | Syntax Check Command | Exit Code | Validation Status |
| :--- | :--- | :--- | :--- | :--- |
| Main Menu & Dashboard | `src/main.sh` | `bash -n src/main.sh` | 0 | **PASSED** |
| Shared Utilities & DB | `src/utils.sh` | `bash -n src/utils.sh` | 0 | **PASSED** |
| Student Management | `src/students.sh` | `bash -n src/students.sh` | 0 | **PASSED** |
| Assignment Scheduling | `src/assignments.sh` | `bash -n src/assignments.sh` | 0 | **PASSED** |
| Submission Engine | `src/submissions.sh` | `bash -n src/submissions.sh` | 0 | **PASSED** |
| Plagiarism & SHA-256 | `src/plagiarism.sh` | `bash -n src/plagiarism.sh` | 0 | **PASSED** |
| Faculty Review & Remarks | `src/remarks.sh` | `bash -n src/remarks.sh` | 0 | **PASSED** |
| Analytics & Reports | `src/reports.sh` | `bash -n src/reports.sh` | 0 | **PASSED** |
| Installation Script | `install.sh` | `bash -n install.sh` | 0 | **PASSED** |
| Launch Script | `run.sh` | `bash -n run.sh` | 0 | **PASSED** |
| Test Suite Script | `tests/test_project.sh` | `bash -n tests/test_project.sh` | 0 | **PASSED** |

---

### 3. Automated Test Cases Matrix

| Test ID | Module | Scenario / Objective | Input Data | Expected Result | Actual Result | Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **TC01** | Student Mgmt | Register 10 realistic student records | 10 student records array | 10 lines in `students.db` | 10 lines verified | **PASS** |
| **TC02** | Student Mgmt | Prevent duplicate roll number registration | Duplicate roll `CS2024-001` | System detects existing roll and rejects | Rejection confirmed | **PASS** |
| **TC03** | Student Mgmt | Regex search for registered students | Query: `Alice Johnson` | Matches record `CS2024-001` | Match returned | **PASS** |
| **TC04** | Student Mgmt | Temporary record creation & update | `CS2024-999` record | Details updated via `awk` stream | Updated in database | **PASS** |
| **TC05** | Student Mgmt | Safe deletion of student record | Roll: `CS2024-999` | Record removed from `students.db` | Cleanly removed | **PASS** |
| **TC06** | Assignment | Create 3 distinct assignments | `CS101-A1`, `CS501-A2`, `CS502-A3` | 3 rows added to `assignments.db` | 3 rows verified | **PASS** |
| **TC07** | Assignment | Valid date format validation | `2026-12-01 18:00:00` | Return code 0 (valid) | Code 0 returned | **PASS** |
| **TC08** | Assignment | Invalid date format rejection | `2026-13-45 99:99:99` | Return code 1 (invalid) | Code 1 returned | **PASS** |
| **TC09** | Assignment | Deadline extension & update | New date for `CS101-A1` | Database updated with new deadline | Updated successfully | **PASS** |
| **TC10** | Submission | On-time valid submission ingestion | Alice submits `cs101_sample_alice.sh` | Status: `Submitted`, Late: `NO` | Recorded as `Submitted` | **PASS** |
| **TC11** | Plagiarism | Detect identical SHA-256 file match | Bob submits identical `cs101_sample_bob.sh` | Exact hash match with Alice detected | `Duplicate Suspected` | **PASS** |
| **TC12** | Submission | Independent submission hash distinction | Carol submits distinct solution | SHA-256 hash differs from Alice/Bob | Distinct hash verified | **PASS** |
| **TC13** | Integrity | Zero-byte empty file detection | David submits empty 0-byte file | Detected as empty; flagged `Unverified` | `Unverified` recorded | **PASS** |
| **TC14** | Integrity | Non-existent file path handling | Emily enters non-existent file path | Detected missing; flagged `Unverified` | `Unverified` recorded | **PASS** |
| **TC15** | Submission | Late submission detection | Frank submits after deadline | Status: `Late`, LateFlag: `YES` | Flagged as `Late` | **PASS** |
| **TC16** | Submission | Ingestion for second assignment | Grace submits for `CS501-A2` | Status: `Submitted`, Late: `NO` | Recorded as `Submitted` | **PASS** |
| **TC17** | Plagiarism | Second duplicate cluster collision | Isabella submits copy of Henry's file | Exact hash collision detected | `Duplicate Suspected` | **PASS** |
| **TC18** | Versioning | Resubmission version tracking | Alice submits revised assignment | Version increments from `v1` to `v2` | `v2` assigned | **PASS** |
| **TC19** | Faculty Rev | Record faculty reviews and determinations | 5 evaluation records added | Stored in `reviews.db` | 5 records verified | **PASS** |
| **TC20** | Faculty Rev | Sync submission status with faculty review | SUB-1001 marked Reviewed | Status updated in `submissions.db` | Status synced | **PASS** |
| **TC21** | Reports | Plain text summary report generation | Execute `generate_reports` | `reports/submission_report.txt` created | Report file verified | **PASS** |
| **TC22** | Reports | CSV spreadsheet export generation | Execute `generate_reports` | `reports/submission_report.csv` created | CSV file verified | **PASS** |
| **TC23** | Reports | CSV header and column validation | Verify header row | Header matches schema | Header verified | **PASS** |
| **TC24** | Persistence | Student database persistence | Verify record count | 10 students intact | 10 verified | **PASS** |
| **TC25** | Persistence | Assignment database persistence | Verify record count | 3 assignments intact | 3 verified | **PASS** |
| **TC26** | Persistence | Submissions database persistence | Verify record count | 10 submissions intact | 10 verified | **PASS** |
| **TC27** | Persistence | Reviews database persistence | Verify record count | 5 reviews intact | 5 verified | **PASS** |
| **TC28** | Overall | Zero test failure confirmation | Overall assertion check | 0 failures | 0 failures verified | **PASS** |

---

### 4. Edge Case & Security Analysis

1. **Delimiter Injection Protection**: Input values are processed via `sanitize_string()` which strips pipe characters (`|`) to prevent delimiter spoofing in database records.
2. **Non-destructive In-Place Updates**: Record updates in `students.db`, `assignments.db`, and `submissions.db` utilize `mktemp` temporary files and atomic `mv` replacements, preventing file corruption in case of unexpected termination.
3. **Cryptographic Checksum Collision Guarantee**: SHA-256 produces a 256-bit hash. The probability of two distinct files naturally producing identical SHA-256 digests is approximately $1 \text{ in } 2^{256}$ ($10^{77}$), mathematically confirming identical bit sequences.
