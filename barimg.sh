#!/bin/bash

function parse() {
    local qr=$1
    local file=$2
    echo -n "$qr"| \
    awk -v file=$file '{ FS="!"; ORS=""; $0=$0; print file "," substr($1,9,length($1)) "," $3 "," $4 "," } \
    {FS=","; $0=$2; print $1+$2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13 "," $14+$15+$16+$17+$18+$19 "," $20 "," \
    $21+$22+$23+$24 "," $25+$26+$27+$28+$29+$30 "," $31 "," $32+$33 "," $34+$35+$36 "," $37 "," $38 "\n" }'
}

result=$(zbarimg --set "*.enable=0" --set qrcode.enable=1 -q $1/$2 | head -1)

if [ "$result" = "" ]; then
   convert $1/$2  -resize 50%  /tmp/$2
   result=$(zbarimg --set *.enable=0 --set qrcode.enable=1 -q /tmp/$2 | head -1)
   rm /tmp/$2
fi

if [ "$result" = "" ]; then
   cp $1/$2 failed/
else
   parse $result $2
fi
