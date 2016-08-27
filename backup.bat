@echo off

:CONFIG_SETTINGS

  set bkp_path=%UserProfile%\bkp
  set xcopy_opts=/D /S /R /Y /I /K /H

:CREATE_BACKUP_FOLDER

  if not exist %bkp_path% (
    mkdir %bkp_path%
    if "%ErrorLevel%" == "0" (
      echo Created backup root folder
    ) else (
      echo Failed to create backup folder
    )
    echo %bkp_path%
  )

:CREATE_CURRENT_TIMESTAMP_FOLDER

  set time2=%time: =0%
  set dest_path=%bkp_path%\%date:/=-%-%time2::=%
  mkdir %dest_path%
  echo BackupFolder: %dest_path%
  echo.

:BACKUP_ARGUMENTS

  for %%a in (%*) do (
    xcopy %%a %dest_path% %xcopy_opts%
    
    if not "%ErrorLevel%" == "0" (
      echo Failed to backup ...
      pause
    )
  )

:FINISH

  timeout 5

