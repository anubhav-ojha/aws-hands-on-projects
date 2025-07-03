# 🐧 Linux Basics & Directory Structure

---

## ✅ What is Linux?

**Linux** is an open-source, UNIX-like operating system kernel. Most modern Linux distributions include tools and utilities built around this kernel.

It is widely used in servers, cloud platforms (like AWS EC2), containers (Docker), and development environments.

---

## 📂 Linux Directory Structure (Filesystem Hierarchy)

Linux uses a **tree-like structure** starting from the **root (`/`) directory**:

| Directory | Description |
|-----------|-------------|
| `/`       | Root directory; top of the filesystem hierarchy |
| `/bin`    | Essential binary executables (e.g., `ls`, `cat`, `cp`) |
| `/sbin`   | System binaries (used by the system admin, e.g., `reboot`) |
| `/etc`    | Configuration files for the system |
| `/home`   | Home directories of users (e.g., `/home/user`) |
| `/root`   | Home directory of the root user |
| `/var`    | Variable files (logs, mail, spool files) |
| `/usr`    | User-installed software and libraries |
| `/tmp`    | Temporary files (automatically deleted on reboot) |
| `/dev`    | Device files (e.g., `/dev/sda`, `/dev/null`) |
| `/proc`   | Virtual filesystem for system/process information |
| `/lib`    | Essential shared libraries for binaries in `/bin` and `/sbin` |
| `/opt`    | Optional or third-party software packages |

---

## 🛠️ Basic Linux Commands

### 📁 File and Directory Commands

| Command              | Description                        |
|----------------------|------------------------------------|
| `ls`                 | List files and directories         |
| `pwd`                | Print current working directory    |
| `cd`                 | Change directory                   |
| `mkdir`              | Create a new directory             |
| `rmdir`              | Remove empty directory             |
| `rm -r`              | Remove directory recursively       |
| `touch file.txt`     | Create empty file                  |
| `cp file1 file2`     | Copy file1 to file2                |
| `mv file1 newname`   | Rename or move file                |
| `cat file.txt`       | View file content                  |
| `nano file.txt`      | Edit file with nano text editor    |
| `vi file.txt`        | Edit file with vi editor           |

---

### 🔐 Permissions & Ownership

| Command                       | Description                             |
|-------------------------------|-----------------------------------------|
| `chmod 755 file`              | Change file permissions                 |
| `chown user:group file`       | Change file ownership                   |
| `ls -l`                       | List with permissions and ownership     |

---

### 🧠 Helpful Tips

- **Everything is a file** in Linux — even devices and processes.
- Paths starting with `/` are **absolute paths**.
- Use `TAB` to **auto-complete commands or paths**.
- Use `man command` to read the **manual page** for a command.

---

## 🧾 Summary

- Linux follows a **standard directory hierarchy**.
- Files and directories are organized logically under `/`.
- Knowing basic **file navigation, creation, and permission commands** is essential for Linux administration.

