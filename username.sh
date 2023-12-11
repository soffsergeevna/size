#!/bin/bash

file="/etc/passwd"
uid=$(whoami)

usage() {
   echo "Использование: userhome [-f file] [uid]" 
}


while getopts "f:" opt; do
  case $opt in
    f)
      file="$OPTARG"
      ;;
    --usage)
       usage
       exit 0
       ;;
    \?)
      echo "Использование: userhome [-f file] [uid]" >&2
      exit 1
      ;;
  esac
done

if [ ! -f "$file" ]; then
  echo "Ошибка: Файл $file не найден." >&2
  exit 2
fi

if [ -z $1 ]; then
   echo "Ошибка: необходимо указать UID пользователя"
   exit 1
fi 

shift $((OPTIND - 1))

if [ $# -eq 1 ]; then
  uid=$1
fi


login=$(grep "^[^:]*:[^:]*:$uid:" "$file" | cut -d: -f1)

if [ -z "$login" ]; then
  echo "Ошибка: Пользователь с уникальным идентификатором $uid не найден." >&2
else
   echo "Логин пользователя с UID $uid : $login"
fi


exit 0



