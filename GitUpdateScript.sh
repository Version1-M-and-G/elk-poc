#!/bin/bash
#: Title       : UpdateGitRepos.sh
#: Date        : 18/08/2017
#: Author      : "David Tuohy" <david.tuohy@version1.com>
#: Version     : 1.0
#: Description : finds the .git files and pulls the changes
#: Options     : None
clear


SECONDS=0  #set seconds counter back to 0

home_dir=$(pwd)  #v1 holds the home dir

function Branch_Checking(){

	flag_branch=0 #flag to tell if on right branch, 0 is no 1 is yes
	echo "Current Branches"
	git branch| tee log_branch
	branch_I_want="* master"
	branch_I_want_not_on="master"
	branch_I_want_dev="* dev"
	branch_I_want_dev_not_on="dev"
	while read -r branch_option
	do # will make sure we are on the master branch and change flag
		if [ "$branch_option" = "$branch_I_want" ]
		then
		  
		  flag_branch=1
		elif [ "$branch_option" = "$branch_I_want_dev" ]
		then
		  #echo "On the correct branch"
		  flag_branch=1
		elif [ "$branch_option" = "$branch_I_want_not_on" ]
		then
		  #brach is there but we are not on it
		  flag_branch=2
		elif [ "$branch_option" = "$branch_I_want_dev_not_on" ]
		then
		  #brach is there but we are not on it
		  flag_branch=3
		fi




	done < log_branch  #end of loop
	rm log_branch #rm removes/dels the file 

	if [ "$flag_branch" -eq 0 ]
	then
	  echo "######################################################"
	  echo "# Could NOT find $branch_I_want_not_on or $branch_I_want_dev_not_on branches              #"
	  echo "# Please check that you are on the corred branch     #" 
	  echo "# Will run update on current branch                  #"
	  echo "######################################################"
	elif [ "$flag_branch" -eq 1 ]
	then
	  echo "On the correct branch"
	else
	 echo "On wrong branch will try and change- please note will run git stash command"

		if [ "$flag_branch" -eq 2 ]
		then
		 git stash # saves changes but does not commit before changing branch
		 git checkout $branch_I_want_not_on
		elif [ "$flag_branch" -eq 3 ]
		then
		 git stash # saves changes but does not commit before changing branch
		 git checkout $branch_I_want_dev_not_on
		fi
	fi
}




echo "Git Repositories Found:"
find -name .git| tee Temp_dir_log  #finds file with name .gitignore and stores results in file called FILENAME

echo "Going to each git repositories and update:"
while read file_dir
do 

	file_dir=${file_dir#?}  #${var#?} removes first char of varible var
	
	full_dir=$home_dir$file_dir  #merge home dir with the dir the git repository is in
	###remove git file name searched for char by char###
	full_dir=${full_dir%?}  #remove right char
	full_dir=${full_dir%?}  #remove right char
	full_dir=${full_dir%?}  #remove right char
	full_dir=${full_dir%?}  #remove right char

	cd  #go to home dir
	cd $full_dir
	#echo "Git Repositorie $full_dir:" 
	pwd

	Branch_Checking  

	git pull  

echo "Elapsed Time:" $SECONDS
done < Temp_dir_log

cd $home_dir #go back to the starting dir
rm Temp_dir_log #rm removes/dels the file 



#echo "Elapsed Time:" $SECONDS







