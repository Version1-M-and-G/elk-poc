#!/bin/bash
#: Title       : Update Git Repositories
#: Author      : "David Tuohy" <david.tuohy@version1.com>
#: Version     : 1.0
#: Description : finds all git repositories (.git folders), and performs a git pull on the specified/default branch
#: Options     : None
clear
SECONDS=0  #set seconds counter back to 0


function MoveToDefaultBranches(){
    local arrayDefaultBranches=(master develop)

    local i
    for ((i=0; i<${#arrayDefaultBranches[*]}; i++ ))
    do
        if [[ $(git branch -a | grep "${arrayDefaultBranches[i]}" -c) -gt 0 ]]
        then
             CheckoutBranchAndPull "${arrayDefaultBranches[i]}"
             flagRequiredBranchFound=1
        fi
    done
}

function CheckoutBranchAndPull(){
    git stash # saves changes but does not commit before changing branch
    git checkout "${1}"
    git pull
}

function MoveToCorrectBranch(){

    local flagRequiredBranchFound=0

    if [[ ${1} -gt 0 ]]
    then
        echo "Requested branch found:" "${2}"
        CheckoutBranchAndPull "${2}"
        local flagRequiredBranchFound=1
    else
        echo "Moving to Default Branch"
        MoveToDefaultBranches
    fi

    if [[ ${flagRequiredBranchFound} -eq 0 ]]
    then
        echo "WARNING NO BRANCHES FOUND"
    fi
}


function DoesBranchExistForParameterPassedIntoScript(){
    local branchExist
    #if used to check if a parameter is passed into script
    #this is used to prevent error
    if [[ ${#1} -eq 0 ]]  #${#var}  Use the length of var.
    then
        branchExist=0
    else
        branchExist=$(git branch -a | grep "${1}" -c)
    fi

    echo "$branchExist" #acting as a return
}

function GoToGitRepositoryDirectory(){

    cd $(dirname "$1""${2:1}") || exit #change to git dir
    echo "Starting git repository refresh @" "$(pwd)" #print dir to screen
}

function PrintParameterPassedIntoScript(){
    if [[ ${#1} -gt 0 ]]  #${#var}  Use the length of var.
    then
        echo "Will try moving to branch: ${1}"
    fi
}



#########################################
##########   Script Start  ##############
#########################################

homeDir=$(pwd)  #v1 holds the home dir

requestedBranchName=$1

mapfile -t arrayGitDir < <(find . -name .git)
numberOfGitRepos=$(find . -name .git | wc -l)  #wc is word count -l makes it count lines, | is pipe and find finds all .git

echo "Going to each git repository and updating:"

PrintParameterPassedIntoScript "${requestedBranchName}"

for (( i=0; i<numberOfGitRepos; i++ ))
do
    gitDir=${arrayGitDir[$i]}
    GoToGitRepositoryDirectory "${homeDir}" "${gitDir}"

    doesBranchExist=$(DoesBranchExistForParameterPassedIntoScript "${requestedBranchName}")

    MoveToCorrectBranch "${doesBranchExist}" "${requestedBranchName}"

    echo "Elapsed Time:" $SECONDS
    echo ""
done



echo "Total Elapsed Time:" $SECONDS
