@echo off

set bkp_dir=%UserProfile%\bkp
set time2=%time: =0%
set dest_dir=%bkp_dir%\%date:~0,4%-%date:~5,2%%date:~8,2%-%time2:~0,2%%time2:~3,2%-%time2:~6,2%%time2:~9,2%

if not exist %bkp_dir% (
  mkdir %bkp_dir%
  if "%ErrorLevel%" == "0" (
    echo Created backup root folder
  ) else (
    echo Failed to create backup folder
  )
  echo %bkp_dir%
)

echo BackupFolder: %dest_dir%
mkdir %dest_dir%

for %%a in (%*) do (
  xcopy %%a %dest_dir% /D /S /R /Y /I /K /H
  
  if not "%ErrorLevel%" == "0" (
    echo Failed...
    pause
  )
)

timeout 3

