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

# alarm.sh
Auto suspend and wake-up script
See the [blog post][alarm] for a more detailed overview.

# analyze-pcap.sh
Use tcpflow and foremost to analyze TCP streams in a pcap file.
See the [blog post][pcap] for a more detailed overview.

# compare-dirs.sh
Compares the files in 2 directories and
detects duplicates based on MD5 checksums.
See the [blog post][comp] for a more detailed overview.

# createpdf.sh
Create a pdf document from a plaintext document.
See the [blog post][pdf] for a more detailed overview.

# notify-postponed.sh
Send a notification when there are postponed
messages in [mutt][mutt].

# resigner.sh
Resigns an apk with user debug information.
See the [blog post][resign] for a more detailed overview.

# sync.sh
Sync a directory *to* remote machines.
See the [blog post][sync] for a more detailed overview.

# timesheets.sh
Plaintext timesheet management.
See the [blog post][timesheet] for a more detailed overview.


[alarm]: http://bamos.github.io/2013/03/09/rtcwake/
[pcap]: http://bamos.github.io/2013/07/31/pcap-analysis/
[comp]: http://bamos.github.io/2013/03/11/compare-directories-bash/
[pdf]: http://bamos.github.io/2013/04/16/pdf-from-plaintext/
[resign]: http://bamos.github.io/2013/03/10/resigning-apk/
[sync]: http://bamos.github.io/2013/07/17/sync-to-servers-bash/
[timesheet]: http://bamos.github.io/2013/02/10/timesheets-with-bash-and-latex/

[mutt]: http://www.mutt.org/
[dotfiles]: https://github.com/bamos/dotfiles
