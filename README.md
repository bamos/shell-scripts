This is a collection of short shell scripts I have added to my
`PATH` variable to run from anywhere.

To add these to your `PATH`, clone the repo and add the following
to your `bashrc` or `zshrc`, replacing `<python-scripts>`
with the location of the cloned repository.
Furthermore, see my [dotfiles][dotfiles] repo for my
complete Mac and Linux system configurations.

```Bash
# Add additional directories to the path.
pathadd() {
  [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]] && PATH="${PATH:+"$PATH:"}$1"
}

pathadd <python-scripts>/python2.7
pathadd <python-scripts>/python3
```

# 2x2-slides.sh
Takes a PDF of slides as input and outputs them tiled
in a 2x2 landscape PDF.

# alarm.sh
Linux computers can be used as an alarm clock with a program called
[rtcwake][rtcwake], which will sleep the computer until a specifed time.
`alarm.sh` is a simple wrapper around `rtcwake` to infer the
full data given a time.
For example, the following command will sleep the computer until the
next occurring 7PM.

```Bash
alarm.sh 7:00PM
```

# analyze-pcap.sh
Use tcpflow and foremost to analyze TCP streams in a pcap file.
For example, the following command automatically analyzes a pcap file.

```Bash
analyze-pcap.sh traffic.pcap
```

# compare-dirs.sh
Compares the files in 2 directories and
detects duplicates based on MD5 checksums.
For example, the following command compares the
files in `test_dir1` and `test_dir2`.

```
./compare-dirs.sh test_dir1 test_dir2
Creating checksums for files in dir1.
Checking files in dir2.
md5:  60b725f10c9c85c70d97880dfe8191b3
dir1: test_dir1/a
dir2: test_dir2/a_renamed

md5:  3b5d5c3712955042212316173ccf37be
dir1: test_dir1/b
dir2: test_dir2/b
```

# createpdf.sh
Create a pdf document from a plaintext document,
with optional source code highlighting.

```
./createpdf.sh main.cpp c++
```

# notify-postponed.sh
Send a notification when there are postponed
messages in [mutt][mutt].

# timesheets.sh
Plaintext timesheet management.


[rtcwake]: http://linux.die.net/man/8/rtcwake
[comp]: http://bamos.github.io/2013/03/11/compare-directories-bash/
[pdf]: http://bamos.github.io/2013/04/16/pdf-from-plaintext/
[resign]: http://bamos.github.io/2013/03/10/resigning-apk/
[sync]: http://bamos.github.io/2013/07/17/sync-to-servers-bash/

[mutt]: http://www.mutt.org/
[dotfiles]: https://github.com/bamos/dotfiles
