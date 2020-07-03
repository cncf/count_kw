#!/bin/bash
wd=`pwd`
fn="${wd}/result.csv"
if [ ! -z "${RESET}" ]
then
  echo 'master,slave,whitelist,blacklist' > "${fn}"
fi
cd ~/devstats_repos/
declare -A kws
kws[${#kws[@]}]='master'
kws[${#kws[@]}]='slave'
kws[${#kws[@]}]='white-?list'
kws[${#kws[@]}]='black-?list'
declare -A projs
projs[${#projs[@]}]='Kubernetes'
projs[${#projs[@]}]='TikV'
declare -A sources
sources[${#sources[@]}]='kubernetes kubernetes-client kubernetes-csi kubernetes-incubator kubernetes-security kubernetes-sig kubernetes-sig-testing'
sources[${#sources[@]}]='tikv'
for i in "${!projs[@]}"
do
  proj="${projs[$i]}"
  src="${sources[$i]}"
  echo -n "${proj}," >> "${fn}"
  for j in "${!kws[@]}"
  do
    kw="${kws[$j]}"
    echo -n "${proj}(${src}) ${kw}: "
    res=`"${wd}/count_kw.sh" "${src}" '*' "${kw}"`
    echo "${res}"
    echo -n "${res}" >> "${fn}"
    if [ ! "${j}" = "3" ]
    then
      echo -n ',' >> "${fn}"
    fi
  done
done
echo '' >> "${fn}"
