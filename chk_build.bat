echo off

echo *** Building nkcodec ***
call ddkbuild -quiet -WNET free nkcodec
copy /Y nkcodec\objfre_wnet_x86\i386\nkcodec.lib shared

echo *** Building nkcontrol ***
call ddkbuild -quiet -WNET free nkcontrol

echo *** Building nkfilter ***
call ddkbuild -quiet -WNET checked nkfilter

echo *** Copying files ***
xcopy /Y nkfilter\objchk_wnet_x86\i386\nkfilter.sys compiled\*
xcopy /Y nkcontrol\objfre_wnet_x86\i386\nkcontrol.exe compiled\*
xcopy /Y inf\nkfilter.inf compiled\*

echo on
