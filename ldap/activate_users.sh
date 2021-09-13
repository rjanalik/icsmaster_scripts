#!/bin/bash

grp1='abcdefghijklmnopqrstuvwxyz'
grp2='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
grp3='0123456789'
grp4='.,!?'

scriptFile="activateStudents.bat"

password() {
  local i pass= var len
  for i in {1..4}; do
     case $i in
       1) len=$((2+RANDOM%3));;
       2) len=$((5-len));;
       3|4) len=1;;
     esac
     var=grp$i
     var=${!var}
     for((j=0; j<len; j++)); do
       pass+=${var:$RANDOM%${#var}:1}
     done
  done
  shuf "$pass"
}

shuf() {
   local arg=$1 res=
   while ((${#arg})); do
      idx=$((RANDOM%${#arg}))
      res+=${arg:idx:1}
      arg=${arg:0:idx}${arg:${#arg}}${arg:idx+1}
   done
   printf -- '%s\n' "$res"
}


rm -f $scriptFile

for i in `seq -f "%02g" 01 90`; do
   echo "Set-ADUser -Identity stud${i} -Enabled \$true" >> $scriptFile
done
