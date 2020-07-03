#!/bin/bash
if [ -z "${1}" ]
then
  echo "$0: please provide a path as a first argument, for example '.', or list '/path/1 /path/2'"
  exit 1
fi
if [ -z "${2}" ]
then
  echo "$0: please provide a filename pattern as a second arument, for example '*' or list '*.go *.c'"
  exit 2
fi
if [ -z "${3}" ]
then
  echo "$0: please provide a keyword as a 3rd argument, for example 'kubernetes' can also be regexp '(pattern|argument)'"
  exit 3
fi
ns=`date +%s%N`
fn="/tmp/${ns}.data"
function cleanup {
  rm -f "${fn}"
}
trap cleanup EXIT
> "${fn}"
# echo "Paths: ${1}"
# echo "Filename patterns: ${2}"
# echo "Keyword pattern: ${3}"
read -ra paths <<< "${1}"
read -ra patterns <<< "${2}"
for pth in "${paths[@]}"
do
  # echo "Path: ${pth}"
  for pat in "${patterns[@]}"
  do
    # echo "Filename pattern: ${pat}"
    if [ -z "${VERBOSE}" ]
    then
      find "${pth}" -type f -iname "${pat}" -not -wholename "${fn}" -not -path '*.git/*' -not -path '*vendor/*' -not -path '*.svn/*' -not -path '*.github/*' -not -path '*.circleci/*' -exec grep -HEInio "(^|[[:punct:][:space:]]+)${3}([[:punct:][:space:]]+|$)" "{}" \; > "${fn}" || exit 4
    else
      find "${pth}" -type f -iname "${pat}" -not -wholename "${fn}" -not -path '*.git/*' -not -path '*vendor/*' -not -path '*.svn/*' -not -path '*.github/*' -not -path '*.circleci/*' -exec grep -HEInio "(^|[[:punct:][:space:]]+)${3}([[:punct:][:space:]]+|$)" "{}" \; | tee -a "${fn}" || exit 4
    fi
  done
done
cat "${fn}" | wc -l || exit 5
