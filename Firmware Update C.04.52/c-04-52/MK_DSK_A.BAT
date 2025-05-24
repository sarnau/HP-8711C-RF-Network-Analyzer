echo off
REM Copyright: 1995, Hewlett-Packard All rights reserved.
REM Fri Aug  8 15:56:43 PDT 1995
REM
REM DOS batch script to create HP 871XC RF Network Analyzer
REM firmware update disks.
REM
REM Microwave Instrument Division, Hewlett-Packard Co.
REM

REM Prepare LIF firmware update disk using drive A:
echo ---------
echo ***** This routine will NOT work if using Windows NT! *****
echo ---------
echo Insert DOS formatted disk (not write-protected) into floppy drive A: 
echo WARNING!!  All data will be lost on this disk.
pause

lif init A: /d
echo Copying C871XC_0
lif cp C871XC_0  A:C871XC_0    /O /R /T:-23951 /I:0
echo Copying C871XC_1
lif cp C871XC_1  A:C871XC_1    /O /R /T:-23951 
echo Copying C871XC_2
lif cp C871XC_2  A:C871XC_2    /O /R /T:-23951 
echo Copying C871XC_3
lif cp C871XC_3  A:C871XC_3    /O /R /T:-23951 
echo Copying C871XC_4
lif cp C871XC_4  A:C871XC_4    /O /R /T:-23951 
echo Copying C871XC_5
lif cp C871XC_5  A:C871XC_5    /O /R /T:-23951 
echo Copying C871XC_6
lif cp C871XC_6  A:C871XC_6    /O /R /T:-23951 
echo Copying ASCII ID file
lif cp C_04_52C  A:C_04_52C    /O /A

echo Done.
:end
