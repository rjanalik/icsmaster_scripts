#!/bin/bash

IFS=","
read -sp"Password: " pass
tmp=
trap '[ -f "$tmp" ] && rm -- "$tmp"' EXIT
tmp=`mktemp`

#sudo postfix start
grep @ -- "$@" | while read surname firstname program email year previous_studies visiting login password; do
   password=${password// /\;}
   password=${password//\"}
   NAME=$firstname EMAIL=$email LOGIN=$login PASSWORD=$password \
    envsubst <email_input.txt >"$tmp"
    #| sendmail -f radim.janalik@{gmail.com,usi.ch} -- "$email"
    python ./sendmail.py "$tmp" <<<"$pass"
done
#sudo postfix stop
