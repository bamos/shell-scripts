#!/bin/bash
#
# Takes a PDF of slides as input and outputs them tiled
# in a 2x2 landscape PDF.
#
# Brandon Amos

set -e -u

function die { echo $1; exit 42; }

[[ $# != 1 ]] && die "Usage: $0 <slides>"

INPUT_SLIDES=$1
OUTPUT=2x2-$INPUT_SLIDES

# LaTeX has trouble with some filenames.
rm -rf /tmp/slides.pdf
ln -sf $PWD/$INPUT_SLIDES /tmp/slides.pdf
INPUT_SLIDES=/tmp/slides.pdf

cat>/tmp/2x2-slides.tex<<EOF
\documentclass[a4paper]{article}
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage{pdfpages}
\usepackage{hyperref}

\begin{document}

\hypersetup{}

\pdfbookmark[0]{landscape}{1}

\includepdfmerge[nup=2x2, column=False, frame=False, angle=0,
                 scale=1, landscape=True, noautoscale=False,
                 clip=True ]{$INPUT_SLIDES, -}


\end{document}
EOF
rm -f /tmp/2x2-slides.pdf
pdflatex /tmp/2x2-slides.tex > /dev/null </dev/null
mv 2x2-slides.pdf $OUTPUT
echo "Output in $OUTPUT"
