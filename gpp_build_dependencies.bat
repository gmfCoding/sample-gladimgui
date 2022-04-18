@echo off
@REM %~dp0 is this batch files' containing directory

@REM This may seem overly overcomplicated but really it's just running:
@REM g++ -c %~dp0app\vendor\glad\src\glad.c -o %~dp0gppouttmp\glad.o -I%~dp0app\vendor\glad\include
@REM using my overly complicated somewhat extensible batch script (that originally hard more objects/arguments)

@REM Glad - OpenGL loader
set obj[0].Name=Glad  
set obj[0].ARGS=-c %~dp0app\vendor\glad\src\glad.c -o %~dp0gppouttmp\glad.o -I%~dp0app\vendor\glad\include

if not exist gppouttmp mkdir gppouttmp

@REM Build each object
FOR /L %%i IN (0 1 ) DO  (

   call g++ %%obj[%%i].ARGS%%

   if %ERRORLEVEL% EQU 0 (
      call echo Successfully %%obj[%%i].Name%%
   ) else (
      call echo %%obj[%%i].Name%% build failled, reason: %errorlevel%
   )
)

@REM P.S I don't like batch.