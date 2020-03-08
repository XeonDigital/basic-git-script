@ECHO OFF
echo Press enter to continue without opening
set /p folder="Which folder are you trying to open(Enter folder path or folder name [folder name must be in the current folder])?"
cd %folder%
cls
set /p input="Do you want to pull now (type y or enter for no)?"
if %input%== y (goto pull)
:start
cls
echo you are in %cd%
git branch
echo -----------------------------------------
echo 1 - initialize repo
echo 2 - initialize and pull repo 
echo 3 - commit changes
echo 4 - force commit
echo 5 - set global account
echo 6 - pull branch
echo 7 - create branch
echo 8 - switch branch
echo 9 - push changes
echo 10 - merge branches
echo 11 - reset commit changes
echo 12 - change repo
echo 13 - update current branch from master
echo -----------------------------------------
set /p "set=What do you want to do(input the corresponding number)?"
if %set%== 1 (goto init)
if %set%== 2 (goto initpull)
if %set%== 3 (goto commit)
if %set%== 4 (goto force)
if %set%== 5 (goto login)
if %set%== 6 (goto pull)
if %set%== 7 (goto createB)
if %set%== 8 (goto switch)
if %set%== 9 (goto push)
if %set%== 10 (goto merge)
if %set%== 11 (goto reset)
if %set%== 12 (goto switchRepo)
if %set%== 13 (goto updateBranch)
pause
goto end

:switchRepo
set /p folder="Which folder are you trying to open(Enter folder path or folder name [folder name must be in the current folder])?"
cd %folder%
goto start

:updateBranch
git fetch origin master
git rebase origin master
pause
goto start


:reset
echo Resetting the changes from last commit
git reset
echo done
pause
goto start

:merge
echo The highlighted green text is where you are right now
git branch
set /p merge="Which branch do you want to merge from?"
git merge %merge%
pause
goto start

:switch
git branch
set /p set="Which branch do you want to switch to?"
git checkout %set%
pause
goto start


:createB
set /p branch="What would your branch name be?"
git checkout -b %branch%
set /p pull="Which branch do you want to pull from?"
git pull origin %pull%
git commit -m "Created a new branch from %pull%"
git push origin %branch%
goto start


:commit
cls
set /p reason="Enter your reason for this commit:"
git add .
git commit -m "%reason%"
pause
goto push


:push
git branch
set /p branch="Which branch do you want to push to?"
git push origin %branch%
pause
goto start

:force
cls
echo DO THIS ONLY IF YOU REALLY NEED TO
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
git remote add origin %origin%
git add .
git commit -m "first commit"
git push -u origin master
echo finished setup
pause
goto start

:initpull
set /p origin="What is your origin?"
git init
git remote add origin %origin%
set /p branch="What is the branch you want to pull from?"
git pull origin %branch%
git checkout %branch%
echo finished updating local repository
pause 
goto start

:end 
cls
set /p stop="Continue?(y for yes. if yes input anything else)?"
if %stop% == y (goto start) 
exit

:pull
git branch
set /p branch="What branch do you want to pull from?"
git pull origin %branch%
pause
goto start

:login
cls 
set /p username="What is your username?"
set /p password="What is your password?"
git config --global user.email "%username%"
git config --global user.password "%password%"
goto start