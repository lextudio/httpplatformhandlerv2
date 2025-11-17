SET objDir=%1
SET binDir=%2
SET configuration=%3

cl /nologo /c /Fo%objDir%\httpbridge_arm64.obj empty.cpp
cl /nologo /c /arm64EC /Fo%objDir%\httpbridge_x64.obj empty.cpp

link /lib /nologo /machine:arm64 /def:httpbridge_arm64.def /out:%objDir%\httpbridge_arm64.lib
link /lib /nologo /machine:x64 /def:httpbridge_x64.def /out:%objDir%\httpbridge_x64.lib

link /dll /nologo /noentry /machine:arm64x /defArm64Native:httpbridge_arm64.def /def:httpbridge_x64.def %objDir%\httpbridge_arm64.obj %objDir%\httpbridge_x64.obj %objDir%\..\AspNetCoreModuleShim\x64\%configuration%\aspnetcoremodule.res /out:%binDir%\httpbridge.dll %objDir%\httpbridge_arm64.lib %objDir%\httpbridge_x64.lib /FORCE:UNRESOLVED

cl /nologo /nologo /c /Fo%objDir%\httpbridge_outofprocess_arm64.obj empty.cpp
cl /nologo /nologo /c /arm64EC /Fo%objDir%\httpbridge_outofprocess_x64.obj empty.cpp

link /lib /nologo /machine:arm64 /def:httpbridge_outofprocess_arm64.def /out:%objDir%\httpbridge_outofprocess_arm64.lib
link /lib /nologo /machine:x64 /def:httpbridge_outofprocess_x64.def /out:%objDir%\httpbridge_outofprocess_x64.lib

link /dll /nologo /noentry /machine:arm64x /defArm64Native:httpbridge_outofprocess_arm64.def /def:httpbridge_outofprocess_x64.def %objDir%\httpbridge_outofprocess_arm64.obj %objDir%\httpbridge_outofprocess_x64.obj %objDir%\..\OutOfProcessRequestHandler\x64\%configuration%\outofprocessrequesthandler.res /out:%binDir%\httpbridge_outofprocess.dll %objDir%\httpbridge_outofprocess_arm64.lib %objDir%\httpbridge_outofprocess_x64.lib /FORCE:UNRESOLVED
