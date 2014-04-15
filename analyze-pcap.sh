#!/bin/bash
#
# analyze-pcap.sh
# Use tcpflow and foremost to analyze TCP streams in a pcap file.
#
# Brandon Amos <http://bamos.github.io>
# 2013.07.30

function die { echo $*; exit 42; }

[[ $# != 1 || ! -f $1 ]] && die "Usage: $0 <pcap file>"

TCP_STREAMS=$(mktemp /tmp/tcpflow.XXX)
OUTPUT=${1%.*}.output
tcpflow -r $1 -C -B > $TCP_STREAMS
[[ $? == 0 ]] || die "Error using 'tcpflow'."
foremost $TCP_STREAMS -o $OUTPUT
[[ $? == 0 ]] || die "Error using 'foremost'."
rm -f $TCP_STREAMS report.xml
echo "Output is in '$OUTPUT'."
