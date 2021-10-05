@echo off

setlocal enableextensions

if exist obj rmdir /s /q obj
if exist obj_vs2017 rmdir /s /q obj_vs2017

set VS2017=C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Auxiliary\Build\

if NOT EXIST "%VS2017%" @echo VS2017 has not been found! & exit /b 1
call "%VS2017%\vcvarsall.bat" x64 || exit /b 1

if "%*" == "" (
    msbuild.exe /nologo /m /t:Restore %~dp0build.proj || exit /b 1
    msbuild.exe /nologo /m /t:Test %~dp0build.proj > out_vs2017.txt || exit /b 1
    ren obj obj_vs2017
) else (
    msbuild.exe /nologo /m %* %~dp0build.proj || exit /b 1
)