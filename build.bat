@echo off
set "gameName=pong"
set "playdatePath=C:\Program Files (x86)\Playdate"
set "sourcePath=%~f0\..\source"
set "outputPath=%~f0\..\%gameName%.pdx"

call "%playdatePath%\bin\pdc.exe" -sdkpath "%playdatePath%" "%sourcePath%" "%outputPath%"
call "%playdatePath%\bin\PlaydateSimulator.exe" "%outputPath%"
