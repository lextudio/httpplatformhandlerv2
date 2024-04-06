iisreset /stop
copy ..\..\..\..\artifacts\bin\OutOfProcessRequestHandler\Win32\Debug\httpplatformhandlerv2_outofprocess.dll "C:\Program Files (x86)\IIS\HttpPlatformHandler Module\V2\18.0.24098"
copy ..\..\..\..\artifacts\bin\OutOfProcessRequestHandler\Win32\Debug\httpplatformhandlerv2_outofprocess.pdb "C:\Program Files (x86)\IIS\HttpPlatformHandler Module\V2\18.0.24098"
copy ..\..\..\..\artifacts\bin\AspNetCoreModuleShim\Win32\Debug\httpplatformhandlerv2.dll "C:\Program Files (x86)\IIS\HttpPlatformHandler Module\V2"
copy ..\..\..\..\artifacts\bin\AspNetCoreModuleShim\Win32\Debug\httpplatformhandlerv2.pdb "C:\Program Files (x86)\IIS\HttpPlatformHandler Module\V2"
iisreset /start
