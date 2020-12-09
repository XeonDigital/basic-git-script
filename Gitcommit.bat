@ECHO OFF
rem I need to make it so that you would beable to get all of the remote branches and track them
rem I need to make the script do stashing
rem I also need to make it so that there are mutiple menus
rem I also gotta figure out how to error check
rem I gotta allow it to show git status


echo Press enter to continue without opening
set /p folder="Which folder are you trying to open(Enter folder path or folder name [folder name must be in the current folder])?"
cd %folder%
cls
:firstpull
set input=
set /p input="Do you want to pull now (type y or enter for no)?"
if DEFINED input (cls) else (goto firstpull)
if %input%== y (goto pull)
:start
set set=
cls
echo you are in %cd%
echo Branches:
echo (The star and the green text is the current branch)
git branch
echo -----------------------------------------
echo [1]initialize repo
echo [2]initialize and pull repo
echo [3]commit changes
echo [4]force commit (ONLY DO THIS IF YOU KNOW WHAT YOU ARE DOING)
echo [5]set account
echo [6]push changes
echo [7]pull branch
echo [8]reset commit changes
echo [9]change directory
echo [10]branch menu
echo [11]stash menu
echo -----------------------------------------
set /p "set=What do you want to do(input the corresponding number)?"
if defined set (cls) else (goto end)
if %set%== 1 (goto init)
if %set%== 2 (goto initpull)
if %set%== 3 (goto commit)
if %set%== 4 (goto force)
if %set%== 5 (goto login)
if %set%== 6 (goto push)
if %set%== 7 (goto pull)
if %set%== 8 (goto reset)
if %set%== 9 (goto switchRepo)
if %set%== 10 (goto branchmenu)
if %set%== 11 (goto stashmenu)
pause
goto end

:stashmenu
echo STASH MENU
echo Branches:
echo (The star and the green text is the current branch)
git branch
echo Stash List:
git stash list
git stash show
echo -----------------------------------------
echo [1]stash current commit
echo [2]drop current stash
echo [3]delete all stashes
echo *Enter nothing to exit
echo -----------------------------------------
set /p "set=What do you want to do(input the corresponding number)?"
if %set%== 1 (goto stash)
if %set%== 2 (goto dropStash)
if %set%== 3 (goto delStash)
set set=
pause
goto start

:branchmenu
set %set%=
echo BRANCH MENU
echo Branches:
echo (The star and the green text is the current branch)
git branch

echo -----------------------------------------
echo [1]create branch
echo [2]delete branch
echo [3]switch branch
echo [4]merge local branches
echo [5]fetch all branches
echo [6]get all branchs and track them (not yet implemented)
echo *Enter nothing to exit
echo -----------------------------------------
set /p "set=What do you want to do(input the corresponding number)?"
if %set%== 1 (goto createB)
if %set%== 2 (goto delBranch)
if %set%== 3 (goto switch)
if %set%== 4 (goto merge)
if %set%== 5 (goto fetch)
pause
goto start


rem methods (idk what to call them)


:delStash
git stash clear
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with deleting the stash
	pause 
	goto start
)
echo stash cleared

:delBranch
set branch=
set /p "branch=Which local branch do you want to delete?"
git branch -d %branch%
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with deleting the branch
	pause 
	goto start
)
echo Branch deleted
pause
goto start

:dropStash
git stash pop
echo Poped stash
pause
goto start

:stash
git stash
echo Changes stashed
pause
goto start


:fetch
echo Fetching all the branches
git fetch
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with fetching
	pause 
	goto start
)
goto start

:switchRepo
set /p folder="Which folder are you trying to open(Enter folder path)?"
cd %folder%
goto start


:reset
echo Resetting the changes from last commit
git reset
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with resetting
	pause 
	goto start
)
echo done
pause
goto start

:merge
echo The highlighted green text is where you are right now
git branch
set /p merge="Which branch do you want to merge from?"
git merge %merge%
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with merging
	pause 
	goto start
)
pause
goto start

:switch
git branch
set /p set="Which branch do you want to switch to?"
git checkout %set%
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with swtiching the branch
	pause
	goto start
)
pause
goto start


:createB
set /p branch="What would your branch name be?"
git checkout -b %branch%
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with creating a branch
	pause
	goto start
)
set /p pull="Which branch do you want to pull from?"
git pull origin %pull%
git commit -m "Created a new branch from %pull%"
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with pulling from %pull%
	pause
	goto start
)
git push origin %branch%
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with merging
	pause
	goto start
)
goto start


:commit
cls
set /p reason="Enter your reason for this commit:"
git add .
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with adding the files
	pause
	goto start
)
git commit -m "%reason%"
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with commiting
	pause
	goto start
)
pause
goto push


:push
git branch
set /p branch="Which branch do you want to push to?"
git push origin %branch%
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with pushing
	pause
	goto start
)
pause
goto start

:force
cls
echo DO THIS ONLY IF YOU REALLY NEED TO
set /p confirm="ARE YOU SURE ABOUT THIS(y=Yes or n=No)?"
if %confirm%==y (goto start)
if %confirm%==Y (goto start)
set /p reason="Enter your reason for this forced commit:"
git add .
git commit -m "%reason%"
set /p branch="Which branch do you want to do this to?"
git push -f origin %branch%
pause
goto start

:init
set /p origin="What is your origin?"
git init
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with initializing the repo
	pause
	goto start
)
git remote add origin %origin%
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with adding the remote
	pause
	goto start
)
git add .
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with adding all the files
	pause
	goto start
)
set /p comment="Enter the reason or "
git commit -m "first commit"
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with commiting
	pause
	goto start
)
git push -u origin master
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with 
	pause
	goto start
)
echo finished setup
pause
goto start

:initpull
set /p origin="What is your origin?"
git init
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with initializing the repo
	pause
	goto start
)
git remote add origin %origin%
set /p branch="What is the branch you want to pull from?"
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with adding the remote
	pause
	goto start
)
git pull origin %branch%
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with pulling from %branch%
	pause
	goto start
)
git checkout %branch%
echo finished updating local repository
pause 
goto start

:pull
git branch
set /p branch="What branch do you want to pull from?"
git pull origin %branch%
if %ERRORLEVEL% NEQ 0 (
	echo Something went wrong with pulling from %branch%
	pause
	goto start
)
pause
goto start

:login
cls 
set /p username="What is your username?"
set /p password="What is your password?"
git config user.email "%username%"
git config user.password "%password%"
goto start

:end
exit