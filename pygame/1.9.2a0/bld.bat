rem Building pygame for windows is hell, so we use the wheel files kindly provided
rem by dr. Gohlke: http://www.lfd.uci.edu/~gohlke/. It is assumed they are placed in
rem the C:\Libraries directory

@echo off
c:
cd \Libraries
pip install pygame-1.9.2a0-cp%CONDA_PY%-none-win_amd64.whl
if errorlevel 1 exit 1
