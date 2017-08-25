#!/bin/bash
#: Title       : UpdateGitRepos.sh
#: Date        : 18/08/2017
#: Author      : "David Tuohy" <david.tuohy@version1.com>
#: Version     : 1.0
#: Description : finds the .git files and pulls the changes
#: Options     : None
clear


SECONDS=0  #set seconds counter back to 0
function RemoveUnwantedCharFromDirVar()
{
	file_dir=${file_dir#?}  #${var#?} removes first char of varible var
	full_dir=$home_dir$file_dir  #merge home dir with the dir the git repository is in
	###remove git file name searched for, char by char###
	full_dir=${full_dir%?}  #remove right char
	full_dir=${full_dir%?}  #remove right char
	full_dir=${full_dir%?}  #remove right char
	full_dir=${full_dir%?}  #remove right char
}
function GoToGitRepositoryDirectory(){
	cd  #go to home dir
	cd $full_dir #change to git dir
	pwd #pint dir to screen
}
function FindsWhatBranchRepositoryIsOn() {
	if [ "$branch_option" = "* $branch_I_want" ] #note "* " is used to show branch selection
	then
	 #echo "On the correct branch"
	 flagWhatBranchOn="$flagOnCorrectBranch"
	elif [ "$branch_option" = "* $branch_I_want_dev" ]
	then
	 #echo "On the correct branch"
	 flagWhatBranchOn="$flagOnCorrectBranch"
	elif [ "$branch_option" = "$branch_I_want" ]
	then
	 #branch is there but we are not on it
	 flagWhatBranchOn="$flagOnBranchMaster"
	elif [ "$branch_option" = "$branch_I_want_dev" ]
	then
	 #branch is there but we are not on it
	 flagWhatBranchOn="$FlagOnBranchDev"
	fi
}
function MoveToCorrectBranch(){
	if [ "$flagWhatBranchOn" -eq "$flagDontKnowBranch" ]
	then
	  echo "######################################################"
	  echo "# Could NOT find $branch_I_want or $branch_I_want_dev branches              #"
	  echo "# Please check that you are on the corred branch     #" 
	  echo "# Will run update on current branch                  #"
	  echo "######################################################"
	elif [ "$flagWhatBranchOn" -eq "$flagOnCorrectBranch" ]
	then
	  echo "On the correct branch"
	else
	 echo "On wrong branch will try and change- please note will run git stash command"

		if [ "$flagWhatBranchOn" -eq "$flagOnBranchMaster" ]
		then
		 git stash # saves changes but does not commit before changing branch
		 git checkout $branch_I_want
		elif [ "$flagWhatBranchOn" -eq "$FlagOnBranchDev" ]
		then
		 git stash # saves changes but does not commit before changing branch
		 git checkout $branch_I_want_dev
		fi
	fi
}


function BranchChecking(){
	#constants
	flagDontKnowBranch=0
	flagOnCorrectBranch=1
	flagOnBranchMaster=2
	FlagOnBranchDev=3

	
	flagWhatBranchOn="$flagDontKnowBranch" 
	echo "Current Branches"
	git branch| tee log_branch
	branch_I_want="master"
	branch_I_want_dev="dev"


	while read -r branch_option
	do # will make sure we are on the master branch and change flag

	FindsWhatBranchRepositoryIsOn
		
	done < log_branch  #end of loop
	rm log_branch #rm removes/dels the file 

	MoveToCorrectBranch

}

function RemoveFileCreatedToHoldGitReposNames(){
cd $home_dir #go back to the starting dir
rm Temp_dir_log #rm removes/dels the file 
}

home_dir=$(pwd)  #v1 holds the home dir
echo "Git Repositories Found:"
find -name .git| tee Temp_dir_log  #finds file with name .gitignore and stores results in file called FILENAME

echo "Going to each git repositories and update:"
while read file_dir
do 
	RemoveUnwantedCharFromDirVar

	GoToGitRepositoryDirectory

	BranchChecking  #call branch checking function

	git pull  

	echo "Elapsed Time:" $SECONDS
done < Temp_dir_log


RemoveFileCreatedToHoldGitReposNames

echo "Total Elapsed Time:" $SECONDS







