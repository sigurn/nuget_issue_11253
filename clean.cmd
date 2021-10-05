@echo off

if exist obj rmdir /s /q obj
if exist obj_vs2017 rmdir /s /q obj_vs2017
if exist obj_vs2019 rmdir /s /q obj_vs2019
if exist obj_vs2019_transitive rmdir /s /q obj_vs2019_transitive

if exist out_vs2017.txt del /q out_vs2017.txt
if exist out_vs2019.txt del /q out_vs2019.txt
if exist out_vs2019_transitive.txt del /q out_vs2019_transitive.txt