@echo off

:INITIALIZE

  set bkp_dir=%UserProfile%\bkp
  set time2=%time: =0%
  set dest_dir=%bkp_dir%\%date:/=-%-%time2::=%

:CREATE_BACKUP_FOLDER

  if not exist %bkp_dir% (
    mkdir %bkp_dir%
    if "%ErrorLevel%" == "0" (
      echo Created backup root folder
    ) else (
      echo Failed to create backup folder
    )
    echo %bkp_dir%
  )

:CREATE_CURRENT_TIMESTAMP_FOLDER

  echo BackupFolder: %dest_dir%
  echo.
  mkdir %dest_dir%

:BACKUP_ARGUMENTS

  for %%a in (%*) do (
    xcopy %%a %dest_dir% /D /S /R /Y /I /K /H
    
    if not "%ErrorLevel%" == "0" (
      echo Failed...
      pause
    )
  )

:FINISH

  timeout 5

