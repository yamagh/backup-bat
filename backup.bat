@echo off

:CONFIG

  set bkp_path=%UserProfile%\bkp
  set copy_cmd=xcopy
  set copy_opts=/C /R /Y /I /K /H /S

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
    if exist "%%a\" (
      %copy_cmd% %%a "%dest_path%\%%~na" %copy_opts%
    ) else (
      %copy_cmd% %%a "%dest_path%" %copy_opts%
    )
    
    if not "%ErrorLevel%" == "0" (
      echo Failed to backup ...
      pause
    )
  )

:FINISH

  timeout 3

