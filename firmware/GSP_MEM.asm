04200000h: .word 0
HESYNC:
C0000000h: .word 0017h
HSBLNK:
C0000020h: .word 0022h
VESYNC:
C0000040h: .word 00C2h
VSBLNK:
C0000060h: .word 00C6h
DPYCTL:
C0000080h: .word 0001h
DPYINT:
C00000A0h: .word 0021h
HSTDATA:
C00000C0h: .word 0201h
HSTADRL:
C00000E0h: .word 020Ch
HSTCTLH:
C0000100h: .word 7410h
INTPEND:
C0000120h: .word 1E00h
CONVDP:
C0000140h: .word 0000h
PMASK:
C0000160h: .word 00CCh
REG_0x0180:
C0000180h: .word 0000h
REG_0x01A0:
C00001A0h: .word 0000h
HCOUNT:
C00001C0h: .word 0000h
DPYADR:
C00001E0h: .word 0000h
C0000200h: .word 8000h
C0000220h: .word 0000h
C0000240h: .word 0000h
C0000260h: .word 0000h
C0000280h: .word 0000h
C00002A0h: .word 0004h
C00002C0h: .word 0000h
C00002E0h: .word 0000h
C0000300h: .word 0000h
C0000320h: .word 0000h
C0000340h: .word 0000h
C0000360h: .word 0000h
C0000380h: .word 0000h
C00003A0h: .word 0000h
C00003C0h: .word 0000h
C00003E0h: .word 0000h
USERFLAGS:
FFDA0000h: .bss 512*8
********************************************************************************
* RESET_VECTOR
********************************************************************************
RESET_VECTOR:
FFDA8000h: 0360                     DINT
FFDA8010h: 0740                     SETF   20h,0,1
FFDA8020h: 09EF FDF0 FFDD           MOVI   STACK_TOP,SP
FFDA8050h: 0544                     SETF   4h,0,0
FFDA8060h: 058F 00F3 C000           MOVE   SP,@HSTCTLL+3,0
FFDA8090h: 0550                     SETF   10h,0,0
FFDA80A0h: 09F3 1000 0000           MOVI   00001000h,B3_DPTCH
FFDA80D0h: 09F5 0000 0000           MOVI   SCREENBASE_0x0000_0000,B5_WSTART
FFDA8100h: 09F6 027F 01DF           MOVI   01DF027Fh,B6_WEND
FFDA8130h: 5718                     CLR    B8_COLOR0
FFDA8140h: 5739                     CLR    B9_COLOR1
FFDA8150h: 09FD FFFF FFFF           MOVI   FFFFFFFFh,B13_PATTRN
FFDA8180h: 6A7E                     LMO    B3_DPTCH,B14_TEMP
FFDA8190h: 059E 0140 C000           MOVE   B14_TEMP,@CONVDP,0
FFDA81C0h: 09F4 0000 003C           MOVI   SCREENBASE_0x003C_0000,B4_OFFSET
FFDA81F0h: 0D3F 08B4                CALLR  CLEAR_SCREEN
FFDA8210h: 09F4 0000 0000           MOVI   SCREENBASE_0x0000_0000,B4_OFFSET
FFDA8240h: 0D3F 08AF                CALLR  CLEAR_SCREEN
FFDA8260h: 09F4 0000 001E           MOVI   SCREENBASE_0x001E_0000,B4_OFFSET
FFDA8290h: 0D3F 08AA                CALLR  CLEAR_SCREEN
FFDA82B0h: 09C1 1DF0                MOVI   1DF0h,A1
FFDA82D0h: 0581 0090 C000           MOVE   A1,@DPYSTRT,0
FFDA8300h: 0541                     SETF   1h,0,0
FFDA8310h: 1821                     MOVK   1h,A1
FFDA8320h: 0581 008F C000           MOVE   A1,@DPYCTL+15,0
FFDA8350h: 0550                     SETF   10h,0,0
FFDA8360h: 5621                     CLR    A1
FFDA8370h: 0581 0840 FFEC           MOVE   A1,@FFEC0840h,0
FFDA83A0h: 05C0 0060 C000 00A0 C000 MOVE   @VSBLNK,@DPYINT,0
FFDA83F0h: 0542                     SETF   2h,0,0
FFDA8400h: 1861                     MOVK   3h,A1
FFDA8410h: 0581 0119 C000           MOVE   A1,@INTENB+9,0
FFDA8440h: 0550                     SETF   10h,0,0
FFDA8450h: 0D60                     EINT
FFDA8460h: 0550                     SETF   10h,0,0
FFDA8470h: 0740                     SETF   20h,0,1
FFDA8480h: 09F5 0280 01E0           MOVI   01E00280h,B5_WSTART
FFDA84B0h: 0795 0A20 FFEC           MOVE   B5_WSTART,@FFEC0A20h,1
FFDA84E0h: 09F5 0000 0000           MOVI   SCREENBASE_0x0000_0000,B5_WSTART
FFDA8510h: 09F6 027F 01DF           MOVI   01DF027Fh,B6_WEND
FFDA8540h: 0795 0A00 FFEC           MOVE   B5_WSTART,@FFEC0A00h,1
FFDA8570h: 0795 0A40 FFEC           MOVE   B5_WSTART,@CLIP_MIN_XY,1
FFDA85A0h: 0796 0A60 FFEC           MOVE   B6_WEND,@CLIP_MAX_XY,1
FFDA85D0h: 5684                     CLR    A4
FFDA85E0h: 054A                     SETF   Ah,0,0
FFDA85F0h: 18C1                     MOVK   6h,A1
FFDA8600h: 0581 00B5 C000           MOVE   A1,@CONTROL+5,0
FFDA8630h: 0550                     SETF   10h,0,0
FFDA8640h: 07A8 E000 FFEC           MOVE   @CMD_LIST_PTR,A8,1
FFDA8670h: 09ED 1000 FFDD           MOVI   CMD_STACK,A13
********************************************************************************
* CMD_LOOP
********************************************************************************
CMD_LOOP:
FFDA86A0h: 0788 0800 FFEC           MOVE   A8,@CURRENT_CMD_PC,1
FFDA86D0h: 9501                     MOVE   *A8+,A1,0
FFDA86E0h: 0781 0820 FFEC           MOVE   A1,@CURRENT_CMD,1
FFDA8710h: 0B41 FF57                CMPI   A8h,A1
FFDA8730h: C706                     JRGT   ILLEGAL_CMD
FFDA8740h: 24A1                     SLL    5h,A1
FFDA8750h: 0B21 8000 FFDC           ADDI   CMD_ADR_TABLE,A1
FFDA8780h: 8621                     MOVE   *A1,A1,1
FFDA8790h: 0161                     JUMP   A1

********************************************************************************
* ILLEGAL_CMD
********************************************************************************
ILLEGAL_CMD:
FFDA87A0h: 1608                     SUBK   10h,A8
FFDA87B0h: C0FF                     JR     FFDA87B0h

********************************************************************************
* COMMAND_2_ARC
********************************************************************************
COMMAND_2_ARC:
FFDA87C0h: 9501                     MOVE   *A8+,A1,0
FFDA87D0h: 9501                     MOVE   *A8+,A1,0
FFDA87E0h: 9501                     MOVE   *A8+,A1,0
FFDA87F0h: C0EA                     JR     CMD_LOOP

********************************************************************************
* COMMAND_4_BENCHMARK_TEXT
********************************************************************************
COMMAND_4_BENCHMARK_TEXT:
FFDA8800h: 07BB 0AE0 FFEC           MOVE   @FFEC0AE0h,B11_INC1,1
FFDA8830h: 07BA 0AC0 FFEC           MOVE   @FFEC0AC0h,B10_COUNT,1
FFDA8860h: 455B                     SUB    B10_COUNT,B11_INC1
FFDA8870h: 09FA 0C80 0000           MOVI   00000C80h,B10_COUNT
FFDA88A0h: 5F5B                     MPYU   B10_COUNT,B11_INC1
FFDA88B0h: 09DA 0064                MOVI   64h,B10_COUNT
FFDA88D0h: 5B5B                     DIVU   B10_COUNT,B11_INC1
FFDA88E0h: 4D7A                     MOVE   B11_INC1,B10_COUNT
FFDA88F0h: 195C                     MOVK   Ah,B12_INC2
FFDA8900h: 09FB 9680 0098           MOVI   00989680h,B11_INC1
FFDA8930h: 09E1 0B00 FFEC           MOVI   FFEC0B00h,A1
FFDA8960h: 09C2 0030                MOVI   30h,A2
FFDA8980h: 1022                     INC    A2
FFDA8990h: 457A                     SUB    B11_INC1,B10_COUNT
FFDA89A0h: C9FD                     JRNC   FFDA8980h
FFDA89B0h: 1422                     DEC    A2
FFDA89C0h: 417A                     ADD    B11_INC1,B10_COUNT
FFDA89D0h: 9041                     MOVE   A2,*A1+,0
FFDA89E0h: 5B9B                     DIVU   B12_INC2,B11_INC1
FFDA89F0h: CBF6                     JRNE   FFDA8960h
FFDA8A00h: 4D01                     MOVE   A8,A1
FFDA8A10h: 09E8 0B00 FFEC           MOVI   FFEC0B00h,A8
FFDA8A40h: 1903                     MOVK   8h,A3
FFDA8A50h: C000 04A1                JR     FFDAD480h

********************************************************************************
* COMMAND_6_BINARY_MAP
********************************************************************************
COMMAND_6_BINARY_MAP:
FFDA8A70h: 9701                     MOVE   *A8+,A1,1
FFDA8A80h: 4E20                     MOVE   A1,B0_SADDR
FFDA8A90h: 9411                     MOVE   *B0_SADDR+,B1_SPTCH,0
FFDA8AA0h: 6A3E                     LMO    B1_SPTCH,B14_TEMP
FFDA8AB0h: 059E 0130 C000           MOVE   B14_TEMP,@CONVSP,0
FFDA8AE0h: 4E82                     MOVE   A4,B2_DADDR
FFDA8AF0h: 9617                     MOVE   *B0_SADDR+,B7_DVDX,1
FFDA8B00h: 0FA0                     PIXBLT B,XY
FFDA8B10h: C0B8                     JR     CMD_LOOP

********************************************************************************
* COMMAND_8_CIRCLE
********************************************************************************
COMMAND_8_CIRCLE:
FFDA8B20h: 9503                     MOVE   *A8+,A3,0
FFDA8B30h: 0503                     SEXT   A3,0
FFDA8B40h: 0383                     ABS    A3
FFDA8B50h: CA36                     JREQ   FFDA8EC0h
FFDA8B60h: 09E1 0000 0001           MOVI   00010000h,A1
FFDA8B90h: 0750                     SETF   10h,0,1
FFDA8BA0h: 5E61                     MPYU   A3,A1
FFDA8BB0h: 5729                     CLR    A9
FFDA8BC0h: 2E01                     SRL    10h,A1
FFDA8BD0h: 4321                     ADDC   A9,A1
FFDA8BE0h: 4C82                     MOVE   A4,A2
FFDA8BF0h: E022                     ADDXY  A1,A2
FFDA8C00h: 4E4A                     MOVE   A2,B10_COUNT
FFDA8C10h: 4E4E                     MOVE   A2,B14_TEMP
FFDA8C20h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY
FFDA8C30h: 4C82                     MOVE   A4,A2
FFDA8C40h: E222                     SUBXY  A1,A2
FFDA8C50h: 4E4B                     MOVE   A2,B11_INC1
FFDA8C60h: 4E4C                     MOVE   A2,B12_INC2
FFDA8C70h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY
FFDA8C80h: 1832                     MOVK   1h,B2_DADDR
FFDA8C90h: 2612                     SLL    10h,B2_DADDR
FFDA8CA0h: 4C50                     MOVE   B2_DADDR,B0_SADDR
FFDA8CB0h: 1831                     MOVK   1h,B1_SPTCH
FFDA8CC0h: E230                     SUBXY  B1_SPTCH,B0_SADDR
FFDA8CD0h: E051                     ADDXY  B2_DADDR,B1_SPTCH
FFDA8CE0h: 4C57                     MOVE   B2_DADDR,B7_DVDX
FFDA8CF0h: E237                     SUBXY  B1_SPTCH,B7_DVDX
FFDA8D00h: 5E63                     MPYU   A3,A3
FFDA8D10h: 4C65                     MOVE   A3,A5
FFDA8D20h: 2425                     SLL    1h,A5
FFDA8D30h: 4CA6                     MOVE   A5,A6
FFDA8D40h: 2426                     SLL    1h,A6
FFDA8D50h: 4CA7                     MOVE   A5,A7
FFDA8D60h: 5E27                     MPYU   A1,A7
FFDA8D70h: 5E21                     MPYU   A1,A1
FFDA8D80h: 0740                     SETF   20h,0,1
FFDA8D90h: 4C22                     MOVE   A1,A2
FFDA8DA0h: 2422                     SLL    1h,A2
FFDA8DB0h: 4C40                     MOVE   A2,A0
FFDA8DC0h: 2420                     SLL    1h,A0
FFDA8DD0h: 2FE1                     SRL    1h,A1
FFDA8DE0h: 2FE3                     SRL    1h,A3
FFDA8DF0h: 44E3                     SUB    A7,A3
FFDA8E00h: 2427                     SLL    1h,A7
FFDA8E10h: 44E1                     SUB    A7,A1
FFDA8E20h: 40A1                     ADD    A5,A1
FFDA8E30h: 05AA 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A10,0
FFDA8E60h: CB07                     JRNE   FFDA8EE0h
FFDA8E70h: 4043                     ADD    A2,A3
FFDA8E80h: CE19                     JRN    FFDA9020h
FFDA8E90h: C025                     JR     FFDA90F0h

FFDA8EA0h: 495B                     CMP    B10_COUNT,B11_INC1
FFDA8EB0h: CB36                     JRNE   FFDA9220h
FFDA8EC0h: C000 FF7C                JR     CMD_LOOP

FFDA8EE0h: 099F 0084                MMTM   SP,B8_COLOR0,B13_PATTRN
FFDA8F00h: E2FA                     SUBXY  B7_DVDX,B10_COUNT
FFDA8F10h: F6FA                     DRAV   B7_DVDX,B10_COUNT
FFDA8F20h: E2FB                     SUBXY  B7_DVDX,B11_INC1
FFDA8F30h: F6FB                     DRAV   B7_DVDX,B11_INC1
FFDA8F40h: 4C3D                     MOVE   B1_SPTCH,B13_PATTRN
FFDA8F50h: E2FD                     SUBXY  B7_DVDX,B13_PATTRN
FFDA8F60h: 4C18                     MOVE   B0_SADDR,B8_COLOR0
FFDA8F70h: E0F8                     ADDXY  B7_DVDX,B8_COLOR0
FFDA8F80h: 4043                     ADD    A2,A3
FFDA8F90h: CE45                     JRN    FFDA93F0h
FFDA8FA0h: C055                     JR     FFDA9500h

FFDA8FB0h: E230                     SUBXY  B1_SPTCH,B0_SADDR
FFDA8FC0h: 495B                     CMP    B10_COUNT,B11_INC1
FFDA8FD0h: CB69                     JRNE   FFDA9670h
FFDA8FE0h: 09BF 2100                MMFM   SP,B8_COLOR0,B13_PATTRN
FFDA9000h: C000 FF68                JR     CMD_LOOP

FFDA9020h: E05A                     ADDXY  B2_DADDR,B10_COUNT
FFDA9030h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY
FFDA9040h: E05B                     ADDXY  B2_DADDR,B11_INC1
FFDA9050h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY
FFDA9060h: E25C                     SUBXY  B2_DADDR,B12_INC2
FFDA9070h: F13C                     PIXT   B9_COLOR1,*B12_INC2,XY
FFDA9080h: E25E                     SUBXY  B2_DADDR,B14_TEMP
FFDA9090h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY
FFDA90A0h: 4009                     ADD    A0,A9
FFDA90B0h: 4121                     ADD    A9,A1
FFDA90C0h: 4123                     ADD    A9,A3
FFDA90D0h: 4043                     ADD    A2,A3
FFDA90E0h: CEF3                     JRN    FFDA9020h
FFDA90F0h: E01A                     ADDXY  B0_SADDR,B10_COUNT
FFDA9100h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY
FFDA9110h: E03B                     ADDXY  B1_SPTCH,B11_INC1
FFDA9120h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY
FFDA9130h: E21C                     SUBXY  B0_SADDR,B12_INC2
FFDA9140h: F13C                     PIXT   B9_COLOR1,*B12_INC2,XY
FFDA9150h: E23E                     SUBXY  B1_SPTCH,B14_TEMP
FFDA9160h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY
FFDA9170h: 4009                     ADD    A0,A9
FFDA9180h: 44C7                     SUB    A6,A7
FFDA9190h: 44E1                     SUB    A7,A1
FFDA91A0h: 4121                     ADD    A9,A1
FFDA91B0h: 40A1                     ADD    A5,A1
FFDA91C0h: C5CD                     JRGE   FFDA8EA0h
FFDA91D0h: 44E3                     SUB    A7,A3
FFDA91E0h: 4123                     ADD    A9,A3
FFDA91F0h: 4043                     ADD    A2,A3
FFDA9200h: C5EE                     JRGE   FFDA90F0h
FFDA9210h: C0E0                     JR     FFDA9020h

FFDA9220h: E0FA                     ADDXY  B7_DVDX,B10_COUNT
FFDA9230h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY
FFDA9240h: E0FE                     ADDXY  B7_DVDX,B14_TEMP
FFDA9250h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY
FFDA9260h: E2FB                     SUBXY  B7_DVDX,B11_INC1
FFDA9270h: 495B                     CMP    B10_COUNT,B11_INC1
FFDA9280h: CAC3                     JREQ   FFDA8EC0h
FFDA9290h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY
FFDA92A0h: E2FC                     SUBXY  B7_DVDX,B12_INC2
FFDA92B0h: F13C                     PIXT   B9_COLOR1,*B12_INC2,XY
FFDA92C0h: 44C7                     SUB    A6,A7
FFDA92D0h: 44E1                     SUB    A7,A1
FFDA92E0h: 40A1                     ADD    A5,A1
FFDA92F0h: C5F2                     JRGE   FFDA9220h
FFDA9300h: E01A                     ADDXY  B0_SADDR,B10_COUNT
FFDA9310h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY
FFDA9320h: E23E                     SUBXY  B1_SPTCH,B14_TEMP
FFDA9330h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY
FFDA9340h: E03B                     ADDXY  B1_SPTCH,B11_INC1
FFDA9350h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY
FFDA9360h: E21C                     SUBXY  B0_SADDR,B12_INC2
FFDA9370h: F13C                     PIXT   B9_COLOR1,*B12_INC2,XY
FFDA9380h: 44C7                     SUB    A6,A7
FFDA9390h: 4009                     ADD    A0,A9
FFDA93A0h: 44E1                     SUB    A7,A1
FFDA93B0h: 40A1                     ADD    A5,A1
FFDA93C0h: 4121                     ADD    A9,A1
FFDA93D0h: C5E4                     JRGE   FFDA9220h
FFDA93E0h: C0F1                     JR     FFDA9300h

FFDA93F0h: E03A                     ADDXY  B1_SPTCH,B10_COUNT
FFDA9400h: F6FA                     DRAV   B7_DVDX,B10_COUNT
FFDA9410h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY
FFDA9420h: E03B                     ADDXY  B1_SPTCH,B11_INC1
FFDA9430h: F6FB                     DRAV   B7_DVDX,B11_INC1
FFDA9440h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY
FFDA9450h: E21C                     SUBXY  B0_SADDR,B12_INC2
FFDA9460h: F6FC                     DRAV   B7_DVDX,B12_INC2
FFDA9470h: F13C                     PIXT   B9_COLOR1,*B12_INC2,XY
FFDA9480h: E21E                     SUBXY  B0_SADDR,B14_TEMP
FFDA9490h: F6FE                     DRAV   B7_DVDX,B14_TEMP
FFDA94A0h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY
FFDA94B0h: 4009                     ADD    A0,A9
FFDA94C0h: 4121                     ADD    A9,A1
FFDA94D0h: 4123                     ADD    A9,A3
FFDA94E0h: 4043                     ADD    A2,A3
FFDA94F0h: CEEF                     JRN    FFDA93F0h
FFDA9500h: E05A                     ADDXY  B2_DADDR,B10_COUNT
FFDA9510h: F6FA                     DRAV   B7_DVDX,B10_COUNT
FFDA9520h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY
FFDA9530h: E1BB                     ADDXY  B13_PATTRN,B11_INC1
FFDA9540h: F6FB                     DRAV   B7_DVDX,B11_INC1
FFDA9550h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY
FFDA9560h: E31C                     SUBXY  B8_COLOR0,B12_INC2
FFDA9570h: F6FC                     DRAV   B7_DVDX,B12_INC2
FFDA9580h: F13C                     PIXT   B9_COLOR1,*B12_INC2,XY
FFDA9590h: E25E                     SUBXY  B2_DADDR,B14_TEMP
FFDA95A0h: F6FE                     DRAV   B7_DVDX,B14_TEMP
FFDA95B0h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY
FFDA95C0h: 4009                     ADD    A0,A9
FFDA95D0h: 44C7                     SUB    A6,A7
FFDA95E0h: 44E1                     SUB    A7,A1
FFDA95F0h: 4121                     ADD    A9,A1
FFDA9600h: 40A1                     ADD    A5,A1
FFDA9610h: C599                     JRGE   FFDA8FB0h
FFDA9620h: 44E3                     SUB    A7,A3
FFDA9630h: 4123                     ADD    A9,A3
FFDA9640h: 4043                     ADD    A2,A3
FFDA9650h: C5EA                     JRGE   FFDA9500h
FFDA9660h: C0D8                     JR     FFDA93F0h

FFDA9670h: E01A                     ADDXY  B0_SADDR,B10_COUNT
FFDA9680h: 495B                     CMP    B10_COUNT,B11_INC1
FFDA9690h: CA94                     JREQ   FFDA8FE0h
FFDA96A0h: E2FA                     SUBXY  B7_DVDX,B10_COUNT
FFDA96B0h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY
FFDA96C0h: E0FE                     ADDXY  B7_DVDX,B14_TEMP
FFDA96D0h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY
FFDA96E0h: E21B                     SUBXY  B0_SADDR,B11_INC1
FFDA96F0h: F6FB                     DRAV   B7_DVDX,B11_INC1
FFDA9700h: E21C                     SUBXY  B0_SADDR,B12_INC2
FFDA9710h: F6FC                     DRAV   B7_DVDX,B12_INC2
FFDA9720h: 44C7                     SUB    A6,A7
FFDA9730h: 44E1                     SUB    A7,A1
FFDA9740h: 40A1                     ADD    A5,A1
FFDA9750h: C5F1                     JRGE   FFDA9670h
FFDA9760h: E05A                     ADDXY  B2_DADDR,B10_COUNT
FFDA9770h: F6FA                     DRAV   B7_DVDX,B10_COUNT
FFDA9780h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY
FFDA9790h: E25E                     SUBXY  B2_DADDR,B14_TEMP
FFDA97A0h: F6FE                     DRAV   B7_DVDX,B14_TEMP
FFDA97B0h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY
FFDA97C0h: E1BB                     ADDXY  B13_PATTRN,B11_INC1
FFDA97D0h: F6FB                     DRAV   B7_DVDX,B11_INC1
FFDA97E0h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY
FFDA97F0h: E31C                     SUBXY  B8_COLOR0,B12_INC2
FFDA9800h: F6FC                     DRAV   B7_DVDX,B12_INC2
FFDA9810h: F13C                     PIXT   B9_COLOR1,*B12_INC2,XY
FFDA9820h: 44C7                     SUB    A6,A7
FFDA9830h: 4009                     ADD    A0,A9
FFDA9840h: 44E1                     SUB    A7,A1
FFDA9850h: 40A1                     ADD    A5,A1
FFDA9860h: 4121                     ADD    A9,A1
FFDA9870h: C5DF                     JRGE   FFDA9670h
FFDA9880h: C0ED                     JR     FFDA9760h

********************************************************************************
* COMMAND_10_COPY_RECTANGLE
********************************************************************************
COMMAND_10_COPY_RECTANGLE:
FFDA9890h: 4C71                     MOVE   B3_DPTCH,B1_SPTCH
FFDA98A0h: 6A3E                     LMO    B1_SPTCH,B14_TEMP
FFDA98B0h: 059E 0130 C000           MOVE   B14_TEMP,@CONVSP,0
FFDA98E0h: 9701                     MOVE   *A8+,A1,1
FFDA98F0h: 9702                     MOVE   *A8+,A2,1
FFDA9900h: 4E20                     MOVE   A1,B0_SADDR
FFDA9910h: 4E47                     MOVE   A2,B7_DVDX
FFDA9920h: 4E82                     MOVE   A4,B2_DADDR
FFDA9930h: 4EB1                     MOVE   B5_WSTART,A1
FFDA9940h: 4ED3                     MOVE   B6_WEND,A3
FFDA9950h: 4C15                     MOVE   B0_SADDR,B5_WSTART
FFDA9960h: 56D6                     CLR    B6_WEND
FFDA9970h: 1436                     DEC    B6_WEND
FFDA9980h: E0B6                     ADDXY  B5_WSTART,B6_WEND
FFDA9990h: E0F6                     ADDXY  B7_DVDX,B6_WEND
FFDA99A0h: 0541                     SETF   1h,0,0
FFDA99B0h: 09E5 00B7 C000           MOVI   CONTROL+7,A5
FFDA99E0h: 81E5                     MOVE   SP,*A5,0
FFDA99F0h: 81E5                     MOVE   SP,*A5,0
FFDA9A00h: 0FE0                     FILL   XY
FFDA9A10h: 1826                     MOVK   1h,A6
FFDA9A20h: 90C5                     MOVE   A6,*A5+,0
FFDA9A30h: CD07                     JRNV   FFDA9AB0h
FFDA9A40h: 81E5                     MOVE   SP,*A5,0
FFDA9A50h: 0550                     SETF   10h,0,0
FFDA9A60h: 4E25                     MOVE   A1,B5_WSTART
FFDA9A70h: 4E66                     MOVE   A3,B6_WEND
FFDA9A80h: 0F60                     PIXBLT XY,XY
FFDA9A90h: C000 FEBF                JR     CMD_LOOP

FFDA9AB0h: 4E25                     MOVE   A1,B5_WSTART
FFDA9AC0h: 4E66                     MOVE   A3,B6_WEND
FFDA9AD0h: 4E82                     MOVE   A4,B2_DADDR
FFDA9AE0h: 4E47                     MOVE   A2,B7_DVDX
FFDA9AF0h: 56C6                     CLR    A6
FFDA9B00h: E450                     CMPXY  B2_DADDR,B0_SADDR
FFDA9B10h: CD02                     JRNV   FFDA9B40h
FFDA9B20h: 1026                     INC    A6
FFDA9B30h: E450                     CMPXY  B2_DADDR,B0_SADDR
FFDA9B40h: C901                     JRNC   FFDA9B60h
FFDA9B50h: 1046                     ADDK   2h,A6
FFDA9B60h: 0542                     SETF   2h,0,0
FFDA9B70h: 80C5                     MOVE   A6,*A5,0
FFDA9B80h: 80C5                     MOVE   A6,*A5,0
FFDA9B90h: 0F60                     PIXBLT XY,XY
FFDA9BA0h: 81E5                     MOVE   SP,*A5,0
FFDA9BB0h: 0550                     SETF   10h,0,0
FFDA9BC0h: C000 FEAC                JR     CMD_LOOP

********************************************************************************
* COMMAND_12_DOT
********************************************************************************
COMMAND_12_DOT:
FFDA9BE0h: 4E82                     MOVE   A4,B2_DADDR
FFDA9BF0h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY
FFDA9C00h: 05A1 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A1,0
FFDA9C30h: CA00 FEA5                JREQ   CMD_LOOP
FFDA9C50h: 183E                     MOVK   1h,B14_TEMP
FFDA9C60h: E1D2                     ADDXY  B14_TEMP,B2_DADDR
FFDA9C70h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY
FFDA9C80h: C000 FEA0                JR     CMD_LOOP

********************************************************************************
* COMMAND_14_ERASE_RECTANGLE
********************************************************************************
COMMAND_14_ERASE_RECTANGLE:
FFDA9CA0h: 05A1 00B0 C000           MOVE   @CONTROL,A1,0
FFDA9CD0h: 4C23                     MOVE   A1,A3
FFDA9CE0h: 0B81 7C20 FFFF           ANDI   83DFh,A1
FFDA9D10h: 0581 00B0 C000           MOVE   A1,@CONTROL,0
FFDA9D40h: 9701                     MOVE   *A8+,A1,1
FFDA9D50h: 4E27                     MOVE   A1,B7_DVDX
FFDA9D60h: 4E82                     MOVE   A4,B2_DADDR
FFDA9D70h: 4F32                     MOVE   B9_COLOR1,A2
FFDA9D80h: 4D19                     MOVE   B8_COLOR0,B9_COLOR1
FFDA9D90h: 0FE0                     FILL   XY
FFDA9DA0h: 4E49                     MOVE   A2,B9_COLOR1
FFDA9DB0h: 0583 00B0 C000           MOVE   A3,@CONTROL,0
FFDA9DE0h: C000 FE8A                JR     CMD_LOOP

********************************************************************************
* COMMAND_16_FILL_CIRCLE
********************************************************************************
COMMAND_16_FILL_CIRCLE:
FFDA9E00h: A31F                     MOVE   B8_COLOR0,-*SP,1
FFDA9E10h: 9503                     MOVE   *A8+,A3,0
FFDA9E20h: 0503                     SEXT   A3,0
FFDA9E30h: 0383                     ABS    A3
FFDA9E40h: CA39                     JREQ   FFDAA1E0h
FFDA9E50h: 09E1 0000 0001           MOVI   00010000h,A1
FFDA9E80h: 0750                     SETF   10h,0,1
FFDA9E90h: 5E61                     MPYU   A3,A1
FFDA9EA0h: 5729                     CLR    A9
FFDA9EB0h: 2E01                     SRL    10h,A1
FFDA9EC0h: 4321                     ADDC   A9,A1
FFDA9ED0h: 1838                     MOVK   1h,B8_COLOR0
FFDA9EE0h: 4D11                     MOVE   B8_COLOR0,B1_SPTCH
FFDA9EF0h: 3211                     RL     10h,B1_SPTCH
FFDA9F00h: 184B                     MOVK   2h,A11
FFDA9F10h: 4C82                     MOVE   A4,A2
FFDA9F20h: E222                     SUBXY  A1,A2
FFDA9F30h: 4E42                     MOVE   A2,B2_DADDR
FFDA9F40h: 4E40                     MOVE   A2,B0_SADDR
FFDA9F50h: 4E27                     MOVE   A1,B7_DVDX
FFDA9F60h: E0F7                     ADDXY  B7_DVDX,B7_DVDX
FFDA9F70h: E117                     ADDXY  B8_COLOR0,B7_DVDX
FFDA9F80h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDA9F90h: 4EFA                     MOVE   B7_DVDX,A10
FFDA9FA0h: 0FE0                     FILL   XY
FFDA9FB0h: 4F47                     MOVE   A10,B7_DVDX
FFDA9FC0h: 4C12                     MOVE   B0_SADDR,B2_DADDR
FFDA9FD0h: E032                     ADDXY  B1_SPTCH,B2_DADDR
FFDA9FE0h: E230                     SUBXY  B1_SPTCH,B0_SADDR
FFDA9FF0h: 5E63                     MPYU   A3,A3
FFDAA000h: 4C65                     MOVE   A3,A5
FFDAA010h: 2425                     SLL    1h,A5
FFDAA020h: 4CA6                     MOVE   A5,A6
FFDAA030h: 2426                     SLL    1h,A6
FFDAA040h: 4CA7                     MOVE   A5,A7
FFDAA050h: 5E27                     MPYU   A1,A7
FFDAA060h: 5E21                     MPYU   A1,A1
FFDAA070h: 0740                     SETF   20h,0,1
FFDAA080h: 4C22                     MOVE   A1,A2
FFDAA090h: 2422                     SLL    1h,A2
FFDAA0A0h: 4C40                     MOVE   A2,A0
FFDAA0B0h: 2420                     SLL    1h,A0
FFDAA0C0h: 2FE1                     SRL    1h,A1
FFDAA0D0h: 2FE3                     SRL    1h,A3
FFDAA0E0h: 44E3                     SUB    A7,A3
FFDAA0F0h: 2427                     SLL    1h,A7
FFDAA100h: 44E1                     SUB    A7,A1
FFDAA110h: 40A1                     ADD    A5,A1
FFDAA120h: 4043                     ADD    A2,A3
FFDAA130h: CE0D                     JRN    FFDAA210h
FFDAA140h: C013                     JR     FFDAA280h

FFDAA150h: 4EFA                     MOVE   B7_DVDX,A10
FFDAA160h: 4E5C                     MOVE   B2_DADDR,A12
FFDAA170h: 0FE0                     FILL   XY
FFDAA180h: 4C12                     MOVE   B0_SADDR,B2_DADDR
FFDAA190h: 4F47                     MOVE   A10,B7_DVDX
FFDAA1A0h: 0FE0                     FILL   XY
FFDAA1B0h: 4F82                     MOVE   A12,B2_DADDR
FFDAA1C0h: E584                     CMPXY  A12,A4
FFDAA1D0h: CF23                     JRNN   FFDAA410h
FFDAA1E0h: 97F8                     MOVE   *SP+,B8_COLOR0,1
FFDAA1F0h: C000 FE49                JR     CMD_LOOP

FFDAA210h: E230                     SUBXY  B1_SPTCH,B0_SADDR
FFDAA220h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDAA230h: 4009                     ADD    A0,A9
FFDAA240h: 4121                     ADD    A9,A1
FFDAA250h: 4123                     ADD    A9,A3
FFDAA260h: 4043                     ADD    A2,A3
FFDAA270h: CEF9                     JRN    FFDAA210h
FFDAA280h: 4EFA                     MOVE   B7_DVDX,A10
FFDAA290h: 4E5C                     MOVE   B2_DADDR,A12
FFDAA2A0h: 0FE0                     FILL   XY
FFDAA2B0h: 4C12                     MOVE   B0_SADDR,B2_DADDR
FFDAA2C0h: 4F47                     MOVE   A10,B7_DVDX
FFDAA2D0h: 0FE0                     FILL   XY
FFDAA2E0h: E230                     SUBXY  B1_SPTCH,B0_SADDR
FFDAA2F0h: E110                     ADDXY  B8_COLOR0,B0_SADDR
FFDAA300h: E14C                     ADDXY  A10,A12
FFDAA310h: 4F82                     MOVE   A12,B2_DADDR
FFDAA320h: EC12                     MOVX   B0_SADDR,B2_DADDR
FFDAA330h: E36A                     SUBXY  A11,A10
FFDAA340h: 4F47                     MOVE   A10,B7_DVDX
FFDAA350h: EE37                     MOVY   B1_SPTCH,B7_DVDX
FFDAA360h: 4009                     ADD    A0,A9
FFDAA370h: 44C7                     SUB    A6,A7
FFDAA380h: 44E1                     SUB    A7,A1
FFDAA390h: 4121                     ADD    A9,A1
FFDAA3A0h: 40A1                     ADD    A5,A1
FFDAA3B0h: C5D9                     JRGE   FFDAA150h
FFDAA3C0h: 44E3                     SUB    A7,A3
FFDAA3D0h: 4123                     ADD    A9,A3
FFDAA3E0h: 4043                     ADD    A2,A3
FFDAA3F0h: C5E8                     JRGE   FFDAA280h
FFDAA400h: C0E0                     JR     FFDAA210h

FFDAA410h: E112                     ADDXY  B8_COLOR0,B2_DADDR
FFDAA420h: E110                     ADDXY  B8_COLOR0,B0_SADDR
FFDAA430h: E36A                     SUBXY  A11,A10
FFDAA440h: 4E5C                     MOVE   B2_DADDR,A12
FFDAA450h: E584                     CMPXY  A12,A4
FFDAA460h: CED7                     JRN    FFDAA1E0h
FFDAA470h: 44C7                     SUB    A6,A7
FFDAA480h: 44E1                     SUB    A7,A1
FFDAA490h: 40A1                     ADD    A5,A1
FFDAA4A0h: C5F6                     JRGE   FFDAA410h
FFDAA4B0h: E112                     ADDXY  B8_COLOR0,B2_DADDR
FFDAA4C0h: E032                     ADDXY  B1_SPTCH,B2_DADDR
FFDAA4D0h: E110                     ADDXY  B8_COLOR0,B0_SADDR
FFDAA4E0h: E230                     SUBXY  B1_SPTCH,B0_SADDR
FFDAA4F0h: E36A                     SUBXY  A11,A10
FFDAA500h: 4E5C                     MOVE   B2_DADDR,A12
FFDAA510h: 4F47                     MOVE   A10,B7_DVDX
FFDAA520h: 0FE0                     FILL   XY
FFDAA530h: 4C12                     MOVE   B0_SADDR,B2_DADDR
FFDAA540h: 4F47                     MOVE   A10,B7_DVDX
FFDAA550h: 0FE0                     FILL   XY
FFDAA560h: 4F82                     MOVE   A12,B2_DADDR
FFDAA570h: 44C7                     SUB    A6,A7
FFDAA580h: 4009                     ADD    A0,A9
FFDAA590h: 44E1                     SUB    A7,A1
FFDAA5A0h: 40A1                     ADD    A5,A1
FFDAA5B0h: 4121                     ADD    A9,A1
FFDAA5C0h: C5E4                     JRGE   FFDAA410h
FFDAA5D0h: C0ED                     JR     FFDAA4B0h

********************************************************************************
* COMMAND_18_FILL_RECTANGLE
********************************************************************************
COMMAND_18_FILL_RECTANGLE:
FFDAA5E0h: 9701                     MOVE   *A8+,A1,1
FFDAA5F0h: 4E27                     MOVE   A1,B7_DVDX
FFDAA600h: 4E82                     MOVE   A4,B2_DADDR
FFDAA610h: 0FE0                     FILL   XY
FFDAA620h: C000 FE06                JR     CMD_LOOP

********************************************************************************
* COMMAND_20_21
********************************************************************************
COMMAND_20_21:
FFDAA640h: 09F1 0001 0001           MOVI   00010001h,B1_SPTCH
FFDAA670h: 4CD0                     MOVE   B6_WEND,B0_SADDR
FFDAA680h: E2B0                     SUBXY  B5_WSTART,B0_SADDR
FFDAA690h: E030                     ADDXY  B1_SPTCH,B0_SADDR
FFDAA6A0h: EC17                     MOVX   B0_SADDR,B7_DVDX
FFDAA6B0h: EE37                     MOVY   B1_SPTCH,B7_DVDX
FFDAA6C0h: 4CB2                     MOVE   B5_WSTART,B2_DADDR
FFDAA6D0h: E852                     CVXYL  B2_DADDR,B2_DADDR
FFDAA6E0h: 0FC0                     FILL   L
FFDAA6F0h: 4CB2                     MOVE   B5_WSTART,B2_DADDR
FFDAA700h: EED2                     MOVY   B6_WEND,B2_DADDR
FFDAA710h: E852                     CVXYL  B2_DADDR,B2_DADDR
FFDAA720h: 0FC0                     FILL   L
FFDAA730h: EC37                     MOVX   B1_SPTCH,B7_DVDX
FFDAA740h: EE17                     MOVY   B0_SADDR,B7_DVDX
FFDAA750h: 5631                     CLR    B1_SPTCH
FFDAA760h: 05A1 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A1,0
FFDAA790h: CA02                     JREQ   FFDAA7C0h
FFDAA7A0h: 1831                     MOVK   1h,B1_SPTCH
FFDAA7B0h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDAA7C0h: 4CB2                     MOVE   B5_WSTART,B2_DADDR
FFDAA7D0h: E852                     CVXYL  B2_DADDR,B2_DADDR
FFDAA7E0h: 0FC0                     FILL   L
FFDAA7F0h: 4CB2                     MOVE   B5_WSTART,B2_DADDR
FFDAA800h: ECD2                     MOVX   B6_WEND,B2_DADDR
FFDAA810h: E232                     SUBXY  B1_SPTCH,B2_DADDR
FFDAA820h: E852                     CVXYL  B2_DADDR,B2_DADDR
FFDAA830h: 0FC0                     FILL   L
FFDAA840h: C000 FDE4                JR     CMD_LOOP

********************************************************************************
* COMMAND_22_23
********************************************************************************
COMMAND_22_23:
FFDAA860h: 9503                     MOVE   *A8+,A3,0
FFDAA870h: 9702                     MOVE   *A8+,A2,1
FFDAA880h: 4E41                     MOVE   A2,B1_SPTCH
FFDAA890h: 9502                     MOVE   *A8+,A2,0
FFDAA8A0h: 4C63                     MOVE   A3,A3
FFDAA8B0h: CA00 FDDD                JREQ   CMD_LOOP
FFDAA8D0h: 4F11                     MOVE   B8_COLOR0,A1
FFDAA8E0h: 4E48                     MOVE   A2,B8_COLOR0
FFDAA8F0h: 09F0 0001 0001           MOVI   00010001h,B0_SADDR
FFDAA920h: 9637                     MOVE   *B1_SPTCH+,B7_DVDX,1
FFDAA930h: 4CF2                     MOVE   B7_DVDX,B2_DADDR
FFDAA940h: 2612                     SLL    10h,B2_DADDR
FFDAA950h: ED12                     MOVX   B8_COLOR0,B2_DADDR
FFDAA960h: ED17                     MOVX   B8_COLOR0,B7_DVDX
FFDAA970h: 4857                     CMP    B2_DADDR,B7_DVDX
FFDAA980h: C503                     JRGE   FFDAA9C0h
FFDAA990h: 4CFA                     MOVE   B7_DVDX,B10_COUNT
FFDAA9A0h: 4C57                     MOVE   B2_DADDR,B7_DVDX
FFDAA9B0h: 4D52                     MOVE   B10_COUNT,B2_DADDR
FFDAA9C0h: E65A                     CPW    B2_DADDR,B10_COUNT
FFDAA9D0h: CC0B                     JRV    FFDAAA90h
FFDAA9E0h: E6FA                     CPW    B7_DVDX,B10_COUNT
FFDAA9F0h: CC0B                     JRV    FFDAAAB0h
FFDAAA00h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDAAA10h: E017                     ADDXY  B0_SADDR,B7_DVDX
FFDAAA20h: E852                     CVXYL  B2_DADDR,B2_DADDR
FFDAAA30h: 0FC0                     FILL   L
FFDAAA40h: 1038                     INC    B8_COLOR0
FFDAAA50h: 3E83                     DSJS   A3,FFDAA920h
FFDAAA60h: 4E28                     MOVE   A1,B8_COLOR0
FFDAAA70h: C000 FDC1                JR     CMD_LOOP

FFDAAA90h: E6FB                     CPW    B7_DVDX,B11_INC1
FFDAAAA0h: CC04                     JRV    FFDAAAF0h
FFDAAAB0h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDAAAC0h: E017                     ADDXY  B0_SADDR,B7_DVDX
FFDAAAD0h: 0FE0                     FILL   XY
FFDAAAE0h: C0F5                     JR     FFDAAA40h

FFDAAAF0h: 515B                     AND    B10_COUNT,B11_INC1
FFDAAB00h: CAFA                     JREQ   FFDAAAB0h
FFDAAB10h: EED2                     MOVY   B6_WEND,B2_DADDR
FFDAAB20h: 1EFB                     BTST   8h,B11_INC1
FFDAAB30h: CB01                     JRNE   FFDAAB50h
FFDAAB40h: EEB2                     MOVY   B5_WSTART,B2_DADDR
FFDAAB50h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY
FFDAAB60h: C0ED                     JR     FFDAAA40h

********************************************************************************
* COMMAND_34_35
********************************************************************************
COMMAND_34_35:
FFDAAB70h: 9507                     MOVE   *A8+,A7,0
FFDAAB80h: 9501                     MOVE   *A8+,A1,0
FFDAAB90h: 9700                     MOVE   *A8+,A0,1
FFDAABA0h: 4CE7                     MOVE   A7,A7
FFDAABB0h: CA00 FDAD                JREQ   CMD_LOOP
FFDAABD0h: 4C2A                     MOVE   A1,A10
FFDAABE0h: 270A                     SLL    18h,A10
FFDAABF0h: 2C8A                     SRL    1Ch,A10
FFDAAC00h: 1FA1                     BTST   2h,A1
FFDAAC10h: CB13                     JRNE   FFDAAD50h
FFDAAC20h: 4C29                     MOVE   A1,A9
FFDAAC30h: 2689                     SLL    14h,A9
FFDAAC40h: 2C89                     SRL    1Ch,A9
FFDAAC50h: 2609                     SLL    10h,A9
FFDAAC60h: EF2A                     MOVY   A9,A10
FFDAAC70h: 27C1                     SLL    1Eh,A1
FFDAAC80h: 2C41                     SRL    1Eh,A1
FFDAAC90h: 0B6A FFFE FFFE           CMPI   10001h,A10
FFDAACC0h: CA02                     JREQ   FFDAACF0h
FFDAACD0h: 1081                     ADDK   4h,A1
FFDAACE0h: 4F3B                     MOVE   B9_COLOR1,A11
FFDAACF0h: 24A1                     SLL    5h,A1
FFDAAD00h: 0B21 ADD0 FFDA           ADDI   FFDAADD0h,A1
FFDAAD30h: 8621                     MOVE   *A1,A1,1
FFDAAD40h: 0161                     JUMP   A1

FFDAAD50h: 4F3B                     MOVE   B9_COLOR1,A11
FFDAAD60h: 27C1                     SLL    1Eh,A1
FFDAAD70h: 2CE1                     SRL    19h,A1
FFDAAD80h: 0B21 AED0 FFDA           ADDI   FFDAAED0h,A1
FFDAADB0h: 8621                     MOVE   *A1,A1,1
FFDAADC0h: 0161                     JUMP   A1

FFDAADD0h: AF50 FFDA                .long    FFDAAF50h

FFDAADF0h: AFC0 FFDA                .long    FFDAAFC0h

FFDAAE10h: B020 FFDA                .long    FFDAB020h

FFDAAE30h: B090 FFDA                .long    FFDAB090h

FFDAAE50h: B0F0 FFDA                .long    FFDAB0F0h

FFDAAE70h: B240 FFDA                .long    FFDAB240h

FFDAAE90h: B370 FFDA                .long    FFDAB370h

FFDAAEB0h: B500 FFDA                .long    FFDAB500h

FFDAAED0h: B690 FFDA                .long    FFDAB690h

FFDAAEF0h: B810 FFDA                .long    FFDAB810h

FFDAAF10h: B970 FFDA                .long    FFDAB970h

FFDAAF30h: BB20 FFDA                .long    FFDABB20h

FFDAAF50h: 2E09                     SRL    10h,A9
FFDAAF60h: 9401                     MOVE   *A0+,A1,0
FFDAAF70h: F024                     PIXT   A1,*A4,XY
FFDAAF80h: E124                     ADDXY  A9,A4
FFDAAF90h: 3C87                     DSJS   A7,FFDAAF60h
FFDAAFA0h: C000 FD6E                JR     CMD_LOOP

FFDAAFC0h: 9401                     MOVE   *A0+,A1,0
FFDAAFD0h: F024                     PIXT   A1,*A4,XY
FFDAAFE0h: E124                     ADDXY  A9,A4
FFDAAFF0h: 3C87                     DSJS   A7,FFDAAFC0h
FFDAB000h: C000 FD68                JR     CMD_LOOP

FFDAB020h: 2E09                     SRL    10h,A9
FFDAB030h: 9401                     MOVE   *A0+,A1,0
FFDAB040h: F024                     PIXT   A1,*A4,XY
FFDAB050h: E324                     SUBXY  A9,A4
FFDAB060h: 3C87                     DSJS   A7,FFDAB030h
FFDAB070h: C000 FD61                JR     CMD_LOOP

FFDAB090h: 9401                     MOVE   *A0+,A1,0
FFDAB0A0h: F024                     PIXT   A1,*A4,XY
FFDAB0B0h: E324                     SUBXY  A9,A4
FFDAB0C0h: 3C87                     DSJS   A7,FFDAB090h
FFDAB0D0h: C000 FD5B                JR     CMD_LOOP

FFDAB0F0h: 2E09                     SRL    10h,A9
FFDAB100h: 320A                     RL     10h,A10
FFDAB110h: 9401                     MOVE   *A0+,A1,0
FFDAB120h: 4E29                     MOVE   A1,B9_COLOR1
FFDAB130h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB140h: 249E                     SLL    4h,B14_TEMP
FFDAB150h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB160h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB170h: 251E                     SLL    8h,B14_TEMP
FFDAB180h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB190h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB1A0h: 261E                     SLL    10h,B14_TEMP
FFDAB1B0h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB1C0h: 4F47                     MOVE   A10,B7_DVDX
FFDAB1D0h: 4E82                     MOVE   A4,B2_DADDR
FFDAB1E0h: 0FE0                     FILL   XY
FFDAB1F0h: E124                     ADDXY  A9,A4
FFDAB200h: 3E07                     DSJS   A7,FFDAB110h
FFDAB210h: 4F69                     MOVE   A11,B9_COLOR1
FFDAB220h: C000 FD46                JR     CMD_LOOP

FFDAB240h: 9401                     MOVE   *A0+,A1,0
FFDAB250h: 4E29                     MOVE   A1,B9_COLOR1
FFDAB260h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB270h: 249E                     SLL    4h,B14_TEMP
FFDAB280h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB290h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB2A0h: 251E                     SLL    8h,B14_TEMP
FFDAB2B0h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB2C0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB2D0h: 261E                     SLL    10h,B14_TEMP
FFDAB2E0h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB2F0h: 4F47                     MOVE   A10,B7_DVDX
FFDAB300h: 4E82                     MOVE   A4,B2_DADDR
FFDAB310h: 0FE0                     FILL   XY
FFDAB320h: E124                     ADDXY  A9,A4
FFDAB330h: 3E07                     DSJS   A7,FFDAB240h
FFDAB340h: 4F69                     MOVE   A11,B9_COLOR1
FFDAB350h: C000 FD33                JR     CMD_LOOP

FFDAB370h: 1821                     MOVK   1h,A1
FFDAB380h: E024                     ADDXY  A1,A4
FFDAB390h: 2E09                     SRL    10h,A9
FFDAB3A0h: 320A                     RL     10h,A10
FFDAB3B0h: 9401                     MOVE   *A0+,A1,0
FFDAB3C0h: 4E29                     MOVE   A1,B9_COLOR1
FFDAB3D0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB3E0h: 249E                     SLL    4h,B14_TEMP
FFDAB3F0h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB400h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB410h: 251E                     SLL    8h,B14_TEMP
FFDAB420h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB430h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB440h: 261E                     SLL    10h,B14_TEMP
FFDAB450h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB460h: 4F47                     MOVE   A10,B7_DVDX
FFDAB470h: E324                     SUBXY  A9,A4
FFDAB480h: 4E82                     MOVE   A4,B2_DADDR
FFDAB490h: 0FE0                     FILL   XY
FFDAB4A0h: 3E07                     DSJS   A7,FFDAB3B0h
FFDAB4B0h: 1829                     MOVK   1h,A9
FFDAB4C0h: E324                     SUBXY  A9,A4
FFDAB4D0h: 4F69                     MOVE   A11,B9_COLOR1
FFDAB4E0h: C000 FD1A                JR     CMD_LOOP

FFDAB500h: 1821                     MOVK   1h,A1
FFDAB510h: 2601                     SLL    10h,A1
FFDAB520h: E024                     ADDXY  A1,A4
FFDAB530h: 9401                     MOVE   *A0+,A1,0
FFDAB540h: 4E29                     MOVE   A1,B9_COLOR1
FFDAB550h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB560h: 249E                     SLL    4h,B14_TEMP
FFDAB570h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB580h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB590h: 251E                     SLL    8h,B14_TEMP
FFDAB5A0h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB5B0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB5C0h: 261E                     SLL    10h,B14_TEMP
FFDAB5D0h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB5E0h: 4F47                     MOVE   A10,B7_DVDX
FFDAB5F0h: E324                     SUBXY  A9,A4
FFDAB600h: 4E82                     MOVE   A4,B2_DADDR
FFDAB610h: 0FE0                     FILL   XY
FFDAB620h: 3E07                     DSJS   A7,FFDAB530h
FFDAB630h: 1829                     MOVK   1h,A9
FFDAB640h: 2609                     SLL    10h,A9
FFDAB650h: E324                     SUBXY  A9,A4
FFDAB660h: 4F69                     MOVE   A11,B9_COLOR1
FFDAB670h: C000 FD01                JR     CMD_LOOP

FFDAB690h: 5729                     CLR    A9
FFDAB6A0h: 320A                     RL     10h,A10
FFDAB6B0h: 9601                     MOVE   *A0+,A1,1
FFDAB6C0h: 4E29                     MOVE   A1,B9_COLOR1
FFDAB6D0h: 2E19                     SRL    10h,B9_COLOR1
FFDAB6E0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB6F0h: 249E                     SLL    4h,B14_TEMP
FFDAB700h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB710h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB720h: 251E                     SLL    8h,B14_TEMP
FFDAB730h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB740h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB750h: 261E                     SLL    10h,B14_TEMP
FFDAB760h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB770h: EC29                     MOVX   A1,A9
FFDAB780h: EC2A                     MOVX   A1,A10
FFDAB790h: 4F47                     MOVE   A10,B7_DVDX
FFDAB7A0h: 4E82                     MOVE   A4,B2_DADDR
FFDAB7B0h: 0FE0                     FILL   XY
FFDAB7C0h: E124                     ADDXY  A9,A4
FFDAB7D0h: 3E67                     DSJS   A7,FFDAB6B0h
FFDAB7E0h: 4F69                     MOVE   A11,B9_COLOR1
FFDAB7F0h: C000 FCE9                JR     CMD_LOOP

FFDAB810h: 9609                     MOVE   *A0+,A9,1
FFDAB820h: 4F29                     MOVE   A9,B9_COLOR1
FFDAB830h: 2E19                     SRL    10h,B9_COLOR1
FFDAB840h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB850h: 249E                     SLL    4h,B14_TEMP
FFDAB860h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB870h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB880h: 251E                     SLL    8h,B14_TEMP
FFDAB890h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB8A0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB8B0h: 261E                     SLL    10h,B14_TEMP
FFDAB8C0h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAB8D0h: 2609                     SLL    10h,A9
FFDAB8E0h: EF2A                     MOVY   A9,A10
FFDAB8F0h: 4F47                     MOVE   A10,B7_DVDX
FFDAB900h: 4E82                     MOVE   A4,B2_DADDR
FFDAB910h: 0FE0                     FILL   XY
FFDAB920h: E124                     ADDXY  A9,A4
FFDAB930h: 3E67                     DSJS   A7,FFDAB810h
FFDAB940h: 4F69                     MOVE   A11,B9_COLOR1
FFDAB950h: C000 FCD3                JR     CMD_LOOP

FFDAB970h: 1829                     MOVK   1h,A9
FFDAB980h: E124                     ADDXY  A9,A4
FFDAB990h: 320A                     RL     10h,A10
FFDAB9A0h: 9601                     MOVE   *A0+,A1,1
FFDAB9B0h: 4E29                     MOVE   A1,B9_COLOR1
FFDAB9C0h: 2E19                     SRL    10h,B9_COLOR1
FFDAB9D0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAB9E0h: 249E                     SLL    4h,B14_TEMP
FFDAB9F0h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDABA00h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDABA10h: 251E                     SLL    8h,B14_TEMP
FFDABA20h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDABA30h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDABA40h: 261E                     SLL    10h,B14_TEMP
FFDABA50h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDABA60h: EC29                     MOVX   A1,A9
FFDABA70h: EC2A                     MOVX   A1,A10
FFDABA80h: 4F47                     MOVE   A10,B7_DVDX
FFDABA90h: E324                     SUBXY  A9,A4
FFDABAA0h: 4E82                     MOVE   A4,B2_DADDR
FFDABAB0h: 0FE0                     FILL   XY
FFDABAC0h: 3E67                     DSJS   A7,FFDAB9A0h
FFDABAD0h: 1829                     MOVK   1h,A9
FFDABAE0h: E324                     SUBXY  A9,A4
FFDABAF0h: 4F69                     MOVE   A11,B9_COLOR1
FFDABB00h: C000 FCB8                JR     CMD_LOOP

FFDABB20h: 1829                     MOVK   1h,A9
FFDABB30h: 2609                     SLL    10h,A9
FFDABB40h: E124                     ADDXY  A9,A4
FFDABB50h: 9609                     MOVE   *A0+,A9,1
FFDABB60h: 4F29                     MOVE   A9,B9_COLOR1
FFDABB70h: 2E19                     SRL    10h,B9_COLOR1
FFDABB80h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDABB90h: 249E                     SLL    4h,B14_TEMP
FFDABBA0h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDABBB0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDABBC0h: 251E                     SLL    8h,B14_TEMP
FFDABBD0h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDABBE0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDABBF0h: 261E                     SLL    10h,B14_TEMP
FFDABC00h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDABC10h: 2609                     SLL    10h,A9
FFDABC20h: EF2A                     MOVY   A9,A10
FFDABC30h: 4F47                     MOVE   A10,B7_DVDX
FFDABC40h: E324                     SUBXY  A9,A4
FFDABC50h: 4E82                     MOVE   A4,B2_DADDR
FFDABC60h: 0FE0                     FILL   XY
FFDABC70h: 3E67                     DSJS   A7,FFDABB50h
FFDABC80h: 1829                     MOVK   1h,A9
FFDABC90h: 2609                     SLL    10h,A9
FFDABCA0h: E324                     SUBXY  A9,A4
FFDABCB0h: 4F69                     MOVE   A11,B9_COLOR1
FFDABCC0h: C000 FC9C                JR     CMD_LOOP

********************************************************************************
* COMMAND_30_31
********************************************************************************
COMMAND_30_31:
FFDABCE0h: 9507                     MOVE   *A8+,A7,0
FFDABCF0h: 950A                     MOVE   *A8+,A10,0
FFDABD00h: 9700                     MOVE   *A8+,A0,1
FFDABD10h: 9504                     MOVE   *A8+,A4,0
FFDABD20h: 4CE7                     MOVE   A7,A7
FFDABD30h: CA00 FC95                JREQ   CMD_LOOP
FFDABD50h: 2604                     SLL    10h,A4
FFDABD60h: 5621                     CLR    A1
FFDABD70h: 09C2 FFFF                MOVI   FFFFh,A2
FFDABD90h: 4C4C                     MOVE   A2,A12
FFDABDA0h: 2E8C                     SRL    Ch,A12
FFDABDB0h: 182E                     MOVK   1h,A14
FFDABDC0h: 25EE                     SLL    Fh,A14
FFDABDD0h: 0770                     SETF   10h,1,1
FFDABDE0h: 960B                     MOVE   *A0+,A11,1
FFDABDF0h: 9406                     MOVE   *A0+,A6,0
FFDABE00h: 5186                     AND    A12,A6
FFDABE10h: ED64                     MOVX   A11,A4
FFDABE20h: F0C4                     PIXT   A6,*A4,XY
FFDABE30h: 1427                     DEC    A7
FFDABE40h: CB26                     JRNE   FFDAC0B0h
FFDABE50h: C036                     JR     FFDAC1C0h

FFDABE60h: 4569                     SUB    A11,A9
FFDABE70h: CA1F                     JREQ   FFDAC070h
FFDABE80h: C702                     JRGT   FFDABEB0h
FFDABE90h: 4C4A                     MOVE   A2,A10
FFDABEA0h: 03A9                     NEG    A9
FFDABEB0h: 0B49 FFFD                CMPI   2h,A9
FFDABED0h: C417                     JRLT   FFDAC050h
FFDABEE0h: CA11                     JREQ   FFDAC000h
FFDABEF0h: 4CA3                     MOVE   A5,A3
FFDABF00h: 2603                     SLL    10h,A3
FFDABF10h: 2606                     SLL    10h,A6
FFDABF20h: 44C3                     SUB    A6,A3
FFDABF30h: 4626                     SUBB   A1,A6
FFDABF40h: 41C6                     ADD    A14,A6
FFDABF50h: 5923                     DIVS   A9,A3
FFDABF60h: E144                     ADDXY  A10,A4
FFDABF70h: 4066                     ADD    A3,A6
FFDABF80h: 3206                     RL     10h,A6
FFDABF90h: F0C4                     PIXT   A6,*A4,XY
FFDABFA0h: 3206                     RL     10h,A6
FFDABFB0h: 3CC9                     DSJS   A9,FFDABF60h
FFDABFC0h: 4E1B                     MOVE   B0_SADDR,A11
FFDABFD0h: 4CA6                     MOVE   A5,A6
FFDABFE0h: 3987                     DSJS   A7,FFDAC0B0h
FFDABFF0h: C01C                     JR     FFDAC1C0h

FFDAC000h: 40A6                     ADD    A5,A6
FFDAC010h: 1026                     INC    A6
FFDAC020h: 2FE6                     SRL    1h,A6
FFDAC030h: E144                     ADDXY  A10,A4
FFDAC040h: F0C4                     PIXT   A6,*A4,XY
FFDAC050h: E144                     ADDXY  A10,A4
FFDAC060h: 4E1B                     MOVE   B0_SADDR,A11
FFDAC070h: F0A4                     PIXT   A5,*A4,XY
FFDAC080h: 4CA6                     MOVE   A5,A6
FFDAC090h: 3827                     DSJS   A7,FFDAC0B0h
FFDAC0A0h: C011                     JR     FFDAC1C0h

FFDAC0B0h: 9609                     MOVE   *A0+,A9,1
FFDAC0C0h: 4F20                     MOVE   A9,B0_SADDR
FFDAC0D0h: 9405                     MOVE   *A0+,A5,0
FFDAC0E0h: 182A                     MOVK   1h,A10
FFDAC0F0h: 5185                     AND    A12,A5
FFDAC100h: 48C5                     CMP    A6,A5
FFDAC110h: CBD4                     JRNE   FFDABE60h
FFDAC120h: 4569                     SUB    A11,A9
FFDAC130h: CA07                     JREQ   FFDAC1B0h
FFDAC140h: C702                     JRGT   FFDAC170h
FFDAC150h: 4C4A                     MOVE   A2,A10
FFDAC160h: 03A9                     NEG    A9
FFDAC170h: E144                     ADDXY  A10,A4
FFDAC180h: F0A4                     PIXT   A5,*A4,XY
FFDAC190h: 3C69                     DSJS   A9,FFDAC170h
FFDAC1A0h: 4E1B                     MOVE   B0_SADDR,A11
FFDAC1B0h: 3E27                     DSJS   A7,FFDAC0B0h
FFDAC1C0h: 0740                     SETF   20h,0,1
FFDAC1D0h: C000 FC4B                JR     CMD_LOOP

********************************************************************************
* COMMAND_36_LINE_ABSOLUTE
********************************************************************************
COMMAND_36_LINE_ABSOLUTE:
FFDAC1F0h: 9705                     MOVE   *A8+,A5,1
FFDAC200h: 05A1 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A1,0
FFDAC230h: E485                     CMPXY  A4,A5
FFDAC240h: CA29                     JREQ   FFDAC4E0h
FFDAC250h: CE2C                     JRN    FFDAC520h
FFDAC260h: 4EA2                     MOVE   A5,B2_DADDR
FFDAC270h: 4E80                     MOVE   A4,B0_SADDR
FFDAC280h: E250                     SUBXY  B2_DADDR,B0_SADDR
FFDAC290h: 477B                     SUBB   B11_INC1,B11_INC1
FFDAC2A0h: 183A                     MOVK   1h,B10_COUNT
FFDAC2B0h: 56F7                     CLR    B7_DVDX
FFDAC2C0h: E217                     SUBXY  B0_SADDR,B7_DVDX
FFDAC2D0h: C903                     JRNC   FFDAC310h
FFDAC2E0h: EE17                     MOVY   B0_SADDR,B7_DVDX
FFDAC2F0h: 03FB                     NOT    B11_INC1
FFDAC300h: 2E3B                     SRL    Fh,B11_INC1
FFDAC310h: CD02                     JRNV   FFDAC340h
FFDAC320h: EC17                     MOVX   B0_SADDR,B7_DVDX
FFDAC330h: ED5B                     MOVX   B10_COUNT,B11_INC1
FFDAC340h: 579C                     CLR    B12_INC2
FFDAC350h: 4CF0                     MOVE   B7_DVDX,B0_SADDR
FFDAC360h: 2E10                     SRL    10h,B0_SADDR
FFDAC370h: E417                     CMPXY  B0_SADDR,B7_DVDX
FFDAC380h: CC02                     JRV    FFDAC3B0h
FFDAC390h: ED7C                     MOVX   B11_INC1,B12_INC2
FFDAC3A0h: C003                     JR     FFDAC3E0h

FFDAC3B0h: ECF0                     MOVX   B7_DVDX,B0_SADDR
FFDAC3C0h: 3217                     RL     10h,B7_DVDX
FFDAC3D0h: EF7C                     MOVY   B11_INC1,B12_INC2
FFDAC3E0h: 4010                     ADD    B0_SADDR,B0_SADDR
FFDAC3F0h: ECFA                     MOVX   B7_DVDX,B10_COUNT
FFDAC400h: 4550                     SUB    B10_COUNT,B0_SADDR
FFDAC410h: 103A                     INC    B10_COUNT
FFDAC420h: 1FE1                     BTST   0h,A1
FFDAC430h: CA08                     JREQ   FFDAC4C0h
FFDAC440h: 4C11                     MOVE   B0_SADDR,B1_SPTCH
FFDAC450h: 4F54                     MOVE   B10_COUNT,A4
FFDAC460h: DF1A                     LINE   0
FFDAC470h: 4EA2                     MOVE   A5,B2_DADDR
FFDAC480h: 4C30                     MOVE   B1_SPTCH,B0_SADDR
FFDAC490h: 4E8A                     MOVE   A4,B10_COUNT
FFDAC4A0h: 183E                     MOVK   1h,B14_TEMP
FFDAC4B0h: E1D2                     ADDXY  B14_TEMP,B2_DADDR
FFDAC4C0h: DF1A                     LINE   0
FFDAC4D0h: C010                     JR     FFDAC5E0h

FFDAC4E0h: CC04                     JRV    FFDAC530h
FFDAC4F0h: 4E82                     MOVE   A4,B2_DADDR
FFDAC500h: 4EA7                     MOVE   A5,B7_DVDX
FFDAC510h: C003                     JR     FFDAC550h

FFDAC520h: C9FC                     JRNC   FFDAC4F0h
FFDAC530h: 4EA2                     MOVE   A5,B2_DADDR
FFDAC540h: 4E87                     MOVE   A4,B7_DVDX
FFDAC550h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDAC560h: 09FE 0001 0001           MOVI   00010001h,B14_TEMP
FFDAC590h: 1FE1                     BTST   0h,A1
FFDAC5A0h: CA01                     JREQ   FFDAC5C0h
FFDAC5B0h: 103E                     INC    B14_TEMP
FFDAC5C0h: E1D7                     ADDXY  B14_TEMP,B7_DVDX
FFDAC5D0h: 0FE0                     FILL   XY
FFDAC5E0h: 4CA4                     MOVE   A5,A4
FFDAC5F0h: C000 FC09                JR     CMD_LOOP

********************************************************************************
* COMMAND_38_LINE_RELATIVE
********************************************************************************
COMMAND_38_LINE_RELATIVE:
FFDAC610h: 9705                     MOVE   *A8+,A5,1
FFDAC620h: E085                     ADDXY  A4,A5
FFDAC630h: 05A1 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A1,0
FFDAC660h: E485                     CMPXY  A4,A5
FFDAC670h: CA29                     JREQ   FFDAC910h
FFDAC680h: CE2C                     JRN    FFDAC950h
FFDAC690h: 4EA2                     MOVE   A5,B2_DADDR
FFDAC6A0h: 4E80                     MOVE   A4,B0_SADDR
FFDAC6B0h: E250                     SUBXY  B2_DADDR,B0_SADDR
FFDAC6C0h: 477B                     SUBB   B11_INC1,B11_INC1
FFDAC6D0h: 183A                     MOVK   1h,B10_COUNT
FFDAC6E0h: 56F7                     CLR    B7_DVDX
FFDAC6F0h: E217                     SUBXY  B0_SADDR,B7_DVDX
FFDAC700h: C903                     JRNC   FFDAC740h
FFDAC710h: EE17                     MOVY   B0_SADDR,B7_DVDX
FFDAC720h: 03FB                     NOT    B11_INC1
FFDAC730h: 2E3B                     SRL    Fh,B11_INC1
FFDAC740h: CD02                     JRNV   FFDAC770h
FFDAC750h: EC17                     MOVX   B0_SADDR,B7_DVDX
FFDAC760h: ED5B                     MOVX   B10_COUNT,B11_INC1
FFDAC770h: 579C                     CLR    B12_INC2
FFDAC780h: 4CF0                     MOVE   B7_DVDX,B0_SADDR
FFDAC790h: 2E10                     SRL    10h,B0_SADDR
FFDAC7A0h: E417                     CMPXY  B0_SADDR,B7_DVDX
FFDAC7B0h: CC02                     JRV    FFDAC7E0h
FFDAC7C0h: ED7C                     MOVX   B11_INC1,B12_INC2
FFDAC7D0h: C003                     JR     FFDAC810h

FFDAC7E0h: ECF0                     MOVX   B7_DVDX,B0_SADDR
FFDAC7F0h: 3217                     RL     10h,B7_DVDX
FFDAC800h: EF7C                     MOVY   B11_INC1,B12_INC2
FFDAC810h: 4010                     ADD    B0_SADDR,B0_SADDR
FFDAC820h: ECFA                     MOVX   B7_DVDX,B10_COUNT
FFDAC830h: 4550                     SUB    B10_COUNT,B0_SADDR
FFDAC840h: 103A                     INC    B10_COUNT
FFDAC850h: 1FE1                     BTST   0h,A1
FFDAC860h: CA08                     JREQ   FFDAC8F0h
FFDAC870h: 4C11                     MOVE   B0_SADDR,B1_SPTCH
FFDAC880h: 4F54                     MOVE   B10_COUNT,A4
FFDAC890h: DF1A                     LINE   0
FFDAC8A0h: 4EA2                     MOVE   A5,B2_DADDR
FFDAC8B0h: 4C30                     MOVE   B1_SPTCH,B0_SADDR
FFDAC8C0h: 4E8A                     MOVE   A4,B10_COUNT
FFDAC8D0h: 183E                     MOVK   1h,B14_TEMP
FFDAC8E0h: E1D2                     ADDXY  B14_TEMP,B2_DADDR
FFDAC8F0h: DF1A                     LINE   0
FFDAC900h: C010                     JR     FFDACA10h

FFDAC910h: CC04                     JRV    FFDAC960h
FFDAC920h: 4E82                     MOVE   A4,B2_DADDR
FFDAC930h: 4EA7                     MOVE   A5,B7_DVDX
FFDAC940h: C003                     JR     FFDAC980h

FFDAC950h: C9FC                     JRNC   FFDAC920h
FFDAC960h: 4EA2                     MOVE   A5,B2_DADDR
FFDAC970h: 4E87                     MOVE   A4,B7_DVDX
FFDAC980h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDAC990h: 09FE 0001 0001           MOVI   00010001h,B14_TEMP
FFDAC9C0h: 1FE1                     BTST   0h,A1
FFDAC9D0h: CA01                     JREQ   FFDAC9F0h
FFDAC9E0h: 103E                     INC    B14_TEMP
FFDAC9F0h: E1D7                     ADDXY  B14_TEMP,B7_DVDX
FFDACA00h: 0FE0                     FILL   XY
FFDACA10h: 4CA4                     MOVE   A5,A4
FFDACA20h: C000 FBC6                JR     CMD_LOOP

********************************************************************************
* COMMAND_40_PIXEL_MAP
********************************************************************************
COMMAND_40_PIXEL_MAP:
FFDACA40h: 9701                     MOVE   *A8+,A1,1
FFDACA50h: 4E20                     MOVE   A1,B0_SADDR
FFDACA60h: 9411                     MOVE   *B0_SADDR+,B1_SPTCH,0
FFDACA70h: 6A3E                     LMO    B1_SPTCH,B14_TEMP
FFDACA80h: 059E 0130 C000           MOVE   B14_TEMP,@CONVSP,0
FFDACAB0h: 4E82                     MOVE   A4,B2_DADDR
FFDACAC0h: 9617                     MOVE   *B0_SADDR+,B7_DVDX,1
FFDACAD0h: 0F20                     PIXBLT L,XY
FFDACAE0h: C000 FBBA                JR     CMD_LOOP

********************************************************************************
* COMMAND_42_POLYLINE_ABSOLUTE
********************************************************************************
COMMAND_42_POLYLINE_ABSOLUTE:
FFDACB00h: 05A1 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A1,0
FFDACB30h: 9502                     MOVE   *A8+,A2,0
FFDACB40h: 9503                     MOVE   *A8+,A3,0
FFDACB50h: 24A3                     SLL    5h,A3
FFDACB60h: 4103                     ADD    A8,A3
FFDACB70h: 9705                     MOVE   *A8+,A5,1
FFDACB80h: E485                     CMPXY  A4,A5
FFDACB90h: CA29                     JREQ   FFDACE30h
FFDACBA0h: CE2C                     JRN    FFDACE70h
FFDACBB0h: 4EA2                     MOVE   A5,B2_DADDR
FFDACBC0h: 4E80                     MOVE   A4,B0_SADDR
FFDACBD0h: E250                     SUBXY  B2_DADDR,B0_SADDR
FFDACBE0h: 477B                     SUBB   B11_INC1,B11_INC1
FFDACBF0h: 183A                     MOVK   1h,B10_COUNT
FFDACC00h: 56F7                     CLR    B7_DVDX
FFDACC10h: E217                     SUBXY  B0_SADDR,B7_DVDX
FFDACC20h: C903                     JRNC   FFDACC60h
FFDACC30h: EE17                     MOVY   B0_SADDR,B7_DVDX
FFDACC40h: 03FB                     NOT    B11_INC1
FFDACC50h: 2E3B                     SRL    Fh,B11_INC1
FFDACC60h: CD02                     JRNV   FFDACC90h
FFDACC70h: EC17                     MOVX   B0_SADDR,B7_DVDX
FFDACC80h: ED5B                     MOVX   B10_COUNT,B11_INC1
FFDACC90h: 579C                     CLR    B12_INC2
FFDACCA0h: 4CF0                     MOVE   B7_DVDX,B0_SADDR
FFDACCB0h: 2E10                     SRL    10h,B0_SADDR
FFDACCC0h: E417                     CMPXY  B0_SADDR,B7_DVDX
FFDACCD0h: CC02                     JRV    FFDACD00h
FFDACCE0h: ED7C                     MOVX   B11_INC1,B12_INC2
FFDACCF0h: C003                     JR     FFDACD30h

FFDACD00h: ECF0                     MOVX   B7_DVDX,B0_SADDR
FFDACD10h: 3217                     RL     10h,B7_DVDX
FFDACD20h: EF7C                     MOVY   B11_INC1,B12_INC2
FFDACD30h: 4010                     ADD    B0_SADDR,B0_SADDR
FFDACD40h: ECFA                     MOVX   B7_DVDX,B10_COUNT
FFDACD50h: 4550                     SUB    B10_COUNT,B0_SADDR
FFDACD60h: 103A                     INC    B10_COUNT
FFDACD70h: 1FE1                     BTST   0h,A1
FFDACD80h: CA08                     JREQ   FFDACE10h
FFDACD90h: 4C11                     MOVE   B0_SADDR,B1_SPTCH
FFDACDA0h: 4F54                     MOVE   B10_COUNT,A4
FFDACDB0h: DF1A                     LINE   0
FFDACDC0h: 4EA2                     MOVE   A5,B2_DADDR
FFDACDD0h: 4C30                     MOVE   B1_SPTCH,B0_SADDR
FFDACDE0h: 4E8A                     MOVE   A4,B10_COUNT
FFDACDF0h: 183E                     MOVK   1h,B14_TEMP
FFDACE00h: E1D2                     ADDXY  B14_TEMP,B2_DADDR
FFDACE10h: DF1A                     LINE   0
FFDACE20h: C010                     JR     FFDACF30h

FFDACE30h: CC04                     JRV    FFDACE80h
FFDACE40h: 4E82                     MOVE   A4,B2_DADDR
FFDACE50h: 4EA7                     MOVE   A5,B7_DVDX
FFDACE60h: C003                     JR     FFDACEA0h

FFDACE70h: C9FC                     JRNC   FFDACE40h
FFDACE80h: 4EA2                     MOVE   A5,B2_DADDR
FFDACE90h: 4E87                     MOVE   A4,B7_DVDX
FFDACEA0h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDACEB0h: 09FE 0001 0001           MOVI   00010001h,B14_TEMP
FFDACEE0h: 1FE1                     BTST   0h,A1
FFDACEF0h: CA01                     JREQ   FFDACF10h
FFDACF00h: 103E                     INC    B14_TEMP
FFDACF10h: E1D7                     ADDXY  B14_TEMP,B7_DVDX
FFDACF20h: 0FE0                     FILL   XY
FFDACF30h: 4CA4                     MOVE   A5,A4
FFDACF40h: 0D82 FFC1                DSJ    A2,FFDACB70h
FFDACF60h: 4C68                     MOVE   A3,A8
FFDACF70h: C000 FB71                JR     CMD_LOOP

********************************************************************************
* COMMAND_44_POLYLINE_RELATIVE
********************************************************************************
COMMAND_44_POLYLINE_RELATIVE:
FFDACF90h: 05A1 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A1,0
FFDACFC0h: 9502                     MOVE   *A8+,A2,0
FFDACFD0h: 9503                     MOVE   *A8+,A3,0
FFDACFE0h: 24A3                     SLL    5h,A3
FFDACFF0h: 4103                     ADD    A8,A3
FFDAD000h: 9705                     MOVE   *A8+,A5,1
FFDAD010h: E085                     ADDXY  A4,A5
FFDAD020h: E485                     CMPXY  A4,A5
FFDAD030h: CA29                     JREQ   FFDAD2D0h
FFDAD040h: CE2C                     JRN    FFDAD310h
FFDAD050h: 4EA2                     MOVE   A5,B2_DADDR
FFDAD060h: 4E80                     MOVE   A4,B0_SADDR
FFDAD070h: E250                     SUBXY  B2_DADDR,B0_SADDR
FFDAD080h: 477B                     SUBB   B11_INC1,B11_INC1
FFDAD090h: 183A                     MOVK   1h,B10_COUNT
FFDAD0A0h: 56F7                     CLR    B7_DVDX
FFDAD0B0h: E217                     SUBXY  B0_SADDR,B7_DVDX
FFDAD0C0h: C903                     JRNC   FFDAD100h
FFDAD0D0h: EE17                     MOVY   B0_SADDR,B7_DVDX
FFDAD0E0h: 03FB                     NOT    B11_INC1
FFDAD0F0h: 2E3B                     SRL    Fh,B11_INC1
FFDAD100h: CD02                     JRNV   FFDAD130h
FFDAD110h: EC17                     MOVX   B0_SADDR,B7_DVDX
FFDAD120h: ED5B                     MOVX   B10_COUNT,B11_INC1
FFDAD130h: 579C                     CLR    B12_INC2
FFDAD140h: 4CF0                     MOVE   B7_DVDX,B0_SADDR
FFDAD150h: 2E10                     SRL    10h,B0_SADDR
FFDAD160h: E417                     CMPXY  B0_SADDR,B7_DVDX
FFDAD170h: CC02                     JRV    FFDAD1A0h
FFDAD180h: ED7C                     MOVX   B11_INC1,B12_INC2
FFDAD190h: C003                     JR     FFDAD1D0h

FFDAD1A0h: ECF0                     MOVX   B7_DVDX,B0_SADDR
FFDAD1B0h: 3217                     RL     10h,B7_DVDX
FFDAD1C0h: EF7C                     MOVY   B11_INC1,B12_INC2
FFDAD1D0h: 4010                     ADD    B0_SADDR,B0_SADDR
FFDAD1E0h: ECFA                     MOVX   B7_DVDX,B10_COUNT
FFDAD1F0h: 4550                     SUB    B10_COUNT,B0_SADDR
FFDAD200h: 103A                     INC    B10_COUNT
FFDAD210h: 1FE1                     BTST   0h,A1
FFDAD220h: CA08                     JREQ   FFDAD2B0h
FFDAD230h: 4C11                     MOVE   B0_SADDR,B1_SPTCH
FFDAD240h: 4F54                     MOVE   B10_COUNT,A4
FFDAD250h: DF1A                     LINE   0
FFDAD260h: 4EA2                     MOVE   A5,B2_DADDR
FFDAD270h: 4C30                     MOVE   B1_SPTCH,B0_SADDR
FFDAD280h: 4E8A                     MOVE   A4,B10_COUNT
FFDAD290h: 183E                     MOVK   1h,B14_TEMP
FFDAD2A0h: E1D2                     ADDXY  B14_TEMP,B2_DADDR
FFDAD2B0h: DF1A                     LINE   0
FFDAD2C0h: C010                     JR     FFDAD3D0h

FFDAD2D0h: CC04                     JRV    FFDAD320h
FFDAD2E0h: 4E82                     MOVE   A4,B2_DADDR
FFDAD2F0h: 4EA7                     MOVE   A5,B7_DVDX
FFDAD300h: C003                     JR     FFDAD340h

FFDAD310h: C9FC                     JRNC   FFDAD2E0h
FFDAD320h: 4EA2                     MOVE   A5,B2_DADDR
FFDAD330h: 4E87                     MOVE   A4,B7_DVDX
FFDAD340h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDAD350h: 09FE 0001 0001           MOVI   00010001h,B14_TEMP
FFDAD380h: 1FE1                     BTST   0h,A1
FFDAD390h: CA01                     JREQ   FFDAD3B0h
FFDAD3A0h: 103E                     INC    B14_TEMP
FFDAD3B0h: E1D7                     ADDXY  B14_TEMP,B7_DVDX
FFDAD3C0h: 0FE0                     FILL   XY
FFDAD3D0h: 4CA4                     MOVE   A5,A4
FFDAD3E0h: 0D82 FFC0                DSJ    A2,FFDAD000h
FFDAD400h: 4C68                     MOVE   A3,A8
FFDAD410h: C000 FB27                JR     CMD_LOOP

********************************************************************************
* COMMAND_46_TEXT
********************************************************************************
COMMAND_46_TEXT:
FFDAD430h: 9503                     MOVE   *A8+,A3,0
FFDAD440h: CA7C                     JREQ   FFDADC10h
FFDAD450h: 9501                     MOVE   *A8+,A1,0
FFDAD460h: 2481                     SLL    4h,A1
FFDAD470h: 4101                     ADD    A8,A1
FFDAD480h: A3AF                     MOVE   A13,-*SP,1
FFDAD490h: A22F                     MOVE   A1,-*SP,1
FFDAD4A0h: 09E1 0CD0 FFEC           MOVI   CURRENT_FONT,A1
FFDAD4D0h: 962C                     MOVE   *A1+,A12,1
FFDAD4E0h: 962A                     MOVE   *A1+,A10,1
FFDAD4F0h: 5600                     CLR    A0
FFDAD500h: ED40                     MOVX   A10,A0
FFDAD510h: 9429                     MOVE   *A1+,A9,0
FFDAD520h: 9422                     MOVE   *A1+,A2,0
FFDAD530h: 4E41                     MOVE   A2,B1_SPTCH
FFDAD540h: 6A3C                     LMO    B1_SPTCH,B12_INC2
FFDAD550h: 059C 0130 C000           MOVE   B12_INC2,@CONVSP,0
FFDAD580h: 9422                     MOVE   *A1+,A2,0
FFDAD590h: CA07                     JREQ   FFDAD610h
FFDAD5A0h: 2420                     SLL    1h,A0
FFDAD5B0h: 09EE 0150 C000           MOVI   PSIZE,A14
FFDAD5E0h: 85C6                     MOVE   *A14,A6,0
FFDAD5F0h: 4CC7                     MOVE   A6,A7
FFDAD600h: 2427                     SLL    1h,A7
FFDAD610h: 8421                     MOVE   *A1,A1,0
FFDAD620h: 1421                     DEC    A1
FFDAD630h: 2601                     SLL    10h,A1
FFDAD640h: A22F                     MOVE   A1,-*SP,1
FFDAD650h: E224                     SUBXY  A1,A4
FFDAD660h: 4C85                     MOVE   A4,A5
FFDAD670h: 194D                     MOVK   Ah,A13
FFDAD680h: 4C42                     MOVE   A2,A2
FFDAD690h: CB12                     JRNE   FFDAD7C0h
FFDAD6A0h: 5621                     CLR    A1
FFDAD6B0h: EF41                     MOVY   A10,A1
FFDAD6C0h: 950B                     MOVE   *A8+,A11,0
FFDAD6D0h: 496D                     CMP    A11,A13
FFDAD6E0h: CA09                     JREQ   FFDAD780h
FFDAD6F0h: 4E82                     MOVE   A4,B2_DADDR
FFDAD700h: 4F47                     MOVE   A10,B7_DVDX
FFDAD710h: 632B                     SLL    A9,A11
FFDAD720h: 418B                     ADD    A12,A11
FFDAD730h: 4F60                     MOVE   A11,B0_SADDR
FFDAD740h: 0FA0                     PIXBLT B,XY
FFDAD750h: E004                     ADDXY  A0,A4
FFDAD760h: 3D63                     DSJS   A3,FFDAD6C0h
FFDAD770h: C043                     JR     FFDADBB0h

FFDAD780h: E225                     SUBXY  A1,A5
FFDAD790h: 4CA4                     MOVE   A5,A4
FFDAD7A0h: 3DE3                     DSJS   A3,FFDAD6C0h
FFDAD7B0h: C03F                     JR     FFDADBB0h

FFDAD7C0h: 0541                     SETF   1h,0,0
FFDAD7D0h: 058F 00B7 C000           MOVE   SP,@CONTROL+7,0
FFDAD800h: 0550                     SETF   10h,0,0
FFDAD810h: 5642                     CLR    A2
FFDAD820h: 950B                     MOVE   *A8+,A11,0
FFDAD830h: 496D                     CMP    A11,A13
FFDAD840h: CA17                     JREQ   FFDAD9C0h
FFDAD850h: 4E82                     MOVE   A4,B2_DADDR
FFDAD860h: 4F47                     MOVE   A10,B7_DVDX
FFDAD870h: 632B                     SLL    A9,A11
FFDAD880h: 418B                     ADD    A12,A11
FFDAD890h: E65E                     CPW    B2_DADDR,B14_TEMP
FFDAD8A0h: CC18                     JRV    FFDADA30h
FFDAD8B0h: E0F2                     ADDXY  B7_DVDX,B2_DADDR
FFDAD8C0h: E65E                     CPW    B2_DADDR,B14_TEMP
FFDAD8D0h: CC23                     JRV    FFDADB10h
FFDAD8E0h: E2F2                     SUBXY  B7_DVDX,B2_DADDR
FFDAD8F0h: E852                     CVXYL  B2_DADDR,B2_DADDR
FFDAD900h: 80EE                     MOVE   A7,*A14,0
FFDAD910h: 4F60                     MOVE   A11,B0_SADDR
FFDAD920h: 950B                     MOVE   *A8+,A11,0
FFDAD930h: 0F80                     PIXBLT B,L
FFDAD940h: E004                     ADDXY  A0,A4
FFDAD950h: 80CE                     MOVE   A6,*A14,0
FFDAD960h: 3E83                     DSJS   A3,FFDAD830h
FFDAD970h: C01C                     JR     FFDADB40h

FFDAD980h: E004                     ADDXY  A0,A4
FFDAD990h: 950B                     MOVE   *A8+,A11,0
FFDAD9A0h: 3F03                     DSJS   A3,FFDAD830h
FFDAD9B0h: C018                     JR     FFDADB40h

FFDAD9C0h: 5621                     CLR    A1
FFDAD9D0h: EF41                     MOVY   A10,A1
FFDAD9E0h: E225                     SUBXY  A1,A5
FFDAD9F0h: 4CA4                     MOVE   A5,A4
FFDADA00h: 950B                     MOVE   *A8+,A11,0
FFDADA10h: 3FE3                     DSJS   A3,FFDAD830h
FFDADA20h: C011                     JR     FFDADB40h

FFDADA30h: 0FE0                     FILL   XY
FFDADA40h: CCF3                     JRV    FFDAD980h
FFDADA50h: 4E51                     MOVE   B2_DADDR,A1
FFDADA60h: E281                     SUBXY  A4,A1
FFDADA70h: EC22                     MOVX   A1,A2
FFDADA80h: 404B                     ADD    A2,A11
FFDADA90h: 2E01                     SRL    10h,A1
FFDADAA0h: 4E32                     MOVE   B1_SPTCH,A2
FFDADAB0h: 6A42                     LMO    A2,A2
FFDADAC0h: 03A2                     NEG    A2
FFDADAD0h: 13E2                     ADDK   1Fh,A2
FFDADAE0h: 6241                     SLL    A2,A1
FFDADAF0h: 402B                     ADD    A1,A11
FFDADB00h: C0DE                     JR     FFDAD8F0h

FFDADB10h: E2F2                     SUBXY  B7_DVDX,B2_DADDR
FFDADB20h: 0FE0                     FILL   XY
FFDADB30h: C0DB                     JR     FFDAD8F0h

FFDADB40h: 1821                     MOVK   1h,A1
FFDADB50h: 0541                     SETF   1h,0,0
FFDADB60h: 0581 00B7 C000           MOVE   A1,@CONTROL+7,0
FFDADB90h: 0550                     SETF   10h,0,0
FFDADBA0h: 0300                     NOP
FFDADBB0h: 97E1                     MOVE   *SP+,A1,1
FFDADBC0h: E024                     ADDXY  A1,A4
FFDADBD0h: 97E8                     MOVE   *SP+,A8,1
FFDADBE0h: 97ED                     MOVE   *SP+,A13,1
FFDADBF0h: C000 FAA9                JR     CMD_LOOP

FFDADC10h: 9501                     MOVE   *A8+,A1,0
FFDADC20h: 2481                     SLL    4h,A1
FFDADC30h: 4028                     ADD    A1,A8
FFDADC40h: C000 FAA4                JR     CMD_LOOP

********************************************************************************
* COMMAND_48_TEXT_UNDERLINE
********************************************************************************
COMMAND_48_TEXT_UNDERLINE:
FFDADC60h: C000 FAA2                JR     CMD_LOOP

********************************************************************************
* COMMAND_50_CALL
********************************************************************************
COMMAND_50_CALL:
FFDADC80h: 9701                     MOVE   *A8+,A1,1
FFDADC90h: 930D                     MOVE   A8,*A13+,1
FFDADCA0h: 4C28                     MOVE   A1,A8
FFDADCB0h: C000 FA9D                JR     CMD_LOOP

********************************************************************************
* COMMAND_52_CALL_NOT_USER_FLAG
********************************************************************************
COMMAND_52_CALL_NOT_USER_FLAG:
FFDADCD0h: 9501                     MOVE   *A8+,A1,0
FFDADCE0h: 2481                     SLL    4h,A1
FFDADCF0h: 0B21 0000 FFDA           ADDI   USERFLAGS,A1
FFDADD20h: 8421                     MOVE   *A1,A1,0
FFDADD30h: CB05                     JRNE   FFDADD90h
FFDADD40h: 9701                     MOVE   *A8+,A1,1
FFDADD50h: 930D                     MOVE   A8,*A13+,1
FFDADD60h: 4C28                     MOVE   A1,A8
FFDADD70h: C000 FA91                JR     CMD_LOOP

FFDADD90h: 1008                     ADDK   20h,A8
FFDADDA0h: C000 FA8E                JR     CMD_LOOP

********************************************************************************
* COMMAND_54_CALL_ON_USER_FLAG
********************************************************************************
COMMAND_54_CALL_ON_USER_FLAG:
FFDADDC0h: 9501                     MOVE   *A8+,A1,0
FFDADDD0h: 2481                     SLL    4h,A1
FFDADDE0h: 0B21 0000 FFDA           ADDI   USERFLAGS,A1
FFDADE10h: 8421                     MOVE   *A1,A1,0
FFDADE20h: CA05                     JREQ   FFDADE80h
FFDADE30h: 9701                     MOVE   *A8+,A1,1
FFDADE40h: 930D                     MOVE   A8,*A13+,1
FFDADE50h: 4C28                     MOVE   A1,A8
FFDADE60h: C000 FA82                JR     CMD_LOOP

FFDADE80h: 1008                     ADDK   20h,A8
FFDADE90h: C000 FA7F                JR     CMD_LOOP

********************************************************************************
* COMMAND_56_JUMP
********************************************************************************
COMMAND_56_JUMP:
FFDADEB0h: 8708                     MOVE   *A8,A8,1
FFDADEC0h: C000 FA7C                JR     CMD_LOOP

********************************************************************************
* COMMAND_58_JUMP_NOT_USER_FLAG
********************************************************************************
COMMAND_58_JUMP_NOT_USER_FLAG:
FFDADEE0h: 9501                     MOVE   *A8+,A1,0
FFDADEF0h: 2481                     SLL    4h,A1
FFDADF00h: 0B21 0000 FFDA           ADDI   USERFLAGS,A1
FFDADF30h: 8421                     MOVE   *A1,A1,0
FFDADF40h: CB03                     JRNE   FFDADF80h
FFDADF50h: 8708                     MOVE   *A8,A8,1
FFDADF60h: C000 FA72                JR     CMD_LOOP

FFDADF80h: 1008                     ADDK   20h,A8
FFDADF90h: C000 FA6F                JR     CMD_LOOP

********************************************************************************
* COMMAND_60_JUMP_ON_USER_FLAG
********************************************************************************
COMMAND_60_JUMP_ON_USER_FLAG:
FFDADFB0h: 9501                     MOVE   *A8+,A1,0
FFDADFC0h: 2481                     SLL    4h,A1
FFDADFD0h: 0B21 0000 FFDA           ADDI   USERFLAGS,A1
FFDAE000h: 8421                     MOVE   *A1,A1,0
FFDAE010h: CA03                     JREQ   FFDAE050h
FFDAE020h: 8708                     MOVE   *A8,A8,1
FFDAE030h: C000 FA65                JR     CMD_LOOP

FFDAE050h: 1008                     ADDK   20h,A8
FFDAE060h: C000 FA62                JR     CMD_LOOP

********************************************************************************
* COMMAND_62_RETURN
********************************************************************************
COMMAND_62_RETURN:
FFDAE080h: A7A8                     MOVE   -*A13,A8,1
FFDAE090h: C000 FA5F                JR     CMD_LOOP

********************************************************************************
* COMMAND_64_SKIP1
********************************************************************************
COMMAND_64_SKIP1:
FFDAE0B0h: 1208                     ADDK   10h,A8
FFDAE0C0h: C000 FA5C                JR     CMD_LOOP

********************************************************************************
* COMMAND_66_SKIP2
********************************************************************************
COMMAND_66_SKIP2:
FFDAE0E0h: 1008                     ADDK   20h,A8
FFDAE0F0h: C000 FA59                JR     CMD_LOOP

********************************************************************************
* COMMAND_68_SKIP3
********************************************************************************
COMMAND_68_SKIP3:
FFDAE110h: 0B08 0030                ADDI   30h,A8
FFDAE130h: C000 FA55                JR     CMD_LOOP

********************************************************************************
* COMMAND_70_SKIP4
********************************************************************************
COMMAND_70_SKIP4:
FFDAE150h: 0B08 0040                ADDI   40h,A8
FFDAE170h: C000 FA51                JR     CMD_LOOP

********************************************************************************
* COMMAND_72_USER_FLAG_CLEAR
********************************************************************************
COMMAND_72_USER_FLAG_CLEAR:
FFDAE190h: 9501                     MOVE   *A8+,A1,0
FFDAE1A0h: 2481                     SLL    4h,A1
FFDAE1B0h: 0B21 0000 FFDA           ADDI   USERFLAGS,A1
FFDAE1E0h: 5642                     CLR    A2
FFDAE1F0h: 8041                     MOVE   A2,*A1,0
FFDAE200h: C000 FA48                JR     CMD_LOOP

********************************************************************************
* COMMAND_74_USER_FLAG_SET
********************************************************************************
COMMAND_74_USER_FLAG_SET:
FFDAE220h: 9501                     MOVE   *A8+,A1,0
FFDAE230h: 2481                     SLL    4h,A1
FFDAE240h: 0B21 0000 FFDA           ADDI   USERFLAGS,A1
FFDAE270h: 1822                     MOVK   1h,A2
FFDAE280h: 8041                     MOVE   A2,*A1,0
FFDAE290h: C000 FA3F                JR     CMD_LOOP

********************************************************************************
* COMMAND_76_USER_FLAG_TOGGLE 
********************************************************************************
COMMAND_76_USER_FLAG_TOGGLE :
FFDAE2B0h: 9501                     MOVE   *A8+,A1,0
FFDAE2C0h: 2481                     SLL    4h,A1
FFDAE2D0h: 0B21 0000 FFDA           ADDI   USERFLAGS,A1
FFDAE300h: 8422                     MOVE   *A1,A2,0
FFDAE310h: 1823                     MOVK   1h,A3
FFDAE320h: 5662                     XOR    A3,A2
FFDAE330h: 8041                     MOVE   A2,*A1,0
FFDAE340h: C000 FA34                JR     CMD_LOOP

********************************************************************************
* COMMAND_78_DYNAMIC_FRAME
********************************************************************************
COMMAND_78_DYNAMIC_FRAME:
FFDAE360h: 05A1 0840 FFEC           MOVE   @FFEC0840h,A1,0
FFDAE390h: CBFC                     JRNE   COMMAND_78_DYNAMIC_FRAME
FFDAE3A0h: 09F4 0000 001E           MOVI   SCREENBASE_0x001E_0000,B4_OFFSET
FFDAE3D0h: 05A1 0090 C000           MOVE   @DPYSTRT,A1,0
FFDAE400h: 0B41 E20F                CMPI   1DF0h,A1
FFDAE420h: CA03                     JREQ   FFDAE460h
FFDAE430h: 09F4 0000 0000           MOVI   SCREENBASE_0x0000_0000,B4_OFFSET
FFDAE460h: 07BE 09C0 FFEC           MOVE   @FFEC09C0h,B14_TEMP,1
FFDAE490h: 41D4                     ADD    B14_TEMP,B4_OFFSET
FFDAE4A0h: C000 FA1E                JR     CMD_LOOP

********************************************************************************
* COMMAND_80_STATIC_FRAME
********************************************************************************
COMMAND_80_STATIC_FRAME:
FFDAE4C0h: 5621                     CLR    A1
FFDAE4D0h: 0581 0840 FFEC           MOVE   A1,@FFEC0840h,0
FFDAE500h: 07BE 09C0 FFEC           MOVE   @FFEC09C0h,B14_TEMP,1
FFDAE530h: 09F4 0000 003C           MOVI   SCREENBASE_0x003C_0000,B4_OFFSET
FFDAE560h: 41D4                     ADD    B14_TEMP,B4_OFFSET
FFDAE570h: C000 FA11                JR     CMD_LOOP

********************************************************************************
* COMMAND_82_STATIC_FRAME_AND_ERASE
********************************************************************************
COMMAND_82_STATIC_FRAME_AND_ERASE:
FFDAE590h: 1841                     MOVK   2h,A1
FFDAE5A0h: 0581 0840 FFEC           MOVE   A1,@FFEC0840h,0
FFDAE5D0h: 07BE 09C0 FFEC           MOVE   @FFEC09C0h,B14_TEMP,1
FFDAE600h: 09F4 0000 003C           MOVI   SCREENBASE_0x003C_0000,B4_OFFSET
FFDAE630h: 05A1 0840 FFEC           MOVE   @FFEC0840h,A1,0
FFDAE660h: CBFC                     JRNE   FFDAE630h
FFDAE670h: 41D4                     ADD    B14_TEMP,B4_OFFSET
FFDAE680h: C000 FA00                JR     CMD_LOOP

********************************************************************************
* COMMAND_84_GATED_CALL
********************************************************************************
COMMAND_84_GATED_CALL:
FFDAE6A0h: 1608                     SUBK   10h,A8
FFDAE6B0h: 0541                     SETF   1h,0,0
FFDAE6C0h: 8501                     MOVE   *A8,A1,0
FFDAE6D0h: CB09                     JRNE   FFDAE770h
FFDAE6E0h: 1821                     MOVK   1h,A1
FFDAE6F0h: 8028                     MOVE   A1,*A8,0
FFDAE700h: 0550                     SETF   10h,0,0
FFDAE710h: 1208                     ADDK   10h,A8
FFDAE720h: 9701                     MOVE   *A8+,A1,1
FFDAE730h: 930D                     MOVE   A8,*A13+,1
FFDAE740h: 4C28                     MOVE   A1,A8
FFDAE750h: C000 F9F3                JR     CMD_LOOP

FFDAE770h: 0550                     SETF   10h,0,0
FFDAE780h: 0B08 0040                ADDI   40h,A8
FFDAE7A0h: C000 F9EE                JR     CMD_LOOP

********************************************************************************
* COMMAND_86_INTERRUPT_HOST
********************************************************************************
COMMAND_86_INTERRUPT_HOST:
FFDAE7C0h: 1608                     SUBK   10h,A8
FFDAE7D0h: 0788 08C0 FFEC           MOVE   A8,@INTERRUPT_HOST_CURRENT_PC,1
FFDAE800h: 1208                     ADDK   10h,A8
FFDAE810h: 0544                     SETF   4h,0,0
FFDAE820h: 1921                     MOVK   9h,A1
FFDAE830h: 0581 00F4 C000           MOVE   A1,@HSTCTLL+4,0
FFDAE860h: 0550                     SETF   10h,0,0
FFDAE870h: C000 F9E1                JR     CMD_LOOP

********************************************************************************
* COMMAND_IGNORE
********************************************************************************
COMMAND_IGNORE:
FFDAE890h: C000 F9DF                JR     CMD_LOOP

********************************************************************************
* COMMAND_90_91
********************************************************************************
COMMAND_90_91:
FFDAE8B0h: 0541                     SETF   1h,0,0
FFDAE8C0h: 1821                     MOVK   1h,A1
FFDAE8D0h: B028 FFF0                MOVE   A1,*A8(FFF0h),0
FFDAE8F0h: 0550                     SETF   10h,0,0
FFDAE900h: C000 F9D8                JR     CMD_LOOP

********************************************************************************
* COMMAND_92_SEGMENT_END
********************************************************************************
COMMAND_92_SEGMENT_END:
FFDAE920h: 07A1 08A0 FFEC           MOVE   @FFEC08A0h,A1,1
FFDAE950h: 0541                     SETF   1h,0,0
FFDAE960h: 5642                     CLR    A2
FFDAE970h: 8041                     MOVE   A2,*A1,0
FFDAE980h: 0550                     SETF   10h,0,0
FFDAE990h: 07A2 0860 FFEC           MOVE   @FFEC0860h,A2,1
FFDAE9C0h: 4822                     CMP    A1,A2
FFDAE9D0h: CB00 F9CB                JRNE   CMD_LOOP
FFDAE9F0h: 0541                     SETF   1h,0,0
FFDAEA00h: 1822                     MOVK   1h,A2
FFDAEA10h: 8041                     MOVE   A2,*A1,0
FFDAEA20h: 0550                     SETF   10h,0,0
FFDAEA30h: 5642                     CLR    A2
FFDAEA40h: 0782 0860 FFEC           MOVE   A2,@FFEC0860h,1
FFDAEA70h: C000 F9C1                JR     CMD_LOOP

********************************************************************************
* COMMAND_94_SEGMENT_END_AND_RETURN
********************************************************************************
COMMAND_94_SEGMENT_END_AND_RETURN:
FFDAEA90h: A7A8                     MOVE   -*A13,A8,1
FFDAEAA0h: C0E7                     JR     COMMAND_92_SEGMENT_END

********************************************************************************
* COMMAND_96_SEGMENT_END_AND_JUMP
********************************************************************************
COMMAND_96_SEGMENT_END_AND_JUMP:
FFDAEAB0h: 8708                     MOVE   *A8,A8,1
FFDAEAC0h: C0E5                     JR     COMMAND_92_SEGMENT_END

********************************************************************************
* COMMAND_98_SEGMENT_START
********************************************************************************
COMMAND_98_SEGMENT_START:
FFDAEAD0h: 1608                     SUBK   10h,A8
FFDAEAE0h: 0360                     DINT
FFDAEAF0h: 8501                     MOVE   *A8,A1,0
FFDAEB00h: 1FE1                     BTST   0h,A1
FFDAEB10h: CB05                     JRNE   FFDAEB70h
FFDAEB20h: 0788 08A0 FFEC           MOVE   A8,@FFEC08A0h,1
FFDAEB50h: 1021                     INC    A1
FFDAEB60h: 8028                     MOVE   A1,*A8,0
FFDAEB70h: 0D60                     EINT
FFDAEB80h: 1208                     ADDK   10h,A8
FFDAEB90h: C000 F9AF                JR     CMD_LOOP

********************************************************************************
* COMMAND_100_STALL
********************************************************************************
COMMAND_100_STALL:
FFDAEBB0h: 1608                     SUBK   10h,A8
FFDAEBC0h: C000 F9AC                JR     CMD_LOOP

********************************************************************************
* COMMAND_102_SYNC_COPY_STATIC
********************************************************************************
COMMAND_102_SYNC_COPY_STATIC:
FFDAEBE0h: 09F4 0000 001E           MOVI   SCREENBASE_0x001E_0000,B4_OFFSET
FFDAEC10h: 05A1 0090 C000           MOVE   @DPYSTRT,A1,0
FFDAEC40h: 0B41 E20F                CMPI   1DF0h,A1
FFDAEC60h: CA03                     JREQ   FFDAECA0h
FFDAEC70h: 09F4 0000 0000           MOVI   SCREENBASE_0x0000_0000,B4_OFFSET
FFDAECA0h: 07BE 09C0 FFEC           MOVE   @FFEC09C0h,B14_TEMP,1
FFDAECD0h: 41D4                     ADD    B14_TEMP,B4_OFFSET
FFDAECE0h: 1821                     MOVK   1h,A1
FFDAECF0h: 0581 0840 FFEC           MOVE   A1,@FFEC0840h,0
FFDAED20h: C000 F996                JR     CMD_LOOP

********************************************************************************
* COMMAND_104_SYNC_DISPLAY_DYNAMIC
********************************************************************************
COMMAND_104_SYNC_DISPLAY_DYNAMIC:
FFDAED40h: 05A1 0090 C000           MOVE   @DPYSTRT,A1,0
FFDAED70h: 09C2 1DF0                MOVI   1DF0h,A2
FFDAED90h: 09F4 0000 001E           MOVI   SCREENBASE_0x001E_0000,B4_OFFSET
FFDAEDC0h: 4841                     CMP    A2,A1
FFDAEDD0h: CB05                     JRNE   FFDAEE30h
FFDAEDE0h: 09C2 3BF0                MOVI   3BF0h,A2
FFDAEE00h: 09F4 0000 0000           MOVI   SCREENBASE_0x0000_0000,B4_OFFSET
FFDAEE30h: 0582 0090 C000           MOVE   A2,@DPYSTRT,0
FFDAEE60h: 07BE 09C0 FFEC           MOVE   @FFEC09C0h,B14_TEMP,1
FFDAEE90h: 41D4                     ADD    B14_TEMP,B4_OFFSET
FFDAEEA0h: 1821                     MOVK   1h,A1
FFDAEEB0h: 0581 0840 FFEC           MOVE   A1,@FFEC0840h,0
FFDAEEE0h: C000 F97A                JR     CMD_LOOP

********************************************************************************
* COMMAND_106_BENCHMARK_START_0x6a
********************************************************************************
COMMAND_106_BENCHMARK_START_0x6a:
FFDAEF00h: 09E5 0AC0 FFEC           MOVI   FFEC0AC0h,A5
FFDAEF30h: 0541                     SETF   1h,0,0
FFDAEF40h: 058F 011A C000           MOVE   SP,@INTENB+10,0
FFDAEF70h: 0550                     SETF   10h,0,0
FFDAEF80h: 07A1 0A80 FFEC           MOVE   @FFEC0A80h,A1,1
FFDAEFB0h: 05A2 01D0 C000           MOVE   @VCOUNT,A2,0
FFDAEFE0h: 195E                     MOVK   Ah,B14_TEMP
FFDAEFF0h: 4C43                     MOVE   A2,A3
FFDAF000h: 05A2 01D0 C000           MOVE   @VCOUNT,A2,0
FFDAF030h: 4843                     CMP    A2,A3
FFDAF040h: CA01                     JREQ   FFDAF060h
FFDAF050h: 3CFE                     DSJS   B14_TEMP,FFDAEFF0h
FFDAF060h: 09C3 0201                MOVI   201h,A3
FFDAF080h: 4462                     SUB    A3,A2
FFDAF090h: C405                     JRLT   FFDAF0F0h
FFDAF0A0h: 07A3 0AA0 FFEC           MOVE   @FFEC0AA0h,A3,1
FFDAF0D0h: 4823                     CMP    A1,A3
FFDAF0E0h: CB02                     JRNE   FFDAF110h
FFDAF0F0h: 0B01 020D                ADDI   20Dh,A1
FFDAF110h: 4041                     ADD    A2,A1
FFDAF120h: 8225                     MOVE   A1,*A5,1
FFDAF130h: 0541                     SETF   1h,0,0
FFDAF140h: 183A                     MOVK   1h,B10_COUNT
FFDAF150h: 059A 011A C000           MOVE   B10_COUNT,@INTENB+10,0
FFDAF180h: 0550                     SETF   10h,0,0
FFDAF190h: C000 F94F                JR     CMD_LOOP

********************************************************************************
* COMMAND_108_BENCHMARK_START_0x6c
********************************************************************************
COMMAND_108_BENCHMARK_START_0x6c:
FFDAF1B0h: 09E5 0AE0 FFEC           MOVI   FFEC0AE0h,A5
FFDAF1E0h: C0D4                     JR     FFDAEF30h

********************************************************************************
* COMMAND_110_CLIP_OFF
********************************************************************************
COMMAND_110_CLIP_OFF:
FFDAF1F0h: 09F5 0000 0000           MOVI   SCREENBASE_0x0000_0000,B5_WSTART
FFDAF220h: 09F6 027F 01DF           MOVI   01DF027Fh,B6_WEND
FFDAF250h: C000 F943                JR     CMD_LOOP

********************************************************************************
* COMMAND_112_CLIP_ON
********************************************************************************
COMMAND_112_CLIP_ON:
FFDAF270h: 07B5 0A40 FFEC           MOVE   @CLIP_MIN_XY,B5_WSTART,1
FFDAF2A0h: 07B6 0A60 FFEC           MOVE   @CLIP_MAX_XY,B6_WEND,1
FFDAF2D0h: C000 F93B                JR     CMD_LOOP

********************************************************************************
* COMMAND_114_CLIP_RECTANGLE
********************************************************************************
COMMAND_114_CLIP_RECTANGLE:
FFDAF2F0h: 9701                     MOVE   *A8+,A1,1
FFDAF300h: 0781 0A00 FFEC           MOVE   A1,@FFEC0A00h,1
FFDAF330h: 4E22                     MOVE   A1,B2_DADDR
FFDAF340h: 9701                     MOVE   *A8+,A1,1
FFDAF350h: 0781 0A20 FFEC           MOVE   A1,@FFEC0A20h,1
FFDAF380h: 4E27                     MOVE   A1,B7_DVDX
FFDAF390h: 09F5 0000 0000           MOVI   SCREENBASE_0x0000_0000,B5_WSTART
FFDAF3C0h: 09F6 027F 01DF           MOVI   01DF027Fh,B6_WEND
FFDAF3F0h: 09F0 0001 0001           MOVI   00010001h,B0_SADDR
FFDAF420h: 0541                     SETF   1h,0,0
FFDAF430h: 0588 00B7 C000           MOVE   A8,@CONTROL+7,0
FFDAF460h: 07B1 09E0 FFEC           MOVE   @FFEC09E0h,B1_SPTCH,1
FFDAF490h: E032                     ADDXY  B1_SPTCH,B2_DADDR
FFDAF4A0h: 0FE0                     FILL   XY
FFDAF4B0h: 0590 00B7 C000           MOVE   B0_SADDR,@CONTROL+7,0
FFDAF4E0h: 0550                     SETF   10h,0,0
FFDAF4F0h: CD02                     JRNV   FFDAF520h
FFDAF500h: 4CB6                     MOVE   B5_WSTART,B6_WEND
FFDAF510h: C004                     JR     FFDAF560h

FFDAF520h: 4C55                     MOVE   B2_DADDR,B5_WSTART
FFDAF530h: E235                     SUBXY  B1_SPTCH,B5_WSTART
FFDAF540h: 4CF6                     MOVE   B7_DVDX,B6_WEND
FFDAF550h: E0B6                     ADDXY  B5_WSTART,B6_WEND
FFDAF560h: E216                     SUBXY  B0_SADDR,B6_WEND
FFDAF570h: 0795 0A40 FFEC           MOVE   B5_WSTART,@CLIP_MIN_XY,1
FFDAF5A0h: 0796 0A60 FFEC           MOVE   B6_WEND,@CLIP_MAX_XY,1
FFDAF5D0h: C000 F90B                JR     CMD_LOOP

********************************************************************************
* COMMAND_116_MOVE_ABSOLUTE_0x74
********************************************************************************
COMMAND_116_MOVE_ABSOLUTE_0x74:
FFDAF5F0h: 9704                     MOVE   *A8+,A4,1
FFDAF600h: C000 F908                JR     CMD_LOOP

********************************************************************************
* COMMAND_118_MOVE_ABSOLUTE_0x76
********************************************************************************
COMMAND_118_MOVE_ABSOLUTE_0x76:
FFDAF620h: 9701                     MOVE   *A8+,A1,1
FFDAF630h: E024                     ADDXY  A1,A4
FFDAF640h: C000 F904                JR     CMD_LOOP

********************************************************************************
* COMMAND_120_ORIGIN
********************************************************************************
COMMAND_120_ORIGIN:
FFDAF660h: 07BE 09C0 FFEC           MOVE   @FFEC09C0h,B14_TEMP,1
FFDAF690h: 45D4                     SUB    B14_TEMP,B4_OFFSET
FFDAF6A0h: 9701                     MOVE   *A8+,A1,1
FFDAF6B0h: 0781 09E0 FFEC           MOVE   A1,@FFEC09E0h,1
FFDAF6E0h: E821                     CVXYL  A1,A1
FFDAF6F0h: 4E2E                     MOVE   A1,B14_TEMP
FFDAF700h: 449E                     SUB    B4_OFFSET,B14_TEMP
FFDAF710h: 079E 09C0 FFEC           MOVE   B14_TEMP,@FFEC09C0h,1
FFDAF740h: 4E24                     MOVE   A1,B4_OFFSET
FFDAF750h: 07B2 0A00 FFEC           MOVE   @FFEC0A00h,B2_DADDR,1
FFDAF780h: 07B7 0A20 FFEC           MOVE   @FFEC0A20h,B7_DVDX,1
FFDAF7B0h: C0BD                     JR     FFDAF390h

********************************************************************************
* COMMAND_122_PIXEL_OPERATION
********************************************************************************
COMMAND_122_PIXEL_OPERATION:
FFDAF7C0h: 9501                     MOVE   *A8+,A1,0
FFDAF7D0h: 4E28                     MOVE   A1,B8_COLOR0
FFDAF7E0h: 4D1E                     MOVE   B8_COLOR0,B14_TEMP
FFDAF7F0h: 249E                     SLL    4h,B14_TEMP
FFDAF800h: 55D8                     OR     B14_TEMP,B8_COLOR0
FFDAF810h: 4D1E                     MOVE   B8_COLOR0,B14_TEMP
FFDAF820h: 251E                     SLL    8h,B14_TEMP
FFDAF830h: 55D8                     OR     B14_TEMP,B8_COLOR0
FFDAF840h: 4D1E                     MOVE   B8_COLOR0,B14_TEMP
FFDAF850h: 261E                     SLL    10h,B14_TEMP
FFDAF860h: 55D8                     OR     B14_TEMP,B8_COLOR0
FFDAF870h: C000 F8E1                JR     CMD_LOOP

********************************************************************************
* COMMAND_124_PEN_FOREGROUND
********************************************************************************
COMMAND_124_PEN_FOREGROUND:
FFDAF890h: 9501                     MOVE   *A8+,A1,0
FFDAF8A0h: 4E29                     MOVE   A1,B9_COLOR1
FFDAF8B0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAF8C0h: 249E                     SLL    4h,B14_TEMP
FFDAF8D0h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAF8E0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAF8F0h: 251E                     SLL    8h,B14_TEMP
FFDAF900h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAF910h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP
FFDAF920h: 261E                     SLL    10h,B14_TEMP
FFDAF930h: 55D9                     OR     B14_TEMP,B9_COLOR1
FFDAF940h: C000 F8D4                JR     CMD_LOOP

********************************************************************************
* COMMAND_126_127
********************************************************************************
COMMAND_126_127:
FFDAF960h: 9501                     MOVE   *A8+,A1,0
FFDAF970h: 0545                     SETF   5h,0,0
FFDAF980h: 0581 00BA C000           MOVE   A1,@CONTROL+10,0
FFDAF9B0h: 0550                     SETF   10h,0,0
FFDAF9C0h: C000 F8CC                JR     CMD_LOOP

********************************************************************************
* COMMAND_128_PIXEL_STRETCH_OFF
********************************************************************************
COMMAND_128_PIXEL_STRETCH_OFF:
FFDAF9E0h: 5621                     CLR    A1
FFDAF9F0h: 0581 0920 FFEC           MOVE   A1,@PIXEL_STRETCH_ENABLED_FLAG,0
FFDAFA20h: C000 F8C6                JR     CMD_LOOP

********************************************************************************
* COMMAND_130_PIXEL_STRETCH_ON
********************************************************************************
COMMAND_130_PIXEL_STRETCH_ON:
FFDAFA40h: 1821                     MOVK   1h,A1
FFDAFA50h: 0581 0920 FFEC           MOVE   A1,@PIXEL_STRETCH_ENABLED_FLAG,0
FFDAFA80h: C000 F8C0                JR     CMD_LOOP

********************************************************************************
* COMMAND_132_SCALE_FACTOR_0x84
********************************************************************************
COMMAND_132_SCALE_FACTOR_0x84:
FFDAFAA0h: 9701                     MOVE   *A8+,A1,1
FFDAFAB0h: 0781 0940 FFEC           MOVE   A1,@SCALE_FACTOR_DX_A,1
FFDAFAE0h: 9701                     MOVE   *A8+,A1,1
FFDAFAF0h: 0781 0960 FFEC           MOVE   A1,@SCALE_FACTOR_DY_A,1
FFDAFB20h: C000 F8B6                JR     CMD_LOOP

********************************************************************************
* COMMAND_134_SCALE_FACTOR_0x86
********************************************************************************
COMMAND_134_SCALE_FACTOR_0x86:
FFDAFB40h: 9501                     MOVE   *A8+,A1,0
FFDAFB50h: 0581 0980 FFEC           MOVE   A1,@SCALE_FACTOR_DX_B,0
FFDAFB80h: 9501                     MOVE   *A8+,A1,0
FFDAFB90h: 0581 09A0 FFEC           MOVE   A1,@SCALE_FACTOR_DY_B,0
FFDAFBC0h: C000 F8AC                JR     CMD_LOOP

********************************************************************************
* COMMAND_136_TEXT_FONT
********************************************************************************
COMMAND_136_TEXT_FONT:
FFDAFBE0h: 9503                     MOVE   *A8+,A3,0
FFDAFBF0h: 09E1 9540 FFDC           MOVI   FONTS_TABLES,A1
FFDAFC20h: 24A3                     SLL    5h,A3
FFDAFC30h: 4061                     ADD    A3,A1
FFDAFC40h: 09E2 0CD0 FFEC           MOVI   CURRENT_FONT,A2
FFDAFC70h: 09C7 0010                MOVI   10h,A7
FFDAFC90h: 8623                     MOVE   *A1,A3,1
FFDAFCA0h: 9A62                     MOVE   *A3+,*A2+,1
FFDAFCB0h: 3C47                     DSJS   A7,FFDAFCA0h
FFDAFCC0h: C000 F89C                JR     CMD_LOOP

********************************************************************************
* COMMAND_138_TRANSPARENCY_OFF
********************************************************************************
COMMAND_138_TRANSPARENCY_OFF:
FFDAFCE0h: 0541                     SETF   1h,0,0
FFDAFCF0h: 5621                     CLR    A1
FFDAFD00h: 0581 00B5 C000           MOVE   A1,@CONTROL+5,0
FFDAFD30h: 0550                     SETF   10h,0,0
FFDAFD40h: C000 F894                JR     CMD_LOOP

********************************************************************************
* COMMAND_140_TRANSPARENCY_ON
********************************************************************************
COMMAND_140_TRANSPARENCY_ON:
FFDAFD60h: 0541                     SETF   1h,0,0
FFDAFD70h: 1821                     MOVK   1h,A1
FFDAFD80h: 0581 00B5 C000           MOVE   A1,@CONTROL+5,0
FFDAFDB0h: 0550                     SETF   10h,0,0
FFDAFDC0h: C000 F88C                JR     CMD_LOOP

********************************************************************************
* HI_VECTOR
********************************************************************************
HI_VECTOR:
FFDAFDE0h: 098F 6000                MMTM   SP,A1,A2
FFDAFE00h: 05A1 00F0 C000           MOVE   @HSTCTLL,A1,0
FFDAFE30h: 27A1                     SLL    1Dh,A1
FFDAFE40h: 2D01                     SRL    18h,A1
FFDAFE50h: 0B21 0B80 FFEC           ADDI   MSGIN_TABLE,A1
FFDAFE80h: 8621                     MOVE   *A1,A1,1
FFDAFE90h: 0161                     JUMP   A1

********************************************************************************
* MSGIN_1
********************************************************************************
MSGIN_1:
FFDAFEA0h: 07A1 0860 FFEC           MOVE   @FFEC0860h,A1,1
FFDAFED0h: 0541                     SETF   1h,0,0
FFDAFEE0h: 8422                     MOVE   *A1,A2,0
FFDAFEF0h: CB06                     JRNE   FFDAFF60h
FFDAFF00h: 1822                     MOVK   1h,A2
FFDAFF10h: 8041                     MOVE   A2,*A1,0
FFDAFF20h: 5642                     CLR    A2
FFDAFF30h: 0782 0860 FFEC           MOVE   A2,@FFEC0860h,1
FFDAFF60h: 0588 00F3 C000           MOVE   A8,@HSTCTLL+3,0
FFDAFF90h: 0550                     SETF   10h,0,0
FFDAFFA0h: 09AF 0006                MMFM   SP,A1,A2
FFDAFFC0h: 0940                     RETI

********************************************************************************
* MSGIN_2
********************************************************************************
MSGIN_2:
FFDAFFD0h: 09E1 0ED0 FFEC           MOVI   FFEC0ED0h,A1
FFDB0000h: B7E2 0060                MOVE   *SP(60h),A2,1
FFDB0020h: 9241                     MOVE   A2,*A1+,1
FFDB0030h: B7E2 0040                MOVE   *SP(40h),A2,1
FFDB0050h: 9241                     MOVE   A2,*A1+,1
FFDB0060h: 9201                     MOVE   A0,*A1+,1
FFDB0070h: B7E2 0020                MOVE   *SP(20h),A2,1
FFDB0090h: 9241                     MOVE   A2,*A1+,1
FFDB00A0h: 87E2                     MOVE   *SP,A2,1
FFDB00B0h: 9241                     MOVE   A2,*A1+,1
FFDB00C0h: 9261                     MOVE   A3,*A1+,1
FFDB00D0h: 9281                     MOVE   A4,*A1+,1
FFDB00E0h: 92A1                     MOVE   A5,*A1+,1
FFDB00F0h: 92C1                     MOVE   A6,*A1+,1
FFDB0100h: 92E1                     MOVE   A7,*A1+,1
FFDB0110h: 9301                     MOVE   A8,*A1+,1
FFDB0120h: 9321                     MOVE   A9,*A1+,1
FFDB0130h: 9341                     MOVE   A10,*A1+,1
FFDB0140h: 9361                     MOVE   A11,*A1+,1
FFDB0150h: 9381                     MOVE   A12,*A1+,1
FFDB0160h: 93A1                     MOVE   A13,*A1+,1
FFDB0170h: 93C1                     MOVE   A14,*A1+,1
FFDB0180h: 4E12                     MOVE   B0_SADDR,A2
FFDB0190h: 9241                     MOVE   A2,*A1+,1
FFDB01A0h: 4E20                     MOVE   A1,B0_SADDR
FFDB01B0h: 9230                     MOVE   B1_SPTCH,*B0_SADDR+,1
FFDB01C0h: 9250                     MOVE   B2_DADDR,*B0_SADDR+,1
FFDB01D0h: 9270                     MOVE   B3_DPTCH,*B0_SADDR+,1
FFDB01E0h: 9290                     MOVE   B4_OFFSET,*B0_SADDR+,1
FFDB01F0h: 92B0                     MOVE   B5_WSTART,*B0_SADDR+,1
FFDB0200h: 92D0                     MOVE   B6_WEND,*B0_SADDR+,1
FFDB0210h: 92F0                     MOVE   B7_DVDX,*B0_SADDR+,1
FFDB0220h: 9310                     MOVE   B8_COLOR0,*B0_SADDR+,1
FFDB0230h: 9330                     MOVE   B9_COLOR1,*B0_SADDR+,1
FFDB0240h: 9350                     MOVE   B10_COUNT,*B0_SADDR+,1
FFDB0250h: 9370                     MOVE   B11_INC1,*B0_SADDR+,1
FFDB0260h: 9390                     MOVE   B12_INC2,*B0_SADDR+,1
FFDB0270h: 93B0                     MOVE   B13_PATTRN,*B0_SADDR+,1
FFDB0280h: 93D0                     MOVE   B14_TEMP,*B0_SADDR+,1
FFDB0290h: 4E40                     MOVE   A2,B0_SADDR
********************************************************************************
* MSGIN_0_3_4_7
********************************************************************************
MSGIN_0_3_4_7:
FFDB02A0h: 0541                     SETF   1h,0,0
FFDB02B0h: C0CA                     JR     FFDAFF60h

********************************************************************************
* DI_VECTOR
********************************************************************************
DI_VECTOR:
FFDB02C0h: 099F 000A                MMTM   SP,B12_INC2,B14_TEMP
FFDB02E0h: 0541                     SETF   1h,0,0
FFDB02F0h: 058F 012A C000           MOVE   SP,@INTPEND+10,0
FFDB0320h: 0550                     SETF   10h,0,0
FFDB0330h: 05BE 00A0 C000           MOVE   @DPYINT,B14_TEMP,0
FFDB0360h: 05BC 0050 C000           MOVE   @VEBLNK,B12_INC2,0
FFDB0390h: 49DC                     CMP    B14_TEMP,B12_INC2
FFDB03A0h: CB0D                     JRNE   FFDB0480h
FFDB03B0h: 05BC 0060 C000           MOVE   @VSBLNK,B12_INC2,0
FFDB03E0h: 059C 00A0 C000           MOVE   B12_INC2,@DPYINT,0
FFDB0410h: 07C0 0A80 FFEC 0AA0 FFEC MOVE   @FFEC0A80h,@FFEC0AA0h,1
FFDB0460h: C000 008A                JR     FFDB0D20h

FFDB0480h: 059C 00A0 C000           MOVE   B12_INC2,@DPYINT,0
FFDB04B0h: 07BE 0A80 FFEC           MOVE   @FFEC0A80h,B14_TEMP,1
FFDB04E0h: 0B1E 020D                ADDI   20Dh,B14_TEMP
FFDB0500h: 079E 0A80 FFEC           MOVE   B14_TEMP,@FFEC0A80h,1
FFDB0530h: 05BE 0840 FFEC           MOVE   @FFEC0840h,B14_TEMP,0
FFDB0560h: CA7B                     JREQ   FFDB0D20h
FFDB0570h: 143E                     DEC    B14_TEMP
FFDB0580h: CA37                     JREQ   FFDB0900h
FFDB0590h: 05BE 00B0 C000           MOVE   @CONTROL,B14_TEMP,0
FFDB05C0h: 099F 3142                MMTM   SP,B2_DADDR,B3_DPTCH,B7_DVDX,B9_COLOR1,B14_TEMP
FFDB05E0h: 57DE                     CLR    B14_TEMP
FFDB05F0h: 0549                     SETF   9h,0,0
FFDB0600h: 059E 00B6 C000           MOVE   B14_TEMP,@CONTROL+6,0
FFDB0630h: 0550                     SETF   10h,0,0
FFDB0640h: 09F3 2000 0000           MOVI   00002000h,B3_DPTCH
FFDB0670h: 09F7 0800 0001           MOVI   00010800h,B7_DVDX
FFDB06A0h: 09F2 0000 003C           MOVI   SCREENBASE_0x003C_0000,B2_DADDR
FFDB06D0h: 5739                     CLR    B9_COLOR1
FFDB06E0h: 05BE 00B0 C000           MOVE   @CONTROL,B14_TEMP,0
FFDB0710h: 0FC0                     FILL   L
FFDB0720h: 0541                     SETF   1h,0,0
FFDB0730h: 183E                     MOVK   1h,B14_TEMP
FFDB0740h: 059E 008B C000           MOVE   B14_TEMP,@DPYCTL+11,0
FFDB0770h: 09F2 0000 003C           MOVI   SCREENBASE_0x003C_0000,B2_DADDR
FFDB07A0h: 05BE 0080 C000           MOVE   @DPYCTL,B14_TEMP,0
FFDB07D0h: FA5E                     PIXT   *B2_DADDR,B14_TEMP
FFDB07E0h: 09F7 0004 00F0           MOVI   00F00004h,B7_DVDX
FFDB0810h: 0FC0                     FILL   L
FFDB0820h: 058F 008B C000           MOVE   SP,@DPYCTL+11,0
FFDB0850h: 0550                     SETF   10h,0,0
FFDB0860h: 57DE                     CLR    B14_TEMP
FFDB0870h: 059E 0840 FFEC           MOVE   B14_TEMP,@FFEC0840h,0
FFDB08A0h: 09BF 428C                MMFM   SP,B2_DADDR,B3_DPTCH,B7_DVDX,B9_COLOR1,B14_TEMP
FFDB08C0h: 059E 00B0 C000           MOVE   B14_TEMP,@CONTROL,0
FFDB08F0h: C042                     JR     FFDB0D20h

FFDB0900h: 09DE FFFF                MOVI   FFFFh,B14_TEMP
FFDB0920h: 059E 0000 0400           MOVE   B14_TEMP,@04000000h,0
FFDB0950h: 09DE FFFF                MOVI   FFFFh,B14_TEMP
FFDB0970h: 059E 0000 0200           MOVE   B14_TEMP,@02000000h,0
FFDB09A0h: 059E 2000 0200           MOVE   B14_TEMP,@02002000h,0
FFDB09D0h: 05BE 0000 0420           MOVE   @04200000h,B14_TEMP,0
FFDB0A00h: 05C0 0090 C000 01E0 C000 MOVE   @DPYSTRT,@DPYADR,0
FFDB0A50h: 05BE 00B0 C000           MOVE   @CONTROL,B14_TEMP,0
FFDB0A80h: 099F F102                MMTM   SP,B0_SADDR-B3_DPTCH,B7_DVDX,B14_TEMP
FFDB0AA0h: 57DE                     CLR    B14_TEMP
FFDB0AB0h: 0549                     SETF   9h,0,0
FFDB0AC0h: 059E 00B6 C000           MOVE   B14_TEMP,@CONTROL+6,0
FFDB0AF0h: 0550                     SETF   10h,0,0
FFDB0B00h: 0541                     SETF   1h,0,0
FFDB0B10h: 183E                     MOVK   1h,B14_TEMP
FFDB0B20h: 059E 008B C000           MOVE   B14_TEMP,@DPYCTL+11,0
FFDB0B50h: 09F3 2000 0000           MOVI   00002000h,B3_DPTCH
FFDB0B80h: 4C71                     MOVE   B3_DPTCH,B1_SPTCH
FFDB0B90h: 4C92                     MOVE   B4_OFFSET,B2_DADDR
FFDB0BA0h: 07B0 09C0 FFEC           MOVE   @FFEC09C0h,B0_SADDR,1
FFDB0BD0h: 4412                     SUB    B0_SADDR,B2_DADDR
FFDB0BE0h: 09F0 0000 003C           MOVI   SCREENBASE_0x003C_0000,B0_SADDR
FFDB0C10h: 09F7 0004 00F0           MOVI   00F00004h,B7_DVDX
FFDB0C40h: 0F00                     PIXBLT L,L
FFDB0C50h: 058F 008B C000           MOVE   SP,@DPYCTL+11,0
FFDB0C80h: 0550                     SETF   10h,0,0
FFDB0C90h: 57DE                     CLR    B14_TEMP
FFDB0CA0h: 059E 0840 FFEC           MOVE   B14_TEMP,@FFEC0840h,0
FFDB0CD0h: 09BF 408F                MMFM   SP,B0_SADDR-B3_DPTCH,B7_DVDX,B14_TEMP
FFDB0CF0h: 059E 00B0 C000           MOVE   B14_TEMP,@CONTROL,0
FFDB0D20h: 09BF 5000                MMFM   SP,B12_INC2,B14_TEMP
FFDB0D40h: 0940                     RETI

********************************************************************************
* CLEAR_SCREEN
********************************************************************************
CLEAR_SCREEN:
FFDB0D50h: 05A1 00B0 C000           MOVE   @CONTROL,A1,0
FFDB0D80h: 5739                     CLR    B9_COLOR1
FFDB0D90h: 0549                     SETF   9h,0,0
FFDB0DA0h: 0599 00B6 C000           MOVE   B9_COLOR1,@CONTROL+6,0
FFDB0DD0h: 0550                     SETF   10h,0,0
FFDB0DE0h: 4C92                     MOVE   B4_OFFSET,B2_DADDR
FFDB0DF0h: 09F7 0280 01E0           MOVI   01E00280h,B7_DVDX
FFDB0E20h: 0FC0                     FILL   L
FFDB0E30h: 0581 00B0 C000           MOVE   A1,@CONTROL,0
FFDB0E60h: 0960                     RETS

********************************************************************************
* MSGIN_5
********************************************************************************
MSGIN_5:
FFDB0E70h: 0550                     SETF   10h,0,0
FFDB0E80h: 09DE 0050                MOVI   50h,B14_TEMP
FFDB0EA0h: 059E 00F0 C000           MOVE   B14_TEMP,@HSTCTLL,0
FFDB0ED0h: 09C1 FFFF                MOVI   FFFFh,A1
FFDB0EF0h: 0581 00A0 C000           MOVE   A1,@DPYINT,0
FFDB0F20h: 0541                     SETF   1h,0,0
FFDB0F30h: 57DE                     CLR    B14_TEMP
FFDB0F40h: 059E 00F3 C000           MOVE   B14_TEMP,@HSTCTLL+3,0
FFDB0F70h: 0550                     SETF   10h,0,0
FFDB0F80h: 09AF 0006                MMFM   SP,A1,A2
FFDB0FA0h: 97FE                     MOVE   *SP+,B14_TEMP,1
FFDB0FB0h: 0B0F 0020                ADDI   20h,SP
FFDB0FD0h: 09EF FDF0 FFDD           MOVI   STACK_TOP,SP
FFDB1000h: 0B9E 0000 0200           ANDI   FDFFFFFFh,B14_TEMP
FFDB1030h: 01BE                     PUTST  B14_TEMP
FFDB1040h: 09DE 0050                MOVI   50h,B14_TEMP
FFDB1060h: 059E 00F0 C000           MOVE   B14_TEMP,@HSTCTLL,0
FFDB1090h: 0300                     NOP
FFDB10A0h: 0300                     NOP
FFDB10B0h: 0300                     NOP
FFDB10C0h: 0300                     NOP
FFDB10D0h: 0300                     NOP
FFDB10E0h: 0300                     NOP
FFDB10F0h: 0300                     NOP
FFDB1100h: 0300                     NOP
FFDB1110h: 0300                     NOP
FFDB1120h: 0300                     NOP
FFDB1130h: 0300                     NOP
FFDB1140h: 09DE 0040                MOVI   40h,B14_TEMP
FFDB1160h: 059E 00F0 C000           MOVE   B14_TEMP,@HSTCTLL,0
FFDB1190h: 0300                     NOP
FFDB11A0h: 0300                     NOP
FFDB11B0h: 0300                     NOP
FFDB11C0h: 0300                     NOP
FFDB11D0h: 0300                     NOP
FFDB11E0h: 0300                     NOP
FFDB11F0h: 0300                     NOP
FFDB1200h: 0300                     NOP
FFDB1210h: 0300                     NOP
FFDB1220h: 0300                     NOP
FFDB1230h: 0300                     NOP
FFDB1240h: C0DF                     JR     FFDB1040h

********************************************************************************
* MSGIN_6
********************************************************************************
MSGIN_6:
FFDB1250h: 0550                     SETF   10h,0,0
FFDB1260h: 05BE 00B0 C000           MOVE   @CONTROL,B14_TEMP,0
FFDB1290h: 099F F102                MMTM   SP,B0_SADDR-B3_DPTCH,B7_DVDX,B14_TEMP
FFDB12B0h: 09DE 0060                MOVI   60h,B14_TEMP
FFDB12D0h: 059E 00F0 C000           MOVE   B14_TEMP,@HSTCTLL,0
FFDB1300h: 57DE                     CLR    B14_TEMP
FFDB1310h: 0549                     SETF   9h,0,0
FFDB1320h: 059E 00B6 C000           MOVE   B14_TEMP,@CONTROL+6,0
FFDB1350h: 0550                     SETF   10h,0,0
FFDB1360h: 09F3 2000 0000           MOVI   00002000h,B3_DPTCH
FFDB1390h: 4C71                     MOVE   B3_DPTCH,B1_SPTCH
FFDB13A0h: 0300                     NOP
FFDB13B0h: 0300                     NOP
FFDB13C0h: 0300                     NOP
FFDB13D0h: 0300                     NOP
FFDB13E0h: 05BE 0CC0 FFEC           MOVE   @FFEC0CC0h,B14_TEMP,0
FFDB1410h: CAF8                     JREQ   FFDB13A0h
FFDB1420h: 0550                     SETF   10h,0,0
FFDB1430h: 05B0 0CA0 FFEC           MOVE   @FFEC0CA0h,B0_SADDR,0
FFDB1460h: 2590                     SLL    Ch,B0_SADDR
FFDB1470h: 05B2 0CB0 FFEC           MOVE   @FFEC0CB0h,B2_DADDR,0
FFDB14A0h: 2592                     SLL    Ch,B2_DADDR
FFDB14B0h: 0541                     SETF   1h,0,0
FFDB14C0h: 57DE                     CLR    B14_TEMP
FFDB14D0h: 059E 008C C000           MOVE   B14_TEMP,@DPYCTL+12,0
FFDB1500h: 183E                     MOVK   1h,B14_TEMP
FFDB1510h: 059E 008B C000           MOVE   B14_TEMP,@DPYCTL+11,0
FFDB1540h: 09DE 0064                MOVI   64h,B14_TEMP
FFDB1560h: 0300                     NOP
FFDB1570h: 0300                     NOP
FFDB1580h: 3C7E                     DSJS   B14_TEMP,FFDB1560h
FFDB1590h: 09F7 0004 0001           MOVI   00010004h,B7_DVDX
FFDB15C0h: 0F00                     PIXBLT L,L
FFDB15D0h: 57DE                     CLR    B14_TEMP
FFDB15E0h: 059E 008B C000           MOVE   B14_TEMP,@DPYCTL+11,0
FFDB1610h: 183E                     MOVK   1h,B14_TEMP
FFDB1620h: 059E 008C C000           MOVE   B14_TEMP,@DPYCTL+12,0
FFDB1650h: 0550                     SETF   10h,0,0
FFDB1660h: 57DE                     CLR    B14_TEMP
FFDB1670h: 059E 0CC0 FFEC           MOVE   B14_TEMP,@FFEC0CC0h,0
FFDB16A0h: C0CF                     JR     FFDB13A0h

********************************************************************************
* ILLOP_VECTOR
********************************************************************************
ILLOP_VECTOR:
FFDB16B0h: 97E0                     MOVE   *SP+,A0,1
FFDB16C0h: 97E1                     MOVE   *SP+,A1,1
FFDB16D0h: C0FF                     JR     FFDB16D0h

********************************************************************************
* INT1_VECTOR
********************************************************************************
INT1_VECTOR:
FFDB16E0h: C0FF                     JR     INT1_VECTOR

********************************************************************************
* INT2_VECTOR
********************************************************************************
INT2_VECTOR:
FFDB16F0h: C0FF                     JR     INT2_VECTOR

********************************************************************************
* COMMAND_26_GRAPHYY_0x1a
********************************************************************************
COMMAND_26_GRAPHYY_0x1a:
FFDB1700h: 9504                     MOVE   *A8+,A4,0
FFDB1710h: 9701                     MOVE   *A8+,A1,1
FFDB1720h: 9702                     MOVE   *A8+,A2,1
FFDB1730h: 9703                     MOVE   *A8+,A3,1
FFDB1740h: 9506                     MOVE   *A8+,A6,0
FFDB1750h: 4C84                     MOVE   A4,A4
FFDB1760h: CA00 F6F2                JREQ   CMD_LOOP
FFDB1780h: 098F 0084                MMTM   SP,A8,A13
FFDB17A0h: 099F 0080                MMTM   SP,B8_COLOR0
FFDB17C0h: 4C8D                     MOVE   A4,A13
FFDB17D0h: 4C68                     MOVE   A3,A8
FFDB17E0h: 4F3C                     MOVE   B9_COLOR1,A12
FFDB17F0h: 4F1E                     MOVE   B8_COLOR0,A14
FFDB1800h: 1829                     MOVK   1h,A9
FFDB1810h: 25E9                     SLL    Fh,A9
FFDB1820h: 4CC4                     MOVE   A6,A4
FFDB1830h: 2606                     SLL    10h,A6
FFDB1840h: 4126                     ADD    A9,A6
FFDB1850h: 4E40                     MOVE   A2,B0_SADDR
FFDB1860h: 0390                     ABS    B0_SADDR
FFDB1870h: 09FB 0000 FFDD           MOVI   FFDD0000h,B11_INC1
FFDB18A0h: 4E27                     MOVE   A1,B7_DVDX
FFDB18B0h: 2717                     SLL    18h,B7_DVDX
FFDB18C0h: 2C77                     SRL    1Dh,B7_DVDX
FFDB18D0h: 2437                     SLL    1h,B7_DVDX
FFDB18E0h: CB01                     JRNE   FFDB1900h
FFDB18F0h: 1A17                     MOVK   10h,B7_DVDX
FFDB1900h: 4C27                     MOVE   A1,A7
FFDB1910h: 2587                     SLL    Ch,A7
FFDB1920h: 2C87                     SRL    1Ch,A7
FFDB1930h: CA07                     JREQ   FFDB19B0h
FFDB1940h: 1427                     DEC    A7
FFDB1950h: CA05                     JREQ   FFDB19B0h
FFDB1960h: 2487                     SLL    4h,A7
FFDB1970h: 09FA 44D0 FFDB           MOVI   FFDB44D0h,B10_COUNT
FFDB19A0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB19B0h: 09F2 44E0 FFDB           MOVI   FFDB44E0h,B2_DADDR
FFDB19E0h: 1FA1                     BTST   2h,A1
FFDB19F0h: CA15                     JREQ   FFDB1B50h
FFDB1A00h: 05A3 09A0 FFEC           MOVE   @SCALE_FACTOR_DY_B,A3,0
FFDB1A30h: 2603                     SLL    10h,A3
FFDB1A40h: 4069                     ADD    A3,A9
FFDB1A50h: 07AA 0960 FFEC           MOVE   @SCALE_FACTOR_DY_A,A10,1
FFDB1A80h: 4E13                     MOVE   B0_SADDR,A3
FFDB1A90h: 2603                     SLL    10h,A3
FFDB1AA0h: CA04                     JREQ   FFDB1AF0h
FFDB1AB0h: 09FA 3220 FFDB           MOVI   FFDB3220h,B10_COUNT
FFDB1AE0h: C01A                     JR     FFDB1C90h

FFDB1AF0h: 2A02                     SRA    10h,A2
FFDB1B00h: 2A06                     SRA    10h,A6
FFDB1B10h: 09FA 32B0 FFDB           MOVI   FFDB32B0h,B10_COUNT
FFDB1B40h: C014                     JR     FFDB1C90h

FFDB1B50h: 182A                     MOVK   1h,A10
FFDB1B60h: 260A                     SLL    10h,A10
FFDB1B70h: 4CFA                     MOVE   B7_DVDX,B10_COUNT
FFDB1B80h: 2FFA                     SRL    1h,B10_COUNT
FFDB1B90h: 143A                     DEC    B10_COUNT
FFDB1BA0h: 4E13                     MOVE   B0_SADDR,A3
FFDB1BB0h: 2603                     SLL    10h,A3
FFDB1BC0h: CB03                     JRNE   FFDB1C00h
FFDB1BD0h: 121A                     ADDK   10h,B10_COUNT
FFDB1BE0h: 2A02                     SRA    10h,A2
FFDB1BF0h: 2A06                     SRA    10h,A6
FFDB1C00h: 4C23                     MOVE   A1,A3
FFDB1C10h: 27A3                     SLL    1Dh,A3
FFDB1C20h: CB01                     JRNE   FFDB1C40h
FFDB1C30h: 111A                     ADDK   8h,B10_COUNT
FFDB1C40h: 24BA                     SLL    5h,B10_COUNT
FFDB1C50h: 0B3A 29A0 FFDB           ADDI   FFDB29A0h,B10_COUNT
FFDB1C80h: 875A                     MOVE   *B10_COUNT,B10_COUNT,1
FFDB1C90h: 955E                     MOVE   *B10_COUNT+,B14_TEMP,0
FFDB1CA0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB1CB0h: 3C5E                     DSJS   B14_TEMP,FFDB1CA0h
FFDB1CC0h: 1F81                     BTST   3h,A1
FFDB1CD0h: CB0B                     JRNE   FFDB1D90h
FFDB1CE0h: D717                     EXGF   B7_DVDX,1
FFDB1CF0h: 9503                     MOVE   *A8+,A3,0
FFDB1D00h: 4D45                     MOVE   A10,A5
FFDB1D10h: 5C65                     MPYS   A3,A5
FFDB1D20h: 4125                     ADD    A9,A5
FFDB1D30h: EEA4                     MOVY   A5,A4
FFDB1D40h: D717                     EXGF   B7_DVDX,1
FFDB1D50h: 142D                     DEC    A13
FFDB1D60h: CA23                     JREQ   FFDB1FA0h
FFDB1D70h: 40E8                     ADD    A7,A8
FFDB1D80h: C001                     JR     FFDB1DA0h

FFDB1D90h: 4446                     SUB    A2,A6
FFDB1DA0h: 575A                     CLR    B10_COUNT
FFDB1DB0h: 1F81                     BTST   3h,A1
FFDB1DC0h: CA01                     JREQ   FFDB1DE0h
FFDB1DD0h: 111A                     ADDK   8h,B10_COUNT
FFDB1DE0h: 0D10 FFFF FFFE           SUBI   10000h,B0_SADDR
FFDB1E10h: C701                     JRGT   FFDB1E30h
FFDB1E20h: 109A                     ADDK   4h,B10_COUNT
FFDB1E30h: 05A3 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A3,0
FFDB1E60h: CA01                     JREQ   FFDB1E80h
FFDB1E70h: 103A                     INC    B10_COUNT
FFDB1E80h: 24BA                     SLL    5h,B10_COUNT
FFDB1E90h: 0B3A 2FA0 FFDB           ADDI   FFDB2FA0h,B10_COUNT
FFDB1EC0h: 875A                     MOVE   *B10_COUNT,B10_COUNT,1
FFDB1ED0h: 093A                     CALL   B10_COUNT
FFDB1EE0h: 09FB 010E C000           MOVI   HSTCTLH+14,B11_INC1
FFDB1F10h: 0541                     SETF   1h,0,0
FFDB1F20h: 183E                     MOVK   1h,B14_TEMP
FFDB1F30h: 81DB                     MOVE   B14_TEMP,*B11_INC1,0
FFDB1F40h: 81FB                     MOVE   SP,*B11_INC1,0
FFDB1F50h: 0550                     SETF   10h,0,0
FFDB1F60h: D717                     EXGF   B7_DVDX,1
FFDB1F70h: 0D5F 0000 FFDD           CALLA  FFDD0000h
FFDB1FA0h: 0740                     SETF   20h,0,1
FFDB1FB0h: 09E3 00B6 C000           MOVI   CONTROL+6,A3
FFDB1FE0h: 0542                     SETF   2h,0,0
FFDB1FF0h: 1861                     MOVK   3h,A1
FFDB2000h: 8023                     MOVE   A1,*A3,0
FFDB2010h: 0550                     SETF   10h,0,0
FFDB2020h: 09BF 0100                MMFM   SP,B8_COLOR0
FFDB2040h: 09AF 2100                MMFM   SP,A8,A13
FFDB2060h: 4F89                     MOVE   A12,B9_COLOR1
FFDB2070h: C000 F661                JR     CMD_LOOP

********************************************************************************
* COMMAND_28_GRAPHYY_0x1c
********************************************************************************
COMMAND_28_GRAPHYY_0x1c:
FFDB2090h: 9504                     MOVE   *A8+,A4,0
FFDB20A0h: 9701                     MOVE   *A8+,A1,1
FFDB20B0h: 9703                     MOVE   *A8+,A3,1
FFDB20C0h: 4C84                     MOVE   A4,A4
FFDB20D0h: CA00 F65B                JREQ   CMD_LOOP
FFDB20F0h: 098F 0084                MMTM   SP,A8,A13
FFDB2110h: 099F 0080                MMTM   SP,B8_COLOR0
FFDB2130h: 4C8D                     MOVE   A4,A13
FFDB2140h: 4C68                     MOVE   A3,A8
FFDB2150h: 4F3C                     MOVE   B9_COLOR1,A12
FFDB2160h: 4F1E                     MOVE   B8_COLOR0,A14
FFDB2170h: 1829                     MOVK   1h,A9
FFDB2180h: 25E9                     SLL    Fh,A9
FFDB2190h: 4D22                     MOVE   A9,A2
FFDB21A0h: 09FB 0000 FFDD           MOVI   FFDD0000h,B11_INC1
FFDB21D0h: 4E27                     MOVE   A1,B7_DVDX
FFDB21E0h: 2717                     SLL    18h,B7_DVDX
FFDB21F0h: 2C77                     SRL    1Dh,B7_DVDX
FFDB2200h: 2437                     SLL    1h,B7_DVDX
FFDB2210h: CB01                     JRNE   FFDB2230h
FFDB2220h: 1A17                     MOVK   10h,B7_DVDX
FFDB2230h: 4C27                     MOVE   A1,A7
FFDB2240h: 2587                     SLL    Ch,A7
FFDB2250h: 2C87                     SRL    1Ch,A7
FFDB2260h: CA07                     JREQ   FFDB22E0h
FFDB2270h: 1427                     DEC    A7
FFDB2280h: CA05                     JREQ   FFDB22E0h
FFDB2290h: 24A7                     SLL    5h,A7
FFDB22A0h: 09FA 44D0 FFDB           MOVI   FFDB44D0h,B10_COUNT
FFDB22D0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB22E0h: 1FA1                     BTST   2h,A1
FFDB22F0h: CA17                     JREQ   FFDB2470h
FFDB2300h: 09F2 44E0 FFDB           MOVI   FFDB44E0h,B2_DADDR
FFDB2330h: 05A3 09A0 FFEC           MOVE   @SCALE_FACTOR_DY_B,A3,0
FFDB2360h: 2603                     SLL    10h,A3
FFDB2370h: 4069                     ADD    A3,A9
FFDB2380h: 07AA 0960 FFEC           MOVE   @SCALE_FACTOR_DY_A,A10,1
FFDB23B0h: 05A3 0980 FFEC           MOVE   @SCALE_FACTOR_DX_B,A3,0
FFDB23E0h: 2603                     SLL    10h,A3
FFDB23F0h: 4062                     ADD    A3,A2
FFDB2400h: 07A6 0940 FFEC           MOVE   @SCALE_FACTOR_DX_A,A6,1
FFDB2430h: 09FA 3FE0 FFDB           MOVI   FFDB3FE0h,B10_COUNT
FFDB2460h: C012                     JR     FFDB2590h

FFDB2470h: 182A                     MOVK   1h,A10
FFDB2480h: 260A                     SLL    10h,A10
FFDB2490h: 4D46                     MOVE   A10,A6
FFDB24A0h: 09F2 45E0 FFDB           MOVI   FFDB45E0h,B2_DADDR
FFDB24D0h: 4CFA                     MOVE   B7_DVDX,B10_COUNT
FFDB24E0h: 2FFA                     SRL    1h,B10_COUNT
FFDB24F0h: 143A                     DEC    B10_COUNT
FFDB2500h: 4C23                     MOVE   A1,A3
FFDB2510h: 27A3                     SLL    1Dh,A3
FFDB2520h: CB01                     JRNE   FFDB2540h
FFDB2530h: 111A                     ADDK   8h,B10_COUNT
FFDB2540h: 24BA                     SLL    5h,B10_COUNT
FFDB2550h: 0B3A 2DA0 FFDB           ADDI   FFDB2DA0h,B10_COUNT
FFDB2580h: 875A                     MOVE   *B10_COUNT,B10_COUNT,1
FFDB2590h: 955E                     MOVE   *B10_COUNT+,B14_TEMP,0
FFDB25A0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB25B0h: 3C5E                     DSJS   B14_TEMP,FFDB25A0h
FFDB25C0h: 1F81                     BTST   3h,A1
FFDB25D0h: CB12                     JRNE   FFDB2700h
FFDB25E0h: D717                     EXGF   B7_DVDX,1
FFDB25F0h: 0540                     SETF   20h,0,0
FFDB2600h: 9505                     MOVE   *A8+,A5,0
FFDB2610h: 4CC3                     MOVE   A6,A3
FFDB2620h: 5CA3                     MPYS   A5,A3
FFDB2630h: 4043                     ADD    A2,A3
FFDB2640h: 2E03                     SRL    10h,A3
FFDB2650h: 4C64                     MOVE   A3,A4
FFDB2660h: 2E05                     SRL    10h,A5
FFDB2670h: 4D43                     MOVE   A10,A3
FFDB2680h: 5CA3                     MPYS   A5,A3
FFDB2690h: 4123                     ADD    A9,A3
FFDB26A0h: EE64                     MOVY   A3,A4
FFDB26B0h: D717                     EXGF   B7_DVDX,1
FFDB26C0h: 0550                     SETF   10h,0,0
FFDB26D0h: 142D                     DEC    A13
FFDB26E0h: CA1C                     JREQ   FFDB28B0h
FFDB26F0h: 40E8                     ADD    A7,A8
FFDB2700h: 575A                     CLR    B10_COUNT
FFDB2710h: 1F81                     BTST   3h,A1
FFDB2720h: CA01                     JREQ   FFDB2740h
FFDB2730h: 105A                     ADDK   2h,B10_COUNT
FFDB2740h: 05A3 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A3,0
FFDB2770h: CA01                     JREQ   FFDB2790h
FFDB2780h: 103A                     INC    B10_COUNT
FFDB2790h: 24BA                     SLL    5h,B10_COUNT
FFDB27A0h: 0B3A 31A0 FFDB           ADDI   FFDB31A0h,B10_COUNT
FFDB27D0h: 875A                     MOVE   *B10_COUNT,B10_COUNT,1
FFDB27E0h: 093A                     CALL   B10_COUNT
FFDB27F0h: 09FB 010E C000           MOVI   HSTCTLH+14,B11_INC1
FFDB2820h: 0541                     SETF   1h,0,0
FFDB2830h: 183E                     MOVK   1h,B14_TEMP
FFDB2840h: 81DB                     MOVE   B14_TEMP,*B11_INC1,0
FFDB2850h: 81FB                     MOVE   SP,*B11_INC1,0
FFDB2860h: 0540                     SETF   20h,0,0
FFDB2870h: D717                     EXGF   B7_DVDX,1
FFDB2880h: 0D5F 0000 FFDD           CALLA  FFDD0000h
FFDB28B0h: 0740                     SETF   20h,0,1
FFDB28C0h: 09E3 00B6 C000           MOVI   CONTROL+6,A3
FFDB28F0h: 0542                     SETF   2h,0,0
FFDB2900h: 1861                     MOVK   3h,A1
FFDB2910h: 8023                     MOVE   A1,*A3,0
FFDB2920h: 0550                     SETF   10h,0,0
FFDB2930h: 09BF 0100                MMFM   SP,B8_COLOR0
FFDB2950h: 09AF 2100                MMFM   SP,A8,A13
FFDB2970h: 4F89                     MOVE   A12,B9_COLOR1
FFDB2980h: C000 F5D0                JR     CMD_LOOP

FFDB29A0h: 3320 FFDB                .long    FFDB3320h

FFDB29C0h: 3390 FFDB                .long    FFDB3390h

FFDB29E0h: 3400 FFDB                .long    FFDB3400h

FFDB2A00h: 3470 FFDB                .long    FFDB3470h

FFDB2A20h: 34E0 FFDB                .long    FFDB34E0h

FFDB2A40h: 3550 FFDB                .long    FFDB3550h

FFDB2A60h: 35C0 FFDB                .long    FFDB35C0h

FFDB2A80h: 3630 FFDB                .long    FFDB3630h

FFDB2AA0h: 3690 FFDB                .long    FFDB3690h

FFDB2AC0h: 36F0 FFDB                .long    FFDB36F0h

FFDB2AE0h: 3750 FFDB                .long    FFDB3750h

FFDB2B00h: 37B0 FFDB                .long    FFDB37B0h

FFDB2B20h: 3810 FFDB                .long    FFDB3810h

FFDB2B40h: 3870 FFDB                .long    FFDB3870h

FFDB2B60h: 38D0 FFDB                .long    FFDB38D0h

FFDB2B80h: 3930 FFDB                .long    FFDB3930h

FFDB2BA0h: 3980 FFDB                .long    FFDB3980h

FFDB2BC0h: 39F0 FFDB                .long    FFDB39F0h

FFDB2BE0h: 3A60 FFDB                .long    FFDB3A60h

FFDB2C00h: 3AD0 FFDB                .long    FFDB3AD0h

FFDB2C20h: 3B40 FFDB                .long    FFDB3B40h

FFDB2C40h: 3BB0 FFDB                .long    FFDB3BB0h

FFDB2C60h: 3C20 FFDB                .long    FFDB3C20h

FFDB2C80h: 3C90 FFDB                .long    FFDB3C90h

FFDB2CA0h: 3CF0 FFDB                .long    FFDB3CF0h

FFDB2CC0h: 3D50 FFDB                .long    FFDB3D50h

FFDB2CE0h: 3DB0 FFDB                .long    FFDB3DB0h

FFDB2D00h: 3E10 FFDB                .long    FFDB3E10h

FFDB2D20h: 3E70 FFDB                .long    FFDB3E70h

FFDB2D40h: 3ED0 FFDB                .long    FFDB3ED0h

FFDB2D60h: 3F30 FFDB                .long    FFDB3F30h

FFDB2D80h: 3F90 FFDB                .long    FFDB3F90h

FFDB2DA0h: 4090 FFDB                .long    FFDB4090h

FFDB2DC0h: 40E0 FFDB                .long    FFDB40E0h

FFDB2DE0h: 4130 FFDB                .long    FFDB4130h

FFDB2E00h: 4180 FFDB                .long    FFDB4180h

FFDB2E20h: 41D0 FFDB                .long    FFDB41D0h

FFDB2E40h: 4220 FFDB                .long    FFDB4220h

FFDB2E60h: 4270 FFDB                .long    FFDB4270h

FFDB2E80h: 42C0 FFDB                .long    FFDB42C0h

FFDB2EA0h: 42F0 FFDB                .long    FFDB42F0h

FFDB2EC0h: 4330 FFDB                .long    FFDB4330h

FFDB2EE0h: 4370 FFDB                .long    FFDB4370h

FFDB2F00h: 43B0 FFDB                .long    FFDB43B0h

FFDB2F20h: 43F0 FFDB                .long    FFDB43F0h

FFDB2F40h: 4430 FFDB                .long    FFDB4430h

FFDB2F60h: 4470 FFDB                .long    FFDB4470h

FFDB2F80h: 44B0 FFDB                .long    FFDB44B0h

FFDB2FA0h: 46E0 FFDB                .long    FFDB46E0h

FFDB2FC0h: 5770 FFDB                .long    FFDB5770h

FFDB2FE0h: 46E0 FFDB                .long    FFDB46E0h

FFDB3000h: 5770 FFDB                .long    FFDB5770h

FFDB3020h: 6950 FFDB                .long    FFDB6950h

FFDB3040h: 72F0 FFDB                .long    FFDB72F0h

FFDB3060h: 6950 FFDB                .long    FFDB6950h

FFDB3080h: 72F0 FFDB                .long    FFDB72F0h

FFDB30A0h: 7D20 FFDB                .long    FFDB7D20h

FFDB30C0h: 8490 FFDB                .long    FFDB8490h

FFDB30E0h: 7D20 FFDB                .long    FFDB7D20h

FFDB3100h: 8490 FFDB                .long    FFDB8490h

FFDB3120h: 7D20 FFDB                .long    FFDB7D20h

FFDB3140h: 8490 FFDB                .long    FFDB8490h

FFDB3160h: 7D20 FFDB                .long    FFDB7D20h

FFDB3180h: 8490 FFDB                .long    FFDB8490h

FFDB31A0h: 46E0 FFDB                .long    FFDB46E0h

FFDB31C0h: 5770 FFDB                .long    FFDB5770h

FFDB31E0h: 7D20 FFDB                .long    FFDB7D20h

FFDB3200h: 8490 FFDB                .long    FFDB8490h

FFDB3220h: 0008 9501 4D45 5C25 4125 .word    0008h,9501h,4D45h,5C25h,4125h,2E05h,4046h,EEC5h,3205h

FFDB32B0h: 0006 9501 4D45 5C25 4125 .word    0006h,9501h,4D45h,5C25h,4125h,4046h,ECC5h

FFDB3320h: 0006 9505 4CA1 4046 EEC5 .word    0006h,9505h,4CA1h,4046h,EEC5h,33C5h,2A45h

FFDB3390h: 0006 9505 4CA1 4046 EEC5 .word    0006h,9505h,4CA1h,4046h,EEC5h,3385h,2A85h

FFDB3400h: 0006 9505 4CA1 4046 EEC5 .word    0006h,9505h,4CA1h,4046h,EEC5h,3345h,2AC5h

FFDB3470h: 0006 9505 4CA1 4046 EEC5 .word    0006h,9505h,4CA1h,4046h,EEC5h,3305h,2B05h

FFDB34E0h: 0006 9505 4CA1 4046 EEC5 .word    0006h,9505h,4CA1h,4046h,EEC5h,32C5h,2B45h

FFDB3550h: 0006 9505 4CA1 4046 EEC5 .word    0006h,9505h,4CA1h,4046h,EEC5h,3285h,2B85h

FFDB35C0h: 0006 9505 4CA1 4046 EEC5 .word    0006h,9505h,4CA1h,4046h,EEC5h,3245h,2BC5h

FFDB3630h: 0005 9505 4CA1 4046 EEC5 .word    0005h,9505h,4CA1h,4046h,EEC5h,3205h

FFDB3690h: 0005 9505 4046 EEC5 33C5 .word    0005h,9505h,4046h,EEC5h,33C5h,2A45h

FFDB36F0h: 0005 9505 4046 EEC5 3385 .word    0005h,9505h,4046h,EEC5h,3385h,2A85h

FFDB3750h: 0005 9505 4046 EEC5 3345 .word    0005h,9505h,4046h,EEC5h,3345h,2AC5h

FFDB37B0h: 0005 9505 4046 EEC5 3305 .word    0005h,9505h,4046h,EEC5h,3305h,2B05h

FFDB3810h: 0005 9505 4046 EEC5 32C5 .word    0005h,9505h,4046h,EEC5h,32C5h,2B45h

FFDB3870h: 0005 9505 4046 EEC5 3285 .word    0005h,9505h,4046h,EEC5h,3285h,2B85h

FFDB38D0h: 0005 9505 4046 EEC5 3245 .word    0005h,9505h,4046h,EEC5h,3245h,2BC5h

FFDB3930h: 0004 9505 4046 EEC5 3205 .word    0004h,9505h,4046h,EEC5h,3205h

FFDB3980h: 0006 9505 4CA1 27C5 2A45 .word    0006h,9505h,4CA1h,27C5h,2A45h,4046h,ECC5h

FFDB39F0h: 0006 9505 4CA1 2785 2A85 .word    0006h,9505h,4CA1h,2785h,2A85h,4046h,ECC5h

FFDB3A60h: 0006 9505 4CA1 2745 2AC5 .word    0006h,9505h,4CA1h,2745h,2AC5h,4046h,ECC5h

FFDB3AD0h: 0006 9505 4CA1 2705 2B05 .word    0006h,9505h,4CA1h,2705h,2B05h,4046h,ECC5h

FFDB3B40h: 0006 9505 4CA1 26C5 2B45 .word    0006h,9505h,4CA1h,26C5h,2B45h,4046h,ECC5h

FFDB3BB0h: 0006 9505 4CA1 2685 2B85 .word    0006h,9505h,4CA1h,2685h,2B85h,4046h,ECC5h

FFDB3C20h: 0006 9505 4CA1 2645 2BC5 .word    0006h,9505h,4CA1h,2645h,2BC5h,4046h,ECC5h

FFDB3C90h: 0005 9505 4CA1 2605 4046 .word    0005h,9505h,4CA1h,2605h,4046h,ECC5h

FFDB3CF0h: 0005 9505 27C5 2A45 4046 .word    0005h,9505h,27C5h,2A45h,4046h,ECC5h

FFDB3D50h: 0005 9505 2785 2A85 4046 .word    0005h,9505h,2785h,2A85h,4046h,ECC5h

FFDB3DB0h: 0005 9505 2745 2AC5 4046 .word    0005h,9505h,2745h,2AC5h,4046h,ECC5h

FFDB3E10h: 0005 9505 2705 2B05 4046 .word    0005h,9505h,2705h,2B05h,4046h,ECC5h

FFDB3E70h: 0005 9505 26C5 2B45 4046 .word    0005h,9505h,26C5h,2B45h,4046h,ECC5h

FFDB3ED0h: 0005 9505 2685 2B85 4046 .word    0005h,9505h,2685h,2B85h,4046h,ECC5h

FFDB3F30h: 0005 9505 2645 2BC5 4046 .word    0005h,9505h,2645h,2BC5h,4046h,ECC5h

FFDB3F90h: 0004 9505 2605 4046 ECC5 .word    0004h,9505h,2605h,4046h,ECC5h

FFDB3FE0h: 000A 9501 4CC5 5C25 4045 .word    000Ah,9501h,4CC5h,5C25h,4045h,2E05h,2E01h,4D43h,5C23h,4123h,EE65h

FFDB4090h: 0004 9505 4CA1 25C5 2A45 .word    0004h,9505h,4CA1h,25C5h,2A45h

FFDB40E0h: 0004 9505 4CA1 2585 2A85 .word    0004h,9505h,4CA1h,2585h,2A85h

FFDB4130h: 0004 9505 4CA1 2545 2AC5 .word    0004h,9505h,4CA1h,2545h,2AC5h

FFDB4180h: 0004 9505 4CA1 2505 2B05 .word    0004h,9505h,4CA1h,2505h,2B05h

FFDB41D0h: 0004 9505 4CA1 24C5 2B45 .word    0004h,9505h,4CA1h,24C5h,2B45h

FFDB4220h: 0004 9505 4CA1 2485 2B85 .word    0004h,9505h,4CA1h,2485h,2B85h

FFDB4270h: 0004 9505 4CA1 2445 2BC5 .word    0004h,9505h,4CA1h,2445h,2BC5h

FFDB42C0h: 0002 9505 4CA1           .word    0002h,9505h,4CA1h

FFDB42F0h: 0003 9505 25C5 2A45      .word    0003h,9505h,25C5h,2A45h

FFDB4330h: 0003 9505 2585 2A85      .word    0003h,9505h,2585h,2A85h

FFDB4370h: 0003 9505 2545 2AC5      .word    0003h,9505h,2545h,2AC5h

FFDB43B0h: 0003 9505 2505 2B05      .word    0003h,9505h,2505h,2B05h

FFDB43F0h: 0003 9505 24C5 2B45      .word    0003h,9505h,24C5h,2B45h

FFDB4430h: 0003 9505 2485 2B85      .word    0003h,9505h,2485h,2B85h

FFDB4470h: 0003 9505 2445 2BC5      .word    0003h,9505h,2445h,2BC5h

FFDB44B0h: 0001 9505                .word    0001h,9505h

FFDB44D0h: 40E8                     ADD    A7,A8
FFDB44E0h: 1FE1                     BTST   0h,A1
FFDB44F0h: 1FC1                     BTST   1h,A1
FFDB4500h: 1FA1                     BTST   2h,A1
FFDB4510h: 1F81                     BTST   3h,A1
FFDB4520h: 1F61                     BTST   4h,A1
FFDB4530h: 1F41                     BTST   5h,A1
FFDB4540h: 1F21                     BTST   6h,A1
FFDB4550h: 1F01                     BTST   7h,A1
FFDB4560h: 1EE1                     BTST   8h,A1
FFDB4570h: 1EC1                     BTST   9h,A1
FFDB4580h: 1EA1                     BTST   Ah,A1
FFDB4590h: 1E81                     BTST   Bh,A1
FFDB45A0h: 1E61                     BTST   Ch,A1
FFDB45B0h: 1E41                     BTST   Dh,A1
FFDB45C0h: 1E21                     BTST   Eh,A1
FFDB45D0h: 1E01                     BTST   Fh,A1
FFDB45E0h: 1DE1                     BTST   10h,A1
FFDB45F0h: 1DC1                     BTST   11h,A1
FFDB4600h: 1DA1                     BTST   12h,A1
FFDB4610h: 1D81                     BTST   13h,A1
FFDB4620h: 1D61                     BTST   14h,A1
FFDB4630h: 1D41                     BTST   15h,A1
FFDB4640h: 1D21                     BTST   16h,A1
FFDB4650h: 1D01                     BTST   17h,A1
FFDB4660h: 1CE1                     BTST   18h,A1
FFDB4670h: 1CC1                     BTST   19h,A1
FFDB4680h: 1CA1                     BTST   1Ah,A1
FFDB4690h: 1C81                     BTST   1Bh,A1
FFDB46A0h: 1C61                     BTST   1Ch,A1
FFDB46B0h: 1C41                     BTST   1Dh,A1
FFDB46C0h: 1C21                     BTST   1Eh,A1
FFDB46D0h: 1C01                     BTST   1Fh,A1
FFDB46E0h: 1FC1                     BTST   1h,A1
FFDB46F0h: CA0C                     JREQ   FFDB47C0h
FFDB4700h: 09FA 4C80 FFDB           MOVI   FFDB4C80h,B10_COUNT
FFDB4730h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB4740h: 4E2E                     MOVE   A1,B14_TEMP
FFDB4750h: 261E                     SLL    10h,B14_TEMP
FFDB4760h: 2C9E                     SRL    1Ch,B14_TEMP
FFDB4770h: 249E                     SLL    4h,B14_TEMP
FFDB4780h: 405E                     ADD    B2_DADDR,B14_TEMP
FFDB4790h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0
FFDB47A0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB47B0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB47C0h: 1FE1                     BTST   0h,A1
FFDB47D0h: CA0A                     JREQ   FFDB4880h
FFDB47E0h: 09FA 4CB0 FFDB           MOVI   FFDB4CB0h,B10_COUNT
FFDB4810h: 4E2E                     MOVE   A1,B14_TEMP
FFDB4820h: 269E                     SLL    14h,B14_TEMP
FFDB4830h: 2C9E                     SRL    1Ch,B14_TEMP
FFDB4840h: 249E                     SLL    4h,B14_TEMP
FFDB4850h: 405E                     ADD    B2_DADDR,B14_TEMP
FFDB4860h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0
FFDB4870h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB4880h: 09FA 4CC0 FFDB           MOVI   FFDB4CC0h,B10_COUNT
FFDB48B0h: 195E                     MOVK   Ah,B14_TEMP
FFDB48C0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB48D0h: 3C5E                     DSJS   B14_TEMP,FFDB48C0h
FFDB48E0h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP
FFDB4910h: 457E                     SUB    B11_INC1,B14_TEMP
FFDB4920h: 161E                     SUBK   10h,B14_TEMP
FFDB4930h: 2F9E                     SRL    4h,B14_TEMP
FFDB4940h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0
FFDB4950h: 121A                     ADDK   10h,B10_COUNT
FFDB4960h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB4970h: 4F70                     MOVE   B11_INC1,A0
FFDB4980h: 0B00 0080                ADDI   80h,A0
FFDB49A0h: 4D78                     MOVE   B11_INC1,B8_COLOR0
FFDB49B0h: 0B18 03E0                ADDI   3E0h,B8_COLOR0
FFDB49D0h: 09DE 009F                MOVI   9Fh,B14_TEMP
FFDB49F0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB4A00h: 3C5E                     DSJS   B14_TEMP,FFDB49F0h
FFDB4A10h: 09FB 00B6 C000           MOVI   CONTROL+6,B11_INC1
FFDB4A40h: 0542                     SETF   2h,0,0
FFDB4A50h: 185A                     MOVK   2h,B10_COUNT
FFDB4A60h: 815B                     MOVE   B10_COUNT,*B11_INC1,0
FFDB4A70h: 0550                     SETF   10h,0,0
FFDB4A80h: 09F1 0001 0001           MOVI   00010001h,B1_SPTCH
FFDB4AB0h: 4E82                     MOVE   A4,B2_DADDR
FFDB4AC0h: E65E                     CPW    B2_DADDR,B14_TEMP
FFDB4AD0h: CD05                     JRNV   FFDB4B30h
FFDB4AE0h: 0B3E 5160 FFDB           ADDI   FFDB5160h,B14_TEMP
FFDB4B10h: 013E                     EXGPC  B14_TEMP
FFDB4B20h: 4E5B                     MOVE   B2_DADDR,A11
FFDB4B30h: 0960                     RETS

FFDB4B40h: 0000 0000 0000 0000 0000 .bss     20*2*8

FFDB4C80h: 4F89                     MOVE   A12,B9_COLOR1
FFDB4C90h: CA01                     JREQ   FFDB4CB0h
FFDB4CA0h: 4FC9                     MOVE   A14,B9_COLOR1
FFDB4CB0h: CB0C                     JRNE   FFDB4D80h
FFDB4CC0h: E6A1                     CPW    A5,A1
FFDB4CD0h: CC2E                     JRV    FFDB4FC0h
FFDB4CE0h: E683                     CPW    A4,A3
FFDB4CF0h: CC45                     JRV    FFDB5150h
FFDB4D00h: 4E82                     MOVE   A4,B2_DADDR
FFDB4D10h: 4EA0                     MOVE   A5,B0_SADDR
FFDB4D20h: 4C01                     MOVE   A0,A1
FFDB4D30h: 0121                     EXGPC  A1
FFDB4D40h: 4CA4                     MOVE   A5,A4
FFDB4D50h: 0D8D FFDD                DSJ    A13,FFDB4B40h
FFDB4D70h: 0960                     RETS

FFDB4D80h: E6A1                     CPW    A5,A1
FFDB4D90h: CDFA                     JRNV   FFDB4D40h
FFDB4DA0h: 4EA2                     MOVE   A5,B2_DADDR
FFDB4DB0h: E65E                     CPW    B2_DADDR,B14_TEMP
FFDB4DC0h: 411E                     ADD    B8_COLOR0,B14_TEMP
FFDB4DD0h: 013E                     EXGPC  B14_TEMP
FFDB4DE0h: 4E5B                     MOVE   B2_DADDR,A11
FFDB4DF0h: C0F4                     JR     FFDB4D40h

FFDB4E00h: E250                     SUBXY  B2_DADDR,B0_SADDR
FFDB4E10h: 577B                     CLR    B11_INC1
FFDB4E20h: 03FB                     NOT    B11_INC1
FFDB4E30h: 183A                     MOVK   1h,B10_COUNT
FFDB4E40h: 56F7                     CLR    B7_DVDX
FFDB4E50h: E217                     SUBXY  B0_SADDR,B7_DVDX
FFDB4E60h: C902                     JRNC   FFDB4E90h
FFDB4E70h: EE17                     MOVY   B0_SADDR,B7_DVDX
FFDB4E80h: 2E3B                     SRL    Fh,B11_INC1
FFDB4E90h: CD02                     JRNV   FFDB4EC0h
FFDB4EA0h: EC17                     MOVX   B0_SADDR,B7_DVDX
FFDB4EB0h: ED5B                     MOVX   B10_COUNT,B11_INC1
FFDB4EC0h: 579C                     CLR    B12_INC2
FFDB4ED0h: 4CF0                     MOVE   B7_DVDX,B0_SADDR
FFDB4EE0h: 2E10                     SRL    10h,B0_SADDR
FFDB4EF0h: E417                     CMPXY  B0_SADDR,B7_DVDX
FFDB4F00h: CC02                     JRV    FFDB4F30h
FFDB4F10h: ED7C                     MOVX   B11_INC1,B12_INC2
FFDB4F20h: C003                     JR     FFDB4F60h

FFDB4F30h: ECF0                     MOVX   B7_DVDX,B0_SADDR
FFDB4F40h: 3217                     RL     10h,B7_DVDX
FFDB4F50h: EF7C                     MOVY   B11_INC1,B12_INC2
FFDB4F60h: 4010                     ADD    B0_SADDR,B0_SADDR
FFDB4F70h: ECFA                     MOVX   B7_DVDX,B10_COUNT
FFDB4F80h: 4550                     SUB    B10_COUNT,B0_SADDR
FFDB4F90h: 103A                     INC    B10_COUNT
FFDB4FA0h: DF1A                     LINE   0
FFDB4FB0h: 0121                     EXGPC  A1
FFDB4FC0h: 4EA2                     MOVE   A5,B2_DADDR
FFDB4FD0h: E65E                     CPW    B2_DADDR,B14_TEMP
FFDB4FE0h: 411E                     ADD    B8_COLOR0,B14_TEMP
FFDB4FF0h: 013E                     EXGPC  B14_TEMP
FFDB5000h: 4F67                     MOVE   A11,B7_DVDX
FFDB5010h: 4E5B                     MOVE   B2_DADDR,A11
FFDB5020h: E683                     CPW    A4,A3
FFDB5030h: CC28                     JRV    FFDB52C0h
FFDB5040h: 4E82                     MOVE   A4,B2_DADDR
FFDB5050h: 4EA0                     MOVE   A5,B0_SADDR
FFDB5060h: 4C01                     MOVE   A0,A1
FFDB5070h: 0121                     EXGPC  A1
FFDB5080h: E65E                     CPW    B2_DADDR,B14_TEMP
FFDB5090h: 411E                     ADD    B8_COLOR0,B14_TEMP
FFDB50A0h: 013E                     EXGPC  B14_TEMP
FFDB50B0h: 4F67                     MOVE   A11,B7_DVDX
FFDB50C0h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDB50D0h: C801                     JRC    FFDB50F0h
FFDB50E0h: CD03                     JRNV   FFDB5120h
FFDB50F0h: E0F2                     ADDXY  B7_DVDX,B2_DADDR
FFDB5100h: 03F7                     NOT    B7_DVDX
FFDB5110h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB5120h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB5130h: 0FE0                     FILL   XY
FFDB5140h: C0BF                     JR     FFDB4D40h

FFDB5150h: 4EA2                     MOVE   A5,B2_DADDR
FFDB5160h: 4E80                     MOVE   A4,B0_SADDR
FFDB5170h: C0EE                     JR     FFDB5060h

FFDB5180h: ECB2                     MOVX   B5_WSTART,B2_DADDR
FFDB5190h: 013E                     EXGPC  B14_TEMP
FFDB51A0h: ECD2                     MOVX   B6_WEND,B2_DADDR
FFDB51B0h: 013E                     EXGPC  B14_TEMP
FFDB51C0h: 0300                     NOP
FFDB51D0h: 013E                     EXGPC  B14_TEMP
FFDB51E0h: EEB2                     MOVY   B5_WSTART,B2_DADDR
FFDB51F0h: 013E                     EXGPC  B14_TEMP
FFDB5200h: 4CB2                     MOVE   B5_WSTART,B2_DADDR
FFDB5210h: 013E                     EXGPC  B14_TEMP
FFDB5220h: ECD2                     MOVX   B6_WEND,B2_DADDR
FFDB5230h: EEB2                     MOVY   B5_WSTART,B2_DADDR
FFDB5240h: 013E                     EXGPC  B14_TEMP
FFDB5250h: 0300                     NOP
FFDB5260h: EED2                     MOVY   B6_WEND,B2_DADDR
FFDB5270h: 013E                     EXGPC  B14_TEMP
FFDB5280h: ECB2                     MOVX   B5_WSTART,B2_DADDR
FFDB5290h: C0FC                     JR     FFDB5260h

FFDB52A0h: 4CD2                     MOVE   B6_WEND,B2_DADDR
FFDB52B0h: 013E                     EXGPC  B14_TEMP
FFDB52C0h: 5061                     AND    A3,A1
FFDB52D0h: CBDE                     JRNE   FFDB50C0h
FFDB52E0h: 4EF3                     MOVE   B7_DVDX,A3
FFDB52F0h: 1841                     MOVK   2h,A1
FFDB5300h: D501                     EXGF   A1,0
FFDB5310h: 183C                     MOVK   1h,B12_INC2
FFDB5320h: 09FE 00B6 C000           MOVI   CONTROL+6,B14_TEMP
FFDB5350h: 819E                     MOVE   B12_INC2,*B14_TEMP,0
FFDB5360h: 4E82                     MOVE   A4,B2_DADDR
FFDB5370h: 4EA0                     MOVE   A5,B0_SADDR
FFDB5380h: E250                     SUBXY  B2_DADDR,B0_SADDR
FFDB5390h: 577B                     CLR    B11_INC1
FFDB53A0h: 03FB                     NOT    B11_INC1
FFDB53B0h: 183A                     MOVK   1h,B10_COUNT
FFDB53C0h: 56F7                     CLR    B7_DVDX
FFDB53D0h: E217                     SUBXY  B0_SADDR,B7_DVDX
FFDB53E0h: C902                     JRNC   FFDB5410h
FFDB53F0h: EE17                     MOVY   B0_SADDR,B7_DVDX
FFDB5400h: 2E3B                     SRL    Fh,B11_INC1
FFDB5410h: CD02                     JRNV   FFDB5440h
FFDB5420h: EC17                     MOVX   B0_SADDR,B7_DVDX
FFDB5430h: ED5B                     MOVX   B10_COUNT,B11_INC1
FFDB5440h: 579C                     CLR    B12_INC2
FFDB5450h: 4CF0                     MOVE   B7_DVDX,B0_SADDR
FFDB5460h: 2E10                     SRL    10h,B0_SADDR
FFDB5470h: E417                     CMPXY  B0_SADDR,B7_DVDX
FFDB5480h: CC02                     JRV    FFDB54B0h
FFDB5490h: ED7C                     MOVX   B11_INC1,B12_INC2
FFDB54A0h: C003                     JR     FFDB54E0h

FFDB54B0h: ECF0                     MOVX   B7_DVDX,B0_SADDR
FFDB54C0h: 3217                     RL     10h,B7_DVDX
FFDB54D0h: EF7C                     MOVY   B11_INC1,B12_INC2
FFDB54E0h: 4010                     ADD    B0_SADDR,B0_SADDR
FFDB54F0h: ECFA                     MOVX   B7_DVDX,B10_COUNT
FFDB5500h: 4550                     SUB    B10_COUNT,B0_SADDR
FFDB5510h: 103A                     INC    B10_COUNT
FFDB5520h: DF1A                     LINE   0
FFDB5530h: 185C                     MOVK   2h,B12_INC2
FFDB5540h: 09FE 00B6 C000           MOVI   CONTROL+6,B14_TEMP
FFDB5570h: 819E                     MOVE   B12_INC2,*B14_TEMP,0
FFDB5580h: D501                     EXGF   A1,0
FFDB5590h: CD12                     JRNV   FFDB56C0h
FFDB55A0h: 4F62                     MOVE   A11,B2_DADDR
FFDB55B0h: 4E8C                     MOVE   A4,B12_INC2
FFDB55C0h: E79E                     CPW    B12_INC2,B14_TEMP
FFDB55D0h: 411E                     ADD    B8_COLOR0,B14_TEMP
FFDB55E0h: 013E                     EXGPC  B14_TEMP
FFDB55F0h: 4E51                     MOVE   B2_DADDR,A1
FFDB5600h: 4F67                     MOVE   A11,B7_DVDX
FFDB5610h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDB5620h: C801                     JRC    FFDB5640h
FFDB5630h: CD03                     JRNV   FFDB5670h
FFDB5640h: E0F2                     ADDXY  B7_DVDX,B2_DADDR
FFDB5650h: 03F7                     NOT    B7_DVDX
FFDB5660h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB5670h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB5680h: 0FE0                     FILL   XY
FFDB5690h: 4E27                     MOVE   A1,B7_DVDX
FFDB56A0h: 4E62                     MOVE   A3,B2_DADDR
FFDB56B0h: C0A0                     JR     FFDB50C0h

FFDB56C0h: 4E54                     MOVE   B2_DADDR,A4
FFDB56D0h: 4E67                     MOVE   A3,B7_DVDX
FFDB56E0h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDB56F0h: C801                     JRC    FFDB5710h
FFDB5700h: CD03                     JRNV   FFDB5740h
FFDB5710h: E0F2                     ADDXY  B7_DVDX,B2_DADDR
FFDB5720h: 03F7                     NOT    B7_DVDX
FFDB5730h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB5740h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB5750h: 0FE0                     FILL   XY
FFDB5760h: C08D                     JR     FFDB5040h

FFDB5770h: 1FC1                     BTST   1h,A1
FFDB5780h: CA0C                     JREQ   FFDB5850h
FFDB5790h: 09FA 5D10 FFDB           MOVI   FFDB5D10h,B10_COUNT
FFDB57C0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB57D0h: 4E2E                     MOVE   A1,B14_TEMP
FFDB57E0h: 261E                     SLL    10h,B14_TEMP
FFDB57F0h: 2C9E                     SRL    1Ch,B14_TEMP
FFDB5800h: 249E                     SLL    4h,B14_TEMP
FFDB5810h: 405E                     ADD    B2_DADDR,B14_TEMP
FFDB5820h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0
FFDB5830h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB5840h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB5850h: 1FE1                     BTST   0h,A1
FFDB5860h: CA0A                     JREQ   FFDB5910h
FFDB5870h: 09FA 5D40 FFDB           MOVI   FFDB5D40h,B10_COUNT
FFDB58A0h: 4E2E                     MOVE   A1,B14_TEMP
FFDB58B0h: 269E                     SLL    14h,B14_TEMP
FFDB58C0h: 2C9E                     SRL    1Ch,B14_TEMP
FFDB58D0h: 249E                     SLL    4h,B14_TEMP
FFDB58E0h: 405E                     ADD    B2_DADDR,B14_TEMP
FFDB58F0h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0
FFDB5900h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB5910h: 09FA 5D50 FFDB           MOVI   FFDB5D50h,B10_COUNT
FFDB5940h: 195E                     MOVK   Ah,B14_TEMP
FFDB5950h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB5960h: 3C5E                     DSJS   B14_TEMP,FFDB5950h
FFDB5970h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP
FFDB59A0h: 457E                     SUB    B11_INC1,B14_TEMP
FFDB59B0h: 161E                     SUBK   10h,B14_TEMP
FFDB59C0h: 2F9E                     SRL    4h,B14_TEMP
FFDB59D0h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0
FFDB59E0h: 121A                     ADDK   10h,B10_COUNT
FFDB59F0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB5A00h: 4F70                     MOVE   B11_INC1,A0
FFDB5A10h: 0B00 0080                ADDI   80h,A0
FFDB5A30h: 4D78                     MOVE   B11_INC1,B8_COLOR0
FFDB5A40h: 0B18 0490                ADDI   490h,B8_COLOR0
FFDB5A60h: 09DE 00B4                MOVI   B4h,B14_TEMP
FFDB5A80h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB5A90h: 3C5E                     DSJS   B14_TEMP,FFDB5A80h
FFDB5AA0h: 09FB 00B6 C000           MOVI   CONTROL+6,B11_INC1
FFDB5AD0h: 0542                     SETF   2h,0,0
FFDB5AE0h: 185A                     MOVK   2h,B10_COUNT
FFDB5AF0h: 815B                     MOVE   B10_COUNT,*B11_INC1,0
FFDB5B00h: 0550                     SETF   10h,0,0
FFDB5B10h: 09F1 0001 0001           MOVI   00010001h,B1_SPTCH
FFDB5B40h: 4E82                     MOVE   A4,B2_DADDR
FFDB5B50h: E65E                     CPW    B2_DADDR,B14_TEMP
FFDB5B60h: CD05                     JRNV   FFDB5BC0h
FFDB5B70h: 0B3E 62A0 FFDB           ADDI   FFDB62A0h,B14_TEMP
FFDB5BA0h: 013E                     EXGPC  B14_TEMP
FFDB5BB0h: 4E5B                     MOVE   B2_DADDR,A11
FFDB5BC0h: 0960                     RETS

FFDB5BD0h: 0000 0000 0000 0000 0000 .bss     20*2*8

FFDB5D10h: 4F89                     MOVE   A12,B9_COLOR1
FFDB5D20h: CA01                     JREQ   FFDB5D40h
FFDB5D30h: 4FC9                     MOVE   A14,B9_COLOR1
FFDB5D40h: CB0C                     JRNE   FFDB5E10h
FFDB5D50h: E6A1                     CPW    A5,A1
FFDB5D60h: CC37                     JRV    FFDB60E0h
FFDB5D70h: E683                     CPW    A4,A3
FFDB5D80h: CC50                     JRV    FFDB6290h
FFDB5D90h: 4E82                     MOVE   A4,B2_DADDR
FFDB5DA0h: 4EA0                     MOVE   A5,B0_SADDR
FFDB5DB0h: 4C01                     MOVE   A0,A1
FFDB5DC0h: 0121                     EXGPC  A1
FFDB5DD0h: 4CA4                     MOVE   A5,A4
FFDB5DE0h: 0D8D FFDD                DSJ    A13,FFDB5BD0h
FFDB5E00h: 0960                     RETS

FFDB5E10h: E6A1                     CPW    A5,A1
FFDB5E20h: CDFA                     JRNV   FFDB5DD0h
FFDB5E30h: 4EA2                     MOVE   A5,B2_DADDR
FFDB5E40h: E65E                     CPW    B2_DADDR,B14_TEMP
FFDB5E50h: 411E                     ADD    B8_COLOR0,B14_TEMP
FFDB5E60h: 013E                     EXGPC  B14_TEMP
FFDB5E70h: 4E5B                     MOVE   B2_DADDR,A11
FFDB5E80h: C0F4                     JR     FFDB5DD0h

FFDB5E90h: E250                     SUBXY  B2_DADDR,B0_SADDR
FFDB5EA0h: 577B                     CLR    B11_INC1
FFDB5EB0h: 03FB                     NOT    B11_INC1
FFDB5EC0h: 183A                     MOVK   1h,B10_COUNT
FFDB5ED0h: 56F7                     CLR    B7_DVDX
FFDB5EE0h: E217                     SUBXY  B0_SADDR,B7_DVDX
FFDB5EF0h: C902                     JRNC   FFDB5F20h
FFDB5F00h: EE17                     MOVY   B0_SADDR,B7_DVDX
FFDB5F10h: 2E3B                     SRL    Fh,B11_INC1
FFDB5F20h: CD02                     JRNV   FFDB5F50h
FFDB5F30h: EC17                     MOVX   B0_SADDR,B7_DVDX
FFDB5F40h: ED5B                     MOVX   B10_COUNT,B11_INC1
FFDB5F50h: 579C                     CLR    B12_INC2
FFDB5F60h: 4CF0                     MOVE   B7_DVDX,B0_SADDR
FFDB5F70h: 2E10                     SRL    10h,B0_SADDR
FFDB5F80h: E417                     CMPXY  B0_SADDR,B7_DVDX
FFDB5F90h: CC02                     JRV    FFDB5FC0h
FFDB5FA0h: ED7C                     MOVX   B11_INC1,B12_INC2
FFDB5FB0h: C003                     JR     FFDB5FF0h

FFDB5FC0h: ECF0                     MOVX   B7_DVDX,B0_SADDR
FFDB5FD0h: 3217                     RL     10h,B7_DVDX
FFDB5FE0h: EF7C                     MOVY   B11_INC1,B12_INC2
FFDB5FF0h: 4010                     ADD    B0_SADDR,B0_SADDR
FFDB6000h: ECFA                     MOVX   B7_DVDX,B10_COUNT
FFDB6010h: 4550                     SUB    B10_COUNT,B0_SADDR
FFDB6020h: 103A                     INC    B10_COUNT
FFDB6030h: 4E54                     MOVE   B2_DADDR,A4
FFDB6040h: 4E13                     MOVE   B0_SADDR,A3
FFDB6050h: DF1A                     LINE   0
FFDB6060h: 4E82                     MOVE   A4,B2_DADDR
FFDB6070h: 4E60                     MOVE   A3,B0_SADDR
FFDB6080h: 183A                     MOVK   1h,B10_COUNT
FFDB6090h: E152                     ADDXY  B10_COUNT,B2_DADDR
FFDB60A0h: ECFA                     MOVX   B7_DVDX,B10_COUNT
FFDB60B0h: 103A                     INC    B10_COUNT
FFDB60C0h: DF1A                     LINE   0
FFDB60D0h: 0121                     EXGPC  A1
FFDB60E0h: 4EA2                     MOVE   A5,B2_DADDR
FFDB60F0h: E65E                     CPW    B2_DADDR,B14_TEMP
FFDB6100h: 411E                     ADD    B8_COLOR0,B14_TEMP
FFDB6110h: 013E                     EXGPC  B14_TEMP
FFDB6120h: 4F67                     MOVE   A11,B7_DVDX
FFDB6130h: 4E5B                     MOVE   B2_DADDR,A11
FFDB6140h: E683                     CPW    A4,A3
FFDB6150h: CC2C                     JRV    FFDB6420h
FFDB6160h: 4E82                     MOVE   A4,B2_DADDR
FFDB6170h: 4EA0                     MOVE   A5,B0_SADDR
FFDB6180h: 4C01                     MOVE   A0,A1
FFDB6190h: 0121                     EXGPC  A1
FFDB61A0h: E65E                     CPW    B2_DADDR,B14_TEMP
FFDB61B0h: 411E                     ADD    B8_COLOR0,B14_TEMP
FFDB61C0h: 013E                     EXGPC  B14_TEMP
FFDB61D0h: 4F67                     MOVE   A11,B7_DVDX
FFDB61E0h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDB61F0h: C801                     JRC    FFDB6210h
FFDB6200h: CD03                     JRNV   FFDB6240h
FFDB6210h: E0F2                     ADDXY  B7_DVDX,B2_DADDR
FFDB6220h: 03F7                     NOT    B7_DVDX
FFDB6230h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB6240h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB6250h: 183E                     MOVK   1h,B14_TEMP
FFDB6260h: E1D7                     ADDXY  B14_TEMP,B7_DVDX
FFDB6270h: 0FE0                     FILL   XY
FFDB6280h: C0B4                     JR     FFDB5DD0h

FFDB6290h: 4EA2                     MOVE   A5,B2_DADDR
FFDB62A0h: 4E80                     MOVE   A4,B0_SADDR
FFDB62B0h: C0EC                     JR     FFDB6180h

FFDB62C0h: ECB2                     MOVX   B5_WSTART,B2_DADDR
FFDB62D0h: 013E                     EXGPC  B14_TEMP
FFDB62E0h: ECD2                     MOVX   B6_WEND,B2_DADDR
FFDB62F0h: C00F                     JR     FFDB63F0h

FFDB6300h: 0300                     NOP
FFDB6310h: 013E                     EXGPC  B14_TEMP
FFDB6320h: EEB2                     MOVY   B5_WSTART,B2_DADDR
FFDB6330h: 013E                     EXGPC  B14_TEMP
FFDB6340h: 4CB2                     MOVE   B5_WSTART,B2_DADDR
FFDB6350h: 013E                     EXGPC  B14_TEMP
FFDB6360h: ECD2                     MOVX   B6_WEND,B2_DADDR
FFDB6370h: EEB2                     MOVY   B5_WSTART,B2_DADDR
FFDB6380h: C006                     JR     FFDB63F0h

FFDB6390h: 0300                     NOP
FFDB63A0h: EED2                     MOVY   B6_WEND,B2_DADDR
FFDB63B0h: 013E                     EXGPC  B14_TEMP
FFDB63C0h: ECB2                     MOVX   B5_WSTART,B2_DADDR
FFDB63D0h: C0FC                     JR     FFDB63A0h

FFDB63E0h: 4CD2                     MOVE   B6_WEND,B2_DADDR
FFDB63F0h: 183C                     MOVK   1h,B12_INC2
FFDB6400h: E392                     SUBXY  B12_INC2,B2_DADDR
FFDB6410h: 013E                     EXGPC  B14_TEMP
FFDB6420h: 5061                     AND    A3,A1
FFDB6430h: CBDA                     JRNE   FFDB61E0h
FFDB6440h: 4EF3                     MOVE   B7_DVDX,A3
FFDB6450h: 1841                     MOVK   2h,A1
FFDB6460h: D501                     EXGF   A1,0
FFDB6470h: 183C                     MOVK   1h,B12_INC2
FFDB6480h: 09FE 00B6 C000           MOVI   CONTROL+6,B14_TEMP
FFDB64B0h: 819E                     MOVE   B12_INC2,*B14_TEMP,0
FFDB64C0h: 4E82                     MOVE   A4,B2_DADDR
FFDB64D0h: 4EA0                     MOVE   A5,B0_SADDR
FFDB64E0h: E250                     SUBXY  B2_DADDR,B0_SADDR
FFDB64F0h: 577B                     CLR    B11_INC1
FFDB6500h: 03FB                     NOT    B11_INC1
FFDB6510h: 183A                     MOVK   1h,B10_COUNT
FFDB6520h: 56F7                     CLR    B7_DVDX
FFDB6530h: E217                     SUBXY  B0_SADDR,B7_DVDX
FFDB6540h: C902                     JRNC   FFDB6570h
FFDB6550h: EE17                     MOVY   B0_SADDR,B7_DVDX
FFDB6560h: 2E3B                     SRL    Fh,B11_INC1
FFDB6570h: CD02                     JRNV   FFDB65A0h
FFDB6580h: EC17                     MOVX   B0_SADDR,B7_DVDX
FFDB6590h: ED5B                     MOVX   B10_COUNT,B11_INC1
FFDB65A0h: 579C                     CLR    B12_INC2
FFDB65B0h: 4CF0                     MOVE   B7_DVDX,B0_SADDR
FFDB65C0h: 2E10                     SRL    10h,B0_SADDR
FFDB65D0h: E417                     CMPXY  B0_SADDR,B7_DVDX
FFDB65E0h: CC02                     JRV    FFDB6610h
FFDB65F0h: ED7C                     MOVX   B11_INC1,B12_INC2
FFDB6600h: C003                     JR     FFDB6640h

FFDB6610h: ECF0                     MOVX   B7_DVDX,B0_SADDR
FFDB6620h: 3217                     RL     10h,B7_DVDX
FFDB6630h: EF7C                     MOVY   B11_INC1,B12_INC2
FFDB6640h: 4010                     ADD    B0_SADDR,B0_SADDR
FFDB6650h: ECFA                     MOVX   B7_DVDX,B10_COUNT
FFDB6660h: 4550                     SUB    B10_COUNT,B0_SADDR
FFDB6670h: 103A                     INC    B10_COUNT
FFDB6680h: DF1A                     LINE   0
FFDB6690h: 185C                     MOVK   2h,B12_INC2
FFDB66A0h: 09FE 00B6 C000           MOVI   CONTROL+6,B14_TEMP
FFDB66D0h: 819E                     MOVE   B12_INC2,*B14_TEMP,0
FFDB66E0h: D501                     EXGF   A1,0
FFDB66F0h: CD14                     JRNV   FFDB6840h
FFDB6700h: 4F62                     MOVE   A11,B2_DADDR
FFDB6710h: 4E8C                     MOVE   A4,B12_INC2
FFDB6720h: E79E                     CPW    B12_INC2,B14_TEMP
FFDB6730h: 411E                     ADD    B8_COLOR0,B14_TEMP
FFDB6740h: 013E                     EXGPC  B14_TEMP
FFDB6750h: 4E51                     MOVE   B2_DADDR,A1
FFDB6760h: 4F67                     MOVE   A11,B7_DVDX
FFDB6770h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDB6780h: C801                     JRC    FFDB67A0h
FFDB6790h: CD03                     JRNV   FFDB67D0h
FFDB67A0h: E0F2                     ADDXY  B7_DVDX,B2_DADDR
FFDB67B0h: 03F7                     NOT    B7_DVDX
FFDB67C0h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB67D0h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB67E0h: 183E                     MOVK   1h,B14_TEMP
FFDB67F0h: E1D7                     ADDXY  B14_TEMP,B7_DVDX
FFDB6800h: 0FE0                     FILL   XY
FFDB6810h: 4E27                     MOVE   A1,B7_DVDX
FFDB6820h: 4E62                     MOVE   A3,B2_DADDR
FFDB6830h: C09A                     JR     FFDB61E0h

FFDB6840h: E456                     CMPXY  B2_DADDR,B6_WEND
FFDB6850h: CF02                     JRNN   FFDB6880h
FFDB6860h: 183E                     MOVK   1h,B14_TEMP
FFDB6870h: E3D2                     SUBXY  B14_TEMP,B2_DADDR
FFDB6880h: 4E54                     MOVE   B2_DADDR,A4
FFDB6890h: 4E67                     MOVE   A3,B7_DVDX
FFDB68A0h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDB68B0h: C801                     JRC    FFDB68D0h
FFDB68C0h: CD03                     JRNV   FFDB6900h
FFDB68D0h: E0F2                     ADDXY  B7_DVDX,B2_DADDR
FFDB68E0h: 03F7                     NOT    B7_DVDX
FFDB68F0h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB6900h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB6910h: 183E                     MOVK   1h,B14_TEMP
FFDB6920h: E1D7                     ADDXY  B14_TEMP,B7_DVDX
FFDB6930h: 0FE0                     FILL   XY
FFDB6940h: C081                     JR     FFDB6160h

FFDB6950h: 1FC1                     BTST   1h,A1
FFDB6960h: CA0C                     JREQ   FFDB6A30h
FFDB6970h: 09FA 6D20 FFDB           MOVI   FFDB6D20h,B10_COUNT
FFDB69A0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB69B0h: 4E2E                     MOVE   A1,B14_TEMP
FFDB69C0h: 261E                     SLL    10h,B14_TEMP
FFDB69D0h: 2C9E                     SRL    1Ch,B14_TEMP
FFDB69E0h: 249E                     SLL    4h,B14_TEMP
FFDB69F0h: 405E                     ADD    B2_DADDR,B14_TEMP
FFDB6A00h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0
FFDB6A10h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB6A20h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB6A30h: 1FE1                     BTST   0h,A1
FFDB6A40h: CA0A                     JREQ   FFDB6AF0h
FFDB6A50h: 09FA 6D50 FFDB           MOVI   FFDB6D50h,B10_COUNT
FFDB6A80h: 4E2E                     MOVE   A1,B14_TEMP
FFDB6A90h: 269E                     SLL    14h,B14_TEMP
FFDB6AA0h: 2C9E                     SRL    1Ch,B14_TEMP
FFDB6AB0h: 249E                     SLL    4h,B14_TEMP
FFDB6AC0h: 405E                     ADD    B2_DADDR,B14_TEMP
FFDB6AD0h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0
FFDB6AE0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB6AF0h: 09FA 6D60 FFDB           MOVI   FFDB6D60h,B10_COUNT
FFDB6B20h: 09DE 0029                MOVI   29h,B14_TEMP
FFDB6B40h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB6B50h: 3C5E                     DSJS   B14_TEMP,FFDB6B40h
FFDB6B60h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP
FFDB6B90h: 457E                     SUB    B11_INC1,B14_TEMP
FFDB6BA0h: 161E                     SUBK   10h,B14_TEMP
FFDB6BB0h: 2F9E                     SRL    4h,B14_TEMP
FFDB6BC0h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0
FFDB6BD0h: 121A                     ADDK   10h,B10_COUNT
FFDB6BE0h: 09DE 002E                MOVI   2Eh,B14_TEMP
FFDB6C00h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB6C10h: 3C5E                     DSJS   B14_TEMP,FFDB6C00h
FFDB6C20h: 1D61                     BTST   14h,A1
FFDB6C30h: CA02                     JREQ   FFDB6C60h
FFDB6C40h: 141B                     SUBK   20h,B11_INC1
FFDB6C50h: 895B                     MOVE   *B10_COUNT,*B11_INC1,0
FFDB6C60h: 4C80                     MOVE   A4,A0
FFDB6C70h: 4C83                     MOVE   A4,A3
FFDB6C80h: 09EB 0000 0001           MOVI   00010000h,A11
FFDB6CB0h: 09F1 0001 0001           MOVI   00010001h,B1_SPTCH
FFDB6CE0h: 059E 0C80 FFEC           MOVE   B14_TEMP,@FFEC0C80h,0
FFDB6D10h: 0960                     RETS

FFDB6D20h: 4F89                     MOVE   A12,B9_COLOR1
FFDB6D30h: CA01                     JREQ   FFDB6D50h
FFDB6D40h: 4FC9                     MOVE   A14,B9_COLOR1
FFDB6D50h: CB38                     JRNE   FFDB70E0h
FFDB6D60h: E485                     CMPXY  A4,A5
FFDB6D70h: CA46                     JREQ   FFDB71E0h
FFDB6D80h: CE3C                     JRN    FFDB7150h
FFDB6D90h: C90F                     JRNC   FFDB6E90h
FFDB6DA0h: 4E67                     MOVE   A3,B7_DVDX
FFDB6DB0h: 4C83                     MOVE   A4,A3
FFDB6DC0h: E2A3                     SUBXY  A5,A3
FFDB6DD0h: E163                     ADDXY  A11,A3
FFDB6DE0h: 2FE3                     SRL    1h,A3
FFDB6DF0h: E0A3                     ADDXY  A5,A3
FFDB6E00h: ECA3                     MOVX   A5,A3
FFDB6E10h: 4C61                     MOVE   A3,A1
FFDB6E20h: E161                     ADDXY  A11,A1
FFDB6E30h: E401                     CMPXY  A0,A1
FFDB6E40h: C901                     JRNC   FFDB6E60h
FFDB6E50h: EE20                     MOVY   A1,A0
FFDB6E60h: 4E02                     MOVE   A0,B2_DADDR
FFDB6E70h: 4CA0                     MOVE   A5,A0
FFDB6E80h: C00E                     JR     FFDB6F70h

FFDB6E90h: 4E02                     MOVE   A0,B2_DADDR
FFDB6EA0h: 4CA0                     MOVE   A5,A0
FFDB6EB0h: E280                     SUBXY  A4,A0
FFDB6EC0h: E160                     ADDXY  A11,A0
FFDB6ED0h: 2FE0                     SRL    1h,A0
FFDB6EE0h: E080                     ADDXY  A4,A0
FFDB6EF0h: ECA0                     MOVX   A5,A0
FFDB6F00h: 4C01                     MOVE   A0,A1
FFDB6F10h: E361                     SUBXY  A11,A1
FFDB6F20h: E423                     CMPXY  A1,A3
FFDB6F30h: C901                     JRNC   FFDB6F50h
FFDB6F40h: EE23                     MOVY   A1,A3
FFDB6F50h: 4E67                     MOVE   A3,B7_DVDX
FFDB6F60h: 4CA3                     MOVE   A5,A3
FFDB6F70h: E65E                     CPW    B2_DADDR,B14_TEMP
FFDB6F80h: CC29                     JRV    FFDB7220h
FFDB6F90h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDB6FA0h: CA2E                     JREQ   FFDB7290h
FFDB6FB0h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB6FC0h: 0FE0                     FILL   XY
FFDB6FD0h: 4CA4                     MOVE   A5,A4
FFDB6FE0h: 0D8D FFD2                DSJ    A13,FFDB6D20h
FFDB7000h: 05A1 0C80 FFEC           MOVE   @FFEC0C80h,A1,0
FFDB7030h: CB09                     JRNE   FFDB70D0h
FFDB7040h: 1821                     MOVK   1h,A1
FFDB7050h: 0581 0C80 FFEC           MOVE   A1,@FFEC0C80h,0
FFDB7080h: 184D                     MOVK   2h,A13
FFDB7090h: 1608                     SUBK   10h,A8
FFDB70A0h: 44E8                     SUB    A7,A8
FFDB70B0h: E224                     SUBXY  A1,A4
FFDB70C0h: C0F0                     JR     FFDB6FD0h

FFDB70D0h: 0960                     RETS

FFDB70E0h: E485                     CMPXY  A4,A5
FFDB70F0h: CEED                     JRN    FFDB6FD0h
FFDB7100h: E403                     CMPXY  A0,A3
FFDB7110h: CB0D                     JRNE   FFDB71F0h
FFDB7120h: 4CA0                     MOVE   A5,A0
FFDB7130h: 4CA3                     MOVE   A5,A3
FFDB7140h: C0E8                     JR     FFDB6FD0h

FFDB7150h: C904                     JRNC   FFDB71A0h
FFDB7160h: E405                     CMPXY  A0,A5
FFDB7170h: C9E5                     JRNC   FFDB6FD0h
FFDB7180h: 4CA0                     MOVE   A5,A0
FFDB7190h: C0E3                     JR     FFDB6FD0h

FFDB71A0h: E4A3                     CMPXY  A5,A3
FFDB71B0h: C9E1                     JRNC   FFDB6FD0h
FFDB71C0h: 4CA3                     MOVE   A5,A3
FFDB71D0h: C0DF                     JR     FFDB6FD0h

FFDB71E0h: CEDE                     JRN    FFDB6FD0h
FFDB71F0h: 4E02                     MOVE   A0,B2_DADDR
FFDB7200h: 4CA0                     MOVE   A5,A0
FFDB7210h: C0D3                     JR     FFDB6F50h

FFDB7220h: E6FC                     CPW    B7_DVDX,B12_INC2
FFDB7230h: CDD5                     JRNV   FFDB6F90h
FFDB7240h: 519E                     AND    B12_INC2,B14_TEMP
FFDB7250h: CAD3                     JREQ   FFDB6F90h
FFDB7260h: 1F1E                     BTST   7h,B14_TEMP
FFDB7270h: CB03                     JRNE   FFDB72B0h
FFDB7280h: EED2                     MOVY   B6_WEND,B2_DADDR
FFDB7290h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY
FFDB72A0h: C0D2                     JR     FFDB6FD0h

FFDB72B0h: EEB2                     MOVY   B5_WSTART,B2_DADDR
FFDB72C0h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY
FFDB72D0h: C0CF                     JR     FFDB6FD0h

FFDB72E0h: 0300                     NOP
FFDB72F0h: 1FC1                     BTST   1h,A1
FFDB7300h: CA0C                     JREQ   FFDB73D0h
FFDB7310h: 09FA 76F0 FFDB           MOVI   FFDB76F0h,B10_COUNT
FFDB7340h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB7350h: 4E2E                     MOVE   A1,B14_TEMP
FFDB7360h: 261E                     SLL    10h,B14_TEMP
FFDB7370h: 2C9E                     SRL    1Ch,B14_TEMP
FFDB7380h: 249E                     SLL    4h,B14_TEMP
FFDB7390h: 405E                     ADD    B2_DADDR,B14_TEMP
FFDB73A0h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0
FFDB73B0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB73C0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB73D0h: 1FE1                     BTST   0h,A1
FFDB73E0h: CA0A                     JREQ   FFDB7490h
FFDB73F0h: 09FA 7720 FFDB           MOVI   FFDB7720h,B10_COUNT
FFDB7420h: 4E2E                     MOVE   A1,B14_TEMP
FFDB7430h: 269E                     SLL    14h,B14_TEMP
FFDB7440h: 2C9E                     SRL    1Ch,B14_TEMP
FFDB7450h: 249E                     SLL    4h,B14_TEMP
FFDB7460h: 405E                     ADD    B2_DADDR,B14_TEMP
FFDB7470h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0
FFDB7480h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB7490h: 09FA 7730 FFDB           MOVI   FFDB7730h,B10_COUNT
FFDB74C0h: 09DE 002A                MOVI   2Ah,B14_TEMP
FFDB74E0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB74F0h: 3C5E                     DSJS   B14_TEMP,FFDB74E0h
FFDB7500h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP
FFDB7530h: 457E                     SUB    B11_INC1,B14_TEMP
FFDB7540h: 161E                     SUBK   10h,B14_TEMP
FFDB7550h: 2F9E                     SRL    4h,B14_TEMP
FFDB7560h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0
FFDB7570h: 121A                     ADDK   10h,B10_COUNT
FFDB7580h: 09DE 0032                MOVI   32h,B14_TEMP
FFDB75A0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB75B0h: 3C5E                     DSJS   B14_TEMP,FFDB75A0h
FFDB75C0h: 1D61                     BTST   14h,A1
FFDB75D0h: CA04                     JREQ   FFDB7620h
FFDB75E0h: 0BFB FFCF                SUBI   30h,B11_INC1
FFDB7600h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB7610h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB7620h: 4C80                     MOVE   A4,A0
FFDB7630h: 4C83                     MOVE   A4,A3
FFDB7640h: 09EB 0000 0001           MOVI   00010000h,A11
FFDB7670h: 09F1 0001 0001           MOVI   00010001h,B1_SPTCH
FFDB76A0h: 1830                     MOVK   1h,B0_SADDR
FFDB76B0h: 059E 0C80 FFEC           MOVE   B14_TEMP,@FFEC0C80h,0
FFDB76E0h: 0960                     RETS

FFDB76F0h: 4F89                     MOVE   A12,B9_COLOR1
FFDB7700h: CA01                     JREQ   FFDB7720h
FFDB7710h: 4FC9                     MOVE   A14,B9_COLOR1
FFDB7720h: CB39                     JRNE   FFDB7AC0h
FFDB7730h: E485                     CMPXY  A4,A5
FFDB7740h: CA47                     JREQ   FFDB7BC0h
FFDB7750h: CE3D                     JRN    FFDB7B30h
FFDB7760h: C90F                     JRNC   FFDB7860h
FFDB7770h: 4E67                     MOVE   A3,B7_DVDX
FFDB7780h: 4C83                     MOVE   A4,A3
FFDB7790h: E2A3                     SUBXY  A5,A3
FFDB77A0h: E163                     ADDXY  A11,A3
FFDB77B0h: 2FE3                     SRL    1h,A3
FFDB77C0h: E0A3                     ADDXY  A5,A3
FFDB77D0h: ECA3                     MOVX   A5,A3
FFDB77E0h: 4C61                     MOVE   A3,A1
FFDB77F0h: E161                     ADDXY  A11,A1
FFDB7800h: E401                     CMPXY  A0,A1
FFDB7810h: C901                     JRNC   FFDB7830h
FFDB7820h: EE20                     MOVY   A1,A0
FFDB7830h: 4E02                     MOVE   A0,B2_DADDR
FFDB7840h: 4CA0                     MOVE   A5,A0
FFDB7850h: C00E                     JR     FFDB7940h

FFDB7860h: 4E02                     MOVE   A0,B2_DADDR
FFDB7870h: 4CA0                     MOVE   A5,A0
FFDB7880h: E280                     SUBXY  A4,A0
FFDB7890h: E160                     ADDXY  A11,A0
FFDB78A0h: 2FE0                     SRL    1h,A0
FFDB78B0h: E080                     ADDXY  A4,A0
FFDB78C0h: ECA0                     MOVX   A5,A0
FFDB78D0h: 4C01                     MOVE   A0,A1
FFDB78E0h: E361                     SUBXY  A11,A1
FFDB78F0h: E423                     CMPXY  A1,A3
FFDB7900h: C901                     JRNC   FFDB7920h
FFDB7910h: EE23                     MOVY   A1,A3
FFDB7920h: 4E67                     MOVE   A3,B7_DVDX
FFDB7930h: 4CA3                     MOVE   A5,A3
FFDB7940h: E65E                     CPW    B2_DADDR,B14_TEMP
FFDB7950h: CC2A                     JRV    FFDB7C00h
FFDB7960h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDB7970h: CA31                     JREQ   FFDB7C90h
FFDB7980h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB7990h: E017                     ADDXY  B0_SADDR,B7_DVDX
FFDB79A0h: 0FE0                     FILL   XY
FFDB79B0h: 4CA4                     MOVE   A5,A4
FFDB79C0h: 0D8D FFD1                DSJ    A13,FFDB76F0h
FFDB79E0h: 05A1 0C80 FFEC           MOVE   @FFEC0C80h,A1,0
FFDB7A10h: CB09                     JRNE   FFDB7AB0h
FFDB7A20h: 1821                     MOVK   1h,A1
FFDB7A30h: 0581 0C80 FFEC           MOVE   A1,@FFEC0C80h,0
FFDB7A60h: 184D                     MOVK   2h,A13
FFDB7A70h: 1608                     SUBK   10h,A8
FFDB7A80h: 44E8                     SUB    A7,A8
FFDB7A90h: E224                     SUBXY  A1,A4
FFDB7AA0h: C0F0                     JR     FFDB79B0h

FFDB7AB0h: 0960                     RETS

FFDB7AC0h: E485                     CMPXY  A4,A5
FFDB7AD0h: CEED                     JRN    FFDB79B0h
FFDB7AE0h: E403                     CMPXY  A0,A3
FFDB7AF0h: CB0D                     JRNE   FFDB7BD0h
FFDB7B00h: 4CA0                     MOVE   A5,A0
FFDB7B10h: 4CA3                     MOVE   A5,A3
FFDB7B20h: C0E8                     JR     FFDB79B0h

FFDB7B30h: C904                     JRNC   FFDB7B80h
FFDB7B40h: E405                     CMPXY  A0,A5
FFDB7B50h: C9E5                     JRNC   FFDB79B0h
FFDB7B60h: 4CA0                     MOVE   A5,A0
FFDB7B70h: C0E3                     JR     FFDB79B0h

FFDB7B80h: E4A3                     CMPXY  A5,A3
FFDB7B90h: C9E1                     JRNC   FFDB79B0h
FFDB7BA0h: 4CA3                     MOVE   A5,A3
FFDB7BB0h: C0DF                     JR     FFDB79B0h

FFDB7BC0h: CEDE                     JRN    FFDB79B0h
FFDB7BD0h: 4E02                     MOVE   A0,B2_DADDR
FFDB7BE0h: 4CA0                     MOVE   A5,A0
FFDB7BF0h: C0D2                     JR     FFDB7920h

FFDB7C00h: E6FC                     CPW    B7_DVDX,B12_INC2
FFDB7C10h: CDD4                     JRNV   FFDB7960h
FFDB7C20h: 519E                     AND    B12_INC2,B14_TEMP
FFDB7C30h: CAD2                     JREQ   FFDB7960h
FFDB7C40h: 1F5E                     BTST   5h,B14_TEMP
FFDB7C50h: CBD5                     JRNE   FFDB79B0h
FFDB7C60h: 1F1E                     BTST   7h,B14_TEMP
FFDB7C70h: CB04                     JRNE   FFDB7CC0h
FFDB7C80h: EED2                     MOVY   B6_WEND,B2_DADDR
FFDB7C90h: F612                     DRAV   B0_SADDR,B2_DADDR
FFDB7CA0h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY
FFDB7CB0h: C0CF                     JR     FFDB79B0h

FFDB7CC0h: EEB2                     MOVY   B5_WSTART,B2_DADDR
FFDB7CD0h: F612                     DRAV   B0_SADDR,B2_DADDR
FFDB7CE0h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY
FFDB7CF0h: C0CB                     JR     FFDB79B0h

FFDB7D00h: 0300                     NOP
FFDB7D10h: 0300                     NOP
FFDB7D20h: 1FC1                     BTST   1h,A1
FFDB7D30h: CA0C                     JREQ   FFDB7E00h
FFDB7D40h: 09FA 8250 FFDB           MOVI   FFDB8250h,B10_COUNT
FFDB7D70h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB7D80h: 4E2E                     MOVE   A1,B14_TEMP
FFDB7D90h: 261E                     SLL    10h,B14_TEMP
FFDB7DA0h: 2C9E                     SRL    1Ch,B14_TEMP
FFDB7DB0h: 249E                     SLL    4h,B14_TEMP
FFDB7DC0h: 405E                     ADD    B2_DADDR,B14_TEMP
FFDB7DD0h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0
FFDB7DE0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB7DF0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB7E00h: 1FE1                     BTST   0h,A1
FFDB7E10h: CA0A                     JREQ   FFDB7EC0h
FFDB7E20h: 09FA 8280 FFDB           MOVI   FFDB8280h,B10_COUNT
FFDB7E50h: 4E2E                     MOVE   A1,B14_TEMP
FFDB7E60h: 269E                     SLL    14h,B14_TEMP
FFDB7E70h: 2C9E                     SRL    1Ch,B14_TEMP
FFDB7E80h: 249E                     SLL    4h,B14_TEMP
FFDB7E90h: 405E                     ADD    B2_DADDR,B14_TEMP
FFDB7EA0h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0
FFDB7EB0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB7EC0h: 09FA 8290 FFDB           MOVI   FFDB8290h,B10_COUNT
FFDB7EF0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB7F00h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB7F10h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB7F20h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP
FFDB7F50h: 457E                     SUB    B11_INC1,B14_TEMP
FFDB7F60h: 161E                     SUBK   10h,B14_TEMP
FFDB7F70h: 2F9E                     SRL    4h,B14_TEMP
FFDB7F80h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0
FFDB7F90h: 4F70                     MOVE   B11_INC1,A0
FFDB7FA0h: 0B00 0060                ADDI   60h,A0
FFDB7FC0h: 121A                     ADDK   10h,B10_COUNT
FFDB7FD0h: 1B9E                     MOVK   1Ch,B14_TEMP
FFDB7FE0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB7FF0h: 3C5E                     DSJS   B14_TEMP,FFDB7FE0h
FFDB8000h: 4F3B                     MOVE   B9_COLOR1,A11
FFDB8010h: 4EBE                     MOVE   B5_WSTART,A14
FFDB8020h: 4EDC                     MOVE   B6_WEND,A12
FFDB8030h: 1823                     MOVK   1h,A3
FFDB8040h: 0960                     RETS

FFDB8050h: 0000 0000 0000 0000 0000 .bss     32*2*8

FFDB8250h: 4F3B                     MOVE   B9_COLOR1,A11
FFDB8260h: CA01                     JREQ   FFDB8280h
FFDB8270h: 4F1B                     MOVE   B8_COLOR0,A11
FFDB8280h: CB02                     JRNE   FFDB82B0h
FFDB8290h: F165                     PIXT   A11,*A5,XY
FFDB82A0h: CC05                     JRV    FFDB8300h
FFDB82B0h: 0D8D FFD8                DSJ    A13,FFDB8050h
FFDB82D0h: 4F69                     MOVE   A11,B9_COLOR1
FFDB82E0h: 4CA4                     MOVE   A5,A4
FFDB82F0h: 0960                     RETS

FFDB8300h: E6A1                     CPW    A5,A1
FFDB8310h: 4001                     ADD    A0,A1
FFDB8320h: 0161                     JUMP   A1

FFDB8330h: 0300                     NOP
FFDB8340h: 0300                     NOP
FFDB8350h: EDC5                     MOVX   A14,A5
FFDB8360h: C0F2                     JR     FFDB8290h

FFDB8370h: ED85                     MOVX   A12,A5
FFDB8380h: C0F0                     JR     FFDB8290h

FFDB8390h: 0300                     NOP
FFDB83A0h: 0300                     NOP
FFDB83B0h: EFC5                     MOVY   A14,A5
FFDB83C0h: C0EC                     JR     FFDB8290h

FFDB83D0h: 4DC5                     MOVE   A14,A5
FFDB83E0h: C0EA                     JR     FFDB8290h

FFDB83F0h: ED85                     MOVX   A12,A5
FFDB8400h: EFC5                     MOVY   A14,A5
FFDB8410h: C0E7                     JR     FFDB8290h

FFDB8420h: 0300                     NOP
FFDB8430h: EF85                     MOVY   A12,A5
FFDB8440h: C0E4                     JR     FFDB8290h

FFDB8450h: EDC5                     MOVX   A14,A5
FFDB8460h: C0FC                     JR     FFDB8430h

FFDB8470h: 4D85                     MOVE   A12,A5
FFDB8480h: C0E0                     JR     FFDB8290h

FFDB8490h: 1FC1                     BTST   1h,A1
FFDB84A0h: CA0C                     JREQ   FFDB8570h
FFDB84B0h: 09FA 89E0 FFDB           MOVI   FFDB89E0h,B10_COUNT
FFDB84E0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB84F0h: 4E2E                     MOVE   A1,B14_TEMP
FFDB8500h: 261E                     SLL    10h,B14_TEMP
FFDB8510h: 2C9E                     SRL    1Ch,B14_TEMP
FFDB8520h: 249E                     SLL    4h,B14_TEMP
FFDB8530h: 405E                     ADD    B2_DADDR,B14_TEMP
FFDB8540h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0
FFDB8550h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB8560h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB8570h: 1FE1                     BTST   0h,A1
FFDB8580h: CA0A                     JREQ   FFDB8630h
FFDB8590h: 09FA 8A10 FFDB           MOVI   FFDB8A10h,B10_COUNT
FFDB85C0h: 4E2E                     MOVE   A1,B14_TEMP
FFDB85D0h: 269E                     SLL    14h,B14_TEMP
FFDB85E0h: 2C9E                     SRL    1Ch,B14_TEMP
FFDB85F0h: 249E                     SLL    4h,B14_TEMP
FFDB8600h: 405E                     ADD    B2_DADDR,B14_TEMP
FFDB8610h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0
FFDB8620h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB8630h: 09FA 8A20 FFDB           MOVI   FFDB8A20h,B10_COUNT
FFDB8660h: 18DE                     MOVK   6h,B14_TEMP
FFDB8670h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB8680h: 3C5E                     DSJS   B14_TEMP,FFDB8670h
FFDB8690h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP
FFDB86C0h: 457E                     SUB    B11_INC1,B14_TEMP
FFDB86D0h: 161E                     SUBK   10h,B14_TEMP
FFDB86E0h: 2F9E                     SRL    4h,B14_TEMP
FFDB86F0h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0
FFDB8700h: 4F70                     MOVE   B11_INC1,A0
FFDB8710h: 0B00 0060                ADDI   60h,A0
FFDB8730h: 121A                     ADDK   10h,B10_COUNT
FFDB8740h: 1BFE                     MOVK   1Fh,B14_TEMP
FFDB8750h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB8760h: 3C5E                     DSJS   B14_TEMP,FFDB8750h
FFDB8770h: 4F3B                     MOVE   B9_COLOR1,A11
FFDB8780h: 4EBE                     MOVE   B5_WSTART,A14
FFDB8790h: 4EDC                     MOVE   B6_WEND,A12
FFDB87A0h: 1823                     MOVK   1h,A3
FFDB87B0h: E26C                     SUBXY  A3,A12
FFDB87C0h: 1844                     MOVK   2h,A4
FFDB87D0h: 0960                     RETS

FFDB87E0h: 0000 0000 0000 0000 0000 .bss     32*2*8

FFDB89E0h: 4F3B                     MOVE   B9_COLOR1,A11
FFDB89F0h: CA01                     JREQ   FFDB8A10h
FFDB8A00h: 4F1B                     MOVE   B8_COLOR0,A11
FFDB8A10h: CB05                     JRNE   FFDB8A70h
FFDB8A20h: F165                     PIXT   A11,*A5,XY
FFDB8A30h: CC08                     JRV    FFDB8AC0h
FFDB8A40h: E065                     ADDXY  A3,A5
FFDB8A50h: F165                     PIXT   A11,*A5,XY
FFDB8A60h: CC1E                     JRV    FFDB8C50h
FFDB8A70h: 0D8D FFD5                DSJ    A13,FFDB87E0h
FFDB8A90h: 4F69                     MOVE   A11,B9_COLOR1
FFDB8AA0h: 4CA4                     MOVE   A5,A4
FFDB8AB0h: 0960                     RETS

FFDB8AC0h: E6A1                     CPW    A5,A1
FFDB8AD0h: 4001                     ADD    A0,A1
FFDB8AE0h: 0161                     JUMP   A1

FFDB8AF0h: 0300                     NOP
FFDB8B00h: 0300                     NOP
FFDB8B10h: EDC5                     MOVX   A14,A5
FFDB8B20h: C0EF                     JR     FFDB8A20h

FFDB8B30h: ED85                     MOVX   A12,A5
FFDB8B40h: C0ED                     JR     FFDB8A20h

FFDB8B50h: 0300                     NOP
FFDB8B60h: 0300                     NOP
FFDB8B70h: EFC5                     MOVY   A14,A5
FFDB8B80h: C0E9                     JR     FFDB8A20h

FFDB8B90h: 4DC5                     MOVE   A14,A5
FFDB8BA0h: C0E7                     JR     FFDB8A20h

FFDB8BB0h: ED85                     MOVX   A12,A5
FFDB8BC0h: EFC5                     MOVY   A14,A5
FFDB8BD0h: C0E4                     JR     FFDB8A20h

FFDB8BE0h: 0300                     NOP
FFDB8BF0h: EF85                     MOVY   A12,A5
FFDB8C00h: C0E1                     JR     FFDB8A20h

FFDB8C10h: EDC5                     MOVX   A14,A5
FFDB8C20h: C0FC                     JR     FFDB8BF0h

FFDB8C30h: 4D85                     MOVE   A12,A5
FFDB8C40h: C0DD                     JR     FFDB8A20h

FFDB8C50h: E285                     SUBXY  A4,A5
FFDB8C60h: F165                     PIXT   A11,*A5,XY
FFDB8C70h: C0DF                     JR     FFDB8A70h

********************************************************************************
* COMMAND_24_25
********************************************************************************
COMMAND_24_25:
FFDB8C80h: 9503                     MOVE   *A8+,A3,0
FFDB8C90h: 9701                     MOVE   *A8+,A1,1
FFDB8CA0h: 9700                     MOVE   *A8+,A0,1
FFDB8CB0h: 950A                     MOVE   *A8+,A10,0
FFDB8CC0h: 1423                     DEC    A3
FFDB8CD0h: C600 EF9B                JRLE   CMD_LOOP
FFDB8CF0h: 098F 0084                MMTM   SP,A8,A13
FFDB8D10h: 4F3C                     MOVE   B9_COLOR1,A12
FFDB8D20h: 4F1E                     MOVE   B8_COLOR0,A14
FFDB8D30h: 4F40                     MOVE   A10,B0_SADDR
FFDB8D40h: 574A                     CLR    A10
FFDB8D50h: 09F1 0001 0001           MOVI   00010001h,B1_SPTCH
FFDB8D80h: 09E2 0000 0001           MOVI   00010000h,A2
FFDB8DB0h: 09FB 0000 FFDD           MOVI   FFDD0000h,B11_INC1
FFDB8DE0h: 4E27                     MOVE   A1,B7_DVDX
FFDB8DF0h: 2717                     SLL    18h,B7_DVDX
FFDB8E00h: 2C77                     SRL    1Dh,B7_DVDX
FFDB8E10h: 2437                     SLL    1h,B7_DVDX
FFDB8E20h: CB0B                     JRNE   FFDB8EE0h
FFDB8E30h: 1A17                     MOVK   10h,B7_DVDX
FFDB8E40h: 09FA 9480 FFDB           MOVI   FFDB9480h,B10_COUNT
FFDB8E70h: 4E2C                     MOVE   A1,B12_INC2
FFDB8E80h: 27BC                     SLL    1Dh,B12_INC2
FFDB8E90h: CA0D                     JREQ   FFDB8F70h
FFDB8EA0h: 09FA 95D0 FFDB           MOVI   FFDB95D0h,B10_COUNT
FFDB8ED0h: C009                     JR     FFDB8F70h

FFDB8EE0h: 09FA 95D0 FFDB           MOVI   FFDB95D0h,B10_COUNT
FFDB8F10h: 4E2C                     MOVE   A1,B12_INC2
FFDB8F20h: 27BC                     SLL    1Dh,B12_INC2
FFDB8F30h: CB03                     JRNE   FFDB8F70h
FFDB8F40h: 09FA 9520 FFDB           MOVI   FFDB9520h,B10_COUNT
FFDB8F70h: 1217                     ADDK   10h,B7_DVDX
FFDB8F80h: 955E                     MOVE   *B10_COUNT+,B14_TEMP,0
FFDB8F90h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB8FA0h: 3C5E                     DSJS   B14_TEMP,FFDB8F90h
FFDB8FB0h: 1FC1                     BTST   1h,A1
FFDB8FC0h: CA0B                     JREQ   FFDB9080h
FFDB8FD0h: 09FA 96A0 FFDB           MOVI   FFDB96A0h,B10_COUNT
FFDB9000h: 4C28                     MOVE   A1,A8
FFDB9010h: 2608                     SLL    10h,A8
FFDB9020h: 2C88                     SRL    1Ch,A8
FFDB9030h: 1208                     ADDK   10h,A8
FFDB9040h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9050h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9060h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9070h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9080h: 1FE1                     BTST   0h,A1
FFDB9090h: CA09                     JREQ   FFDB9130h
FFDB90A0h: 09FA 96E0 FFDB           MOVI   FFDB96E0h,B10_COUNT
FFDB90D0h: 4C2D                     MOVE   A1,A13
FFDB90E0h: 268D                     SLL    14h,A13
FFDB90F0h: 2C8D                     SRL    1Ch,A13
FFDB9100h: 120D                     ADDK   10h,A13
FFDB9110h: 1ABE                     MOVK   15h,B14_TEMP
FFDB9120h: C004                     JR     FFDB9170h

FFDB9130h: 09FA 9720 FFDB           MOVI   FFDB9720h,B10_COUNT
FFDB9160h: 1A3E                     MOVK   11h,B14_TEMP
FFDB9170h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9180h: 3C5E                     DSJS   B14_TEMP,FFDB9170h
FFDB9190h: 193E                     MOVK   9h,B14_TEMP
FFDB91A0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB91B0h: 3C5E                     DSJS   B14_TEMP,FFDB91A0h
FFDB91C0h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP
FFDB91F0h: 457E                     SUB    B11_INC1,B14_TEMP
FFDB9200h: 2F9E                     SRL    4h,B14_TEMP
FFDB9210h: 161B                     SUBK   10h,B11_INC1
FFDB9220h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0
FFDB9230h: 1B5E                     MOVK   1Ah,B14_TEMP
FFDB9240h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9250h: 3C5E                     DSJS   B14_TEMP,FFDB9240h
FFDB9260h: 1D61                     BTST   14h,A1
FFDB9270h: CA02                     JREQ   FFDB92A0h
FFDB9280h: 141B                     SUBK   20h,B11_INC1
FFDB9290h: 895B                     MOVE   *B10_COUNT,*B11_INC1,0
FFDB92A0h: 9607                     MOVE   *A0+,A7,1
FFDB92B0h: 4CEB                     MOVE   A7,A11
FFDB92C0h: 4CE9                     MOVE   A7,A9
FFDB92D0h: 2609                     SLL    10h,A9
FFDB92E0h: ED27                     MOVX   A9,A7
FFDB92F0h: D717                     EXGF   B7_DVDX,1
FFDB9300h: 0707                     SEXT   A7,1
FFDB9310h: 4927                     CMP    A9,A7
FFDB9320h: C503                     JRGE   FFDB9360h
FFDB9330h: 4EEA                     MOVE   A7,B10_COUNT
FFDB9340h: 4D27                     MOVE   A9,A7
FFDB9350h: 4F59                     MOVE   B10_COUNT,A9
FFDB9360h: 09FB 010E C000           MOVI   HSTCTLH+14,B11_INC1
FFDB9390h: 0541                     SETF   1h,0,0
FFDB93A0h: 183E                     MOVK   1h,B14_TEMP
FFDB93B0h: 81DB                     MOVE   B14_TEMP,*B11_INC1,0
FFDB93C0h: 81FB                     MOVE   SP,*B11_INC1,0
FFDB93D0h: 0540                     SETF   20h,0,0
FFDB93E0h: 0D5F 0000 FFDD           CALLA  FFDD0000h
FFDB9410h: 0550                     SETF   10h,0,0
FFDB9420h: 0740                     SETF   20h,0,1
FFDB9430h: 4F89                     MOVE   A12,B9_COLOR1
FFDB9440h: 09AF 2100                MMFM   SP,A8,A13
FFDB9460h: C000 EF22                JR     CMD_LOOP

FFDB9480h: 0009                     .word    0009h
FFDB9490h: 9405                     MOVE   *A0+,A5,0
FFDB94A0h: 4CA6                     MOVE   A5,A6
FFDB94B0h: 2606                     SLL    10h,A6
FFDB94C0h: ECC5                     MOVX   A6,A5
FFDB94D0h: 48C5                     CMP    A6,A5
FFDB94E0h: C503                     JRGE   FFDB9520h
FFDB94F0h: 4EAA                     MOVE   A5,B10_COUNT
FFDB9500h: 4CC5                     MOVE   A6,A5
FFDB9510h: 4F56                     MOVE   B10_COUNT,A6
FFDB9520h: 000A                     .word    000Ah
FFDB9530h: 9405                     MOVE   *A0+,A5,0
FFDB9540h: 4CA6                     MOVE   A5,A6
FFDB9550h: 2606                     SLL    10h,A6
FFDB9560h: ECC5                     MOVX   A6,A5
FFDB9570h: 0705                     SEXT   A5,1
FFDB9580h: 48C5                     CMP    A6,A5
FFDB9590h: C503                     JRGE   FFDB95D0h
FFDB95A0h: 4EAA                     MOVE   A5,B10_COUNT
FFDB95B0h: 4CC5                     MOVE   A6,A5
FFDB95C0h: 4F56                     MOVE   B10_COUNT,A6
FFDB95D0h: 000C                     .word    000Ch
FFDB95E0h: 9405                     MOVE   *A0+,A5,0
FFDB95F0h: 4D61                     MOVE   A11,A1
FFDB9600h: 4CAB                     MOVE   A5,A11
FFDB9610h: 4CA6                     MOVE   A5,A6
FFDB9620h: 2606                     SLL    10h,A6
FFDB9630h: ECC5                     MOVX   A6,A5
FFDB9640h: 0705                     SEXT   A5,1
FFDB9650h: 48C5                     CMP    A6,A5
FFDB9660h: C503                     JRGE   FFDB96A0h
FFDB9670h: 4EAA                     MOVE   A5,B10_COUNT
FFDB9680h: 4CC5                     MOVE   A6,A5
FFDB9690h: 4F56                     MOVE   B10_COUNT,A6
FFDB96A0h: 4F89                     MOVE   A12,B9_COLOR1
FFDB96B0h: 4B01                     BTST   A8,A1
FFDB96C0h: CA01                     JREQ   FFDB96E0h
FFDB96D0h: 4FC9                     MOVE   A14,B9_COLOR1
FFDB96E0h: 4BA1                     BTST   A13,A1
FFDB96F0h: CB30                     JRNE   FFDB9A00h
FFDB9700h: 4BAB                     BTST   A13,A11
FFDB9710h: CB04                     JRNE   FFDB9760h
FFDB9720h: 48A9                     CMP    A5,A9
FFDB9730h: C602                     JRLE   FFDB9760h
FFDB9740h: 4CA9                     MOVE   A5,A9
FFDB9750h: E049                     ADDXY  A2,A9
FFDB9760h: 4EE7                     MOVE   A7,B7_DVDX
FFDB9770h: 4F22                     MOVE   A9,B2_DADDR
FFDB9780h: EC17                     MOVX   B0_SADDR,B7_DVDX
FFDB9790h: EC12                     MOVX   B0_SADDR,B2_DADDR
FFDB97A0h: E65A                     CPW    B2_DADDR,B10_COUNT
FFDB97B0h: CC17                     JRV    FFDB9930h
FFDB97C0h: E6FA                     CPW    B7_DVDX,B10_COUNT
FFDB97D0h: CC17                     JRV    FFDB9950h
FFDB97E0h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDB97F0h: CA1E                     JREQ   FFDB99E0h
FFDB9800h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB9810h: E852                     CVXYL  B2_DADDR,B2_DADDR
FFDB9820h: 0FC0                     FILL   L
FFDB9830h: 1030                     INC    B0_SADDR
FFDB9840h: 4CC9                     MOVE   A6,A9
FFDB9850h: 48E6                     CMP    A7,A6
FFDB9860h: C602                     JRLE   FFDB9890h
FFDB9870h: 4CE9                     MOVE   A7,A9
FFDB9880h: E049                     ADDXY  A2,A9
FFDB9890h: 4CA7                     MOVE   A5,A7
FFDB98A0h: 0D83 FFBC                DSJ    A3,FFDB9480h
FFDB98C0h: 4D4A                     MOVE   A10,A10
FFDB98D0h: CB04                     JRNE   FFDB9920h
FFDB98E0h: 102A                     INC    A10
FFDB98F0h: 1843                     MOVK   2h,A3
FFDB9900h: 1400                     SUBK   20h,A0
FFDB9910h: C0F7                     JR     FFDB9890h

FFDB9920h: 0960                     RETS

FFDB9930h: E6FB                     CPW    B7_DVDX,B11_INC1
FFDB9940h: CC04                     JRV    FFDB9990h
FFDB9950h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDB9960h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDB9970h: 0FE0                     FILL   XY
FFDB9980h: C0EA                     JR     FFDB9830h

FFDB9990h: 515B                     AND    B10_COUNT,B11_INC1
FFDB99A0h: CAFA                     JREQ   FFDB9950h
FFDB99B0h: 1F1B                     BTST   7h,B11_INC1
FFDB99C0h: CB06                     JRNE   FFDB9A30h
FFDB99D0h: EED2                     MOVY   B6_WEND,B2_DADDR
FFDB99E0h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY
FFDB99F0h: C0E3                     JR     FFDB9830h

FFDB9A00h: 1030                     INC    B0_SADDR
FFDB9A10h: 4CC9                     MOVE   A6,A9
FFDB9A20h: C0E6                     JR     FFDB9890h

FFDB9A30h: EEB2                     MOVY   B5_WSTART,B2_DADDR
FFDB9A40h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY
FFDB9A50h: C0DD                     JR     FFDB9830h

FFDB9A60h: 0300                     NOP
********************************************************************************
* COMMAND_32_GRAPHYY_0x20
********************************************************************************
COMMAND_32_GRAPHYY_0x20:
FFDB9A70h: 9503                     MOVE   *A8+,A3,0
FFDB9A80h: 9701                     MOVE   *A8+,A1,1
FFDB9A90h: 9700                     MOVE   *A8+,A0,1
FFDB9AA0h: 950A                     MOVE   *A8+,A10,0
FFDB9AB0h: 1423                     DEC    A3
FFDB9AC0h: C600 EEBC                JRLE   CMD_LOOP
FFDB9AE0h: 098F 0084                MMTM   SP,A8,A13
FFDB9B00h: 4F3C                     MOVE   B9_COLOR1,A12
FFDB9B10h: 4F1E                     MOVE   B8_COLOR0,A14
FFDB9B20h: 4F40                     MOVE   A10,B0_SADDR
FFDB9B30h: 574A                     CLR    A10
FFDB9B40h: 09F1 0001 0001           MOVI   00010001h,B1_SPTCH
FFDB9B70h: 09E2 0000 0001           MOVI   00010000h,A2
FFDB9BA0h: 09FB 0000 FFDD           MOVI   FFDD0000h,B11_INC1
FFDB9BD0h: 09FA A1B0 FFDB           MOVI   FFDBA1B0h,B10_COUNT
FFDB9C00h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9C10h: 4E2C                     MOVE   A1,B12_INC2
FFDB9C20h: 27BC                     SLL    1Dh,B12_INC2
FFDB9C30h: CA02                     JREQ   FFDB9C60h
FFDB9C40h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9C50h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9C60h: 4E27                     MOVE   A1,B7_DVDX
FFDB9C70h: 2717                     SLL    18h,B7_DVDX
FFDB9C80h: 2C77                     SRL    1Dh,B7_DVDX
FFDB9C90h: 2437                     SLL    1h,B7_DVDX
FFDB9CA0h: CB01                     JRNE   FFDB9CC0h
FFDB9CB0h: 1A17                     MOVK   10h,B7_DVDX
FFDB9CC0h: 09FA A1E0 FFDB           MOVI   FFDBA1E0h,B10_COUNT
FFDB9CF0h: 4CFC                     MOVE   B7_DVDX,B12_INC2
FFDB9D00h: 145C                     SUBK   2h,B12_INC2
FFDB9D10h: 249C                     SLL    4h,B12_INC2
FFDB9D20h: 419A                     ADD    B12_INC2,B10_COUNT
FFDB9D30h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9D40h: 4CFC                     MOVE   B7_DVDX,B12_INC2
FFDB9D50h: 279C                     SLL    1Ch,B12_INC2
FFDB9D60h: CA01                     JREQ   FFDB9D80h
FFDB9D70h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9D80h: 1FC1                     BTST   1h,A1
FFDB9D90h: CA0A                     JREQ   FFDB9E40h
FFDB9DA0h: 09FA A2D0 FFDB           MOVI   FFDBA2D0h,B10_COUNT
FFDB9DD0h: 4C28                     MOVE   A1,A8
FFDB9DE0h: 2608                     SLL    10h,A8
FFDB9DF0h: 2C88                     SRL    1Ch,A8
FFDB9E00h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9E10h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9E20h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9E30h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9E40h: 1FE1                     BTST   0h,A1
FFDB9E50h: CA08                     JREQ   FFDB9EE0h
FFDB9E60h: 09FA A310 FFDB           MOVI   FFDBA310h,B10_COUNT
FFDB9E90h: 4C2D                     MOVE   A1,A13
FFDB9EA0h: 268D                     SLL    14h,A13
FFDB9EB0h: 2C8D                     SRL    1Ch,A13
FFDB9EC0h: 1ABE                     MOVK   15h,B14_TEMP
FFDB9ED0h: C004                     JR     FFDB9F20h

FFDB9EE0h: 09FA A350 FFDB           MOVI   FFDBA350h,B10_COUNT
FFDB9F10h: 1A3E                     MOVK   11h,B14_TEMP
FFDB9F20h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9F30h: 3C5E                     DSJS   B14_TEMP,FFDB9F20h
FFDB9F40h: 193E                     MOVK   9h,B14_TEMP
FFDB9F50h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDB9F60h: 3C5E                     DSJS   B14_TEMP,FFDB9F50h
FFDB9F70h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP
FFDB9FA0h: 457E                     SUB    B11_INC1,B14_TEMP
FFDB9FB0h: 2F9E                     SRL    4h,B14_TEMP
FFDB9FC0h: 161B                     SUBK   10h,B11_INC1
FFDB9FD0h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0
FFDB9FE0h: 1B5E                     MOVK   1Ah,B14_TEMP
FFDB9FF0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0
FFDBA000h: 3C5E                     DSJS   B14_TEMP,FFDB9FF0h
FFDBA010h: 1D61                     BTST   14h,A1
FFDBA020h: CA02                     JREQ   FFDBA050h
FFDBA030h: 141B                     SUBK   20h,B11_INC1
FFDBA040h: 895B                     MOVE   *B10_COUNT,*B11_INC1,0
FFDBA050h: 9407                     MOVE   *A0+,A7,0
FFDBA060h: 4CEB                     MOVE   A7,A11
FFDBA070h: D717                     EXGF   B7_DVDX,1
FFDBA080h: 0707                     SEXT   A7,1
FFDBA090h: 2607                     SLL    10h,A7
FFDBA0A0h: 4CE9                     MOVE   A7,A9
FFDBA0B0h: 09FB 010E C000           MOVI   HSTCTLH+14,B11_INC1
FFDBA0E0h: 0741                     SETF   1h,0,1
FFDBA0F0h: 183E                     MOVK   1h,B14_TEMP
FFDBA100h: 83DB                     MOVE   B14_TEMP,*B11_INC1,1
FFDBA110h: 83FB                     MOVE   SP,*B11_INC1,1
FFDBA120h: 0D5F 0000 FFDD           CALLA  FFDD0000h
FFDBA150h: 0740                     SETF   20h,0,1
FFDBA160h: 4F89                     MOVE   A12,B9_COLOR1
FFDBA170h: 09AF 2100                MMFM   SP,A8,A13
FFDBA190h: C000 EE4F                JR     CMD_LOOP

FFDBA1B0h: 9405                     MOVE   *A0+,A5,0
FFDBA1C0h: 4D61                     MOVE   A11,A1
FFDBA1D0h: 4CAB                     MOVE   A5,A11
FFDBA1E0h: 27C5                     SLL    1Eh,A5
FFDBA1F0h: 2A45                     SRA    Eh,A5
FFDBA200h: 2785                     SLL    1Ch,A5
FFDBA210h: 2A85                     SRA    Ch,A5
FFDBA220h: 2745                     SLL    1Ah,A5
FFDBA230h: 2AC5                     SRA    Ah,A5
FFDBA240h: 2705                     SLL    18h,A5
FFDBA250h: 2B05                     SRA    8h,A5
FFDBA260h: 26C5                     SLL    16h,A5
FFDBA270h: 2B45                     SRA    6h,A5
FFDBA280h: 2685                     SLL    14h,A5
FFDBA290h: 2B85                     SRA    4h,A5
FFDBA2A0h: 2645                     SLL    12h,A5
FFDBA2B0h: 2BC5                     SRA    2h,A5
FFDBA2C0h: 2605                     SLL    10h,A5
FFDBA2D0h: 4F89                     MOVE   A12,B9_COLOR1
FFDBA2E0h: 4B01                     BTST   A8,A1
FFDBA2F0h: CA01                     JREQ   FFDBA310h
FFDBA300h: 4FC9                     MOVE   A14,B9_COLOR1
FFDBA310h: 4BA1                     BTST   A13,A1
FFDBA320h: CB30                     JRNE   FFDBA630h
FFDBA330h: 4BAB                     BTST   A13,A11
FFDBA340h: CB04                     JRNE   FFDBA390h
FFDBA350h: 48A9                     CMP    A5,A9
FFDBA360h: C602                     JRLE   FFDBA390h
FFDBA370h: 4CA9                     MOVE   A5,A9
FFDBA380h: E049                     ADDXY  A2,A9
FFDBA390h: 4EE7                     MOVE   A7,B7_DVDX
FFDBA3A0h: 4F22                     MOVE   A9,B2_DADDR
FFDBA3B0h: EC17                     MOVX   B0_SADDR,B7_DVDX
FFDBA3C0h: EC12                     MOVX   B0_SADDR,B2_DADDR
FFDBA3D0h: E65A                     CPW    B2_DADDR,B10_COUNT
FFDBA3E0h: CC17                     JRV    FFDBA560h
FFDBA3F0h: E6FA                     CPW    B7_DVDX,B10_COUNT
FFDBA400h: CC17                     JRV    FFDBA580h
FFDBA410h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDBA420h: CA1E                     JREQ   FFDBA610h
FFDBA430h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDBA440h: E852                     CVXYL  B2_DADDR,B2_DADDR
FFDBA450h: 0FC0                     FILL   L
FFDBA460h: 1030                     INC    B0_SADDR
FFDBA470h: 4CA9                     MOVE   A5,A9
FFDBA480h: 48E9                     CMP    A7,A9
FFDBA490h: C602                     JRLE   FFDBA4C0h
FFDBA4A0h: 4CE9                     MOVE   A7,A9
FFDBA4B0h: E049                     ADDXY  A2,A9
FFDBA4C0h: 4CA7                     MOVE   A5,A7
FFDBA4D0h: 0D83 FFCC                DSJ    A3,FFDBA1B0h
FFDBA4F0h: 4D4A                     MOVE   A10,A10
FFDBA500h: CB04                     JRNE   FFDBA550h
FFDBA510h: 102A                     INC    A10
FFDBA520h: 1843                     MOVK   2h,A3
FFDBA530h: 1600                     SUBK   10h,A0
FFDBA540h: C0F7                     JR     FFDBA4C0h

FFDBA550h: 0960                     RETS

FFDBA560h: E6FB                     CPW    B7_DVDX,B11_INC1
FFDBA570h: CC04                     JRV    FFDBA5C0h
FFDBA580h: E257                     SUBXY  B2_DADDR,B7_DVDX
FFDBA590h: E037                     ADDXY  B1_SPTCH,B7_DVDX
FFDBA5A0h: 0FE0                     FILL   XY
FFDBA5B0h: C0EA                     JR     FFDBA460h

FFDBA5C0h: 515B                     AND    B10_COUNT,B11_INC1
FFDBA5D0h: CAFA                     JREQ   FFDBA580h
FFDBA5E0h: 1F1B                     BTST   7h,B11_INC1
FFDBA5F0h: CB06                     JRNE   FFDBA660h
FFDBA600h: EED2                     MOVY   B6_WEND,B2_DADDR
FFDBA610h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY
FFDBA620h: C0E3                     JR     FFDBA460h

FFDBA630h: 1030                     INC    B0_SADDR
FFDBA640h: 4CA9                     MOVE   A5,A9
FFDBA650h: C0E6                     JR     FFDBA4C0h

FFDBA660h: EEB2                     MOVY   B5_WSTART,B2_DADDR
FFDBA670h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY
FFDBA680h: C0DD                     JR     FFDBA460h

FFDBA690h: 0300                     NOP

CMD_ADR_TABLE:
FFDC8000h: .long SCREENBASE_0x0000_0000
FFDC8020h: .long SCREENBASE_0x0000_0000
FFDC8040h: .long COMMAND_2_ARC
FFDC8060h: .long COMMAND_2_ARC
FFDC8080h: .long COMMAND_4_BENCHMARK_TEXT
FFDC80A0h: .long COMMAND_4_BENCHMARK_TEXT
FFDC80C0h: .long COMMAND_6_BINARY_MAP
FFDC80E0h: .long COMMAND_6_BINARY_MAP
FFDC8100h: .long COMMAND_8_CIRCLE
FFDC8120h: .long COMMAND_8_CIRCLE
FFDC8140h: .long COMMAND_10_COPY_RECTANGLE
FFDC8160h: .long COMMAND_10_COPY_RECTANGLE
FFDC8180h: .long COMMAND_12_DOT
FFDC81A0h: .long COMMAND_12_DOT
FFDC81C0h: .long COMMAND_14_ERASE_RECTANGLE
FFDC81E0h: .long COMMAND_14_ERASE_RECTANGLE
FFDC8200h: .long COMMAND_16_FILL_CIRCLE
FFDC8220h: .long COMMAND_16_FILL_CIRCLE
FFDC8240h: .long COMMAND_18_FILL_RECTANGLE
FFDC8260h: .long COMMAND_18_FILL_RECTANGLE
FFDC8280h: .long COMMAND_20_21
FFDC82A0h: .long COMMAND_20_21
FFDC82C0h: .long COMMAND_22_23
FFDC82E0h: .long COMMAND_22_23
FFDC8300h: .long COMMAND_24_25
FFDC8320h: .long COMMAND_24_25
FFDC8340h: .long COMMAND_26_GRAPHYY_0x1a
FFDC8360h: .long COMMAND_26_GRAPHYY_0x1a
FFDC8380h: .long COMMAND_28_GRAPHYY_0x1c
FFDC83A0h: .long COMMAND_28_GRAPHYY_0x1c
FFDC83C0h: .long COMMAND_30_31
FFDC83E0h: .long COMMAND_30_31
FFDC8400h: .long COMMAND_32_GRAPHYY_0x20
FFDC8420h: .long COMMAND_32_GRAPHYY_0x20
FFDC8440h: .long COMMAND_34_35
FFDC8460h: .long COMMAND_34_35
FFDC8480h: .long COMMAND_36_LINE_ABSOLUTE
FFDC84A0h: .long COMMAND_36_LINE_ABSOLUTE
FFDC84C0h: .long COMMAND_38_LINE_RELATIVE
FFDC84E0h: .long COMMAND_38_LINE_RELATIVE
FFDC8500h: .long COMMAND_40_PIXEL_MAP
FFDC8520h: .long COMMAND_40_PIXEL_MAP
FFDC8540h: .long COMMAND_42_POLYLINE_ABSOLUTE
FFDC8560h: .long COMMAND_42_POLYLINE_ABSOLUTE
FFDC8580h: .long COMMAND_44_POLYLINE_RELATIVE
FFDC85A0h: .long COMMAND_44_POLYLINE_RELATIVE
FFDC85C0h: .long COMMAND_46_TEXT
FFDC85E0h: .long COMMAND_46_TEXT
FFDC8600h: .long COMMAND_48_TEXT_UNDERLINE
FFDC8620h: .long COMMAND_48_TEXT_UNDERLINE
FFDC8640h: .long COMMAND_50_CALL
FFDC8660h: .long COMMAND_50_CALL
FFDC8680h: .long COMMAND_52_CALL_NOT_USER_FLAG
FFDC86A0h: .long COMMAND_52_CALL_NOT_USER_FLAG
FFDC86C0h: .long COMMAND_54_CALL_ON_USER_FLAG
FFDC86E0h: .long COMMAND_54_CALL_ON_USER_FLAG
FFDC8700h: .long COMMAND_56_JUMP
FFDC8720h: .long COMMAND_56_JUMP
FFDC8740h: .long COMMAND_58_JUMP_NOT_USER_FLAG
FFDC8760h: .long COMMAND_58_JUMP_NOT_USER_FLAG
FFDC8780h: .long COMMAND_60_JUMP_ON_USER_FLAG
FFDC87A0h: .long COMMAND_60_JUMP_ON_USER_FLAG
FFDC87C0h: .long COMMAND_62_RETURN
FFDC87E0h: .long COMMAND_62_RETURN
FFDC8800h: .long COMMAND_64_SKIP1
FFDC8820h: .long COMMAND_64_SKIP1
FFDC8840h: .long COMMAND_66_SKIP2
FFDC8860h: .long COMMAND_66_SKIP2
FFDC8880h: .long COMMAND_68_SKIP3
FFDC88A0h: .long COMMAND_68_SKIP3
FFDC88C0h: .long COMMAND_70_SKIP4
FFDC88E0h: .long COMMAND_70_SKIP4
FFDC8900h: .long COMMAND_72_USER_FLAG_CLEAR
FFDC8920h: .long COMMAND_72_USER_FLAG_CLEAR
FFDC8940h: .long COMMAND_74_USER_FLAG_SET
FFDC8960h: .long COMMAND_74_USER_FLAG_SET
FFDC8980h: .long COMMAND_76_USER_FLAG_TOGGLE 
FFDC89A0h: .long COMMAND_76_USER_FLAG_TOGGLE 
FFDC89C0h: .long COMMAND_78_DYNAMIC_FRAME
FFDC89E0h: .long COMMAND_78_DYNAMIC_FRAME
FFDC8A00h: .long COMMAND_80_STATIC_FRAME
FFDC8A20h: .long COMMAND_80_STATIC_FRAME
FFDC8A40h: .long COMMAND_82_STATIC_FRAME_AND_ERASE
FFDC8A60h: .long COMMAND_82_STATIC_FRAME_AND_ERASE
FFDC8A80h: .long COMMAND_84_GATED_CALL
FFDC8AA0h: .long COMMAND_84_GATED_CALL
FFDC8AC0h: .long COMMAND_86_INTERRUPT_HOST
FFDC8AE0h: .long COMMAND_86_INTERRUPT_HOST
FFDC8B00h: .long COMMAND_IGNORE
FFDC8B20h: .long COMMAND_IGNORE
FFDC8B40h: .long COMMAND_90_91
FFDC8B60h: .long COMMAND_90_91
FFDC8B80h: .long COMMAND_92_SEGMENT_END
FFDC8BA0h: .long COMMAND_92_SEGMENT_END
FFDC8BC0h: .long COMMAND_94_SEGMENT_END_AND_RETURN
FFDC8BE0h: .long COMMAND_94_SEGMENT_END_AND_RETURN
FFDC8C00h: .long COMMAND_96_SEGMENT_END_AND_JUMP
FFDC8C20h: .long COMMAND_96_SEGMENT_END_AND_JUMP
FFDC8C40h: .long COMMAND_98_SEGMENT_START
FFDC8C60h: .long COMMAND_98_SEGMENT_START
FFDC8C80h: .long COMMAND_100_STALL
FFDC8CA0h: .long COMMAND_100_STALL
FFDC8CC0h: .long COMMAND_102_SYNC_COPY_STATIC
FFDC8CE0h: .long COMMAND_102_SYNC_COPY_STATIC
FFDC8D00h: .long COMMAND_104_SYNC_DISPLAY_DYNAMIC
FFDC8D20h: .long COMMAND_104_SYNC_DISPLAY_DYNAMIC
FFDC8D40h: .long COMMAND_106_BENCHMARK_START_0x6a
FFDC8D60h: .long COMMAND_106_BENCHMARK_START_0x6a
FFDC8D80h: .long COMMAND_108_BENCHMARK_START_0x6c
FFDC8DA0h: .long COMMAND_108_BENCHMARK_START_0x6c
FFDC8DC0h: .long COMMAND_110_CLIP_OFF
FFDC8DE0h: .long COMMAND_110_CLIP_OFF
FFDC8E00h: .long COMMAND_112_CLIP_ON
FFDC8E20h: .long COMMAND_112_CLIP_ON
FFDC8E40h: .long COMMAND_114_CLIP_RECTANGLE
FFDC8E60h: .long COMMAND_114_CLIP_RECTANGLE
FFDC8E80h: .long COMMAND_116_MOVE_ABSOLUTE_0x74
FFDC8EA0h: .long COMMAND_116_MOVE_ABSOLUTE_0x74
FFDC8EC0h: .long COMMAND_118_MOVE_ABSOLUTE_0x76
FFDC8EE0h: .long COMMAND_118_MOVE_ABSOLUTE_0x76
FFDC8F00h: .long COMMAND_120_ORIGIN
FFDC8F20h: .long COMMAND_120_ORIGIN
FFDC8F40h: .long COMMAND_122_PIXEL_OPERATION
FFDC8F60h: .long COMMAND_122_PIXEL_OPERATION
FFDC8F80h: .long COMMAND_124_PEN_FOREGROUND
FFDC8FA0h: .long COMMAND_124_PEN_FOREGROUND
FFDC8FC0h: .long COMMAND_126_127
FFDC8FE0h: .long COMMAND_126_127
FFDC9000h: .long COMMAND_128_PIXEL_STRETCH_OFF
FFDC9020h: .long COMMAND_128_PIXEL_STRETCH_OFF
FFDC9040h: .long COMMAND_130_PIXEL_STRETCH_ON
FFDC9060h: .long COMMAND_130_PIXEL_STRETCH_ON
FFDC9080h: .long COMMAND_132_SCALE_FACTOR_0x84
FFDC90A0h: .long COMMAND_132_SCALE_FACTOR_0x84
FFDC90C0h: .long COMMAND_134_SCALE_FACTOR_0x86
FFDC90E0h: .long COMMAND_134_SCALE_FACTOR_0x86
FFDC9100h: .long COMMAND_136_TEXT_FONT
FFDC9120h: .long COMMAND_136_TEXT_FONT
FFDC9140h: .long COMMAND_138_TRANSPARENCY_OFF
FFDC9160h: .long COMMAND_138_TRANSPARENCY_OFF
FFDC9180h: .long COMMAND_140_TRANSPARENCY_ON
FFDC91A0h: .long COMMAND_140_TRANSPARENCY_ON
FFDC91C0h: .long COMMAND_IGNORE
FFDC91E0h: .long COMMAND_IGNORE
FFDC9200h: .long COMMAND_IGNORE
FFDC9220h: .long COMMAND_IGNORE
FFDC9240h: .long COMMAND_IGNORE
FFDC9260h: .long COMMAND_IGNORE
FFDC9280h: .long COMMAND_IGNORE
FFDC92A0h: .long COMMAND_IGNORE
FFDC92C0h: .long COMMAND_IGNORE
FFDC92E0h: .long COMMAND_IGNORE
FFDC9300h: .long COMMAND_IGNORE
FFDC9320h: .long COMMAND_IGNORE
FFDC9340h: .long COMMAND_IGNORE
FFDC9360h: .long COMMAND_IGNORE
FFDC9380h: .long COMMAND_IGNORE
FFDC93A0h: .long COMMAND_IGNORE
FFDC93C0h: .long COMMAND_IGNORE
FFDC93E0h: .long COMMAND_IGNORE
FFDC9400h: .long COMMAND_IGNORE
FFDC9420h: .long COMMAND_IGNORE
FFDC9440h: .long COMMAND_IGNORE
FFDC9460h: .long COMMAND_IGNORE
FFDC9480h: .long COMMAND_IGNORE
FFDC94A0h: .long COMMAND_IGNORE
FFDC94C0h: .long COMMAND_IGNORE
FFDC94E0h: .long COMMAND_IGNORE
FFDC9500h: .long COMMAND_IGNORE

FONTS_TABLES:
FFDC9540h: .long FONT_0
FFDC9560h: .long FONT_1
FFDC9580h: .long FONT_2
FFDC95A0h: .long FONT_3

FFDD0000h: .bss 256*2*8
CMD_STACK:
FFDD1000h: .bss 11*2*8
FFDD8000h: .bss 16*2*8

FONT_0:
FFDE0000h: .byte 08h,c0h,ffh,deh,00h,0ah,00h,14h,00h,09h,00h,10h,00h,00h,00h,04h,00h,10h,00h,10h,08h,00h,ffh,deh,01h,00h,00h,00h,00h,00h,00h,00h,6fh,66h,74h,6eh,00h,32h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
FONT_1:
FFDE0200h: .byte 08h,c0h,ffh,deh,00h,0ah,00h,14h,00h,09h,00h,10h,00h,00h,00h,04h,00h,10h,00h,10h,08h,00h,ffh,deh,01h,00h,00h,00h,00h,00h,00h,00h,6fh,66h,74h,6eh,00h,32h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
FONT_2:
FFDE0400h: .byte 08h,c0h,ffh,deh,00h,0ah,00h,14h,00h,09h,00h,10h,00h,00h,00h,04h,00h,10h,00h,10h,08h,00h,ffh,deh,01h,00h,00h,00h,00h,00h,00h,00h,6fh,66h,74h,6eh,00h,32h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
FONT_3:
FFDE0600h: .byte 08h,c0h,ffh,deh,00h,0ah,00h,14h,00h,09h,00h,10h,00h,00h,00h,04h,00h,10h,00h,10h,08h,00h,ffh,deh,01h,00h,00h,00h,00h,00h,00h,00h,6fh,66h,74h,6eh,00h,32h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h

CURRENT_CMD_PC:
FFEC0800h: .word 0000h
FFEC0810h: .word 0000h
CURRENT_CMD:
FFEC0820h: .word 0000h
FFEC0830h: .word 0000h
FFEC0840h: .word 0000h
FFEC0850h: .word 0000h
FFEC0860h: .word 0000h
FFEC0870h: .word 0000h
FFEC0880h: .word 0000h
FFEC0890h: .word 0000h
FFEC08A0h: .word 0000h
FFEC08B0h: .word 0000h
INTERRUPT_HOST_CURRENT_PC:
FFEC08C0h: .word 0000h
FFEC08D0h: .word 0000h
FFEC08E0h: .word 0000h
FFEC08F0h: .word 0000h
FFEC0900h: .word 0001h
FFEC0910h: .word 0000h
PIXEL_STRETCH_ENABLED_FLAG:
FFEC0920h: .word 0000h
FFEC0930h: .word 0000h
SCALE_FACTOR_DX_A:
FFEC0940h: .word 0000h
FFEC0950h: .word 0001h
SCALE_FACTOR_DY_A:
FFEC0960h: .word 0000h
FFEC0970h: .word 0001h
SCALE_FACTOR_DX_B:
FFEC0980h: .word 0000h
FFEC0990h: .word 0000h
SCALE_FACTOR_DY_B:
FFEC09A0h: .word 0000h
FFEC09B0h: .word 0000h
FFEC09C0h: .word 0000h
FFEC09D0h: .word 0000h
FFEC09E0h: .word 0000h
FFEC09F0h: .word 0000h
FFEC0A00h: .word 0000h
FFEC0A10h: .word 0000h
FFEC0A20h: .word 0280h
FFEC0A30h: .word 01E0h
CLIP_MIN_XY:
FFEC0A40h: .word 0000h
FFEC0A50h: .word 0000h
CLIP_MAX_XY:
FFEC0A60h: .word 027Fh
FFEC0A70h: .word 01DFh
FFEC0A80h: .word 0000h
FFEC0A90h: .word 0000h
FFEC0AA0h: .word 0000h
FFEC0AB0h: .word 0000h
FFEC0AC0h: .word 0000h
FFEC0AD0h: .word 0000h
FFEC0AE0h: .word 0000h
FFEC0AF0h: .word 0000h
FFEC0B00h: .word 0030h
FFEC0B10h: .word 0030h
FFEC0B20h: .word 0030h
FFEC0B30h: .word 0030h
FFEC0B40h: .word 0030h
FFEC0B50h: .word 0030h
FFEC0B60h: .word 0030h
FFEC0B70h: .word 0030h
MSGIN_TABLE:
FFEC0B80h: .long MSGIN_0_3_4_7
FFEC0BA0h: .long MSGIN_1
FFEC0BC0h: .long MSGIN_2
FFEC0BE0h: .long MSGIN_0_3_4_7
FFEC0C00h: .long MSGIN_0_3_4_7
FFEC0C20h: .long MSGIN_5
FFEC0C40h: .long MSGIN_6
FFEC0C60h: .long MSGIN_0_3_4_7
FFEC0C80h: .word 0000h
FFEC0C90h: .word 0000h
FFEC0CA0h: .word 0460h
FFEC0CB0h: .word 00A1h
FFEC0CC0h: .word 0000h
CURRENT_FONT:
FFEC0CD0h: .word 0000h
FFEC0CE0h: .word 0000h
FFEC0CF0h: .word 0000h
FFEC0D00h: .word 0000h
FFEC0D10h: .word 0000h
FFEC0D20h: .word 0000h
FFEC0D30h: .word 0000h
FFEC0D40h: .word 0000h
FFEC0D50h: .word 0000h
FFEC0D60h: .word 0000h
FFEC0D70h: .word 0000h
FFEC0D80h: .word 0000h
FFEC0D90h: .word 0000h
FFEC0DA0h: .word 0000h
FFEC0DB0h: .word 0000h
FFEC0DC0h: .word 0000h
FFEC0DD0h: .word 0000h
FFEC0DE0h: .word 0000h
FFEC0DF0h: .word 0000h
FFEC0E00h: .word 0000h
FFEC0E10h: .word 0000h
FFEC0E20h: .word 0000h
FFEC0E30h: .word 0000h
FFEC0E40h: .word 0000h
FFEC0E50h: .word 0000h
FFEC0E60h: .word 0000h
FFEC0E70h: .word 0000h
FFEC0E80h: .word 0000h
FFEC0E90h: .word 0000h
FFEC0EA0h: .word 0000h
FFEC0EB0h: .word 0000h
FFEC0EC0h: .word 0000h
FFEC0ED0h: .word 0000h
FFEC0EE0h: .word 0000h
FFEC0EF0h: .word 0000h
FFEC0F00h: .word 0000h
FFEC0F10h: .word 0000h
FFEC0F20h: .word 0000h
FFEC0F30h: .word 0000h
FFEC0F40h: .word 0000h
FFEC0F50h: .word 0000h
FFEC0F60h: .word 0000h
FFEC0F70h: .word 0000h
FFEC0F80h: .word 0000h
FFEC0F90h: .word 0000h
FFEC0FA0h: .word 0000h
FFEC0FB0h: .word 0000h
FFEC0FC0h: .word 0000h
FFEC0FD0h: .word 0000h
FFEC0FE0h: .word 0000h
FFEC0FF0h: .word 0000h
FFEC1000h: .word 0000h
FFEC1010h: .word 0000h
FFEC1020h: .word 0000h
FFEC1030h: .word 0000h
FFEC1040h: .word 0000h
FFEC1050h: .word 0000h
FFEC1060h: .word 0000h
FFEC1070h: .word 0000h
FFEC1080h: .word 0000h
FFEC1090h: .word 0000h
FFEC10A0h: .word 0000h
FFEC10B0h: .word 0000h
FFEC10C0h: .word 0000h
FFEC10D0h: .word 0000h
FFEC10E0h: .word 0000h
FFEC10F0h: .word 0000h
FFEC1100h: .word 0000h
FFEC1110h: .word 0000h
FFEC1120h: .word 0000h
FFEC1130h: .word 0000h
FFEC1140h: .word 0000h
FFEC1150h: .word 0000h
FFEC1160h: .word 0000h
FFEC1170h: .word 0000h
FFEC1180h: .word 0000h
FFEC1190h: .word 0000h
FFEC11A0h: .word 0000h
FFEC11B0h: .word 0000h
FFEC11C0h: .word 0000h
FFEC11D0h: .word 0000h
FFEC11E0h: .word 0000h
FFEC11F0h: .word 0000h
FFEC1200h: .word 0000h
FFEC1210h: .word 0000h
FFEC1220h: .word 0000h
FFEC1230h: .word 0000h
FFEC1240h: .word 0000h
FFEC1250h: .word 0000h
FFEC1260h: .word 0000h
FFEC1270h: .word 0000h
FFEC1280h: .word 0000h
FFEC1290h: .word 0000h
FFEC12A0h: .word 0000h
FFEC12B0h: .word 0000h
FFEC12C0h: .word 0000h
CMD_LIST_PTR:
FFECE000h: .long CMD_BUFFER
FFECE020h: .long FFEC0860h
FFECE040h: .long FONTS_TABLES
CMD_BUFFER:
FFECE800h: .word 0072h,0000h,0000h,0280h,01E0h,0078h,0000h,0000h,0088h,0002h,0050h,007Ah,0000h,007Ch,0000h,0074h,0000h,0000h,0012h,0280h,01E0h,0058h,0058h,0058h,0058h,0058h,0058h,0058h,0058h,0066h,004Eh,007Ah,0000h,007Ch,000Fh,0074h,0002h,01CDh,008Ch,0058h,0058h,0058h,0058h,0058h,0058h,0058h,0058h,0058h,002Eh,0600h,0604h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,0020h,000Ah,0000h,0000h,0000h,0000h,008Ah,0058h,0058h,0058h,0058h,0058h,0058h,0058h,0058h,0058h,0058h,0058h,007Ch,0009h,0074h,025Fh,01C8h,0006h,4CF0h,FFEDh,0038h,4FE0h,FFEDh,0058h,0020h,0020h,0016h,6FFCh,3FFFh,63FEh,7FE0h,C0FEh,7F80h,C07Eh,7F00h,803Eh,7E01h,803Eh,7C01h,18DEh,7C3Fh,30DEh,7863h,318Eh,78C6h,618Eh,78C6h,630Eh,798Ch,C30Eh,798Ch,C60Eh,7998h,C60Eh,7998h,FC1Eh,7DF0h,0C1Eh,7C00h,183Eh,7E00h,183Eh,7E00h,307Eh,7F00h,30FEh,7FC0h,63FEh,7FF0h,6FFCh,3FFFh,0058h,0068h,0038h,E9E0h,FFECh

FFFFFFE0h: .long RESET_VECTOR
FFFFFFC0h: .long INT1_VECTOR
FFFFFFA0h: .long INT2_VECTOR
FFFFFF80h: .long RESET_VECTOR
FFFFFF60h: .long RESET_VECTOR
FFFFFF40h: .long RESET_VECTOR
FFFFFF20h: .long RESET_VECTOR
FFFFFF00h: .long RESET_VECTOR
FFFFFEE0h: .long RESET_VECTOR
FFFFFEC0h: .long HI_VECTOR
FFFFFEA0h: .long DI_VECTOR
FFFFFE80h: .long RESET_VECTOR
FFFFFE60h: .long RESET_VECTOR
FFFFFE40h: .long RESET_VECTOR
FFFFFE20h: .long RESET_VECTOR
FFFFFE00h: .long RESET_VECTOR
FFFFFDE0h: .long RESET_VECTOR
FFFFFDC0h: .long RESET_VECTOR
FFFFFDA0h: .long RESET_VECTOR
FFFFFD80h: .long RESET_VECTOR
FFFFFD60h: .long RESET_VECTOR
FFFFFD40h: .long RESET_VECTOR
FFFFFD20h: .long RESET_VECTOR
FFFFFD00h: .long RESET_VECTOR
FFFFFCE0h: .long RESET_VECTOR
FFFFFCC0h: .long RESET_VECTOR
FFFFFCA0h: .long RESET_VECTOR
FFFFFC80h: .long RESET_VECTOR
FFFFFC60h: .long RESET_VECTOR
FFFFFC40h: .long RESET_VECTOR
FFFFFC20h: .long ILLOP_VECTOR
FFFFFC00h: .long RESET_VECTOR
