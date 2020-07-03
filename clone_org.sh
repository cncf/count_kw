#!/bin/bash
# SRC_BASE=/path/to/sources/folder (defaults to ~/devstats_repos)
# TOKEN=oauth_token, if not specified defaults to '/etc/github/oauth' file.
if [ -z "${TOKEN}" ]
then
  token=`cat /etc/github/oauth`
else
  token="${TOKEN}"
fi
if [ -z "$token" ]
then
  args=''
else
  args="-H 'Authorization: token $token'"
fi
if [ -z "${SRC_BASE}" ]
then
  cd ~/devstats_repos/
else
  cd "${SRC_BASE}" || exit 1
fi
for org in $*
do
  echo "Org: $org"
  cmd="curl ${args} -s 'https://api.github.com/orgs/${org}/repos?type=public&per_page=100&page="
  i="1"
  c="0"
  while true
  do
    currcmd="${cmd}${i}' | jq -r '.[].name'"
    j="0"
    for repo in `eval $currcmd`
    do
      j=$((j+1))
      #echo "$i/$j: $1/$repo"
      git clone "https://github.com/${org}/${repo}"
      r=$?
      if [ "$r" = "0" ]
      then
        c=$((c+1))
      fi
    done
    if [ "${j}" = "0" ]
    then
      break
    fi
    i=$((i+1))
  done
  echo "Org: $org, cloned $c repos"
done
