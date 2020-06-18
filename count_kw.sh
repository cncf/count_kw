#!/bin/bash
if [ -z "${1}" ]
then
  echo "$0: please provide a path as a first argument, for example '.'"
  exit 1
fi
if [ -z "${2}" ]
then
  echo "$0: please provide a filename pattern as a second arument, for example '*'"
  exit 2
fi
if [ -z "${3}" ]
then
  echo "$0: please provide a keyword as a 3rd argument, for example 'kubernetes'"
  exit 3
fi
fn="/tmp/${3}.data"
function cleanup {
  rm -f "${fn}"
}
trap cleanup EXIT
> "${fn}"
find "${1}" -type f -iname "${2}" -not -wholename "${fn}" -not -path '*.git/*' -not -path '*vendor/*' -exec grep -HEInio "(^|[[:punct:][:space:]]+)${3}([[:punct:][:space:]]+|$)" "{}" \; | tee "${fn}" || exit 4
cat "${fn}" | wc -l || exit 5
