#!/bin/zsh
#Copyright (c) 2016 pandada8
#Permission is hereby granted, free of charge, to any person obtaining a copy of
#this software and associated documentation files (the "Software"), to deal in
#the Software without restriction, including without limitation the rights to
#use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
#of the Software, and to permit persons to whom the Software is furnished to do
#so, subject to the following conditions:
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

function disk(){
  printf "$(tput bold)$(tput smul)Name$(tput rmul)\t$(tput smul)Folder$(tput rmul)\t$(tput smul)Size$(tput rmul)\n$(tput sgr0)"
  grep -v "^#" /etc/passwd | awk -F: '{if ($6 !~ "/var|/bin|/proc|/etc|/dev|/srv" && $6 != "/") {print $1, $6}}' | while read -r line; do
    name=("${(@s/ /)line}");
    printf "%s\t%s\t" $name[1] $name[3]
    printf "%s\n" $(du -sh $name[3] 2>/dev/null | awk -F "\t" '{print $1}');
  done;
}

function max_file(){
  printf "$(tput bold)$(tput smul)Name$(tput rmul)\t$(tput smul)Size$(tput rmul)\t$(tput smul)MaxFile$(tput rmul)\n$(tput sgr0)"
  grep -v "^#" /etc/passwd | awk -F: '{if ($6 !~ "/var|/bin|/proc|/etc|/dev|/srv" && $6 != "/") {print $1, $6}}' | while read -r line; do
    name=("${(@s/ /)line}");
    printf "%s\t" $name[1]
    printf "%s\n" $(du $name[3] 2>/dev/null | awk -v max=0 -F "\t" '{if($1>max){want=$2; max=$1}}END{print max, want}');
  done;
}

function code_line(){
  printf "$(tput bold)$(tput smul)Name$(tput rmul)\t$(tput smul)Lines$(tput rmul)\n$(tput sgr0)"
  grep -v "^#" /etc/passwd | awk -F: '{if ($6 !~ "/var|/bin|/proc|/etc|/dev|/srv" && $6 != "/") {print $1, $6}}' | while read -r line; do
    name=("${(@s/ /)line}");
    printf "%s\t" $name[1]
    ag --cpp --nonumbers "^" $name[3] | awk -F: 'sum=0 {sum += $2} END {print sum}'
  done;
}

function online(){
  printf "Username:"
  while read username; do
    found=$(who | awk -v "user=$username" '{if (user == $1) print $1}')
    if [[ -z $found ]] then
      echo "$found is offline"
    else
      echo "$found is online"
    fi
  done;
}

if type "service" > /dev/null; then
  function services(){
    printf "<service> "
    while read action service; do
      service $service $action
    done
  }
fi
if type "systemctl" > /dev/null; then
  function services(){
    printf "<systemctl>"
    while read action service; do
      systemctl $action $service
    done
  }
fi
if ! type "services" > /dev/null; then
function services(){
  echo "system not supported"
}
fi

function menu(){
  echo "Functions:"
  echo "1. print all user disk file size"
  echo "2. find largest file of users"
  echo "3. sum cpp/h file row count"
  echo "4. check user online"
  echo "5. manage service"
  echo "6. quit"
  echo
  printf ">"
}

function main(){
  if [[ $UID != 0 ]]; then
      echo "Please run this script with sudo:"
      echo "sudo $0 $*"
      exit 1
  fi;
  menu
  while read i; do
    case $i in
      1)
      disk
      ;;
      2)
      max_file
      ;;
      3)
      code_line
      ;;
      4)
      online
      ;;
      5)
      services
      ;;
      6)
      exit 0
      ;;
      "*")
      echo "喵喵喵 ?"
      ;;
    esac;
    menu
  done;
}
main
