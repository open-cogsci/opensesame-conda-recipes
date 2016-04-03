rem assumes https://www.libsdl.org/release/SDL-devel-1.2.15-VC.zip has been
rem downloaded and extracted to C:\Libraries



"%PYTHON%" setup.py install
if errorlevel 1 exit 1
