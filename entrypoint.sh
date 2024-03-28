#!/bin/bash

if [[ "$GITOPS_BRANCH" == "development" ]]; then
    printf "\033[0;36m================================================================================================================> Condition 1: Develop environment \033[0m\n"
    printf "\033[0;32m============> Cloning $5 - Branch: development \033[0m\n"
    git clone https://$4@$6 -b development
    cd $5
    git config --local user.email "action@github.com"
    git config --local user.name "GitHub Action"
    echo "Repo $5 cloned!!!"

    printf "\033[0;32m============> Control plane dev branch Kustomize step - development Overlay \033[0m\n"
    cd k8s/$1/overlays/development
    kustomize edit set image IMAGE=$2/$1:$RELEASE_VERSION
    echo "Done!!"

    printf "\033[0;32m============> Git push: Branch development \033[0m\n"
    cd ../..
    git commit -am "$3 has Built a new version: $RELEASE_VERSION"
    git push origin development

elif [[ "$GITOPS_BRANCH" == "main" ]]; then
    printf "\033[0;36m================================================================================================================> Condition 3: New release (HML and PRD environment) \033[0m\n"
    printf "\033[0;32m============> Cloning $5 - Branch: $GITOPS_BRANCH \033[0m\n"
    git clone https://$4@$6 -b develop
    cd $5
    git config --local user.email "action@github.com"
    git config --local user.name "GitHub Action"
    echo "Repo $5 cloned!!!"

    printf "\033[0;32m============> Develop branch Kustomize step - DEV Overlay \033[0m\n"
    cd k8s/$1/overlays/dev
    kustomize edit set image IMAGE=$2/$1:$RELEASE_VERSION
    echo "Done!!"

    printf "\033[0;32m============> Develop branch Kustomize step - PRD Overlay \033[0m\n"
    cd ../prod
    kustomize edit set image IMAGE=$2/$1:$RELEASE_VERSION
    echo "Done!!"

    printf "\033[0;32m============> Git commit and push: Branch develop \033[0m\n"
    cd ../..
    git commit -am "$3 has Built a new version: $RELEASE_VERSION"
    git push origin develop

    printf "\033[0;32m============> Open PR: develop -> main \033[0m\n"
    export GITHUB_TOKEN=$4
    gh pr create --head develop --base main -t "GitHub Actions: Automatic PR opened by $3 - $RELEASE_VERSION" --body "GitHub Actions: Automatic PR opened by $3 - $RELEASE_VERSION"

fi
