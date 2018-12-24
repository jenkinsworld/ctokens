#!/bin/bash
commitmsg=${1}
echo "$commitmsg"

if [[ ! "${commitmsg}" =~ ^JIRA[0-9] ]]; then
  echo "Incorrect pattern: Pattern should be like JIRA123"
  exit 0
else
  echo "Pattern matched"
  git commit -am "$commitmsg"
  echo "commited the changes successfully"
  VERSION=`git describe --tags --abbrev=0 | awk -F. '{$NF+=1; OFS="."; print $0}'`
  git tag -a `echo $VERSION | awk -F' ' 'BEGIN{OFS=".";} {print $1,$2,$3;}'` -m "new release"
  git push origin `echo $VERSION | awk -F' ' 'BEGIN{OFS=".";} {print $1,$2,$3;}'
fi

