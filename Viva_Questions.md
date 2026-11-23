# Viva Voce Examination Guide: Unix Shell Programming

## Student Assignment Submission and Plagiarism Monitoring System

This document contains 32 comprehensive technical Viva Voce questions and detailed answers designed for MS-level academic viva and oral examinations.

---

### Category A: Unix Shell Scripting Fundamentals

#### Q1. What is the difference between a Shell and a Kernel in Unix/Linux?
**Answer**:  
The **Kernel** is the core component of the operating system that directly interfaces with computer hardware (CPU, memory, devices, file systems). It manages process scheduling, memory allocation, and system calls.  
The **Shell** is a command language interpreter that acts as an interface between the user and the kernel. It reads user commands, interprets them, and makes appropriate system calls to the kernel. Examples include Bash, Zsh, Dash, and Ksh.

#### Q2. Why is `#!/usr/bin/env bash` used as the shebang line instead of `#!/bin/bash`?
**Answer**:  
`#!/bin/bash` hardcodes the absolute path to the Bash binary. In different Unix environments (such as FreeBSD, macOS, Alpine Linux, or custom containers), Bash may be located in `/usr/local/bin/bash` or `/usr/bin/bash`. Using `#!/usr/bin/env bash` queries the user's `PATH` environment variable dynamically to locate the active Bash executable, maximizing cross-platform portability across Linux, GitHub Codespaces, and BSD systems.

#### Q3. What is the purpose of `set -e` in shell scripts?
**Answer**:  
`set -e` (also known as `errexit`) instructs the Bash shell to terminate script execution immediately if any command exits with a non-zero exit status (i.e., encounters an error), unless the command is part of an explicit conditional test (such as `if`, `while`, or `until`). This prevents cascade failures where later commands operate on corrupt or non-existent files produced by failed earlier steps.

#### Q4. How does parameter expansion `${BASH_SOURCE[0]}` differ from `$0`?
**Answer**:  
`$0` holds the name of the script as invoked by the shell, or the name of the shell if sourced. When a script is sourced using `source utils.sh` or `. utils.sh`, `$0` retains the name of the parent shell or caller script, whereas `${BASH_SOURCE[0]}` always contains the exact path of the specific script file itself, regardless of whether it was executed directly or sourced. This is critical for computing reliable relative paths to project root directories.

#### Q5. How are exit codes represented and evaluated in Unix shell programming?
**Answer**:  
Every Unix process returns an integer exit code (from 0 to 255) to its parent process upon termination. An exit status of `0` denotes successful execution, while any non-zero value (`1` to `255`) indicates an error or special termination condition. In Bash, the special variable `$?` captures the exit status of the most recently executed foreground command.

---

### Category B: AWK Text Processing & Data Extraction

#### Q6. What is the fundamental execution model of AWK?
**Answer**:  
AWK is a pattern-directed scanning and processing language. It operates in an implicit loop over input lines:
1. It executes optional `BEGIN { ... }` blocks before reading any input records.
2. For each input line (record), it splits the line into fields using the field separator (`FS`).
3. It evaluates pattern-action blocks `pattern { action }`. If the pattern matches (or if no pattern is specified), the corresponding action block is executed.
4. It executes optional `END { ... }` blocks after all records from all input files have been processed.

#### Q7. Explain the built-in variables `FS`, `OFS`, `NR`, and `NF` in AWK.
**Answer**:  
- **`FS` (Field Separator)**: Specifies the delimiter used to split input records into fields `$1, $2, ...`. In this project, `FS="|"`.
- **`OFS` (Output Field Separator)**: Specifies the string used to separate fields when printed using `print $1, $2`. Defaults to a single space, but can be set to `"|"`.
- **`NR` (Number of Records)**: Keeps a running count of the total number of input records read so far across all input files.
- **`NF` (Number of Fields)**: Contains the count of fields in the current input record.

#### Q8. How do associative arrays work in AWK, and how are they used in duplicate detection?
**Answer**:  
Unlike traditional arrays indexed by integers, AWK arrays are associative (hash maps), indexed by arbitrary strings. In Module 7 (`plagiarism.sh`), we use associative arrays to count hash occurrences:
```awk
key = $3 "|" $6      # Compound key: AssignmentID|SHA256
count[key]++
```
In the `END` block, AWK iterates over the keys using `for (k in count)` and identifies all clusters where `count[k] > 1`, successfully detecting duplicate submissions across distinct students.

#### Q9. How does AWK pass variables from the shell environment?
**Answer**:  
Variables can be passed from shell scripts into AWK using the `-v` command-line option:
```bash
awk -F'|' -v target="$roll_no" '$1 == target { print $2 }' data/students.db
```
This safely binds the shell variable `$roll_no` to the internal AWK variable `target` without risking command injection or quoting issues.

---

### Category C: Stream Editing (SED) and Filtering (GREP)

#### Q10. What is SED and how does the substitution command `s/find/replace/g` work?
**Answer**:  
SED (Stream Editor) is a non-interactive text editor that processes text streams line-by-line based on editing commands. The substitution command syntax is `sed 's/regex/replacement/flags'`:
- `s`: Specifies the substitute command.
- `regex`: The regular expression pattern to match.
- `replacement`: The replacement text.
- `g`: The global flag, ensuring every occurrence on each line is replaced, rather than just the first occurrence.

#### Q11. Why is in-place editing `sed -i` avoided or handled via temporary files in robust scripts?
**Answer**:  
The `-i` flag for in-place editing behaves differently across Unix platforms: GNU `sed` (Linux) accepts `sed -i '...' file`, whereas BSD `sed` (macOS) requires `sed -i '' '...' file`. Furthermore, an interrupted `sed -i` operation due to a power loss or process kill can leave files truncated. Using `mktemp` to generate a temporary file followed by an atomic `mv` is POSIX-compliant, portable across all Unix variants, and crash-resilient.

#### Q12. Explain the difference between `grep`, `grep -q`, `grep -v`, and `grep -E`.
**Answer**:  
- `grep "pattern" file`: Prints all lines matching the pattern.
- `grep -q "pattern" file`: Quiet mode; suppresses all output and simply returns exit code 0 if a match exists, or 1 if not. Ideal for `if grep -q ...` statements.
- `grep -v "pattern" file`: Invert match; prints all lines that do *not* match the pattern.
- `grep -E "pattern" file`: Extended Regular Expressions (ERE), supporting advanced syntax such as alternation `(cat|dog)`, `+`, `?`, and grouping without escaping backslashes.

---

### Category D: Cryptography & Plagiarism Detection

#### Q13. What is SHA-256 and how does it guarantee duplicate detection?
**Answer**:  
SHA-256 (Secure Hash Algorithm 256-bit) is a cryptographic hash function published by the National Institute of Standards and Technology (NIST). It takes arbitrary-length input data and deterministically computes a fixed 256-bit (64 hexadecimal character) hash digest.  
It has three essential properties:
1. **Pre-image resistance**: It is computationally infeasible to reconstruct the original input from the hash digest.
2. **Deterministic output**: Identical input files will always generate the exact same 64-character hash.
3. **Collision resistance**: The probability of two distinct files generating the identical SHA-256 hash is $2^{-256}$, which is astronomically low ($10^{-77}$).

#### Q14. Why is MD5 or SHA-1 considered unsuitable for cryptographic verification compared to SHA-256?
**Answer**:  
MD5 (128-bit) and SHA-1 (160-bit) have suffered practical collision attacks where researchers generated two different files with identical hashes. SHA-256 remains cryptographically secure against collision and chosen-prefix attacks, ensuring absolute certainty when detecting matching binary content.

#### Q15. Does an identical SHA-256 hash prove academic plagiarism?
**Answer**:  
**No**. Cryptographic hashing confirms identical binary/text content. However, identical files may arise from legitimate academic contexts:
- A student submitting a provided starter skeleton or blank laboratory template.
- Identical configuration files.
- Resubmitting an earlier version of one's own work.
Therefore, the system flags matches as `Duplicate Suspected` and mandates an independent faculty review to evaluate intent.

#### Q16. What are the limitations of checksum-based plagiarism detection?
**Answer**:  
SHA-256 is an exact bitwise comparison. It cannot detect:
- Changing variable names or comments.
- Reordering function definitions.
- Modifying whitespace, indentations, or formatting.
Detecting paraphrased or obfuscated code requires Abstract Syntax Tree (AST) parsing or lexical n-gram tokenization (such as Stanford MOSS or JPlag).

---

### Category E: Database Design, Concurrency, and System Architecture

#### Q17. Why was a flat-file database (`.db`) chosen over MySQL or SQLite for this project?
**Answer**:  
1. **Academic Purity**: The assignment requirements mandate pure Unix/Linux shell programming using standard CLI tools (`awk`, `sed`, `grep`, `coreutils`) without third-party database engines.
2. **Zero-Configuration Portability**: Flat-file databases require no daemon installation, network sockets, user credentials, or database services, ensuring instant execution in GitHub Codespaces.
3. **Transparency**: Pipe-delimited records are human-readable, auditable via standard Unix pipelines, and easily backed up or inspected using `cat`, `head`, or `less`.

#### Q18. How is data corruption prevented during record updates in flat-file databases?
**Answer**:  
By using atomic update patterns:
1. `tmp_file=$(mktemp ...)` creates an isolated temporary buffer file.
2. `awk` reads the original database and writes updated records to the buffer.
3. `mv "$tmp_file" "$ORIGINAL_DB"` replaces the target file via an atomic filesystem directory rename operation. If the process is killed midway, the original database file remains intact.

#### Q19. How does the system calculate late submissions using Unix timestamps?
**Answer**:  
Human-readable dates in format `YYYY-MM-DD HH:MM:SS` are converted into POSIX epoch timestamps (seconds elapsed since January 1, 1970 00:00:00 UTC) using `date -d "$timestamp" "+%s"`.  
The system evaluates the numerical condition:
$$\text{Submission Epoch} \le \text{Deadline Epoch}$$
If true, the submission is flagged as on-time (`NO` late flag); if false, it is flagged as `Late` (`YES` late flag).

#### Q20. How does the system handle zero-byte empty files and non-existent paths?
**Answer**:  
The system utilizes POSIX file test operators:
- `[ ! -e "$path" ]`: Tests if the path does not exist on the filesystem.
- `[ ! -f "$path" ]`: Tests if the path is not a regular file (e.g., directory or socket).
- `[ ! -s "$path" ]`: Tests if the file has a size of 0 bytes.
When an anomaly is detected, the submission is recorded with status `Unverified` without casting accusatory fraud claims, allowing faculty to grant grace periods or request re-uploads.

---

### Category F: Advanced Questions on Linux Utilities

#### Q21. What is the difference between hard links and soft (symbolic) links?
**Answer**:  
A **hard link** is an additional directory entry pointing directly to the file's existing inode on the same filesystem. Deleting the original file name does not delete the file contents until all hard links are unlinked.  
A **symbolic (soft) link** is a special file whose data contains the path string to another target file or directory. If the target file is deleted or moved, the symlink becomes a broken ("dangling") link.

#### Q22. How does `date -d` differ from `date` on standard BSD/macOS?
**Answer**:  
GNU `date` (used in Linux and Codespaces) uses the `-d` or `--date` flag to parse arbitrary date strings (e.g. `date -d "2026-11-23 20:00:00" "+%s"`). BSD `date` (macOS) uses `-j -f "%Y-%m-%d %H:%M:%S" "string" "+%s"`. Our scripts target GNU coreutils on Linux/Codespaces.

#### Q23. What is the significance of the `export` command in Bash?
**Answer**:  
In Bash, variables declared without `export` are local to the current shell process and are not inherited by child processes. The `export` command marks the variable for inclusion in the environment of all subsequently executed child commands and sub-shells.

#### Q24. How does the pipe operator `|` function at the operating system level?
**Answer**:  
A pipe is an inter-process communication (IPC) channel managed by the kernel. The kernel creates a unidirectional byte stream buffer in memory. The standard output (`stdout`, file descriptor 1) of the command on the left is connected to the write end of the pipe, and the standard input (`stdin`, file descriptor 0) of the command on the right is connected to the read end. Both processes execute concurrently.

#### Q25. What is the difference between `>` and `>>` redirection operators?
**Answer**:  
- `>` (Overwrite): Opens the target file with the `O_TRUNC` flag, wiping any existing contents and writing new data from the beginning of the file.
- `>>` (Append): Opens the target file with the `O_APPEND` flag, preserving existing contents and writing new data at the end of the file.

#### Q26. How do you prevent delimiter collision in delimited databases?
**Answer**:  
Through sanitization. The function `sanitize_string()` uses `tr -d '|'` to remove any pipe characters from user input strings before they are appended to `.db` files, preserving the structural integrity of the field boundaries.

#### Q27. What is an inode in Unix?
**Answer**:  
An inode (index node) is a data structure on a Unix filesystem that stores metadata about a file (file type, permissions, owner UID, group GID, file size, timestamps for access, modification, and change, and pointers to data blocks on disk). Inodes do not store the filename or file contents; filenames are stored in directory tables mapped to inode numbers.

#### Q28. What is the difference between single quotes `'...'` and double quotes `"..."` in Bash?
**Answer**:  
- **Single quotes**: Enforce literal interpretation of every character enclosed within them; variable interpolation (`$VAR`), command substitution (`$(cmd)`), and escape characters (`\n`) are disabled.
- **Double quotes**: Allow variable expansion (`$VAR`), command substitution (`$(cmd)`), and arithmetic expansion (`$((expr))`), while protecting spaces and special characters from word splitting and globbing.

#### Q29. What is a race condition in shell scripting and how can it be mitigated?
**Answer**:  
A race condition occurs when the behavior of a program depends on the relative timing or interleaving of multiple concurrent processes accessing shared resources (e.g., two processes simultaneously reading, modifying, and writing to `students.db`). It can be mitigated using file locks via `flock`, POSIX `mkdir` locks (which are atomic operations in the filesystem), or staging transactions through temporary files.

#### Q30. What is the purpose of `.devcontainer/devcontainer.json` in modern developer workflows?
**Answer**:  
The Development Container specification defines an open format to configure a full-featured development environment inside a Docker container. In GitHub Codespaces, `devcontainer.json` specifies the base Linux operating system image, pre-installed toolchains, VS Code extensions, and initialization commands (such as running `chmod +x` and `install.sh`), eliminating environment drift and "works on my machine" issues.

#### Q31. What is the difference between `cron` and `at` commands for scheduling?
**Answer**:  
- `cron`: Schedules recurring automated jobs based on a 5-field time specification (minute, hour, day of month, month, day of week).
- `at`: Schedules a one-time task to be executed at a specific future timestamp.

#### Q32. How can you demonstrate that your shell script is production-ready?
**Answer**:  
1. Pass static syntax checks (`bash -n`).
2. Pass linting tests (e.g. `shellcheck`).
3. Have comprehensive automated unit and integration tests with 100% pass rate.
4. Gracefully handle edge cases (empty files, missing paths, duplicate entries).
5. Maintain structured logging and RFC-compliant reporting (CSV/TXT).
6. Provide complete technical documentation and reproducible installation scripts.
