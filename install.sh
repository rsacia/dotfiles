#!/bin/bash

FILES=`find . -type f -not -path "./.git/*" -not -name "${0##*/}" -not -name "README.md"`

for FILE in $FILES
do
    RF=`echo ${FILE} | sed "s:^\./::"`
    LN="ln -s"

    if [ "$1" == "-f" -o "$1" == "--force" ]
    then
        LN="${LN} -f"
    fi

    ${LN} "$(pwd)/${RF}" ~/"${RF}"
done

