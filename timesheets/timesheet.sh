#!/bin/bash
#
# timesheet.sh
# Parses hours from a plaintext file and creates a timesheet in PDF format.

function die { echo $@; exit 1; }
function delimit_days { echo "$2 $1 $3 $1 $4 $1 $5 $1 $6 $1 $7 $1 $8"; }
[[ -n $1 ]] || die "Usage: ./timesheet.sh <file>"

function _num {
    [[ $1 =~ -+ ]] && echo 0
    [[ ! $1 =~ -+ ]] && echo $1
}

function _elem {
    [[ $1 =~ -+ ]] && echo " ~ "
    [[ ! $1 =~ -+ ]] && echo $1
}

function parse_week {
    BEGIN_DATE=$1;  END_DATE=$2;
    [[ $WEEKS == 0 ]] && OVERALL_BEGINNING=$BEGIN_DATE
    M=$3; T=$4; W=$5; TH=$6; F=$7; S=$8; SU=$9
    WEEKLY_HOURS=$(delimit_days " + " $(_num $M) $(_num $T) $(_num $W) \
        $(_num $TH) $(_num $F) $(_num $S) $(_num $SU) | bc)
    TOTAL_HOURS=$(echo "$TOTAL_HOURS + $WEEKLY_HOURS" | bc)

    TABLE_ENTRY="$BEGIN_DATE & $END_DATE & "
    TABLE_ENTRY+=$(delimit_days " & " $(_elem $M) $(_elem $T) $(_elem $W) \
        $(_elem $TH) $(_elem $F) $(_elem $S) $(_elem $SU))
    TABLE_ENTRY+=" & $WEEKLY_HOURS"
    TABLE_ENTRY+=' & \includegraphics[scale=0.3]{signature.png}'
    TABLE_ENTRY+=' & \\[-0.25mm] \hline'
    echo $TABLE_ENTRY >> table-contents.tex
}

function populate_table {
    TOTAL_HOURS=0
    WEEKS=0;

    while read LINE; do
        parse_week $LINE
        WEEKS=$((WEEKS+1))
    done <<< "$(tail -n +2 $INPUT)"

    for ((; WEEKS<5; WEEKS++)); do
        echo '&&&&&&&&&&& \\ \hline' >> table-contents.tex
    done

    TOTAL_LINE='\multicolumn{12}{r}{TOTAL HOURS \hspace{0.2in}'
    TOTAL_LINE+="$TOTAL_HOURS"
    TOTAL_LINE+='} \hspace{2.15in}'
    echo $TOTAL_LINE >> table-contents.tex
}

# http://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
function get_filename {
    filename=$(basename "$1")
    extension="${filename##*.}"
    filename="${filename%.*}"
    echo $filename
}

function check_date_box {
    sed -i 's/\\XBox/\\Square/g' template.tex

    REGEX='\(' # Group 1
    REGEX+="$OVERALL_BEGINNING"
    REGEX+='\)'
    REGEX+='\([^{]*}{\)' # Group 2
    REGEX+='\(\\Square\)' # Group 3
    REPLACEMENT='\1\2\\XBox'
    sed -i "s|$REGEX|$REPLACEMENT|g" template.tex
}

#########
# Start #
#########

cat /dev/null > table-contents.tex

INPUT=$1
populate_table $INPUT
check_date_box

pdflatex -halt-on-error template.tex &> template-compile.log
[[ $? == 0 ]] || die "Latex failed. See the log in template-compile.log."

rm template.aux template-compile.log template.log template.out texput.log \
    &> /dev/null

FILENAME=$(get_filename $INPUT)
PDF=${FILENAME}.pdf
[[ -d Archives ]] || mkdir -p Archives
mv template.pdf Archives/$PDF
mv $INPUT Archives/
rm table-contents.tex

echo "Successfully generated and archived timesheet for '$FILENAME'"
