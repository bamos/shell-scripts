#!/bin/sh
#
# References:
#   https://github.com/btford/write-good
#   http://dsl.org/cookbook/cookbook_15.html#SEC224

die() { echo $*; exit -1; }
head() { echo -e "\n\n======= $* ======= \n\n"; }

[[ $# == 1 ]] || die "Usage: check-latex.sh <document>"

TMP=$(mktemp /tmp/latex-analysis.XXXXXXX)

head "Running detex"
detex $1 > $TMP || die "Nonzero return."

head "Running write-good"
write-good $TMP || die "Nonzero return."

runstyle() {
  head "Running style - $1 $2"
  style --print-$1 $2 $TMP || die "Nonzero return"
}

runstyle long 20
runstyle ari 20
runstyle passive
runstyle nom
runstyle nom-passive
