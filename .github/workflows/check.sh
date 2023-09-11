#!/usr/bin/env bash
UPSTREAM=$(curl -IkLs -o /tmp/NUL -w %{url_effective} https://github.com/benbusby/whoogle-search/releases/latest | grep -o "[^/]*$")
cat .github/version.txt | while read line      
do
   CURRENT=$line          
done

if [[ ${UPSTREAM} == ${CURRENT} ]]
then
    echo 'there is nothing to do'
else
    git config user.name GitHub
    git config user.email noreply@github.com
    echo "${UPSTREAM}" > .github/version.txt
    git add .
    git commit --author "github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>" --allow-empty -m "$(git log -1 --pretty=%s)"
    git push 
fi
