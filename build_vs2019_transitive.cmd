@echo off

setlocal enableextensions

if exist obj rmdir /s /q obj
if exist obj_vs2019_transitive rmdir /s /q obj_vs2019

set VS2019=C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\

if NOT EXIST "%VS2019%" @echo VS2019 has not been found! & exit /b 1
call "%VS2019%\vcvarsall.bat" x64 || exit /b 1

msbuild.exe /nologo /m /p:TestBuildTransitive=True /t:Restore %~dp0build.proj || exit /b 1
msbuild.exe /nologo /m /t:Test %~dp0build.proj > out_vs2019_transitive.txt || exit /b 1
ren obj obj_vs2019_transitive
