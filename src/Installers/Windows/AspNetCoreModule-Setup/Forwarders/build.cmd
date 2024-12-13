SET objDir=%1
SET binDir=%2

cl /nologo /c /Fo%objDir%\httpplatformhandlerv2_arm64.obj empty.cpp
cl /nologo /c /arm64EC /Fo%objDir%\httpplatformhandlerv2_x64.obj empty.cpp

link /lib /nologo /machine:arm64 /def:httpplatformhandlerv2_arm64.def /out:%objDir%\httpplatformhandlerv2_arm64.lib
link /lib /nologo /machine:x64 /def:httpplatformhandlerv2_x64.def /out:%objDir%\httpplatformhandlerv2_x64.lib

link /dll /nologo /noentry /machine:arm64x /defArm64Native:httpplatformhandlerv2_arm64.def /def:httpplatformhandlerv2_x64.def %objDir%\httpplatformhandlerv2_arm64.obj %objDir%\httpplatformhandlerv2_x64.obj /out:%binDir%\httpplatformhandlerv2.dll %objDir%\httpplatformhandlerv2_arm64.lib %objDir%\httpplatformhandlerv2_x64.lib

cl /nologo /nologo /c /Fo%objDir%\httpplatformhandlerv2_outofprocess_arm64.obj empty.cpp
cl /nologo /nologo /c /arm64EC /Fo%objDir%\httpplatformhandlerv2_outofprocess_x64.obj empty.cpp

link /lib /nologo /machine:arm64 /def:httpplatformhandlerv2_outofprocess_arm64.def /out:%objDir%\httpplatformhandlerv2_outofprocess_arm64.lib
link /lib /machine:x64 /def:httpplatformhandlerv2_outofprocess_x64.def /out:%objDir%\httpplatformhandlerv2_outofprocess_x64.lib

link /dll /nologo /noentry /machine:arm64x /defArm64Native:httpplatformhandlerv2_outofprocess_arm64.def /def:httpplatformhandlerv2_outofprocess_x64.def %objDir%\httpplatformhandlerv2_outofprocess_arm64.obj %objDir%\httpplatformhandlerv2_outofprocess_x64.obj /out:%binDir%\httpplatformhandlerv2_outofprocess.dll %objDir%\httpplatformhandlerv2_outofprocess_arm64.lib %objDir%\httpplatformhandlerv2_outofprocess_x64.lib
