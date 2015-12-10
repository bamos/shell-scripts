#!/bin/bash
#
# createpdf.sh
# Creates a pdf document from a plaintext file.
#
# Brandon Amos <http://bamos.github.io>
# 2013.04.16

set -e -u

function die { echo $1; exit 42; }

[[ $# > 2 ]] && die "Usage: $0 <plaintext file> [<language>]"

TEXT_FILE=$1
[[ -a $TEXT_FILE ]] || die "$TEXT_FILE is not a file."
if [[ $# == 1 ]]; then
  LANGUAGE=''
else
  LANGUAGE=$2
fi

OUTPUT=$TEXT_FILE.pdf

cat>/tmp/createpdf.tex<<EOF
\documentclass[letter]{article}
\usepackage[T1]{fontenc}
\usepackage[hmargin=1in, vmargin=1in]{geometry}

\usepackage{listings,textcomp,color}
\lstset{language=$LANGUAGE,upquote=true,
  basicstyle=\footnotesize,commentstyle=\textit,stringstyle=\upshape,
  numbers=left,numberstyle=\footnotesize,stepnumber=1,numbersep=5pt,
  backgroundcolor=\color{white},frame=single,tabsize=2,
  showspaces=false,showstringspaces=false,showtabs=false,
  breaklines=true,breakatwhitespace=true
}

\begin{document}

\vspace*{-2cm}
\noindent\verb!$TEXT_FILE!
\lstinputlisting{$PWD/$TEXT_FILE}

\end{document}
EOF
rm -f /tmp/createpdf.pdf
pdflatex /tmp/createpdf.tex > /dev/null </dev/null
mv createpdf.pdf $OUTPUT
echo "Output in $OUTPUT"
