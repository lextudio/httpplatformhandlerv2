iisreset /stop
copy artifacts\bin\OutOfProcessRequestHandler\Win32\Debug\httpbridge_outofprocess.dll "C:\Program Files (x86)\IIS Express\HTTP Bridge Module\V2\18.0.24105"
copy artifacts\bin\OutOfProcessRequestHandler\Win32\Debug\httpbridge_outofprocess.pdb "C:\Program Files (x86)\IIS Express\HTTP Bridge Module\V2\18.0.24105"
copy artifacts\bin\AspNetCoreModuleShim\Win32\Debug\httpbridge.dll "C:\Program Files (x86)\IIS Express\HTTP Bridge Module\V2"
copy artifacts\bin\AspNetCoreModuleShim\Win32\Debug\httpbridge.pdb "C:\Program Files (x86)\IIS Express\HTTP Bridge Module\V2"
iisreset /start
