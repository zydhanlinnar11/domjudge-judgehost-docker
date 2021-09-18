#!/bin/bash
/opt/domjudge/judgehost/bin/dj_make_chroot

# Install PyPy3
/opt/domjudge/judgehost/bin/dj_run_chroot "apt install -y wget bzip2"
/opt/domjudge/judgehost/bin/dj_run_chroot "cd /opt && wget https://downloads.python.org/pypy/pypy3.7-v7.3.5-linux64.tar.bz2"
/opt/domjudge/judgehost/bin/dj_run_chroot "cd /opt && tar -xf pypy3.7-v7.3.5-linux64.tar.bz2"
/opt/domjudge/judgehost/bin/dj_run_chroot "mv /opt/pypy3.7-v7.3.5-linux64 /usr/lib"
/opt/domjudge/judgehost/bin/dj_run_chroot "ln -s ../lib/pypy3.7-v7.3.5-linux64/bin/pypy3 /usr/bin/pypy3"
/opt/domjudge/judgehost/bin/dj_run_chroot "rm opt/pypy3.7-v7.3.5-linux64.tar.bz2"

# Install kotlinc
/opt/domjudge/judgehost/bin/dj_run_chroot "apt install -y wget openjdk-11-jdk zip unzip"
/opt/domjudge/judgehost/bin/dj_run_chroot "cd /opt && wget https://github.com/JetBrains/kotlin/releases/download/v1.5.30/kotlin-compiler-1.5.30.zip"
/opt/domjudge/judgehost/bin/dj_run_chroot "cd /opt && unzip kotlin-compiler-1.5.30.zip"
/opt/domjudge/judgehost/bin/dj_run_chroot "mv /opt/kotlinc /usr/lib"
/opt/domjudge/judgehost/bin/dj_run_chroot "ln -s ../lib/kotlinc/bin/kotlinc /usr/bin/kotlinc"
/opt/domjudge/judgehost/bin/dj_run_chroot "ln -s ../lib/kotlinc/bin/kotlin /usr/bin/kotlin"
/opt/domjudge/judgehost/bin/dj_run_chroot "rm /opt/kotlin-compiler-1.5.30.zip"

cd /
echo "Archiving chroot"
sudo tar -czpvf /chroot.tar.gz /chroot
echo "Archived chroot"
sudo tar -czpvf /judgehost.tar.gz /opt/domjudge/judgehost
