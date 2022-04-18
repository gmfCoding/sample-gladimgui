@echo off
@REM multiLine contains the supplied argumnets to g++
@REM Legend:
@REM %~dp0 (working directory of this batch file)
@REM -I G++ include directory
@REM -l G++ link library
@REM -o G++ out file path
@REM A space is required before each argument

echo This is an example file for compiling this project, it however requires manual building of glfw3
echo Then copying the built library files into %~dp0lib directory (such as lib\glfw3dll.lib)
echo Then later copying glfw3.dll into gppout
echo Avoiding to do so will result in ("ld.exe: cannot find -lglfw3: No such file or directory")

pause
set multiLine=-g^
 %~dp0app\src\*.cpp^
 %~dp0app\vendor\imgui\*.cpp^
 %~dp0app\vendor\imgui\backends\imgui_impl_opengl3.cpp^
 %~dp0app\vendor\imgui\backends\imgui_impl_glfw.cpp^
 -o%~dp0gppout\main.exe^
 %~dp0gppouttmp\glad.o^
 -I%~dp0app\srcinc^
 -I%~dp0app\vendor\include^
 -I%~dp0app\vendor\glad\include^
 -I%~dp0app\vendor\imgui^
 -I%~dp0app\vendor\imgui\backends^
 -I%~dp0app\vendor\glfw^
 -L%~dp0lib\^
 -DGLFW_INCLUDE_NONE^
 -lglfw3dll^
 -lshlwapi^
 -std=c++17^


if not exist gppouttmp mkdir gppouttmp
if not exist gppout mkdir gppout

C:\msys64\mingw64\bin\g++.exe %multiLine%


if %ERRORLEVEL% EQU 0 (
   echo Success
) else (
   echo Failure Reason Given is %errorlevel%
)

pause