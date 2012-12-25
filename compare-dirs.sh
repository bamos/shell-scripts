#!/bin/bash
#
# compare-dirs.sh
# 
# Compares the files in 2 directories and detects duplicates based
# on MD5 checksums.
#
# Brandon Amos <bamos.github.com>
# 2012.12.24

VERBOSE=1 # 0 or 1

function die {
    echo $1;
    exit 1;
}

function check_directory {
    [[ -d "$1" ]] || die "Unable to find directory '$1'"
}

function dir1_contains {
    for (( i=0; i<$DIR1_SIZE; i++ )); do
        [[ ${sums[$i]} == $1 ]] && return 0
    done
    return 1
}

function populate_dir1_arrays {
    echo "Creating checksums for files in dir1."
    local i=0;
    for f in $DIR1/*; do
        names[$i]=$f
        sums[$i]=`md5sum $f | cut -f 1 -d " "`
        let i++
    done
    DIR1_SIZE=$i
}

function match_found {
    MATCH=1
    echo "md5:  $1"
    echo "dir1: $2"
    echo "dir2: $3"
    echo
}

function check_dir2 {
    echo "Checking files in dir2."
    for f in $DIR2/*; do
        dir1_contains `md5sum $f | cut -f 1 -d " "`
        [[ $? == 0 ]] && match_found ${sums[$i]} "${names[$i]}" "$f"
    done
    [[ $MATCH == 1 ]] || echo "No matches found."
}

[[ $# == 2 ]] || die "Usage: ./compare-dirs.sh <dir1> <dir2>"

DIR1=$1; DIR2=$2;
check_directory $DIR1
check_directory $DIR2

populate_dir1_arrays
check_dir2
