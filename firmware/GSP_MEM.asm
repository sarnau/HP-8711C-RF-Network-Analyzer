04200000h: .word 0
HESYNC:
C0000000h: .word 0017h
HEBLNK:
C0000010h: .word 0022h
HSBLNK:
C0000020h: .word 00C2h
HTOTAL:
C0000030h: .word 00C6h
VESYNC:
C0000040h: .word 0001h
VEBLNK:
C0000050h: .word 0021h
VSBLNK:
C0000060h: .word 0201h
VTOTAL:
C0000070h: .word 020Ch
DPYCTL:
C0000080h: .word 7410h
DPYSTRT:
C0000090h: .word 1E00h
DPYINT:
C00000A0h: .word 0000h
CONTROL:
C00000B0h: .word 00CCh
HSTDATA:
C00000C0h: .word 0000h
HSTADRH:
C00000D0h: .word 0000h
HSTADRL:
C00000E0h: .word 0000h
HSTCTLL:
C00000F0h: .word 0000h
HSTCTLH:
C0000100h: .word 8000h
INTENB:
C0000110h: .word 0000h
INTPEND:
C0000120h: .word 0000h
CONVSP:
C0000130h: .word 0000h
CONVDP:
C0000140h: .word 0000h
PSIZE:
C0000150h: .word 0004h
PMASK:
C0000160h: .word 0000h
REG_0x0170:
C0000170h: .word 0000h
REG_0x0180:
C0000180h: .word 0000h
REG_0x0190:
C0000190h: .word 0000h
REG_0x01A0:
C00001A0h: .word 0000h
DPYTAP:
C00001B0h: .word 0000h
HCOUNT:
C00001C0h: .word 0000h
VCOUNT:
C00001D0h: .word 0000h
DPYADR:
C00001E0h: .word 0000h
REFCNT:
C00001F0h: .word 0000h
USERFLAGS:
FFDA0000h: .bss 512*8
********************************************************************************
* RESET_VECTOR
********************************************************************************
RESET_VECTOR:
FFDA8000h: 0360                     DINT                        ; Disable Interrupts
FFDA8010h: 0740                     SETF   20h,0,1              ; Set field parameters
FFDA8020h: 09EF FDF0 FFDD           MOVI   STACK_TOP,SP         ; Move immediate (32 bits)
FFDA8050h: 0544                     SETF   4h,0,0               ; Set field parameters
FFDA8060h: 058F 00F3 C000           MOVE   SP,@HSTCTLL+3,0      ; Move field, register to absolute
FFDA8090h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDA80A0h: 09F3 1000 0000           MOVI   00001000h,B3_DPTCH   ; Move immediate (32 bits)
FFDA80D0h: 09F5 0000 0000           MOVI   SCREENBASE_0x0000_0000,B5_WSTART ; Move immediate (32 bits)
FFDA8100h: 09F6 027F 01DF           MOVI   01DF027Fh,B6_WEND    ; Move immediate (32 bits)
FFDA8130h: 5718                     CLR    B8_COLOR0            ; Clear register
FFDA8140h: 5739                     CLR    B9_COLOR1            ; Clear register
FFDA8150h: 09FD FFFF FFFF           MOVI   FFFFFFFFh,B13_PATTRN ; Move immediate (32 bits)
FFDA8180h: 6A7E                     LMO    B3_DPTCH,B14_TEMP    ; Leftmost one bit
FFDA8190h: 059E 0140 C000           MOVE   B14_TEMP,@CONVDP,0   ; Move field, register to absolute
FFDA81C0h: 09F4 0000 003C           MOVI   SCREENBASE_0x003C_0000,B4_OFFSET ; Move immediate (32 bits)
FFDA81F0h: 0D3F 08B4                CALLR  CLEAR_SCREEN         ; Call subroutine relative
FFDA8210h: 09F4 0000 0000           MOVI   SCREENBASE_0x0000_0000,B4_OFFSET ; Move immediate (32 bits)
FFDA8240h: 0D3F 08AF                CALLR  CLEAR_SCREEN         ; Call subroutine relative
FFDA8260h: 09F4 0000 001E           MOVI   SCREENBASE_0x001E_0000,B4_OFFSET ; Move immediate (32 bits)
FFDA8290h: 0D3F 08AA                CALLR  CLEAR_SCREEN         ; Call subroutine relative
FFDA82B0h: 09C1 1DF0                MOVI   1DF0h,A1             ; Move immediate (16 bits)
FFDA82D0h: 0581 0090 C000           MOVE   A1,@DPYSTRT,0        ; Move field, register to absolute
FFDA8300h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDA8310h: 1821                     MOVK   1h,A1                ; Move constant (5 bits)
FFDA8320h: 0581 008F C000           MOVE   A1,@DPYCTL+15,0      ; Move field, register to absolute
FFDA8350h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDA8360h: 5621                     CLR    A1                   ; Clear register
FFDA8370h: 0581 0840 FFEC           MOVE   A1,@FFEC0840h,0      ; Move field, register to absolute
FFDA83A0h: 05C0 0060 C000 00A0 C000 MOVE   @VSBLNK,@DPYINT,0    ; Move field, absolute to absolute
FFDA83F0h: 0542                     SETF   2h,0,0               ; Set field parameters
FFDA8400h: 1861                     MOVK   3h,A1                ; Move constant (5 bits)
FFDA8410h: 0581 0119 C000           MOVE   A1,@INTENB+9,0       ; Move field, register to absolute
FFDA8440h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDA8450h: 0D60                     EINT                        ; Enable Interrupts
FFDA8460h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDA8470h: 0740                     SETF   20h,0,1              ; Set field parameters
FFDA8480h: 09F5 0280 01E0           MOVI   01E00280h,B5_WSTART  ; Move immediate (32 bits)
FFDA84B0h: 0795 0A20 FFEC           MOVE   B5_WSTART,@FFEC0A20h,1 ; Move field, register to absolute
FFDA84E0h: 09F5 0000 0000           MOVI   SCREENBASE_0x0000_0000,B5_WSTART ; Move immediate (32 bits)
FFDA8510h: 09F6 027F 01DF           MOVI   01DF027Fh,B6_WEND    ; Move immediate (32 bits)
FFDA8540h: 0795 0A00 FFEC           MOVE   B5_WSTART,@FFEC0A00h,1 ; Move field, register to absolute
FFDA8570h: 0795 0A40 FFEC           MOVE   B5_WSTART,@CLIP_MIN_XY,1 ; Move field, register to absolute
FFDA85A0h: 0796 0A60 FFEC           MOVE   B6_WEND,@CLIP_MAX_XY,1 ; Move field, register to absolute
FFDA85D0h: 5684                     CLR    A4                   ; Clear register
FFDA85E0h: 054A                     SETF   Ah,0,0               ; Set field parameters
FFDA85F0h: 18C1                     MOVK   6h,A1                ; Move constant (5 bits)
FFDA8600h: 0581 00B5 C000           MOVE   A1,@CONTROL+5,0      ; Move field, register to absolute
FFDA8630h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDA8640h: 07A8 E000 FFEC           MOVE   @CMD_LIST_PTR,A8,1   ; Move field, absolute to register
FFDA8670h: 09ED 1000 FFDD           MOVI   CMD_STACK,A13        ; Move immediate (32 bits)
********************************************************************************
* CMD_LOOP
********************************************************************************
CMD_LOOP:
FFDA86A0h: 0788 0800 FFEC           MOVE   A8,@CURRENT_CMD_PC,1 ; Move field, register to absolute
FFDA86D0h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDA86E0h: 0781 0820 FFEC           MOVE   A1,@CURRENT_CMD,1    ; Move field, register to absolute
FFDA8710h: 0B41 FF57                CMPI   A8h,A1               ; Compare immediate (16 bits)
FFDA8730h: C706                     JRGT   ILLEGAL_CMD          ; Jump relative conditional
FFDA8740h: 24A1                     SLL    5h,A1                ; Shift left logical, constant
FFDA8750h: 0B21 8000 FFDC           ADDI   CMD_ADR_TABLE,A1     ; Add immediate (32 bits)
FFDA8780h: 8621                     MOVE   *A1,A1,1             ; Move field. indirect to register
FFDA8790h: 0161                     JUMP   A1                   ; Jump indirect

********************************************************************************
* ILLEGAL_CMD
********************************************************************************
ILLEGAL_CMD:
FFDA87A0h: 1608                     SUBK   10h,A8               ; Subtract constant (5 bits)
FFDA87B0h: C0FF                     JR     FFDA87B0h            ; Jump relative conditional

********************************************************************************
* COMMAND_2_ARC
********************************************************************************
COMMAND_2_ARC:
FFDA87C0h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDA87D0h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDA87E0h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDA87F0h: C0EA                     JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_4_BENCHMARK_TEXT
********************************************************************************
COMMAND_4_BENCHMARK_TEXT:
FFDA8800h: 07BB 0AE0 FFEC           MOVE   @FFEC0AE0h,B11_INC1,1 ; Move field, absolute to register
FFDA8830h: 07BA 0AC0 FFEC           MOVE   @FFEC0AC0h,B10_COUNT,1 ; Move field, absolute to register
FFDA8860h: 455B                     SUB    B10_COUNT,B11_INC1   ; Subtract registers
FFDA8870h: 09FA 0C80 0000           MOVI   00000C80h,B10_COUNT  ; Move immediate (32 bits)
FFDA88A0h: 5F5B                     MPYU   B10_COUNT,B11_INC1   ; Rd even: Rs*Rd → Rd:Rd+1; Rd odd: Rs*Rd → Rd (unsigned multiply)
FFDA88B0h: 09DA 0064                MOVI   64h,B10_COUNT        ; Move immediate (16 bits)
FFDA88D0h: 5B5B                     DIVU   B10_COUNT,B11_INC1   ; Rd even: Rd:Rd+1/Rs → Rd; Remainder → Rd+1; Rd odd: Rd/Rs → Rd (unsigned divide)
FFDA88E0h: 4D7A                     MOVE   B11_INC1,B10_COUNT   ; Move register to register
FFDA88F0h: 195C                     MOVK   Ah,B12_INC2          ; Move constant (5 bits)
FFDA8900h: 09FB 9680 0098           MOVI   00989680h,B11_INC1   ; Move immediate (32 bits)
FFDA8930h: 09E1 0B00 FFEC           MOVI   FFEC0B00h,A1         ; Move immediate (32 bits)
FFDA8960h: 09C2 0030                MOVI   30h,A2               ; Move immediate (16 bits)
FFDA8980h: 1022                     INC    A2                   ; Increment register
FFDA8990h: 457A                     SUB    B11_INC1,B10_COUNT   ; Subtract registers
FFDA89A0h: C9FD                     JRNC   FFDA8980h            ; Jump relative conditional
FFDA89B0h: 1422                     DEC    A2                   ; Decrement register
FFDA89C0h: 417A                     ADD    B11_INC1,B10_COUNT   ; Add registers
FFDA89D0h: 9041                     MOVE   A2,*A1+,0            ; Move field. register to indirect (postincrement)
FFDA89E0h: 5B9B                     DIVU   B12_INC2,B11_INC1    ; Rd even: Rd:Rd+1/Rs → Rd; Remainder → Rd+1; Rd odd: Rd/Rs → Rd (unsigned divide)
FFDA89F0h: CBF6                     JRNE   FFDA8960h            ; Jump relative conditional
FFDA8A00h: 4D01                     MOVE   A8,A1                ; Move register to register
FFDA8A10h: 09E8 0B00 FFEC           MOVI   FFEC0B00h,A8         ; Move immediate (32 bits)
FFDA8A40h: 1903                     MOVK   8h,A3                ; Move constant (5 bits)
FFDA8A50h: C000 04A1                JR     FFDAD480h            ; Jump relative conditional

********************************************************************************
* COMMAND_6_BINARY_MAP
********************************************************************************
COMMAND_6_BINARY_MAP:
FFDA8A70h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDA8A80h: 4E20                     MOVE   A1,B0_SADDR          ; Move register to register
FFDA8A90h: 9411                     MOVE   *B0_SADDR+,B1_SPTCH,0 ; Move field. indirect (postincrement) to register
FFDA8AA0h: 6A3E                     LMO    B1_SPTCH,B14_TEMP    ; Leftmost one bit
FFDA8AB0h: 059E 0130 C000           MOVE   B14_TEMP,@CONVSP,0   ; Move field, register to absolute
FFDA8AE0h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDA8AF0h: 9617                     MOVE   *B0_SADDR+,B7_DVDX,1 ; Move field. indirect (postincrement) to register
FFDA8B00h: 0FA0                     PIXBLT B,XY                 ; Pixel block transfer and expand, binary to XY
FFDA8B10h: C0B8                     JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_8_CIRCLE
********************************************************************************
COMMAND_8_CIRCLE:
FFDA8B20h: 9503                     MOVE   *A8+,A3,0            ; Move field. indirect (postincrement) to register
FFDA8B30h: 0503                     SEXT   A3,0                 ; Sign extend to long
FFDA8B40h: 0383                     ABS    A3                   ; Store absolute value
FFDA8B50h: CA36                     JREQ   FFDA8EC0h            ; Jump relative conditional
FFDA8B60h: 09E1 0000 0001           MOVI   00010000h,A1         ; Move immediate (32 bits)
FFDA8B90h: 0750                     SETF   10h,0,1              ; Set field parameters
FFDA8BA0h: 5E61                     MPYU   A3,A1                ; Rd even: Rs*Rd → Rd:Rd+1; Rd odd: Rs*Rd → Rd (unsigned multiply)
FFDA8BB0h: 5729                     CLR    A9                   ; Clear register
FFDA8BC0h: 2E01                     SRL    10h,A1               ; Shift right logical, constant
FFDA8BD0h: 4321                     ADDC   A9,A1                ; Add registers with carry
FFDA8BE0h: 4C82                     MOVE   A4,A2                ; Move register to register
FFDA8BF0h: E022                     ADDXY  A1,A2                ; Add registers in XV mode
FFDA8C00h: 4E4A                     MOVE   A2,B10_COUNT         ; Move register to register
FFDA8C10h: 4E4E                     MOVE   A2,B14_TEMP          ; Move register to register
FFDA8C20h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY ; Pixel transfer, register to indirect XY
FFDA8C30h: 4C82                     MOVE   A4,A2                ; Move register to register
FFDA8C40h: E222                     SUBXY  A1,A2                ; Subtract registers in XY mode
FFDA8C50h: 4E4B                     MOVE   A2,B11_INC1          ; Move register to register
FFDA8C60h: 4E4C                     MOVE   A2,B12_INC2          ; Move register to register
FFDA8C70h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY ; Pixel transfer, register to indirect XY
FFDA8C80h: 1832                     MOVK   1h,B2_DADDR          ; Move constant (5 bits)
FFDA8C90h: 2612                     SLL    10h,B2_DADDR         ; Shift left logical, constant
FFDA8CA0h: 4C50                     MOVE   B2_DADDR,B0_SADDR    ; Move register to register
FFDA8CB0h: 1831                     MOVK   1h,B1_SPTCH          ; Move constant (5 bits)
FFDA8CC0h: E230                     SUBXY  B1_SPTCH,B0_SADDR    ; Subtract registers in XY mode
FFDA8CD0h: E051                     ADDXY  B2_DADDR,B1_SPTCH    ; Add registers in XV mode
FFDA8CE0h: 4C57                     MOVE   B2_DADDR,B7_DVDX     ; Move register to register
FFDA8CF0h: E237                     SUBXY  B1_SPTCH,B7_DVDX     ; Subtract registers in XY mode
FFDA8D00h: 5E63                     MPYU   A3,A3                ; Rd even: Rs*Rd → Rd:Rd+1; Rd odd: Rs*Rd → Rd (unsigned multiply)
FFDA8D10h: 4C65                     MOVE   A3,A5                ; Move register to register
FFDA8D20h: 2425                     SLL    1h,A5                ; Shift left logical, constant
FFDA8D30h: 4CA6                     MOVE   A5,A6                ; Move register to register
FFDA8D40h: 2426                     SLL    1h,A6                ; Shift left logical, constant
FFDA8D50h: 4CA7                     MOVE   A5,A7                ; Move register to register
FFDA8D60h: 5E27                     MPYU   A1,A7                ; Rd even: Rs*Rd → Rd:Rd+1; Rd odd: Rs*Rd → Rd (unsigned multiply)
FFDA8D70h: 5E21                     MPYU   A1,A1                ; Rd even: Rs*Rd → Rd:Rd+1; Rd odd: Rs*Rd → Rd (unsigned multiply)
FFDA8D80h: 0740                     SETF   20h,0,1              ; Set field parameters
FFDA8D90h: 4C22                     MOVE   A1,A2                ; Move register to register
FFDA8DA0h: 2422                     SLL    1h,A2                ; Shift left logical, constant
FFDA8DB0h: 4C40                     MOVE   A2,A0                ; Move register to register
FFDA8DC0h: 2420                     SLL    1h,A0                ; Shift left logical, constant
FFDA8DD0h: 2FE1                     SRL    1h,A1                ; Shift right logical, constant
FFDA8DE0h: 2FE3                     SRL    1h,A3                ; Shift right logical, constant
FFDA8DF0h: 44E3                     SUB    A7,A3                ; Subtract registers
FFDA8E00h: 2427                     SLL    1h,A7                ; Shift left logical, constant
FFDA8E10h: 44E1                     SUB    A7,A1                ; Subtract registers
FFDA8E20h: 40A1                     ADD    A5,A1                ; Add registers
FFDA8E30h: 05AA 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A10,0 ; Move field, absolute to register
FFDA8E60h: CB07                     JRNE   FFDA8EE0h            ; Jump relative conditional
FFDA8E70h: 4043                     ADD    A2,A3                ; Add registers
FFDA8E80h: CE19                     JRN    FFDA9020h            ; Jump relative conditional
FFDA8E90h: C025                     JR     FFDA90F0h            ; Jump relative conditional

FFDA8EA0h: 495B                     CMP    B10_COUNT,B11_INC1   ; Compare registers
FFDA8EB0h: CB36                     JRNE   FFDA9220h            ; Jump relative conditional
FFDA8EC0h: C000 FF7C                JR     CMD_LOOP             ; Jump relative conditional

FFDA8EE0h: 099F 0084                MMTM   SP,B8_COLOR0,B13_PATTRN ; If Register n is in the register list: Rn → -*Rd (repeat for n = 0 to 15)
FFDA8F00h: E2FA                     SUBXY  B7_DVDX,B10_COUNT    ; Subtract registers in XY mode
FFDA8F10h: F6FA                     DRAV   B7_DVDX,B10_COUNT    ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA8F20h: E2FB                     SUBXY  B7_DVDX,B11_INC1     ; Subtract registers in XY mode
FFDA8F30h: F6FB                     DRAV   B7_DVDX,B11_INC1     ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA8F40h: 4C3D                     MOVE   B1_SPTCH,B13_PATTRN  ; Move register to register
FFDA8F50h: E2FD                     SUBXY  B7_DVDX,B13_PATTRN   ; Subtract registers in XY mode
FFDA8F60h: 4C18                     MOVE   B0_SADDR,B8_COLOR0   ; Move register to register
FFDA8F70h: E0F8                     ADDXY  B7_DVDX,B8_COLOR0    ; Add registers in XV mode
FFDA8F80h: 4043                     ADD    A2,A3                ; Add registers
FFDA8F90h: CE45                     JRN    FFDA93F0h            ; Jump relative conditional
FFDA8FA0h: C055                     JR     FFDA9500h            ; Jump relative conditional

FFDA8FB0h: E230                     SUBXY  B1_SPTCH,B0_SADDR    ; Subtract registers in XY mode
FFDA8FC0h: 495B                     CMP    B10_COUNT,B11_INC1   ; Compare registers
FFDA8FD0h: CB69                     JRNE   FFDA9670h            ; Jump relative conditional
FFDA8FE0h: 09BF 2100                MMFM   SP,B8_COLOR0,B13_PATTRN ; If Register n is in the register list: *Rs+ → Rn (repeat for n = 0 to 15)
FFDA9000h: C000 FF68                JR     CMD_LOOP             ; Jump relative conditional

FFDA9020h: E05A                     ADDXY  B2_DADDR,B10_COUNT   ; Add registers in XV mode
FFDA9030h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY ; Pixel transfer, register to indirect XY
FFDA9040h: E05B                     ADDXY  B2_DADDR,B11_INC1    ; Add registers in XV mode
FFDA9050h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY ; Pixel transfer, register to indirect XY
FFDA9060h: E25C                     SUBXY  B2_DADDR,B12_INC2    ; Subtract registers in XY mode
FFDA9070h: F13C                     PIXT   B9_COLOR1,*B12_INC2,XY ; Pixel transfer, register to indirect XY
FFDA9080h: E25E                     SUBXY  B2_DADDR,B14_TEMP    ; Subtract registers in XY mode
FFDA9090h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY ; Pixel transfer, register to indirect XY
FFDA90A0h: 4009                     ADD    A0,A9                ; Add registers
FFDA90B0h: 4121                     ADD    A9,A1                ; Add registers
FFDA90C0h: 4123                     ADD    A9,A3                ; Add registers
FFDA90D0h: 4043                     ADD    A2,A3                ; Add registers
FFDA90E0h: CEF3                     JRN    FFDA9020h            ; Jump relative conditional
FFDA90F0h: E01A                     ADDXY  B0_SADDR,B10_COUNT   ; Add registers in XV mode
FFDA9100h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY ; Pixel transfer, register to indirect XY
FFDA9110h: E03B                     ADDXY  B1_SPTCH,B11_INC1    ; Add registers in XV mode
FFDA9120h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY ; Pixel transfer, register to indirect XY
FFDA9130h: E21C                     SUBXY  B0_SADDR,B12_INC2    ; Subtract registers in XY mode
FFDA9140h: F13C                     PIXT   B9_COLOR1,*B12_INC2,XY ; Pixel transfer, register to indirect XY
FFDA9150h: E23E                     SUBXY  B1_SPTCH,B14_TEMP    ; Subtract registers in XY mode
FFDA9160h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY ; Pixel transfer, register to indirect XY
FFDA9170h: 4009                     ADD    A0,A9                ; Add registers
FFDA9180h: 44C7                     SUB    A6,A7                ; Subtract registers
FFDA9190h: 44E1                     SUB    A7,A1                ; Subtract registers
FFDA91A0h: 4121                     ADD    A9,A1                ; Add registers
FFDA91B0h: 40A1                     ADD    A5,A1                ; Add registers
FFDA91C0h: C5CD                     JRGE   FFDA8EA0h            ; Jump relative conditional
FFDA91D0h: 44E3                     SUB    A7,A3                ; Subtract registers
FFDA91E0h: 4123                     ADD    A9,A3                ; Add registers
FFDA91F0h: 4043                     ADD    A2,A3                ; Add registers
FFDA9200h: C5EE                     JRGE   FFDA90F0h            ; Jump relative conditional
FFDA9210h: C0E0                     JR     FFDA9020h            ; Jump relative conditional

FFDA9220h: E0FA                     ADDXY  B7_DVDX,B10_COUNT    ; Add registers in XV mode
FFDA9230h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY ; Pixel transfer, register to indirect XY
FFDA9240h: E0FE                     ADDXY  B7_DVDX,B14_TEMP     ; Add registers in XV mode
FFDA9250h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY ; Pixel transfer, register to indirect XY
FFDA9260h: E2FB                     SUBXY  B7_DVDX,B11_INC1     ; Subtract registers in XY mode
FFDA9270h: 495B                     CMP    B10_COUNT,B11_INC1   ; Compare registers
FFDA9280h: CAC3                     JREQ   FFDA8EC0h            ; Jump relative conditional
FFDA9290h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY ; Pixel transfer, register to indirect XY
FFDA92A0h: E2FC                     SUBXY  B7_DVDX,B12_INC2     ; Subtract registers in XY mode
FFDA92B0h: F13C                     PIXT   B9_COLOR1,*B12_INC2,XY ; Pixel transfer, register to indirect XY
FFDA92C0h: 44C7                     SUB    A6,A7                ; Subtract registers
FFDA92D0h: 44E1                     SUB    A7,A1                ; Subtract registers
FFDA92E0h: 40A1                     ADD    A5,A1                ; Add registers
FFDA92F0h: C5F2                     JRGE   FFDA9220h            ; Jump relative conditional
FFDA9300h: E01A                     ADDXY  B0_SADDR,B10_COUNT   ; Add registers in XV mode
FFDA9310h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY ; Pixel transfer, register to indirect XY
FFDA9320h: E23E                     SUBXY  B1_SPTCH,B14_TEMP    ; Subtract registers in XY mode
FFDA9330h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY ; Pixel transfer, register to indirect XY
FFDA9340h: E03B                     ADDXY  B1_SPTCH,B11_INC1    ; Add registers in XV mode
FFDA9350h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY ; Pixel transfer, register to indirect XY
FFDA9360h: E21C                     SUBXY  B0_SADDR,B12_INC2    ; Subtract registers in XY mode
FFDA9370h: F13C                     PIXT   B9_COLOR1,*B12_INC2,XY ; Pixel transfer, register to indirect XY
FFDA9380h: 44C7                     SUB    A6,A7                ; Subtract registers
FFDA9390h: 4009                     ADD    A0,A9                ; Add registers
FFDA93A0h: 44E1                     SUB    A7,A1                ; Subtract registers
FFDA93B0h: 40A1                     ADD    A5,A1                ; Add registers
FFDA93C0h: 4121                     ADD    A9,A1                ; Add registers
FFDA93D0h: C5E4                     JRGE   FFDA9220h            ; Jump relative conditional
FFDA93E0h: C0F1                     JR     FFDA9300h            ; Jump relative conditional

FFDA93F0h: E03A                     ADDXY  B1_SPTCH,B10_COUNT   ; Add registers in XV mode
FFDA9400h: F6FA                     DRAV   B7_DVDX,B10_COUNT    ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA9410h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY ; Pixel transfer, register to indirect XY
FFDA9420h: E03B                     ADDXY  B1_SPTCH,B11_INC1    ; Add registers in XV mode
FFDA9430h: F6FB                     DRAV   B7_DVDX,B11_INC1     ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA9440h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY ; Pixel transfer, register to indirect XY
FFDA9450h: E21C                     SUBXY  B0_SADDR,B12_INC2    ; Subtract registers in XY mode
FFDA9460h: F6FC                     DRAV   B7_DVDX,B12_INC2     ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA9470h: F13C                     PIXT   B9_COLOR1,*B12_INC2,XY ; Pixel transfer, register to indirect XY
FFDA9480h: E21E                     SUBXY  B0_SADDR,B14_TEMP    ; Subtract registers in XY mode
FFDA9490h: F6FE                     DRAV   B7_DVDX,B14_TEMP     ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA94A0h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY ; Pixel transfer, register to indirect XY
FFDA94B0h: 4009                     ADD    A0,A9                ; Add registers
FFDA94C0h: 4121                     ADD    A9,A1                ; Add registers
FFDA94D0h: 4123                     ADD    A9,A3                ; Add registers
FFDA94E0h: 4043                     ADD    A2,A3                ; Add registers
FFDA94F0h: CEEF                     JRN    FFDA93F0h            ; Jump relative conditional
FFDA9500h: E05A                     ADDXY  B2_DADDR,B10_COUNT   ; Add registers in XV mode
FFDA9510h: F6FA                     DRAV   B7_DVDX,B10_COUNT    ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA9520h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY ; Pixel transfer, register to indirect XY
FFDA9530h: E1BB                     ADDXY  B13_PATTRN,B11_INC1  ; Add registers in XV mode
FFDA9540h: F6FB                     DRAV   B7_DVDX,B11_INC1     ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA9550h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY ; Pixel transfer, register to indirect XY
FFDA9560h: E31C                     SUBXY  B8_COLOR0,B12_INC2   ; Subtract registers in XY mode
FFDA9570h: F6FC                     DRAV   B7_DVDX,B12_INC2     ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA9580h: F13C                     PIXT   B9_COLOR1,*B12_INC2,XY ; Pixel transfer, register to indirect XY
FFDA9590h: E25E                     SUBXY  B2_DADDR,B14_TEMP    ; Subtract registers in XY mode
FFDA95A0h: F6FE                     DRAV   B7_DVDX,B14_TEMP     ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA95B0h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY ; Pixel transfer, register to indirect XY
FFDA95C0h: 4009                     ADD    A0,A9                ; Add registers
FFDA95D0h: 44C7                     SUB    A6,A7                ; Subtract registers
FFDA95E0h: 44E1                     SUB    A7,A1                ; Subtract registers
FFDA95F0h: 4121                     ADD    A9,A1                ; Add registers
FFDA9600h: 40A1                     ADD    A5,A1                ; Add registers
FFDA9610h: C599                     JRGE   FFDA8FB0h            ; Jump relative conditional
FFDA9620h: 44E3                     SUB    A7,A3                ; Subtract registers
FFDA9630h: 4123                     ADD    A9,A3                ; Add registers
FFDA9640h: 4043                     ADD    A2,A3                ; Add registers
FFDA9650h: C5EA                     JRGE   FFDA9500h            ; Jump relative conditional
FFDA9660h: C0D8                     JR     FFDA93F0h            ; Jump relative conditional

FFDA9670h: E01A                     ADDXY  B0_SADDR,B10_COUNT   ; Add registers in XV mode
FFDA9680h: 495B                     CMP    B10_COUNT,B11_INC1   ; Compare registers
FFDA9690h: CA94                     JREQ   FFDA8FE0h            ; Jump relative conditional
FFDA96A0h: E2FA                     SUBXY  B7_DVDX,B10_COUNT    ; Subtract registers in XY mode
FFDA96B0h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY ; Pixel transfer, register to indirect XY
FFDA96C0h: E0FE                     ADDXY  B7_DVDX,B14_TEMP     ; Add registers in XV mode
FFDA96D0h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY ; Pixel transfer, register to indirect XY
FFDA96E0h: E21B                     SUBXY  B0_SADDR,B11_INC1    ; Subtract registers in XY mode
FFDA96F0h: F6FB                     DRAV   B7_DVDX,B11_INC1     ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA9700h: E21C                     SUBXY  B0_SADDR,B12_INC2    ; Subtract registers in XY mode
FFDA9710h: F6FC                     DRAV   B7_DVDX,B12_INC2     ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA9720h: 44C7                     SUB    A6,A7                ; Subtract registers
FFDA9730h: 44E1                     SUB    A7,A1                ; Subtract registers
FFDA9740h: 40A1                     ADD    A5,A1                ; Add registers
FFDA9750h: C5F1                     JRGE   FFDA9670h            ; Jump relative conditional
FFDA9760h: E05A                     ADDXY  B2_DADDR,B10_COUNT   ; Add registers in XV mode
FFDA9770h: F6FA                     DRAV   B7_DVDX,B10_COUNT    ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA9780h: F13A                     PIXT   B9_COLOR1,*B10_COUNT,XY ; Pixel transfer, register to indirect XY
FFDA9790h: E25E                     SUBXY  B2_DADDR,B14_TEMP    ; Subtract registers in XY mode
FFDA97A0h: F6FE                     DRAV   B7_DVDX,B14_TEMP     ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA97B0h: F13E                     PIXT   B9_COLOR1,*B14_TEMP,XY ; Pixel transfer, register to indirect XY
FFDA97C0h: E1BB                     ADDXY  B13_PATTRN,B11_INC1  ; Add registers in XV mode
FFDA97D0h: F6FB                     DRAV   B7_DVDX,B11_INC1     ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA97E0h: F13B                     PIXT   B9_COLOR1,*B11_INC1,XY ; Pixel transfer, register to indirect XY
FFDA97F0h: E31C                     SUBXY  B8_COLOR0,B12_INC2   ; Subtract registers in XY mode
FFDA9800h: F6FC                     DRAV   B7_DVDX,B12_INC2     ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDA9810h: F13C                     PIXT   B9_COLOR1,*B12_INC2,XY ; Pixel transfer, register to indirect XY
FFDA9820h: 44C7                     SUB    A6,A7                ; Subtract registers
FFDA9830h: 4009                     ADD    A0,A9                ; Add registers
FFDA9840h: 44E1                     SUB    A7,A1                ; Subtract registers
FFDA9850h: 40A1                     ADD    A5,A1                ; Add registers
FFDA9860h: 4121                     ADD    A9,A1                ; Add registers
FFDA9870h: C5DF                     JRGE   FFDA9670h            ; Jump relative conditional
FFDA9880h: C0ED                     JR     FFDA9760h            ; Jump relative conditional

********************************************************************************
* COMMAND_10_COPY_RECTANGLE
********************************************************************************
COMMAND_10_COPY_RECTANGLE:
FFDA9890h: 4C71                     MOVE   B3_DPTCH,B1_SPTCH    ; Move register to register
FFDA98A0h: 6A3E                     LMO    B1_SPTCH,B14_TEMP    ; Leftmost one bit
FFDA98B0h: 059E 0130 C000           MOVE   B14_TEMP,@CONVSP,0   ; Move field, register to absolute
FFDA98E0h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDA98F0h: 9702                     MOVE   *A8+,A2,1            ; Move field. indirect (postincrement) to register
FFDA9900h: 4E20                     MOVE   A1,B0_SADDR          ; Move register to register
FFDA9910h: 4E47                     MOVE   A2,B7_DVDX           ; Move register to register
FFDA9920h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDA9930h: 4EB1                     MOVE   B5_WSTART,A1         ; Move register to register
FFDA9940h: 4ED3                     MOVE   B6_WEND,A3           ; Move register to register
FFDA9950h: 4C15                     MOVE   B0_SADDR,B5_WSTART   ; Move register to register
FFDA9960h: 56D6                     CLR    B6_WEND              ; Clear register
FFDA9970h: 1436                     DEC    B6_WEND              ; Decrement register
FFDA9980h: E0B6                     ADDXY  B5_WSTART,B6_WEND    ; Add registers in XV mode
FFDA9990h: E0F6                     ADDXY  B7_DVDX,B6_WEND      ; Add registers in XV mode
FFDA99A0h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDA99B0h: 09E5 00B7 C000           MOVI   CONTROL+7,A5         ; Move immediate (32 bits)
FFDA99E0h: 81E5                     MOVE   SP,*A5,0             ; Move field. register to indirect
FFDA99F0h: 81E5                     MOVE   SP,*A5,0             ; Move field. register to indirect
FFDA9A00h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDA9A10h: 1826                     MOVK   1h,A6                ; Move constant (5 bits)
FFDA9A20h: 90C5                     MOVE   A6,*A5+,0            ; Move field. register to indirect (postincrement)
FFDA9A30h: CD07                     JRNV   FFDA9AB0h            ; Jump relative conditional
FFDA9A40h: 81E5                     MOVE   SP,*A5,0             ; Move field. register to indirect
FFDA9A50h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDA9A60h: 4E25                     MOVE   A1,B5_WSTART         ; Move register to register
FFDA9A70h: 4E66                     MOVE   A3,B6_WEND           ; Move register to register
FFDA9A80h: 0F60                     PIXBLT XY,XY                ; Pixel block transfer, XY to XY
FFDA9A90h: C000 FEBF                JR     CMD_LOOP             ; Jump relative conditional

FFDA9AB0h: 4E25                     MOVE   A1,B5_WSTART         ; Move register to register
FFDA9AC0h: 4E66                     MOVE   A3,B6_WEND           ; Move register to register
FFDA9AD0h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDA9AE0h: 4E47                     MOVE   A2,B7_DVDX           ; Move register to register
FFDA9AF0h: 56C6                     CLR    A6                   ; Clear register
FFDA9B00h: E450                     CMPXY  B2_DADDR,B0_SADDR    ; Compare X and V halves of registers
FFDA9B10h: CD02                     JRNV   FFDA9B40h            ; Jump relative conditional
FFDA9B20h: 1026                     INC    A6                   ; Increment register
FFDA9B30h: E450                     CMPXY  B2_DADDR,B0_SADDR    ; Compare X and V halves of registers
FFDA9B40h: C901                     JRNC   FFDA9B60h            ; Jump relative conditional
FFDA9B50h: 1046                     ADDK   2h,A6                ; Add constant (5 bits)
FFDA9B60h: 0542                     SETF   2h,0,0               ; Set field parameters
FFDA9B70h: 80C5                     MOVE   A6,*A5,0             ; Move field. register to indirect
FFDA9B80h: 80C5                     MOVE   A6,*A5,0             ; Move field. register to indirect
FFDA9B90h: 0F60                     PIXBLT XY,XY                ; Pixel block transfer, XY to XY
FFDA9BA0h: 81E5                     MOVE   SP,*A5,0             ; Move field. register to indirect
FFDA9BB0h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDA9BC0h: C000 FEAC                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_12_DOT
********************************************************************************
COMMAND_12_DOT:
FFDA9BE0h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDA9BF0h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY ; Pixel transfer, register to indirect XY
FFDA9C00h: 05A1 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A1,0 ; Move field, absolute to register
FFDA9C30h: CA00 FEA5                JREQ   CMD_LOOP             ; Jump relative conditional
FFDA9C50h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDA9C60h: E1D2                     ADDXY  B14_TEMP,B2_DADDR    ; Add registers in XV mode
FFDA9C70h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY ; Pixel transfer, register to indirect XY
FFDA9C80h: C000 FEA0                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_14_ERASE_RECTANGLE
********************************************************************************
COMMAND_14_ERASE_RECTANGLE:
FFDA9CA0h: 05A1 00B0 C000           MOVE   @CONTROL,A1,0        ; Move field, absolute to register
FFDA9CD0h: 4C23                     MOVE   A1,A3                ; Move register to register
FFDA9CE0h: 0B81 7C20 FFFF           ANDI   83DFh,A1             ; AND immediate (32 bits)
FFDA9D10h: 0581 00B0 C000           MOVE   A1,@CONTROL,0        ; Move field, register to absolute
FFDA9D40h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDA9D50h: 4E27                     MOVE   A1,B7_DVDX           ; Move register to register
FFDA9D60h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDA9D70h: 4F32                     MOVE   B9_COLOR1,A2         ; Move register to register
FFDA9D80h: 4D19                     MOVE   B8_COLOR0,B9_COLOR1  ; Move register to register
FFDA9D90h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDA9DA0h: 4E49                     MOVE   A2,B9_COLOR1         ; Move register to register
FFDA9DB0h: 0583 00B0 C000           MOVE   A3,@CONTROL,0        ; Move field, register to absolute
FFDA9DE0h: C000 FE8A                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_16_FILL_CIRCLE
********************************************************************************
COMMAND_16_FILL_CIRCLE:
FFDA9E00h: A31F                     MOVE   B8_COLOR0,-*SP,1     ; Move field. register to indirect (predecrement)
FFDA9E10h: 9503                     MOVE   *A8+,A3,0            ; Move field. indirect (postincrement) to register
FFDA9E20h: 0503                     SEXT   A3,0                 ; Sign extend to long
FFDA9E30h: 0383                     ABS    A3                   ; Store absolute value
FFDA9E40h: CA39                     JREQ   FFDAA1E0h            ; Jump relative conditional
FFDA9E50h: 09E1 0000 0001           MOVI   00010000h,A1         ; Move immediate (32 bits)
FFDA9E80h: 0750                     SETF   10h,0,1              ; Set field parameters
FFDA9E90h: 5E61                     MPYU   A3,A1                ; Rd even: Rs*Rd → Rd:Rd+1; Rd odd: Rs*Rd → Rd (unsigned multiply)
FFDA9EA0h: 5729                     CLR    A9                   ; Clear register
FFDA9EB0h: 2E01                     SRL    10h,A1               ; Shift right logical, constant
FFDA9EC0h: 4321                     ADDC   A9,A1                ; Add registers with carry
FFDA9ED0h: 1838                     MOVK   1h,B8_COLOR0         ; Move constant (5 bits)
FFDA9EE0h: 4D11                     MOVE   B8_COLOR0,B1_SPTCH   ; Move register to register
FFDA9EF0h: 3211                     RL     10h,B1_SPTCH         ; Rotate left, constant
FFDA9F00h: 184B                     MOVK   2h,A11               ; Move constant (5 bits)
FFDA9F10h: 4C82                     MOVE   A4,A2                ; Move register to register
FFDA9F20h: E222                     SUBXY  A1,A2                ; Subtract registers in XY mode
FFDA9F30h: 4E42                     MOVE   A2,B2_DADDR          ; Move register to register
FFDA9F40h: 4E40                     MOVE   A2,B0_SADDR          ; Move register to register
FFDA9F50h: 4E27                     MOVE   A1,B7_DVDX           ; Move register to register
FFDA9F60h: E0F7                     ADDXY  B7_DVDX,B7_DVDX      ; Add registers in XV mode
FFDA9F70h: E117                     ADDXY  B8_COLOR0,B7_DVDX    ; Add registers in XV mode
FFDA9F80h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDA9F90h: 4EFA                     MOVE   B7_DVDX,A10          ; Move register to register
FFDA9FA0h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDA9FB0h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDA9FC0h: 4C12                     MOVE   B0_SADDR,B2_DADDR    ; Move register to register
FFDA9FD0h: E032                     ADDXY  B1_SPTCH,B2_DADDR    ; Add registers in XV mode
FFDA9FE0h: E230                     SUBXY  B1_SPTCH,B0_SADDR    ; Subtract registers in XY mode
FFDA9FF0h: 5E63                     MPYU   A3,A3                ; Rd even: Rs*Rd → Rd:Rd+1; Rd odd: Rs*Rd → Rd (unsigned multiply)
FFDAA000h: 4C65                     MOVE   A3,A5                ; Move register to register
FFDAA010h: 2425                     SLL    1h,A5                ; Shift left logical, constant
FFDAA020h: 4CA6                     MOVE   A5,A6                ; Move register to register
FFDAA030h: 2426                     SLL    1h,A6                ; Shift left logical, constant
FFDAA040h: 4CA7                     MOVE   A5,A7                ; Move register to register
FFDAA050h: 5E27                     MPYU   A1,A7                ; Rd even: Rs*Rd → Rd:Rd+1; Rd odd: Rs*Rd → Rd (unsigned multiply)
FFDAA060h: 5E21                     MPYU   A1,A1                ; Rd even: Rs*Rd → Rd:Rd+1; Rd odd: Rs*Rd → Rd (unsigned multiply)
FFDAA070h: 0740                     SETF   20h,0,1              ; Set field parameters
FFDAA080h: 4C22                     MOVE   A1,A2                ; Move register to register
FFDAA090h: 2422                     SLL    1h,A2                ; Shift left logical, constant
FFDAA0A0h: 4C40                     MOVE   A2,A0                ; Move register to register
FFDAA0B0h: 2420                     SLL    1h,A0                ; Shift left logical, constant
FFDAA0C0h: 2FE1                     SRL    1h,A1                ; Shift right logical, constant
FFDAA0D0h: 2FE3                     SRL    1h,A3                ; Shift right logical, constant
FFDAA0E0h: 44E3                     SUB    A7,A3                ; Subtract registers
FFDAA0F0h: 2427                     SLL    1h,A7                ; Shift left logical, constant
FFDAA100h: 44E1                     SUB    A7,A1                ; Subtract registers
FFDAA110h: 40A1                     ADD    A5,A1                ; Add registers
FFDAA120h: 4043                     ADD    A2,A3                ; Add registers
FFDAA130h: CE0D                     JRN    FFDAA210h            ; Jump relative conditional
FFDAA140h: C013                     JR     FFDAA280h            ; Jump relative conditional

FFDAA150h: 4EFA                     MOVE   B7_DVDX,A10          ; Move register to register
FFDAA160h: 4E5C                     MOVE   B2_DADDR,A12         ; Move register to register
FFDAA170h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAA180h: 4C12                     MOVE   B0_SADDR,B2_DADDR    ; Move register to register
FFDAA190h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDAA1A0h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAA1B0h: 4F82                     MOVE   A12,B2_DADDR         ; Move register to register
FFDAA1C0h: E584                     CMPXY  A12,A4               ; Compare X and V halves of registers
FFDAA1D0h: CF23                     JRNN   FFDAA410h            ; Jump relative conditional
FFDAA1E0h: 97F8                     MOVE   *SP+,B8_COLOR0,1     ; Move field. indirect (postincrement) to register
FFDAA1F0h: C000 FE49                JR     CMD_LOOP             ; Jump relative conditional

FFDAA210h: E230                     SUBXY  B1_SPTCH,B0_SADDR    ; Subtract registers in XY mode
FFDAA220h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDAA230h: 4009                     ADD    A0,A9                ; Add registers
FFDAA240h: 4121                     ADD    A9,A1                ; Add registers
FFDAA250h: 4123                     ADD    A9,A3                ; Add registers
FFDAA260h: 4043                     ADD    A2,A3                ; Add registers
FFDAA270h: CEF9                     JRN    FFDAA210h            ; Jump relative conditional
FFDAA280h: 4EFA                     MOVE   B7_DVDX,A10          ; Move register to register
FFDAA290h: 4E5C                     MOVE   B2_DADDR,A12         ; Move register to register
FFDAA2A0h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAA2B0h: 4C12                     MOVE   B0_SADDR,B2_DADDR    ; Move register to register
FFDAA2C0h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDAA2D0h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAA2E0h: E230                     SUBXY  B1_SPTCH,B0_SADDR    ; Subtract registers in XY mode
FFDAA2F0h: E110                     ADDXY  B8_COLOR0,B0_SADDR   ; Add registers in XV mode
FFDAA300h: E14C                     ADDXY  A10,A12              ; Add registers in XV mode
FFDAA310h: 4F82                     MOVE   A12,B2_DADDR         ; Move register to register
FFDAA320h: EC12                     MOVX   B0_SADDR,B2_DADDR    ; Move X half of register
FFDAA330h: E36A                     SUBXY  A11,A10              ; Subtract registers in XY mode
FFDAA340h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDAA350h: EE37                     MOVY   B1_SPTCH,B7_DVDX     ; Move Y half of register
FFDAA360h: 4009                     ADD    A0,A9                ; Add registers
FFDAA370h: 44C7                     SUB    A6,A7                ; Subtract registers
FFDAA380h: 44E1                     SUB    A7,A1                ; Subtract registers
FFDAA390h: 4121                     ADD    A9,A1                ; Add registers
FFDAA3A0h: 40A1                     ADD    A5,A1                ; Add registers
FFDAA3B0h: C5D9                     JRGE   FFDAA150h            ; Jump relative conditional
FFDAA3C0h: 44E3                     SUB    A7,A3                ; Subtract registers
FFDAA3D0h: 4123                     ADD    A9,A3                ; Add registers
FFDAA3E0h: 4043                     ADD    A2,A3                ; Add registers
FFDAA3F0h: C5E8                     JRGE   FFDAA280h            ; Jump relative conditional
FFDAA400h: C0E0                     JR     FFDAA210h            ; Jump relative conditional

FFDAA410h: E112                     ADDXY  B8_COLOR0,B2_DADDR   ; Add registers in XV mode
FFDAA420h: E110                     ADDXY  B8_COLOR0,B0_SADDR   ; Add registers in XV mode
FFDAA430h: E36A                     SUBXY  A11,A10              ; Subtract registers in XY mode
FFDAA440h: 4E5C                     MOVE   B2_DADDR,A12         ; Move register to register
FFDAA450h: E584                     CMPXY  A12,A4               ; Compare X and V halves of registers
FFDAA460h: CED7                     JRN    FFDAA1E0h            ; Jump relative conditional
FFDAA470h: 44C7                     SUB    A6,A7                ; Subtract registers
FFDAA480h: 44E1                     SUB    A7,A1                ; Subtract registers
FFDAA490h: 40A1                     ADD    A5,A1                ; Add registers
FFDAA4A0h: C5F6                     JRGE   FFDAA410h            ; Jump relative conditional
FFDAA4B0h: E112                     ADDXY  B8_COLOR0,B2_DADDR   ; Add registers in XV mode
FFDAA4C0h: E032                     ADDXY  B1_SPTCH,B2_DADDR    ; Add registers in XV mode
FFDAA4D0h: E110                     ADDXY  B8_COLOR0,B0_SADDR   ; Add registers in XV mode
FFDAA4E0h: E230                     SUBXY  B1_SPTCH,B0_SADDR    ; Subtract registers in XY mode
FFDAA4F0h: E36A                     SUBXY  A11,A10              ; Subtract registers in XY mode
FFDAA500h: 4E5C                     MOVE   B2_DADDR,A12         ; Move register to register
FFDAA510h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDAA520h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAA530h: 4C12                     MOVE   B0_SADDR,B2_DADDR    ; Move register to register
FFDAA540h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDAA550h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAA560h: 4F82                     MOVE   A12,B2_DADDR         ; Move register to register
FFDAA570h: 44C7                     SUB    A6,A7                ; Subtract registers
FFDAA580h: 4009                     ADD    A0,A9                ; Add registers
FFDAA590h: 44E1                     SUB    A7,A1                ; Subtract registers
FFDAA5A0h: 40A1                     ADD    A5,A1                ; Add registers
FFDAA5B0h: 4121                     ADD    A9,A1                ; Add registers
FFDAA5C0h: C5E4                     JRGE   FFDAA410h            ; Jump relative conditional
FFDAA5D0h: C0ED                     JR     FFDAA4B0h            ; Jump relative conditional

********************************************************************************
* COMMAND_18_FILL_RECTANGLE
********************************************************************************
COMMAND_18_FILL_RECTANGLE:
FFDAA5E0h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDAA5F0h: 4E27                     MOVE   A1,B7_DVDX           ; Move register to register
FFDAA600h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDAA610h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAA620h: C000 FE06                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_20_21
********************************************************************************
COMMAND_20_21:
FFDAA640h: 09F1 0001 0001           MOVI   00010001h,B1_SPTCH   ; Move immediate (32 bits)
FFDAA670h: 4CD0                     MOVE   B6_WEND,B0_SADDR     ; Move register to register
FFDAA680h: E2B0                     SUBXY  B5_WSTART,B0_SADDR   ; Subtract registers in XY mode
FFDAA690h: E030                     ADDXY  B1_SPTCH,B0_SADDR    ; Add registers in XV mode
FFDAA6A0h: EC17                     MOVX   B0_SADDR,B7_DVDX     ; Move X half of register
FFDAA6B0h: EE37                     MOVY   B1_SPTCH,B7_DVDX     ; Move Y half of register
FFDAA6C0h: 4CB2                     MOVE   B5_WSTART,B2_DADDR   ; Move register to register
FFDAA6D0h: E852                     CVXYL  B2_DADDR,B2_DADDR    ; Convert XY address to linear address
FFDAA6E0h: 0FC0                     FILL   L                    ; Fill array with processed pixels, linear
FFDAA6F0h: 4CB2                     MOVE   B5_WSTART,B2_DADDR   ; Move register to register
FFDAA700h: EED2                     MOVY   B6_WEND,B2_DADDR     ; Move Y half of register
FFDAA710h: E852                     CVXYL  B2_DADDR,B2_DADDR    ; Convert XY address to linear address
FFDAA720h: 0FC0                     FILL   L                    ; Fill array with processed pixels, linear
FFDAA730h: EC37                     MOVX   B1_SPTCH,B7_DVDX     ; Move X half of register
FFDAA740h: EE17                     MOVY   B0_SADDR,B7_DVDX     ; Move Y half of register
FFDAA750h: 5631                     CLR    B1_SPTCH             ; Clear register
FFDAA760h: 05A1 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A1,0 ; Move field, absolute to register
FFDAA790h: CA02                     JREQ   FFDAA7C0h            ; Jump relative conditional
FFDAA7A0h: 1831                     MOVK   1h,B1_SPTCH          ; Move constant (5 bits)
FFDAA7B0h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDAA7C0h: 4CB2                     MOVE   B5_WSTART,B2_DADDR   ; Move register to register
FFDAA7D0h: E852                     CVXYL  B2_DADDR,B2_DADDR    ; Convert XY address to linear address
FFDAA7E0h: 0FC0                     FILL   L                    ; Fill array with processed pixels, linear
FFDAA7F0h: 4CB2                     MOVE   B5_WSTART,B2_DADDR   ; Move register to register
FFDAA800h: ECD2                     MOVX   B6_WEND,B2_DADDR     ; Move X half of register
FFDAA810h: E232                     SUBXY  B1_SPTCH,B2_DADDR    ; Subtract registers in XY mode
FFDAA820h: E852                     CVXYL  B2_DADDR,B2_DADDR    ; Convert XY address to linear address
FFDAA830h: 0FC0                     FILL   L                    ; Fill array with processed pixels, linear
FFDAA840h: C000 FDE4                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_22_23
********************************************************************************
COMMAND_22_23:
FFDAA860h: 9503                     MOVE   *A8+,A3,0            ; Move field. indirect (postincrement) to register
FFDAA870h: 9702                     MOVE   *A8+,A2,1            ; Move field. indirect (postincrement) to register
FFDAA880h: 4E41                     MOVE   A2,B1_SPTCH          ; Move register to register
FFDAA890h: 9502                     MOVE   *A8+,A2,0            ; Move field. indirect (postincrement) to register
FFDAA8A0h: 4C63                     MOVE   A3,A3                ; Move register to register
FFDAA8B0h: CA00 FDDD                JREQ   CMD_LOOP             ; Jump relative conditional
FFDAA8D0h: 4F11                     MOVE   B8_COLOR0,A1         ; Move register to register
FFDAA8E0h: 4E48                     MOVE   A2,B8_COLOR0         ; Move register to register
FFDAA8F0h: 09F0 0001 0001           MOVI   00010001h,B0_SADDR   ; Move immediate (32 bits)
FFDAA920h: 9637                     MOVE   *B1_SPTCH+,B7_DVDX,1 ; Move field. indirect (postincrement) to register
FFDAA930h: 4CF2                     MOVE   B7_DVDX,B2_DADDR     ; Move register to register
FFDAA940h: 2612                     SLL    10h,B2_DADDR         ; Shift left logical, constant
FFDAA950h: ED12                     MOVX   B8_COLOR0,B2_DADDR   ; Move X half of register
FFDAA960h: ED17                     MOVX   B8_COLOR0,B7_DVDX    ; Move X half of register
FFDAA970h: 4857                     CMP    B2_DADDR,B7_DVDX     ; Compare registers
FFDAA980h: C503                     JRGE   FFDAA9C0h            ; Jump relative conditional
FFDAA990h: 4CFA                     MOVE   B7_DVDX,B10_COUNT    ; Move register to register
FFDAA9A0h: 4C57                     MOVE   B2_DADDR,B7_DVDX     ; Move register to register
FFDAA9B0h: 4D52                     MOVE   B10_COUNT,B2_DADDR   ; Move register to register
FFDAA9C0h: E65A                     CPW    B2_DADDR,B10_COUNT   ; Compare point to window
FFDAA9D0h: CC0B                     JRV    FFDAAA90h            ; Jump relative conditional
FFDAA9E0h: E6FA                     CPW    B7_DVDX,B10_COUNT    ; Compare point to window
FFDAA9F0h: CC0B                     JRV    FFDAAAB0h            ; Jump relative conditional
FFDAAA00h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDAAA10h: E017                     ADDXY  B0_SADDR,B7_DVDX     ; Add registers in XV mode
FFDAAA20h: E852                     CVXYL  B2_DADDR,B2_DADDR    ; Convert XY address to linear address
FFDAAA30h: 0FC0                     FILL   L                    ; Fill array with processed pixels, linear
FFDAAA40h: 1038                     INC    B8_COLOR0            ; Increment register
FFDAAA50h: 3E83                     DSJS   A3,FFDAA920h         ; Decrement register and skip jump short
FFDAAA60h: 4E28                     MOVE   A1,B8_COLOR0         ; Move register to register
FFDAAA70h: C000 FDC1                JR     CMD_LOOP             ; Jump relative conditional

FFDAAA90h: E6FB                     CPW    B7_DVDX,B11_INC1     ; Compare point to window
FFDAAAA0h: CC04                     JRV    FFDAAAF0h            ; Jump relative conditional
FFDAAAB0h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDAAAC0h: E017                     ADDXY  B0_SADDR,B7_DVDX     ; Add registers in XV mode
FFDAAAD0h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAAAE0h: C0F5                     JR     FFDAAA40h            ; Jump relative conditional

FFDAAAF0h: 515B                     AND    B10_COUNT,B11_INC1   ; AND registers
FFDAAB00h: CAFA                     JREQ   FFDAAAB0h            ; Jump relative conditional
FFDAAB10h: EED2                     MOVY   B6_WEND,B2_DADDR     ; Move Y half of register
FFDAAB20h: 1EFB                     BTST   8h,B11_INC1          ; Set status on value of: bit K in Rd
FFDAAB30h: CB01                     JRNE   FFDAAB50h            ; Jump relative conditional
FFDAAB40h: EEB2                     MOVY   B5_WSTART,B2_DADDR   ; Move Y half of register
FFDAAB50h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY ; Pixel transfer, register to indirect XY
FFDAAB60h: C0ED                     JR     FFDAAA40h            ; Jump relative conditional

********************************************************************************
* COMMAND_34_35
********************************************************************************
COMMAND_34_35:
FFDAAB70h: 9507                     MOVE   *A8+,A7,0            ; Move field. indirect (postincrement) to register
FFDAAB80h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDAAB90h: 9700                     MOVE   *A8+,A0,1            ; Move field. indirect (postincrement) to register
FFDAABA0h: 4CE7                     MOVE   A7,A7                ; Move register to register
FFDAABB0h: CA00 FDAD                JREQ   CMD_LOOP             ; Jump relative conditional
FFDAABD0h: 4C2A                     MOVE   A1,A10               ; Move register to register
FFDAABE0h: 270A                     SLL    18h,A10              ; Shift left logical, constant
FFDAABF0h: 2C8A                     SRL    1Ch,A10              ; Shift right logical, constant
FFDAAC00h: 1FA1                     BTST   2h,A1                ; Set status on value of: bit K in Rd
FFDAAC10h: CB13                     JRNE   FFDAAD50h            ; Jump relative conditional
FFDAAC20h: 4C29                     MOVE   A1,A9                ; Move register to register
FFDAAC30h: 2689                     SLL    14h,A9               ; Shift left logical, constant
FFDAAC40h: 2C89                     SRL    1Ch,A9               ; Shift right logical, constant
FFDAAC50h: 2609                     SLL    10h,A9               ; Shift left logical, constant
FFDAAC60h: EF2A                     MOVY   A9,A10               ; Move Y half of register
FFDAAC70h: 27C1                     SLL    1Eh,A1               ; Shift left logical, constant
FFDAAC80h: 2C41                     SRL    1Eh,A1               ; Shift right logical, constant
FFDAAC90h: 0B6A FFFE FFFE           CMPI   10001h,A10           ; Compare immediate (32 bits)
FFDAACC0h: CA02                     JREQ   FFDAACF0h            ; Jump relative conditional
FFDAACD0h: 1081                     ADDK   4h,A1                ; Add constant (5 bits)
FFDAACE0h: 4F3B                     MOVE   B9_COLOR1,A11        ; Move register to register
FFDAACF0h: 24A1                     SLL    5h,A1                ; Shift left logical, constant
FFDAAD00h: 0B21 ADD0 FFDA           ADDI   FFDAADD0h,A1         ; Add immediate (32 bits)
FFDAAD30h: 8621                     MOVE   *A1,A1,1             ; Move field. indirect to register
FFDAAD40h: 0161                     JUMP   A1                   ; Jump indirect

FFDAAD50h: 4F3B                     MOVE   B9_COLOR1,A11        ; Move register to register
FFDAAD60h: 27C1                     SLL    1Eh,A1               ; Shift left logical, constant
FFDAAD70h: 2CE1                     SRL    19h,A1               ; Shift right logical, constant
FFDAAD80h: 0B21 AED0 FFDA           ADDI   FFDAAED0h,A1         ; Add immediate (32 bits)
FFDAADB0h: 8621                     MOVE   *A1,A1,1             ; Move field. indirect to register
FFDAADC0h: 0161                     JUMP   A1                   ; Jump indirect

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

FFDAAF50h: 2E09                     SRL    10h,A9               ; Shift right logical, constant
FFDAAF60h: 9401                     MOVE   *A0+,A1,0            ; Move field. indirect (postincrement) to register
FFDAAF70h: F024                     PIXT   A1,*A4,XY            ; Pixel transfer, register to indirect XY
FFDAAF80h: E124                     ADDXY  A9,A4                ; Add registers in XV mode
FFDAAF90h: 3C87                     DSJS   A7,FFDAAF60h         ; Decrement register and skip jump short
FFDAAFA0h: C000 FD6E                JR     CMD_LOOP             ; Jump relative conditional

FFDAAFC0h: 9401                     MOVE   *A0+,A1,0            ; Move field. indirect (postincrement) to register
FFDAAFD0h: F024                     PIXT   A1,*A4,XY            ; Pixel transfer, register to indirect XY
FFDAAFE0h: E124                     ADDXY  A9,A4                ; Add registers in XV mode
FFDAAFF0h: 3C87                     DSJS   A7,FFDAAFC0h         ; Decrement register and skip jump short
FFDAB000h: C000 FD68                JR     CMD_LOOP             ; Jump relative conditional

FFDAB020h: 2E09                     SRL    10h,A9               ; Shift right logical, constant
FFDAB030h: 9401                     MOVE   *A0+,A1,0            ; Move field. indirect (postincrement) to register
FFDAB040h: F024                     PIXT   A1,*A4,XY            ; Pixel transfer, register to indirect XY
FFDAB050h: E324                     SUBXY  A9,A4                ; Subtract registers in XY mode
FFDAB060h: 3C87                     DSJS   A7,FFDAB030h         ; Decrement register and skip jump short
FFDAB070h: C000 FD61                JR     CMD_LOOP             ; Jump relative conditional

FFDAB090h: 9401                     MOVE   *A0+,A1,0            ; Move field. indirect (postincrement) to register
FFDAB0A0h: F024                     PIXT   A1,*A4,XY            ; Pixel transfer, register to indirect XY
FFDAB0B0h: E324                     SUBXY  A9,A4                ; Subtract registers in XY mode
FFDAB0C0h: 3C87                     DSJS   A7,FFDAB090h         ; Decrement register and skip jump short
FFDAB0D0h: C000 FD5B                JR     CMD_LOOP             ; Jump relative conditional

FFDAB0F0h: 2E09                     SRL    10h,A9               ; Shift right logical, constant
FFDAB100h: 320A                     RL     10h,A10              ; Rotate left, constant
FFDAB110h: 9401                     MOVE   *A0+,A1,0            ; Move field. indirect (postincrement) to register
FFDAB120h: 4E29                     MOVE   A1,B9_COLOR1         ; Move register to register
FFDAB130h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB140h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDAB150h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB160h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB170h: 251E                     SLL    8h,B14_TEMP          ; Shift left logical, constant
FFDAB180h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB190h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB1A0h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDAB1B0h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB1C0h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDAB1D0h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDAB1E0h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAB1F0h: E124                     ADDXY  A9,A4                ; Add registers in XV mode
FFDAB200h: 3E07                     DSJS   A7,FFDAB110h         ; Decrement register and skip jump short
FFDAB210h: 4F69                     MOVE   A11,B9_COLOR1        ; Move register to register
FFDAB220h: C000 FD46                JR     CMD_LOOP             ; Jump relative conditional

FFDAB240h: 9401                     MOVE   *A0+,A1,0            ; Move field. indirect (postincrement) to register
FFDAB250h: 4E29                     MOVE   A1,B9_COLOR1         ; Move register to register
FFDAB260h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB270h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDAB280h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB290h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB2A0h: 251E                     SLL    8h,B14_TEMP          ; Shift left logical, constant
FFDAB2B0h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB2C0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB2D0h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDAB2E0h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB2F0h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDAB300h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDAB310h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAB320h: E124                     ADDXY  A9,A4                ; Add registers in XV mode
FFDAB330h: 3E07                     DSJS   A7,FFDAB240h         ; Decrement register and skip jump short
FFDAB340h: 4F69                     MOVE   A11,B9_COLOR1        ; Move register to register
FFDAB350h: C000 FD33                JR     CMD_LOOP             ; Jump relative conditional

FFDAB370h: 1821                     MOVK   1h,A1                ; Move constant (5 bits)
FFDAB380h: E024                     ADDXY  A1,A4                ; Add registers in XV mode
FFDAB390h: 2E09                     SRL    10h,A9               ; Shift right logical, constant
FFDAB3A0h: 320A                     RL     10h,A10              ; Rotate left, constant
FFDAB3B0h: 9401                     MOVE   *A0+,A1,0            ; Move field. indirect (postincrement) to register
FFDAB3C0h: 4E29                     MOVE   A1,B9_COLOR1         ; Move register to register
FFDAB3D0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB3E0h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDAB3F0h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB400h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB410h: 251E                     SLL    8h,B14_TEMP          ; Shift left logical, constant
FFDAB420h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB430h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB440h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDAB450h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB460h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDAB470h: E324                     SUBXY  A9,A4                ; Subtract registers in XY mode
FFDAB480h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDAB490h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAB4A0h: 3E07                     DSJS   A7,FFDAB3B0h         ; Decrement register and skip jump short
FFDAB4B0h: 1829                     MOVK   1h,A9                ; Move constant (5 bits)
FFDAB4C0h: E324                     SUBXY  A9,A4                ; Subtract registers in XY mode
FFDAB4D0h: 4F69                     MOVE   A11,B9_COLOR1        ; Move register to register
FFDAB4E0h: C000 FD1A                JR     CMD_LOOP             ; Jump relative conditional

FFDAB500h: 1821                     MOVK   1h,A1                ; Move constant (5 bits)
FFDAB510h: 2601                     SLL    10h,A1               ; Shift left logical, constant
FFDAB520h: E024                     ADDXY  A1,A4                ; Add registers in XV mode
FFDAB530h: 9401                     MOVE   *A0+,A1,0            ; Move field. indirect (postincrement) to register
FFDAB540h: 4E29                     MOVE   A1,B9_COLOR1         ; Move register to register
FFDAB550h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB560h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDAB570h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB580h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB590h: 251E                     SLL    8h,B14_TEMP          ; Shift left logical, constant
FFDAB5A0h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB5B0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB5C0h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDAB5D0h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB5E0h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDAB5F0h: E324                     SUBXY  A9,A4                ; Subtract registers in XY mode
FFDAB600h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDAB610h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAB620h: 3E07                     DSJS   A7,FFDAB530h         ; Decrement register and skip jump short
FFDAB630h: 1829                     MOVK   1h,A9                ; Move constant (5 bits)
FFDAB640h: 2609                     SLL    10h,A9               ; Shift left logical, constant
FFDAB650h: E324                     SUBXY  A9,A4                ; Subtract registers in XY mode
FFDAB660h: 4F69                     MOVE   A11,B9_COLOR1        ; Move register to register
FFDAB670h: C000 FD01                JR     CMD_LOOP             ; Jump relative conditional

FFDAB690h: 5729                     CLR    A9                   ; Clear register
FFDAB6A0h: 320A                     RL     10h,A10              ; Rotate left, constant
FFDAB6B0h: 9601                     MOVE   *A0+,A1,1            ; Move field. indirect (postincrement) to register
FFDAB6C0h: 4E29                     MOVE   A1,B9_COLOR1         ; Move register to register
FFDAB6D0h: 2E19                     SRL    10h,B9_COLOR1        ; Shift right logical, constant
FFDAB6E0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB6F0h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDAB700h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB710h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB720h: 251E                     SLL    8h,B14_TEMP          ; Shift left logical, constant
FFDAB730h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB740h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB750h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDAB760h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB770h: EC29                     MOVX   A1,A9                ; Move X half of register
FFDAB780h: EC2A                     MOVX   A1,A10               ; Move X half of register
FFDAB790h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDAB7A0h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDAB7B0h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAB7C0h: E124                     ADDXY  A9,A4                ; Add registers in XV mode
FFDAB7D0h: 3E67                     DSJS   A7,FFDAB6B0h         ; Decrement register and skip jump short
FFDAB7E0h: 4F69                     MOVE   A11,B9_COLOR1        ; Move register to register
FFDAB7F0h: C000 FCE9                JR     CMD_LOOP             ; Jump relative conditional

FFDAB810h: 9609                     MOVE   *A0+,A9,1            ; Move field. indirect (postincrement) to register
FFDAB820h: 4F29                     MOVE   A9,B9_COLOR1         ; Move register to register
FFDAB830h: 2E19                     SRL    10h,B9_COLOR1        ; Shift right logical, constant
FFDAB840h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB850h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDAB860h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB870h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB880h: 251E                     SLL    8h,B14_TEMP          ; Shift left logical, constant
FFDAB890h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB8A0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB8B0h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDAB8C0h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAB8D0h: 2609                     SLL    10h,A9               ; Shift left logical, constant
FFDAB8E0h: EF2A                     MOVY   A9,A10               ; Move Y half of register
FFDAB8F0h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDAB900h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDAB910h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAB920h: E124                     ADDXY  A9,A4                ; Add registers in XV mode
FFDAB930h: 3E67                     DSJS   A7,FFDAB810h         ; Decrement register and skip jump short
FFDAB940h: 4F69                     MOVE   A11,B9_COLOR1        ; Move register to register
FFDAB950h: C000 FCD3                JR     CMD_LOOP             ; Jump relative conditional

FFDAB970h: 1829                     MOVK   1h,A9                ; Move constant (5 bits)
FFDAB980h: E124                     ADDXY  A9,A4                ; Add registers in XV mode
FFDAB990h: 320A                     RL     10h,A10              ; Rotate left, constant
FFDAB9A0h: 9601                     MOVE   *A0+,A1,1            ; Move field. indirect (postincrement) to register
FFDAB9B0h: 4E29                     MOVE   A1,B9_COLOR1         ; Move register to register
FFDAB9C0h: 2E19                     SRL    10h,B9_COLOR1        ; Shift right logical, constant
FFDAB9D0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAB9E0h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDAB9F0h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDABA00h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDABA10h: 251E                     SLL    8h,B14_TEMP          ; Shift left logical, constant
FFDABA20h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDABA30h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDABA40h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDABA50h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDABA60h: EC29                     MOVX   A1,A9                ; Move X half of register
FFDABA70h: EC2A                     MOVX   A1,A10               ; Move X half of register
FFDABA80h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDABA90h: E324                     SUBXY  A9,A4                ; Subtract registers in XY mode
FFDABAA0h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDABAB0h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDABAC0h: 3E67                     DSJS   A7,FFDAB9A0h         ; Decrement register and skip jump short
FFDABAD0h: 1829                     MOVK   1h,A9                ; Move constant (5 bits)
FFDABAE0h: E324                     SUBXY  A9,A4                ; Subtract registers in XY mode
FFDABAF0h: 4F69                     MOVE   A11,B9_COLOR1        ; Move register to register
FFDABB00h: C000 FCB8                JR     CMD_LOOP             ; Jump relative conditional

FFDABB20h: 1829                     MOVK   1h,A9                ; Move constant (5 bits)
FFDABB30h: 2609                     SLL    10h,A9               ; Shift left logical, constant
FFDABB40h: E124                     ADDXY  A9,A4                ; Add registers in XV mode
FFDABB50h: 9609                     MOVE   *A0+,A9,1            ; Move field. indirect (postincrement) to register
FFDABB60h: 4F29                     MOVE   A9,B9_COLOR1         ; Move register to register
FFDABB70h: 2E19                     SRL    10h,B9_COLOR1        ; Shift right logical, constant
FFDABB80h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDABB90h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDABBA0h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDABBB0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDABBC0h: 251E                     SLL    8h,B14_TEMP          ; Shift left logical, constant
FFDABBD0h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDABBE0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDABBF0h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDABC00h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDABC10h: 2609                     SLL    10h,A9               ; Shift left logical, constant
FFDABC20h: EF2A                     MOVY   A9,A10               ; Move Y half of register
FFDABC30h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDABC40h: E324                     SUBXY  A9,A4                ; Subtract registers in XY mode
FFDABC50h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDABC60h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDABC70h: 3E67                     DSJS   A7,FFDABB50h         ; Decrement register and skip jump short
FFDABC80h: 1829                     MOVK   1h,A9                ; Move constant (5 bits)
FFDABC90h: 2609                     SLL    10h,A9               ; Shift left logical, constant
FFDABCA0h: E324                     SUBXY  A9,A4                ; Subtract registers in XY mode
FFDABCB0h: 4F69                     MOVE   A11,B9_COLOR1        ; Move register to register
FFDABCC0h: C000 FC9C                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_30_31
********************************************************************************
COMMAND_30_31:
FFDABCE0h: 9507                     MOVE   *A8+,A7,0            ; Move field. indirect (postincrement) to register
FFDABCF0h: 950A                     MOVE   *A8+,A10,0           ; Move field. indirect (postincrement) to register
FFDABD00h: 9700                     MOVE   *A8+,A0,1            ; Move field. indirect (postincrement) to register
FFDABD10h: 9504                     MOVE   *A8+,A4,0            ; Move field. indirect (postincrement) to register
FFDABD20h: 4CE7                     MOVE   A7,A7                ; Move register to register
FFDABD30h: CA00 FC95                JREQ   CMD_LOOP             ; Jump relative conditional
FFDABD50h: 2604                     SLL    10h,A4               ; Shift left logical, constant
FFDABD60h: 5621                     CLR    A1                   ; Clear register
FFDABD70h: 09C2 FFFF                MOVI   FFFFh,A2             ; Move immediate (16 bits)
FFDABD90h: 4C4C                     MOVE   A2,A12               ; Move register to register
FFDABDA0h: 2E8C                     SRL    Ch,A12               ; Shift right logical, constant
FFDABDB0h: 182E                     MOVK   1h,A14               ; Move constant (5 bits)
FFDABDC0h: 25EE                     SLL    Fh,A14               ; Shift left logical, constant
FFDABDD0h: 0770                     SETF   10h,1,1              ; Set field parameters
FFDABDE0h: 960B                     MOVE   *A0+,A11,1           ; Move field. indirect (postincrement) to register
FFDABDF0h: 9406                     MOVE   *A0+,A6,0            ; Move field. indirect (postincrement) to register
FFDABE00h: 5186                     AND    A12,A6               ; AND registers
FFDABE10h: ED64                     MOVX   A11,A4               ; Move X half of register
FFDABE20h: F0C4                     PIXT   A6,*A4,XY            ; Pixel transfer, register to indirect XY
FFDABE30h: 1427                     DEC    A7                   ; Decrement register
FFDABE40h: CB26                     JRNE   FFDAC0B0h            ; Jump relative conditional
FFDABE50h: C036                     JR     FFDAC1C0h            ; Jump relative conditional

FFDABE60h: 4569                     SUB    A11,A9               ; Subtract registers
FFDABE70h: CA1F                     JREQ   FFDAC070h            ; Jump relative conditional
FFDABE80h: C702                     JRGT   FFDABEB0h            ; Jump relative conditional
FFDABE90h: 4C4A                     MOVE   A2,A10               ; Move register to register
FFDABEA0h: 03A9                     NEG    A9                   ; Negate register
FFDABEB0h: 0B49 FFFD                CMPI   2h,A9                ; Compare immediate (16 bits)
FFDABED0h: C417                     JRLT   FFDAC050h            ; Jump relative conditional
FFDABEE0h: CA11                     JREQ   FFDAC000h            ; Jump relative conditional
FFDABEF0h: 4CA3                     MOVE   A5,A3                ; Move register to register
FFDABF00h: 2603                     SLL    10h,A3               ; Shift left logical, constant
FFDABF10h: 2606                     SLL    10h,A6               ; Shift left logical, constant
FFDABF20h: 44C3                     SUB    A6,A3                ; Subtract registers
FFDABF30h: 4626                     SUBB   A1,A6                ; Subtract registers with borrow
FFDABF40h: 41C6                     ADD    A14,A6               ; Add registers
FFDABF50h: 5923                     DIVS   A9,A3                ; Rd even: Rd:Rd+1/Rs → Rd; Remainder → Rd+1; Rd odd: Rd/Rs → Rd (signed divide)
FFDABF60h: E144                     ADDXY  A10,A4               ; Add registers in XV mode
FFDABF70h: 4066                     ADD    A3,A6                ; Add registers
FFDABF80h: 3206                     RL     10h,A6               ; Rotate left, constant
FFDABF90h: F0C4                     PIXT   A6,*A4,XY            ; Pixel transfer, register to indirect XY
FFDABFA0h: 3206                     RL     10h,A6               ; Rotate left, constant
FFDABFB0h: 3CC9                     DSJS   A9,FFDABF60h         ; Decrement register and skip jump short
FFDABFC0h: 4E1B                     MOVE   B0_SADDR,A11         ; Move register to register
FFDABFD0h: 4CA6                     MOVE   A5,A6                ; Move register to register
FFDABFE0h: 3987                     DSJS   A7,FFDAC0B0h         ; Decrement register and skip jump short
FFDABFF0h: C01C                     JR     FFDAC1C0h            ; Jump relative conditional

FFDAC000h: 40A6                     ADD    A5,A6                ; Add registers
FFDAC010h: 1026                     INC    A6                   ; Increment register
FFDAC020h: 2FE6                     SRL    1h,A6                ; Shift right logical, constant
FFDAC030h: E144                     ADDXY  A10,A4               ; Add registers in XV mode
FFDAC040h: F0C4                     PIXT   A6,*A4,XY            ; Pixel transfer, register to indirect XY
FFDAC050h: E144                     ADDXY  A10,A4               ; Add registers in XV mode
FFDAC060h: 4E1B                     MOVE   B0_SADDR,A11         ; Move register to register
FFDAC070h: F0A4                     PIXT   A5,*A4,XY            ; Pixel transfer, register to indirect XY
FFDAC080h: 4CA6                     MOVE   A5,A6                ; Move register to register
FFDAC090h: 3827                     DSJS   A7,FFDAC0B0h         ; Decrement register and skip jump short
FFDAC0A0h: C011                     JR     FFDAC1C0h            ; Jump relative conditional

FFDAC0B0h: 9609                     MOVE   *A0+,A9,1            ; Move field. indirect (postincrement) to register
FFDAC0C0h: 4F20                     MOVE   A9,B0_SADDR          ; Move register to register
FFDAC0D0h: 9405                     MOVE   *A0+,A5,0            ; Move field. indirect (postincrement) to register
FFDAC0E0h: 182A                     MOVK   1h,A10               ; Move constant (5 bits)
FFDAC0F0h: 5185                     AND    A12,A5               ; AND registers
FFDAC100h: 48C5                     CMP    A6,A5                ; Compare registers
FFDAC110h: CBD4                     JRNE   FFDABE60h            ; Jump relative conditional
FFDAC120h: 4569                     SUB    A11,A9               ; Subtract registers
FFDAC130h: CA07                     JREQ   FFDAC1B0h            ; Jump relative conditional
FFDAC140h: C702                     JRGT   FFDAC170h            ; Jump relative conditional
FFDAC150h: 4C4A                     MOVE   A2,A10               ; Move register to register
FFDAC160h: 03A9                     NEG    A9                   ; Negate register
FFDAC170h: E144                     ADDXY  A10,A4               ; Add registers in XV mode
FFDAC180h: F0A4                     PIXT   A5,*A4,XY            ; Pixel transfer, register to indirect XY
FFDAC190h: 3C69                     DSJS   A9,FFDAC170h         ; Decrement register and skip jump short
FFDAC1A0h: 4E1B                     MOVE   B0_SADDR,A11         ; Move register to register
FFDAC1B0h: 3E27                     DSJS   A7,FFDAC0B0h         ; Decrement register and skip jump short
FFDAC1C0h: 0740                     SETF   20h,0,1              ; Set field parameters
FFDAC1D0h: C000 FC4B                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_36_LINE_ABSOLUTE
********************************************************************************
COMMAND_36_LINE_ABSOLUTE:
FFDAC1F0h: 9705                     MOVE   *A8+,A5,1            ; Move field. indirect (postincrement) to register
FFDAC200h: 05A1 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A1,0 ; Move field, absolute to register
FFDAC230h: E485                     CMPXY  A4,A5                ; Compare X and V halves of registers
FFDAC240h: CA29                     JREQ   FFDAC4E0h            ; Jump relative conditional
FFDAC250h: CE2C                     JRN    FFDAC520h            ; Jump relative conditional
FFDAC260h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDAC270h: 4E80                     MOVE   A4,B0_SADDR          ; Move register to register
FFDAC280h: E250                     SUBXY  B2_DADDR,B0_SADDR    ; Subtract registers in XY mode
FFDAC290h: 477B                     SUBB   B11_INC1,B11_INC1    ; Subtract registers with borrow
FFDAC2A0h: 183A                     MOVK   1h,B10_COUNT         ; Move constant (5 bits)
FFDAC2B0h: 56F7                     CLR    B7_DVDX              ; Clear register
FFDAC2C0h: E217                     SUBXY  B0_SADDR,B7_DVDX     ; Subtract registers in XY mode
FFDAC2D0h: C903                     JRNC   FFDAC310h            ; Jump relative conditional
FFDAC2E0h: EE17                     MOVY   B0_SADDR,B7_DVDX     ; Move Y half of register
FFDAC2F0h: 03FB                     NOT    B11_INC1             ; Complement register
FFDAC300h: 2E3B                     SRL    Fh,B11_INC1          ; Shift right logical, constant
FFDAC310h: CD02                     JRNV   FFDAC340h            ; Jump relative conditional
FFDAC320h: EC17                     MOVX   B0_SADDR,B7_DVDX     ; Move X half of register
FFDAC330h: ED5B                     MOVX   B10_COUNT,B11_INC1   ; Move X half of register
FFDAC340h: 579C                     CLR    B12_INC2             ; Clear register
FFDAC350h: 4CF0                     MOVE   B7_DVDX,B0_SADDR     ; Move register to register
FFDAC360h: 2E10                     SRL    10h,B0_SADDR         ; Shift right logical, constant
FFDAC370h: E417                     CMPXY  B0_SADDR,B7_DVDX     ; Compare X and V halves of registers
FFDAC380h: CC02                     JRV    FFDAC3B0h            ; Jump relative conditional
FFDAC390h: ED7C                     MOVX   B11_INC1,B12_INC2    ; Move X half of register
FFDAC3A0h: C003                     JR     FFDAC3E0h            ; Jump relative conditional

FFDAC3B0h: ECF0                     MOVX   B7_DVDX,B0_SADDR     ; Move X half of register
FFDAC3C0h: 3217                     RL     10h,B7_DVDX          ; Rotate left, constant
FFDAC3D0h: EF7C                     MOVY   B11_INC1,B12_INC2    ; Move Y half of register
FFDAC3E0h: 4010                     ADD    B0_SADDR,B0_SADDR    ; Add registers
FFDAC3F0h: ECFA                     MOVX   B7_DVDX,B10_COUNT    ; Move X half of register
FFDAC400h: 4550                     SUB    B10_COUNT,B0_SADDR   ; Subtract registers
FFDAC410h: 103A                     INC    B10_COUNT            ; Increment register
FFDAC420h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDAC430h: CA08                     JREQ   FFDAC4C0h            ; Jump relative conditional
FFDAC440h: 4C11                     MOVE   B0_SADDR,B1_SPTCH    ; Move register to register
FFDAC450h: 4F54                     MOVE   B10_COUNT,A4         ; Move register to register
FFDAC460h: DF1A                     LINE   0                    ; Perform the inner loop of Bresenham's line-drawing algorithm
FFDAC470h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDAC480h: 4C30                     MOVE   B1_SPTCH,B0_SADDR    ; Move register to register
FFDAC490h: 4E8A                     MOVE   A4,B10_COUNT         ; Move register to register
FFDAC4A0h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDAC4B0h: E1D2                     ADDXY  B14_TEMP,B2_DADDR    ; Add registers in XV mode
FFDAC4C0h: DF1A                     LINE   0                    ; Perform the inner loop of Bresenham's line-drawing algorithm
FFDAC4D0h: C010                     JR     FFDAC5E0h            ; Jump relative conditional

FFDAC4E0h: CC04                     JRV    FFDAC530h            ; Jump relative conditional
FFDAC4F0h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDAC500h: 4EA7                     MOVE   A5,B7_DVDX           ; Move register to register
FFDAC510h: C003                     JR     FFDAC550h            ; Jump relative conditional

FFDAC520h: C9FC                     JRNC   FFDAC4F0h            ; Jump relative conditional
FFDAC530h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDAC540h: 4E87                     MOVE   A4,B7_DVDX           ; Move register to register
FFDAC550h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDAC560h: 09FE 0001 0001           MOVI   00010001h,B14_TEMP   ; Move immediate (32 bits)
FFDAC590h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDAC5A0h: CA01                     JREQ   FFDAC5C0h            ; Jump relative conditional
FFDAC5B0h: 103E                     INC    B14_TEMP             ; Increment register
FFDAC5C0h: E1D7                     ADDXY  B14_TEMP,B7_DVDX     ; Add registers in XV mode
FFDAC5D0h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAC5E0h: 4CA4                     MOVE   A5,A4                ; Move register to register
FFDAC5F0h: C000 FC09                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_38_LINE_RELATIVE
********************************************************************************
COMMAND_38_LINE_RELATIVE:
FFDAC610h: 9705                     MOVE   *A8+,A5,1            ; Move field. indirect (postincrement) to register
FFDAC620h: E085                     ADDXY  A4,A5                ; Add registers in XV mode
FFDAC630h: 05A1 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A1,0 ; Move field, absolute to register
FFDAC660h: E485                     CMPXY  A4,A5                ; Compare X and V halves of registers
FFDAC670h: CA29                     JREQ   FFDAC910h            ; Jump relative conditional
FFDAC680h: CE2C                     JRN    FFDAC950h            ; Jump relative conditional
FFDAC690h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDAC6A0h: 4E80                     MOVE   A4,B0_SADDR          ; Move register to register
FFDAC6B0h: E250                     SUBXY  B2_DADDR,B0_SADDR    ; Subtract registers in XY mode
FFDAC6C0h: 477B                     SUBB   B11_INC1,B11_INC1    ; Subtract registers with borrow
FFDAC6D0h: 183A                     MOVK   1h,B10_COUNT         ; Move constant (5 bits)
FFDAC6E0h: 56F7                     CLR    B7_DVDX              ; Clear register
FFDAC6F0h: E217                     SUBXY  B0_SADDR,B7_DVDX     ; Subtract registers in XY mode
FFDAC700h: C903                     JRNC   FFDAC740h            ; Jump relative conditional
FFDAC710h: EE17                     MOVY   B0_SADDR,B7_DVDX     ; Move Y half of register
FFDAC720h: 03FB                     NOT    B11_INC1             ; Complement register
FFDAC730h: 2E3B                     SRL    Fh,B11_INC1          ; Shift right logical, constant
FFDAC740h: CD02                     JRNV   FFDAC770h            ; Jump relative conditional
FFDAC750h: EC17                     MOVX   B0_SADDR,B7_DVDX     ; Move X half of register
FFDAC760h: ED5B                     MOVX   B10_COUNT,B11_INC1   ; Move X half of register
FFDAC770h: 579C                     CLR    B12_INC2             ; Clear register
FFDAC780h: 4CF0                     MOVE   B7_DVDX,B0_SADDR     ; Move register to register
FFDAC790h: 2E10                     SRL    10h,B0_SADDR         ; Shift right logical, constant
FFDAC7A0h: E417                     CMPXY  B0_SADDR,B7_DVDX     ; Compare X and V halves of registers
FFDAC7B0h: CC02                     JRV    FFDAC7E0h            ; Jump relative conditional
FFDAC7C0h: ED7C                     MOVX   B11_INC1,B12_INC2    ; Move X half of register
FFDAC7D0h: C003                     JR     FFDAC810h            ; Jump relative conditional

FFDAC7E0h: ECF0                     MOVX   B7_DVDX,B0_SADDR     ; Move X half of register
FFDAC7F0h: 3217                     RL     10h,B7_DVDX          ; Rotate left, constant
FFDAC800h: EF7C                     MOVY   B11_INC1,B12_INC2    ; Move Y half of register
FFDAC810h: 4010                     ADD    B0_SADDR,B0_SADDR    ; Add registers
FFDAC820h: ECFA                     MOVX   B7_DVDX,B10_COUNT    ; Move X half of register
FFDAC830h: 4550                     SUB    B10_COUNT,B0_SADDR   ; Subtract registers
FFDAC840h: 103A                     INC    B10_COUNT            ; Increment register
FFDAC850h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDAC860h: CA08                     JREQ   FFDAC8F0h            ; Jump relative conditional
FFDAC870h: 4C11                     MOVE   B0_SADDR,B1_SPTCH    ; Move register to register
FFDAC880h: 4F54                     MOVE   B10_COUNT,A4         ; Move register to register
FFDAC890h: DF1A                     LINE   0                    ; Perform the inner loop of Bresenham's line-drawing algorithm
FFDAC8A0h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDAC8B0h: 4C30                     MOVE   B1_SPTCH,B0_SADDR    ; Move register to register
FFDAC8C0h: 4E8A                     MOVE   A4,B10_COUNT         ; Move register to register
FFDAC8D0h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDAC8E0h: E1D2                     ADDXY  B14_TEMP,B2_DADDR    ; Add registers in XV mode
FFDAC8F0h: DF1A                     LINE   0                    ; Perform the inner loop of Bresenham's line-drawing algorithm
FFDAC900h: C010                     JR     FFDACA10h            ; Jump relative conditional

FFDAC910h: CC04                     JRV    FFDAC960h            ; Jump relative conditional
FFDAC920h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDAC930h: 4EA7                     MOVE   A5,B7_DVDX           ; Move register to register
FFDAC940h: C003                     JR     FFDAC980h            ; Jump relative conditional

FFDAC950h: C9FC                     JRNC   FFDAC920h            ; Jump relative conditional
FFDAC960h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDAC970h: 4E87                     MOVE   A4,B7_DVDX           ; Move register to register
FFDAC980h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDAC990h: 09FE 0001 0001           MOVI   00010001h,B14_TEMP   ; Move immediate (32 bits)
FFDAC9C0h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDAC9D0h: CA01                     JREQ   FFDAC9F0h            ; Jump relative conditional
FFDAC9E0h: 103E                     INC    B14_TEMP             ; Increment register
FFDAC9F0h: E1D7                     ADDXY  B14_TEMP,B7_DVDX     ; Add registers in XV mode
FFDACA00h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDACA10h: 4CA4                     MOVE   A5,A4                ; Move register to register
FFDACA20h: C000 FBC6                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_40_PIXEL_MAP
********************************************************************************
COMMAND_40_PIXEL_MAP:
FFDACA40h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDACA50h: 4E20                     MOVE   A1,B0_SADDR          ; Move register to register
FFDACA60h: 9411                     MOVE   *B0_SADDR+,B1_SPTCH,0 ; Move field. indirect (postincrement) to register
FFDACA70h: 6A3E                     LMO    B1_SPTCH,B14_TEMP    ; Leftmost one bit
FFDACA80h: 059E 0130 C000           MOVE   B14_TEMP,@CONVSP,0   ; Move field, register to absolute
FFDACAB0h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDACAC0h: 9617                     MOVE   *B0_SADDR+,B7_DVDX,1 ; Move field. indirect (postincrement) to register
FFDACAD0h: 0F20                     PIXBLT L,XY                 ; Pixel block transfer, linear to XY
FFDACAE0h: C000 FBBA                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_42_POLYLINE_ABSOLUTE
********************************************************************************
COMMAND_42_POLYLINE_ABSOLUTE:
FFDACB00h: 05A1 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A1,0 ; Move field, absolute to register
FFDACB30h: 9502                     MOVE   *A8+,A2,0            ; Move field. indirect (postincrement) to register
FFDACB40h: 9503                     MOVE   *A8+,A3,0            ; Move field. indirect (postincrement) to register
FFDACB50h: 24A3                     SLL    5h,A3                ; Shift left logical, constant
FFDACB60h: 4103                     ADD    A8,A3                ; Add registers
FFDACB70h: 9705                     MOVE   *A8+,A5,1            ; Move field. indirect (postincrement) to register
FFDACB80h: E485                     CMPXY  A4,A5                ; Compare X and V halves of registers
FFDACB90h: CA29                     JREQ   FFDACE30h            ; Jump relative conditional
FFDACBA0h: CE2C                     JRN    FFDACE70h            ; Jump relative conditional
FFDACBB0h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDACBC0h: 4E80                     MOVE   A4,B0_SADDR          ; Move register to register
FFDACBD0h: E250                     SUBXY  B2_DADDR,B0_SADDR    ; Subtract registers in XY mode
FFDACBE0h: 477B                     SUBB   B11_INC1,B11_INC1    ; Subtract registers with borrow
FFDACBF0h: 183A                     MOVK   1h,B10_COUNT         ; Move constant (5 bits)
FFDACC00h: 56F7                     CLR    B7_DVDX              ; Clear register
FFDACC10h: E217                     SUBXY  B0_SADDR,B7_DVDX     ; Subtract registers in XY mode
FFDACC20h: C903                     JRNC   FFDACC60h            ; Jump relative conditional
FFDACC30h: EE17                     MOVY   B0_SADDR,B7_DVDX     ; Move Y half of register
FFDACC40h: 03FB                     NOT    B11_INC1             ; Complement register
FFDACC50h: 2E3B                     SRL    Fh,B11_INC1          ; Shift right logical, constant
FFDACC60h: CD02                     JRNV   FFDACC90h            ; Jump relative conditional
FFDACC70h: EC17                     MOVX   B0_SADDR,B7_DVDX     ; Move X half of register
FFDACC80h: ED5B                     MOVX   B10_COUNT,B11_INC1   ; Move X half of register
FFDACC90h: 579C                     CLR    B12_INC2             ; Clear register
FFDACCA0h: 4CF0                     MOVE   B7_DVDX,B0_SADDR     ; Move register to register
FFDACCB0h: 2E10                     SRL    10h,B0_SADDR         ; Shift right logical, constant
FFDACCC0h: E417                     CMPXY  B0_SADDR,B7_DVDX     ; Compare X and V halves of registers
FFDACCD0h: CC02                     JRV    FFDACD00h            ; Jump relative conditional
FFDACCE0h: ED7C                     MOVX   B11_INC1,B12_INC2    ; Move X half of register
FFDACCF0h: C003                     JR     FFDACD30h            ; Jump relative conditional

FFDACD00h: ECF0                     MOVX   B7_DVDX,B0_SADDR     ; Move X half of register
FFDACD10h: 3217                     RL     10h,B7_DVDX          ; Rotate left, constant
FFDACD20h: EF7C                     MOVY   B11_INC1,B12_INC2    ; Move Y half of register
FFDACD30h: 4010                     ADD    B0_SADDR,B0_SADDR    ; Add registers
FFDACD40h: ECFA                     MOVX   B7_DVDX,B10_COUNT    ; Move X half of register
FFDACD50h: 4550                     SUB    B10_COUNT,B0_SADDR   ; Subtract registers
FFDACD60h: 103A                     INC    B10_COUNT            ; Increment register
FFDACD70h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDACD80h: CA08                     JREQ   FFDACE10h            ; Jump relative conditional
FFDACD90h: 4C11                     MOVE   B0_SADDR,B1_SPTCH    ; Move register to register
FFDACDA0h: 4F54                     MOVE   B10_COUNT,A4         ; Move register to register
FFDACDB0h: DF1A                     LINE   0                    ; Perform the inner loop of Bresenham's line-drawing algorithm
FFDACDC0h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDACDD0h: 4C30                     MOVE   B1_SPTCH,B0_SADDR    ; Move register to register
FFDACDE0h: 4E8A                     MOVE   A4,B10_COUNT         ; Move register to register
FFDACDF0h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDACE00h: E1D2                     ADDXY  B14_TEMP,B2_DADDR    ; Add registers in XV mode
FFDACE10h: DF1A                     LINE   0                    ; Perform the inner loop of Bresenham's line-drawing algorithm
FFDACE20h: C010                     JR     FFDACF30h            ; Jump relative conditional

FFDACE30h: CC04                     JRV    FFDACE80h            ; Jump relative conditional
FFDACE40h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDACE50h: 4EA7                     MOVE   A5,B7_DVDX           ; Move register to register
FFDACE60h: C003                     JR     FFDACEA0h            ; Jump relative conditional

FFDACE70h: C9FC                     JRNC   FFDACE40h            ; Jump relative conditional
FFDACE80h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDACE90h: 4E87                     MOVE   A4,B7_DVDX           ; Move register to register
FFDACEA0h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDACEB0h: 09FE 0001 0001           MOVI   00010001h,B14_TEMP   ; Move immediate (32 bits)
FFDACEE0h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDACEF0h: CA01                     JREQ   FFDACF10h            ; Jump relative conditional
FFDACF00h: 103E                     INC    B14_TEMP             ; Increment register
FFDACF10h: E1D7                     ADDXY  B14_TEMP,B7_DVDX     ; Add registers in XV mode
FFDACF20h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDACF30h: 4CA4                     MOVE   A5,A4                ; Move register to register
FFDACF40h: 0D82 FFC1                DSJ    A2,FFDACB70h         ; Decrement register and skip jump
FFDACF60h: 4C68                     MOVE   A3,A8                ; Move register to register
FFDACF70h: C000 FB71                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_44_POLYLINE_RELATIVE
********************************************************************************
COMMAND_44_POLYLINE_RELATIVE:
FFDACF90h: 05A1 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A1,0 ; Move field, absolute to register
FFDACFC0h: 9502                     MOVE   *A8+,A2,0            ; Move field. indirect (postincrement) to register
FFDACFD0h: 9503                     MOVE   *A8+,A3,0            ; Move field. indirect (postincrement) to register
FFDACFE0h: 24A3                     SLL    5h,A3                ; Shift left logical, constant
FFDACFF0h: 4103                     ADD    A8,A3                ; Add registers
FFDAD000h: 9705                     MOVE   *A8+,A5,1            ; Move field. indirect (postincrement) to register
FFDAD010h: E085                     ADDXY  A4,A5                ; Add registers in XV mode
FFDAD020h: E485                     CMPXY  A4,A5                ; Compare X and V halves of registers
FFDAD030h: CA29                     JREQ   FFDAD2D0h            ; Jump relative conditional
FFDAD040h: CE2C                     JRN    FFDAD310h            ; Jump relative conditional
FFDAD050h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDAD060h: 4E80                     MOVE   A4,B0_SADDR          ; Move register to register
FFDAD070h: E250                     SUBXY  B2_DADDR,B0_SADDR    ; Subtract registers in XY mode
FFDAD080h: 477B                     SUBB   B11_INC1,B11_INC1    ; Subtract registers with borrow
FFDAD090h: 183A                     MOVK   1h,B10_COUNT         ; Move constant (5 bits)
FFDAD0A0h: 56F7                     CLR    B7_DVDX              ; Clear register
FFDAD0B0h: E217                     SUBXY  B0_SADDR,B7_DVDX     ; Subtract registers in XY mode
FFDAD0C0h: C903                     JRNC   FFDAD100h            ; Jump relative conditional
FFDAD0D0h: EE17                     MOVY   B0_SADDR,B7_DVDX     ; Move Y half of register
FFDAD0E0h: 03FB                     NOT    B11_INC1             ; Complement register
FFDAD0F0h: 2E3B                     SRL    Fh,B11_INC1          ; Shift right logical, constant
FFDAD100h: CD02                     JRNV   FFDAD130h            ; Jump relative conditional
FFDAD110h: EC17                     MOVX   B0_SADDR,B7_DVDX     ; Move X half of register
FFDAD120h: ED5B                     MOVX   B10_COUNT,B11_INC1   ; Move X half of register
FFDAD130h: 579C                     CLR    B12_INC2             ; Clear register
FFDAD140h: 4CF0                     MOVE   B7_DVDX,B0_SADDR     ; Move register to register
FFDAD150h: 2E10                     SRL    10h,B0_SADDR         ; Shift right logical, constant
FFDAD160h: E417                     CMPXY  B0_SADDR,B7_DVDX     ; Compare X and V halves of registers
FFDAD170h: CC02                     JRV    FFDAD1A0h            ; Jump relative conditional
FFDAD180h: ED7C                     MOVX   B11_INC1,B12_INC2    ; Move X half of register
FFDAD190h: C003                     JR     FFDAD1D0h            ; Jump relative conditional

FFDAD1A0h: ECF0                     MOVX   B7_DVDX,B0_SADDR     ; Move X half of register
FFDAD1B0h: 3217                     RL     10h,B7_DVDX          ; Rotate left, constant
FFDAD1C0h: EF7C                     MOVY   B11_INC1,B12_INC2    ; Move Y half of register
FFDAD1D0h: 4010                     ADD    B0_SADDR,B0_SADDR    ; Add registers
FFDAD1E0h: ECFA                     MOVX   B7_DVDX,B10_COUNT    ; Move X half of register
FFDAD1F0h: 4550                     SUB    B10_COUNT,B0_SADDR   ; Subtract registers
FFDAD200h: 103A                     INC    B10_COUNT            ; Increment register
FFDAD210h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDAD220h: CA08                     JREQ   FFDAD2B0h            ; Jump relative conditional
FFDAD230h: 4C11                     MOVE   B0_SADDR,B1_SPTCH    ; Move register to register
FFDAD240h: 4F54                     MOVE   B10_COUNT,A4         ; Move register to register
FFDAD250h: DF1A                     LINE   0                    ; Perform the inner loop of Bresenham's line-drawing algorithm
FFDAD260h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDAD270h: 4C30                     MOVE   B1_SPTCH,B0_SADDR    ; Move register to register
FFDAD280h: 4E8A                     MOVE   A4,B10_COUNT         ; Move register to register
FFDAD290h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDAD2A0h: E1D2                     ADDXY  B14_TEMP,B2_DADDR    ; Add registers in XV mode
FFDAD2B0h: DF1A                     LINE   0                    ; Perform the inner loop of Bresenham's line-drawing algorithm
FFDAD2C0h: C010                     JR     FFDAD3D0h            ; Jump relative conditional

FFDAD2D0h: CC04                     JRV    FFDAD320h            ; Jump relative conditional
FFDAD2E0h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDAD2F0h: 4EA7                     MOVE   A5,B7_DVDX           ; Move register to register
FFDAD300h: C003                     JR     FFDAD340h            ; Jump relative conditional

FFDAD310h: C9FC                     JRNC   FFDAD2E0h            ; Jump relative conditional
FFDAD320h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDAD330h: 4E87                     MOVE   A4,B7_DVDX           ; Move register to register
FFDAD340h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDAD350h: 09FE 0001 0001           MOVI   00010001h,B14_TEMP   ; Move immediate (32 bits)
FFDAD380h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDAD390h: CA01                     JREQ   FFDAD3B0h            ; Jump relative conditional
FFDAD3A0h: 103E                     INC    B14_TEMP             ; Increment register
FFDAD3B0h: E1D7                     ADDXY  B14_TEMP,B7_DVDX     ; Add registers in XV mode
FFDAD3C0h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAD3D0h: 4CA4                     MOVE   A5,A4                ; Move register to register
FFDAD3E0h: 0D82 FFC0                DSJ    A2,FFDAD000h         ; Decrement register and skip jump
FFDAD400h: 4C68                     MOVE   A3,A8                ; Move register to register
FFDAD410h: C000 FB27                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_46_TEXT
********************************************************************************
COMMAND_46_TEXT:
FFDAD430h: 9503                     MOVE   *A8+,A3,0            ; Move field. indirect (postincrement) to register
FFDAD440h: CA7C                     JREQ   FFDADC10h            ; Jump relative conditional
FFDAD450h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDAD460h: 2481                     SLL    4h,A1                ; Shift left logical, constant
FFDAD470h: 4101                     ADD    A8,A1                ; Add registers
FFDAD480h: A3AF                     MOVE   A13,-*SP,1           ; Move field. register to indirect (predecrement)
FFDAD490h: A22F                     MOVE   A1,-*SP,1            ; Move field. register to indirect (predecrement)
FFDAD4A0h: 09E1 0CD0 FFEC           MOVI   CURRENT_FONT,A1      ; Move immediate (32 bits)
FFDAD4D0h: 962C                     MOVE   *A1+,A12,1           ; Move field. indirect (postincrement) to register
FFDAD4E0h: 962A                     MOVE   *A1+,A10,1           ; Move field. indirect (postincrement) to register
FFDAD4F0h: 5600                     CLR    A0                   ; Clear register
FFDAD500h: ED40                     MOVX   A10,A0               ; Move X half of register
FFDAD510h: 9429                     MOVE   *A1+,A9,0            ; Move field. indirect (postincrement) to register
FFDAD520h: 9422                     MOVE   *A1+,A2,0            ; Move field. indirect (postincrement) to register
FFDAD530h: 4E41                     MOVE   A2,B1_SPTCH          ; Move register to register
FFDAD540h: 6A3C                     LMO    B1_SPTCH,B12_INC2    ; Leftmost one bit
FFDAD550h: 059C 0130 C000           MOVE   B12_INC2,@CONVSP,0   ; Move field, register to absolute
FFDAD580h: 9422                     MOVE   *A1+,A2,0            ; Move field. indirect (postincrement) to register
FFDAD590h: CA07                     JREQ   FFDAD610h            ; Jump relative conditional
FFDAD5A0h: 2420                     SLL    1h,A0                ; Shift left logical, constant
FFDAD5B0h: 09EE 0150 C000           MOVI   PSIZE,A14            ; Move immediate (32 bits)
FFDAD5E0h: 85C6                     MOVE   *A14,A6,0            ; Move field. indirect to register
FFDAD5F0h: 4CC7                     MOVE   A6,A7                ; Move register to register
FFDAD600h: 2427                     SLL    1h,A7                ; Shift left logical, constant
FFDAD610h: 8421                     MOVE   *A1,A1,0             ; Move field. indirect to register
FFDAD620h: 1421                     DEC    A1                   ; Decrement register
FFDAD630h: 2601                     SLL    10h,A1               ; Shift left logical, constant
FFDAD640h: A22F                     MOVE   A1,-*SP,1            ; Move field. register to indirect (predecrement)
FFDAD650h: E224                     SUBXY  A1,A4                ; Subtract registers in XY mode
FFDAD660h: 4C85                     MOVE   A4,A5                ; Move register to register
FFDAD670h: 194D                     MOVK   Ah,A13               ; Move constant (5 bits)
FFDAD680h: 4C42                     MOVE   A2,A2                ; Move register to register
FFDAD690h: CB12                     JRNE   FFDAD7C0h            ; Jump relative conditional
FFDAD6A0h: 5621                     CLR    A1                   ; Clear register
FFDAD6B0h: EF41                     MOVY   A10,A1               ; Move Y half of register
FFDAD6C0h: 950B                     MOVE   *A8+,A11,0           ; Move field. indirect (postincrement) to register
FFDAD6D0h: 496D                     CMP    A11,A13              ; Compare registers
FFDAD6E0h: CA09                     JREQ   FFDAD780h            ; Jump relative conditional
FFDAD6F0h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDAD700h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDAD710h: 632B                     SLL    A9,A11               ; Shift left logical, register
FFDAD720h: 418B                     ADD    A12,A11              ; Add registers
FFDAD730h: 4F60                     MOVE   A11,B0_SADDR         ; Move register to register
FFDAD740h: 0FA0                     PIXBLT B,XY                 ; Pixel block transfer and expand, binary to XY
FFDAD750h: E004                     ADDXY  A0,A4                ; Add registers in XV mode
FFDAD760h: 3D63                     DSJS   A3,FFDAD6C0h         ; Decrement register and skip jump short
FFDAD770h: C043                     JR     FFDADBB0h            ; Jump relative conditional

FFDAD780h: E225                     SUBXY  A1,A5                ; Subtract registers in XY mode
FFDAD790h: 4CA4                     MOVE   A5,A4                ; Move register to register
FFDAD7A0h: 3DE3                     DSJS   A3,FFDAD6C0h         ; Decrement register and skip jump short
FFDAD7B0h: C03F                     JR     FFDADBB0h            ; Jump relative conditional

FFDAD7C0h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDAD7D0h: 058F 00B7 C000           MOVE   SP,@CONTROL+7,0      ; Move field, register to absolute
FFDAD800h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDAD810h: 5642                     CLR    A2                   ; Clear register
FFDAD820h: 950B                     MOVE   *A8+,A11,0           ; Move field. indirect (postincrement) to register
FFDAD830h: 496D                     CMP    A11,A13              ; Compare registers
FFDAD840h: CA17                     JREQ   FFDAD9C0h            ; Jump relative conditional
FFDAD850h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDAD860h: 4F47                     MOVE   A10,B7_DVDX          ; Move register to register
FFDAD870h: 632B                     SLL    A9,A11               ; Shift left logical, register
FFDAD880h: 418B                     ADD    A12,A11              ; Add registers
FFDAD890h: E65E                     CPW    B2_DADDR,B14_TEMP    ; Compare point to window
FFDAD8A0h: CC18                     JRV    FFDADA30h            ; Jump relative conditional
FFDAD8B0h: E0F2                     ADDXY  B7_DVDX,B2_DADDR     ; Add registers in XV mode
FFDAD8C0h: E65E                     CPW    B2_DADDR,B14_TEMP    ; Compare point to window
FFDAD8D0h: CC23                     JRV    FFDADB10h            ; Jump relative conditional
FFDAD8E0h: E2F2                     SUBXY  B7_DVDX,B2_DADDR     ; Subtract registers in XY mode
FFDAD8F0h: E852                     CVXYL  B2_DADDR,B2_DADDR    ; Convert XY address to linear address
FFDAD900h: 80EE                     MOVE   A7,*A14,0            ; Move field. register to indirect
FFDAD910h: 4F60                     MOVE   A11,B0_SADDR         ; Move register to register
FFDAD920h: 950B                     MOVE   *A8+,A11,0           ; Move field. indirect (postincrement) to register
FFDAD930h: 0F80                     PIXBLT B,L                  ; Pixel block transfer, binary to linear
FFDAD940h: E004                     ADDXY  A0,A4                ; Add registers in XV mode
FFDAD950h: 80CE                     MOVE   A6,*A14,0            ; Move field. register to indirect
FFDAD960h: 3E83                     DSJS   A3,FFDAD830h         ; Decrement register and skip jump short
FFDAD970h: C01C                     JR     FFDADB40h            ; Jump relative conditional

FFDAD980h: E004                     ADDXY  A0,A4                ; Add registers in XV mode
FFDAD990h: 950B                     MOVE   *A8+,A11,0           ; Move field. indirect (postincrement) to register
FFDAD9A0h: 3F03                     DSJS   A3,FFDAD830h         ; Decrement register and skip jump short
FFDAD9B0h: C018                     JR     FFDADB40h            ; Jump relative conditional

FFDAD9C0h: 5621                     CLR    A1                   ; Clear register
FFDAD9D0h: EF41                     MOVY   A10,A1               ; Move Y half of register
FFDAD9E0h: E225                     SUBXY  A1,A5                ; Subtract registers in XY mode
FFDAD9F0h: 4CA4                     MOVE   A5,A4                ; Move register to register
FFDADA00h: 950B                     MOVE   *A8+,A11,0           ; Move field. indirect (postincrement) to register
FFDADA10h: 3FE3                     DSJS   A3,FFDAD830h         ; Decrement register and skip jump short
FFDADA20h: C011                     JR     FFDADB40h            ; Jump relative conditional

FFDADA30h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDADA40h: CCF3                     JRV    FFDAD980h            ; Jump relative conditional
FFDADA50h: 4E51                     MOVE   B2_DADDR,A1          ; Move register to register
FFDADA60h: E281                     SUBXY  A4,A1                ; Subtract registers in XY mode
FFDADA70h: EC22                     MOVX   A1,A2                ; Move X half of register
FFDADA80h: 404B                     ADD    A2,A11               ; Add registers
FFDADA90h: 2E01                     SRL    10h,A1               ; Shift right logical, constant
FFDADAA0h: 4E32                     MOVE   B1_SPTCH,A2          ; Move register to register
FFDADAB0h: 6A42                     LMO    A2,A2                ; Leftmost one bit
FFDADAC0h: 03A2                     NEG    A2                   ; Negate register
FFDADAD0h: 13E2                     ADDK   1Fh,A2               ; Add constant (5 bits)
FFDADAE0h: 6241                     SLL    A2,A1                ; Shift left logical, register
FFDADAF0h: 402B                     ADD    A1,A11               ; Add registers
FFDADB00h: C0DE                     JR     FFDAD8F0h            ; Jump relative conditional

FFDADB10h: E2F2                     SUBXY  B7_DVDX,B2_DADDR     ; Subtract registers in XY mode
FFDADB20h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDADB30h: C0DB                     JR     FFDAD8F0h            ; Jump relative conditional

FFDADB40h: 1821                     MOVK   1h,A1                ; Move constant (5 bits)
FFDADB50h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDADB60h: 0581 00B7 C000           MOVE   A1,@CONTROL+7,0      ; Move field, register to absolute
FFDADB90h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDADBA0h: 0300                     NOP                         ; No operation
FFDADBB0h: 97E1                     MOVE   *SP+,A1,1            ; Move field. indirect (postincrement) to register
FFDADBC0h: E024                     ADDXY  A1,A4                ; Add registers in XV mode
FFDADBD0h: 97E8                     MOVE   *SP+,A8,1            ; Move field. indirect (postincrement) to register
FFDADBE0h: 97ED                     MOVE   *SP+,A13,1           ; Move field. indirect (postincrement) to register
FFDADBF0h: C000 FAA9                JR     CMD_LOOP             ; Jump relative conditional

FFDADC10h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDADC20h: 2481                     SLL    4h,A1                ; Shift left logical, constant
FFDADC30h: 4028                     ADD    A1,A8                ; Add registers
FFDADC40h: C000 FAA4                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_48_TEXT_UNDERLINE
********************************************************************************
COMMAND_48_TEXT_UNDERLINE:
FFDADC60h: C000 FAA2                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_50_CALL
********************************************************************************
COMMAND_50_CALL:
FFDADC80h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDADC90h: 930D                     MOVE   A8,*A13+,1           ; Move field. register to indirect (postincrement)
FFDADCA0h: 4C28                     MOVE   A1,A8                ; Move register to register
FFDADCB0h: C000 FA9D                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_52_CALL_NOT_USER_FLAG
********************************************************************************
COMMAND_52_CALL_NOT_USER_FLAG:
FFDADCD0h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDADCE0h: 2481                     SLL    4h,A1                ; Shift left logical, constant
FFDADCF0h: 0B21 0000 FFDA           ADDI   USERFLAGS,A1         ; Add immediate (32 bits)
FFDADD20h: 8421                     MOVE   *A1,A1,0             ; Move field. indirect to register
FFDADD30h: CB05                     JRNE   FFDADD90h            ; Jump relative conditional
FFDADD40h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDADD50h: 930D                     MOVE   A8,*A13+,1           ; Move field. register to indirect (postincrement)
FFDADD60h: 4C28                     MOVE   A1,A8                ; Move register to register
FFDADD70h: C000 FA91                JR     CMD_LOOP             ; Jump relative conditional

FFDADD90h: 1008                     ADDK   20h,A8               ; Add constant (5 bits)
FFDADDA0h: C000 FA8E                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_54_CALL_ON_USER_FLAG
********************************************************************************
COMMAND_54_CALL_ON_USER_FLAG:
FFDADDC0h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDADDD0h: 2481                     SLL    4h,A1                ; Shift left logical, constant
FFDADDE0h: 0B21 0000 FFDA           ADDI   USERFLAGS,A1         ; Add immediate (32 bits)
FFDADE10h: 8421                     MOVE   *A1,A1,0             ; Move field. indirect to register
FFDADE20h: CA05                     JREQ   FFDADE80h            ; Jump relative conditional
FFDADE30h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDADE40h: 930D                     MOVE   A8,*A13+,1           ; Move field. register to indirect (postincrement)
FFDADE50h: 4C28                     MOVE   A1,A8                ; Move register to register
FFDADE60h: C000 FA82                JR     CMD_LOOP             ; Jump relative conditional

FFDADE80h: 1008                     ADDK   20h,A8               ; Add constant (5 bits)
FFDADE90h: C000 FA7F                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_56_JUMP
********************************************************************************
COMMAND_56_JUMP:
FFDADEB0h: 8708                     MOVE   *A8,A8,1             ; Move field. indirect to register
FFDADEC0h: C000 FA7C                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_58_JUMP_NOT_USER_FLAG
********************************************************************************
COMMAND_58_JUMP_NOT_USER_FLAG:
FFDADEE0h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDADEF0h: 2481                     SLL    4h,A1                ; Shift left logical, constant
FFDADF00h: 0B21 0000 FFDA           ADDI   USERFLAGS,A1         ; Add immediate (32 bits)
FFDADF30h: 8421                     MOVE   *A1,A1,0             ; Move field. indirect to register
FFDADF40h: CB03                     JRNE   FFDADF80h            ; Jump relative conditional
FFDADF50h: 8708                     MOVE   *A8,A8,1             ; Move field. indirect to register
FFDADF60h: C000 FA72                JR     CMD_LOOP             ; Jump relative conditional

FFDADF80h: 1008                     ADDK   20h,A8               ; Add constant (5 bits)
FFDADF90h: C000 FA6F                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_60_JUMP_ON_USER_FLAG
********************************************************************************
COMMAND_60_JUMP_ON_USER_FLAG:
FFDADFB0h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDADFC0h: 2481                     SLL    4h,A1                ; Shift left logical, constant
FFDADFD0h: 0B21 0000 FFDA           ADDI   USERFLAGS,A1         ; Add immediate (32 bits)
FFDAE000h: 8421                     MOVE   *A1,A1,0             ; Move field. indirect to register
FFDAE010h: CA03                     JREQ   FFDAE050h            ; Jump relative conditional
FFDAE020h: 8708                     MOVE   *A8,A8,1             ; Move field. indirect to register
FFDAE030h: C000 FA65                JR     CMD_LOOP             ; Jump relative conditional

FFDAE050h: 1008                     ADDK   20h,A8               ; Add constant (5 bits)
FFDAE060h: C000 FA62                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_62_RETURN
********************************************************************************
COMMAND_62_RETURN:
FFDAE080h: A7A8                     MOVE   -*A13,A8,1           ; Move field. indirect (predecrement) to register
FFDAE090h: C000 FA5F                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_64_SKIP1
********************************************************************************
COMMAND_64_SKIP1:
FFDAE0B0h: 1208                     ADDK   10h,A8               ; Add constant (5 bits)
FFDAE0C0h: C000 FA5C                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_66_SKIP2
********************************************************************************
COMMAND_66_SKIP2:
FFDAE0E0h: 1008                     ADDK   20h,A8               ; Add constant (5 bits)
FFDAE0F0h: C000 FA59                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_68_SKIP3
********************************************************************************
COMMAND_68_SKIP3:
FFDAE110h: 0B08 0030                ADDI   30h,A8               ; Add immediate (16 bits)
FFDAE130h: C000 FA55                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_70_SKIP4
********************************************************************************
COMMAND_70_SKIP4:
FFDAE150h: 0B08 0040                ADDI   40h,A8               ; Add immediate (16 bits)
FFDAE170h: C000 FA51                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_72_USER_FLAG_CLEAR
********************************************************************************
COMMAND_72_USER_FLAG_CLEAR:
FFDAE190h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDAE1A0h: 2481                     SLL    4h,A1                ; Shift left logical, constant
FFDAE1B0h: 0B21 0000 FFDA           ADDI   USERFLAGS,A1         ; Add immediate (32 bits)
FFDAE1E0h: 5642                     CLR    A2                   ; Clear register
FFDAE1F0h: 8041                     MOVE   A2,*A1,0             ; Move field. register to indirect
FFDAE200h: C000 FA48                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_74_USER_FLAG_SET
********************************************************************************
COMMAND_74_USER_FLAG_SET:
FFDAE220h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDAE230h: 2481                     SLL    4h,A1                ; Shift left logical, constant
FFDAE240h: 0B21 0000 FFDA           ADDI   USERFLAGS,A1         ; Add immediate (32 bits)
FFDAE270h: 1822                     MOVK   1h,A2                ; Move constant (5 bits)
FFDAE280h: 8041                     MOVE   A2,*A1,0             ; Move field. register to indirect
FFDAE290h: C000 FA3F                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_76_USER_FLAG_TOGGLE 
********************************************************************************
COMMAND_76_USER_FLAG_TOGGLE :
FFDAE2B0h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDAE2C0h: 2481                     SLL    4h,A1                ; Shift left logical, constant
FFDAE2D0h: 0B21 0000 FFDA           ADDI   USERFLAGS,A1         ; Add immediate (32 bits)
FFDAE300h: 8422                     MOVE   *A1,A2,0             ; Move field. indirect to register
FFDAE310h: 1823                     MOVK   1h,A3                ; Move constant (5 bits)
FFDAE320h: 5662                     XOR    A3,A2                ; XOR registers
FFDAE330h: 8041                     MOVE   A2,*A1,0             ; Move field. register to indirect
FFDAE340h: C000 FA34                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_78_DYNAMIC_FRAME
********************************************************************************
COMMAND_78_DYNAMIC_FRAME:
FFDAE360h: 05A1 0840 FFEC           MOVE   @FFEC0840h,A1,0      ; Move field, absolute to register
FFDAE390h: CBFC                     JRNE   COMMAND_78_DYNAMIC_FRAME ; Jump relative conditional
FFDAE3A0h: 09F4 0000 001E           MOVI   SCREENBASE_0x001E_0000,B4_OFFSET ; Move immediate (32 bits)
FFDAE3D0h: 05A1 0090 C000           MOVE   @DPYSTRT,A1,0        ; Move field, absolute to register
FFDAE400h: 0B41 E20F                CMPI   1DF0h,A1             ; Compare immediate (16 bits)
FFDAE420h: CA03                     JREQ   FFDAE460h            ; Jump relative conditional
FFDAE430h: 09F4 0000 0000           MOVI   SCREENBASE_0x0000_0000,B4_OFFSET ; Move immediate (32 bits)
FFDAE460h: 07BE 09C0 FFEC           MOVE   @FFEC09C0h,B14_TEMP,1 ; Move field, absolute to register
FFDAE490h: 41D4                     ADD    B14_TEMP,B4_OFFSET   ; Add registers
FFDAE4A0h: C000 FA1E                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_80_STATIC_FRAME
********************************************************************************
COMMAND_80_STATIC_FRAME:
FFDAE4C0h: 5621                     CLR    A1                   ; Clear register
FFDAE4D0h: 0581 0840 FFEC           MOVE   A1,@FFEC0840h,0      ; Move field, register to absolute
FFDAE500h: 07BE 09C0 FFEC           MOVE   @FFEC09C0h,B14_TEMP,1 ; Move field, absolute to register
FFDAE530h: 09F4 0000 003C           MOVI   SCREENBASE_0x003C_0000,B4_OFFSET ; Move immediate (32 bits)
FFDAE560h: 41D4                     ADD    B14_TEMP,B4_OFFSET   ; Add registers
FFDAE570h: C000 FA11                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_82_STATIC_FRAME_AND_ERASE
********************************************************************************
COMMAND_82_STATIC_FRAME_AND_ERASE:
FFDAE590h: 1841                     MOVK   2h,A1                ; Move constant (5 bits)
FFDAE5A0h: 0581 0840 FFEC           MOVE   A1,@FFEC0840h,0      ; Move field, register to absolute
FFDAE5D0h: 07BE 09C0 FFEC           MOVE   @FFEC09C0h,B14_TEMP,1 ; Move field, absolute to register
FFDAE600h: 09F4 0000 003C           MOVI   SCREENBASE_0x003C_0000,B4_OFFSET ; Move immediate (32 bits)
FFDAE630h: 05A1 0840 FFEC           MOVE   @FFEC0840h,A1,0      ; Move field, absolute to register
FFDAE660h: CBFC                     JRNE   FFDAE630h            ; Jump relative conditional
FFDAE670h: 41D4                     ADD    B14_TEMP,B4_OFFSET   ; Add registers
FFDAE680h: C000 FA00                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_84_GATED_CALL
********************************************************************************
COMMAND_84_GATED_CALL:
FFDAE6A0h: 1608                     SUBK   10h,A8               ; Subtract constant (5 bits)
FFDAE6B0h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDAE6C0h: 8501                     MOVE   *A8,A1,0             ; Move field. indirect to register
FFDAE6D0h: CB09                     JRNE   FFDAE770h            ; Jump relative conditional
FFDAE6E0h: 1821                     MOVK   1h,A1                ; Move constant (5 bits)
FFDAE6F0h: 8028                     MOVE   A1,*A8,0             ; Move field. register to indirect
FFDAE700h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDAE710h: 1208                     ADDK   10h,A8               ; Add constant (5 bits)
FFDAE720h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDAE730h: 930D                     MOVE   A8,*A13+,1           ; Move field. register to indirect (postincrement)
FFDAE740h: 4C28                     MOVE   A1,A8                ; Move register to register
FFDAE750h: C000 F9F3                JR     CMD_LOOP             ; Jump relative conditional

FFDAE770h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDAE780h: 0B08 0040                ADDI   40h,A8               ; Add immediate (16 bits)
FFDAE7A0h: C000 F9EE                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_86_INTERRUPT_HOST
********************************************************************************
COMMAND_86_INTERRUPT_HOST:
FFDAE7C0h: 1608                     SUBK   10h,A8               ; Subtract constant (5 bits)
FFDAE7D0h: 0788 08C0 FFEC           MOVE   A8,@INTERRUPT_HOST_CURRENT_PC,1 ; Move field, register to absolute
FFDAE800h: 1208                     ADDK   10h,A8               ; Add constant (5 bits)
FFDAE810h: 0544                     SETF   4h,0,0               ; Set field parameters
FFDAE820h: 1921                     MOVK   9h,A1                ; Move constant (5 bits)
FFDAE830h: 0581 00F4 C000           MOVE   A1,@HSTCTLL+4,0      ; Move field, register to absolute
FFDAE860h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDAE870h: C000 F9E1                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_IGNORE
********************************************************************************
COMMAND_IGNORE:
FFDAE890h: C000 F9DF                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_90_91
********************************************************************************
COMMAND_90_91:
FFDAE8B0h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDAE8C0h: 1821                     MOVK   1h,A1                ; Move constant (5 bits)
FFDAE8D0h: B028 FFF0                MOVE   A1,*A8(FFF0h),0      ; Move field, register to indirect with offset
FFDAE8F0h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDAE900h: C000 F9D8                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_92_SEGMENT_END
********************************************************************************
COMMAND_92_SEGMENT_END:
FFDAE920h: 07A1 08A0 FFEC           MOVE   @FFEC08A0h,A1,1      ; Move field, absolute to register
FFDAE950h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDAE960h: 5642                     CLR    A2                   ; Clear register
FFDAE970h: 8041                     MOVE   A2,*A1,0             ; Move field. register to indirect
FFDAE980h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDAE990h: 07A2 0860 FFEC           MOVE   @FFEC0860h,A2,1      ; Move field, absolute to register
FFDAE9C0h: 4822                     CMP    A1,A2                ; Compare registers
FFDAE9D0h: CB00 F9CB                JRNE   CMD_LOOP             ; Jump relative conditional
FFDAE9F0h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDAEA00h: 1822                     MOVK   1h,A2                ; Move constant (5 bits)
FFDAEA10h: 8041                     MOVE   A2,*A1,0             ; Move field. register to indirect
FFDAEA20h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDAEA30h: 5642                     CLR    A2                   ; Clear register
FFDAEA40h: 0782 0860 FFEC           MOVE   A2,@FFEC0860h,1      ; Move field, register to absolute
FFDAEA70h: C000 F9C1                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_94_SEGMENT_END_AND_RETURN
********************************************************************************
COMMAND_94_SEGMENT_END_AND_RETURN:
FFDAEA90h: A7A8                     MOVE   -*A13,A8,1           ; Move field. indirect (predecrement) to register
FFDAEAA0h: C0E7                     JR     COMMAND_92_SEGMENT_END ; Jump relative conditional

********************************************************************************
* COMMAND_96_SEGMENT_END_AND_JUMP
********************************************************************************
COMMAND_96_SEGMENT_END_AND_JUMP:
FFDAEAB0h: 8708                     MOVE   *A8,A8,1             ; Move field. indirect to register
FFDAEAC0h: C0E5                     JR     COMMAND_92_SEGMENT_END ; Jump relative conditional

********************************************************************************
* COMMAND_98_SEGMENT_START
********************************************************************************
COMMAND_98_SEGMENT_START:
FFDAEAD0h: 1608                     SUBK   10h,A8               ; Subtract constant (5 bits)
FFDAEAE0h: 0360                     DINT                        ; Disable Interrupts
FFDAEAF0h: 8501                     MOVE   *A8,A1,0             ; Move field. indirect to register
FFDAEB00h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDAEB10h: CB05                     JRNE   FFDAEB70h            ; Jump relative conditional
FFDAEB20h: 0788 08A0 FFEC           MOVE   A8,@FFEC08A0h,1      ; Move field, register to absolute
FFDAEB50h: 1021                     INC    A1                   ; Increment register
FFDAEB60h: 8028                     MOVE   A1,*A8,0             ; Move field. register to indirect
FFDAEB70h: 0D60                     EINT                        ; Enable Interrupts
FFDAEB80h: 1208                     ADDK   10h,A8               ; Add constant (5 bits)
FFDAEB90h: C000 F9AF                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_100_STALL
********************************************************************************
COMMAND_100_STALL:
FFDAEBB0h: 1608                     SUBK   10h,A8               ; Subtract constant (5 bits)
FFDAEBC0h: C000 F9AC                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_102_SYNC_COPY_STATIC
********************************************************************************
COMMAND_102_SYNC_COPY_STATIC:
FFDAEBE0h: 09F4 0000 001E           MOVI   SCREENBASE_0x001E_0000,B4_OFFSET ; Move immediate (32 bits)
FFDAEC10h: 05A1 0090 C000           MOVE   @DPYSTRT,A1,0        ; Move field, absolute to register
FFDAEC40h: 0B41 E20F                CMPI   1DF0h,A1             ; Compare immediate (16 bits)
FFDAEC60h: CA03                     JREQ   FFDAECA0h            ; Jump relative conditional
FFDAEC70h: 09F4 0000 0000           MOVI   SCREENBASE_0x0000_0000,B4_OFFSET ; Move immediate (32 bits)
FFDAECA0h: 07BE 09C0 FFEC           MOVE   @FFEC09C0h,B14_TEMP,1 ; Move field, absolute to register
FFDAECD0h: 41D4                     ADD    B14_TEMP,B4_OFFSET   ; Add registers
FFDAECE0h: 1821                     MOVK   1h,A1                ; Move constant (5 bits)
FFDAECF0h: 0581 0840 FFEC           MOVE   A1,@FFEC0840h,0      ; Move field, register to absolute
FFDAED20h: C000 F996                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_104_SYNC_DISPLAY_DYNAMIC
********************************************************************************
COMMAND_104_SYNC_DISPLAY_DYNAMIC:
FFDAED40h: 05A1 0090 C000           MOVE   @DPYSTRT,A1,0        ; Move field, absolute to register
FFDAED70h: 09C2 1DF0                MOVI   1DF0h,A2             ; Move immediate (16 bits)
FFDAED90h: 09F4 0000 001E           MOVI   SCREENBASE_0x001E_0000,B4_OFFSET ; Move immediate (32 bits)
FFDAEDC0h: 4841                     CMP    A2,A1                ; Compare registers
FFDAEDD0h: CB05                     JRNE   FFDAEE30h            ; Jump relative conditional
FFDAEDE0h: 09C2 3BF0                MOVI   3BF0h,A2             ; Move immediate (16 bits)
FFDAEE00h: 09F4 0000 0000           MOVI   SCREENBASE_0x0000_0000,B4_OFFSET ; Move immediate (32 bits)
FFDAEE30h: 0582 0090 C000           MOVE   A2,@DPYSTRT,0        ; Move field, register to absolute
FFDAEE60h: 07BE 09C0 FFEC           MOVE   @FFEC09C0h,B14_TEMP,1 ; Move field, absolute to register
FFDAEE90h: 41D4                     ADD    B14_TEMP,B4_OFFSET   ; Add registers
FFDAEEA0h: 1821                     MOVK   1h,A1                ; Move constant (5 bits)
FFDAEEB0h: 0581 0840 FFEC           MOVE   A1,@FFEC0840h,0      ; Move field, register to absolute
FFDAEEE0h: C000 F97A                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_106_BENCHMARK_START_0x6a
********************************************************************************
COMMAND_106_BENCHMARK_START_0x6a:
FFDAEF00h: 09E5 0AC0 FFEC           MOVI   FFEC0AC0h,A5         ; Move immediate (32 bits)
FFDAEF30h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDAEF40h: 058F 011A C000           MOVE   SP,@INTENB+10,0      ; Move field, register to absolute
FFDAEF70h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDAEF80h: 07A1 0A80 FFEC           MOVE   @FFEC0A80h,A1,1      ; Move field, absolute to register
FFDAEFB0h: 05A2 01D0 C000           MOVE   @VCOUNT,A2,0         ; Move field, absolute to register
FFDAEFE0h: 195E                     MOVK   Ah,B14_TEMP          ; Move constant (5 bits)
FFDAEFF0h: 4C43                     MOVE   A2,A3                ; Move register to register
FFDAF000h: 05A2 01D0 C000           MOVE   @VCOUNT,A2,0         ; Move field, absolute to register
FFDAF030h: 4843                     CMP    A2,A3                ; Compare registers
FFDAF040h: CA01                     JREQ   FFDAF060h            ; Jump relative conditional
FFDAF050h: 3CFE                     DSJS   B14_TEMP,FFDAEFF0h   ; Decrement register and skip jump short
FFDAF060h: 09C3 0201                MOVI   201h,A3              ; Move immediate (16 bits)
FFDAF080h: 4462                     SUB    A3,A2                ; Subtract registers
FFDAF090h: C405                     JRLT   FFDAF0F0h            ; Jump relative conditional
FFDAF0A0h: 07A3 0AA0 FFEC           MOVE   @FFEC0AA0h,A3,1      ; Move field, absolute to register
FFDAF0D0h: 4823                     CMP    A1,A3                ; Compare registers
FFDAF0E0h: CB02                     JRNE   FFDAF110h            ; Jump relative conditional
FFDAF0F0h: 0B01 020D                ADDI   20Dh,A1              ; Add immediate (16 bits)
FFDAF110h: 4041                     ADD    A2,A1                ; Add registers
FFDAF120h: 8225                     MOVE   A1,*A5,1             ; Move field. register to indirect
FFDAF130h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDAF140h: 183A                     MOVK   1h,B10_COUNT         ; Move constant (5 bits)
FFDAF150h: 059A 011A C000           MOVE   B10_COUNT,@INTENB+10,0 ; Move field, register to absolute
FFDAF180h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDAF190h: C000 F94F                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_108_BENCHMARK_START_0x6c
********************************************************************************
COMMAND_108_BENCHMARK_START_0x6c:
FFDAF1B0h: 09E5 0AE0 FFEC           MOVI   FFEC0AE0h,A5         ; Move immediate (32 bits)
FFDAF1E0h: C0D4                     JR     FFDAEF30h            ; Jump relative conditional

********************************************************************************
* COMMAND_110_CLIP_OFF
********************************************************************************
COMMAND_110_CLIP_OFF:
FFDAF1F0h: 09F5 0000 0000           MOVI   SCREENBASE_0x0000_0000,B5_WSTART ; Move immediate (32 bits)
FFDAF220h: 09F6 027F 01DF           MOVI   01DF027Fh,B6_WEND    ; Move immediate (32 bits)
FFDAF250h: C000 F943                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_112_CLIP_ON
********************************************************************************
COMMAND_112_CLIP_ON:
FFDAF270h: 07B5 0A40 FFEC           MOVE   @CLIP_MIN_XY,B5_WSTART,1 ; Move field, absolute to register
FFDAF2A0h: 07B6 0A60 FFEC           MOVE   @CLIP_MAX_XY,B6_WEND,1 ; Move field, absolute to register
FFDAF2D0h: C000 F93B                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_114_CLIP_RECTANGLE
********************************************************************************
COMMAND_114_CLIP_RECTANGLE:
FFDAF2F0h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDAF300h: 0781 0A00 FFEC           MOVE   A1,@FFEC0A00h,1      ; Move field, register to absolute
FFDAF330h: 4E22                     MOVE   A1,B2_DADDR          ; Move register to register
FFDAF340h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDAF350h: 0781 0A20 FFEC           MOVE   A1,@FFEC0A20h,1      ; Move field, register to absolute
FFDAF380h: 4E27                     MOVE   A1,B7_DVDX           ; Move register to register
FFDAF390h: 09F5 0000 0000           MOVI   SCREENBASE_0x0000_0000,B5_WSTART ; Move immediate (32 bits)
FFDAF3C0h: 09F6 027F 01DF           MOVI   01DF027Fh,B6_WEND    ; Move immediate (32 bits)
FFDAF3F0h: 09F0 0001 0001           MOVI   00010001h,B0_SADDR   ; Move immediate (32 bits)
FFDAF420h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDAF430h: 0588 00B7 C000           MOVE   A8,@CONTROL+7,0      ; Move field, register to absolute
FFDAF460h: 07B1 09E0 FFEC           MOVE   @FFEC09E0h,B1_SPTCH,1 ; Move field, absolute to register
FFDAF490h: E032                     ADDXY  B1_SPTCH,B2_DADDR    ; Add registers in XV mode
FFDAF4A0h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDAF4B0h: 0590 00B7 C000           MOVE   B0_SADDR,@CONTROL+7,0 ; Move field, register to absolute
FFDAF4E0h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDAF4F0h: CD02                     JRNV   FFDAF520h            ; Jump relative conditional
FFDAF500h: 4CB6                     MOVE   B5_WSTART,B6_WEND    ; Move register to register
FFDAF510h: C004                     JR     FFDAF560h            ; Jump relative conditional

FFDAF520h: 4C55                     MOVE   B2_DADDR,B5_WSTART   ; Move register to register
FFDAF530h: E235                     SUBXY  B1_SPTCH,B5_WSTART   ; Subtract registers in XY mode
FFDAF540h: 4CF6                     MOVE   B7_DVDX,B6_WEND      ; Move register to register
FFDAF550h: E0B6                     ADDXY  B5_WSTART,B6_WEND    ; Add registers in XV mode
FFDAF560h: E216                     SUBXY  B0_SADDR,B6_WEND     ; Subtract registers in XY mode
FFDAF570h: 0795 0A40 FFEC           MOVE   B5_WSTART,@CLIP_MIN_XY,1 ; Move field, register to absolute
FFDAF5A0h: 0796 0A60 FFEC           MOVE   B6_WEND,@CLIP_MAX_XY,1 ; Move field, register to absolute
FFDAF5D0h: C000 F90B                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_116_MOVE_ABSOLUTE_0x74
********************************************************************************
COMMAND_116_MOVE_ABSOLUTE_0x74:
FFDAF5F0h: 9704                     MOVE   *A8+,A4,1            ; Move field. indirect (postincrement) to register
FFDAF600h: C000 F908                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_118_MOVE_ABSOLUTE_0x76
********************************************************************************
COMMAND_118_MOVE_ABSOLUTE_0x76:
FFDAF620h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDAF630h: E024                     ADDXY  A1,A4                ; Add registers in XV mode
FFDAF640h: C000 F904                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_120_ORIGIN
********************************************************************************
COMMAND_120_ORIGIN:
FFDAF660h: 07BE 09C0 FFEC           MOVE   @FFEC09C0h,B14_TEMP,1 ; Move field, absolute to register
FFDAF690h: 45D4                     SUB    B14_TEMP,B4_OFFSET   ; Subtract registers
FFDAF6A0h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDAF6B0h: 0781 09E0 FFEC           MOVE   A1,@FFEC09E0h,1      ; Move field, register to absolute
FFDAF6E0h: E821                     CVXYL  A1,A1                ; Convert XY address to linear address
FFDAF6F0h: 4E2E                     MOVE   A1,B14_TEMP          ; Move register to register
FFDAF700h: 449E                     SUB    B4_OFFSET,B14_TEMP   ; Subtract registers
FFDAF710h: 079E 09C0 FFEC           MOVE   B14_TEMP,@FFEC09C0h,1 ; Move field, register to absolute
FFDAF740h: 4E24                     MOVE   A1,B4_OFFSET         ; Move register to register
FFDAF750h: 07B2 0A00 FFEC           MOVE   @FFEC0A00h,B2_DADDR,1 ; Move field, absolute to register
FFDAF780h: 07B7 0A20 FFEC           MOVE   @FFEC0A20h,B7_DVDX,1 ; Move field, absolute to register
FFDAF7B0h: C0BD                     JR     FFDAF390h            ; Jump relative conditional

********************************************************************************
* COMMAND_122_PIXEL_OPERATION
********************************************************************************
COMMAND_122_PIXEL_OPERATION:
FFDAF7C0h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDAF7D0h: 4E28                     MOVE   A1,B8_COLOR0         ; Move register to register
FFDAF7E0h: 4D1E                     MOVE   B8_COLOR0,B14_TEMP   ; Move register to register
FFDAF7F0h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDAF800h: 55D8                     OR     B14_TEMP,B8_COLOR0   ; OR registers
FFDAF810h: 4D1E                     MOVE   B8_COLOR0,B14_TEMP   ; Move register to register
FFDAF820h: 251E                     SLL    8h,B14_TEMP          ; Shift left logical, constant
FFDAF830h: 55D8                     OR     B14_TEMP,B8_COLOR0   ; OR registers
FFDAF840h: 4D1E                     MOVE   B8_COLOR0,B14_TEMP   ; Move register to register
FFDAF850h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDAF860h: 55D8                     OR     B14_TEMP,B8_COLOR0   ; OR registers
FFDAF870h: C000 F8E1                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_124_PEN_FOREGROUND
********************************************************************************
COMMAND_124_PEN_FOREGROUND:
FFDAF890h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDAF8A0h: 4E29                     MOVE   A1,B9_COLOR1         ; Move register to register
FFDAF8B0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAF8C0h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDAF8D0h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAF8E0h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAF8F0h: 251E                     SLL    8h,B14_TEMP          ; Shift left logical, constant
FFDAF900h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAF910h: 4D3E                     MOVE   B9_COLOR1,B14_TEMP   ; Move register to register
FFDAF920h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDAF930h: 55D9                     OR     B14_TEMP,B9_COLOR1   ; OR registers
FFDAF940h: C000 F8D4                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_126_127
********************************************************************************
COMMAND_126_127:
FFDAF960h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDAF970h: 0545                     SETF   5h,0,0               ; Set field parameters
FFDAF980h: 0581 00BA C000           MOVE   A1,@CONTROL+10,0     ; Move field, register to absolute
FFDAF9B0h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDAF9C0h: C000 F8CC                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_128_PIXEL_STRETCH_OFF
********************************************************************************
COMMAND_128_PIXEL_STRETCH_OFF:
FFDAF9E0h: 5621                     CLR    A1                   ; Clear register
FFDAF9F0h: 0581 0920 FFEC           MOVE   A1,@PIXEL_STRETCH_ENABLED_FLAG,0 ; Move field, register to absolute
FFDAFA20h: C000 F8C6                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_130_PIXEL_STRETCH_ON
********************************************************************************
COMMAND_130_PIXEL_STRETCH_ON:
FFDAFA40h: 1821                     MOVK   1h,A1                ; Move constant (5 bits)
FFDAFA50h: 0581 0920 FFEC           MOVE   A1,@PIXEL_STRETCH_ENABLED_FLAG,0 ; Move field, register to absolute
FFDAFA80h: C000 F8C0                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_132_SCALE_FACTOR_0x84
********************************************************************************
COMMAND_132_SCALE_FACTOR_0x84:
FFDAFAA0h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDAFAB0h: 0781 0940 FFEC           MOVE   A1,@SCALE_FACTOR_DX_A,1 ; Move field, register to absolute
FFDAFAE0h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDAFAF0h: 0781 0960 FFEC           MOVE   A1,@SCALE_FACTOR_DY_A,1 ; Move field, register to absolute
FFDAFB20h: C000 F8B6                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_134_SCALE_FACTOR_0x86
********************************************************************************
COMMAND_134_SCALE_FACTOR_0x86:
FFDAFB40h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDAFB50h: 0581 0980 FFEC           MOVE   A1,@SCALE_FACTOR_DX_B,0 ; Move field, register to absolute
FFDAFB80h: 9501                     MOVE   *A8+,A1,0            ; Move field. indirect (postincrement) to register
FFDAFB90h: 0581 09A0 FFEC           MOVE   A1,@SCALE_FACTOR_DY_B,0 ; Move field, register to absolute
FFDAFBC0h: C000 F8AC                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_136_TEXT_FONT
********************************************************************************
COMMAND_136_TEXT_FONT:
FFDAFBE0h: 9503                     MOVE   *A8+,A3,0            ; Move field. indirect (postincrement) to register
FFDAFBF0h: 09E1 9540 FFDC           MOVI   FONTS_TABLES,A1      ; Move immediate (32 bits)
FFDAFC20h: 24A3                     SLL    5h,A3                ; Shift left logical, constant
FFDAFC30h: 4061                     ADD    A3,A1                ; Add registers
FFDAFC40h: 09E2 0CD0 FFEC           MOVI   CURRENT_FONT,A2      ; Move immediate (32 bits)
FFDAFC70h: 09C7 0010                MOVI   10h,A7               ; Move immediate (16 bits)
FFDAFC90h: 8623                     MOVE   *A1,A3,1             ; Move field. indirect to register
FFDAFCA0h: 9A62                     MOVE   *A3+,*A2+,1          ; Move field, indirect (postincrement) to indirect (postincrement)
FFDAFCB0h: 3C47                     DSJS   A7,FFDAFCA0h         ; Decrement register and skip jump short
FFDAFCC0h: C000 F89C                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_138_TRANSPARENCY_OFF
********************************************************************************
COMMAND_138_TRANSPARENCY_OFF:
FFDAFCE0h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDAFCF0h: 5621                     CLR    A1                   ; Clear register
FFDAFD00h: 0581 00B5 C000           MOVE   A1,@CONTROL+5,0      ; Move field, register to absolute
FFDAFD30h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDAFD40h: C000 F894                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_140_TRANSPARENCY_ON
********************************************************************************
COMMAND_140_TRANSPARENCY_ON:
FFDAFD60h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDAFD70h: 1821                     MOVK   1h,A1                ; Move constant (5 bits)
FFDAFD80h: 0581 00B5 C000           MOVE   A1,@CONTROL+5,0      ; Move field, register to absolute
FFDAFDB0h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDAFDC0h: C000 F88C                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* HI_VECTOR
********************************************************************************
HI_VECTOR:
FFDAFDE0h: 098F 6000                MMTM   SP,A1,A2             ; If Register n is in the register list: Rn → -*Rd (repeat for n = 0 to 15)
FFDAFE00h: 05A1 00F0 C000           MOVE   @HSTCTLL,A1,0        ; Move field, absolute to register
FFDAFE30h: 27A1                     SLL    1Dh,A1               ; Shift left logical, constant
FFDAFE40h: 2D01                     SRL    18h,A1               ; Shift right logical, constant
FFDAFE50h: 0B21 0B80 FFEC           ADDI   MSGIN_TABLE,A1       ; Add immediate (32 bits)
FFDAFE80h: 8621                     MOVE   *A1,A1,1             ; Move field. indirect to register
FFDAFE90h: 0161                     JUMP   A1                   ; Jump indirect

********************************************************************************
* MSGIN_1
********************************************************************************
MSGIN_1:
FFDAFEA0h: 07A1 0860 FFEC           MOVE   @FFEC0860h,A1,1      ; Move field, absolute to register
FFDAFED0h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDAFEE0h: 8422                     MOVE   *A1,A2,0             ; Move field. indirect to register
FFDAFEF0h: CB06                     JRNE   FFDAFF60h            ; Jump relative conditional
FFDAFF00h: 1822                     MOVK   1h,A2                ; Move constant (5 bits)
FFDAFF10h: 8041                     MOVE   A2,*A1,0             ; Move field. register to indirect
FFDAFF20h: 5642                     CLR    A2                   ; Clear register
FFDAFF30h: 0782 0860 FFEC           MOVE   A2,@FFEC0860h,1      ; Move field, register to absolute
FFDAFF60h: 0588 00F3 C000           MOVE   A8,@HSTCTLL+3,0      ; Move field, register to absolute
FFDAFF90h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDAFFA0h: 09AF 0006                MMFM   SP,A1,A2             ; If Register n is in the register list: *Rs+ → Rn (repeat for n = 0 to 15)
FFDAFFC0h: 0940                     RETI                        ; Return from interrupt

********************************************************************************
* MSGIN_2
********************************************************************************
MSGIN_2:
FFDAFFD0h: 09E1 0ED0 FFEC           MOVI   FFEC0ED0h,A1         ; Move immediate (32 bits)
FFDB0000h: B7E2 0060                MOVE   *SP(60h),A2,1        ; Move field, indirect with offset to register
FFDB0020h: 9241                     MOVE   A2,*A1+,1            ; Move field. register to indirect (postincrement)
FFDB0030h: B7E2 0040                MOVE   *SP(40h),A2,1        ; Move field, indirect with offset to register
FFDB0050h: 9241                     MOVE   A2,*A1+,1            ; Move field. register to indirect (postincrement)
FFDB0060h: 9201                     MOVE   A0,*A1+,1            ; Move field. register to indirect (postincrement)
FFDB0070h: B7E2 0020                MOVE   *SP(20h),A2,1        ; Move field, indirect with offset to register
FFDB0090h: 9241                     MOVE   A2,*A1+,1            ; Move field. register to indirect (postincrement)
FFDB00A0h: 87E2                     MOVE   *SP,A2,1             ; Move field. indirect to register
FFDB00B0h: 9241                     MOVE   A2,*A1+,1            ; Move field. register to indirect (postincrement)
FFDB00C0h: 9261                     MOVE   A3,*A1+,1            ; Move field. register to indirect (postincrement)
FFDB00D0h: 9281                     MOVE   A4,*A1+,1            ; Move field. register to indirect (postincrement)
FFDB00E0h: 92A1                     MOVE   A5,*A1+,1            ; Move field. register to indirect (postincrement)
FFDB00F0h: 92C1                     MOVE   A6,*A1+,1            ; Move field. register to indirect (postincrement)
FFDB0100h: 92E1                     MOVE   A7,*A1+,1            ; Move field. register to indirect (postincrement)
FFDB0110h: 9301                     MOVE   A8,*A1+,1            ; Move field. register to indirect (postincrement)
FFDB0120h: 9321                     MOVE   A9,*A1+,1            ; Move field. register to indirect (postincrement)
FFDB0130h: 9341                     MOVE   A10,*A1+,1           ; Move field. register to indirect (postincrement)
FFDB0140h: 9361                     MOVE   A11,*A1+,1           ; Move field. register to indirect (postincrement)
FFDB0150h: 9381                     MOVE   A12,*A1+,1           ; Move field. register to indirect (postincrement)
FFDB0160h: 93A1                     MOVE   A13,*A1+,1           ; Move field. register to indirect (postincrement)
FFDB0170h: 93C1                     MOVE   A14,*A1+,1           ; Move field. register to indirect (postincrement)
FFDB0180h: 4E12                     MOVE   B0_SADDR,A2          ; Move register to register
FFDB0190h: 9241                     MOVE   A2,*A1+,1            ; Move field. register to indirect (postincrement)
FFDB01A0h: 4E20                     MOVE   A1,B0_SADDR          ; Move register to register
FFDB01B0h: 9230                     MOVE   B1_SPTCH,*B0_SADDR+,1 ; Move field. register to indirect (postincrement)
FFDB01C0h: 9250                     MOVE   B2_DADDR,*B0_SADDR+,1 ; Move field. register to indirect (postincrement)
FFDB01D0h: 9270                     MOVE   B3_DPTCH,*B0_SADDR+,1 ; Move field. register to indirect (postincrement)
FFDB01E0h: 9290                     MOVE   B4_OFFSET,*B0_SADDR+,1 ; Move field. register to indirect (postincrement)
FFDB01F0h: 92B0                     MOVE   B5_WSTART,*B0_SADDR+,1 ; Move field. register to indirect (postincrement)
FFDB0200h: 92D0                     MOVE   B6_WEND,*B0_SADDR+,1 ; Move field. register to indirect (postincrement)
FFDB0210h: 92F0                     MOVE   B7_DVDX,*B0_SADDR+,1 ; Move field. register to indirect (postincrement)
FFDB0220h: 9310                     MOVE   B8_COLOR0,*B0_SADDR+,1 ; Move field. register to indirect (postincrement)
FFDB0230h: 9330                     MOVE   B9_COLOR1,*B0_SADDR+,1 ; Move field. register to indirect (postincrement)
FFDB0240h: 9350                     MOVE   B10_COUNT,*B0_SADDR+,1 ; Move field. register to indirect (postincrement)
FFDB0250h: 9370                     MOVE   B11_INC1,*B0_SADDR+,1 ; Move field. register to indirect (postincrement)
FFDB0260h: 9390                     MOVE   B12_INC2,*B0_SADDR+,1 ; Move field. register to indirect (postincrement)
FFDB0270h: 93B0                     MOVE   B13_PATTRN,*B0_SADDR+,1 ; Move field. register to indirect (postincrement)
FFDB0280h: 93D0                     MOVE   B14_TEMP,*B0_SADDR+,1 ; Move field. register to indirect (postincrement)
FFDB0290h: 4E40                     MOVE   A2,B0_SADDR          ; Move register to register
********************************************************************************
* MSGIN_0_3_4_7
********************************************************************************
MSGIN_0_3_4_7:
FFDB02A0h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDB02B0h: C0CA                     JR     FFDAFF60h            ; Jump relative conditional

********************************************************************************
* DI_VECTOR
********************************************************************************
DI_VECTOR:
FFDB02C0h: 099F 000A                MMTM   SP,B12_INC2,B14_TEMP ; If Register n is in the register list: Rn → -*Rd (repeat for n = 0 to 15)
FFDB02E0h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDB02F0h: 058F 012A C000           MOVE   SP,@INTPEND+10,0     ; Move field, register to absolute
FFDB0320h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB0330h: 05BE 00A0 C000           MOVE   @DPYINT,B14_TEMP,0   ; Move field, absolute to register
FFDB0360h: 05BC 0050 C000           MOVE   @VEBLNK,B12_INC2,0   ; Move field, absolute to register
FFDB0390h: 49DC                     CMP    B14_TEMP,B12_INC2    ; Compare registers
FFDB03A0h: CB0D                     JRNE   FFDB0480h            ; Jump relative conditional
FFDB03B0h: 05BC 0060 C000           MOVE   @VSBLNK,B12_INC2,0   ; Move field, absolute to register
FFDB03E0h: 059C 00A0 C000           MOVE   B12_INC2,@DPYINT,0   ; Move field, register to absolute
FFDB0410h: 07C0 0A80 FFEC 0AA0 FFEC MOVE   @FFEC0A80h,@FFEC0AA0h,1 ; Move field, absolute to absolute
FFDB0460h: C000 008A                JR     FFDB0D20h            ; Jump relative conditional

FFDB0480h: 059C 00A0 C000           MOVE   B12_INC2,@DPYINT,0   ; Move field, register to absolute
FFDB04B0h: 07BE 0A80 FFEC           MOVE   @FFEC0A80h,B14_TEMP,1 ; Move field, absolute to register
FFDB04E0h: 0B1E 020D                ADDI   20Dh,B14_TEMP        ; Add immediate (16 bits)
FFDB0500h: 079E 0A80 FFEC           MOVE   B14_TEMP,@FFEC0A80h,1 ; Move field, register to absolute
FFDB0530h: 05BE 0840 FFEC           MOVE   @FFEC0840h,B14_TEMP,0 ; Move field, absolute to register
FFDB0560h: CA7B                     JREQ   FFDB0D20h            ; Jump relative conditional
FFDB0570h: 143E                     DEC    B14_TEMP             ; Decrement register
FFDB0580h: CA37                     JREQ   FFDB0900h            ; Jump relative conditional
FFDB0590h: 05BE 00B0 C000           MOVE   @CONTROL,B14_TEMP,0  ; Move field, absolute to register
FFDB05C0h: 099F 3142                MMTM   SP,B2_DADDR,B3_DPTCH,B7_DVDX,B9_COLOR1,B14_TEMP ; If Register n is in the register list: Rn → -*Rd (repeat for n = 0 to 15)
FFDB05E0h: 57DE                     CLR    B14_TEMP             ; Clear register
FFDB05F0h: 0549                     SETF   9h,0,0               ; Set field parameters
FFDB0600h: 059E 00B6 C000           MOVE   B14_TEMP,@CONTROL+6,0 ; Move field, register to absolute
FFDB0630h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB0640h: 09F3 2000 0000           MOVI   00002000h,B3_DPTCH   ; Move immediate (32 bits)
FFDB0670h: 09F7 0800 0001           MOVI   00010800h,B7_DVDX    ; Move immediate (32 bits)
FFDB06A0h: 09F2 0000 003C           MOVI   SCREENBASE_0x003C_0000,B2_DADDR ; Move immediate (32 bits)
FFDB06D0h: 5739                     CLR    B9_COLOR1            ; Clear register
FFDB06E0h: 05BE 00B0 C000           MOVE   @CONTROL,B14_TEMP,0  ; Move field, absolute to register
FFDB0710h: 0FC0                     FILL   L                    ; Fill array with processed pixels, linear
FFDB0720h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDB0730h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDB0740h: 059E 008B C000           MOVE   B14_TEMP,@DPYCTL+11,0 ; Move field, register to absolute
FFDB0770h: 09F2 0000 003C           MOVI   SCREENBASE_0x003C_0000,B2_DADDR ; Move immediate (32 bits)
FFDB07A0h: 05BE 0080 C000           MOVE   @DPYCTL,B14_TEMP,0   ; Move field, absolute to register
FFDB07D0h: FA5E                     PIXT   *B2_DADDR,B14_TEMP   ; Pixel transfer, indirect to register
FFDB07E0h: 09F7 0004 00F0           MOVI   00F00004h,B7_DVDX    ; Move immediate (32 bits)
FFDB0810h: 0FC0                     FILL   L                    ; Fill array with processed pixels, linear
FFDB0820h: 058F 008B C000           MOVE   SP,@DPYCTL+11,0      ; Move field, register to absolute
FFDB0850h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB0860h: 57DE                     CLR    B14_TEMP             ; Clear register
FFDB0870h: 059E 0840 FFEC           MOVE   B14_TEMP,@FFEC0840h,0 ; Move field, register to absolute
FFDB08A0h: 09BF 428C                MMFM   SP,B2_DADDR,B3_DPTCH,B7_DVDX,B9_COLOR1,B14_TEMP ; If Register n is in the register list: *Rs+ → Rn (repeat for n = 0 to 15)
FFDB08C0h: 059E 00B0 C000           MOVE   B14_TEMP,@CONTROL,0  ; Move field, register to absolute
FFDB08F0h: C042                     JR     FFDB0D20h            ; Jump relative conditional

FFDB0900h: 09DE FFFF                MOVI   FFFFh,B14_TEMP       ; Move immediate (16 bits)
FFDB0920h: 059E 0000 0400           MOVE   B14_TEMP,@04000000h,0 ; Move field, register to absolute
FFDB0950h: 09DE FFFF                MOVI   FFFFh,B14_TEMP       ; Move immediate (16 bits)
FFDB0970h: 059E 0000 0200           MOVE   B14_TEMP,@02000000h,0 ; Move field, register to absolute
FFDB09A0h: 059E 2000 0200           MOVE   B14_TEMP,@02002000h,0 ; Move field, register to absolute
FFDB09D0h: 05BE 0000 0420           MOVE   @04200000h,B14_TEMP,0 ; Move field, absolute to register
FFDB0A00h: 05C0 0090 C000 01E0 C000 MOVE   @DPYSTRT,@DPYADR,0   ; Move field, absolute to absolute
FFDB0A50h: 05BE 00B0 C000           MOVE   @CONTROL,B14_TEMP,0  ; Move field, absolute to register
FFDB0A80h: 099F F102                MMTM   SP,B0_SADDR-B3_DPTCH,B7_DVDX,B14_TEMP ; If Register n is in the register list: Rn → -*Rd (repeat for n = 0 to 15)
FFDB0AA0h: 57DE                     CLR    B14_TEMP             ; Clear register
FFDB0AB0h: 0549                     SETF   9h,0,0               ; Set field parameters
FFDB0AC0h: 059E 00B6 C000           MOVE   B14_TEMP,@CONTROL+6,0 ; Move field, register to absolute
FFDB0AF0h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB0B00h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDB0B10h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDB0B20h: 059E 008B C000           MOVE   B14_TEMP,@DPYCTL+11,0 ; Move field, register to absolute
FFDB0B50h: 09F3 2000 0000           MOVI   00002000h,B3_DPTCH   ; Move immediate (32 bits)
FFDB0B80h: 4C71                     MOVE   B3_DPTCH,B1_SPTCH    ; Move register to register
FFDB0B90h: 4C92                     MOVE   B4_OFFSET,B2_DADDR   ; Move register to register
FFDB0BA0h: 07B0 09C0 FFEC           MOVE   @FFEC09C0h,B0_SADDR,1 ; Move field, absolute to register
FFDB0BD0h: 4412                     SUB    B0_SADDR,B2_DADDR    ; Subtract registers
FFDB0BE0h: 09F0 0000 003C           MOVI   SCREENBASE_0x003C_0000,B0_SADDR ; Move immediate (32 bits)
FFDB0C10h: 09F7 0004 00F0           MOVI   00F00004h,B7_DVDX    ; Move immediate (32 bits)
FFDB0C40h: 0F00                     PIXBLT L,L                  ; Pixel block transfer, linear to linear
FFDB0C50h: 058F 008B C000           MOVE   SP,@DPYCTL+11,0      ; Move field, register to absolute
FFDB0C80h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB0C90h: 57DE                     CLR    B14_TEMP             ; Clear register
FFDB0CA0h: 059E 0840 FFEC           MOVE   B14_TEMP,@FFEC0840h,0 ; Move field, register to absolute
FFDB0CD0h: 09BF 408F                MMFM   SP,B0_SADDR-B3_DPTCH,B7_DVDX,B14_TEMP ; If Register n is in the register list: *Rs+ → Rn (repeat for n = 0 to 15)
FFDB0CF0h: 059E 00B0 C000           MOVE   B14_TEMP,@CONTROL,0  ; Move field, register to absolute
FFDB0D20h: 09BF 5000                MMFM   SP,B12_INC2,B14_TEMP ; If Register n is in the register list: *Rs+ → Rn (repeat for n = 0 to 15)
FFDB0D40h: 0940                     RETI                        ; Return from interrupt

********************************************************************************
* CLEAR_SCREEN
********************************************************************************
CLEAR_SCREEN:
FFDB0D50h: 05A1 00B0 C000           MOVE   @CONTROL,A1,0        ; Move field, absolute to register
FFDB0D80h: 5739                     CLR    B9_COLOR1            ; Clear register
FFDB0D90h: 0549                     SETF   9h,0,0               ; Set field parameters
FFDB0DA0h: 0599 00B6 C000           MOVE   B9_COLOR1,@CONTROL+6,0 ; Move field, register to absolute
FFDB0DD0h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB0DE0h: 4C92                     MOVE   B4_OFFSET,B2_DADDR   ; Move register to register
FFDB0DF0h: 09F7 0280 01E0           MOVI   01E00280h,B7_DVDX    ; Move immediate (32 bits)
FFDB0E20h: 0FC0                     FILL   L                    ; Fill array with processed pixels, linear
FFDB0E30h: 0581 00B0 C000           MOVE   A1,@CONTROL,0        ; Move field, register to absolute
FFDB0E60h: 0960                     RETS                        ; Return from subroutine

********************************************************************************
* MSGIN_5
********************************************************************************
MSGIN_5:
FFDB0E70h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB0E80h: 09DE 0050                MOVI   50h,B14_TEMP         ; Move immediate (16 bits)
FFDB0EA0h: 059E 00F0 C000           MOVE   B14_TEMP,@HSTCTLL,0  ; Move field, register to absolute
FFDB0ED0h: 09C1 FFFF                MOVI   FFFFh,A1             ; Move immediate (16 bits)
FFDB0EF0h: 0581 00A0 C000           MOVE   A1,@DPYINT,0         ; Move field, register to absolute
FFDB0F20h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDB0F30h: 57DE                     CLR    B14_TEMP             ; Clear register
FFDB0F40h: 059E 00F3 C000           MOVE   B14_TEMP,@HSTCTLL+3,0 ; Move field, register to absolute
FFDB0F70h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB0F80h: 09AF 0006                MMFM   SP,A1,A2             ; If Register n is in the register list: *Rs+ → Rn (repeat for n = 0 to 15)
FFDB0FA0h: 97FE                     MOVE   *SP+,B14_TEMP,1      ; Move field. indirect (postincrement) to register
FFDB0FB0h: 0B0F 0020                ADDI   20h,SP               ; Add immediate (16 bits)
FFDB0FD0h: 09EF FDF0 FFDD           MOVI   STACK_TOP,SP         ; Move immediate (32 bits)
FFDB1000h: 0B9E 0000 0200           ANDI   FDFFFFFFh,B14_TEMP   ; AND immediate (32 bits)
FFDB1030h: 01BE                     PUTST  B14_TEMP             ; Copy register into status
FFDB1040h: 09DE 0050                MOVI   50h,B14_TEMP         ; Move immediate (16 bits)
FFDB1060h: 059E 00F0 C000           MOVE   B14_TEMP,@HSTCTLL,0  ; Move field, register to absolute
FFDB1090h: 0300                     NOP                         ; No operation
FFDB10A0h: 0300                     NOP                         ; No operation
FFDB10B0h: 0300                     NOP                         ; No operation
FFDB10C0h: 0300                     NOP                         ; No operation
FFDB10D0h: 0300                     NOP                         ; No operation
FFDB10E0h: 0300                     NOP                         ; No operation
FFDB10F0h: 0300                     NOP                         ; No operation
FFDB1100h: 0300                     NOP                         ; No operation
FFDB1110h: 0300                     NOP                         ; No operation
FFDB1120h: 0300                     NOP                         ; No operation
FFDB1130h: 0300                     NOP                         ; No operation
FFDB1140h: 09DE 0040                MOVI   40h,B14_TEMP         ; Move immediate (16 bits)
FFDB1160h: 059E 00F0 C000           MOVE   B14_TEMP,@HSTCTLL,0  ; Move field, register to absolute
FFDB1190h: 0300                     NOP                         ; No operation
FFDB11A0h: 0300                     NOP                         ; No operation
FFDB11B0h: 0300                     NOP                         ; No operation
FFDB11C0h: 0300                     NOP                         ; No operation
FFDB11D0h: 0300                     NOP                         ; No operation
FFDB11E0h: 0300                     NOP                         ; No operation
FFDB11F0h: 0300                     NOP                         ; No operation
FFDB1200h: 0300                     NOP                         ; No operation
FFDB1210h: 0300                     NOP                         ; No operation
FFDB1220h: 0300                     NOP                         ; No operation
FFDB1230h: 0300                     NOP                         ; No operation
FFDB1240h: C0DF                     JR     FFDB1040h            ; Jump relative conditional

********************************************************************************
* MSGIN_6
********************************************************************************
MSGIN_6:
FFDB1250h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB1260h: 05BE 00B0 C000           MOVE   @CONTROL,B14_TEMP,0  ; Move field, absolute to register
FFDB1290h: 099F F102                MMTM   SP,B0_SADDR-B3_DPTCH,B7_DVDX,B14_TEMP ; If Register n is in the register list: Rn → -*Rd (repeat for n = 0 to 15)
FFDB12B0h: 09DE 0060                MOVI   60h,B14_TEMP         ; Move immediate (16 bits)
FFDB12D0h: 059E 00F0 C000           MOVE   B14_TEMP,@HSTCTLL,0  ; Move field, register to absolute
FFDB1300h: 57DE                     CLR    B14_TEMP             ; Clear register
FFDB1310h: 0549                     SETF   9h,0,0               ; Set field parameters
FFDB1320h: 059E 00B6 C000           MOVE   B14_TEMP,@CONTROL+6,0 ; Move field, register to absolute
FFDB1350h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB1360h: 09F3 2000 0000           MOVI   00002000h,B3_DPTCH   ; Move immediate (32 bits)
FFDB1390h: 4C71                     MOVE   B3_DPTCH,B1_SPTCH    ; Move register to register
FFDB13A0h: 0300                     NOP                         ; No operation
FFDB13B0h: 0300                     NOP                         ; No operation
FFDB13C0h: 0300                     NOP                         ; No operation
FFDB13D0h: 0300                     NOP                         ; No operation
FFDB13E0h: 05BE 0CC0 FFEC           MOVE   @FFEC0CC0h,B14_TEMP,0 ; Move field, absolute to register
FFDB1410h: CAF8                     JREQ   FFDB13A0h            ; Jump relative conditional
FFDB1420h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB1430h: 05B0 0CA0 FFEC           MOVE   @FFEC0CA0h,B0_SADDR,0 ; Move field, absolute to register
FFDB1460h: 2590                     SLL    Ch,B0_SADDR          ; Shift left logical, constant
FFDB1470h: 05B2 0CB0 FFEC           MOVE   @FFEC0CB0h,B2_DADDR,0 ; Move field, absolute to register
FFDB14A0h: 2592                     SLL    Ch,B2_DADDR          ; Shift left logical, constant
FFDB14B0h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDB14C0h: 57DE                     CLR    B14_TEMP             ; Clear register
FFDB14D0h: 059E 008C C000           MOVE   B14_TEMP,@DPYCTL+12,0 ; Move field, register to absolute
FFDB1500h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDB1510h: 059E 008B C000           MOVE   B14_TEMP,@DPYCTL+11,0 ; Move field, register to absolute
FFDB1540h: 09DE 0064                MOVI   64h,B14_TEMP         ; Move immediate (16 bits)
FFDB1560h: 0300                     NOP                         ; No operation
FFDB1570h: 0300                     NOP                         ; No operation
FFDB1580h: 3C7E                     DSJS   B14_TEMP,FFDB1560h   ; Decrement register and skip jump short
FFDB1590h: 09F7 0004 0001           MOVI   00010004h,B7_DVDX    ; Move immediate (32 bits)
FFDB15C0h: 0F00                     PIXBLT L,L                  ; Pixel block transfer, linear to linear
FFDB15D0h: 57DE                     CLR    B14_TEMP             ; Clear register
FFDB15E0h: 059E 008B C000           MOVE   B14_TEMP,@DPYCTL+11,0 ; Move field, register to absolute
FFDB1610h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDB1620h: 059E 008C C000           MOVE   B14_TEMP,@DPYCTL+12,0 ; Move field, register to absolute
FFDB1650h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB1660h: 57DE                     CLR    B14_TEMP             ; Clear register
FFDB1670h: 059E 0CC0 FFEC           MOVE   B14_TEMP,@FFEC0CC0h,0 ; Move field, register to absolute
FFDB16A0h: C0CF                     JR     FFDB13A0h            ; Jump relative conditional

********************************************************************************
* ILLOP_VECTOR
********************************************************************************
ILLOP_VECTOR:
FFDB16B0h: 97E0                     MOVE   *SP+,A0,1            ; Move field. indirect (postincrement) to register
FFDB16C0h: 97E1                     MOVE   *SP+,A1,1            ; Move field. indirect (postincrement) to register
FFDB16D0h: C0FF                     JR     FFDB16D0h            ; Jump relative conditional

********************************************************************************
* INT1_VECTOR
********************************************************************************
INT1_VECTOR:
FFDB16E0h: C0FF                     JR     INT1_VECTOR          ; Jump relative conditional

********************************************************************************
* INT2_VECTOR
********************************************************************************
INT2_VECTOR:
FFDB16F0h: C0FF                     JR     INT2_VECTOR          ; Jump relative conditional

********************************************************************************
* COMMAND_26_GRAPHYY_0x1a
********************************************************************************
COMMAND_26_GRAPHYY_0x1a:
FFDB1700h: 9504                     MOVE   *A8+,A4,0            ; Move field. indirect (postincrement) to register
FFDB1710h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDB1720h: 9702                     MOVE   *A8+,A2,1            ; Move field. indirect (postincrement) to register
FFDB1730h: 9703                     MOVE   *A8+,A3,1            ; Move field. indirect (postincrement) to register
FFDB1740h: 9506                     MOVE   *A8+,A6,0            ; Move field. indirect (postincrement) to register
FFDB1750h: 4C84                     MOVE   A4,A4                ; Move register to register
FFDB1760h: CA00 F6F2                JREQ   CMD_LOOP             ; Jump relative conditional
FFDB1780h: 098F 0084                MMTM   SP,A8,A13            ; If Register n is in the register list: Rn → -*Rd (repeat for n = 0 to 15)
FFDB17A0h: 099F 0080                MMTM   SP,B8_COLOR0         ; If Register n is in the register list: Rn → -*Rd (repeat for n = 0 to 15)
FFDB17C0h: 4C8D                     MOVE   A4,A13               ; Move register to register
FFDB17D0h: 4C68                     MOVE   A3,A8                ; Move register to register
FFDB17E0h: 4F3C                     MOVE   B9_COLOR1,A12        ; Move register to register
FFDB17F0h: 4F1E                     MOVE   B8_COLOR0,A14        ; Move register to register
FFDB1800h: 1829                     MOVK   1h,A9                ; Move constant (5 bits)
FFDB1810h: 25E9                     SLL    Fh,A9                ; Shift left logical, constant
FFDB1820h: 4CC4                     MOVE   A6,A4                ; Move register to register
FFDB1830h: 2606                     SLL    10h,A6               ; Shift left logical, constant
FFDB1840h: 4126                     ADD    A9,A6                ; Add registers
FFDB1850h: 4E40                     MOVE   A2,B0_SADDR          ; Move register to register
FFDB1860h: 0390                     ABS    B0_SADDR             ; Store absolute value
FFDB1870h: 09FB 0000 FFDD           MOVI   FFDD0000h,B11_INC1   ; Move immediate (32 bits)
FFDB18A0h: 4E27                     MOVE   A1,B7_DVDX           ; Move register to register
FFDB18B0h: 2717                     SLL    18h,B7_DVDX          ; Shift left logical, constant
FFDB18C0h: 2C77                     SRL    1Dh,B7_DVDX          ; Shift right logical, constant
FFDB18D0h: 2437                     SLL    1h,B7_DVDX           ; Shift left logical, constant
FFDB18E0h: CB01                     JRNE   FFDB1900h            ; Jump relative conditional
FFDB18F0h: 1A17                     MOVK   10h,B7_DVDX          ; Move constant (5 bits)
FFDB1900h: 4C27                     MOVE   A1,A7                ; Move register to register
FFDB1910h: 2587                     SLL    Ch,A7                ; Shift left logical, constant
FFDB1920h: 2C87                     SRL    1Ch,A7               ; Shift right logical, constant
FFDB1930h: CA07                     JREQ   FFDB19B0h            ; Jump relative conditional
FFDB1940h: 1427                     DEC    A7                   ; Decrement register
FFDB1950h: CA05                     JREQ   FFDB19B0h            ; Jump relative conditional
FFDB1960h: 2487                     SLL    4h,A7                ; Shift left logical, constant
FFDB1970h: 09FA 44D0 FFDB           MOVI   FFDB44D0h,B10_COUNT  ; Move immediate (32 bits)
FFDB19A0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB19B0h: 09F2 44E0 FFDB           MOVI   FFDB44E0h,B2_DADDR   ; Move immediate (32 bits)
FFDB19E0h: 1FA1                     BTST   2h,A1                ; Set status on value of: bit K in Rd
FFDB19F0h: CA15                     JREQ   FFDB1B50h            ; Jump relative conditional
FFDB1A00h: 05A3 09A0 FFEC           MOVE   @SCALE_FACTOR_DY_B,A3,0 ; Move field, absolute to register
FFDB1A30h: 2603                     SLL    10h,A3               ; Shift left logical, constant
FFDB1A40h: 4069                     ADD    A3,A9                ; Add registers
FFDB1A50h: 07AA 0960 FFEC           MOVE   @SCALE_FACTOR_DY_A,A10,1 ; Move field, absolute to register
FFDB1A80h: 4E13                     MOVE   B0_SADDR,A3          ; Move register to register
FFDB1A90h: 2603                     SLL    10h,A3               ; Shift left logical, constant
FFDB1AA0h: CA04                     JREQ   FFDB1AF0h            ; Jump relative conditional
FFDB1AB0h: 09FA 3220 FFDB           MOVI   FFDB3220h,B10_COUNT  ; Move immediate (32 bits)
FFDB1AE0h: C01A                     JR     FFDB1C90h            ; Jump relative conditional

FFDB1AF0h: 2A02                     SRA    10h,A2               ; Shift right arithmetic, constant
FFDB1B00h: 2A06                     SRA    10h,A6               ; Shift right arithmetic, constant
FFDB1B10h: 09FA 32B0 FFDB           MOVI   FFDB32B0h,B10_COUNT  ; Move immediate (32 bits)
FFDB1B40h: C014                     JR     FFDB1C90h            ; Jump relative conditional

FFDB1B50h: 182A                     MOVK   1h,A10               ; Move constant (5 bits)
FFDB1B60h: 260A                     SLL    10h,A10              ; Shift left logical, constant
FFDB1B70h: 4CFA                     MOVE   B7_DVDX,B10_COUNT    ; Move register to register
FFDB1B80h: 2FFA                     SRL    1h,B10_COUNT         ; Shift right logical, constant
FFDB1B90h: 143A                     DEC    B10_COUNT            ; Decrement register
FFDB1BA0h: 4E13                     MOVE   B0_SADDR,A3          ; Move register to register
FFDB1BB0h: 2603                     SLL    10h,A3               ; Shift left logical, constant
FFDB1BC0h: CB03                     JRNE   FFDB1C00h            ; Jump relative conditional
FFDB1BD0h: 121A                     ADDK   10h,B10_COUNT        ; Add constant (5 bits)
FFDB1BE0h: 2A02                     SRA    10h,A2               ; Shift right arithmetic, constant
FFDB1BF0h: 2A06                     SRA    10h,A6               ; Shift right arithmetic, constant
FFDB1C00h: 4C23                     MOVE   A1,A3                ; Move register to register
FFDB1C10h: 27A3                     SLL    1Dh,A3               ; Shift left logical, constant
FFDB1C20h: CB01                     JRNE   FFDB1C40h            ; Jump relative conditional
FFDB1C30h: 111A                     ADDK   8h,B10_COUNT         ; Add constant (5 bits)
FFDB1C40h: 24BA                     SLL    5h,B10_COUNT         ; Shift left logical, constant
FFDB1C50h: 0B3A 29A0 FFDB           ADDI   FFDB29A0h,B10_COUNT  ; Add immediate (32 bits)
FFDB1C80h: 875A                     MOVE   *B10_COUNT,B10_COUNT,1 ; Move field. indirect to register
FFDB1C90h: 955E                     MOVE   *B10_COUNT+,B14_TEMP,0 ; Move field. indirect (postincrement) to register
FFDB1CA0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB1CB0h: 3C5E                     DSJS   B14_TEMP,FFDB1CA0h   ; Decrement register and skip jump short
FFDB1CC0h: 1F81                     BTST   3h,A1                ; Set status on value of: bit K in Rd
FFDB1CD0h: CB0B                     JRNE   FFDB1D90h            ; Jump relative conditional
FFDB1CE0h: D717                     EXGF   B7_DVDX,1            ; Exchange field size
FFDB1CF0h: 9503                     MOVE   *A8+,A3,0            ; Move field. indirect (postincrement) to register
FFDB1D00h: 4D45                     MOVE   A10,A5               ; Move register to register
FFDB1D10h: 5C65                     MPYS   A3,A5                ; Rd even: Rs*Rd → Rd:Rd+1; Rd odd: Rs*Rd → Rd (signed multiply)
FFDB1D20h: 4125                     ADD    A9,A5                ; Add registers
FFDB1D30h: EEA4                     MOVY   A5,A4                ; Move Y half of register
FFDB1D40h: D717                     EXGF   B7_DVDX,1            ; Exchange field size
FFDB1D50h: 142D                     DEC    A13                  ; Decrement register
FFDB1D60h: CA23                     JREQ   FFDB1FA0h            ; Jump relative conditional
FFDB1D70h: 40E8                     ADD    A7,A8                ; Add registers
FFDB1D80h: C001                     JR     FFDB1DA0h            ; Jump relative conditional

FFDB1D90h: 4446                     SUB    A2,A6                ; Subtract registers
FFDB1DA0h: 575A                     CLR    B10_COUNT            ; Clear register
FFDB1DB0h: 1F81                     BTST   3h,A1                ; Set status on value of: bit K in Rd
FFDB1DC0h: CA01                     JREQ   FFDB1DE0h            ; Jump relative conditional
FFDB1DD0h: 111A                     ADDK   8h,B10_COUNT         ; Add constant (5 bits)
FFDB1DE0h: 0D10 FFFF FFFE           SUBI   10000h,B0_SADDR      ; Subtract immediate (32 bits)
FFDB1E10h: C701                     JRGT   FFDB1E30h            ; Jump relative conditional
FFDB1E20h: 109A                     ADDK   4h,B10_COUNT         ; Add constant (5 bits)
FFDB1E30h: 05A3 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A3,0 ; Move field, absolute to register
FFDB1E60h: CA01                     JREQ   FFDB1E80h            ; Jump relative conditional
FFDB1E70h: 103A                     INC    B10_COUNT            ; Increment register
FFDB1E80h: 24BA                     SLL    5h,B10_COUNT         ; Shift left logical, constant
FFDB1E90h: 0B3A 2FA0 FFDB           ADDI   FFDB2FA0h,B10_COUNT  ; Add immediate (32 bits)
FFDB1EC0h: 875A                     MOVE   *B10_COUNT,B10_COUNT,1 ; Move field. indirect to register
FFDB1ED0h: 093A                     CALL   B10_COUNT            ; Call subroutine indirect
FFDB1EE0h: 09FB 010E C000           MOVI   HSTCTLH+14,B11_INC1  ; Move immediate (32 bits)
FFDB1F10h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDB1F20h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDB1F30h: 81DB                     MOVE   B14_TEMP,*B11_INC1,0 ; Move field. register to indirect
FFDB1F40h: 81FB                     MOVE   SP,*B11_INC1,0       ; Move field. register to indirect
FFDB1F50h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB1F60h: D717                     EXGF   B7_DVDX,1            ; Exchange field size
FFDB1F70h: 0D5F 0000 FFDD           CALLA  FFDD0000h            ; Call subroutine address
FFDB1FA0h: 0740                     SETF   20h,0,1              ; Set field parameters
FFDB1FB0h: 09E3 00B6 C000           MOVI   CONTROL+6,A3         ; Move immediate (32 bits)
FFDB1FE0h: 0542                     SETF   2h,0,0               ; Set field parameters
FFDB1FF0h: 1861                     MOVK   3h,A1                ; Move constant (5 bits)
FFDB2000h: 8023                     MOVE   A1,*A3,0             ; Move field. register to indirect
FFDB2010h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB2020h: 09BF 0100                MMFM   SP,B8_COLOR0         ; If Register n is in the register list: *Rs+ → Rn (repeat for n = 0 to 15)
FFDB2040h: 09AF 2100                MMFM   SP,A8,A13            ; If Register n is in the register list: *Rs+ → Rn (repeat for n = 0 to 15)
FFDB2060h: 4F89                     MOVE   A12,B9_COLOR1        ; Move register to register
FFDB2070h: C000 F661                JR     CMD_LOOP             ; Jump relative conditional

********************************************************************************
* COMMAND_28_GRAPHYY_0x1c
********************************************************************************
COMMAND_28_GRAPHYY_0x1c:
FFDB2090h: 9504                     MOVE   *A8+,A4,0            ; Move field. indirect (postincrement) to register
FFDB20A0h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDB20B0h: 9703                     MOVE   *A8+,A3,1            ; Move field. indirect (postincrement) to register
FFDB20C0h: 4C84                     MOVE   A4,A4                ; Move register to register
FFDB20D0h: CA00 F65B                JREQ   CMD_LOOP             ; Jump relative conditional
FFDB20F0h: 098F 0084                MMTM   SP,A8,A13            ; If Register n is in the register list: Rn → -*Rd (repeat for n = 0 to 15)
FFDB2110h: 099F 0080                MMTM   SP,B8_COLOR0         ; If Register n is in the register list: Rn → -*Rd (repeat for n = 0 to 15)
FFDB2130h: 4C8D                     MOVE   A4,A13               ; Move register to register
FFDB2140h: 4C68                     MOVE   A3,A8                ; Move register to register
FFDB2150h: 4F3C                     MOVE   B9_COLOR1,A12        ; Move register to register
FFDB2160h: 4F1E                     MOVE   B8_COLOR0,A14        ; Move register to register
FFDB2170h: 1829                     MOVK   1h,A9                ; Move constant (5 bits)
FFDB2180h: 25E9                     SLL    Fh,A9                ; Shift left logical, constant
FFDB2190h: 4D22                     MOVE   A9,A2                ; Move register to register
FFDB21A0h: 09FB 0000 FFDD           MOVI   FFDD0000h,B11_INC1   ; Move immediate (32 bits)
FFDB21D0h: 4E27                     MOVE   A1,B7_DVDX           ; Move register to register
FFDB21E0h: 2717                     SLL    18h,B7_DVDX          ; Shift left logical, constant
FFDB21F0h: 2C77                     SRL    1Dh,B7_DVDX          ; Shift right logical, constant
FFDB2200h: 2437                     SLL    1h,B7_DVDX           ; Shift left logical, constant
FFDB2210h: CB01                     JRNE   FFDB2230h            ; Jump relative conditional
FFDB2220h: 1A17                     MOVK   10h,B7_DVDX          ; Move constant (5 bits)
FFDB2230h: 4C27                     MOVE   A1,A7                ; Move register to register
FFDB2240h: 2587                     SLL    Ch,A7                ; Shift left logical, constant
FFDB2250h: 2C87                     SRL    1Ch,A7               ; Shift right logical, constant
FFDB2260h: CA07                     JREQ   FFDB22E0h            ; Jump relative conditional
FFDB2270h: 1427                     DEC    A7                   ; Decrement register
FFDB2280h: CA05                     JREQ   FFDB22E0h            ; Jump relative conditional
FFDB2290h: 24A7                     SLL    5h,A7                ; Shift left logical, constant
FFDB22A0h: 09FA 44D0 FFDB           MOVI   FFDB44D0h,B10_COUNT  ; Move immediate (32 bits)
FFDB22D0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB22E0h: 1FA1                     BTST   2h,A1                ; Set status on value of: bit K in Rd
FFDB22F0h: CA17                     JREQ   FFDB2470h            ; Jump relative conditional
FFDB2300h: 09F2 44E0 FFDB           MOVI   FFDB44E0h,B2_DADDR   ; Move immediate (32 bits)
FFDB2330h: 05A3 09A0 FFEC           MOVE   @SCALE_FACTOR_DY_B,A3,0 ; Move field, absolute to register
FFDB2360h: 2603                     SLL    10h,A3               ; Shift left logical, constant
FFDB2370h: 4069                     ADD    A3,A9                ; Add registers
FFDB2380h: 07AA 0960 FFEC           MOVE   @SCALE_FACTOR_DY_A,A10,1 ; Move field, absolute to register
FFDB23B0h: 05A3 0980 FFEC           MOVE   @SCALE_FACTOR_DX_B,A3,0 ; Move field, absolute to register
FFDB23E0h: 2603                     SLL    10h,A3               ; Shift left logical, constant
FFDB23F0h: 4062                     ADD    A3,A2                ; Add registers
FFDB2400h: 07A6 0940 FFEC           MOVE   @SCALE_FACTOR_DX_A,A6,1 ; Move field, absolute to register
FFDB2430h: 09FA 3FE0 FFDB           MOVI   FFDB3FE0h,B10_COUNT  ; Move immediate (32 bits)
FFDB2460h: C012                     JR     FFDB2590h            ; Jump relative conditional

FFDB2470h: 182A                     MOVK   1h,A10               ; Move constant (5 bits)
FFDB2480h: 260A                     SLL    10h,A10              ; Shift left logical, constant
FFDB2490h: 4D46                     MOVE   A10,A6               ; Move register to register
FFDB24A0h: 09F2 45E0 FFDB           MOVI   FFDB45E0h,B2_DADDR   ; Move immediate (32 bits)
FFDB24D0h: 4CFA                     MOVE   B7_DVDX,B10_COUNT    ; Move register to register
FFDB24E0h: 2FFA                     SRL    1h,B10_COUNT         ; Shift right logical, constant
FFDB24F0h: 143A                     DEC    B10_COUNT            ; Decrement register
FFDB2500h: 4C23                     MOVE   A1,A3                ; Move register to register
FFDB2510h: 27A3                     SLL    1Dh,A3               ; Shift left logical, constant
FFDB2520h: CB01                     JRNE   FFDB2540h            ; Jump relative conditional
FFDB2530h: 111A                     ADDK   8h,B10_COUNT         ; Add constant (5 bits)
FFDB2540h: 24BA                     SLL    5h,B10_COUNT         ; Shift left logical, constant
FFDB2550h: 0B3A 2DA0 FFDB           ADDI   FFDB2DA0h,B10_COUNT  ; Add immediate (32 bits)
FFDB2580h: 875A                     MOVE   *B10_COUNT,B10_COUNT,1 ; Move field. indirect to register
FFDB2590h: 955E                     MOVE   *B10_COUNT+,B14_TEMP,0 ; Move field. indirect (postincrement) to register
FFDB25A0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB25B0h: 3C5E                     DSJS   B14_TEMP,FFDB25A0h   ; Decrement register and skip jump short
FFDB25C0h: 1F81                     BTST   3h,A1                ; Set status on value of: bit K in Rd
FFDB25D0h: CB12                     JRNE   FFDB2700h            ; Jump relative conditional
FFDB25E0h: D717                     EXGF   B7_DVDX,1            ; Exchange field size
FFDB25F0h: 0540                     SETF   20h,0,0              ; Set field parameters
FFDB2600h: 9505                     MOVE   *A8+,A5,0            ; Move field. indirect (postincrement) to register
FFDB2610h: 4CC3                     MOVE   A6,A3                ; Move register to register
FFDB2620h: 5CA3                     MPYS   A5,A3                ; Rd even: Rs*Rd → Rd:Rd+1; Rd odd: Rs*Rd → Rd (signed multiply)
FFDB2630h: 4043                     ADD    A2,A3                ; Add registers
FFDB2640h: 2E03                     SRL    10h,A3               ; Shift right logical, constant
FFDB2650h: 4C64                     MOVE   A3,A4                ; Move register to register
FFDB2660h: 2E05                     SRL    10h,A5               ; Shift right logical, constant
FFDB2670h: 4D43                     MOVE   A10,A3               ; Move register to register
FFDB2680h: 5CA3                     MPYS   A5,A3                ; Rd even: Rs*Rd → Rd:Rd+1; Rd odd: Rs*Rd → Rd (signed multiply)
FFDB2690h: 4123                     ADD    A9,A3                ; Add registers
FFDB26A0h: EE64                     MOVY   A3,A4                ; Move Y half of register
FFDB26B0h: D717                     EXGF   B7_DVDX,1            ; Exchange field size
FFDB26C0h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB26D0h: 142D                     DEC    A13                  ; Decrement register
FFDB26E0h: CA1C                     JREQ   FFDB28B0h            ; Jump relative conditional
FFDB26F0h: 40E8                     ADD    A7,A8                ; Add registers
FFDB2700h: 575A                     CLR    B10_COUNT            ; Clear register
FFDB2710h: 1F81                     BTST   3h,A1                ; Set status on value of: bit K in Rd
FFDB2720h: CA01                     JREQ   FFDB2740h            ; Jump relative conditional
FFDB2730h: 105A                     ADDK   2h,B10_COUNT         ; Add constant (5 bits)
FFDB2740h: 05A3 0920 FFEC           MOVE   @PIXEL_STRETCH_ENABLED_FLAG,A3,0 ; Move field, absolute to register
FFDB2770h: CA01                     JREQ   FFDB2790h            ; Jump relative conditional
FFDB2780h: 103A                     INC    B10_COUNT            ; Increment register
FFDB2790h: 24BA                     SLL    5h,B10_COUNT         ; Shift left logical, constant
FFDB27A0h: 0B3A 31A0 FFDB           ADDI   FFDB31A0h,B10_COUNT  ; Add immediate (32 bits)
FFDB27D0h: 875A                     MOVE   *B10_COUNT,B10_COUNT,1 ; Move field. indirect to register
FFDB27E0h: 093A                     CALL   B10_COUNT            ; Call subroutine indirect
FFDB27F0h: 09FB 010E C000           MOVI   HSTCTLH+14,B11_INC1  ; Move immediate (32 bits)
FFDB2820h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDB2830h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDB2840h: 81DB                     MOVE   B14_TEMP,*B11_INC1,0 ; Move field. register to indirect
FFDB2850h: 81FB                     MOVE   SP,*B11_INC1,0       ; Move field. register to indirect
FFDB2860h: 0540                     SETF   20h,0,0              ; Set field parameters
FFDB2870h: D717                     EXGF   B7_DVDX,1            ; Exchange field size
FFDB2880h: 0D5F 0000 FFDD           CALLA  FFDD0000h            ; Call subroutine address
FFDB28B0h: 0740                     SETF   20h,0,1              ; Set field parameters
FFDB28C0h: 09E3 00B6 C000           MOVI   CONTROL+6,A3         ; Move immediate (32 bits)
FFDB28F0h: 0542                     SETF   2h,0,0               ; Set field parameters
FFDB2900h: 1861                     MOVK   3h,A1                ; Move constant (5 bits)
FFDB2910h: 8023                     MOVE   A1,*A3,0             ; Move field. register to indirect
FFDB2920h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB2930h: 09BF 0100                MMFM   SP,B8_COLOR0         ; If Register n is in the register list: *Rs+ → Rn (repeat for n = 0 to 15)
FFDB2950h: 09AF 2100                MMFM   SP,A8,A13            ; If Register n is in the register list: *Rs+ → Rn (repeat for n = 0 to 15)
FFDB2970h: 4F89                     MOVE   A12,B9_COLOR1        ; Move register to register
FFDB2980h: C000 F5D0                JR     CMD_LOOP             ; Jump relative conditional

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

FFDB44D0h: 40E8                     ADD    A7,A8                ; Add registers
FFDB44E0h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDB44F0h: 1FC1                     BTST   1h,A1                ; Set status on value of: bit K in Rd
FFDB4500h: 1FA1                     BTST   2h,A1                ; Set status on value of: bit K in Rd
FFDB4510h: 1F81                     BTST   3h,A1                ; Set status on value of: bit K in Rd
FFDB4520h: 1F61                     BTST   4h,A1                ; Set status on value of: bit K in Rd
FFDB4530h: 1F41                     BTST   5h,A1                ; Set status on value of: bit K in Rd
FFDB4540h: 1F21                     BTST   6h,A1                ; Set status on value of: bit K in Rd
FFDB4550h: 1F01                     BTST   7h,A1                ; Set status on value of: bit K in Rd
FFDB4560h: 1EE1                     BTST   8h,A1                ; Set status on value of: bit K in Rd
FFDB4570h: 1EC1                     BTST   9h,A1                ; Set status on value of: bit K in Rd
FFDB4580h: 1EA1                     BTST   Ah,A1                ; Set status on value of: bit K in Rd
FFDB4590h: 1E81                     BTST   Bh,A1                ; Set status on value of: bit K in Rd
FFDB45A0h: 1E61                     BTST   Ch,A1                ; Set status on value of: bit K in Rd
FFDB45B0h: 1E41                     BTST   Dh,A1                ; Set status on value of: bit K in Rd
FFDB45C0h: 1E21                     BTST   Eh,A1                ; Set status on value of: bit K in Rd
FFDB45D0h: 1E01                     BTST   Fh,A1                ; Set status on value of: bit K in Rd
FFDB45E0h: 1DE1                     BTST   10h,A1               ; Set status on value of: bit K in Rd
FFDB45F0h: 1DC1                     BTST   11h,A1               ; Set status on value of: bit K in Rd
FFDB4600h: 1DA1                     BTST   12h,A1               ; Set status on value of: bit K in Rd
FFDB4610h: 1D81                     BTST   13h,A1               ; Set status on value of: bit K in Rd
FFDB4620h: 1D61                     BTST   14h,A1               ; Set status on value of: bit K in Rd
FFDB4630h: 1D41                     BTST   15h,A1               ; Set status on value of: bit K in Rd
FFDB4640h: 1D21                     BTST   16h,A1               ; Set status on value of: bit K in Rd
FFDB4650h: 1D01                     BTST   17h,A1               ; Set status on value of: bit K in Rd
FFDB4660h: 1CE1                     BTST   18h,A1               ; Set status on value of: bit K in Rd
FFDB4670h: 1CC1                     BTST   19h,A1               ; Set status on value of: bit K in Rd
FFDB4680h: 1CA1                     BTST   1Ah,A1               ; Set status on value of: bit K in Rd
FFDB4690h: 1C81                     BTST   1Bh,A1               ; Set status on value of: bit K in Rd
FFDB46A0h: 1C61                     BTST   1Ch,A1               ; Set status on value of: bit K in Rd
FFDB46B0h: 1C41                     BTST   1Dh,A1               ; Set status on value of: bit K in Rd
FFDB46C0h: 1C21                     BTST   1Eh,A1               ; Set status on value of: bit K in Rd
FFDB46D0h: 1C01                     BTST   1Fh,A1               ; Set status on value of: bit K in Rd
FFDB46E0h: 1FC1                     BTST   1h,A1                ; Set status on value of: bit K in Rd
FFDB46F0h: CA0C                     JREQ   FFDB47C0h            ; Jump relative conditional
FFDB4700h: 09FA 4C80 FFDB           MOVI   FFDB4C80h,B10_COUNT  ; Move immediate (32 bits)
FFDB4730h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB4740h: 4E2E                     MOVE   A1,B14_TEMP          ; Move register to register
FFDB4750h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDB4760h: 2C9E                     SRL    1Ch,B14_TEMP         ; Shift right logical, constant
FFDB4770h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDB4780h: 405E                     ADD    B2_DADDR,B14_TEMP    ; Add registers
FFDB4790h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB47A0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB47B0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB47C0h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDB47D0h: CA0A                     JREQ   FFDB4880h            ; Jump relative conditional
FFDB47E0h: 09FA 4CB0 FFDB           MOVI   FFDB4CB0h,B10_COUNT  ; Move immediate (32 bits)
FFDB4810h: 4E2E                     MOVE   A1,B14_TEMP          ; Move register to register
FFDB4820h: 269E                     SLL    14h,B14_TEMP         ; Shift left logical, constant
FFDB4830h: 2C9E                     SRL    1Ch,B14_TEMP         ; Shift right logical, constant
FFDB4840h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDB4850h: 405E                     ADD    B2_DADDR,B14_TEMP    ; Add registers
FFDB4860h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB4870h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB4880h: 09FA 4CC0 FFDB           MOVI   FFDB4CC0h,B10_COUNT  ; Move immediate (32 bits)
FFDB48B0h: 195E                     MOVK   Ah,B14_TEMP          ; Move constant (5 bits)
FFDB48C0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB48D0h: 3C5E                     DSJS   B14_TEMP,FFDB48C0h   ; Decrement register and skip jump short
FFDB48E0h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP   ; Move immediate (32 bits)
FFDB4910h: 457E                     SUB    B11_INC1,B14_TEMP    ; Subtract registers
FFDB4920h: 161E                     SUBK   10h,B14_TEMP         ; Subtract constant (5 bits)
FFDB4930h: 2F9E                     SRL    4h,B14_TEMP          ; Shift right logical, constant
FFDB4940h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0 ; Move field. register to indirect (postincrement)
FFDB4950h: 121A                     ADDK   10h,B10_COUNT        ; Add constant (5 bits)
FFDB4960h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB4970h: 4F70                     MOVE   B11_INC1,A0          ; Move register to register
FFDB4980h: 0B00 0080                ADDI   80h,A0               ; Add immediate (16 bits)
FFDB49A0h: 4D78                     MOVE   B11_INC1,B8_COLOR0   ; Move register to register
FFDB49B0h: 0B18 03E0                ADDI   3E0h,B8_COLOR0       ; Add immediate (16 bits)
FFDB49D0h: 09DE 009F                MOVI   9Fh,B14_TEMP         ; Move immediate (16 bits)
FFDB49F0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB4A00h: 3C5E                     DSJS   B14_TEMP,FFDB49F0h   ; Decrement register and skip jump short
FFDB4A10h: 09FB 00B6 C000           MOVI   CONTROL+6,B11_INC1   ; Move immediate (32 bits)
FFDB4A40h: 0542                     SETF   2h,0,0               ; Set field parameters
FFDB4A50h: 185A                     MOVK   2h,B10_COUNT         ; Move constant (5 bits)
FFDB4A60h: 815B                     MOVE   B10_COUNT,*B11_INC1,0 ; Move field. register to indirect
FFDB4A70h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB4A80h: 09F1 0001 0001           MOVI   00010001h,B1_SPTCH   ; Move immediate (32 bits)
FFDB4AB0h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDB4AC0h: E65E                     CPW    B2_DADDR,B14_TEMP    ; Compare point to window
FFDB4AD0h: CD05                     JRNV   FFDB4B30h            ; Jump relative conditional
FFDB4AE0h: 0B3E 5160 FFDB           ADDI   FFDB5160h,B14_TEMP   ; Add immediate (32 bits)
FFDB4B10h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB4B20h: 4E5B                     MOVE   B2_DADDR,A11         ; Move register to register
FFDB4B30h: 0960                     RETS                        ; Return from subroutine

FFDB4B40h: 0000 0000 0000 0000 0000 .bss     20*2*8

FFDB4C80h: 4F89                     MOVE   A12,B9_COLOR1        ; Move register to register
FFDB4C90h: CA01                     JREQ   FFDB4CB0h            ; Jump relative conditional
FFDB4CA0h: 4FC9                     MOVE   A14,B9_COLOR1        ; Move register to register
FFDB4CB0h: CB0C                     JRNE   FFDB4D80h            ; Jump relative conditional
FFDB4CC0h: E6A1                     CPW    A5,A1                ; Compare point to window
FFDB4CD0h: CC2E                     JRV    FFDB4FC0h            ; Jump relative conditional
FFDB4CE0h: E683                     CPW    A4,A3                ; Compare point to window
FFDB4CF0h: CC45                     JRV    FFDB5150h            ; Jump relative conditional
FFDB4D00h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDB4D10h: 4EA0                     MOVE   A5,B0_SADDR          ; Move register to register
FFDB4D20h: 4C01                     MOVE   A0,A1                ; Move register to register
FFDB4D30h: 0121                     EXGPC  A1                   ; Exchange program counter with register
FFDB4D40h: 4CA4                     MOVE   A5,A4                ; Move register to register
FFDB4D50h: 0D8D FFDD                DSJ    A13,FFDB4B40h        ; Decrement register and skip jump
FFDB4D70h: 0960                     RETS                        ; Return from subroutine

FFDB4D80h: E6A1                     CPW    A5,A1                ; Compare point to window
FFDB4D90h: CDFA                     JRNV   FFDB4D40h            ; Jump relative conditional
FFDB4DA0h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDB4DB0h: E65E                     CPW    B2_DADDR,B14_TEMP    ; Compare point to window
FFDB4DC0h: 411E                     ADD    B8_COLOR0,B14_TEMP   ; Add registers
FFDB4DD0h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB4DE0h: 4E5B                     MOVE   B2_DADDR,A11         ; Move register to register
FFDB4DF0h: C0F4                     JR     FFDB4D40h            ; Jump relative conditional

FFDB4E00h: E250                     SUBXY  B2_DADDR,B0_SADDR    ; Subtract registers in XY mode
FFDB4E10h: 577B                     CLR    B11_INC1             ; Clear register
FFDB4E20h: 03FB                     NOT    B11_INC1             ; Complement register
FFDB4E30h: 183A                     MOVK   1h,B10_COUNT         ; Move constant (5 bits)
FFDB4E40h: 56F7                     CLR    B7_DVDX              ; Clear register
FFDB4E50h: E217                     SUBXY  B0_SADDR,B7_DVDX     ; Subtract registers in XY mode
FFDB4E60h: C902                     JRNC   FFDB4E90h            ; Jump relative conditional
FFDB4E70h: EE17                     MOVY   B0_SADDR,B7_DVDX     ; Move Y half of register
FFDB4E80h: 2E3B                     SRL    Fh,B11_INC1          ; Shift right logical, constant
FFDB4E90h: CD02                     JRNV   FFDB4EC0h            ; Jump relative conditional
FFDB4EA0h: EC17                     MOVX   B0_SADDR,B7_DVDX     ; Move X half of register
FFDB4EB0h: ED5B                     MOVX   B10_COUNT,B11_INC1   ; Move X half of register
FFDB4EC0h: 579C                     CLR    B12_INC2             ; Clear register
FFDB4ED0h: 4CF0                     MOVE   B7_DVDX,B0_SADDR     ; Move register to register
FFDB4EE0h: 2E10                     SRL    10h,B0_SADDR         ; Shift right logical, constant
FFDB4EF0h: E417                     CMPXY  B0_SADDR,B7_DVDX     ; Compare X and V halves of registers
FFDB4F00h: CC02                     JRV    FFDB4F30h            ; Jump relative conditional
FFDB4F10h: ED7C                     MOVX   B11_INC1,B12_INC2    ; Move X half of register
FFDB4F20h: C003                     JR     FFDB4F60h            ; Jump relative conditional

FFDB4F30h: ECF0                     MOVX   B7_DVDX,B0_SADDR     ; Move X half of register
FFDB4F40h: 3217                     RL     10h,B7_DVDX          ; Rotate left, constant
FFDB4F50h: EF7C                     MOVY   B11_INC1,B12_INC2    ; Move Y half of register
FFDB4F60h: 4010                     ADD    B0_SADDR,B0_SADDR    ; Add registers
FFDB4F70h: ECFA                     MOVX   B7_DVDX,B10_COUNT    ; Move X half of register
FFDB4F80h: 4550                     SUB    B10_COUNT,B0_SADDR   ; Subtract registers
FFDB4F90h: 103A                     INC    B10_COUNT            ; Increment register
FFDB4FA0h: DF1A                     LINE   0                    ; Perform the inner loop of Bresenham's line-drawing algorithm
FFDB4FB0h: 0121                     EXGPC  A1                   ; Exchange program counter with register
FFDB4FC0h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDB4FD0h: E65E                     CPW    B2_DADDR,B14_TEMP    ; Compare point to window
FFDB4FE0h: 411E                     ADD    B8_COLOR0,B14_TEMP   ; Add registers
FFDB4FF0h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB5000h: 4F67                     MOVE   A11,B7_DVDX          ; Move register to register
FFDB5010h: 4E5B                     MOVE   B2_DADDR,A11         ; Move register to register
FFDB5020h: E683                     CPW    A4,A3                ; Compare point to window
FFDB5030h: CC28                     JRV    FFDB52C0h            ; Jump relative conditional
FFDB5040h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDB5050h: 4EA0                     MOVE   A5,B0_SADDR          ; Move register to register
FFDB5060h: 4C01                     MOVE   A0,A1                ; Move register to register
FFDB5070h: 0121                     EXGPC  A1                   ; Exchange program counter with register
FFDB5080h: E65E                     CPW    B2_DADDR,B14_TEMP    ; Compare point to window
FFDB5090h: 411E                     ADD    B8_COLOR0,B14_TEMP   ; Add registers
FFDB50A0h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB50B0h: 4F67                     MOVE   A11,B7_DVDX          ; Move register to register
FFDB50C0h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDB50D0h: C801                     JRC    FFDB50F0h            ; Jump relative conditional
FFDB50E0h: CD03                     JRNV   FFDB5120h            ; Jump relative conditional
FFDB50F0h: E0F2                     ADDXY  B7_DVDX,B2_DADDR     ; Add registers in XV mode
FFDB5100h: 03F7                     NOT    B7_DVDX              ; Complement register
FFDB5110h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB5120h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB5130h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDB5140h: C0BF                     JR     FFDB4D40h            ; Jump relative conditional

FFDB5150h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDB5160h: 4E80                     MOVE   A4,B0_SADDR          ; Move register to register
FFDB5170h: C0EE                     JR     FFDB5060h            ; Jump relative conditional

FFDB5180h: ECB2                     MOVX   B5_WSTART,B2_DADDR   ; Move X half of register
FFDB5190h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB51A0h: ECD2                     MOVX   B6_WEND,B2_DADDR     ; Move X half of register
FFDB51B0h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB51C0h: 0300                     NOP                         ; No operation
FFDB51D0h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB51E0h: EEB2                     MOVY   B5_WSTART,B2_DADDR   ; Move Y half of register
FFDB51F0h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB5200h: 4CB2                     MOVE   B5_WSTART,B2_DADDR   ; Move register to register
FFDB5210h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB5220h: ECD2                     MOVX   B6_WEND,B2_DADDR     ; Move X half of register
FFDB5230h: EEB2                     MOVY   B5_WSTART,B2_DADDR   ; Move Y half of register
FFDB5240h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB5250h: 0300                     NOP                         ; No operation
FFDB5260h: EED2                     MOVY   B6_WEND,B2_DADDR     ; Move Y half of register
FFDB5270h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB5280h: ECB2                     MOVX   B5_WSTART,B2_DADDR   ; Move X half of register
FFDB5290h: C0FC                     JR     FFDB5260h            ; Jump relative conditional

FFDB52A0h: 4CD2                     MOVE   B6_WEND,B2_DADDR     ; Move register to register
FFDB52B0h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB52C0h: 5061                     AND    A3,A1                ; AND registers
FFDB52D0h: CBDE                     JRNE   FFDB50C0h            ; Jump relative conditional
FFDB52E0h: 4EF3                     MOVE   B7_DVDX,A3           ; Move register to register
FFDB52F0h: 1841                     MOVK   2h,A1                ; Move constant (5 bits)
FFDB5300h: D501                     EXGF   A1,0                 ; Exchange field size
FFDB5310h: 183C                     MOVK   1h,B12_INC2          ; Move constant (5 bits)
FFDB5320h: 09FE 00B6 C000           MOVI   CONTROL+6,B14_TEMP   ; Move immediate (32 bits)
FFDB5350h: 819E                     MOVE   B12_INC2,*B14_TEMP,0 ; Move field. register to indirect
FFDB5360h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDB5370h: 4EA0                     MOVE   A5,B0_SADDR          ; Move register to register
FFDB5380h: E250                     SUBXY  B2_DADDR,B0_SADDR    ; Subtract registers in XY mode
FFDB5390h: 577B                     CLR    B11_INC1             ; Clear register
FFDB53A0h: 03FB                     NOT    B11_INC1             ; Complement register
FFDB53B0h: 183A                     MOVK   1h,B10_COUNT         ; Move constant (5 bits)
FFDB53C0h: 56F7                     CLR    B7_DVDX              ; Clear register
FFDB53D0h: E217                     SUBXY  B0_SADDR,B7_DVDX     ; Subtract registers in XY mode
FFDB53E0h: C902                     JRNC   FFDB5410h            ; Jump relative conditional
FFDB53F0h: EE17                     MOVY   B0_SADDR,B7_DVDX     ; Move Y half of register
FFDB5400h: 2E3B                     SRL    Fh,B11_INC1          ; Shift right logical, constant
FFDB5410h: CD02                     JRNV   FFDB5440h            ; Jump relative conditional
FFDB5420h: EC17                     MOVX   B0_SADDR,B7_DVDX     ; Move X half of register
FFDB5430h: ED5B                     MOVX   B10_COUNT,B11_INC1   ; Move X half of register
FFDB5440h: 579C                     CLR    B12_INC2             ; Clear register
FFDB5450h: 4CF0                     MOVE   B7_DVDX,B0_SADDR     ; Move register to register
FFDB5460h: 2E10                     SRL    10h,B0_SADDR         ; Shift right logical, constant
FFDB5470h: E417                     CMPXY  B0_SADDR,B7_DVDX     ; Compare X and V halves of registers
FFDB5480h: CC02                     JRV    FFDB54B0h            ; Jump relative conditional
FFDB5490h: ED7C                     MOVX   B11_INC1,B12_INC2    ; Move X half of register
FFDB54A0h: C003                     JR     FFDB54E0h            ; Jump relative conditional

FFDB54B0h: ECF0                     MOVX   B7_DVDX,B0_SADDR     ; Move X half of register
FFDB54C0h: 3217                     RL     10h,B7_DVDX          ; Rotate left, constant
FFDB54D0h: EF7C                     MOVY   B11_INC1,B12_INC2    ; Move Y half of register
FFDB54E0h: 4010                     ADD    B0_SADDR,B0_SADDR    ; Add registers
FFDB54F0h: ECFA                     MOVX   B7_DVDX,B10_COUNT    ; Move X half of register
FFDB5500h: 4550                     SUB    B10_COUNT,B0_SADDR   ; Subtract registers
FFDB5510h: 103A                     INC    B10_COUNT            ; Increment register
FFDB5520h: DF1A                     LINE   0                    ; Perform the inner loop of Bresenham's line-drawing algorithm
FFDB5530h: 185C                     MOVK   2h,B12_INC2          ; Move constant (5 bits)
FFDB5540h: 09FE 00B6 C000           MOVI   CONTROL+6,B14_TEMP   ; Move immediate (32 bits)
FFDB5570h: 819E                     MOVE   B12_INC2,*B14_TEMP,0 ; Move field. register to indirect
FFDB5580h: D501                     EXGF   A1,0                 ; Exchange field size
FFDB5590h: CD12                     JRNV   FFDB56C0h            ; Jump relative conditional
FFDB55A0h: 4F62                     MOVE   A11,B2_DADDR         ; Move register to register
FFDB55B0h: 4E8C                     MOVE   A4,B12_INC2          ; Move register to register
FFDB55C0h: E79E                     CPW    B12_INC2,B14_TEMP    ; Compare point to window
FFDB55D0h: 411E                     ADD    B8_COLOR0,B14_TEMP   ; Add registers
FFDB55E0h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB55F0h: 4E51                     MOVE   B2_DADDR,A1          ; Move register to register
FFDB5600h: 4F67                     MOVE   A11,B7_DVDX          ; Move register to register
FFDB5610h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDB5620h: C801                     JRC    FFDB5640h            ; Jump relative conditional
FFDB5630h: CD03                     JRNV   FFDB5670h            ; Jump relative conditional
FFDB5640h: E0F2                     ADDXY  B7_DVDX,B2_DADDR     ; Add registers in XV mode
FFDB5650h: 03F7                     NOT    B7_DVDX              ; Complement register
FFDB5660h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB5670h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB5680h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDB5690h: 4E27                     MOVE   A1,B7_DVDX           ; Move register to register
FFDB56A0h: 4E62                     MOVE   A3,B2_DADDR          ; Move register to register
FFDB56B0h: C0A0                     JR     FFDB50C0h            ; Jump relative conditional

FFDB56C0h: 4E54                     MOVE   B2_DADDR,A4          ; Move register to register
FFDB56D0h: 4E67                     MOVE   A3,B7_DVDX           ; Move register to register
FFDB56E0h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDB56F0h: C801                     JRC    FFDB5710h            ; Jump relative conditional
FFDB5700h: CD03                     JRNV   FFDB5740h            ; Jump relative conditional
FFDB5710h: E0F2                     ADDXY  B7_DVDX,B2_DADDR     ; Add registers in XV mode
FFDB5720h: 03F7                     NOT    B7_DVDX              ; Complement register
FFDB5730h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB5740h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB5750h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDB5760h: C08D                     JR     FFDB5040h            ; Jump relative conditional

FFDB5770h: 1FC1                     BTST   1h,A1                ; Set status on value of: bit K in Rd
FFDB5780h: CA0C                     JREQ   FFDB5850h            ; Jump relative conditional
FFDB5790h: 09FA 5D10 FFDB           MOVI   FFDB5D10h,B10_COUNT  ; Move immediate (32 bits)
FFDB57C0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB57D0h: 4E2E                     MOVE   A1,B14_TEMP          ; Move register to register
FFDB57E0h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDB57F0h: 2C9E                     SRL    1Ch,B14_TEMP         ; Shift right logical, constant
FFDB5800h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDB5810h: 405E                     ADD    B2_DADDR,B14_TEMP    ; Add registers
FFDB5820h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB5830h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB5840h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB5850h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDB5860h: CA0A                     JREQ   FFDB5910h            ; Jump relative conditional
FFDB5870h: 09FA 5D40 FFDB           MOVI   FFDB5D40h,B10_COUNT  ; Move immediate (32 bits)
FFDB58A0h: 4E2E                     MOVE   A1,B14_TEMP          ; Move register to register
FFDB58B0h: 269E                     SLL    14h,B14_TEMP         ; Shift left logical, constant
FFDB58C0h: 2C9E                     SRL    1Ch,B14_TEMP         ; Shift right logical, constant
FFDB58D0h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDB58E0h: 405E                     ADD    B2_DADDR,B14_TEMP    ; Add registers
FFDB58F0h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB5900h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB5910h: 09FA 5D50 FFDB           MOVI   FFDB5D50h,B10_COUNT  ; Move immediate (32 bits)
FFDB5940h: 195E                     MOVK   Ah,B14_TEMP          ; Move constant (5 bits)
FFDB5950h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB5960h: 3C5E                     DSJS   B14_TEMP,FFDB5950h   ; Decrement register and skip jump short
FFDB5970h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP   ; Move immediate (32 bits)
FFDB59A0h: 457E                     SUB    B11_INC1,B14_TEMP    ; Subtract registers
FFDB59B0h: 161E                     SUBK   10h,B14_TEMP         ; Subtract constant (5 bits)
FFDB59C0h: 2F9E                     SRL    4h,B14_TEMP          ; Shift right logical, constant
FFDB59D0h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0 ; Move field. register to indirect (postincrement)
FFDB59E0h: 121A                     ADDK   10h,B10_COUNT        ; Add constant (5 bits)
FFDB59F0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB5A00h: 4F70                     MOVE   B11_INC1,A0          ; Move register to register
FFDB5A10h: 0B00 0080                ADDI   80h,A0               ; Add immediate (16 bits)
FFDB5A30h: 4D78                     MOVE   B11_INC1,B8_COLOR0   ; Move register to register
FFDB5A40h: 0B18 0490                ADDI   490h,B8_COLOR0       ; Add immediate (16 bits)
FFDB5A60h: 09DE 00B4                MOVI   B4h,B14_TEMP         ; Move immediate (16 bits)
FFDB5A80h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB5A90h: 3C5E                     DSJS   B14_TEMP,FFDB5A80h   ; Decrement register and skip jump short
FFDB5AA0h: 09FB 00B6 C000           MOVI   CONTROL+6,B11_INC1   ; Move immediate (32 bits)
FFDB5AD0h: 0542                     SETF   2h,0,0               ; Set field parameters
FFDB5AE0h: 185A                     MOVK   2h,B10_COUNT         ; Move constant (5 bits)
FFDB5AF0h: 815B                     MOVE   B10_COUNT,*B11_INC1,0 ; Move field. register to indirect
FFDB5B00h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB5B10h: 09F1 0001 0001           MOVI   00010001h,B1_SPTCH   ; Move immediate (32 bits)
FFDB5B40h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDB5B50h: E65E                     CPW    B2_DADDR,B14_TEMP    ; Compare point to window
FFDB5B60h: CD05                     JRNV   FFDB5BC0h            ; Jump relative conditional
FFDB5B70h: 0B3E 62A0 FFDB           ADDI   FFDB62A0h,B14_TEMP   ; Add immediate (32 bits)
FFDB5BA0h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB5BB0h: 4E5B                     MOVE   B2_DADDR,A11         ; Move register to register
FFDB5BC0h: 0960                     RETS                        ; Return from subroutine

FFDB5BD0h: 0000 0000 0000 0000 0000 .bss     20*2*8

FFDB5D10h: 4F89                     MOVE   A12,B9_COLOR1        ; Move register to register
FFDB5D20h: CA01                     JREQ   FFDB5D40h            ; Jump relative conditional
FFDB5D30h: 4FC9                     MOVE   A14,B9_COLOR1        ; Move register to register
FFDB5D40h: CB0C                     JRNE   FFDB5E10h            ; Jump relative conditional
FFDB5D50h: E6A1                     CPW    A5,A1                ; Compare point to window
FFDB5D60h: CC37                     JRV    FFDB60E0h            ; Jump relative conditional
FFDB5D70h: E683                     CPW    A4,A3                ; Compare point to window
FFDB5D80h: CC50                     JRV    FFDB6290h            ; Jump relative conditional
FFDB5D90h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDB5DA0h: 4EA0                     MOVE   A5,B0_SADDR          ; Move register to register
FFDB5DB0h: 4C01                     MOVE   A0,A1                ; Move register to register
FFDB5DC0h: 0121                     EXGPC  A1                   ; Exchange program counter with register
FFDB5DD0h: 4CA4                     MOVE   A5,A4                ; Move register to register
FFDB5DE0h: 0D8D FFDD                DSJ    A13,FFDB5BD0h        ; Decrement register and skip jump
FFDB5E00h: 0960                     RETS                        ; Return from subroutine

FFDB5E10h: E6A1                     CPW    A5,A1                ; Compare point to window
FFDB5E20h: CDFA                     JRNV   FFDB5DD0h            ; Jump relative conditional
FFDB5E30h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDB5E40h: E65E                     CPW    B2_DADDR,B14_TEMP    ; Compare point to window
FFDB5E50h: 411E                     ADD    B8_COLOR0,B14_TEMP   ; Add registers
FFDB5E60h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB5E70h: 4E5B                     MOVE   B2_DADDR,A11         ; Move register to register
FFDB5E80h: C0F4                     JR     FFDB5DD0h            ; Jump relative conditional

FFDB5E90h: E250                     SUBXY  B2_DADDR,B0_SADDR    ; Subtract registers in XY mode
FFDB5EA0h: 577B                     CLR    B11_INC1             ; Clear register
FFDB5EB0h: 03FB                     NOT    B11_INC1             ; Complement register
FFDB5EC0h: 183A                     MOVK   1h,B10_COUNT         ; Move constant (5 bits)
FFDB5ED0h: 56F7                     CLR    B7_DVDX              ; Clear register
FFDB5EE0h: E217                     SUBXY  B0_SADDR,B7_DVDX     ; Subtract registers in XY mode
FFDB5EF0h: C902                     JRNC   FFDB5F20h            ; Jump relative conditional
FFDB5F00h: EE17                     MOVY   B0_SADDR,B7_DVDX     ; Move Y half of register
FFDB5F10h: 2E3B                     SRL    Fh,B11_INC1          ; Shift right logical, constant
FFDB5F20h: CD02                     JRNV   FFDB5F50h            ; Jump relative conditional
FFDB5F30h: EC17                     MOVX   B0_SADDR,B7_DVDX     ; Move X half of register
FFDB5F40h: ED5B                     MOVX   B10_COUNT,B11_INC1   ; Move X half of register
FFDB5F50h: 579C                     CLR    B12_INC2             ; Clear register
FFDB5F60h: 4CF0                     MOVE   B7_DVDX,B0_SADDR     ; Move register to register
FFDB5F70h: 2E10                     SRL    10h,B0_SADDR         ; Shift right logical, constant
FFDB5F80h: E417                     CMPXY  B0_SADDR,B7_DVDX     ; Compare X and V halves of registers
FFDB5F90h: CC02                     JRV    FFDB5FC0h            ; Jump relative conditional
FFDB5FA0h: ED7C                     MOVX   B11_INC1,B12_INC2    ; Move X half of register
FFDB5FB0h: C003                     JR     FFDB5FF0h            ; Jump relative conditional

FFDB5FC0h: ECF0                     MOVX   B7_DVDX,B0_SADDR     ; Move X half of register
FFDB5FD0h: 3217                     RL     10h,B7_DVDX          ; Rotate left, constant
FFDB5FE0h: EF7C                     MOVY   B11_INC1,B12_INC2    ; Move Y half of register
FFDB5FF0h: 4010                     ADD    B0_SADDR,B0_SADDR    ; Add registers
FFDB6000h: ECFA                     MOVX   B7_DVDX,B10_COUNT    ; Move X half of register
FFDB6010h: 4550                     SUB    B10_COUNT,B0_SADDR   ; Subtract registers
FFDB6020h: 103A                     INC    B10_COUNT            ; Increment register
FFDB6030h: 4E54                     MOVE   B2_DADDR,A4          ; Move register to register
FFDB6040h: 4E13                     MOVE   B0_SADDR,A3          ; Move register to register
FFDB6050h: DF1A                     LINE   0                    ; Perform the inner loop of Bresenham's line-drawing algorithm
FFDB6060h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDB6070h: 4E60                     MOVE   A3,B0_SADDR          ; Move register to register
FFDB6080h: 183A                     MOVK   1h,B10_COUNT         ; Move constant (5 bits)
FFDB6090h: E152                     ADDXY  B10_COUNT,B2_DADDR   ; Add registers in XV mode
FFDB60A0h: ECFA                     MOVX   B7_DVDX,B10_COUNT    ; Move X half of register
FFDB60B0h: 103A                     INC    B10_COUNT            ; Increment register
FFDB60C0h: DF1A                     LINE   0                    ; Perform the inner loop of Bresenham's line-drawing algorithm
FFDB60D0h: 0121                     EXGPC  A1                   ; Exchange program counter with register
FFDB60E0h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDB60F0h: E65E                     CPW    B2_DADDR,B14_TEMP    ; Compare point to window
FFDB6100h: 411E                     ADD    B8_COLOR0,B14_TEMP   ; Add registers
FFDB6110h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB6120h: 4F67                     MOVE   A11,B7_DVDX          ; Move register to register
FFDB6130h: 4E5B                     MOVE   B2_DADDR,A11         ; Move register to register
FFDB6140h: E683                     CPW    A4,A3                ; Compare point to window
FFDB6150h: CC2C                     JRV    FFDB6420h            ; Jump relative conditional
FFDB6160h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDB6170h: 4EA0                     MOVE   A5,B0_SADDR          ; Move register to register
FFDB6180h: 4C01                     MOVE   A0,A1                ; Move register to register
FFDB6190h: 0121                     EXGPC  A1                   ; Exchange program counter with register
FFDB61A0h: E65E                     CPW    B2_DADDR,B14_TEMP    ; Compare point to window
FFDB61B0h: 411E                     ADD    B8_COLOR0,B14_TEMP   ; Add registers
FFDB61C0h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB61D0h: 4F67                     MOVE   A11,B7_DVDX          ; Move register to register
FFDB61E0h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDB61F0h: C801                     JRC    FFDB6210h            ; Jump relative conditional
FFDB6200h: CD03                     JRNV   FFDB6240h            ; Jump relative conditional
FFDB6210h: E0F2                     ADDXY  B7_DVDX,B2_DADDR     ; Add registers in XV mode
FFDB6220h: 03F7                     NOT    B7_DVDX              ; Complement register
FFDB6230h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB6240h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB6250h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDB6260h: E1D7                     ADDXY  B14_TEMP,B7_DVDX     ; Add registers in XV mode
FFDB6270h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDB6280h: C0B4                     JR     FFDB5DD0h            ; Jump relative conditional

FFDB6290h: 4EA2                     MOVE   A5,B2_DADDR          ; Move register to register
FFDB62A0h: 4E80                     MOVE   A4,B0_SADDR          ; Move register to register
FFDB62B0h: C0EC                     JR     FFDB6180h            ; Jump relative conditional

FFDB62C0h: ECB2                     MOVX   B5_WSTART,B2_DADDR   ; Move X half of register
FFDB62D0h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB62E0h: ECD2                     MOVX   B6_WEND,B2_DADDR     ; Move X half of register
FFDB62F0h: C00F                     JR     FFDB63F0h            ; Jump relative conditional

FFDB6300h: 0300                     NOP                         ; No operation
FFDB6310h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB6320h: EEB2                     MOVY   B5_WSTART,B2_DADDR   ; Move Y half of register
FFDB6330h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB6340h: 4CB2                     MOVE   B5_WSTART,B2_DADDR   ; Move register to register
FFDB6350h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB6360h: ECD2                     MOVX   B6_WEND,B2_DADDR     ; Move X half of register
FFDB6370h: EEB2                     MOVY   B5_WSTART,B2_DADDR   ; Move Y half of register
FFDB6380h: C006                     JR     FFDB63F0h            ; Jump relative conditional

FFDB6390h: 0300                     NOP                         ; No operation
FFDB63A0h: EED2                     MOVY   B6_WEND,B2_DADDR     ; Move Y half of register
FFDB63B0h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB63C0h: ECB2                     MOVX   B5_WSTART,B2_DADDR   ; Move X half of register
FFDB63D0h: C0FC                     JR     FFDB63A0h            ; Jump relative conditional

FFDB63E0h: 4CD2                     MOVE   B6_WEND,B2_DADDR     ; Move register to register
FFDB63F0h: 183C                     MOVK   1h,B12_INC2          ; Move constant (5 bits)
FFDB6400h: E392                     SUBXY  B12_INC2,B2_DADDR    ; Subtract registers in XY mode
FFDB6410h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB6420h: 5061                     AND    A3,A1                ; AND registers
FFDB6430h: CBDA                     JRNE   FFDB61E0h            ; Jump relative conditional
FFDB6440h: 4EF3                     MOVE   B7_DVDX,A3           ; Move register to register
FFDB6450h: 1841                     MOVK   2h,A1                ; Move constant (5 bits)
FFDB6460h: D501                     EXGF   A1,0                 ; Exchange field size
FFDB6470h: 183C                     MOVK   1h,B12_INC2          ; Move constant (5 bits)
FFDB6480h: 09FE 00B6 C000           MOVI   CONTROL+6,B14_TEMP   ; Move immediate (32 bits)
FFDB64B0h: 819E                     MOVE   B12_INC2,*B14_TEMP,0 ; Move field. register to indirect
FFDB64C0h: 4E82                     MOVE   A4,B2_DADDR          ; Move register to register
FFDB64D0h: 4EA0                     MOVE   A5,B0_SADDR          ; Move register to register
FFDB64E0h: E250                     SUBXY  B2_DADDR,B0_SADDR    ; Subtract registers in XY mode
FFDB64F0h: 577B                     CLR    B11_INC1             ; Clear register
FFDB6500h: 03FB                     NOT    B11_INC1             ; Complement register
FFDB6510h: 183A                     MOVK   1h,B10_COUNT         ; Move constant (5 bits)
FFDB6520h: 56F7                     CLR    B7_DVDX              ; Clear register
FFDB6530h: E217                     SUBXY  B0_SADDR,B7_DVDX     ; Subtract registers in XY mode
FFDB6540h: C902                     JRNC   FFDB6570h            ; Jump relative conditional
FFDB6550h: EE17                     MOVY   B0_SADDR,B7_DVDX     ; Move Y half of register
FFDB6560h: 2E3B                     SRL    Fh,B11_INC1          ; Shift right logical, constant
FFDB6570h: CD02                     JRNV   FFDB65A0h            ; Jump relative conditional
FFDB6580h: EC17                     MOVX   B0_SADDR,B7_DVDX     ; Move X half of register
FFDB6590h: ED5B                     MOVX   B10_COUNT,B11_INC1   ; Move X half of register
FFDB65A0h: 579C                     CLR    B12_INC2             ; Clear register
FFDB65B0h: 4CF0                     MOVE   B7_DVDX,B0_SADDR     ; Move register to register
FFDB65C0h: 2E10                     SRL    10h,B0_SADDR         ; Shift right logical, constant
FFDB65D0h: E417                     CMPXY  B0_SADDR,B7_DVDX     ; Compare X and V halves of registers
FFDB65E0h: CC02                     JRV    FFDB6610h            ; Jump relative conditional
FFDB65F0h: ED7C                     MOVX   B11_INC1,B12_INC2    ; Move X half of register
FFDB6600h: C003                     JR     FFDB6640h            ; Jump relative conditional

FFDB6610h: ECF0                     MOVX   B7_DVDX,B0_SADDR     ; Move X half of register
FFDB6620h: 3217                     RL     10h,B7_DVDX          ; Rotate left, constant
FFDB6630h: EF7C                     MOVY   B11_INC1,B12_INC2    ; Move Y half of register
FFDB6640h: 4010                     ADD    B0_SADDR,B0_SADDR    ; Add registers
FFDB6650h: ECFA                     MOVX   B7_DVDX,B10_COUNT    ; Move X half of register
FFDB6660h: 4550                     SUB    B10_COUNT,B0_SADDR   ; Subtract registers
FFDB6670h: 103A                     INC    B10_COUNT            ; Increment register
FFDB6680h: DF1A                     LINE   0                    ; Perform the inner loop of Bresenham's line-drawing algorithm
FFDB6690h: 185C                     MOVK   2h,B12_INC2          ; Move constant (5 bits)
FFDB66A0h: 09FE 00B6 C000           MOVI   CONTROL+6,B14_TEMP   ; Move immediate (32 bits)
FFDB66D0h: 819E                     MOVE   B12_INC2,*B14_TEMP,0 ; Move field. register to indirect
FFDB66E0h: D501                     EXGF   A1,0                 ; Exchange field size
FFDB66F0h: CD14                     JRNV   FFDB6840h            ; Jump relative conditional
FFDB6700h: 4F62                     MOVE   A11,B2_DADDR         ; Move register to register
FFDB6710h: 4E8C                     MOVE   A4,B12_INC2          ; Move register to register
FFDB6720h: E79E                     CPW    B12_INC2,B14_TEMP    ; Compare point to window
FFDB6730h: 411E                     ADD    B8_COLOR0,B14_TEMP   ; Add registers
FFDB6740h: 013E                     EXGPC  B14_TEMP             ; Exchange program counter with register
FFDB6750h: 4E51                     MOVE   B2_DADDR,A1          ; Move register to register
FFDB6760h: 4F67                     MOVE   A11,B7_DVDX          ; Move register to register
FFDB6770h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDB6780h: C801                     JRC    FFDB67A0h            ; Jump relative conditional
FFDB6790h: CD03                     JRNV   FFDB67D0h            ; Jump relative conditional
FFDB67A0h: E0F2                     ADDXY  B7_DVDX,B2_DADDR     ; Add registers in XV mode
FFDB67B0h: 03F7                     NOT    B7_DVDX              ; Complement register
FFDB67C0h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB67D0h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB67E0h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDB67F0h: E1D7                     ADDXY  B14_TEMP,B7_DVDX     ; Add registers in XV mode
FFDB6800h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDB6810h: 4E27                     MOVE   A1,B7_DVDX           ; Move register to register
FFDB6820h: 4E62                     MOVE   A3,B2_DADDR          ; Move register to register
FFDB6830h: C09A                     JR     FFDB61E0h            ; Jump relative conditional

FFDB6840h: E456                     CMPXY  B2_DADDR,B6_WEND     ; Compare X and V halves of registers
FFDB6850h: CF02                     JRNN   FFDB6880h            ; Jump relative conditional
FFDB6860h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDB6870h: E3D2                     SUBXY  B14_TEMP,B2_DADDR    ; Subtract registers in XY mode
FFDB6880h: 4E54                     MOVE   B2_DADDR,A4          ; Move register to register
FFDB6890h: 4E67                     MOVE   A3,B7_DVDX           ; Move register to register
FFDB68A0h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDB68B0h: C801                     JRC    FFDB68D0h            ; Jump relative conditional
FFDB68C0h: CD03                     JRNV   FFDB6900h            ; Jump relative conditional
FFDB68D0h: E0F2                     ADDXY  B7_DVDX,B2_DADDR     ; Add registers in XV mode
FFDB68E0h: 03F7                     NOT    B7_DVDX              ; Complement register
FFDB68F0h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB6900h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB6910h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDB6920h: E1D7                     ADDXY  B14_TEMP,B7_DVDX     ; Add registers in XV mode
FFDB6930h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDB6940h: C081                     JR     FFDB6160h            ; Jump relative conditional

FFDB6950h: 1FC1                     BTST   1h,A1                ; Set status on value of: bit K in Rd
FFDB6960h: CA0C                     JREQ   FFDB6A30h            ; Jump relative conditional
FFDB6970h: 09FA 6D20 FFDB           MOVI   FFDB6D20h,B10_COUNT  ; Move immediate (32 bits)
FFDB69A0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB69B0h: 4E2E                     MOVE   A1,B14_TEMP          ; Move register to register
FFDB69C0h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDB69D0h: 2C9E                     SRL    1Ch,B14_TEMP         ; Shift right logical, constant
FFDB69E0h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDB69F0h: 405E                     ADD    B2_DADDR,B14_TEMP    ; Add registers
FFDB6A00h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB6A10h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB6A20h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB6A30h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDB6A40h: CA0A                     JREQ   FFDB6AF0h            ; Jump relative conditional
FFDB6A50h: 09FA 6D50 FFDB           MOVI   FFDB6D50h,B10_COUNT  ; Move immediate (32 bits)
FFDB6A80h: 4E2E                     MOVE   A1,B14_TEMP          ; Move register to register
FFDB6A90h: 269E                     SLL    14h,B14_TEMP         ; Shift left logical, constant
FFDB6AA0h: 2C9E                     SRL    1Ch,B14_TEMP         ; Shift right logical, constant
FFDB6AB0h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDB6AC0h: 405E                     ADD    B2_DADDR,B14_TEMP    ; Add registers
FFDB6AD0h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB6AE0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB6AF0h: 09FA 6D60 FFDB           MOVI   FFDB6D60h,B10_COUNT  ; Move immediate (32 bits)
FFDB6B20h: 09DE 0029                MOVI   29h,B14_TEMP         ; Move immediate (16 bits)
FFDB6B40h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB6B50h: 3C5E                     DSJS   B14_TEMP,FFDB6B40h   ; Decrement register and skip jump short
FFDB6B60h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP   ; Move immediate (32 bits)
FFDB6B90h: 457E                     SUB    B11_INC1,B14_TEMP    ; Subtract registers
FFDB6BA0h: 161E                     SUBK   10h,B14_TEMP         ; Subtract constant (5 bits)
FFDB6BB0h: 2F9E                     SRL    4h,B14_TEMP          ; Shift right logical, constant
FFDB6BC0h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0 ; Move field. register to indirect (postincrement)
FFDB6BD0h: 121A                     ADDK   10h,B10_COUNT        ; Add constant (5 bits)
FFDB6BE0h: 09DE 002E                MOVI   2Eh,B14_TEMP         ; Move immediate (16 bits)
FFDB6C00h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB6C10h: 3C5E                     DSJS   B14_TEMP,FFDB6C00h   ; Decrement register and skip jump short
FFDB6C20h: 1D61                     BTST   14h,A1               ; Set status on value of: bit K in Rd
FFDB6C30h: CA02                     JREQ   FFDB6C60h            ; Jump relative conditional
FFDB6C40h: 141B                     SUBK   20h,B11_INC1         ; Subtract constant (5 bits)
FFDB6C50h: 895B                     MOVE   *B10_COUNT,*B11_INC1,0 ; Move field, indirect to indirect
FFDB6C60h: 4C80                     MOVE   A4,A0                ; Move register to register
FFDB6C70h: 4C83                     MOVE   A4,A3                ; Move register to register
FFDB6C80h: 09EB 0000 0001           MOVI   00010000h,A11        ; Move immediate (32 bits)
FFDB6CB0h: 09F1 0001 0001           MOVI   00010001h,B1_SPTCH   ; Move immediate (32 bits)
FFDB6CE0h: 059E 0C80 FFEC           MOVE   B14_TEMP,@FFEC0C80h,0 ; Move field, register to absolute
FFDB6D10h: 0960                     RETS                        ; Return from subroutine

FFDB6D20h: 4F89                     MOVE   A12,B9_COLOR1        ; Move register to register
FFDB6D30h: CA01                     JREQ   FFDB6D50h            ; Jump relative conditional
FFDB6D40h: 4FC9                     MOVE   A14,B9_COLOR1        ; Move register to register
FFDB6D50h: CB38                     JRNE   FFDB70E0h            ; Jump relative conditional
FFDB6D60h: E485                     CMPXY  A4,A5                ; Compare X and V halves of registers
FFDB6D70h: CA46                     JREQ   FFDB71E0h            ; Jump relative conditional
FFDB6D80h: CE3C                     JRN    FFDB7150h            ; Jump relative conditional
FFDB6D90h: C90F                     JRNC   FFDB6E90h            ; Jump relative conditional
FFDB6DA0h: 4E67                     MOVE   A3,B7_DVDX           ; Move register to register
FFDB6DB0h: 4C83                     MOVE   A4,A3                ; Move register to register
FFDB6DC0h: E2A3                     SUBXY  A5,A3                ; Subtract registers in XY mode
FFDB6DD0h: E163                     ADDXY  A11,A3               ; Add registers in XV mode
FFDB6DE0h: 2FE3                     SRL    1h,A3                ; Shift right logical, constant
FFDB6DF0h: E0A3                     ADDXY  A5,A3                ; Add registers in XV mode
FFDB6E00h: ECA3                     MOVX   A5,A3                ; Move X half of register
FFDB6E10h: 4C61                     MOVE   A3,A1                ; Move register to register
FFDB6E20h: E161                     ADDXY  A11,A1               ; Add registers in XV mode
FFDB6E30h: E401                     CMPXY  A0,A1                ; Compare X and V halves of registers
FFDB6E40h: C901                     JRNC   FFDB6E60h            ; Jump relative conditional
FFDB6E50h: EE20                     MOVY   A1,A0                ; Move Y half of register
FFDB6E60h: 4E02                     MOVE   A0,B2_DADDR          ; Move register to register
FFDB6E70h: 4CA0                     MOVE   A5,A0                ; Move register to register
FFDB6E80h: C00E                     JR     FFDB6F70h            ; Jump relative conditional

FFDB6E90h: 4E02                     MOVE   A0,B2_DADDR          ; Move register to register
FFDB6EA0h: 4CA0                     MOVE   A5,A0                ; Move register to register
FFDB6EB0h: E280                     SUBXY  A4,A0                ; Subtract registers in XY mode
FFDB6EC0h: E160                     ADDXY  A11,A0               ; Add registers in XV mode
FFDB6ED0h: 2FE0                     SRL    1h,A0                ; Shift right logical, constant
FFDB6EE0h: E080                     ADDXY  A4,A0                ; Add registers in XV mode
FFDB6EF0h: ECA0                     MOVX   A5,A0                ; Move X half of register
FFDB6F00h: 4C01                     MOVE   A0,A1                ; Move register to register
FFDB6F10h: E361                     SUBXY  A11,A1               ; Subtract registers in XY mode
FFDB6F20h: E423                     CMPXY  A1,A3                ; Compare X and V halves of registers
FFDB6F30h: C901                     JRNC   FFDB6F50h            ; Jump relative conditional
FFDB6F40h: EE23                     MOVY   A1,A3                ; Move Y half of register
FFDB6F50h: 4E67                     MOVE   A3,B7_DVDX           ; Move register to register
FFDB6F60h: 4CA3                     MOVE   A5,A3                ; Move register to register
FFDB6F70h: E65E                     CPW    B2_DADDR,B14_TEMP    ; Compare point to window
FFDB6F80h: CC29                     JRV    FFDB7220h            ; Jump relative conditional
FFDB6F90h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDB6FA0h: CA2E                     JREQ   FFDB7290h            ; Jump relative conditional
FFDB6FB0h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB6FC0h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDB6FD0h: 4CA4                     MOVE   A5,A4                ; Move register to register
FFDB6FE0h: 0D8D FFD2                DSJ    A13,FFDB6D20h        ; Decrement register and skip jump
FFDB7000h: 05A1 0C80 FFEC           MOVE   @FFEC0C80h,A1,0      ; Move field, absolute to register
FFDB7030h: CB09                     JRNE   FFDB70D0h            ; Jump relative conditional
FFDB7040h: 1821                     MOVK   1h,A1                ; Move constant (5 bits)
FFDB7050h: 0581 0C80 FFEC           MOVE   A1,@FFEC0C80h,0      ; Move field, register to absolute
FFDB7080h: 184D                     MOVK   2h,A13               ; Move constant (5 bits)
FFDB7090h: 1608                     SUBK   10h,A8               ; Subtract constant (5 bits)
FFDB70A0h: 44E8                     SUB    A7,A8                ; Subtract registers
FFDB70B0h: E224                     SUBXY  A1,A4                ; Subtract registers in XY mode
FFDB70C0h: C0F0                     JR     FFDB6FD0h            ; Jump relative conditional

FFDB70D0h: 0960                     RETS                        ; Return from subroutine

FFDB70E0h: E485                     CMPXY  A4,A5                ; Compare X and V halves of registers
FFDB70F0h: CEED                     JRN    FFDB6FD0h            ; Jump relative conditional
FFDB7100h: E403                     CMPXY  A0,A3                ; Compare X and V halves of registers
FFDB7110h: CB0D                     JRNE   FFDB71F0h            ; Jump relative conditional
FFDB7120h: 4CA0                     MOVE   A5,A0                ; Move register to register
FFDB7130h: 4CA3                     MOVE   A5,A3                ; Move register to register
FFDB7140h: C0E8                     JR     FFDB6FD0h            ; Jump relative conditional

FFDB7150h: C904                     JRNC   FFDB71A0h            ; Jump relative conditional
FFDB7160h: E405                     CMPXY  A0,A5                ; Compare X and V halves of registers
FFDB7170h: C9E5                     JRNC   FFDB6FD0h            ; Jump relative conditional
FFDB7180h: 4CA0                     MOVE   A5,A0                ; Move register to register
FFDB7190h: C0E3                     JR     FFDB6FD0h            ; Jump relative conditional

FFDB71A0h: E4A3                     CMPXY  A5,A3                ; Compare X and V halves of registers
FFDB71B0h: C9E1                     JRNC   FFDB6FD0h            ; Jump relative conditional
FFDB71C0h: 4CA3                     MOVE   A5,A3                ; Move register to register
FFDB71D0h: C0DF                     JR     FFDB6FD0h            ; Jump relative conditional

FFDB71E0h: CEDE                     JRN    FFDB6FD0h            ; Jump relative conditional
FFDB71F0h: 4E02                     MOVE   A0,B2_DADDR          ; Move register to register
FFDB7200h: 4CA0                     MOVE   A5,A0                ; Move register to register
FFDB7210h: C0D3                     JR     FFDB6F50h            ; Jump relative conditional

FFDB7220h: E6FC                     CPW    B7_DVDX,B12_INC2     ; Compare point to window
FFDB7230h: CDD5                     JRNV   FFDB6F90h            ; Jump relative conditional
FFDB7240h: 519E                     AND    B12_INC2,B14_TEMP    ; AND registers
FFDB7250h: CAD3                     JREQ   FFDB6F90h            ; Jump relative conditional
FFDB7260h: 1F1E                     BTST   7h,B14_TEMP          ; Set status on value of: bit K in Rd
FFDB7270h: CB03                     JRNE   FFDB72B0h            ; Jump relative conditional
FFDB7280h: EED2                     MOVY   B6_WEND,B2_DADDR     ; Move Y half of register
FFDB7290h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY ; Pixel transfer, register to indirect XY
FFDB72A0h: C0D2                     JR     FFDB6FD0h            ; Jump relative conditional

FFDB72B0h: EEB2                     MOVY   B5_WSTART,B2_DADDR   ; Move Y half of register
FFDB72C0h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY ; Pixel transfer, register to indirect XY
FFDB72D0h: C0CF                     JR     FFDB6FD0h            ; Jump relative conditional

FFDB72E0h: 0300                     NOP                         ; No operation
FFDB72F0h: 1FC1                     BTST   1h,A1                ; Set status on value of: bit K in Rd
FFDB7300h: CA0C                     JREQ   FFDB73D0h            ; Jump relative conditional
FFDB7310h: 09FA 76F0 FFDB           MOVI   FFDB76F0h,B10_COUNT  ; Move immediate (32 bits)
FFDB7340h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7350h: 4E2E                     MOVE   A1,B14_TEMP          ; Move register to register
FFDB7360h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDB7370h: 2C9E                     SRL    1Ch,B14_TEMP         ; Shift right logical, constant
FFDB7380h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDB7390h: 405E                     ADD    B2_DADDR,B14_TEMP    ; Add registers
FFDB73A0h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB73B0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB73C0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB73D0h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDB73E0h: CA0A                     JREQ   FFDB7490h            ; Jump relative conditional
FFDB73F0h: 09FA 7720 FFDB           MOVI   FFDB7720h,B10_COUNT  ; Move immediate (32 bits)
FFDB7420h: 4E2E                     MOVE   A1,B14_TEMP          ; Move register to register
FFDB7430h: 269E                     SLL    14h,B14_TEMP         ; Shift left logical, constant
FFDB7440h: 2C9E                     SRL    1Ch,B14_TEMP         ; Shift right logical, constant
FFDB7450h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDB7460h: 405E                     ADD    B2_DADDR,B14_TEMP    ; Add registers
FFDB7470h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7480h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7490h: 09FA 7730 FFDB           MOVI   FFDB7730h,B10_COUNT  ; Move immediate (32 bits)
FFDB74C0h: 09DE 002A                MOVI   2Ah,B14_TEMP         ; Move immediate (16 bits)
FFDB74E0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB74F0h: 3C5E                     DSJS   B14_TEMP,FFDB74E0h   ; Decrement register and skip jump short
FFDB7500h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP   ; Move immediate (32 bits)
FFDB7530h: 457E                     SUB    B11_INC1,B14_TEMP    ; Subtract registers
FFDB7540h: 161E                     SUBK   10h,B14_TEMP         ; Subtract constant (5 bits)
FFDB7550h: 2F9E                     SRL    4h,B14_TEMP          ; Shift right logical, constant
FFDB7560h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0 ; Move field. register to indirect (postincrement)
FFDB7570h: 121A                     ADDK   10h,B10_COUNT        ; Add constant (5 bits)
FFDB7580h: 09DE 0032                MOVI   32h,B14_TEMP         ; Move immediate (16 bits)
FFDB75A0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB75B0h: 3C5E                     DSJS   B14_TEMP,FFDB75A0h   ; Decrement register and skip jump short
FFDB75C0h: 1D61                     BTST   14h,A1               ; Set status on value of: bit K in Rd
FFDB75D0h: CA04                     JREQ   FFDB7620h            ; Jump relative conditional
FFDB75E0h: 0BFB FFCF                SUBI   30h,B11_INC1         ; Subtract immediate (16 bits)
FFDB7600h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7610h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7620h: 4C80                     MOVE   A4,A0                ; Move register to register
FFDB7630h: 4C83                     MOVE   A4,A3                ; Move register to register
FFDB7640h: 09EB 0000 0001           MOVI   00010000h,A11        ; Move immediate (32 bits)
FFDB7670h: 09F1 0001 0001           MOVI   00010001h,B1_SPTCH   ; Move immediate (32 bits)
FFDB76A0h: 1830                     MOVK   1h,B0_SADDR          ; Move constant (5 bits)
FFDB76B0h: 059E 0C80 FFEC           MOVE   B14_TEMP,@FFEC0C80h,0 ; Move field, register to absolute
FFDB76E0h: 0960                     RETS                        ; Return from subroutine

FFDB76F0h: 4F89                     MOVE   A12,B9_COLOR1        ; Move register to register
FFDB7700h: CA01                     JREQ   FFDB7720h            ; Jump relative conditional
FFDB7710h: 4FC9                     MOVE   A14,B9_COLOR1        ; Move register to register
FFDB7720h: CB39                     JRNE   FFDB7AC0h            ; Jump relative conditional
FFDB7730h: E485                     CMPXY  A4,A5                ; Compare X and V halves of registers
FFDB7740h: CA47                     JREQ   FFDB7BC0h            ; Jump relative conditional
FFDB7750h: CE3D                     JRN    FFDB7B30h            ; Jump relative conditional
FFDB7760h: C90F                     JRNC   FFDB7860h            ; Jump relative conditional
FFDB7770h: 4E67                     MOVE   A3,B7_DVDX           ; Move register to register
FFDB7780h: 4C83                     MOVE   A4,A3                ; Move register to register
FFDB7790h: E2A3                     SUBXY  A5,A3                ; Subtract registers in XY mode
FFDB77A0h: E163                     ADDXY  A11,A3               ; Add registers in XV mode
FFDB77B0h: 2FE3                     SRL    1h,A3                ; Shift right logical, constant
FFDB77C0h: E0A3                     ADDXY  A5,A3                ; Add registers in XV mode
FFDB77D0h: ECA3                     MOVX   A5,A3                ; Move X half of register
FFDB77E0h: 4C61                     MOVE   A3,A1                ; Move register to register
FFDB77F0h: E161                     ADDXY  A11,A1               ; Add registers in XV mode
FFDB7800h: E401                     CMPXY  A0,A1                ; Compare X and V halves of registers
FFDB7810h: C901                     JRNC   FFDB7830h            ; Jump relative conditional
FFDB7820h: EE20                     MOVY   A1,A0                ; Move Y half of register
FFDB7830h: 4E02                     MOVE   A0,B2_DADDR          ; Move register to register
FFDB7840h: 4CA0                     MOVE   A5,A0                ; Move register to register
FFDB7850h: C00E                     JR     FFDB7940h            ; Jump relative conditional

FFDB7860h: 4E02                     MOVE   A0,B2_DADDR          ; Move register to register
FFDB7870h: 4CA0                     MOVE   A5,A0                ; Move register to register
FFDB7880h: E280                     SUBXY  A4,A0                ; Subtract registers in XY mode
FFDB7890h: E160                     ADDXY  A11,A0               ; Add registers in XV mode
FFDB78A0h: 2FE0                     SRL    1h,A0                ; Shift right logical, constant
FFDB78B0h: E080                     ADDXY  A4,A0                ; Add registers in XV mode
FFDB78C0h: ECA0                     MOVX   A5,A0                ; Move X half of register
FFDB78D0h: 4C01                     MOVE   A0,A1                ; Move register to register
FFDB78E0h: E361                     SUBXY  A11,A1               ; Subtract registers in XY mode
FFDB78F0h: E423                     CMPXY  A1,A3                ; Compare X and V halves of registers
FFDB7900h: C901                     JRNC   FFDB7920h            ; Jump relative conditional
FFDB7910h: EE23                     MOVY   A1,A3                ; Move Y half of register
FFDB7920h: 4E67                     MOVE   A3,B7_DVDX           ; Move register to register
FFDB7930h: 4CA3                     MOVE   A5,A3                ; Move register to register
FFDB7940h: E65E                     CPW    B2_DADDR,B14_TEMP    ; Compare point to window
FFDB7950h: CC2A                     JRV    FFDB7C00h            ; Jump relative conditional
FFDB7960h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDB7970h: CA31                     JREQ   FFDB7C90h            ; Jump relative conditional
FFDB7980h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB7990h: E017                     ADDXY  B0_SADDR,B7_DVDX     ; Add registers in XV mode
FFDB79A0h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDB79B0h: 4CA4                     MOVE   A5,A4                ; Move register to register
FFDB79C0h: 0D8D FFD1                DSJ    A13,FFDB76F0h        ; Decrement register and skip jump
FFDB79E0h: 05A1 0C80 FFEC           MOVE   @FFEC0C80h,A1,0      ; Move field, absolute to register
FFDB7A10h: CB09                     JRNE   FFDB7AB0h            ; Jump relative conditional
FFDB7A20h: 1821                     MOVK   1h,A1                ; Move constant (5 bits)
FFDB7A30h: 0581 0C80 FFEC           MOVE   A1,@FFEC0C80h,0      ; Move field, register to absolute
FFDB7A60h: 184D                     MOVK   2h,A13               ; Move constant (5 bits)
FFDB7A70h: 1608                     SUBK   10h,A8               ; Subtract constant (5 bits)
FFDB7A80h: 44E8                     SUB    A7,A8                ; Subtract registers
FFDB7A90h: E224                     SUBXY  A1,A4                ; Subtract registers in XY mode
FFDB7AA0h: C0F0                     JR     FFDB79B0h            ; Jump relative conditional

FFDB7AB0h: 0960                     RETS                        ; Return from subroutine

FFDB7AC0h: E485                     CMPXY  A4,A5                ; Compare X and V halves of registers
FFDB7AD0h: CEED                     JRN    FFDB79B0h            ; Jump relative conditional
FFDB7AE0h: E403                     CMPXY  A0,A3                ; Compare X and V halves of registers
FFDB7AF0h: CB0D                     JRNE   FFDB7BD0h            ; Jump relative conditional
FFDB7B00h: 4CA0                     MOVE   A5,A0                ; Move register to register
FFDB7B10h: 4CA3                     MOVE   A5,A3                ; Move register to register
FFDB7B20h: C0E8                     JR     FFDB79B0h            ; Jump relative conditional

FFDB7B30h: C904                     JRNC   FFDB7B80h            ; Jump relative conditional
FFDB7B40h: E405                     CMPXY  A0,A5                ; Compare X and V halves of registers
FFDB7B50h: C9E5                     JRNC   FFDB79B0h            ; Jump relative conditional
FFDB7B60h: 4CA0                     MOVE   A5,A0                ; Move register to register
FFDB7B70h: C0E3                     JR     FFDB79B0h            ; Jump relative conditional

FFDB7B80h: E4A3                     CMPXY  A5,A3                ; Compare X and V halves of registers
FFDB7B90h: C9E1                     JRNC   FFDB79B0h            ; Jump relative conditional
FFDB7BA0h: 4CA3                     MOVE   A5,A3                ; Move register to register
FFDB7BB0h: C0DF                     JR     FFDB79B0h            ; Jump relative conditional

FFDB7BC0h: CEDE                     JRN    FFDB79B0h            ; Jump relative conditional
FFDB7BD0h: 4E02                     MOVE   A0,B2_DADDR          ; Move register to register
FFDB7BE0h: 4CA0                     MOVE   A5,A0                ; Move register to register
FFDB7BF0h: C0D2                     JR     FFDB7920h            ; Jump relative conditional

FFDB7C00h: E6FC                     CPW    B7_DVDX,B12_INC2     ; Compare point to window
FFDB7C10h: CDD4                     JRNV   FFDB7960h            ; Jump relative conditional
FFDB7C20h: 519E                     AND    B12_INC2,B14_TEMP    ; AND registers
FFDB7C30h: CAD2                     JREQ   FFDB7960h            ; Jump relative conditional
FFDB7C40h: 1F5E                     BTST   5h,B14_TEMP          ; Set status on value of: bit K in Rd
FFDB7C50h: CBD5                     JRNE   FFDB79B0h            ; Jump relative conditional
FFDB7C60h: 1F1E                     BTST   7h,B14_TEMP          ; Set status on value of: bit K in Rd
FFDB7C70h: CB04                     JRNE   FFDB7CC0h            ; Jump relative conditional
FFDB7C80h: EED2                     MOVY   B6_WEND,B2_DADDR     ; Move Y half of register
FFDB7C90h: F612                     DRAV   B0_SADDR,B2_DADDR    ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDB7CA0h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY ; Pixel transfer, register to indirect XY
FFDB7CB0h: C0CF                     JR     FFDB79B0h            ; Jump relative conditional

FFDB7CC0h: EEB2                     MOVY   B5_WSTART,B2_DADDR   ; Move Y half of register
FFDB7CD0h: F612                     DRAV   B0_SADDR,B2_DADDR    ; Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY
FFDB7CE0h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY ; Pixel transfer, register to indirect XY
FFDB7CF0h: C0CB                     JR     FFDB79B0h            ; Jump relative conditional

FFDB7D00h: 0300                     NOP                         ; No operation
FFDB7D10h: 0300                     NOP                         ; No operation
FFDB7D20h: 1FC1                     BTST   1h,A1                ; Set status on value of: bit K in Rd
FFDB7D30h: CA0C                     JREQ   FFDB7E00h            ; Jump relative conditional
FFDB7D40h: 09FA 8250 FFDB           MOVI   FFDB8250h,B10_COUNT  ; Move immediate (32 bits)
FFDB7D70h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7D80h: 4E2E                     MOVE   A1,B14_TEMP          ; Move register to register
FFDB7D90h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDB7DA0h: 2C9E                     SRL    1Ch,B14_TEMP         ; Shift right logical, constant
FFDB7DB0h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDB7DC0h: 405E                     ADD    B2_DADDR,B14_TEMP    ; Add registers
FFDB7DD0h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7DE0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7DF0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7E00h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDB7E10h: CA0A                     JREQ   FFDB7EC0h            ; Jump relative conditional
FFDB7E20h: 09FA 8280 FFDB           MOVI   FFDB8280h,B10_COUNT  ; Move immediate (32 bits)
FFDB7E50h: 4E2E                     MOVE   A1,B14_TEMP          ; Move register to register
FFDB7E60h: 269E                     SLL    14h,B14_TEMP         ; Shift left logical, constant
FFDB7E70h: 2C9E                     SRL    1Ch,B14_TEMP         ; Shift right logical, constant
FFDB7E80h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDB7E90h: 405E                     ADD    B2_DADDR,B14_TEMP    ; Add registers
FFDB7EA0h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7EB0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7EC0h: 09FA 8290 FFDB           MOVI   FFDB8290h,B10_COUNT  ; Move immediate (32 bits)
FFDB7EF0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7F00h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7F10h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7F20h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP   ; Move immediate (32 bits)
FFDB7F50h: 457E                     SUB    B11_INC1,B14_TEMP    ; Subtract registers
FFDB7F60h: 161E                     SUBK   10h,B14_TEMP         ; Subtract constant (5 bits)
FFDB7F70h: 2F9E                     SRL    4h,B14_TEMP          ; Shift right logical, constant
FFDB7F80h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0 ; Move field. register to indirect (postincrement)
FFDB7F90h: 4F70                     MOVE   B11_INC1,A0          ; Move register to register
FFDB7FA0h: 0B00 0060                ADDI   60h,A0               ; Add immediate (16 bits)
FFDB7FC0h: 121A                     ADDK   10h,B10_COUNT        ; Add constant (5 bits)
FFDB7FD0h: 1B9E                     MOVK   1Ch,B14_TEMP         ; Move constant (5 bits)
FFDB7FE0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB7FF0h: 3C5E                     DSJS   B14_TEMP,FFDB7FE0h   ; Decrement register and skip jump short
FFDB8000h: 4F3B                     MOVE   B9_COLOR1,A11        ; Move register to register
FFDB8010h: 4EBE                     MOVE   B5_WSTART,A14        ; Move register to register
FFDB8020h: 4EDC                     MOVE   B6_WEND,A12          ; Move register to register
FFDB8030h: 1823                     MOVK   1h,A3                ; Move constant (5 bits)
FFDB8040h: 0960                     RETS                        ; Return from subroutine

FFDB8050h: 0000 0000 0000 0000 0000 .bss     32*2*8

FFDB8250h: 4F3B                     MOVE   B9_COLOR1,A11        ; Move register to register
FFDB8260h: CA01                     JREQ   FFDB8280h            ; Jump relative conditional
FFDB8270h: 4F1B                     MOVE   B8_COLOR0,A11        ; Move register to register
FFDB8280h: CB02                     JRNE   FFDB82B0h            ; Jump relative conditional
FFDB8290h: F165                     PIXT   A11,*A5,XY           ; Pixel transfer, register to indirect XY
FFDB82A0h: CC05                     JRV    FFDB8300h            ; Jump relative conditional
FFDB82B0h: 0D8D FFD8                DSJ    A13,FFDB8050h        ; Decrement register and skip jump
FFDB82D0h: 4F69                     MOVE   A11,B9_COLOR1        ; Move register to register
FFDB82E0h: 4CA4                     MOVE   A5,A4                ; Move register to register
FFDB82F0h: 0960                     RETS                        ; Return from subroutine

FFDB8300h: E6A1                     CPW    A5,A1                ; Compare point to window
FFDB8310h: 4001                     ADD    A0,A1                ; Add registers
FFDB8320h: 0161                     JUMP   A1                   ; Jump indirect

FFDB8330h: 0300                     NOP                         ; No operation
FFDB8340h: 0300                     NOP                         ; No operation
FFDB8350h: EDC5                     MOVX   A14,A5               ; Move X half of register
FFDB8360h: C0F2                     JR     FFDB8290h            ; Jump relative conditional

FFDB8370h: ED85                     MOVX   A12,A5               ; Move X half of register
FFDB8380h: C0F0                     JR     FFDB8290h            ; Jump relative conditional

FFDB8390h: 0300                     NOP                         ; No operation
FFDB83A0h: 0300                     NOP                         ; No operation
FFDB83B0h: EFC5                     MOVY   A14,A5               ; Move Y half of register
FFDB83C0h: C0EC                     JR     FFDB8290h            ; Jump relative conditional

FFDB83D0h: 4DC5                     MOVE   A14,A5               ; Move register to register
FFDB83E0h: C0EA                     JR     FFDB8290h            ; Jump relative conditional

FFDB83F0h: ED85                     MOVX   A12,A5               ; Move X half of register
FFDB8400h: EFC5                     MOVY   A14,A5               ; Move Y half of register
FFDB8410h: C0E7                     JR     FFDB8290h            ; Jump relative conditional

FFDB8420h: 0300                     NOP                         ; No operation
FFDB8430h: EF85                     MOVY   A12,A5               ; Move Y half of register
FFDB8440h: C0E4                     JR     FFDB8290h            ; Jump relative conditional

FFDB8450h: EDC5                     MOVX   A14,A5               ; Move X half of register
FFDB8460h: C0FC                     JR     FFDB8430h            ; Jump relative conditional

FFDB8470h: 4D85                     MOVE   A12,A5               ; Move register to register
FFDB8480h: C0E0                     JR     FFDB8290h            ; Jump relative conditional

FFDB8490h: 1FC1                     BTST   1h,A1                ; Set status on value of: bit K in Rd
FFDB84A0h: CA0C                     JREQ   FFDB8570h            ; Jump relative conditional
FFDB84B0h: 09FA 89E0 FFDB           MOVI   FFDB89E0h,B10_COUNT  ; Move immediate (32 bits)
FFDB84E0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB84F0h: 4E2E                     MOVE   A1,B14_TEMP          ; Move register to register
FFDB8500h: 261E                     SLL    10h,B14_TEMP         ; Shift left logical, constant
FFDB8510h: 2C9E                     SRL    1Ch,B14_TEMP         ; Shift right logical, constant
FFDB8520h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDB8530h: 405E                     ADD    B2_DADDR,B14_TEMP    ; Add registers
FFDB8540h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB8550h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB8560h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB8570h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDB8580h: CA0A                     JREQ   FFDB8630h            ; Jump relative conditional
FFDB8590h: 09FA 8A10 FFDB           MOVI   FFDB8A10h,B10_COUNT  ; Move immediate (32 bits)
FFDB85C0h: 4E2E                     MOVE   A1,B14_TEMP          ; Move register to register
FFDB85D0h: 269E                     SLL    14h,B14_TEMP         ; Shift left logical, constant
FFDB85E0h: 2C9E                     SRL    1Ch,B14_TEMP         ; Shift right logical, constant
FFDB85F0h: 249E                     SLL    4h,B14_TEMP          ; Shift left logical, constant
FFDB8600h: 405E                     ADD    B2_DADDR,B14_TEMP    ; Add registers
FFDB8610h: 99DB                     MOVE   *B14_TEMP+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB8620h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB8630h: 09FA 8A20 FFDB           MOVI   FFDB8A20h,B10_COUNT  ; Move immediate (32 bits)
FFDB8660h: 18DE                     MOVK   6h,B14_TEMP          ; Move constant (5 bits)
FFDB8670h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB8680h: 3C5E                     DSJS   B14_TEMP,FFDB8670h   ; Decrement register and skip jump short
FFDB8690h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP   ; Move immediate (32 bits)
FFDB86C0h: 457E                     SUB    B11_INC1,B14_TEMP    ; Subtract registers
FFDB86D0h: 161E                     SUBK   10h,B14_TEMP         ; Subtract constant (5 bits)
FFDB86E0h: 2F9E                     SRL    4h,B14_TEMP          ; Shift right logical, constant
FFDB86F0h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0 ; Move field. register to indirect (postincrement)
FFDB8700h: 4F70                     MOVE   B11_INC1,A0          ; Move register to register
FFDB8710h: 0B00 0060                ADDI   60h,A0               ; Add immediate (16 bits)
FFDB8730h: 121A                     ADDK   10h,B10_COUNT        ; Add constant (5 bits)
FFDB8740h: 1BFE                     MOVK   1Fh,B14_TEMP         ; Move constant (5 bits)
FFDB8750h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB8760h: 3C5E                     DSJS   B14_TEMP,FFDB8750h   ; Decrement register and skip jump short
FFDB8770h: 4F3B                     MOVE   B9_COLOR1,A11        ; Move register to register
FFDB8780h: 4EBE                     MOVE   B5_WSTART,A14        ; Move register to register
FFDB8790h: 4EDC                     MOVE   B6_WEND,A12          ; Move register to register
FFDB87A0h: 1823                     MOVK   1h,A3                ; Move constant (5 bits)
FFDB87B0h: E26C                     SUBXY  A3,A12               ; Subtract registers in XY mode
FFDB87C0h: 1844                     MOVK   2h,A4                ; Move constant (5 bits)
FFDB87D0h: 0960                     RETS                        ; Return from subroutine

FFDB87E0h: 0000 0000 0000 0000 0000 .bss     32*2*8

FFDB89E0h: 4F3B                     MOVE   B9_COLOR1,A11        ; Move register to register
FFDB89F0h: CA01                     JREQ   FFDB8A10h            ; Jump relative conditional
FFDB8A00h: 4F1B                     MOVE   B8_COLOR0,A11        ; Move register to register
FFDB8A10h: CB05                     JRNE   FFDB8A70h            ; Jump relative conditional
FFDB8A20h: F165                     PIXT   A11,*A5,XY           ; Pixel transfer, register to indirect XY
FFDB8A30h: CC08                     JRV    FFDB8AC0h            ; Jump relative conditional
FFDB8A40h: E065                     ADDXY  A3,A5                ; Add registers in XV mode
FFDB8A50h: F165                     PIXT   A11,*A5,XY           ; Pixel transfer, register to indirect XY
FFDB8A60h: CC1E                     JRV    FFDB8C50h            ; Jump relative conditional
FFDB8A70h: 0D8D FFD5                DSJ    A13,FFDB87E0h        ; Decrement register and skip jump
FFDB8A90h: 4F69                     MOVE   A11,B9_COLOR1        ; Move register to register
FFDB8AA0h: 4CA4                     MOVE   A5,A4                ; Move register to register
FFDB8AB0h: 0960                     RETS                        ; Return from subroutine

FFDB8AC0h: E6A1                     CPW    A5,A1                ; Compare point to window
FFDB8AD0h: 4001                     ADD    A0,A1                ; Add registers
FFDB8AE0h: 0161                     JUMP   A1                   ; Jump indirect

FFDB8AF0h: 0300                     NOP                         ; No operation
FFDB8B00h: 0300                     NOP                         ; No operation
FFDB8B10h: EDC5                     MOVX   A14,A5               ; Move X half of register
FFDB8B20h: C0EF                     JR     FFDB8A20h            ; Jump relative conditional

FFDB8B30h: ED85                     MOVX   A12,A5               ; Move X half of register
FFDB8B40h: C0ED                     JR     FFDB8A20h            ; Jump relative conditional

FFDB8B50h: 0300                     NOP                         ; No operation
FFDB8B60h: 0300                     NOP                         ; No operation
FFDB8B70h: EFC5                     MOVY   A14,A5               ; Move Y half of register
FFDB8B80h: C0E9                     JR     FFDB8A20h            ; Jump relative conditional

FFDB8B90h: 4DC5                     MOVE   A14,A5               ; Move register to register
FFDB8BA0h: C0E7                     JR     FFDB8A20h            ; Jump relative conditional

FFDB8BB0h: ED85                     MOVX   A12,A5               ; Move X half of register
FFDB8BC0h: EFC5                     MOVY   A14,A5               ; Move Y half of register
FFDB8BD0h: C0E4                     JR     FFDB8A20h            ; Jump relative conditional

FFDB8BE0h: 0300                     NOP                         ; No operation
FFDB8BF0h: EF85                     MOVY   A12,A5               ; Move Y half of register
FFDB8C00h: C0E1                     JR     FFDB8A20h            ; Jump relative conditional

FFDB8C10h: EDC5                     MOVX   A14,A5               ; Move X half of register
FFDB8C20h: C0FC                     JR     FFDB8BF0h            ; Jump relative conditional

FFDB8C30h: 4D85                     MOVE   A12,A5               ; Move register to register
FFDB8C40h: C0DD                     JR     FFDB8A20h            ; Jump relative conditional

FFDB8C50h: E285                     SUBXY  A4,A5                ; Subtract registers in XY mode
FFDB8C60h: F165                     PIXT   A11,*A5,XY           ; Pixel transfer, register to indirect XY
FFDB8C70h: C0DF                     JR     FFDB8A70h            ; Jump relative conditional

********************************************************************************
* COMMAND_24_25
********************************************************************************
COMMAND_24_25:
FFDB8C80h: 9503                     MOVE   *A8+,A3,0            ; Move field. indirect (postincrement) to register
FFDB8C90h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDB8CA0h: 9700                     MOVE   *A8+,A0,1            ; Move field. indirect (postincrement) to register
FFDB8CB0h: 950A                     MOVE   *A8+,A10,0           ; Move field. indirect (postincrement) to register
FFDB8CC0h: 1423                     DEC    A3                   ; Decrement register
FFDB8CD0h: C600 EF9B                JRLE   CMD_LOOP             ; Jump relative conditional
FFDB8CF0h: 098F 0084                MMTM   SP,A8,A13            ; If Register n is in the register list: Rn → -*Rd (repeat for n = 0 to 15)
FFDB8D10h: 4F3C                     MOVE   B9_COLOR1,A12        ; Move register to register
FFDB8D20h: 4F1E                     MOVE   B8_COLOR0,A14        ; Move register to register
FFDB8D30h: 4F40                     MOVE   A10,B0_SADDR         ; Move register to register
FFDB8D40h: 574A                     CLR    A10                  ; Clear register
FFDB8D50h: 09F1 0001 0001           MOVI   00010001h,B1_SPTCH   ; Move immediate (32 bits)
FFDB8D80h: 09E2 0000 0001           MOVI   00010000h,A2         ; Move immediate (32 bits)
FFDB8DB0h: 09FB 0000 FFDD           MOVI   FFDD0000h,B11_INC1   ; Move immediate (32 bits)
FFDB8DE0h: 4E27                     MOVE   A1,B7_DVDX           ; Move register to register
FFDB8DF0h: 2717                     SLL    18h,B7_DVDX          ; Shift left logical, constant
FFDB8E00h: 2C77                     SRL    1Dh,B7_DVDX          ; Shift right logical, constant
FFDB8E10h: 2437                     SLL    1h,B7_DVDX           ; Shift left logical, constant
FFDB8E20h: CB0B                     JRNE   FFDB8EE0h            ; Jump relative conditional
FFDB8E30h: 1A17                     MOVK   10h,B7_DVDX          ; Move constant (5 bits)
FFDB8E40h: 09FA 9480 FFDB           MOVI   FFDB9480h,B10_COUNT  ; Move immediate (32 bits)
FFDB8E70h: 4E2C                     MOVE   A1,B12_INC2          ; Move register to register
FFDB8E80h: 27BC                     SLL    1Dh,B12_INC2         ; Shift left logical, constant
FFDB8E90h: CA0D                     JREQ   FFDB8F70h            ; Jump relative conditional
FFDB8EA0h: 09FA 95D0 FFDB           MOVI   FFDB95D0h,B10_COUNT  ; Move immediate (32 bits)
FFDB8ED0h: C009                     JR     FFDB8F70h            ; Jump relative conditional

FFDB8EE0h: 09FA 95D0 FFDB           MOVI   FFDB95D0h,B10_COUNT  ; Move immediate (32 bits)
FFDB8F10h: 4E2C                     MOVE   A1,B12_INC2          ; Move register to register
FFDB8F20h: 27BC                     SLL    1Dh,B12_INC2         ; Shift left logical, constant
FFDB8F30h: CB03                     JRNE   FFDB8F70h            ; Jump relative conditional
FFDB8F40h: 09FA 9520 FFDB           MOVI   FFDB9520h,B10_COUNT  ; Move immediate (32 bits)
FFDB8F70h: 1217                     ADDK   10h,B7_DVDX          ; Add constant (5 bits)
FFDB8F80h: 955E                     MOVE   *B10_COUNT+,B14_TEMP,0 ; Move field. indirect (postincrement) to register
FFDB8F90h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB8FA0h: 3C5E                     DSJS   B14_TEMP,FFDB8F90h   ; Decrement register and skip jump short
FFDB8FB0h: 1FC1                     BTST   1h,A1                ; Set status on value of: bit K in Rd
FFDB8FC0h: CA0B                     JREQ   FFDB9080h            ; Jump relative conditional
FFDB8FD0h: 09FA 96A0 FFDB           MOVI   FFDB96A0h,B10_COUNT  ; Move immediate (32 bits)
FFDB9000h: 4C28                     MOVE   A1,A8                ; Move register to register
FFDB9010h: 2608                     SLL    10h,A8               ; Shift left logical, constant
FFDB9020h: 2C88                     SRL    1Ch,A8               ; Shift right logical, constant
FFDB9030h: 1208                     ADDK   10h,A8               ; Add constant (5 bits)
FFDB9040h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9050h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9060h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9070h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9080h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDB9090h: CA09                     JREQ   FFDB9130h            ; Jump relative conditional
FFDB90A0h: 09FA 96E0 FFDB           MOVI   FFDB96E0h,B10_COUNT  ; Move immediate (32 bits)
FFDB90D0h: 4C2D                     MOVE   A1,A13               ; Move register to register
FFDB90E0h: 268D                     SLL    14h,A13              ; Shift left logical, constant
FFDB90F0h: 2C8D                     SRL    1Ch,A13              ; Shift right logical, constant
FFDB9100h: 120D                     ADDK   10h,A13              ; Add constant (5 bits)
FFDB9110h: 1ABE                     MOVK   15h,B14_TEMP         ; Move constant (5 bits)
FFDB9120h: C004                     JR     FFDB9170h            ; Jump relative conditional

FFDB9130h: 09FA 9720 FFDB           MOVI   FFDB9720h,B10_COUNT  ; Move immediate (32 bits)
FFDB9160h: 1A3E                     MOVK   11h,B14_TEMP         ; Move constant (5 bits)
FFDB9170h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9180h: 3C5E                     DSJS   B14_TEMP,FFDB9170h   ; Decrement register and skip jump short
FFDB9190h: 193E                     MOVK   9h,B14_TEMP          ; Move constant (5 bits)
FFDB91A0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB91B0h: 3C5E                     DSJS   B14_TEMP,FFDB91A0h   ; Decrement register and skip jump short
FFDB91C0h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP   ; Move immediate (32 bits)
FFDB91F0h: 457E                     SUB    B11_INC1,B14_TEMP    ; Subtract registers
FFDB9200h: 2F9E                     SRL    4h,B14_TEMP          ; Shift right logical, constant
FFDB9210h: 161B                     SUBK   10h,B11_INC1         ; Subtract constant (5 bits)
FFDB9220h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0 ; Move field. register to indirect (postincrement)
FFDB9230h: 1B5E                     MOVK   1Ah,B14_TEMP         ; Move constant (5 bits)
FFDB9240h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9250h: 3C5E                     DSJS   B14_TEMP,FFDB9240h   ; Decrement register and skip jump short
FFDB9260h: 1D61                     BTST   14h,A1               ; Set status on value of: bit K in Rd
FFDB9270h: CA02                     JREQ   FFDB92A0h            ; Jump relative conditional
FFDB9280h: 141B                     SUBK   20h,B11_INC1         ; Subtract constant (5 bits)
FFDB9290h: 895B                     MOVE   *B10_COUNT,*B11_INC1,0 ; Move field, indirect to indirect
FFDB92A0h: 9607                     MOVE   *A0+,A7,1            ; Move field. indirect (postincrement) to register
FFDB92B0h: 4CEB                     MOVE   A7,A11               ; Move register to register
FFDB92C0h: 4CE9                     MOVE   A7,A9                ; Move register to register
FFDB92D0h: 2609                     SLL    10h,A9               ; Shift left logical, constant
FFDB92E0h: ED27                     MOVX   A9,A7                ; Move X half of register
FFDB92F0h: D717                     EXGF   B7_DVDX,1            ; Exchange field size
FFDB9300h: 0707                     SEXT   A7,1                 ; Sign extend to long
FFDB9310h: 4927                     CMP    A9,A7                ; Compare registers
FFDB9320h: C503                     JRGE   FFDB9360h            ; Jump relative conditional
FFDB9330h: 4EEA                     MOVE   A7,B10_COUNT         ; Move register to register
FFDB9340h: 4D27                     MOVE   A9,A7                ; Move register to register
FFDB9350h: 4F59                     MOVE   B10_COUNT,A9         ; Move register to register
FFDB9360h: 09FB 010E C000           MOVI   HSTCTLH+14,B11_INC1  ; Move immediate (32 bits)
FFDB9390h: 0541                     SETF   1h,0,0               ; Set field parameters
FFDB93A0h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDB93B0h: 81DB                     MOVE   B14_TEMP,*B11_INC1,0 ; Move field. register to indirect
FFDB93C0h: 81FB                     MOVE   SP,*B11_INC1,0       ; Move field. register to indirect
FFDB93D0h: 0540                     SETF   20h,0,0              ; Set field parameters
FFDB93E0h: 0D5F 0000 FFDD           CALLA  FFDD0000h            ; Call subroutine address
FFDB9410h: 0550                     SETF   10h,0,0              ; Set field parameters
FFDB9420h: 0740                     SETF   20h,0,1              ; Set field parameters
FFDB9430h: 4F89                     MOVE   A12,B9_COLOR1        ; Move register to register
FFDB9440h: 09AF 2100                MMFM   SP,A8,A13            ; If Register n is in the register list: *Rs+ → Rn (repeat for n = 0 to 15)
FFDB9460h: C000 EF22                JR     CMD_LOOP             ; Jump relative conditional

FFDB9480h: 0009                     .word  0009h
FFDB9490h: 9405                     MOVE   *A0+,A5,0            ; Move field. indirect (postincrement) to register
FFDB94A0h: 4CA6                     MOVE   A5,A6                ; Move register to register
FFDB94B0h: 2606                     SLL    10h,A6               ; Shift left logical, constant
FFDB94C0h: ECC5                     MOVX   A6,A5                ; Move X half of register
FFDB94D0h: 48C5                     CMP    A6,A5                ; Compare registers
FFDB94E0h: C503                     JRGE   FFDB9520h            ; Jump relative conditional
FFDB94F0h: 4EAA                     MOVE   A5,B10_COUNT         ; Move register to register
FFDB9500h: 4CC5                     MOVE   A6,A5                ; Move register to register
FFDB9510h: 4F56                     MOVE   B10_COUNT,A6         ; Move register to register
FFDB9520h: 000A                     .word  000Ah
FFDB9530h: 9405                     MOVE   *A0+,A5,0            ; Move field. indirect (postincrement) to register
FFDB9540h: 4CA6                     MOVE   A5,A6                ; Move register to register
FFDB9550h: 2606                     SLL    10h,A6               ; Shift left logical, constant
FFDB9560h: ECC5                     MOVX   A6,A5                ; Move X half of register
FFDB9570h: 0705                     SEXT   A5,1                 ; Sign extend to long
FFDB9580h: 48C5                     CMP    A6,A5                ; Compare registers
FFDB9590h: C503                     JRGE   FFDB95D0h            ; Jump relative conditional
FFDB95A0h: 4EAA                     MOVE   A5,B10_COUNT         ; Move register to register
FFDB95B0h: 4CC5                     MOVE   A6,A5                ; Move register to register
FFDB95C0h: 4F56                     MOVE   B10_COUNT,A6         ; Move register to register
FFDB95D0h: 000C                     .word  000Ch
FFDB95E0h: 9405                     MOVE   *A0+,A5,0            ; Move field. indirect (postincrement) to register
FFDB95F0h: 4D61                     MOVE   A11,A1               ; Move register to register
FFDB9600h: 4CAB                     MOVE   A5,A11               ; Move register to register
FFDB9610h: 4CA6                     MOVE   A5,A6                ; Move register to register
FFDB9620h: 2606                     SLL    10h,A6               ; Shift left logical, constant
FFDB9630h: ECC5                     MOVX   A6,A5                ; Move X half of register
FFDB9640h: 0705                     SEXT   A5,1                 ; Sign extend to long
FFDB9650h: 48C5                     CMP    A6,A5                ; Compare registers
FFDB9660h: C503                     JRGE   FFDB96A0h            ; Jump relative conditional
FFDB9670h: 4EAA                     MOVE   A5,B10_COUNT         ; Move register to register
FFDB9680h: 4CC5                     MOVE   A6,A5                ; Move register to register
FFDB9690h: 4F56                     MOVE   B10_COUNT,A6         ; Move register to register
FFDB96A0h: 4F89                     MOVE   A12,B9_COLOR1        ; Move register to register
FFDB96B0h: 4B01                     BTST   A8,A1                ; Test register bit, register
FFDB96C0h: CA01                     JREQ   FFDB96E0h            ; Jump relative conditional
FFDB96D0h: 4FC9                     MOVE   A14,B9_COLOR1        ; Move register to register
FFDB96E0h: 4BA1                     BTST   A13,A1               ; Test register bit, register
FFDB96F0h: CB30                     JRNE   FFDB9A00h            ; Jump relative conditional
FFDB9700h: 4BAB                     BTST   A13,A11              ; Test register bit, register
FFDB9710h: CB04                     JRNE   FFDB9760h            ; Jump relative conditional
FFDB9720h: 48A9                     CMP    A5,A9                ; Compare registers
FFDB9730h: C602                     JRLE   FFDB9760h            ; Jump relative conditional
FFDB9740h: 4CA9                     MOVE   A5,A9                ; Move register to register
FFDB9750h: E049                     ADDXY  A2,A9                ; Add registers in XV mode
FFDB9760h: 4EE7                     MOVE   A7,B7_DVDX           ; Move register to register
FFDB9770h: 4F22                     MOVE   A9,B2_DADDR          ; Move register to register
FFDB9780h: EC17                     MOVX   B0_SADDR,B7_DVDX     ; Move X half of register
FFDB9790h: EC12                     MOVX   B0_SADDR,B2_DADDR    ; Move X half of register
FFDB97A0h: E65A                     CPW    B2_DADDR,B10_COUNT   ; Compare point to window
FFDB97B0h: CC17                     JRV    FFDB9930h            ; Jump relative conditional
FFDB97C0h: E6FA                     CPW    B7_DVDX,B10_COUNT    ; Compare point to window
FFDB97D0h: CC17                     JRV    FFDB9950h            ; Jump relative conditional
FFDB97E0h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDB97F0h: CA1E                     JREQ   FFDB99E0h            ; Jump relative conditional
FFDB9800h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB9810h: E852                     CVXYL  B2_DADDR,B2_DADDR    ; Convert XY address to linear address
FFDB9820h: 0FC0                     FILL   L                    ; Fill array with processed pixels, linear
FFDB9830h: 1030                     INC    B0_SADDR             ; Increment register
FFDB9840h: 4CC9                     MOVE   A6,A9                ; Move register to register
FFDB9850h: 48E6                     CMP    A7,A6                ; Compare registers
FFDB9860h: C602                     JRLE   FFDB9890h            ; Jump relative conditional
FFDB9870h: 4CE9                     MOVE   A7,A9                ; Move register to register
FFDB9880h: E049                     ADDXY  A2,A9                ; Add registers in XV mode
FFDB9890h: 4CA7                     MOVE   A5,A7                ; Move register to register
FFDB98A0h: 0D83 FFBC                DSJ    A3,FFDB9480h         ; Decrement register and skip jump
FFDB98C0h: 4D4A                     MOVE   A10,A10              ; Move register to register
FFDB98D0h: CB04                     JRNE   FFDB9920h            ; Jump relative conditional
FFDB98E0h: 102A                     INC    A10                  ; Increment register
FFDB98F0h: 1843                     MOVK   2h,A3                ; Move constant (5 bits)
FFDB9900h: 1400                     SUBK   20h,A0               ; Subtract constant (5 bits)
FFDB9910h: C0F7                     JR     FFDB9890h            ; Jump relative conditional

FFDB9920h: 0960                     RETS                        ; Return from subroutine

FFDB9930h: E6FB                     CPW    B7_DVDX,B11_INC1     ; Compare point to window
FFDB9940h: CC04                     JRV    FFDB9990h            ; Jump relative conditional
FFDB9950h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDB9960h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDB9970h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDB9980h: C0EA                     JR     FFDB9830h            ; Jump relative conditional

FFDB9990h: 515B                     AND    B10_COUNT,B11_INC1   ; AND registers
FFDB99A0h: CAFA                     JREQ   FFDB9950h            ; Jump relative conditional
FFDB99B0h: 1F1B                     BTST   7h,B11_INC1          ; Set status on value of: bit K in Rd
FFDB99C0h: CB06                     JRNE   FFDB9A30h            ; Jump relative conditional
FFDB99D0h: EED2                     MOVY   B6_WEND,B2_DADDR     ; Move Y half of register
FFDB99E0h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY ; Pixel transfer, register to indirect XY
FFDB99F0h: C0E3                     JR     FFDB9830h            ; Jump relative conditional

FFDB9A00h: 1030                     INC    B0_SADDR             ; Increment register
FFDB9A10h: 4CC9                     MOVE   A6,A9                ; Move register to register
FFDB9A20h: C0E6                     JR     FFDB9890h            ; Jump relative conditional

FFDB9A30h: EEB2                     MOVY   B5_WSTART,B2_DADDR   ; Move Y half of register
FFDB9A40h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY ; Pixel transfer, register to indirect XY
FFDB9A50h: C0DD                     JR     FFDB9830h            ; Jump relative conditional

FFDB9A60h: 0300                     NOP                         ; No operation
********************************************************************************
* COMMAND_32_GRAPHYY_0x20
********************************************************************************
COMMAND_32_GRAPHYY_0x20:
FFDB9A70h: 9503                     MOVE   *A8+,A3,0            ; Move field. indirect (postincrement) to register
FFDB9A80h: 9701                     MOVE   *A8+,A1,1            ; Move field. indirect (postincrement) to register
FFDB9A90h: 9700                     MOVE   *A8+,A0,1            ; Move field. indirect (postincrement) to register
FFDB9AA0h: 950A                     MOVE   *A8+,A10,0           ; Move field. indirect (postincrement) to register
FFDB9AB0h: 1423                     DEC    A3                   ; Decrement register
FFDB9AC0h: C600 EEBC                JRLE   CMD_LOOP             ; Jump relative conditional
FFDB9AE0h: 098F 0084                MMTM   SP,A8,A13            ; If Register n is in the register list: Rn → -*Rd (repeat for n = 0 to 15)
FFDB9B00h: 4F3C                     MOVE   B9_COLOR1,A12        ; Move register to register
FFDB9B10h: 4F1E                     MOVE   B8_COLOR0,A14        ; Move register to register
FFDB9B20h: 4F40                     MOVE   A10,B0_SADDR         ; Move register to register
FFDB9B30h: 574A                     CLR    A10                  ; Clear register
FFDB9B40h: 09F1 0001 0001           MOVI   00010001h,B1_SPTCH   ; Move immediate (32 bits)
FFDB9B70h: 09E2 0000 0001           MOVI   00010000h,A2         ; Move immediate (32 bits)
FFDB9BA0h: 09FB 0000 FFDD           MOVI   FFDD0000h,B11_INC1   ; Move immediate (32 bits)
FFDB9BD0h: 09FA A1B0 FFDB           MOVI   FFDBA1B0h,B10_COUNT  ; Move immediate (32 bits)
FFDB9C00h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9C10h: 4E2C                     MOVE   A1,B12_INC2          ; Move register to register
FFDB9C20h: 27BC                     SLL    1Dh,B12_INC2         ; Shift left logical, constant
FFDB9C30h: CA02                     JREQ   FFDB9C60h            ; Jump relative conditional
FFDB9C40h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9C50h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9C60h: 4E27                     MOVE   A1,B7_DVDX           ; Move register to register
FFDB9C70h: 2717                     SLL    18h,B7_DVDX          ; Shift left logical, constant
FFDB9C80h: 2C77                     SRL    1Dh,B7_DVDX          ; Shift right logical, constant
FFDB9C90h: 2437                     SLL    1h,B7_DVDX           ; Shift left logical, constant
FFDB9CA0h: CB01                     JRNE   FFDB9CC0h            ; Jump relative conditional
FFDB9CB0h: 1A17                     MOVK   10h,B7_DVDX          ; Move constant (5 bits)
FFDB9CC0h: 09FA A1E0 FFDB           MOVI   FFDBA1E0h,B10_COUNT  ; Move immediate (32 bits)
FFDB9CF0h: 4CFC                     MOVE   B7_DVDX,B12_INC2     ; Move register to register
FFDB9D00h: 145C                     SUBK   2h,B12_INC2          ; Subtract constant (5 bits)
FFDB9D10h: 249C                     SLL    4h,B12_INC2          ; Shift left logical, constant
FFDB9D20h: 419A                     ADD    B12_INC2,B10_COUNT   ; Add registers
FFDB9D30h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9D40h: 4CFC                     MOVE   B7_DVDX,B12_INC2     ; Move register to register
FFDB9D50h: 279C                     SLL    1Ch,B12_INC2         ; Shift left logical, constant
FFDB9D60h: CA01                     JREQ   FFDB9D80h            ; Jump relative conditional
FFDB9D70h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9D80h: 1FC1                     BTST   1h,A1                ; Set status on value of: bit K in Rd
FFDB9D90h: CA0A                     JREQ   FFDB9E40h            ; Jump relative conditional
FFDB9DA0h: 09FA A2D0 FFDB           MOVI   FFDBA2D0h,B10_COUNT  ; Move immediate (32 bits)
FFDB9DD0h: 4C28                     MOVE   A1,A8                ; Move register to register
FFDB9DE0h: 2608                     SLL    10h,A8               ; Shift left logical, constant
FFDB9DF0h: 2C88                     SRL    1Ch,A8               ; Shift right logical, constant
FFDB9E00h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9E10h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9E20h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9E30h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9E40h: 1FE1                     BTST   0h,A1                ; Set status on value of: bit K in Rd
FFDB9E50h: CA08                     JREQ   FFDB9EE0h            ; Jump relative conditional
FFDB9E60h: 09FA A310 FFDB           MOVI   FFDBA310h,B10_COUNT  ; Move immediate (32 bits)
FFDB9E90h: 4C2D                     MOVE   A1,A13               ; Move register to register
FFDB9EA0h: 268D                     SLL    14h,A13              ; Shift left logical, constant
FFDB9EB0h: 2C8D                     SRL    1Ch,A13              ; Shift right logical, constant
FFDB9EC0h: 1ABE                     MOVK   15h,B14_TEMP         ; Move constant (5 bits)
FFDB9ED0h: C004                     JR     FFDB9F20h            ; Jump relative conditional

FFDB9EE0h: 09FA A350 FFDB           MOVI   FFDBA350h,B10_COUNT  ; Move immediate (32 bits)
FFDB9F10h: 1A3E                     MOVK   11h,B14_TEMP         ; Move constant (5 bits)
FFDB9F20h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9F30h: 3C5E                     DSJS   B14_TEMP,FFDB9F20h   ; Decrement register and skip jump short
FFDB9F40h: 193E                     MOVK   9h,B14_TEMP          ; Move constant (5 bits)
FFDB9F50h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDB9F60h: 3C5E                     DSJS   B14_TEMP,FFDB9F50h   ; Decrement register and skip jump short
FFDB9F70h: 09FE 0000 FFDD           MOVI   FFDD0000h,B14_TEMP   ; Move immediate (32 bits)
FFDB9FA0h: 457E                     SUB    B11_INC1,B14_TEMP    ; Subtract registers
FFDB9FB0h: 2F9E                     SRL    4h,B14_TEMP          ; Shift right logical, constant
FFDB9FC0h: 161B                     SUBK   10h,B11_INC1         ; Subtract constant (5 bits)
FFDB9FD0h: 91DB                     MOVE   B14_TEMP,*B11_INC1+,0 ; Move field. register to indirect (postincrement)
FFDB9FE0h: 1B5E                     MOVK   1Ah,B14_TEMP         ; Move constant (5 bits)
FFDB9FF0h: 995B                     MOVE   *B10_COUNT+,*B11_INC1+,0 ; Move field, indirect (postincrement) to indirect (postincrement)
FFDBA000h: 3C5E                     DSJS   B14_TEMP,FFDB9FF0h   ; Decrement register and skip jump short
FFDBA010h: 1D61                     BTST   14h,A1               ; Set status on value of: bit K in Rd
FFDBA020h: CA02                     JREQ   FFDBA050h            ; Jump relative conditional
FFDBA030h: 141B                     SUBK   20h,B11_INC1         ; Subtract constant (5 bits)
FFDBA040h: 895B                     MOVE   *B10_COUNT,*B11_INC1,0 ; Move field, indirect to indirect
FFDBA050h: 9407                     MOVE   *A0+,A7,0            ; Move field. indirect (postincrement) to register
FFDBA060h: 4CEB                     MOVE   A7,A11               ; Move register to register
FFDBA070h: D717                     EXGF   B7_DVDX,1            ; Exchange field size
FFDBA080h: 0707                     SEXT   A7,1                 ; Sign extend to long
FFDBA090h: 2607                     SLL    10h,A7               ; Shift left logical, constant
FFDBA0A0h: 4CE9                     MOVE   A7,A9                ; Move register to register
FFDBA0B0h: 09FB 010E C000           MOVI   HSTCTLH+14,B11_INC1  ; Move immediate (32 bits)
FFDBA0E0h: 0741                     SETF   1h,0,1               ; Set field parameters
FFDBA0F0h: 183E                     MOVK   1h,B14_TEMP          ; Move constant (5 bits)
FFDBA100h: 83DB                     MOVE   B14_TEMP,*B11_INC1,1 ; Move field. register to indirect
FFDBA110h: 83FB                     MOVE   SP,*B11_INC1,1       ; Move field. register to indirect
FFDBA120h: 0D5F 0000 FFDD           CALLA  FFDD0000h            ; Call subroutine address
FFDBA150h: 0740                     SETF   20h,0,1              ; Set field parameters
FFDBA160h: 4F89                     MOVE   A12,B9_COLOR1        ; Move register to register
FFDBA170h: 09AF 2100                MMFM   SP,A8,A13            ; If Register n is in the register list: *Rs+ → Rn (repeat for n = 0 to 15)
FFDBA190h: C000 EE4F                JR     CMD_LOOP             ; Jump relative conditional

FFDBA1B0h: 9405                     MOVE   *A0+,A5,0            ; Move field. indirect (postincrement) to register
FFDBA1C0h: 4D61                     MOVE   A11,A1               ; Move register to register
FFDBA1D0h: 4CAB                     MOVE   A5,A11               ; Move register to register
FFDBA1E0h: 27C5                     SLL    1Eh,A5               ; Shift left logical, constant
FFDBA1F0h: 2A45                     SRA    Eh,A5                ; Shift right arithmetic, constant
FFDBA200h: 2785                     SLL    1Ch,A5               ; Shift left logical, constant
FFDBA210h: 2A85                     SRA    Ch,A5                ; Shift right arithmetic, constant
FFDBA220h: 2745                     SLL    1Ah,A5               ; Shift left logical, constant
FFDBA230h: 2AC5                     SRA    Ah,A5                ; Shift right arithmetic, constant
FFDBA240h: 2705                     SLL    18h,A5               ; Shift left logical, constant
FFDBA250h: 2B05                     SRA    8h,A5                ; Shift right arithmetic, constant
FFDBA260h: 26C5                     SLL    16h,A5               ; Shift left logical, constant
FFDBA270h: 2B45                     SRA    6h,A5                ; Shift right arithmetic, constant
FFDBA280h: 2685                     SLL    14h,A5               ; Shift left logical, constant
FFDBA290h: 2B85                     SRA    4h,A5                ; Shift right arithmetic, constant
FFDBA2A0h: 2645                     SLL    12h,A5               ; Shift left logical, constant
FFDBA2B0h: 2BC5                     SRA    2h,A5                ; Shift right arithmetic, constant
FFDBA2C0h: 2605                     SLL    10h,A5               ; Shift left logical, constant
FFDBA2D0h: 4F89                     MOVE   A12,B9_COLOR1        ; Move register to register
FFDBA2E0h: 4B01                     BTST   A8,A1                ; Test register bit, register
FFDBA2F0h: CA01                     JREQ   FFDBA310h            ; Jump relative conditional
FFDBA300h: 4FC9                     MOVE   A14,B9_COLOR1        ; Move register to register
FFDBA310h: 4BA1                     BTST   A13,A1               ; Test register bit, register
FFDBA320h: CB30                     JRNE   FFDBA630h            ; Jump relative conditional
FFDBA330h: 4BAB                     BTST   A13,A11              ; Test register bit, register
FFDBA340h: CB04                     JRNE   FFDBA390h            ; Jump relative conditional
FFDBA350h: 48A9                     CMP    A5,A9                ; Compare registers
FFDBA360h: C602                     JRLE   FFDBA390h            ; Jump relative conditional
FFDBA370h: 4CA9                     MOVE   A5,A9                ; Move register to register
FFDBA380h: E049                     ADDXY  A2,A9                ; Add registers in XV mode
FFDBA390h: 4EE7                     MOVE   A7,B7_DVDX           ; Move register to register
FFDBA3A0h: 4F22                     MOVE   A9,B2_DADDR          ; Move register to register
FFDBA3B0h: EC17                     MOVX   B0_SADDR,B7_DVDX     ; Move X half of register
FFDBA3C0h: EC12                     MOVX   B0_SADDR,B2_DADDR    ; Move X half of register
FFDBA3D0h: E65A                     CPW    B2_DADDR,B10_COUNT   ; Compare point to window
FFDBA3E0h: CC17                     JRV    FFDBA560h            ; Jump relative conditional
FFDBA3F0h: E6FA                     CPW    B7_DVDX,B10_COUNT    ; Compare point to window
FFDBA400h: CC17                     JRV    FFDBA580h            ; Jump relative conditional
FFDBA410h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDBA420h: CA1E                     JREQ   FFDBA610h            ; Jump relative conditional
FFDBA430h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDBA440h: E852                     CVXYL  B2_DADDR,B2_DADDR    ; Convert XY address to linear address
FFDBA450h: 0FC0                     FILL   L                    ; Fill array with processed pixels, linear
FFDBA460h: 1030                     INC    B0_SADDR             ; Increment register
FFDBA470h: 4CA9                     MOVE   A5,A9                ; Move register to register
FFDBA480h: 48E9                     CMP    A7,A9                ; Compare registers
FFDBA490h: C602                     JRLE   FFDBA4C0h            ; Jump relative conditional
FFDBA4A0h: 4CE9                     MOVE   A7,A9                ; Move register to register
FFDBA4B0h: E049                     ADDXY  A2,A9                ; Add registers in XV mode
FFDBA4C0h: 4CA7                     MOVE   A5,A7                ; Move register to register
FFDBA4D0h: 0D83 FFCC                DSJ    A3,FFDBA1B0h         ; Decrement register and skip jump
FFDBA4F0h: 4D4A                     MOVE   A10,A10              ; Move register to register
FFDBA500h: CB04                     JRNE   FFDBA550h            ; Jump relative conditional
FFDBA510h: 102A                     INC    A10                  ; Increment register
FFDBA520h: 1843                     MOVK   2h,A3                ; Move constant (5 bits)
FFDBA530h: 1600                     SUBK   10h,A0               ; Subtract constant (5 bits)
FFDBA540h: C0F7                     JR     FFDBA4C0h            ; Jump relative conditional

FFDBA550h: 0960                     RETS                        ; Return from subroutine

FFDBA560h: E6FB                     CPW    B7_DVDX,B11_INC1     ; Compare point to window
FFDBA570h: CC04                     JRV    FFDBA5C0h            ; Jump relative conditional
FFDBA580h: E257                     SUBXY  B2_DADDR,B7_DVDX     ; Subtract registers in XY mode
FFDBA590h: E037                     ADDXY  B1_SPTCH,B7_DVDX     ; Add registers in XV mode
FFDBA5A0h: 0FE0                     FILL   XY                   ; Fill array with processed pixels, XY
FFDBA5B0h: C0EA                     JR     FFDBA460h            ; Jump relative conditional

FFDBA5C0h: 515B                     AND    B10_COUNT,B11_INC1   ; AND registers
FFDBA5D0h: CAFA                     JREQ   FFDBA580h            ; Jump relative conditional
FFDBA5E0h: 1F1B                     BTST   7h,B11_INC1          ; Set status on value of: bit K in Rd
FFDBA5F0h: CB06                     JRNE   FFDBA660h            ; Jump relative conditional
FFDBA600h: EED2                     MOVY   B6_WEND,B2_DADDR     ; Move Y half of register
FFDBA610h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY ; Pixel transfer, register to indirect XY
FFDBA620h: C0E3                     JR     FFDBA460h            ; Jump relative conditional

FFDBA630h: 1030                     INC    B0_SADDR             ; Increment register
FFDBA640h: 4CA9                     MOVE   A5,A9                ; Move register to register
FFDBA650h: C0E6                     JR     FFDBA4C0h            ; Jump relative conditional

FFDBA660h: EEB2                     MOVY   B5_WSTART,B2_DADDR   ; Move Y half of register
FFDBA670h: F132                     PIXT   B9_COLOR1,*B2_DADDR,XY ; Pixel transfer, register to indirect XY
FFDBA680h: C0DD                     JR     FFDBA460h            ; Jump relative conditional

FFDBA690h: 0300                     NOP                         ; No operation

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
