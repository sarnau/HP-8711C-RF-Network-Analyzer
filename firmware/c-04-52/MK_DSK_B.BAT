echo off
REM Copyright: 1995, Hewlett-Packard All rights reserved.
REM Fri Aug  8 15:56:43 PDT 1995
REM
REM DOS batch script to create HP 871XC RF Network Analyzer
REM firmware update disks.
REM
REM Microwave Instrument Division, Hewlett-Packard Co.
REM

REM Prepare LIF firmware update disk using drive B:
echo ---------
echo ***** This routine will NOT work if using Windows NT! *****
echo ---------
echo Insert DOS formatted disk (not write-protected) into floppy drive B: 
echo WARNING!!  All data will be lost on this disk.
pause

lif init B: /d
echo Copying C871XC_0
lif cp C871XC_0  B:C871XC_0    /O /R /T:-23951 /I:0
echo Copying B871XB_1
lif cp C871XC_1  B:C871XC_1    /O /R /T:-23951 
echo Copying B871XB_2
lif cp C871XC_2  B:C871XC_2    /O /R /T:-23951 
echo Copying B871XB_3
lif cp C871XC_3  B:C871XC_3    /O /R /T:-23951 
echo Copying B871XB_4
lif cp C871XC_4  B:C871XC_4    /O /R /T:-23951 
echo Copying B871XB_5
lif cp C871XC_5  B:C871XC_5    /O /R /T:-23951 
echo Copying C871XC_6
lif cp C871XC_6  B:C871XC_6    /O /R /T:-23951 
echo Copying ASCII ID file
lif cp C_04_52C  B:C_04_52C    /O /A

echo Done.
:end
