#!/bin/bash
COMMIT="$(hg log --limit 1 | grep summary | cut -d ':' -f 2 | awk '{$1=$1};1')"

if [ -d ".git" ]; then
    rm -rf .git
fi

git init
git config user.email elvis.oliveira@blive-ti.com.br
git config user.name "Elvis Oliveira"

echo '.hg' > .gitignore

if [[ "$(git remote)" = "" ]]; then
    git remote remove origin
    git remote add origin https://github.com/elvisoliveira-blive/jenkins_integration_3.git
fi

git stash --all
git pull origin master
git stash apply

git add .
git reset -- .hg
git commit -m "$COMMIT"
git push https://'elvisoliveira-blive':'blive%40123'@github.com/elvisoliveira-blive/jenkins_integration_3.git --all