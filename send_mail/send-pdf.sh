#!/bin/bash

IFS=","
read -sp"Password: " pass
tmp=
trap '[ -f "$tmp" ] && rm -- "$tmp"' EXIT
tmp=`mktemp`
echo
dir="6ECTS"

#sudo postfix start
grep @ -- "$@" | while read id firstname surname email organization texfile pdffile remaining; do
   #echo Sending email to $firstname $surname $email
   echo $texfile " " $pdffile
   NAME=$firstname SURNAME=$surname EMAIL=$email ORGANIZATION=$organization LOGIN=$login PASSWORD=$password \
   envsubst <email_input.txt >"$tmp"
   python ./sendmail-attachment.py "$tmp" "$pdffile" <<<"$pass"
done
#sudo postfix stop
