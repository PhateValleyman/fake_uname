# Fake Uname

This project overrides the `uname()` system call to fake the output of various system information, including the kernel version, system name, hostname, architecture, and build version. It can be useful when certain applications require specific system versions or architectures.

## Features

- Fake kernel version: `2.6.31.8`
- Fake architecture: `armv5tel`
- Fake system name: `Linux`
- Fake hostname: `Server`
- Fake kernel build date and version: `#2 Fri Mar 11 17:09:19 CST 2016`
- Modifies the output of `uname -a` to be:  
  ```bash
  Linux Server 2.6.31.8 #2 Fri Mar 11 17:09:19 CST 2016 armv5tel GNU/Linux
