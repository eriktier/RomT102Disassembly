#ifndef MemVars
#include	"memvar.inc"
#endif
	
    org 0000H
; ======================================================
; Reset Vector
; ======================================================
        JMP  L1BA7H    ; Different from M100: Jump to boot routine
	
    org 0003H
    DB  "MENU",00H
	
    org 0008H
; ======================================================
; Compare next byte with M
; ======================================================
        MOV  A,M        ; Get byte from (HL)
        XTHL           ; Get address of next inst. from stack
        CMP  M          ; Compare with expected code byte
        JNZ  ERRSYN     ; Generate Syntax error if no match
        INX  H          ; Increment past the compare byte
        XTHL           ; Put new return address on stack
	
; Fall through to get next BASIC instruction. The code above is
; used to parse the validity of BASIC statements.
	
    org 0010H
; ======================================================
; Get next non-white char from M
; ======================================================
        JMP  L0858H      ; RST 10H routine with pre-increment of HL
	
	
    org 0010H
; ======================================================
; Load pointer to Storage of TEXT Line Starts in DE
; ======================================================
        XCHG
        LHLD F6EBH     ; Storage of TEXT Line Starts
        XCHG
	
	
    org 0010H
; ======================================================
; Compare DE and HL
; ======================================================
        MOV  A,H        ; Compare MSB first to test <>
        SUB  D          ; Compare with D
        RNZ            ; Return if not equal
        MOV  A,L        ; Prepare to test LSB
        SUB  E          ; Compare with E
        RET
	
    org 001EH
; ======================================================
; VRVIDFSend a space to screen/printer
; ======================================================
        MVI  A,20H      ; Load SPACE into A
	
	
    org 0020H
; ======================================================
; Send character in A to screen/printer
; ======================================================
        JMP  LCD      ; Send A to screen or printer
        NOP
	
	
    org 0024H
; ======================================================
; Power down TRAP
; ======================================================
        JMP  VLPSIH      ; RAM vector for TRAP interrupt
        NOP
	
	
    org 0028H
; ======================================================
; Determine type of last var used
; ======================================================
        JMP  L1069H      ; RST 28H routine
        NOP
	
	
    org 002CH
; ======================================================
; RST 5.5 -- Bar Code Reader
; ======================================================
        DI
        JMP  VBCRIH      ; RST 5.5 RAM Vector
	
    
    org 0030H
; ======================================================
; Get sign of FAC1
; ======================================================
        JMP  L33DCH      ; RST 30H routine
        NOP
	
    org 0034H
; ======================================================
; RST 6.5 -- RS232 character pending
; ======================================================
        DI
        JMP  L6DACH      ; RST 6.5 routine (RS232 receive interrupt)
	
	
    org 0038H
; ======================================================
; RAM vector table driver
; ======================================================
        JMP  L7FD6H      ; RST 38H RAM vector driver routine
        NOP
	
	
    org 003CH
; ======================================================
; RST 7.5 -- Timer background task
; ======================================================
        DI
        JMP  L1B32H      ; RST 7.5 interrupt routine
	
	
    org 0040H
; ======================================================
; Function vector table for SGN to MID$
; ======================================================
    DW   3407H,3654H,33F2H,2B4CH
    DW   1100H,10C8H,10CEH,305AH
    DW   313EH,2FCFH,30A4H,2EEFH
    DW   2F09H,2F58H,2F71H,1284H
    DW   1889H,506DH,506BH,3501H
    DW   352AH,35BAH,3645H,2943H
    DW   273AH,2A07H,294FH,295FH
    DW   298EH,29ABH,29DCH,29E6H
	
    org 0080H
; ======================================================
; BASIC statement keyword table END to NEW
; ======================================================
    DB   80H or 'E',"ND"        ; 0
    DB   80H or 'F',"OR"
    DB   80H or 'N',"EXT"
    DB   80H or 'D',"ATA"
    DB   80H or 'I',"NPUT"
    DB   80H or 'D',"IM"        ; 5
    DB   80H or 'R',"EAD"
    DB   80H or 'L',"ET"
    DB   80H or 'G',"OTO"
    DB   80H or 'R',"UN"
    DB   80H or 'I',"F"         ; 10
    DB   80H or 'R',"ESTORE"
    DB   80H or 'G',"OSUB"
    DB   80H or 'R',"ETURN"
    DB   80H or 'R',"EM"
    DB   80H or 'S',"TOP"       ; 15
    DB   80H or 'W',"IDTH"
    DB   80H or 'E',"LSE"
    DB   80H or 'L',"INE"
    DB   80H or 'E',"DIT"
    DB   80H or 'E',"RROR"      ; 20
    DB   80H or 'R',"ESUME"
    DB   80H or 'O',"UT"
    DB   80H or 'O',"N"
    DB   80H or 'D',"SKO$"
    DB   80H or 'O',"PEN"       ; 25
    DB   80H or 'C',"LOSE"
    DB   80H or 'L',"OAD"
    DB   80H or 'M',"ERGE"
    DB   80H or 'F',"ILES"
    DB   80H or 'S',"AVE"       ; 30
    DB   80H or 'L',"FILES"
    DB   80H or 'L',"PRINT"
    DB   80H or 'D',"EF"
    DB   80H or 'P',"OKE"
    DB   80H or 'P',"RINT"      ; 35
    DB   80H or 'C',"ONT"
    DB   80H or 'L',"IST"
    DB   80H or 'L',"LIST"
    DB   80H or 'C',"LEAR"
    DB   80H or 'C',"LOAD"      ; 40
    DB   80H or 'C',"SAVE"
    DB   80H or 'T',"IME$"
    DB   80H or 'D',"ATE$"
    DB   80H or 'D',"AY$"
    DB   80H or 'C',"OM"        ; 45
    DB   80H or 'M',"DM"
    DB   80H or 'K',"EY"
    DB   80H or 'C',"LS"
    DB   80H or 'B',"EEP"
    DB   80H or 'S',"OUND"      ; 50
    DB   80H or 'L',"COPY"
    DB   80H or 'P',"SET"
    DB   80H or 'P',"RESET"
    DB   80H or 'M',"OTOR"
    DB   80H or 'M',"AX"        ; 55
    DB   80H or 'P',"OWER"
    DB   80H or 'C',"ALL"
    DB   80H or 'M',"ENU"
    DB   80H or 'I',"PL"
    DB   80H or 'N',"AME"       ; 60
    DB   80H or 'K',"ILL"
    DB   80H or 'S',"CREEN"
    DB   80H or 'N',"EW"
	
    org 018FH
; ======================================================
; Function keyword table TAB to <
; ======================================================
    DB   80H or 'T',"AB("
    DB   80H or 'T',"O"         ; 65
    DB   80H or 'U',"SING"
    DB   80H or 'V',"ARPTR"
    DB   80H or 'E',"RL"
    DB   80H or 'E',"RR"
    DB   80H or 'S',"TRING$"    ; 70
    DB   80H or 'I',"NSTR"
    DB   80H or 'D',"SKI$"
    DB   80H or 'I',"NKEY$"
    DB   80H or 'C',"SRLIN"
    DB   80H or 'O',"FF"        ; 75
    DB   80H or 'H',"IMEM"
    DB   80H or 'T',"HEN"
    DB   80H or 'N',"OT"
    DB   80H or 'S',"TEP"
    DB   80H or '+'             ; 80
    DB   80H or '-'
    DB   80H or '*'
    DB   80H or '/'
    DB   80H or '^'
    DB   80H or 'A',"ND"        ; 85
    DB   80H or 'O',"R"
    DB   80H or 'X',"OR"
    DB   80H or 'E',"QV"
    DB   80H or 'I',"MP"
    DB   80H or 'M',"OD"        ; 90
    DB   80H or '\'
    DB   80H or '>'
    DB   80H or '='
    DB   80H or '<'
	
    org 01F0H
; ======================================================
; Function keyword table SGN to MID$
; ======================================================
    DB   80H or 'S',"GN"        ; 95
    DB   80H or 'I',"NT"
    DB   80H or 'A',"BS"
    DB   80H or 'F',"RE"
    DB   80H or 'I',"NP"
    DB   80H or 'L',"POS"       ; 100
    DB   80H or 'P',"OS"
    DB   80H or 'S',"QR"
    DB   80H or 'R',"ND"
    DB   80H or 'L',"OG"
    DB   80H or 'E',"XP"        ; 105
    DB   80H or 'C',"OS"
    DB   80H or 'S',"IN"
    DB   80H or 'T',"AN"
    DB   80H or 'A',"TN"
    DB   80H or 'P',"EEK"       ; 110
    DB   80H or 'E',"OF"
    DB   80H or 'L',"OC"
    DB   80H or 'L',"OF"
    DB   80H or 'C',"INT"
    DB   80H or 'C',"SNG"       ; 115
    DB   80H or 'C',"DBL"
    DB   80H or 'F',"IX"
    DB   80H or 'L',"EN"
    DB   80H or 'S',"TR$"
    DB   80H or 'V',"AL"        ; 120
    DB   80H or 'A',"SC"
    DB   80H or 'C',"HR$"
    DB   80H or 'S',"PACE$"
    DB   80H or 'L',"EFT$"
    DB   80H or 'R',"IGHT$"     ; 125
    DB   80H or 'M',"ID$"
    DB   80H or "'"             ; 127
    DB   80H
	
    org 0262H
; ======================================================
; BASIC statement vector table for END to NEW
; ======================================================
    DW   409FH,0726H,4174H,099EH
    DW   0CA3H,478BH,0CD9H,09C3H
    DW   0936H,090FH,0B1AH,407FH
    DW   091EH,0966H,09A0H,409AH
    DW   1DC3H,09A0H,0C45H,5E51H
    DW   0B0FH,0AB0H,110CH,0A2FH
    DW   5071H,4CCBH,4E28H,4D70H
    DW   4D71H,1F3AH,4DCFH,506FH
    DW   0B4EH,0872H,128BH,0B56H
    DW   40DAH,1140H,113BH,40F9H
    DW   2377H,2280H,19ABH,19BDH
    DW   19F1H,1A9EH,1A9EH,1BB8H
    DW   4231H,4229H,1DC5H,1E5EH
    DW   1C57H,1C66H,1DECH,7F0BH
    DW   1419H,1DFAH,5797H,1A78H
    DW   2037H,1F91H,1E22H,20FEH
	
    org 02E2H
; ======================================================
; Operator order of precedence table
; ======================================================
    DB   79H, 79H, 7CH, 7CH
    DB   7FH, 50H, 46H, 3CH
    DB   32H, 28H, 7AH, 7BH
    DB   BAH, 35H, 00H, 00H
	
    org 02F2H
; ======================================================
; Vector table for math operations
; ======================================================
    DW   3501H,35D9H
    DW   352AH,2B78H,2B69H,2CFFH
    DW   2DC7H,3D8EH,34FAH,37F4H
    DW   37FDH,3803H,380EH,3D7FH
    DW   3498H,3704H,36F8H,3725H
    DW   0F0DH,3DF7H,34C2H
	
    org 031CH
; ======================================================
; BASIC error message text
; ======================================================
    DB   "NF"
    DB   "SN"
    DB   "RG"
    DB   "OD"
    DB   "FC"
    DB   "OV"
    DB   "OM"
    DB   "UL"
    DB   "BS"
    DB   "DD"
    DB   "/0"
    DB   "ID"
    DB   "TM"
    DB   "OS"
    DB   "LS"
    DB   "ST"
    DB   "CN"
    DB   "IO"
    DB   "NR"
    DB   "RW"
    DB   "UE"
    DB   "MO"
    DB   "IE"
    DB   "BN"
    DB   "FF"
    DB   "AO"
    DB   "EF"
    DB   "NM"
    DB   "DS"
    DB   "FL"
    DB   "CF"
	
; ======================================================
; L035AH: Initialization image loaded to F5F0H
; ======================================================
    DB   4DH            ; LSB of COLD vs WARM boot marker (at address VSSYS)
    DB   8AH            ; MSB of COLD vs WARM boot marker
    DB   00H            ; Auto PowerDown signature LSB (at address VSPOPD)
    DB   00H            ; Auto PowerDown signature MSB
    DB   F0H            ; LSB of HIMEM (VHIMEM)
    DB   F5H            ; MSB of HIMEM
    RET                 ; This RET can be changed to JMP to hook Boot-up (VPWONH)
    NOP                 ; Space for address for JMP
    NOP
    EI                  ; This is the hook for WAND (VBCRIH) (RST 5.5)
    RET                 ; Replace EI, RET, NOP with a JMP instruction
    NOP
    RET                 ; This is the RST 6.5 routine (RS232 receive interrupt) hook (VUARTH)
    NOP                 ; Replace RET, NOP, NOP with a JMP instruction
    NOP
    RET                 ; This is the RST 7.5 hook (Background tick)  (VTLINH)
    NOP
    NOP
    JMP L1431H          ; Normal TRAP (low power) interrupt routine - Hook at VLPSIH
	
	
    org 036FH
; ======================================================
; External ROM detect image loaded at F605H
; ======================================================
    DB   3EH,01H,D3H,E8H,21H,40H,00H,11H  ; F605H - MVI A,01H;  OUT E8H; LXI H,L0040H;  LXI D,FAA4H
    DB   A4H,FAH,7EH,12H,23H,13H,7DH,D6H  ; F60DH - MVI A,M;    STAX D;  INX H; INX D; MOV A,L; SUI 48H
    DB   48H,C2H,0FH,F6H,D3H,E8H,2AH,A4H  ; F515H - JNZ F60FH;  OUT E8H; LHLD FAA4H;   
    DB   FAH,11H,41H,42H,C3H,18H,00H,F3H  ; F61DH - LXI D,L4142H; JMP 0018H;     DI;     ; Different from M100
    DB   3EH,01H,D3H,E8H,C7H,00H,01H,00H  ; F625H - MVI A,01H;  OUT E8H; RST 0
    DB   00H,FFH,FFH,00H,00H,00H,00H,00H  ; F62DH \
    DB   00H,00H,00H,00H,01H,01H,08H,28H  ; F635H  \
    DB   00H,00H,00H,01H,01H,01H,01H,19H  ; F63DH   \
    DB   28H,00H,00H,00H,50H,38H,30H,00H  ; F645H    \
    DB   00H,00H,00H,00H,00H,00H,00H,00H  ; F64DH     \ Initialized Data space at F6XXH
    DB   00H,00H,64H,FFH,00H,00H,4DH,37H  ; F655H    /
    DB   49H,31H,44H,C3H,00H,00H,00H,C9H  ; F65DH   /     ; Different from M100
    DB   00H,C9H,D3H,00H,C9H,DBH,00H,C9H  ; F665H  /
    DB   3AH,00H,00H,00H,00H,00H,00H,00H  ; F66DH /
    DB   00H,0EH,00H,15H,FDH,FEH,FFH,B2H  ; F675H
    DB   FCH,00H,00H
	
	
    org 03EAH
; ======================================================
; BASIC message strings
; ======================================================
    DB   " Error",00H
    DB   " in ",00H
    DB   "Ok",0DH,0AH,00H
    DB   "Break",00H
	
	
; ======================================================
; L0401H: Pop return address for NEXT or RETURN
; ======================================================
POPRET: LXI  H,L0004H   ; Prepare to point to BASIC token in stack
        DAD  SP         ; Offset into stack
NXTLVL: MOV  A,M        ; Load BASIC token that caused the push (FOR or GOSUB)
        INX  H          ; Increment back in stack past token
        CPI  81H        ; Test for FOR token
        RNZ             ; Return if not FOR token
        MOV  C,M
        INX  H
        MOV  B,M
        INX  H
        PUSH H
        MOV  H,B
        MOV  L,C
        MOV  A,D
        ORA  E
        XCHG
        JZ   L0419
        XCHG
        RST  3          ; Compare DE and HL
L0419:  LXI  B,L0016H   ; TODO: find better name
        POP  H
        RZ
        DAD  B
        JMP  NXTLVL     ; Jump to test next level of FOR/GOSUB
	
; ======================================================
; L0422H: Initialize system and go to BASIC ready
; ======================================================
        LXI  B,L0501H   ; Pop stack and vector to BASIC ready
        JMP  L048DH     ; Restore stack & runtime and jump to BC
	
; ======================================================
; L0428H: Normal end of program reached
; ======================================================
ENDPRG: LHLD F67AH      ; Current executing line number
        MOV  A,H        ; Get MSB of executing line number
        ANA  L          ; AND LSB of executing line number
        INR  A          ; Test if executing line number is FFFFh
        JZ   LNFFFF     ; Jump if executing line number is FFFFh
        LDA  FBA7H      ; BASIC Program Running Flag
        ORA  A          ; Test if program running
        MVI  E,13H      ; Load code for NR Error (No RESUME)
        JNZ  L045DH     ; Generate error in E if program running
LNFFFF: JMP  L40B6H     ; Branch into middle of "END" statement
	
; ======================================================
; L043DH: Never CALLed.  Maybe used by OptROMS?
; ======================================================
        JMP  L045DH     ; Generate error in E   TODO: find out if this is ever reached
	
; ======================================================
; L0440H: Generate SN error on DATA statement line
; ======================================================
GERRSN: LHLD FB94H      ; Line number of current data statement
        SHLD F67AH      ; Current executing line number
	
; ======================================================
; L0446H: Generate Syntax error
; ======================================================
ERRSYN: MVI  E,02H      ; Load value for SN Error  TODO: examine this, it doesn't make sense
        DB   01H
        MVI  E,0BH      ; Load value for /0 Error
        DB   01H
        MVI  E,01H      ; Load value for NF Error
        DB   01H
        MVI  E,0AH      ; Load value for DD Error
        DB   01H
        MVI  E,14H      ; Load value for RW Error
        DB   01H
        MVI  E,06H      ; Load value for OV Error
        DB   01H
        MVI  E,16H      ; Load value for MO Error
        DB   01H
        MVI  E,0DH      ; Load value for TM Error 
	
; ======================================================
; Generate error in E
; ======================================================
L045DH:	XRA   A         
	STA   FCA7H     
	LHLD  F67EH     
	MOV   A,H       
	ORA   L         
	JZ    L0473H    
	LDA   FBE6H     
	MOV   M,A       
	LXI   H,0000H  
	SHLD  F67EH     
L0473H:	EI              
	LHLD  F652H     ; Load ON ERROR handler address (may be zero)
	PUSH  H         ; Push ON ERROR handler address to stack
	MOV   A,H       ; Get MSB of handler address
	ORA   L         ; OR with LSB of handler address
	RNZ             ; RETurn to handler if not zero
	LHLD  F67AH     ; Current executing line number
	SHLD  FB9FH     ; Line number of last error
	MOV   A,H       ; Move LSB of address of line number to A
	ANA   L         ; AND with MSB of address
	INR   A         ; Increment it test for FFFFH
	JZ    L048AH    ; Skip saving as most recent line # if FFFFH
	SHLD  FBA1H     ; Most recent used or entered line number
L048AH:	LXI   B,L0493H  ; Load address of ERROR print routine in BC
	
; ======================================================
; Restore stack & runtime and jump to BC
; ======================================================
L048DH:	LHLD  FB9DH     ; SP used by BASIC to reinitialize the stack
	JMP   L3F78H    ; Jump into BASIC initialize routine
	
; ======================================================
; Generate Error in E Print routine
; ======================================================
L0493H:	POP   B         
	MOV   A,E       
	MOV   C,E       
	STA   F672H     ; Last Error code
	LHLD  FB9BH     ; Most recent or currently running line pointer
	SHLD  FBA3H     ; Pointer to occurrence of error
	XCHG            
	LHLD  FB9FH     ; Line number of last error
	MOV   A,H       
	ANA   L         
	INR   A         
	JZ    L04B6H    
	SHLD  FBAAH     ; Line where break, END, or STOP occurred
	XCHG            
	SHLD  FBACH     ; Address where program stopped on last break, END, or STOP
	LHLD  FBA5H     ; Address of ON ERROR routine
	MOV   A,H       
	ORA   L         
	XCHG            
L04B6H:	LXI   H,FBA7H   ; BASIC Program Running Flag
	JZ    L04C5H    ; Print BASIC error message - XX error in XXX
	ANA   M         
	JNZ   L04C5H    ; Print BASIC error message - XX error in XXX
	DCR   M         
	XCHG            
	JMP   L082BH    
	
; ======================================================
; Print BASIC error message - XX error in XXX
; ======================================================
L04C5H:	XRA   A         
	MOV   M,A       
	MOV   E,C       
	CALL  L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	MOV   A,E       
	CPI   3BH       
	JNC   L04DBH    
	CPI   32H       
	JNC   L04DDH    
	CPI   17H       
	JC    L04E0H    
L04DBH:	MVI   A,30H     
L04DDH:	SUI   1BH       
	MOV   E,A       
L04E0H:	MVI   D,00H     
	LXI   H,L031AH  ; BASIC error message text
	DAD   D         
	DAD   D         
	MVI   A,3FH     
	RST   4         ; Send character in A to screen/printer
	MOV   A,M       
	RST   4         ; Send character in A to screen/printer
	RST   2         ; Get next non-white char from M
	RST   4         ; Send character in A to screen/printer
	LXI   H,L03EAH  ; BASIC message strings
	PUSH  H         
	LHLD  FB9FH     ; Line number of last error
	XTHL            
L04F6H:	CALL  L27B1H    ; Print buffer at M until NULL or '"'
	POP   H         
	MOV   A,H       
	ANA   L         
	INR   A         
	CNZ   L39CCH    ; Finish printing BASIC ERROR message " in " line #
L0500H:
    DB	3EH             ; Makes "POP B" below look like "MVI A,C1H"
	
; ======================================================
; Pop stack and vector to BASIC ready
; ======================================================
L0501H:	POP   B         ; Cleanup stack
	
; ======================================================
; Vector to BASIC ready - print Ok
; ======================================================
L0502H:	CALL  ROTLCD    ; Reinitialize output back to LCD
	CALL  L4F45H    
	CALL  L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	LXI   H,L03F6H  ; Load pointer to "Ok" text
	CALL  L27B1H    ; Print buffer at M until NULL or '"'
	
; ======================================================
; Silent vector to BASIC ready
; ======================================================
L0511H:	LXI   H,FFFFH   ; Prepare to clear the BASIC executing line number
	SHLD  F67AH     ; Current executing line number
	LXI   H,F66DH   
	SHLD  FB9BH     ; Most recent or currently running line pointer
	CALL  INLIN     ; Input and display (no "?") line and store
	JC    L0511H    ; Silent vector to BASIC ready
	
; ======================================================
; Perform operation at M and return to ready
; ======================================================
	RST   2         ; Get next non-white char from M
	INR   A         ; Increment A to test if NULL
	DCR   A         ; Decrement A to test if NULL (why not just "ANA A"?)
	JZ    L0511H    ; If at end of string, Silent vector to BASIC ready
	PUSH  PSW       ; Save A & flags
	CALL  L08EBH    ; Check for line number - Convert ASCII number at M to binary
	JNC   L0536H    ; If last character received wasn't ASCII Digit, skip ahead
	CALL  L421AH    ; Test if address FC8CH is Zero. WHY???
	JZ    ERRSYN    ; Generate Syntax error - Line Integer too big
L0536H:	DCX   H         ; Rewind BASIC command pointer 1 byte
	MOV   A,M       ; Get next byte from BASIC command
	CPI   20H       ; Test for SPACE
	JZ    L0536H    ; Jump back to test previous byte
	CPI   09H       ; Test for TAB
	JZ    L0536H    ; Jump back to test previous byte
	INX   H         ; Point to next byte from BASIC command line
	MOV   A,M       ; Get next byte from BASIC command line
	CPI   20H       ; Test for SPACE
	CZ    L3457H    ; If SPACE, increment HL and return. Never keep 1st SPACE
	PUSH  D         
	CALL  L0646H    ; Perform Token compression
	POP   D         
	POP   PSW       
	SHLD  FB9BH     ; Most recent or currently running line pointer
	JNC   L4F1CH    
	PUSH  D         
	PUSH  B         
	XRA   A         
	STA   FB97H     
	RST   2         ; Get next non-white char from M
	ORA   A         
	PUSH  PSW       
	XCHG            
	SHLD  FBA1H     ; Most recent used or entered line number
	XCHG            
	CALL  L0628H    ; Find line number in DE
	JC    L056FH    
	POP   PSW       
	PUSH  PSW       
	JZ    L094DH    ; Generate UL error
	ORA   A         
L056FH:	PUSH  B         
	JNC   L0591H    
	CALL  L126CH    
	MOV   A,C       
	SUB   E         
	MOV   C,A       
	MOV   A,B       
	SBB   D         
	MOV   B,A       
	LHLD  FBAEH     ; Start of DO files pointer
	DAD   B         
	SHLD  FBAEH     ; Start of DO files pointer
	LHLD  FBB0H     ; Start of CO files pointer
	DAD   B         
	SHLD  FBB0H     ; Start of CO files pointer
	LHLD  FAD8H     
	DAD   B         
	SHLD  FAD8H     
L0591H:	POP   D         
	POP   PSW       
	PUSH  D         
	JZ    L05DAH    
	POP   D         
	LXI   H,0000H  
	SHLD  FBA5H     ; Address of ON ERROR routine
	LHLD  FBB2H     ; Start of variable data pointer
	XTHL            
	POP   B         
	PUSH  H         
	DAD   B         
	PUSH  H         
	CALL  L3EF0H    ; Copy bytes from BC to HL with decriment until BC=DE
	POP   H         
	SHLD  FBB2H     ; Start of variable data pointer
	XCHG            
	MOV   M,H       
	POP   B         
	POP   D         
	PUSH  H         
	INX   H         
	INX   H         
	MOV   M,E       
	INX   H         
	MOV   M,D       
	INX   H         
	LXI   D,F681H   ; Address of temp storage for tokenized line
	PUSH  H         
	LHLD  FBAEH     ; Start of DO files pointer
	DAD   B         
	SHLD  FBAEH     ; Start of DO files pointer
	LHLD  FBB0H     ; Start of CO files pointer
	DAD   B         
	SHLD  FBB0H     ; Start of CO files pointer
	LHLD  FAD8H     
	DAD   B         
	SHLD  FAD8H     
	POP   H         
L05D2H:	LDAX  D         
	MOV   M,A       
	INX   H         
	INX   D         
	ORA   A         
	JNZ   L05D2H    
L05DAH:	POP   D         
	CALL  L05F4H    ; Update line addresses for BASIC program at (DE)
	LHLD  FC8CH     
	SHLD  FBA8H     
	CALL  L3F28H    ; Initialize BASIC Variables for new execution
	LHLD  FBA8H     
	SHLD  FC8CH     
	JMP   L0511H    ; Silent vector to BASIC ready
	
	
; ======================================================
; Update line addresses for current BASIC program
; ======================================================
L05F0H:	LHLD  VBASPP    ; Get Start of BASIC program pointer
	XCHG            ; Put start of program in DE
	
; ======================================================
; Update line addresses for BASIC program at (DE)
; ======================================================
L05F4H:	MOV   H,D       ; Put address of current line in HL
	MOV   L,E       
	MOV   A,M       ; Get pointer to next line LSB
	INX   H         ; Increment to MSB
	ORA   M         ; OR MSB of pointer to test for NULL
	RZ              ; Return if at end of program
	INX   H         ; Increment to Line Number LSB
	INX   H         ; Increment to Line Number MSB
	INX   H         ; Increment to first byte of BASIC line
	XRA   A         ; Clear A to test for end of line
L05FEH:	CMP   M         ; Test for end of BASIC line
	INX   H         ; Increment to next byte of BASIC line
	JNZ   L05FEH    ; Jump to test next byte of BASIC if not NULL
L0603H:	XCHG            ; DE=Address of next line, HL=start of current line
	MOV   M,E       ; Save LSB of next line in current line pointer
	INX   H         ; Increment to MSB
	MOV   M,D       ; Save MSB of next line in current line pointer
	JMP   L05F4H    ; Jump to update address of next line
	
	
; ======================================================
; Evaluate LIST statement arguments
; ======================================================
L060AH:	LXI   D,0000H  
	PUSH  D         
	JZ    L061BH    
	POP   D         
	CALL  L08E0H    ; Evaluate line number text at M
	PUSH  D         
	JZ    L0624H    
	RST   1         ; Compare next byte with M
    DB	D1H             ; Test for '-'
L061BH:	LXI   D,FFFAH   
	CNZ   L08E0H    ; Evaluate line number text at M
	JNZ   ERRSYN    ; Generate Syntax error
L0624H:	XCHG            
	POP   D         
L0626H:	XTHL            ; Preserve HL on stack
	PUSH  H         ; PUSH return address back to stack
	
; ======================================================
; Find line number in DE
; ======================================================
L0628H:	LHLD  VBASPP    ; Start of BASIC program pointer
	
; ======================================================
; Find line number in DE starting at HL
; ======================================================
L062BH:	MOV   B,H       ; Save HL in BC
	MOV   C,L       ; Save LSB too
	MOV   A,M       ; Get LSB of pointer to next BASIC line
	INX   H         ; Increment to MSB
	ORA   M         ; OR in MSB with LSB to test for 0000H
	DCX   H         ; Decrement back to LSB
	RZ              ; Return if at end of BASIC program
	INX   H         ; Increment to MSB of pointer to next BASIC program
	INX   H         ; Increment to LSB of line number
	MOV   A,M       ; Get LSB of line number
	INX   H         ; Increment to MSB of line number
	MOV   H,M       ; Get MSB of line number
	MOV   L,A       ; Move LSB of line number to HL for comparison
	RST   3         ; Compare DE and HL
	MOV   H,B       ; Restore pointer to beginning of this BASIC line
	MOV   L,C       ; Restore LSB of pointer too
	MOV   A,M       ; Get LSB of next BASIC line number
	INX   H         ; Increment to MSB
	MOV   H,M       ; Get MSB of next BASIC line number
	MOV   L,A       ; Move LSB to HL
	CMC             ; Compliment C to indicate line found
	RZ              ; Return if HL = DE. BC will have pointer to line
	CMC             ; Indicate line not found
	RNC             ; Return if beyond line number being sought
	JMP   L062BH    ; Find line number in DE starting at HL
	
	
; ======================================================
; Perform Token compression
; ======================================================
L0646H:	XRA   A         ; Prepare to zero out control vars
	STA   FB66H     ; Zero out DATA statement found marker
	MOV   C,A       ; Zero out line length
	LXI   D,F681H   ; Pointer to temp storage space for tokenized line
L064EH:	MOV   A,M       ; Get next byte from input string
	CPI   20H       ; Compare with SPACE
	JZ    L06EAH    ; Save token in A to (DE)
	MOV   B,A       ; Save character to B
	CPI   22H       ; Compare with QUOTE
	JZ    L070FH    ; Jump if QUOTE to copy bytes until QUOTE or EOL
	ORA   A         ; Test for end of input string
	JZ    L0716H    ; Exit tokenize loop if end of string
	INX   H         ; Increment to next byte in input string
	ORA   A         ; Test for non-ASCII characters
	JM    L064EH    ; Skip byte if non-ASCII (CODE or GRAPH character)
	DCX   H         ; Decrement back to original byte in input string
	LDA   FB66H     ; Load marker if DATA statement active
	ORA   A         ; Test if DATA statement active
	MOV   A,M       ; Get next byte from input string
	JNZ   L06EAH    ; Copy byte to output if DATA statement active
	CPI   3FH       ; Compare with '?'
	MVI   A,A3H     ; Load token for PRINT (convert '?' to PRINT)
	JZ    L06EAH    ; Save token in A to (DE)
	MOV   A,M       ; Get next byte from input string
	CPI   30H       ; Compare with '0'
	JC    L067EH    ; Skip ahead if not '0-9'
	CPI   3CH       ; Compare with '<'
	JC    L06EAH    ; Jump to add digit to output if '0-9'
L067EH:	PUSH  D         ; Save output pointer on stack
	LXI   D,L007FH  ; Point to TOKEN table (-1)
	PUSH  B         ; Save line length count on stack
	LXI   B,L06CDH  ; Load address of routine to ???
	PUSH  B         ; Push address to stack
	MVI   B,7FH     ; Initialize token number counter
	MOV   A,M       ; Get next byte from input string
	CPI   61H       ; Compare with 'a'
	JC    L0697H    ; Skip uppercase if not 'a-z'
	CPI   7BH       ; Compare with '{' ('z' + 1)
	JNC   L0697H    ; Skip uppercase if not 'a-z'
	ANI   5FH       ; Make uppercase
	MOV   M,A       ; Save as uppercase
L0697H:	MOV   C,M       ; Get next byte (uppercase) from input string in C
	XCHG            ; HL now has pointer to Token table
L0699H:	INX   H         ; Increment to next byte in token table
	ORA   M         ; Test if this is the 1st byte of a token
	JP    L0699H    ; Jump back to increment to next byte if not the 1st byte of token
	INR   B         ; Increment the token # counter
	MOV   A,M       ; Get the next byte from the token table
	ANI   7FH       ; Mask off the 1st byte marker
	RZ              ; Return to our tokenizer return hook if token not found
	CMP   C         ; Test if input string byte matches next byte from token table
	JNZ   L0699H    ; Skip to next token in table if it doesn't match
	XCHG            ; 1st Char of token found. Move token table ptr to DE and CMP the rest
	PUSH  H         ; Save pointer to input string in case no match with this token
L06A9H:	INX   D         ; Increment to next byte in token table
	LDAX  D         ; Load the next byte from token table
	ORA   A         ; Test for token 1st byte marker
	JM    L06C9H    ; Jump if 1st byte of next token found = match!
	MOV   C,A       ; Save next byte from token table in C
	MOV   A,B       ; Load the token counter
	CPI   88H       ; Test for GOTO token??
	JNZ   L06B8H    ; Skip ahead if GOTO?
	RST   2         ; Get next non-white char from M
	DCX   H         ; Pre-decrement pointer to next byte from input string
L06B8H:	INX   H         ; Increment to next byte from input string
	MOV   A,M       ; Get next byte from input string
	CPI   61H       ; Test if byte >= 'a'
	JC    L06C1H    ; Skip uppercase if not >= 'a'
	ANI   5FH       ; Make uppercase
L06C1H:	CMP   C         ; Compare byte from input string with next byte from token table
	JZ    L06A9H    ; If it matches, jump back to test next byte for this token
	POP   H         ; Restore pointer to input string to test next token
	JMP   L0697H    ; Jump to test input against next token in table
	
L06C9H:	MOV   C,B       ; Save token number in C
	POP   PSW       ; POP saved pointer to input line
	XCHG            ; Pre-XCHG DE and HL
	RET             ; This returns to our Tokenizer return hook
	
L06CDH:	XCHG            ; Exchange DE & HL so HL = input string, DE = token table pointer
	MOV   A,C       ; Move TOKEN or next byte from input to A
	POP   B         ; Restore line length from stack
	POP   D         ; Restore output pointer from stack
	XCHG            ; HL=output pointer, DE = input string
	CPI   91H       ; Test for ELSE token
	MVI   M,3AH     ; Insert a ":" before ELSE token
	JNZ   L06DBH    ; Skip insertion if not ELSE token
	INR   C         ; It was ELSE token. Increment line length
	INX   H         ; And increment output pointer to keep the ':'
L06DBH:	CPI   FFH       ; Test for "'" token (Alternate REM)
	JNZ   L06E9H    ; Skip ahead to add token to output if not "'" token
	MVI   M,3AH     ; Insert a ':REM' before the "'"
	INX   H         ; Increment to next output byte
	MVI   B,8EH     ; Load value for REM token
	MOV   M,B       ; Save REM token to output
	INX   H         ; Increment to next output byte
	INR   C         ; Increment line length to account for added ':'
	INR   C         ; Increment line length to account for added REM token
L06E9H:	XCHG            ; HL=input line, DE = output pointer
L06EAH:	INX   H         ; Increment to next input byte
	STAX  D         ; Store this token to output (DE)
	INX   D         ; Increment output pointer
	INR   C         ; Increment line length counter
	SUI   3AH       ; Test for ':' token
	JZ    L06F8H    ; Jump ahead if ':'
	CPI   49H       ; Test for DATA statement (I think?)
	JNZ   L06FBH    ; Skip if not DATA statement
L06F8H:	STA   FB66H     ; Indicate DATA statement found
L06FBH:	SUI   54H       ; Test for REM statement
	JZ    L0705H    ; Jump ahead to save termination marker as NULL if REM
	SUI   71H       ; Test for FFh token
	JNZ   L064EH    ; Jump if not FFh token
L0705H:	MOV   B,A       ; Save termination marker as NULL (end of string)
L0706H:	MOV   A,M       ; Get next byte from input string
	ORA   A         ; Test for NULL termination
	JZ    L0716H    ; Jump out of loop if end of string
	CMP   B         ; Compare with termination character (QUOTE or NULL)
	JZ    L06EAH    ; Jump to Save token if termination char found (QUOTE or NULL)
L070FH:	INX   H         ; Increment to next input byte
	STAX  D         ; Save this character to (DE) output
	INR   C         ; Increment line length count
	INX   D         ; Increment output pointer
	JMP   L0706H    ; Jump to test next byte for termination marker (QUOTE or NULL)
	
L0716H:	LXI   H,L0005H  ; Prepare to add 5 to line length for Address, Line # & termination
	MOV   B,H       ; Zero MSB of BC
	DAD   B         ; Add 5 to line length
	MOV   B,H       ; Save MSB of line length in B
	MOV   C,L       ; Save LSB of line length in C
	LXI   H,F680H   ; End of statement marker
	STAX  D         ; Store Zero to output - End of line marker
	INX   D         ; Increment output pointer
	STAX  D         ; Store 2nd zero to output - NULL next BASIC line address LSB
	INX   D         ; Increment output pointer
	STAX  D         ; Store 3rd zero to output - NULL next BASIC line address MSB
	RET             
	
	
; ======================================================
; FOR statement
; ======================================================
	MVI   A,64H     
	STA   FB96H     ; FOR/NEXT loop active flag
	CALL  L09C3H    ; LET statement
	POP   B         ; Pop BASIC Loop "RET"urn address from stack
	PUSH  H         ; Save pointer to FOR arguments on stack
	CALL  L099EH    ; DATA statement
	SHLD  FB92H     ; Save address of first statement in FOR loop
	LXI   H,L0002H  
	DAD   SP        ; Get SP prior to our PUSH H above
L073AH:	CALL  L0405H    
	JNZ   L0758H    
	DAD   B         
	PUSH  D         
	DCX   H         
	MOV   D,M       
	DCX   H         
	MOV   E,M       
	INX   H         
	INX   H         
	PUSH  H         
	LHLD  FB92H     ; Get address of 1st statement in FOR loop
	RST   3         ; Compare DE and HL
	POP   H         
	POP   D         
	JNZ   L073AH    
	POP   D         
	SPHL            
	SHLD  FB9DH     ; SP used by BASIC to reinitialize the stack
	MVI   C,D1H     ; Make POP D (D1H) below look like MVI C,D1H
	XCHG            
	MVI   C,0CH     
	CALL  L3EFFH    ; Test for 24 byte free in stack space
	PUSH  H         
	LHLD  FB92H     ; Get address of 1st statement in FOR loop
	XTHL            
	PUSH  H         
	LHLD  F67AH     ; Current executing line number
	XTHL            
	RST   1         ; Compare next byte with M
    DB	C1H             ; Test for TO token ID
	
; ======================================================
; TO statement
; ======================================================
	RST   5         ; Determine type of last var used
	JZ    L045BH    ; Generate TM error
	PUSH  PSW       ; Save type of last var used
	CALL  L0DABH    ; Main BASIC evaluation routine
	POP   PSW       ; Restore type of last var used
	PUSH  H         
	JNC   L0791H    ; Jump if Double Precision
	JP    L07C8H    ; Jump if Single Precision
	CALL  L3501H    ; CINT function
	XTHL            
	LXI   D,L0001H  
	MOV   A,M       
	
; ======================================================
; STEP statement
; ======================================================
	CPI   CFH       
	CZ    L1112H    ; Evaluate expression at M
	PUSH  D         
	PUSH  H         
	XCHG            
	CALL  L341BH    
	JMP   L07EAH    
	
L0791H:	CALL  L35BAH    ; CDBL function
	POP   D         
	LXI   H,FFF8H   
	DAD   SP        
	SPHL            
	PUSH  D         
	CALL  L3487H    
	POP   H         
	MOV   A,M       
	CPI   CFH       
	LXI   D,L3286H  ; Load pointer to FP 1.000000000
	MVI   A,01H     
	JNZ   L07B7H    
	RST   2         ; Get next non-white char from M
	CALL  L0DABH    ; Main BASIC evaluation routine
	PUSH  H         
	CALL  L35BAH    ; CDBL function
	RST   6         ; Get sign of FAC1
	LXI   D,FC18H   ; Start of FAC1 for single and double precision
	POP   H         
L07B7H:	MOV   B,H       
	MOV   C,L       
	LXI   H,FFF8H   
	DAD   SP        
	SPHL            
	PUSH  PSW       
	PUSH  B         
	CALL  L3465H    
	POP   H         
	POP   PSW       
	JMP   L07F1H    
	
L07C8H:	CALL  L352AH    ; CSNG function
	CALL  L343DH    ; Load single precision FAC1 to BCDE
	POP   H         
	PUSH  B         
	PUSH  D         
	LXI   B,L1041H  
	LXI   D,0000H  
	MOV   A,M       
	CPI   CFH       
	MVI   A,01H     
	JNZ   L07EBH    
	CALL  L0DACH    
	PUSH  H         
	CALL  L352AH    ; CSNG function
	CALL  L343DH    ; Load single precision FAC1 to BCDE
	RST   6         ; Get sign of FAC1
L07EAH:	POP   H         
L07EBH:	PUSH  D         
	PUSH  B         
	PUSH  B         
	PUSH  B         
	PUSH  B         
	PUSH  B         
L07F1H:	ORA   A         
	JNZ   L07F7H    
	MVI   A,02H     
L07F7H:	MOV   C,A       
	RST   5         ; Determine type of last var used
	MOV   B,A       
	PUSH  B         
	PUSH  H         
	LHLD  FB99H     ; Address of last variable assigned
	XTHL            
L0800H:	MVI   B,81H     
	PUSH  B         
	INX   SP        
	
; ======================================================
; Execute BASIC program
; ======================================================
L0804H:	CALL  L6D6DH    ; Check RS232 queue for pending characters
	CNZ   L4028H    ; Call routine to process ON COM interrupt
	LDA   F654H     ; Load pending interrupt (ON KEY/TIME/COM/MDM) count
	ORA   A         ; Test for pending interrupts to process
	CNZ   L402BH    ; Call routine to process ON KEY/TIME/COM/MDM interrupts
L0811H:	CALL  L13F3H    ; Test for CTRL-C or CTRL-S during BASIC execute
	SHLD  FB9BH     ; Most recent or currenly running line pointer
	XCHG            ; Store line pointer in DE
	LXI   H,0000H  ; Prepare to get Stack Pointer
	DAD   SP        ; Get Stack Pointer prior to BASIC Inst. execution
	SHLD  FB9DH     ; SP used by BASIC to reinitialize the stack
	XCHG            ; Restore line pointer
	MOV   A,M       ; Get next byte from executing BASIC line
	CPI   3AH       ; Test for ":" character - Don't update line number
	JZ    L083AH    ; Start executing BASIC program at HL
	ORA   A         ; Test for NULL byte separating BASIC instructions
	JNZ   ERRSYN    ; Generate Syntax error
	INX   H         ; Point to "Next Line #" POINTER to test for end
L082BH:	MOV   A,M       ; Get LSB of "Next line #" POINTER
	INX   H         ; Point to MSB
	ORA   M         ; Test if "Next line #" POINTER is zero - end of program
	JZ    ENDPRG    ; Jump to terminate if end of BASIC program
	INX   H         ; Point to LSB of line NUMBER
	MOV   E,M       ; Get LSB of Executing Line number
	INX   H         ; Point to MSB of line number
	MOV   D,M       ; Get MSB of line number
	XCHG            ; HL=Line #, DE=Pointer to line
	SHLD  F67AH     ; Current executing line number
	XCHG            ; HL=pointer to line, DE=line #
	
; ======================================================
; Start executing BASIC program at HL
; ======================================================
L083AH:	RST   2         ; Get next non-white char from M
	LXI   D,L0804H  ; Address of routine to process next BASIC line
	PUSH  D         ; Push it to the stack
L083FH:	RZ              ; Return to process next line if end of current line
	
; ======================================================
; Execute instruction in A), HL points to args
; ======================================================
L0840H:	SUI   80H       ; Subtract 80 from instruction ID to make it zero based
	JC    L09C3H    ; LET statement
	CPI   40H       ; Test instruction number for bounds
	JNC   L10F4H    ; Test if command to execute is FEH, generate SN error if not
	RLC             ; Multiply instruction x2 to get offset in address table
	MOV   C,A       ; Move inst# x 2 into C for index into table
	MVI   B,00H     ; Clear MSB of command offset
	XCHG            ; Save pointer to command parameters in DE
	LXI   H,L0262H  ; BASIC statement vector table for END to NEW
	DAD   B         ; Index into command handler address table
	MOV   C,M       ; Load LSB of command handler address
	INX   H         ; Point to MSB of command handler address
	MOV   B,M       ; Load MSB of command handler address
	PUSH  B         ; PUSH address of command handler to stack
	XCHG            ; Restore pointer to command parameters from DE
	
; ======================================================
; Execute instruction in A), HL points to args
; ======================================================
L0858H:	INX   H         ; Point to next byte of executing BASIC line
	
; ======================================================
; RST 10H routine
; ======================================================
	MOV   A,M       ; Load next byte from command arguments
	CPI   3AH       ; Test for ":" command separator
	RNC             ; This can "RETurn" to the BASIC statement handler
	CPI   20H       ; Test for space after command
	JZ    L0858H    ; RST 10H routine with pre-increment of HL
	CPI   0BH       
	JNC   L086CH    
	CPI   09H       ; Test for TAB
	JNC   L0858H    ; RST 10H routine with pre-increment of HL
L086CH:	CPI   30H       ; Test for '0'
	CMC             
	INR   A         
	DCR   A         ; Test for zero in command arguments
	RET             ; "Return" to the command handler routine
	
	
; ======================================================
; DEF statement
; ======================================================
	CPI   E0H       ; Test for INT token ID
	JZ    L0886H    ; DEFINT statement
	CPI   44H       ; Test for 'D' character
	JNZ   L088CH    ; Jump if not D to test for "SNG"
	RST   2         ; Get next non-white char from M
	RST   1         ; Compare next byte with M
    DB	42H             ; Test for 'B'
	RST   1         ; Compare next byte with M
    DB	4CH             ; Test for 'L'
	
; ======================================================
; DEFDBL statement
; ======================================================
	MVI   E,08H     ; Load variable type for Double precision
	JMP   L08A1H    ; Declare variable at M to be type E
	
	
; ======================================================
; DEFINT statement
; ======================================================
L0886H:	RST   2         ; Get next non-white char from M
	MVI   E,02H     ; Load variable type for Integer
	JMP   L08A1H    ; Declare variable at M to be type E
	
L088CH:	RST   1         ; Compare next byte with M
    DB	53H             ; Test for 'S'
	CPI   4EH       ; Test for 'N'
	JNZ   L089BH    ; Jump if not "SNG" to test for "STR"
	RST   2         ; Get next non-white char from M
	RST   1         ; Compare next byte with M
    DB	47H             ; Test for 'G'
	
; ======================================================
; DEFSNG statement
; ======================================================
	MVI   E,04H     ; Load variable type for Single Precision
	JMP   L08A1H    ; Declare variable at M to be type E
	
L089BH:	RST   1         ; Compare next byte with M
    DB	54H             ; Test for 'T'
	RST   1         ; Compare next byte with M
    DB	52H             ; Test for 'R'
	
; ======================================================
; DEFSTR statement
; ======================================================
	MVI   E,03H     ; Load variable type for String var
	
; ======================================================
; Declare variable at M to be type E
; ======================================================
L08A1H:	CALL  L40F1H    ; Check if M is alpha character
	LXI   B,ERRSYN  ; Address of Generate Syntax error
	PUSH  B         ; Push address of Syntax Error to stack
	RC              ; Return to generate Syntax Error if not alpha
	SUI   41H       ; De-ASCII the variable
	MOV   C,A       ; Save in C
	MOV   B,A       ; Save in B (for range)
	RST   2         ; Get next non-white char from M
	CPI   D1H       ; Test for '-' token ID
	JNZ   L08BCH    ; Jump if not variable range ("A-D" syntax)
	RST   2         ; Get next non-white char from M
	CALL  L40F1H    ; Check if M is alpha character
	RC              ; Return to Syntax Error if not alpha
	SUI   41H       ; De-ASCII the variable
	MOV   B,A       ; Save in B as a range
	RST   2         ; Get next non-white char from M
L08BCH:	MOV   A,B       ; Get High range in A
	SUB   C         ; Subtract low range
	RC              ; Return if range is inverted
	INR   A         ; Increment range difference (count)
	XTHL            ; Replace "Syntax Error" address with BASIC line pointer
	LXI   H,FBBAH   ; DEF definition table
	MVI   B,00H     ; Zero out MSB of BC for index into table
	DAD   B         ; Index into variable definition table
L08C7H:	MOV   M,E       ; Set type of the variable
	INX   H         ; Increment pointer to variable def table
	DCR   A         ; Decrement range count
	JNZ   L08C7H    ; Jump to define all variables in range
	POP   H         ; Pop BASIC line pointer from stack
	MOV   A,M       ; Get next line from BASIC
	CPI   2CH       ; Test for ','
	RNZ             ; Return if no more variables to declare
	RST   2         ; Get next non-white char from M
	JMP   L08A1H    ; Declare variable at M to be type E
	
L08D6H:	RST   2         ; Get next non-white char from M
L08D7H:	CALL  L1113H    ; Evaluate expression at M-1
	RP              
	
; ======================================================
; Generate FC error
; ======================================================
L08DBH:	MVI   E,05H     ; Load code for FC Error
	JMP   L045DH    ; Generate error in E
	
	
; ======================================================
; Evaluate line number text at M
; ======================================================
L08E0H:	MOV   A,M       ; Get next character from BASIC line
	CPI   2EH       
	XCHG            
	LHLD  FBA1H     ; Most recent used or entered line number
	XCHG            
	JZ    L0858H    ; RST 10H routine with pre-increment of HL
	
; ======================================================
; Convert ASCII number at M to binary
; ======================================================
L08EBH:	DCX   H         
	
; ======================================================
; Convert ASCII number at M+1 to binary
; ======================================================
L08ECH:	LXI   D,0000H  ; Initialize value to zero
L08EFH:	RST   2         ; Get next non-white char from M
	RNC             ; Return if not ASCII Digit '0-9'
	PUSH  H         ; Save pointer to BASIC command line
	PUSH  PSW       ; Save next byte from command line
	LXI   H,L1998H  ; Load value of 65520 / 10
	RST   3         ; Compare DE and HL
	JC    L090CH    ; Jump if line # would be too big
	MOV   H,D       ; Move MSB of current value to H
	MOV   L,E       ; Move LSB of current value to L
	DAD   D         ; x2
	DAD   H         ; x4
	DAD   D         ; x5
	DAD   H         ; x10
	POP   PSW       ; Restore A (next char) from stack
	SUI   30H       ; Convert from ASCII '0-9' to binary
	MOV   E,A       ; Move to DE to perform 16-bit add
	MVI   D,00H     ; Clear MSB
	DAD   D         ; Add to current value (in HL)
L0907H:	XCHG            ; Put current value back in DE
L0908H:	POP   H         ; Restore pointer to BASIC command line
	JMP   L08EFH    ; Jump to read next character
	
L090CH:	POP   PSW       ; POP next byte from BASIC command line
	POP   H         ; POP pointer to BASIC command line
	RET             
	
	
; ======================================================
; RUN statement
; ======================================================
	JZ    L3F28H    ; Initialize BASIC Variables for new execution
	JNC   L4D6EH    ; RUN statement
	CALL  L3F2CH    ; Initialize BASIC Variables for new execution
	LXI   B,L0804H  
	JMP   L0935H    
	
	
; ======================================================
; GOSUB statement
; ======================================================
L091EH:	MVI   C,03H     ; Prepare to test for 6 bytes stack space
	CALL  L3EFFH    ; Test if enough Stack space
	POP   B         ; POP BASIC exec loop return address from stack
	PUSH  H         ; Save pointer to arguments to stack
	PUSH  H         ; Make space on stack for current line number
	LHLD  F67AH     ; Current executing line number
	XTHL            ; Put line number containing GOSUB to stack
	LXI   B,0000H  ; Load a GOSUB control variable
	PUSH  B         ; Push GOSUB control variable to stack
	LXI   B,L0804H  ; Address of BASIC execution loop
	MVI   A,8CH     ; BASIC GOSUB token ID
	PUSH  PSW       ; Push GOSUB ID to stack
	INX   SP        ; Don't keep flags on stack, only token ID
L0935H:	PUSH  B         ; Push BASIC execution loop return address to stack
	
; ======================================================
; GOTO statement
; ======================================================
L0936H:	CALL  L08EBH    ; Convert ASCII number at M to binary
L0939H:	CALL  L09A0H    ; REM statement
	INX   H         ; Increment to next statement to be executed
	PUSH  H         ; Save address of next instruction on stack
	LHLD  F67AH     ; Current executing line number
	RST   3         ; Compare DE and HL
	POP   H         ; Get address of next instruction from stack
	CC    L062BH    ; Find line number in DE starting at HL
	CNC   L0628H    ; Find line number in DE
	MOV   H,B       ; Put new line number in HL
	MOV   L,C       ; ...
	DCX   H         ; Test if line number found, plus pre-decrement
	RC              ; Return to BASIC execute loop if new line found
	
; ======================================================
; Generate UL error
; ======================================================
L094DH:	MVI   E,08H     ; Load code for UL Error
	JMP   L045DH    ; Generate error in E
	
L0952H:	PUSH  H         ; Push line # to Stack
	PUSH  H         ; Push again to preserve through XTHL
	LHLD  F67AH     ; Current executing line number
	XTHL            ; Put Current line number on Stack. HL=new line
	PUSH  B         ; Preserve BC on Stack
	MVI   A,8CH     ; Load token for GOSUB
	PUSH  PSW       ; Push GOSUB Token to Stack
	INX   SP        ; Remove flags from Stack. Keep only GOSUB token
	XCHG            ; HL now has pointer to GOSUB line
	DCX   H         ; Decrement to save as currently running line pointer
	SHLD  FB9BH     ; Most recent or currenly running line pointer
	INX   H         ; Increment back to beginning of line
	JMP   L082BH    ; Jump into Execute BASIC program loop
	
	
; ======================================================
; RETURN statement
; ======================================================
	RNZ             
	MVI   D,FFH     
	CALL  POPRET    ; Pop return address for NEXT or RETURN
	CPI   8CH       ; Test for GOSUB token ID popped from stack
	JZ    L0972H    
	DCX   H         
L0972H:	SPHL            ; Remove GOSUB return info from stack
	SHLD  FB9DH     ; SP used by BASIC to reinitialize the stack
	MVI   E,03H     ; Load code for RG Error
	JNZ   L045DH    ; Generate error in E
	POP   H         
	MOV   A,H       
	ORA   L         
	JZ    L0987H    
	MOV   A,M       
	ANI   01H       
	CNZ   L3FC7H    
L0987H:	POP   H         
	SHLD  F67AH     ; Current executing line number
	INX   H         
	MOV   A,H       
	ORA   L         
	JNZ   L0998H    
	LDA   FB97H     
	ORA   A         
	JNZ   L0501H    ; Pop stack and vector to BASIC ready
L0998H:	LXI   H,L0804H  
	XTHL            
	MVI   A,E1H     
	
; ======================================================
; DATA statement
; ======================================================
L099EH:	LXI   B,L0E3AH  ; Using 0EH below, forms "LXI B,0E3AH"
	NOP             
	MVI   B,00H     ; Zero out B. Termination tokens are NULL & C from above
L09A4H:	MOV   A,C       ; \ Swap termination token when a quote is
	MOV   C,B       ; > detected. That way a ':' in the middle of
	MOV   B,A       ; / a quoted DATA item doesn't terminate the search
L09A7H:	MOV   A,M       ; Get next byte to be ignored
	ORA   A         ; Test for end of line
	RZ              ; Return if end of line
	CMP   B         ; Test for termination token (NULL or ':')
	RZ              ; Return if "ignore" termination found
	INX   H         ; Increment to next byte in BASIC line
	CPI   22H       ; Test for quote character in BASIC line
	JZ    L09A4H    ; If quote, jump to swap termination tokens
	SUI   8AH       ; Test for IF token ID
	JNZ   L09A7H    ; Jump if not IF to ignore next byte
	CMP   B         ; Compare with 0 or 3Eh
	ADC   D         ; Add zero + carry to count
	MOV   D,A       ; Save updated IF count
	JMP   L09A7H    ; Jump to continue ignoring bytes
	
L09BDH:	POP   PSW       ; POP PSW that was left on stack
	ADI   03H       
	JMP   L09D6H    ; Jump into the LET statement
	
	
; ======================================================
; LET statement
; ======================================================
L09C3H:	CALL  L4790H    ; Find address of variable at M
	RST   1         ; Compare next byte with M
    DB	DDH             ; Test for '='
	XCHG            
	SHLD  FB99H     ; Address of last variable assigned
	XCHG            
	PUSH  D         
	LDA   FB65H     ; Type of last variable used
	PUSH  PSW       
	CALL  L0DABH    ; Main BASIC evaluation routine
	POP   PSW       
L09D6H:	XTHL            
L09D7H:	MOV   B,A       
	LDA   FB65H     ; Type of last variable used
	CMP   B         
	MOV   A,B       
	JZ    L09E6H    
	CALL  L10D7H    
	LDA   FB65H     ; Type of last variable used
L09E6H:	LXI   D,FC18H   ; Start of FAC1 for single and double precision
	CPI   02H       ; Test if last variable type was integer
	JNZ   L09F1H    
	LXI   D,FC1AH   ; Start of FAC1 for integers
L09F1H:	PUSH  H         
	CPI   03H       ; Test if last variable type was string
	JNZ   L0A29H    
	LHLD  FC1AH     ; Start of FAC1 for integers
	PUSH  H         
	INX   H         
	MOV   E,M       
	INX   H         
	MOV   D,M       
	LXI   H,F683H   ; Different from M100
	RST   3         ; Compare DE and HL
	JC    L0A1DH    
	LHLD  FBB6H     ; Unused memory pointer
	RST   3         ; Compare DE and HL
	POP   D         
	JNC   L0A25H    
	LXI   H,FB88H   
	RST   3         ; Compare DE and HL
	JC    L0A1CH    
	LXI   H,FB6AH   
	RST   3         ; Compare DE and HL
	JC    L0A25H    
L0A1CH:	MVI   A,D1H     
	CALL  L2935H    
	XCHG            
	CALL  L2747H    
L0A25H:	CALL  L2935H    
	XTHL            
L0A29H:	CALL  L3465H    
	POP   D         
	POP   H         
	RET             
	
	
; ======================================================
; ON statement
; ======================================================
	CPI   94H       
	JNZ   L0A5BH    ; ON KEY/TIME/COM/MDM GOSUB routine
	
; ======================================================
; ON ERROR statement
; ======================================================
	RST   2         ; Get next non-white char from M
	RST   1         ; Compare next byte with M
    DB	88H             ; Test for GOTO token ID
	CALL  L08EBH    ; Convert ASCII number at M to binary
	MOV   A,D       
	ORA   E         
	JZ    L0A48H    
	CALL  L0626H    ; Find line number in DE (preserve HL on stack)
	MOV   D,B       
	MOV   E,C       
	POP   H         ; Restore HL from stack
	JNC   L094DH    ; Generate UL error
L0A48H:	XCHG            
	SHLD  FBA5H     ; Address of ON ERROR routine
	XCHG            
	RC              
	LDA   FBA7H     ; BASIC Program Running Flag
	ORA   A         
	MOV   A,E       
	RZ              
	LDA   F672H     ; Last Error code
	MOV   E,A       
	JMP   L048AH    
	
	
; ======================================================
; ON KEY/TIME/COM/MDM GOSUB routine
; ======================================================
L0A5BH:	CALL  L1AFCH    ; Determine device (KEY/TIME/COM/MDM) for ON GOSUB
	JC    L0A94H    ; ON TIME$ handler
	PUSH  B         ; Save device code to stack
	RST   2         ; Get next non-white char from M
	RST   1         ; Compare next byte with M
    DB	8CH             ; GOSUB token (or generate SN error)
	XRA   A         ; Clear A
L0A66H:	POP   B         ; Get device code from stack
	PUSH  B         ; Push it back on the stach
	CMP   C         ; Compare device count with A
	JNC   ERRSYN    ; Generate Syntax error
	PUSH  PSW       ; Save device count on stack
	CALL  L08EBH    ; Convert ASCII number at M to binary
	MOV   A,D       ; Prepare to test for line# 0
	ORA   E         ; Test for line# 0
	JZ    L0A7EH    ; Skip finding line# if it is 0
	CALL  L0626H    ; Find line number in DE (preserve HL on stack)
	MOV   D,B       ; Save MSB of line number address to D
	MOV   E,C       ; Save LSB of line number address
	POP   H         ; Restore HL from stack
	JNC   L094DH    ; Generate UL error
L0A7EH:	POP   PSW       ; Restore device count from stack
	POP   B         ; Restore device code from stack
	PUSH  PSW       ; Push device count to stack
	ADD   B         ; Calculate device number being accessed (1-10)
	PUSH  B         ; Save device code to stack
	CALL  L1B22H    ; ON COM handler
	DCX   H         ; Decrement BASIC line pointer to test for EOL
	RST   2         ; Get next non-white char from M
	POP   B         ; Restore device code from stack
	POP   D         ; POP device count (&flags) into DE so we don't clobber flags
	RZ              ; Return if at end of BASIC line
	PUSH  B         ; Save device code to stack
	PUSH  D         ; Save device count to stack
	RST   1         ; Compare next byte with M
    DB	2CH             ; ',' - Separator for ON GOSUB x,y,z
	POP   PSW       ; Restore device count from stack
	INR   A         ; Increment to next device number (for ON KEY GOSUB)
	JMP   L0A66H    ; Jump to process next ON KEY GOSUB entry
	
	
; ======================================================
; ON TIME$ handler
; ======================================================
L0A94H:	CALL  L112EH    ; Evaluate expression at M-1
	MOV   A,M       
	MOV   B,A       
	CPI   8CH       
	JZ    L0AA1H    
	RST   1         ; Compare next byte with M
    DB	88H             ; Test for GOTO token ID
	DCX   H         
L0AA1H:	MOV   C,E       
L0AA2H:	DCR   C         
	MOV   A,B       
	JZ    L0840H    ; Execute instruction in A), HL points to args
	CALL  L08ECH    ; Convert ASCII number at M+1 to binary
	CPI   2CH       
	RNZ             
	JMP   L0AA2H    
	
	
; ======================================================
; RESUME statement
; ======================================================
	LDA   FBA7H     ; BASIC Program Running Flag
	ORA   A         
	JNZ   L0AC0H    
	STA   FBA5H     ; Address of ON ERROR routine
	STA   FBA6H     
	JMP   L0452H    ; Generate RW error
	
L0AC0H:	INR   A         
	STA   F672H     ; Last Error code
	MOV   A,M       
	CPI   82H       
	JZ    L0ADBH    
	CALL  L08EBH    ; Convert ASCII number at M to binary
	RNZ             
	MOV   A,D       
	ORA   E         
	JZ    L0AE0H    
	CALL  L0939H    
	XRA   A         
	STA   FBA7H     ; BASIC Program Running Flag
	RET             
	
L0ADBH:	RST   2         ; Get next non-white char from M
	RNZ             
	JMP   L0AE5H    
	
L0AE0H:	XRA   A         
	STA   FBA7H     ; BASIC Program Running Flag
	INR   A         
L0AE5H:	LHLD  FBA3H     ; Pointer to occurance of error
	XCHG            
	LHLD  FB9FH     ; Line number of last error
	SHLD  F67AH     ; Current executing line number
	XCHG            
	RNZ             
	MOV   A,M       
	ORA   A         
	JNZ   L0AFAH    
	INX   H         
	INX   H         
	INX   H         
	INX   H         
L0AFAH:	INX   H         
	MOV   A,D       
	ANA   E         
	INR   A         
	JNZ   L0B08H    
	LDA   FB97H     
	DCR   A         
	JZ    L40B3H    
L0B08H:	XRA   A         
	STA   FBA7H     ; BASIC Program Running Flag
	JMP   L099EH    ; DATA statement
	
	
; ======================================================
; ERROR statement
; ======================================================
L0B0FH:	CALL  L112EH    ; Evaluate expression at M-1
	RNZ             
	ORA   A         
	JZ    L08DBH    ; Generate FC error
	JMP   L045DH    ; Generate error in E
	
	
; ======================================================
; IF statement
; ======================================================
	CALL  L0DABH    ; Main BASIC evaluation routine
	MOV   A,M       
	CPI   2CH       
	CZ    L0858H    ; RST 10H routine with pre-increment of HL
	CPI   88H       
	JZ    L0B2BH    
	RST   1         ; Compare next byte with M
    DB	CDH             ; Test for THEN token ID
	DCX   H         
L0B2BH:	PUSH  H         
	CALL  L3411H    ; Determine sign of last variable used
	POP   H         
	JZ    L0B3AH    
L0B33H:	RST   2         ; Get next non-white char from M
	JC    L0936H    ; GOTO statement
	JMP   L083FH    
	
L0B3AH:	MVI   D,01H     
L0B3CH:	CALL  L099EH    ; DATA statement
	ORA   A         
	RZ              
	RST   2         ; Get next non-white char from M
	CPI   91H       
	JNZ   L0B3CH    
	DCR   D         
	JNZ   L0B3CH    
	JMP   L0B33H    
	
	
; ======================================================
; LPRINT statement
; ======================================================
L0B4EH:	MVI   A,01H     ; Prepare to set output to LPT
	STA   VOUTSW    ; Output device for RST 20H (0=screen)
	JMP   L0B60H    ; Jump into PRINT statement
	
	
; ======================================================
; PRINT statement
; ======================================================
	MVI   C,02H     ; Set PRINT # init entry marker
	CALL  L4F2BH    ; Test for '#' char and process argument
	CPI   40H       
	CZ    L1D5FH    
L0B60H:	DCX   H         
	RST   2         ; Get next non-white char from M
	CZ    L4BCBH    
L0B65H:	JZ    L0C39H    
	CPI   C2H       
	JZ    L4991H    ; USING function
	CPI   C0H       
	JZ    L0C01H    ; TAB statement
	PUSH  H         
	CPI   2CH       
	JZ    L0BCDH    
	CPI   3BH       
	JZ    L0C34H    
	POP   B         
	CALL  L0DABH    ; Main BASIC evaluation routine
	PUSH  H         
	RST   5         ; Determine type of last var used
	JZ    L0BC6H    
	CALL  L39E8H    ; Convert binary number in FAC1 to ASCII at M
	CALL  L276BH    ; Search string at M until QUOTE found
	MVI   M,20H     
	LHLD  FC1AH     ; Start of FAC1 for integers
	INR   M         
	CALL  L421AH    
	JNZ   L0BC2H    
	LHLD  FC1AH     ; Start of FAC1 for integers
	LDA   VOUTSW    ; Output device for RST 20H (0=screen)
	ORA   A         
	JZ    L0BABH    
	LDA   VLPPCL    ; Line printer head position
	ADD   M         
	CPI   FFH       
	JMP   L0BB9H    
	
L0BABH:	LDA   VACTCC    ; Active columns count (1-40)
	MOV   B,A       
	INR   A         
	JZ    L0BC2H    
	LDA   F788H     ; Horiz. position of cursor (0-39)
	ADD   M         
	DCR   A         
	CMP   B         
L0BB9H:	JC    L0BC2H    
	CZ    L4BD1H    
	CNZ   L4BCBH    
L0BC2H:	CALL  L27B4H    
	ORA   A         
L0BC6H:	CZ    L27B4H    
	POP   H         
	JMP   L0B60H    
	
L0BCDH:	LXI   B,L0008H  
	LHLD  FC8CH     
	DAD   B         
	CALL  L421AH    
	MOV   A,M       
	JNZ   L0BF8H    
	LDA   VOUTSW    ; Output device for RST 20H (0=screen)
	ORA   A         
	JZ    L0BEAH    ; Process printing the "," field separator
	LDA   VLPPCL    ; Line printer head position
	CPI   EEH       
	JMP   L0BF2H    
	
L0BEAH:	LDA   F676H     ; Get COL of last field for comma separation in PRINT
	MOV   B,A       ; Save in B
	LDA   F788H     ; Horiz. position of cursor (0-39)
	CMP   B         ; Compare with 0EH or value from DVI calculation
L0BF2H:	CNC   L4BCBH    ; If not beyond last field, then
	JNC   L0C34H    ; Jump to print next item from PRINT statement if it fits
L0BF8H:	SUI   0EH       ; Subtract 14 (comma field width)
	JNC   L0BF8H    ; Keep subtracting until negative
	CMA             ; 1's compliement the remainder
	JMP   L0C2BH    
	
	
; ======================================================
; TAB statement
; ======================================================
L0C01H:	CALL  L112DH    ; Evaluate expression at M
	RST   1         ; Compare next byte with M
    DB	29H             ; Test for ')'
	DCX   H         
L0C07H:	PUSH  H         
	LXI   B,L0008H  
	LHLD  FC8CH     
	DAD   B         
	CALL  L421AH    
	MOV   A,M       
	JNZ   L0C26H    
	LDA   VOUTSW    ; Output device for RST 20H (0=screen)
	ORA   A         
	JZ    L0C23H    
	LDA   VLPPCL    ; Line printer head position
	JMP   L0C26H    
	
L0C23H:	LDA   F788H     ; Horiz. position of cursor (0-39)
L0C26H:	CMA             
	ADD   E         
	JNC   L0C34H    
L0C2BH:	INR   A         ; Pre-increment count
	MOV   B,A       ; Save count in B
	MVI   A,20H     ; Load ASCII code for SPACE
L0C2FH:	RST   4         ; Send character in A to screen/printer
	DCR   B         ; Decrement counter
	JNZ   L0C2FH    ; Keep sending until zero
L0C34H:	POP   H         ; Stack cleanup
	RST   2         ; Get next non-white char from M
	JMP   L0B65H    ; Jump into PRINT statement to print next item
	
L0C39H:	XRA   A         
	STA   VOUTSW    ; Output device for RST 20H (0=screen)
	PUSH  H         
	MOV   H,A       
	MOV   L,A       
	SHLD  FC8CH     ; Clear ASCII
	POP   H         
	RET             
	
	
; ======================================================
; LINE statement
; ======================================================
	CPI   84H       
	JNZ   L1C6DH    ; LINE statement
	RST   2         ; Get next non-white char from M
	CPI   23H       
	JZ    L4F5BH    ; LINE INPUT # statement
	CALL  L10E6H    ; Check for running program
	MOV   A,M       
	CALL  L0CB4H    
	CALL  L4790H    ; Find address of variable at M
	CALL  L35D9H    ; Generate TM error if last variable type not string or RET
	PUSH  D         
	PUSH  H         
	CALL  INLIN     ; Input and display (no "?") line and store
	POP   D         
	POP   B         
	JC    L40B3H    
	PUSH  B         
	PUSH  D         
	MVI   B,00H     
	CALL  L276EH    
	POP   H         
	MVI   A,03H     
	JMP   L09D6H    
	
L0C74H:
    DB	"?Redofromstart",0DH,0AH,00H
	
L0C87H:	LDA   FB98H     
	ORA   A         
	JNZ   GERRSN    ; Jump to generate SN error on DATA statement line
	POP   B         
	LXI   H,L0C74H  ; Load pointer to "?Redo from start" text
	CALL  L27B1H    ; Print buffer at M until NULL or '"'
	LHLD  FB9BH     ; Most recent or currenly running line pointer
	RET             
	
	
; ======================================================
; INPUT # statement
; ======================================================
L0C99H:	CALL  L4F29H    ; Test for '#' char and process argument
	PUSH  H         
	LXI   H,F684H   
	JMP   L0CD4H    
	
	
; ======================================================
; INPUT statement
; ======================================================
L0CA3H:	CALL  L10E6H    ; Check for running program
	MOV   A,M       
	CPI   23H       
	JZ    L0C99H    ; INPUT # statement
	CALL  L10E6H    ; Check for running program
	MOV   A,M       
	LXI   B,L0CC4H  
	PUSH  B         
L0CB4H:	CPI   22H       
	MVI   A,00H     
	RNZ             
	CALL  L276CH    
	RST   1         ; Compare next byte with M
    DB	3BH             
	PUSH  H         
	CALL  L27B4H    
	POP   H         
	RET             
	
L0CC4H:	PUSH  H         
	CALL  L463EH    ; Input and display line and store
	POP   B         
	JC    L40B3H    
	INX   H         
L0CCDH:	MOV   A,M       
	ORA   A         
	DCX   H         
	PUSH  B         
	JZ    L099DH    
L0CD4H:	MVI   M,2CH     
	JMP   L0CDEH    
	
	
; ======================================================
; READ statement
; ======================================================
	PUSH  H         
	LHLD  FBB8H     ; Address where DATA search will begin next
	ORI   AFH       
	STA   FB98H     
	XTHL            
	JMP   L0CE8H    
	
L0CE6H:	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
L0CE8H:	CALL  L4790H    ; Find address of variable at M
	XTHL            
	PUSH  D         
	MOV   A,M       
	CPI   2CH       
	JZ    L0D0EH    
	LDA   FB98H     
	ORA   A         
	JNZ   L0D82H    
	MVI   A,3FH     
	RST   4         ; Send character in A to screen/printer
	CALL  L463EH    ; Input and display line and store
	POP   D         
	POP   B         
	JC    L40B3H    
	INX   H         
	MOV   A,M       
	DCX   H         
	ORA   A         
	PUSH  B         
	JZ    L099DH    
	PUSH  D         
L0D0EH:	CALL  L421AH    
	JNZ   L4F4DH    
	RST   5         ; Determine type of last var used
	PUSH  PSW       
	JNZ   L0D3DH    
	RST   2         ; Get next non-white char from M
	MOV   D,A       
	MOV   B,A       
	CPI   22H       
	JZ    L0D2EH    
	LDA   FB98H     
	ORA   A         
	MOV   D,A       
	JZ    L0D2BH    
	MVI   D,3AH     
L0D2BH:	MVI   B,2CH     
	DCX   H         
L0D2EH:	CALL  L276FH    
L0D31H:	POP   PSW       
	ADI   03H       
	XCHG            
	LXI   H,L0D45H  
	XTHL            
	PUSH  D         
	JMP   L09D7H    
	
L0D3DH:	RST   2         ; Get next non-white char from M
	LXI   B,L0D31H  
	PUSH  B         
	JMP   L3840H    ; Convert ASCII number at M to double precision in FAC1
	
L0D45H:	DCX   H         
	RST   2         ; Get next non-white char from M
	JZ    L0D4FH    
	CPI   2CH       
	JNZ   L0C87H    
L0D4FH:	XTHL            
	DCX   H         
	RST   2         ; Get next non-white char from M
	JNZ   L0CE6H    
	POP   D         
	LDA   FB98H     
	ORA   A         
	XCHG            
	JNZ   L4095H    
	PUSH  D         
	CALL  L421AH    
	JNZ   L0D6DH    
	MOV   A,M       
	ORA   A         
	LXI   H,L0D71H  ; Load pointer to "?Extra ignored" text
	CNZ   L27B1H    ; Print buffer at M until NULL or '"'
L0D6DH:	POP   H         
	JMP   L0C39H    ; Jump to routine to terminate running BASIC?
	
L0D71H:
    DB	"?Extraignored",0DH,0AH,00H
	
L0D82H:	CALL  L099EH    ; DATA statement
	ORA   A         
	JNZ   L0D9BH    
	INX   H         
	MOV   A,M       
	INX   H         
	ORA   M         
	MVI   E,04H     ; Load code for OD Error (Out of Data)
	JZ    L045DH    ; Generate error in E
	INX   H         
	MOV   E,M       
	INX   H         
	MOV   D,M       
	XCHG            
	SHLD  FB94H     ; Line number of current data statement
	XCHG            
L0D9BH:	RST   2         ; Get next non-white char from M
	CPI   83H       
	JNZ   L0D82H    
	JMP   L0D0EH    
	
L0DA4H:	RST   1         ; Compare next byte with M
    DB	DDH             ; Test for '=' token ID
	JMP   L0DABH    ; Main BASIC evaluation routine
	
L0DA9H:	RST   1         ; Compare next byte with M
    DB	28H             ; Test for '('
	
; ======================================================
; Main BASIC evaluation routine
; ======================================================
L0DABH:	DCX   H         
L0DACH:	MVI   D,00H     
L0DAEH:	PUSH  D         
	MVI   C,01H     ; Prepare to test for 2 bytes free stack space
	CALL  L3EFFH    ; Test for 2 bytes free in stack space
	CALL  L0F1CH    ; Evaluate function at M
L0DB7H:	SHLD  FBA8H     ; Save new pointer to input string
L0DBAH:	LHLD  FBA8H     ; Restore pointer to input string
	POP   B         
	MOV   A,M       ; Get next token from input
	SHLD  FB8EH     ; Save new pointer to input string
	CPI   D0H       ; Compare token with '+'
	RC              ; RETurn to perform next level of precedence operation
	CPI   DFH       ; Compare with "SGN" function
	RNC             ; RETurn to perform next level of precedence operation
	CPI   DCH       ; Compare with '>'
	JNC   L0E29H    ; Jump to handle '>', '=', '<' operators
	SUI   D0H       ; Make operator token zero based
	MOV   E,A       ; Save zero-based operator token in E
	JNZ   L0DDCH    ; Skip string concatenation test if not '+' token
	LDA   FB65H     ; Type of last variable used
	CPI   03H       ; Test if last type was String
	MOV   A,E       ; Copy token to A
	JZ    L28CCH    ; Jump (to string concat?) if last variable type was string
L0DDCH:	LXI   H,L02E2H  ; Load pointer to operator order of precedence table maybe?
	MVI   D,00H     ; Make MSB of operator token zero
	DAD   D         ; Index into order of precedence table
	MOV   A,B       
	MOV   D,M       ; Get order of precedence from table
	CMP   D         
	RNC             
	PUSH  B         
	LXI   B,L0DBAH  ; Address of BASIC eval routine for nested evaluations
	PUSH  B         ; Push address to stack
	MOV   A,D       
	CPI   51H       
	JC    L0E45H    
	ANI   FEH       
	CPI   7AH       
	JZ    L0E45H    
L0DF8H:	LXI   H,FC1AH   ; Start of FAC1 for integers
	LDA   FB65H     ; Type of last variable used
	SUI   03H       ; Test if last type was String
	JZ    L045BH    ; Generate TM error
	ORA   A         
	LHLD  FC1AH     ; Start of FAC1 for integers
	PUSH  H         
	JM    L0E1AH    
	LHLD  FC18H     ; Start of FAC1 for single and double precision
	PUSH  H         
	JPO   L0E1AH    
	LHLD  FC1EH     
	PUSH  H         
	LHLD  FC1CH     
	PUSH  H         
L0E1AH:	ADI   03H       
	MOV   C,E       
	MOV   B,A       
	PUSH  B         
	LXI   B,L0E6CH  ; Load pointer to ??? operation vector
L0E22H:	PUSH  B         ; PUSH operation vector to RETurn to later
	LHLD  FB8EH     ; Restore pointer to input string
	JMP   L0DAEH    ; Jump to continue evaluation
	
L0E29H:	MVI   D,00H     
L0E2BH:	SUI   DCH       
	JC    L0E51H    
	CPI   03H       
	JNC   L0E51H    
	CPI   01H       
	RAL             
	XRA   D         
	CMP   D         
L0E3AH:	MOV   D,A       
	JC    ERRSYN    ; Generate Syntax error
	SHLD  FB8EH     
	RST   2         ; Get next non-white char from M
	JMP   L0E2BH    
	
L0E45H:	PUSH  D         
	CALL  L3501H    ; CINT function
	POP   D         
	PUSH  H         
	LXI   B,L1072H  ; Load pointer to vector for handling logic functions
	JMP   L0E22H    ; PUSH operator vector and continue evaluation
	
L0E51H:	MOV   A,B       
	CPI   64H       
	RNC             
	PUSH  B         
	PUSH  D         
	LXI   D,L6405H  
	LXI   H,L1047H  
	PUSH  H         
	RST   5         ; Determine type of last var used
	JNZ   L0DF8H    
	LHLD  FC1AH     ; Start of FAC1 for integers
	PUSH  H         
	LXI   B,L270CH  
	JMP   L0E22H    ; PUSH operator vector and continue evaluation
	
L0E6CH:	POP   B         
	MOV   A,C       
	STA   FB66H     ; Clear tokenization flags
	LDA   FB65H     ; Type of last variable used
	CMP   B         ; Test if last type matches type from Stack
	JNZ   L0E85H    
	CPI   02H       ; Test if last type as integer
	JZ    L0EA1H    
	CPI   04H       ; Test if last type was Single Precision
	JZ    L0EF0H    
	JNC   L0EB4H    
L0E85H:	MOV   D,A       
	MOV   A,B       
	CPI   08H       
	JZ    L0EB1H    
	MOV   A,D       
	CPI   08H       ; Test if last variable type was Double Precision
	JZ    L0ED8H    
	MOV   A,B       
	CPI   04H       
	JZ    L0EEDH    
	MOV   A,D       
	CPI   03H       ; Test if last variable type was String
	JZ    L045BH    ; Generate TM error
	JNC   L0EF8H    
L0EA1H:	LXI   H,L0310H  
	MVI   B,00H     
	DAD   B         
	DAD   B         
	MOV   C,M       
	INX   H         
	MOV   B,M       
	POP   D         
	LHLD  FC1AH     ; Start of FAC1 for integers
	PUSH  B         
	RET             
	
L0EB1H:	CALL  L35BAH    ; CDBL function
L0EB4H:	CALL  L3484H    ; Copy FAC1 to FAC2
	POP   H         
	SHLD  FC1CH     
	POP   H         
	SHLD  FC1EH     
L0EBFH:	POP   B         
	POP   D         
	CALL  L3432H    ; Load single precision in BCDE to FAC1
L0EC4H:	CALL  L35BAH    ; CDBL function
	LXI   H,L02F8H  
L0ECAH:	LDA   FB66H     ; Get tokenization flags
	RLC             
	ADD   L         
	MOV   L,A       
	ADC   H         
	SUB   L         
	MOV   H,A       
	MOV   A,M       
	INX   H         
	MOV   H,M       
	MOV   L,A       
	PCHL            
	
L0ED8H:	MOV   A,B       
	PUSH  PSW       
	CALL  L3484H    ; Copy FAC1 to FAC2
	POP   PSW       
	STA   FB65H     ; Type of last variable used
	CPI   04H       ; Test if last type was Single Precision
	JZ    L0EBFH    
	POP   H         
	SHLD  FC1AH     ; Start of FAC1 for integers
	JMP   L0EC4H    
	
L0EEDH:	CALL  L352AH    ; CSNG function
L0EF0H:	POP   B         
	POP   D         
L0EF2H:	LXI   H,L0304H  
	JMP   L0ECAH    
	
L0EF8H:	POP   H         
	CALL  L3422H    ; Push single precision FAC1 on stack
	CALL  L3543H    ; Convert signed integer HL to single precision FAC1
	CALL  L343DH    ; Load single precision FAC1 to BCDE
	POP   H         
	SHLD  FC18H     ; Start of FAC1 for single and double precision
	POP   H         
	SHLD  FC1AH     ; Start of FAC1 for integers
	JMP   L0EF2H    
	
	
; ======================================================
; Integer Divide FAC1=DE/HL
; ======================================================
L0F0DH:	PUSH  H         
	XCHG            
	CALL  L3543H    ; Convert signed integer HL to single precision FAC1
	POP   H         
	CALL  L3422H    ; Push single precision FAC1 on stack
	CALL  L3543H    ; Convert signed integer HL to single precision FAC1
	JMP   L380CH    
	
	
; ======================================================
; Evaluate function at M
; ======================================================
L0F1CH:	RST   2         ; Get next non-white char from M
	JZ    L0458H    ; Generate MO error
	JC    L3840H    ; Convert ASCII number at M to double precision in FAC1
	CALL  L40F2H    ; Check if A is alpha character
	JNC   L0FDAH    ; Evaluate variable
	CPI   D0H       ; If not alpha, test for '+' token ID
	JZ    L0F1CH    ; Evaluate function at M
	CPI   2EH       ; Test for '.'
	JZ    L3840H    ; Convert ASCII number at M to double precision in FAC1
	CPI   D1H       ; Test for '-' token ID
	JZ    L0FCCH    ; Handle '-' during evaluation
	CPI   22H       ; Test for '"'
	JZ    L276CH    
	CPI   CEH       ; Test for NOT function
	JZ    L1054H    ; NOT function
	CPI   C5H       ; Test for ERR function
	JNZ   L0F51H    ; Jump if not ERR function
	
; ======================================================
; ERR function
; ======================================================
	RST   2         ; Get next non-white char from M
	LDA   F672H     ; Last Error code
	PUSH  H         
	CALL  L10D1H    ; Load integer in A into FAC1
	POP   H         
	RET             
	
L0F51H:	CPI   C4H       ; Test for ERL function
	JNZ   L0F60H    ; Branch if not ERL
	
; ======================================================
; ERL function
; ======================================================
	RST   2         ; Get next non-white char from M
	PUSH  H         
	LHLD  FB9FH     ; Line number of last error
	CALL  L37DBH    ; Convert unsigned HL to single precision in FAC1
	POP   H         
	RET             
	
L0F60H:	CPI   AAH       ; TIME$ token
	JZ    L1904H    ; TIME$ function
	CPI   ABH       ; DATE$ token
	JZ    L1924H    ; Jump to DATE$ function
	CPI   ACH       ; DAY token
	JZ    L1955H    ; DAY function
	CPI   B7H       ; MAX token
	JZ    L1D9BH    ; MAX function
	CPI   CCH       ; HIMEM token
	JZ    L1DB9H    ; HIMEM function
	CPI   C3H       ; VARPTR token
	JNZ   L0FA3H    ; Jump if not VARPTR to test more
	
; ======================================================
; VARPTR function
; ======================================================
	RST   2         ; Get next non-white char from M
	RST   1         ; Compare next byte with M
    DB	28H             ; Test for '('
	CPI   23H       
	JNZ   L0F92H    ; VARPTR(variable) function
	
; ======================================================
; VARPTR(#buffer) function
; ======================================================
	CALL  L112DH    ; Evaluate expression at M
	PUSH  H         
	CALL  L4C84H    ; Get file descriptor for file in A
	XCHG            
	POP   H         
	JMP   L0F95H    
	
	
; ======================================================
; VARPTR(variable) function
; ======================================================
L0F92H:	CALL  L482CH    
L0F95H:	RST   1         ; Compare next byte with M
    DB	29H             ; Test for ')'
	PUSH  H         
	XCHG            
	MOV   A,H       
	ORA   L         
	JZ    L08DBH    ; Generate FC error
	CALL  L3510H    ; Load signed integer in HL to FAC1
	POP   H         
	RET             
	
L0FA3H:	CPI   C7H       
	JZ    L2A37H    ; INSTR function
	CPI   C9H       
	JZ    L4BEAH    ; INKEY$ function
	CPI   C6H       
	JZ    L296DH    ; STRING$ function
	CPI   84H       
	JZ    L4E8EH    ; INPUT statement
	CPI   CAH       
	JZ    L1D90H    ; CSRLIN function
	CPI   C8H       
	JZ    L5073H    ; DSKI$ function
	SUI   DFH       ; Compare with SGN token to test for function
	JNC   L0FF2H    ; Jump if SGN or higher (function)
L0FC6H:	CALL  L0DA9H    
	RST   1         ; Compare next byte with M
    DB	29H             ; ')'
	RET             
	
L0FCCH:	MVI   D,7DH     
	CALL  L0DAEH    
	LHLD  FBA8H     
	PUSH  H         
	CALL  L33F6H    ; Call to take ABS value
L0FD8H:	POP   H         
	RET             
	
	
; ======================================================
; Evaluate variable
; ======================================================
L0FDAH:	CALL  L4790H    ; Find address of variable at M
L0FDDH:	PUSH  H         ; Save address of variable on stack
	XCHG            
	SHLD  FC1AH     ; Start of FAC1 for integers
	RST   5         ; Determine type of last var used
	CNZ   L347EH    ; Copy variable if not string type
	POP   H         ; Get address of variable from stack
	RET             
	
	
; ======================================================
; Get char at M and convert to uppercase
; ======================================================
L0FE8H:	MOV   A,M       ; Get next character from input string
	
; ======================================================
; Convert A to uppercase
; ======================================================
L0FE9H:	CPI   61H       ; Test if >= 'a'
	RC              ; Return if not
	CPI   7BH       ; Test if <= 'z'
	RNC             ; Return if not
	ANI   5FH       ; Make uppercase
	RET             
	
L0FF2H:	MVI   B,00H     ; Set MSB of modified BASIC token to zero
	RLC             ; Multiply modified zero based token x2
	MOV   C,A       ; Save in C
	PUSH  B         ; And PUSH to the stack. Now we process function args.
	RST   2         ; Get next non-white char from M
	MOV   A,C       ; Restore modified BASIC token
	CPI   39H       ; Test for string functions (STR$-MID$)
	JC    L1015H    ; Jump if not string function to handle SGN-ASC
	CALL  L0DA9H    
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	CALL  L35D9H    ; Generate TM error if last variable type not string or RET
	XCHG            
	LHLD  FC1AH     ; Start of FAC1 for integers
	XTHL            ; Get function index from stack
	PUSH  H         ; And PUSH it back to the stack
	XCHG            
	CALL  L112EH    ; Evaluate expression at M-1
	XCHG            
	XTHL            ; Get function index from stack
	JMP   L102EH    ; Lookup function (SGN-MID$) vector and Jump to it
	
L1015H:	CALL  L0FC6H    
	XTHL            ; Get function index from stack
	MOV   A,L       
	CPI   0EH       
	JC    L102AH    
	CPI   1DH       
	JNC   L102AH    
	RST   5         ; Determine type of last var used
	PUSH  H         
	CC    L35BAH    ; CDBL function
	POP   H         
L102AH:	LXI   D,L0FD8H  
	PUSH  D         
L102EH:	LXI   B,L0040H  ; Function vector table for SGN to MID$
L1031H:	DAD   B         ; Index into Function vector table based on HL
	MOV   C,M       ; Get LSB of function address
	INX   H         ; Increment to MSB
	MOV   H,M       ; Get MSB of function address
	MOV   L,C       ; Copy LSB to HL
	PCHL            ; Jump to function
	
	
; ======================================================
; ASCII num conversion - find ASCII or tokenized '+' or '-' in A
; ======================================================
L1037H:	DCR   D         
	CPI   D1H       
	RZ              
	CPI   2DH       
	RZ              
	INR   D         
	CPI   2BH       
L1041H:	RZ              
	CPI   D0H       
	RZ              
	DCX   H         
	RET             
	
L1047H:	INR   A         
	ADC   A         
	POP   B         
	ANA   B         
	ADI   FFH       
	SBB   A         
	CALL  L340AH    ; SGN function
	JMP   L1066H    
	
	
; ======================================================
; NOT function
; ======================================================
L1054H:	MVI   D,5AH     
	CALL  L0DAEH    
	CALL  L3501H    ; CINT function
	MOV   A,L       
	CMA             
	MOV   L,A       
	MOV   A,H       
	CMA             
	MOV   H,A       
	SHLD  FC1AH     ; Start of FAC1 for integers
	POP   B         
L1066H:	JMP   L0DBAH    
	
	
; ======================================================
; RST 28H routine
; ======================================================
L1069H:	LDA   FB65H     ; Type of last variable used
	CPI   08H       ; Compare with Double Precision to set C flag (Clear if Dbl)
	DCR   A         ;
	DCR   A         ; Decrement type 3 times to set Z, P and S flags
	DCR   A         ;
	RET             ; Return with flags set / cleared
	
L1072H:	MOV   A,B       
	PUSH  PSW       
	CALL  L3501H    ; CINT function
	POP   PSW       
	POP   D         
	CPI   7AH       
	JZ    L37DFH    
	CPI   7BH       
	JZ    L377EH    ; Signed integer divide (FAC1=DE/HL)
	LXI   B,L10D3H  
	PUSH  B         
	CPI   46H       
	JNZ   L1092H    
	
; ======================================================
; OR function
; ======================================================
	MOV   A,E       ; Move LSB of DE to A
	ORA   L         ; OR LSB of HL
	MOV   L,A       ; Save in L
	MOV   A,H       ; Move MSB of HL to A
	ORA   D         ; OR MSB of DE
	RET             
	
L1092H:	CPI   50H       ; Compare A with AND token
	JNZ   L109DH    ; Jump if not AND to test XOR
	
; ======================================================
; AND function
; ======================================================
	MOV   A,E       ; Move LSB of DE to A
	ANA   L         ; AND LSB with HL
	MOV   L,A       ; Save in L
	MOV   A,H       ; Move MSB of HL to A
	ANA   D         ; AND with D
	RET             
	
L109DH:	CPI   3CH       ; Compare A with XOR token
	JNZ   L10A8H    ; Jump if not XOR to test EQV
	
; ======================================================
; XOR function
; ======================================================
	MOV   A,E       ; Move LSB of DE to A
	XRA   L         ; XOR with LSB of HL
	MOV   L,A       ; Save in L
	MOV   A,H       ; Move MSB of HL to A
	XRA   D         ; XOR with MSB of DE
	RET             
	
L10A8H:	CPI   32H       ; Compare A with EQV token
	JNZ   L10B5H    ; IMP function
	
; ======================================================
; EQV function
; ======================================================
	MOV   A,E       ; Move LSB of DE to A
	XRA   L         ; XOR with LSB of HL
	CMA             ; Compliment the result
	MOV   L,A       ; And save in L
	MOV   A,H       ; Move MSB of HL to A
	XRA   D         ; XOR with D
	CMA             ; Compliment that result
	RET             
	
	
; ======================================================
; IMP function
; ======================================================
L10B5H:	MOV   A,L       ; Load LSB of HL
	CMA             ; Compliment HL
	ANA   E         ; AND with LSB of DE
	CMA             ; Compliment the result
	MOV   L,A       ; Save in A
	MOV   A,H       ; Get MSB of HL
	CMA             ; Compliment HL
	ANA   D         ; AND with MSB of DE
	CMA             ; Compliment the result
	RET             
	
L10BFH:	MOV   A,L       ; Load LSB of HL
	SUB   E         ; Subtract LSB of DE
L10C1H:	MOV   L,A       ; Save the result in HL
	MOV   A,H       ; Load MSB of HL
	SBB   D         ; Subtract MSB of DE (with borrow)
	MOV   H,A       ; Save the result in HL
	JMP   L37DBH    ; Convert unsigned HL to single precision in FAC1
	
	
; ======================================================
; LPOS function
; ======================================================
	LDA   VLPPCL    ; Line printer head position
	JMP   L10D1H    ; Load integer in A into FAC1
	
	
; ======================================================
; POS function
; ======================================================
	LDA   F788H     ; Horiz. position of cursor (0-39)
	
; ======================================================
; Load integer in A into FAC1
; ======================================================
L10D1H:	MOV   L,A       
	XRA   A         
L10D3H:	MOV   H,A       
	JMP   L3510H    ; Load signed integer in HL to FAC1
	
L10D7H:	PUSH  H         ; Preserve HL on stack
	ANI   07H       ; Limit to 7 function pointers
	LXI   H,L02EEH  ; Vector table for math operations
	MOV   C,A       
	MVI   B,00H     
	DAD   B         
	CALL  L1031H    ; Lookup vector of function (index x2 in HL) and Jump to it
	POP   H         ; Restore HL
	RET             
	
	
; ======================================================
; Check for running program
; ======================================================
L10E6H:	PUSH  H         
	LHLD  F67AH     ; Current executing line number
	INX   H         
	MOV   A,H       
	ORA   L         
	POP   H         
	RNZ             
	
; ======================================================
; Generate ID error
; ======================================================
	MVI   E,0CH     ; Load code for ID Error (Illegal Direct)
	JMP   L045DH    ; Generate error in E
	
L10F4H:	CPI   7EH       ; Test if command is '~'
	JNZ   ERRSYN    ; Generate Syntax error
	INX   H         ; Skip to next byte in command string
	JMP   L2AC2H    
	
	JMP   ERRSYN    ; Generate Syntax error
	
	
; ======================================================
; INP function
; ======================================================
L1100H:	CALL  L1131H    ; Get expression integer < 256 in A or FC Error
	STA   F66BH     ; Save port number as argument to IN
	CALL  F66AH     ; Call the RAM based IN hook
	JMP   L10D1H    ; Load integer in A into FAC1
	
	
; ======================================================
; OUT statement
; ======================================================
	CALL  L111FH    ; Call to process arguments to OUT statement
	JMP   F667H     ; Jump to RAM based hook
	
	
; ======================================================
; Evaluate expression at M
; ======================================================
L1112H:	RST   2         ; Get next non-white char from M
	
; ======================================================
; Evaluate expression at M-1
; ======================================================
L1113H:	CALL  L0DABH    ; Main BASIC evaluation routine
L1116H:	PUSH  H         ; Preserve HL on stack
	CALL  L3501H    ; CINT function
	XCHG            ; Put Integer into DE
	POP   H         ; Restore HL
	MOV   A,D       ; Move MSB of integer to A to test if > 255
	ORA   A         ; Test if integer > 255
	RET             
	
L111FH:	CALL  L112EH    ; Evaluate expression at M-1
	STA   F66BH     ; Save port # as argument to IN? Why?
	STA   F668H     ; Save port # as argument to OUT. Ok.
	RST   1         ; Compare next byte with M
    DB	2CH             ; Compare next byte with ","
	JMP   L112EH    ; Evaluate expression at M-1
	
	
; ======================================================
; Evaluate expression at M
; ======================================================
L112DH:	RST   2         ; Get next non-white char from M
	
; ======================================================
; Evaluate expression at M-1
; ======================================================
L112EH:	CALL  L0DABH    ; Main BASIC evaluation routine
L1131H:	CALL  L1116H    ; Convert to integer in DE and test if 255 or less
	JNZ   L08DBH    ; Generate FC error
	DCX   H         ; Decrement input string pointer
	RST   2         ; Get next non-white char from M
	MOV   A,E       ; Copy LSB of integer to A
	RET             
	
	
; ======================================================
; LLIST statement
; ======================================================
	MVI   A,01H     
	STA   VOUTSW    ; Output device for RST 20H (0=screen)
	
; ======================================================
; LIST statement
; ======================================================
L1140H:	POP   B         
	CALL  L060AH    ; Evaluate LIST statement arguments
	PUSH  B         
	MOV   H,B       
	MOV   L,C       
	SHLD  FABAH     ; Address where last BASIC list started
L114AH:	LXI   H,FFFFH   
	SHLD  F67AH     ; Current executing line number
	POP   H         
	SHLD  FABCH     
	POP   D         
	MOV   C,M       
	INX   H         
	MOV   B,M       
	INX   H         
	MOV   A,B       
	ORA   C         
	JZ    L1195H    
	CALL  L421AH    
	CZ    L13F3H    
	PUSH  B         
	MOV   C,M       
	INX   H         
	MOV   B,M       
	INX   H         
	PUSH  B         
	XTHL            
	XCHG            
	RST   3         ; Compare DE and HL
	POP   B         
	JC    L1194H    
	XTHL            
	PUSH  H         
	PUSH  B         
	XCHG            
	SHLD  FBA1H     ; Most recent used or entered line number
	CALL  L39D4H    ; Print binary number in HL at current position
	POP   H         
	MOV   A,M       
	CPI   09H       
	JZ    L1185H    
	MVI   A,20H     
	RST   4         ; Send character in A to screen/printer
L1185H:	CALL  L11AAH    
	LXI   H,VKYBBF  ; Keyboard buffer
	CALL  L11A2H    ; Send buffer at M to screen
	CALL  L4BCBH    
	JMP   L114AH    
	
L1194H:	POP   B         
L1195H:	LDA   F651H     ; In TEXT because of BASIC EDIT flag
	ANA   A         
	JNZ   L5E82H    
	MVI   A,1AH     
	RST   4         ; Send character in A to screen/printer
	JMP   L0502H    ; Vector to BASIC ready - print Ok
	
	
; ======================================================
; Send buffer at M to screen
; ======================================================
L11A2H:	MOV   A,M       ; Get next byte to send to screen
	ORA   A         ; Test for NULL termination
	RZ              ; Return if NULL found
	RST   4         ; Send character in A to screen/printer
	INX   H         ; Increment the buffer pointer
	JMP   L11A2H    ; Send buffer at M to screen
	
L11AAH:	LXI   B,VKYBBF  ; Keyboard buffer
	MVI   D,FFH     
	XRA   A         
	STA   FB66H     ; Clear tokenization flags
	JMP   L11B9H    
	
L11B6H:	INX   B         
	DCR   D         
	RZ              
L11B9H:	MOV   A,M       
	INX   H         
	ORA   A         
	STAX  B         
	RZ              
	CPI   22H       ; Test for open quote
	JNZ   L11CDH    ; Jump if not quote
	LDA   FB66H     ; Load tokenization flags
	XRI   01H       ; Invert "in-quote" marker
	STA   FB66H     ; Save back to tokenization flags
	MVI   A,22H     ; Reload quote character to A
L11CDH:	CPI   3AH       ; Test for colon
	JNZ   L11E1H    ; Jump if not colon
	LDA   FB66H     ; Get tokenization flags
	RAR             
	JC    L11DFH    
	RAL             
	ANI   FDH       
	STA   FB66H     ; Save tokenization flags
L11DFH:	MVI   A,3AH     
L11E1H:	ORA   A         
	JP    L11B6H    
	LDA   FB66H     ; Get tokenization flags
	RAR             
	JC    L11B6H    
	DCX   H         
	RAR             
	RAR             
	JNC   L1233H    
	MOV   A,M       
	CPI   FFH       
	PUSH  H         
	PUSH  B         
	LXI   H,L121AH  
	PUSH  H         
	RNZ             
	DCX   B         
	LDAX  B         
	CPI   4DH       
	RNZ             
	DCX   B         
	LDAX  B         
	CPI   45H       
	RNZ             
	DCX   B         
	LDAX  B         
	CPI   52H       
	RNZ             
	DCX   B         
	LDAX  B         
	CPI   3AH       
	RNZ             
	POP   PSW       
	POP   PSW       
	POP   H         
	INR   D         
	INR   D         
	INR   D         
	INR   D         
	JMP   L1242H    
	
L121AH:	POP   B         
	POP   H         
	MOV   A,M       
L121DH:	INX   H         
	JMP   L11B6H    
	
L1221H:	LDA   FB66H     ; Get tokenization flags
	ORI   02H       
L1226H:	STA   FB66H     ; Clear tokenization flags
	XRA   A         
	RET             
	
L122BH:	LDA   FB66H     ; Get tokenization flags
	ORI   04H       
	JMP   L1226H    
	
L1233H:	RAL             
	JC    L121DH    
	MOV   A,M       
	CPI   83H       
	CZ    L1221H    
	CPI   8EH       
	CZ    L122BH    
L1242H:	MOV   A,M       
	INX   H         
	CPI   91H       
	CZ    L3643H    
	SUI   7FH       
	PUSH  H         
	MOV   E,A       
	LXI   H,L0080H  ; BASIC statement keyword table END to NEW
L1250H:	MOV   A,M       
	INX   H         
	ORA   A         
	JP    L1250H    
	DCR   E         
	JNZ   L1250H    
	ANI   7FH       
L125CH:	STAX  B         
	INX   B         
	DCR   D         
	JZ    L27E2H    
	MOV   A,M       
	INX   H         
	ORA   A         
	JP    L125CH    
	POP   H         
	JMP   L11B9H    
	
L126CH:	XCHG            
	LHLD  FBB2H     ; Start of variable data pointer
L1270H:	LDAX  D         
	STAX  B         
	INX   B         
	INX   D         
	RST   3         ; Compare DE and HL
	JNZ   L1270H    
	MOV   H,B       
	MOV   L,C       
	SHLD  FBB2H     ; Start of variable data pointer
	SHLD  FBB4H     ; Start of array table pointer
	SHLD  FBB6H     ; Unused memory pointer
	RET             
	
	
; ======================================================
; PEEK function
; ======================================================
	CALL  L12A1H    ; Convert last expression to integer (-32768 to 65535) or OV
	MOV   A,M       ; Load A from (HL)
	JMP   L10D1H    ; Load integer in A into FAC1
	
	
; ======================================================
; POKE function
; ======================================================
	CALL  L1297H    ; Evaluate expression at M
	PUSH  D         ; Save POKE address to stack
	RST   1         ; Compare next byte with M
    DB	2CH             ; ','
	CALL  L112EH    ; Evaluate expression at M-1
	POP   D         ; Get POKE address form stack
	STAX  D         ; POKE the value in a to (DE)
	RET             
	
	
; ======================================================
; Evaluate expression at M
; ======================================================
L1297H:	CALL  L0DABH    ; Main BASIC evaluation routine
	PUSH  H         
	CALL  L12A1H    ; Convert last expression to integer (-32768 to 65535) or OV
	XCHG            
	POP   H         
	RET             
	
L12A1H:	LXI   B,L3501H  ; CINT function
	PUSH  B         
	RST   5         ; Determine type of last var used
	RM              ; Return to CINT function if last var was integer
	RST   6         ; Get sign of FAC1
	RM              ; Return to CINT function if FAC1 negative
	CALL  L352AH    ; CSNG function
	LXI   B,L3245H  ; Load BCDE with Single precision for 32768.0
	LXI   D,8076H   ; "
	CALL  L3498H    ; Compare single precision in BCDE with FAC1
	RC              ; Return to CINT function if less than 32768
	LXI   B,L6545H  ; Load BCDE with Single precision for 65536.0
	LXI   D,L6053H  ; "
	CALL  L3498H    ; Compare single precision in BCDE with FAC1
	JNC   L0455H    ; Generate OV error
	LXI   B,L65C5H  ; Load BCDE with Single precision for -65536.0
	LXI   D,L6053H  ; "
	JMP   L37F4H    ; Single precision addition (FAC1=FAC1+BCDE)
	
	
; ======================================================
; L12CBH: Wait and get character from keyboard.
; Entry conditions: none
; Exit conditions:  A = character code
;           Carry -- set if special character
;                 -- reset if normal character
; (<F1> - <F8> return preprogrammed strings)
; ======================================================
CHGET:  PUSH H          ; Preserve HL on stack
        PUSH D          ; Preserve DE on stack
        PUSH B          ; Preserve BC on stack
        CALL WAITKY     ; Call routine to wait for key
        JMP  L14EEH
WAITKY: RST  7          ; Jump to RST 38H Vector entry of following byte
    DB  04H             ; CHGET Hook
; Process next byte of FKey text to "inject" the keys
        LHLD F62CH      ; Get MSB of pointer to FKey text (from FKey table) for selected FKey
        INR  H          ; Prepare to test if MSB of address is zero
        DCR  H          ; Test for zero
        JZ   PPBINJ     ; Jump to process paste buffer injection if no FKey selected
        MOV  B,M        ; Get next byte from selected FKey text
        MOV  A,B        ; Prepare to test if at end of FKey text
        ORA  A          ; Test for NULL termination
        JZ   L12EA      ; Jump ahead of at end of text
        INX  H          ; Look ahead to the next byte to see if we are at the end of the FKey text
        MOV  A,M        ; Get the byte after this one
        ORA  A          ; And test for zero
        JNZ  L12EB      ; Jump to save updated FKey address if not at end
L12EA:  MOV  H,A        ; Load zero into H to indicate FKey no longer active
L12EB:  SHLD F62CH      ; Save updated address of active FKey text
        MOV  A,B        ; Get the next byte of the FKey text as our "Key"
        RET
; Process PASTE key from keyboard
PPASTE: LDA  F650H
        ADD  A
        RC
        LXI  H,0000H   ; Initialize index of next byte to paste from paste buffer
        SHLD F62EH      ; Save as index of next byte to paste from paste buffer
        MVI  A,0DH      ; Prepare to initialize "last paste char" as ENTER
        STA  FAA1H      ; Initialize "last paste char" as ENTER
; Jump to process paste buffer injection if no FKey selected
PPBINJ: LHLD F62EH      ; Get index into paste buffer
        MOV  A,L        ; Get LSB of length?
        ANA  H          ; And with MSB
        INR  A          ; Increment to test for FFFFH
        JZ   TKEYCH     ; Jump if not actively pasting from paste buffer
        PUSH H          ; PUSH index to stack
        LDA  FAA1H      ; Get value of last paste character
        CPI  0DH        ; Test if it was ENTER
        CZ   L2146H     ; Update system pointers for .DO), .CO), vars), etc.
        LHLD F9A5H      ; Start of Paste Buffer
        POP  D          ; Restore index of next byte in paste buffer
        DAD  D          ; Point to next byte to paste from paste buffer
        MOV  A,M        ; Get the next byte to paste
        STA  FAA1H      ; Store it as the "last paste character"
        MOV  B,A        ; Save byte in B
        CPI  1AH        ; Test for end of paste buffer marker maybe
        MVI  A,00H      ; Replace EOL marker with zero in case of match
        JZ   ENDPBF     ; Jump if end of paste buffer
        CALL KEYX       ; Check keyboard queue for pending characters
        JC   ENDPBF     ; If there is keyboard action, halt the paste operation perhaps?
        INX  H          ; Point to next byte in paste buffer
        MOV  A,M        ; Peek the next byte in paste buffer to see if at end
        XCHG            ; Put index into paste buffer into HL
        INX  H          ; Increment the index count
        SHLD F62EH      ; Save as index into paste buffer of next byte to paste
        CPI  1AH        ; Test if next byte past current byte is end of buffer marker
        MOV  A,B        ; Restore the byte to be pasted from B
        STC             ; Set the C flag
        CMC             ; And now clear it
        RNZ             ; And return if not at end of paste buffer
; At end of paste buffer.
ENDPBF: LXI  H,FFFFH    ; Load value indication paste is "inactive"
        SHLD F62EH      ; And store it as the active index of paste from paste buffer
        RET             ; Now return the next byte from the paste buffer to "inject"
; Test for actual keystroke characters to process
TKEYCH: CALL CHSNS      ; Check keyboard queue for pending characters
        JNZ  L1358
        CALL CONIOB
        MVI  A,FFH
        STA  VPROFS     ; Power off exit condition switch
CKQPDL: CALL CHSNS      ; Check keyboard queue for pending characters
        JZ  CKQPDL
        XRA  A
        STA  VPROFS     ; Power off exit condition switch
        CALL COFIOB     ; Turn cursor back off if it was off before
L1358:  LXI  H,F932H
        MOV  A,M
        ANA  A
        JNZ  L13B5
        CALL L1BB1H     ; Renew automatic power-off counter
        CALL KYREAD     ; Scan keyboard for character (CTRL-BREAK ==> CTRL-C)
        RNC
        SUI  0BH        ; Test for PASTE key
        JZ   PPASTE     ; Jump to process PASTE key if zero
        JNC  L13C0
        INR  A          ; Test for SHIFT-PRINT key
        JZ   PKYSEQ     ; Jump to process special "Paste" of SHIFT-PRINT key sequence
        INR  A
        JZ  L1E5EH      ; LCOPY statement
        INR  A          ; Test for LABEL key
        JZ  TOGLAB      ; Toggle function key label line
        MOV  E,A
        LDA  F650H
        ADD  A          ;
        ADD  A          ;
        MOV  A,E        ;
        RC              ;
        MVI  D,FFH      ;
        XCHG            ;   KDP: TODO: This is calculating the FKey table entry or FKeys somehow!
        DAD  H          ;
        DAD  H          ;
        DAD  H          ;
        DAD  H          ;
        LXI  D,F809H    ;
        DAD  D          ;
        LDA  F650H      ;
        ANA  A          ;
        JP   SHLPAT     ;
        INX  H
        INX  H
        INX  H
        INX  H

; Set HL as pointer to text to be "PASTED" / injected as keystrokes
SHLPAT: SHLD F62CH      ; Points to text for selected FKey from FKey table
        JMP  WAITKY     ; Wait for key from keyboard

; Process paste of key sequence defined for SHIFT-PRINT key
PKYSEQ: LHLD F88AH      ; Load pointer to SHIFT-PRINT key sequence for this mode
        JMP  SHLPAT     ; Jump to set HL as pointer to PASTE sequence

; Toggle function key label line	
TOGLAB: LDA  FAADH      ; Label line enable flag
        ANA  A          ; Test if Label line is enabled
        RZ              ; Return if not enabled
        LDA  VLABLF     ; Label line protect status
        XRI  FFH        ; Test if Label Line is on or off

; Erase or Display function key line based on Z flag
        JZ   ERAFNK     ; Erase function key display
        JMP  DSPNFK     ; Display function key line
L13B5:  DI              ; Disable interrupts for power-down
        MVI  M,00H
        LDA  VPROFT     ; Load power-down time (1/10th of a minute)
        DCX  H          ; Point to power-down count-down
        MOV  M,A        ; Update power-down count-down for next power-up
        CALL L143FH     ; Turn off computer
L13C0:  XRA  A
        RET

; Turn cursor on if not already during program pause
CONIOB: LDA  F63FH      ; Cursor status (0 = off)
        STA  FACBH      ; Storage if cursor was on before BASIC CTRL-S
        ANA  A
        RNZ
        CALL CURSON     ; Turn the cursor on
        JMP  SDESCX     ; Send ESC X
; Turn cursor back off if it was off before
COFIOB: LDA  FACBH
        ANA  A
        RNZ
        CALL CUROFF     ; Turn the cursor off
        JMP  SDESCX     ; Send ESC X
	
	
; ======================================================
; L13DBH: Check keyboard queue for characters
; Entry conditions: none
; Exit conditions:  Z flag set if queue empty,
;                   reset if keys pending
; ======================================================
CHSNS:  LDA  F62DH
        ANA  A
        RNZ
        LDA  F932H
        ANA  A
        RNZ
        PUSH H
        LHLD F62EH      ; Load index of active paste buffer paste operation
        MOV  A,L        ; Prepare to test for FFFFH
        ANA  H          ; AND in MSB to test for FFFFH
        INR  A          ; Test for FFFFH = paste operation inactive
        POP  H          ; Restore HL
        RNZ             ; Return if paste operation active
        RST  7          ; Jump to RST 38H Vector entry of following byte
    DB  06H
        JMP  KEYX       ; Check keyboard queue for pending characters

; Test for CTRL-C or CTRL-S during BASIC Execute
        CALL BRKCHK     ; Check for break or wait (CTRL-S)
        RZ
        CPI  03H        ; Test for CTRL-C
        JZ   ICTRLC     ; Jump if CTRL-C
        CPI  13H        ; Test for CTRL-S (pause)
        RNZ             ; Return if not CTRL-S - okay to execute
        CALL CONIOB     ; Turn cursor on if not already during program pause
NCTRLC: CALL BRKCHK     ; Check for break or wait (CTRL-S)
        CPI  13H        ; Test for CTRL-S
        JZ   COFIOB     ; Turn cursor back off if it was off before
        CPI  03H        ; Check for CTRL-C
        JNZ  NCTRLC     ; Jump if not CTRL-C
        CALL COFIOB     ; Turn cursor back off if it was already off
ICTRLC: XRA  A
        STA  FFAAH      ; Keyboard buffer count
        JMP  L409AH     ; STOP statement
	
	
; ======================================================
; POWER statement
; ======================================================
L1419H:	SUI   A4H       ; Test for CONT token
	JZ    L1459H    ; POWER CONT statement
	CPI   27H       ; Test for POWER OFF token
	JNZ   L1461H    ; POWER ON statement
	RST   2         ; Get next non-white char from M
	JZ    L1451H    ; If no arguments, jump to turn power off
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	RST   1         ; Compare next byte with M
    DB	95H             ; Test for RESUME token
	JNZ   ERRSYN    ; Generate Syntax error
	JMP   L143FH    ; Turn off computer
	
	
; ======================================================
; Normal TRAP (low power) interrupt routine
; ======================================================
L1431H:	PUSH  PSW       ; Preserve A on stack
	LDA   VPROFS    ; Power off exit condition switch
	ANA   A         ; Test if system state preserved through power cycle
	MVI   A,01H     ; Set new exit condition - don't preserve state
	STA   VPROFS    ; Power off exit condition switch
	JNZ   L1451H    ; Jump if not saving system state thru power cycle
	POP   PSW       ; Restore A from stack
	
; ======================================================
; Turn off computer
; ======================================================
L143FH:	DI              ; Disable interrupts for PowerDown
	PUSH  H         ; Push all registers so we can restore
	PUSH  D         ; to the same location upon next
	PUSH  B         ; power on cycle.
	PUSH  PSW       ;
	LXI   H,0000H  ; Prepare to save SP for Auto PowerDown
	DAD   SP        ; Get SP into HL
	SHLD  FABEH     ; SP save area for power up/down
	LXI   H,9C0BH   ; Load Auto PowerDown signaure
	SHLD  VSPOPD    ; Save Auto PowerDown signature
L1451H:	DI              ; Disable interrupts (again?)
	IN    BAH       ; Get Current I/O value of BAH
	ORI   10H       ; Set the PowerDown bit
	OUT   BAH       ; PowerDown. We will loose power here
	HLT             ; Issue a HLT as power may be left in CAPs, etc.
	
; ======================================================
; POWER CONT statement
; ======================================================
L1459H:	CALL  L1469H    ; Store zero to power down time & counter?
	STA   F932H     ; Store zero
	RST   2         ; Get next non-white char from M
	RET             
	
	
; ======================================================
; POWER ON statement
; ======================================================
L1461H:	CALL  L112EH    ; Evaluate expression at M-1
	CPI   0AH       ; Validate POWER argument is at least 10 (10 * 0.1 min)
	JC    L08DBH    ; Generate FC error
L1469H:	STA   VPROFT    ; Store POWER down time (1/10ths of a minute)
	STA   F931H     ; Update power-off countdown
	RET             
	
	
; ======================================================
; L1470H: Print character without expanding tab characters
; Entry conditions: A = character to be printed
; Exit conditions:  none
; ======================================================
PNOTAB: RST  7          ; Jump to RST 38H Vector entry of following byte
    DB  0AH
        CALL PRINTR     ; Send character in A to the printer
        JNC  L147F
        XRA  A
        STA  FACDH
        JMP  L1494H     ; Generate I/O error
L147F:  PUSH PSW
        MVI  A,FFH
        STA  FACDH
        CALL L1BB1H     ; Renew automatic power-off counter
        POP  PSW
        RET
	
	
; ======================================================
; Start tape and load tape header
; ======================================================
L148AH:	CALL  L14A8H    ; Turn cassette motor on
	CALL  L6F85H    ; Read cassette header and sync byte
	RNC             
L1491H:	CALL  L14AAH    ; Turn cassette motor off
	
; ======================================================
; Generate I/O error
; ======================================================
L1494H:	MVI   E,12H     ; Load code for I/O Error
	JMP   L045DH    ; Generate error in E
	
	
; ======================================================
; Turn cassette motor on and detect sync header
; ======================================================
L1499H:	CALL  L14A8H    ; Turn cassette motor on
	LXI   B,0000H  ; Zero out BC to delay prior to writing
L149FH:	DCX   B         ; Decrement BC
	MOV   A,B       ; Get MSB of count
	ORA   C         ; OR in LSB of count to test for zero
	JNZ   L149FH    ; Loop for 65536 cycle delay
	JMP   L6F46H    ; Write cassette header and sync byte
	
	
; ======================================================
; Turn cassette motor on
; ======================================================
L14A8H:	DI              
	LXI   D,L1EFBH  ; Make EI below look like LXI D,1EFBH
	NOP             
	JMP   L7043H    ; Cassette REMOTE routine - turn motor on or off
	
	
; ======================================================
; Read byte from tape & update checksum
; ======================================================
L14B0H:	PUSH  D         
	PUSH  H         
	PUSH  B         
	CALL  L702AH    ; Read character from cassette w/o checksum
	JC    L1491H    ; Turn cassette motor off and generate I/O Error
	MOV   A,D       
	POP   B         
	ADD   C         
	MOV   C,A       
	MOV   A,D       
	POP   H         
	POP   D         
	RET             
	
	
; ======================================================
; Write byte to tape & update checksum
; ======================================================
L14C1H:	PUSH  D         
	PUSH  H         
	MOV   D,A       
	ADD   C         
	MOV   C,A       
	PUSH  B         
	MOV   A,D       
	CALL  L6F5BH    ; Write char in A to cassette w/o checksum
	JC    L1491H    ; Turn cassette motor off and generate I/O Error
	POP   B         
	POP   H         
	POP   D         
	RET             
	
	
; ======================================================
; LCD Device control block
; ======================================================
L14D2H:
    DW	14D8H,4D59H,14E5H
	
	
; ======================================================
; LCD and PRT file open routine
; ======================================================
L14D8H:	MVI   A,02H     
	CMP   E         
	JNZ   L504EH    ; Generate NM error
L14DEH:	SHLD  FC8CH     
	MOV   M,E       
	POP   PSW       
	POP   H         
	RET             
	
	
; ======================================================
; Output to LCD file
; ======================================================
	POP   PSW       
	PUSH  PSW       
	CALL  L431FH    
L14EAH:	CALL  L1BB1H    ; Renew automatic power-off counter
	
; ======================================================
; Pop AF), BC), DE), HL from stack
; ======================================================
L14EDH:	POP   PSW       
L14EEH:	POP   B         
	POP   D         
	POP   H         
	RET             
	
	
; ======================================================
; CRT device control block
; ======================================================
	DW	14F8H,4D59H,14FAH
	
L14F8H:	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	40H             
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	44H             
	
; ======================================================
; RAM device control block
; ======================================================
	DW	1506H,158DH,15ACH,15C4H
	DW	161BH          
	
	
; ======================================================
; Open RAM file
; ======================================================
L1506H:	PUSH  H         
	PUSH  D         
	INX   H         
	INX   H         
	PUSH  H         
	MOV   A,E       
	CPI   01H       
	JZ    L1541H    
	CPI   08H       
	JZ    L155CH    
L1516H:	CALL  L220FH    ; Open a text file at (FC93H)
	JC    L1580H    
	PUSH  D         
	CALL  L18DAH    
	POP   D         
L1521H:	LXI   B,0000H  
L1524H:	POP   H         
	LDAX  D         
	ANI   02H       
	JNZ   L5051H    ; Generate AO error
	LDAX  D         
	ORI   02H       
	STAX  D         
	INX   D         
	MOV   M,E       
	INX   H         
	MOV   M,D       
	INX   H         
	INX   H         
	INX   H         
	MVI   M,00H     
	INX   H         
	MOV   M,C       
	INX   H         
	MOV   M,B       
	POP   D         
	POP   H         
	JMP   L14DEH    
	
L1541H:	LDA   F651H     ; In TEXT because of BASIC EDIT flag
	ANA   A         
	LXI   H,F9AFH   
	CZ    L208FH    ; Find .DO or ." " file in catalog
	JZ    L5057H    ; Generate FF error
	XCHG            
	CALL  L1675H    
	XRA   A         
	MOV   M,A       
	MOV   L,A       
	MOV   H,A       
	SHLD  FAD8H     
	JMP   L1521H    
	
L155CH:	POP   H         
	POP   D         
	MVI   E,02H     
	PUSH  D         
	PUSH  H         
	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	CALL  L208FH    ; Find .DO or ." " file in catalog
	JZ    L1516H    
	MOV   E,L       
	MOV   D,H       
	INX   H         
	MOV   A,M       
	INX   H         
	MOV   H,M       
	MOV   L,A       
	LXI   B,FFFFH   
L1575H:	MOV   A,M       
	INX   H         
	INX   B         
	CPI   1AH       
	JNZ   L1575H    
	JMP   L1524H    
	
L1580H:	LDAX  D         ; Get Open flag
	ANI   02H       ; Test if file already open
	JNZ   L5051H    ; Generate AO error
	XCHG            
	CALL  L1FBFH    ; Kill a text file
	JMP   L1516H    
	
	
; ======================================================
; Close RAM file
; ======================================================
	PUSH  H         
	CALL  L15A0H    
	POP   H         
	CALL  L172AH    
	CNZ   L1621H    
	CALL  L1675H    
	MVI   M,00H     
	JMP   L4D59H    ; LCD), CRT), and LPT file close routine
	
L15A0H:	INX   H         
	INX   H         
	MOV   A,M       
	INX   H         
	MOV   H,M       
	MOV   L,A       
	DCX   H         
	MOV   A,M       
	ANI   FDH       
	MOV   M,A       
	RET             
	
	
; ======================================================
; Output to RAM file
; ======================================================
	POP   PSW       
	PUSH  PSW       
	LXI   B,L14EAH  
	PUSH  B         
	ANA   A         
	RZ              
	CPI   1AH       
	RZ              
	CPI   7FH       
	RZ              
	CALL  L1739H    ; Add byte to open file buffer and keep track of length
	RNZ             
	LXI   B,L0100H  
	JMP   L1621H    
	
	
; ======================================================
; Input from RAM file
; ======================================================
	XCHG            
	CALL  L1675H    
	CALL  L18C7H    
	XCHG            
	CALL  L1749H    
	JNZ   L1609H    
	XCHG            
	LHLD  FC87H     
	RST   3         ; Compare DE and HL
	PUSH  PSW       
	PUSH  D         
	CNZ   L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	POP   H         
	POP   PSW       
	LXI   B,FFF9H   
	DAD   B         
	MOV   E,M       
	INX   H         
	MOV   D,M       
	XCHG            
	MOV   A,M       
	INX   H         
	MOV   H,M       
	MOV   L,A       
	JNZ   L15F5H    
	PUSH  D         
	XCHG            
	LHLD  FAD8H     
	XCHG            
	DAD   D         
	POP   D         
L15F5H:	XCHG            
	INX   H         
	INX   H         
	INX   H         
	INX   H         
	MOV   C,M       
	INX   H         
	MOV   B,M       
	INR   M         
	INX   H         
	XCHG            
	DAD   B         
	MVI   B,00H     
	CALL  L2542H    ; Move B bytes from M to (DE)
	XCHG            
	DCR   H         
	XRA   A         
L1609H:	MOV   C,A       
	DAD   B         
	MOV   A,M       
	CPI   1AH       
	STC             
	CMC             
	JNZ   L4E8AH    
	CALL  L1675H    
	MOV   M,A       
	STC             
	JMP   L4E8AH    
	
	
; ======================================================
; Special RAM file I/O
; ======================================================
L161BH:	CALL  L1675H    
	JMP   L17CDH    
	
L1621H:	PUSH  H         
	PUSH  B         
	PUSH  H         
	XCHG            
	LHLD  FC87H     
	RST   3         ; Compare DE and HL
	CNZ   L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	POP   H         
	DCX   H         
	MOV   D,M       
	DCX   H         
	MOV   E,M       
	XCHG            
	POP   B         
	PUSH  B         
	PUSH  H         
	DAD   B         
	XCHG            
	MOV   M,E       
	INX   H         
	MOV   M,D       
	LXI   B,FFFAH   
	DAD   B         
	MOV   E,M       
	INX   H         
	MOV   D,M       
	LDAX  D         
	MOV   L,A       
	INX   D         
	LDAX  D         
	MOV   H,A       
	POP   B         
	DAD   B         
	POP   B         
	PUSH  H         
	PUSH  B         
	CALL  L6B6DH    ; Insert BC spaces at M
	CNC   L18DDH    
	POP   B         
	POP   D         
	POP   H         
	JC    L1669H    
	PUSH  H         
L1658H:	MOV   A,M       
	STAX  D         
	INX   D         
	INX   H         
	DCR   C         
	JNZ   L1658H    
	POP   D         
	LHLD  FC87H     
	RST   3         ; Compare DE and HL
	RZ              
	JMP   L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	
L1669H:	LXI   B,FFF7H   
	DAD   B         
	MVI   M,00H     
	CALL  L15A0H    
	JMP   L3F17H    ; Reinit BASIC stack and generate OM error
	
L1675H:	PUSH  D         
	LHLD  FAA2H     
	LXI   D,FA91H   
	DAD   D         
	POP   D         
	RET             
	
	
; ======================================================
; CAS device control block
; ======================================================
	DW	1689H,16ADH,16C7H,16D2H
	DW	1710H          
	
	
; ======================================================
; Open CAS file
; ======================================================
L1689H:	PUSH  H         
	PUSH  D         
	LXI   B,L0006H  
	DAD   B         
	XRA   A         
	MOV   M,A       
	STA   FA8EH     
	MOV   A,E       
	CPI   08H       
	JZ    L504EH    ; Generate NM error
	CPI   01H       
	JZ    L16A7H    
	CALL  L260EH    ; Open CAS for output of TEXT files
L16A2H:	POP   D         
	POP   H         
	JMP   L14DEH    
	
L16A7H:	CALL  L2653H    ; Open CAS for input of TEXT files
	JMP   L16A2H    
	
	
; ======================================================
; Close CAS file
; ======================================================
	CALL  L172AH    
	JZ    L16C0H    
	PUSH  H         
	DAD   B         
L16B5H:	MVI   M,1AH     
	INX   H         
	INR   C         
	JNZ   L16B5H    
	POP   H         
	CALL  L1716H    
L16C0H:	XRA   A         
	STA   FA8EH     
	JMP   L4D59H    ; LCD), CRT), and LPT file close routine
	
	
; ======================================================
; Output to CAS file
; ======================================================
	POP   PSW       
	PUSH  PSW       
	CALL  L1739H    ; Add byte to open file buffer and keep track of length
	CZ    L1716H    
	JMP   L14EAH    
	
	
; ======================================================
; Input from CAS file
; ======================================================
	XCHG            
	LXI   H,FA8EH   
	CALL  L18C7H    
	XCHG            
	CALL  L1749H    
	JNZ   L16FFH    
	PUSH  H         
	CALL  L26D1H    ; Load Tape sync, header and 8DH marker & validate
	POP   H         
	LXI   B,0000H  
L16E8H:	CALL  L14B0H    ; Read byte from tape & update checksum
	MOV   M,A       
	INX   H         
	DCR   B         
	JNZ   L16E8H    
	CALL  L14B0H    ; Read byte from tape & update checksum
	MOV   A,C       
	ANA   A         
	JNZ   L1491H    ; Turn cassette motor off and generate I/O Error
	CALL  L14AAH    ; Turn cassette motor off
	DCR   H         
	XRA   A         
	MOV   B,A       
L16FFH:	MOV   C,A       
	DAD   B         
	MOV   A,M       
	CPI   1AH       
	STC             
	CMC             
	JNZ   L4E8AH    
	STA   FA8EH     
	STC             
	JMP   L4E8AH    
	
L1710H:	LXI   H,FA8EH   
	JMP   L17CDH    
	
L1716H:	PUSH  H         ; Preserve pointer to data
	CALL  L2648H    ; Write 8DH data packet header to TAPE
	POP   H         ; Restore pointer to data
	LXI   B,0000H  ; Clear out the byte counter + checksum
L171EH:	MOV   A,M       ; Get next byte to write
	CALL  L14C1H    ; Write byte to tape & update checksum
	INX   H         ; Increment pointer
	DCR   B         ; Decrement the byte count
	JNZ   L171EH    ; Jump to loop for 256 bytes
	JMP   L2635H    ; Write checksum to TAPE
	
L172AH:	MOV   A,M       
	CPI   01H       
	RZ              
	LXI   B,L0006H  
	DAD   B         
	MOV   A,M       
	MOV   C,A       
	MVI   M,00H     
	JMP   L174FH    
	
L1739H:	MOV   E,A       
	LXI   B,L0006H  
	DAD   B         
	MOV   A,M       
	INR   M         
	INX   H         
	INX   H         
	INX   H         
	PUSH  H         
	MOV   C,A       
	DAD   B         
	MOV   M,E       
	POP   H         
	RET             
	
L1749H:	LXI   B,L0006H  
	DAD   B         
	MOV   A,M       
	INR   M         
L174FH:	INX   H         
	INX   H         
	INX   H         
	ANA   A         
	RET             
	
	
; ======================================================
; LPT device control block
; ======================================================
	DW	14D8H,4D59H,175AH
	
	
; ======================================================
; Output to LPT file
; ======================================================
	POP   PSW       
	PUSH  PSW       
	CALL  PRTTAB    ; Print A to printer), expanding tabs if necessary
	JMP   L14EAH    
	
	
; ======================================================
; COM device control block
; ======================================================
	DW	176DH,179EH,17A8H,17B0H
	DW	17CAH          
	
	
; ======================================================
; Open MDM file
; ======================================================
L176CH:	ORI   37H       
	PUSH  PSW       
	CC    L52BBH    ; Disconnect phone line and disable modem carrier
	POP   PSW       
	PUSH  PSW       
	PUSH  H         
	PUSH  D         
	LXI   H,FC93H   ; Filename of current BASIC program
	CALL  L17E6H    ; Set RS232 parameters from string at M
	POP   D         
	MOV   A,E       
	CPI   08H       
	JZ    L504EH    ; Generate NM error
	SUI   01H       
	JNZ   L178BH    
	STA   FA8FH     
L178BH:	POP   H         
	POP   PSW       
	JC    L14DEH    
	CALL  L52E4H    ; Go off-hook and wait for carrier
	JC    L1494H    ; Generate I/O error
	MVI   A,02H     
	CALL  L5316H    
	JMP   L14DEH    
	
	
; ======================================================
; Close COM file
; ======================================================
L179EH:	CALL  L6ECBH    ; Deactivate RS232 or modem
	XRA   A         
	STA   FA8FH     
	JMP   L4D59H    ; LCD), CRT), and LPT file close routine
	
	
; ======================================================
; Output to COM/MDM file
; ======================================================
	POP   PSW       
	PUSH  PSW       
	CALL  L6E32H    ; Send character in A to serial port using XON/XOFF
	JMP   L14EAH    
	
	
; ======================================================
; Input from COM/MDM file
; ======================================================
	LXI   H,FA8FH   
	CALL  L18C7H    
	CALL  L6D7EH    ; Get a character from RS232 receive queue
	JC    L1494H    ; Generate I/O error
	CPI   1AH       
	STC             
	CMC             
	JNZ   L4E8AH    
	STA   FA8FH     
	STC             
	JMP   L4E8AH    
	
	
; ======================================================
; Special COM/MDM file I/O
; ======================================================
L17CAH:	LXI   H,FA8FH   
L17CDH:	MOV   M,C       
	JMP   L5023H    
	
	
; ======================================================
; MDM Device control block
; ======================================================
	DW	176CH,17DBH,17A8H,17B0H
	DW	17CAH          
	
	
; ======================================================
; Close MDM file
; ======================================================
	MVI   A,02H     
	CALL  L5316H    
	CALL  L52BBH    ; Disconnect phone line and disable modem carrier
	JMP   L179EH    ; Close COM file
	
	
; ======================================================
; Set RS232 parameters from string at M
; ======================================================
L17E6H:	PUSH  PSW       
	LXI   B,L504EH  
	PUSH  B         
	JNC   L17F7H    
	MOV   A,M       
	SUI   31H       
	CPI   09H       
	RNC             
	INR   A         
	MOV   D,A       
	INX   H         
L17F7H:	MOV   A,M       
	SUI   36H       
	CPI   03H       
	RNC             
	INR   A         
	ADD   A         
	ADD   A         
	ADD   A         
	MOV   E,A       
	INX   H         
	CALL  L0FE8H    ; Get char at M and convert to uppercase
	CPI   49H       
L1808H:	JNZ   L181CH    
	MOV   A,E       
	CPI   18H       
	RZ              
	ADI   0CH       
	MOV   E,A       
	ANI   08H       
	ADD   A         
	ADD   A         
	ADD   A         
	ORI   3FH       
	JMP   L1832H    
	
L181CH:	CPI   45H       
	MVI   B,02H     
	JZ    L182DH    
	SUI   4EH       
	MVI   B,04H     
	JZ    L182DH    
	DCR   A         
	RNZ             
	MOV   B,A       
L182DH:	MOV   A,B       
	ORA   E         
	MOV   E,A       
	MVI   A,FFH     
L1832H:	STA   FF8DH     ; RS232 Parity Control byte
	INX   H         
	MOV   A,M       
	SUI   31H       
	CPI   02H       
	RNC             
	ORA   E         
	MOV   E,A       
	INX   H         
	CALL  L0FE8H    ; Get char at M and convert to uppercase
	CPI   44H       
	JZ    L184EH    
	CPI   45H       
	RNZ             
	CALL  L6F31H    ; Enable XON/OFF when CTRL-S / CTRL-Q sent
	STC             
L184EH:	CNC   L6F32H    
	POP   B         
	POP   PSW       
	PUSH  PSW       
	PUSH  D         
	DCX   H         
	DCX   H         
	DCX   H         
	DCX   H         
	LXI   D,VISTAT  ; RS232 parameter setting table
	MVI   B,05H     
	MOV   A,M       
	JC    L1864H    
	MVI   A,4DH     
L1864H:	STAX  D         
	INX   H         
	INX   D         
	CALL  L0FE8H    ; Get char at M and convert to uppercase
	DCR   B         
	JNZ   L1864H    
	XCHG            
	POP   H         
	POP   PSW       
	PUSH  D         
	CALL  L6EA6H    ; Initialize RS232 or modem
	POP   H         
	RET             
	
	
; ======================================================
; Wand device control block
; ======================================================
L1877H:DW	1881H,1883H,08DBH,1885H
	DW	1887H          
	
L1881H:	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	46H             
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	48H             
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	4AH             
L1887H:	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	4CH             
	
; ======================================================
; EOF function
; ======================================================
L1889H:	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	26H             
	CALL  L4C81H    
	JZ    L505AH    ; Generate CF error
	CPI   01H       
	JNZ   L504EH    ; Generate NM error
	PUSH  H         
	CALL  L18BFH    
	MOV   C,A       
	SBB   A         
	CALL  L340AH    ; SGN function
	POP   H         
	INX   H         
	INX   H         
	INX   H         
	INX   H         
	MOV   A,M       
	LXI   H,FA8FH   
	CPI   FCH       
	JZ    L18BDH    
	CPI   F9H       
	JZ    L18BDH    
	CALL  L1675H    
	CPI   F8H       
	JZ    L18BDH    
	LXI   H,FA8EH   
L18BDH:	MOV   M,C       
	RET             
	
L18BFH:	PUSH  B         
	PUSH  H         
	PUSH  D         
	MVI   A,06H     
	JMP   L5123H    ; Call OPEN Hook and DCB Vector identified in A
	
L18C7H:	MOV   A,M       
	MVI   M,00H     
	ANA   A         
	RZ              
	INX   SP        
	INX   SP        
	CPI   1AH       
	STC             
	CMC             
	JNZ   L4E8AH    
	MOV   M,A       
	STC             
	JMP   L4E8AH    
	
L18DAH:	LXI   B,L0001H  
L18DDH:	LHLD  FB9DH     ; SP used by BASIC to reinitialize the stack
L18E0H:	MOV   A,M       ; Get next byte from stack
	ANA   A         ; Test for zero (end of stack)
	RZ              ; Return if at bottom of stack
	XCHG            
	LHLD  VTPRAM    ; BASIC string buffer pointer
	XCHG            
	RST   3         ; Compare DE and HL
	RNC             
	MOV   A,M       
	CPI   81H       ; Test if token that PUSHed the stack was FOR
	LXI   D,L0007H  ; Prepare to advance up the stack by 7 bytes (amount pushed by GOSUB)
	JNZ   L1900H    ; Jump to add 7 if not FOR statement
	INX   H         ; Increment to address of loop control value
	MOV   E,M       ; Get LSB of FOR loop control variable
	INX   H         ; Increment to MSB
	MOV   D,M       ; Get MSB of FOR loop control variable
	XCHG            ; Put address in HL
	DAD   B         ; Point to original FOR loop source variable perhaps?
	XCHG            ; HL=stack, DE=address of variable
	MOV   M,D       ; Put new variable address on stack?
	DCX   H         ; Decrement to LSB
	MOV   M,E       ; Put LSB of new variable location on stack?
	LXI   D,L0018H  ; FOR loop occupies 18H bytes on stack
L1900H:	DAD   D         ; Rewind the FOR loop
	JMP   L18E0H    ; Jump to process next stack level
	
	
; ======================================================
; TIME$ function
; ======================================================
L1904H:	RST   2         ; Get next non-white char from M
	PUSH  H         ; Save pointer to BASIC string on stack
	CALL  L198DH    ; Create an 8-byte transient string and return address in HL
	CALL  L190FH    ; Read time and store it at M
	JMP   L278DH    ; Add new transient string to string stack
	
	
; ======================================================
; Read time and store it at M
; ======================================================
L190FH:	CALL  L19A0H    ; Update in-memory (F923H) clock values
	LXI   D,F928H   ; Hours (tens)
	CALL  L1996H    ; Hours - Convert 2 binary digits at (DE) to ASCII digits at (HL) and increment
	MVI   M,3AH     ; Add a ":" between hours and minutes
	INX   H         ; Increment string pointer
	CALL  L1996H    ; Convert 2 binary digits at (DE) to ASCII digits at (HL) and increment
	MVI   M,3AH     ; Add a ":" between minutes and seconds
L1920H:	INX   H         ; Increment string pointer
	JMP   L1996H    ; Convert 2 binary digits at (DE) to ASCII digits at (HL) and increment
	
L1924H:	RST   2         ; Get next non-white char from M
	PUSH  H         ; Save pointer to BASIC command line
	CALL  L198DH    ; Create an 8-byte transient string and return address in HL
	CALL  L192FH    ; DATE$ function
	JMP   L278DH    ; Add new transient string to string stack
	
	
; ======================================================
; DATE$ function
; ======================================================
L192FH:	CALL  L19A0H    ; Update in-memory (F923H) clock values
	LXI   D,F92CH   ; Month (1-12)
	LDAX  D         ; Load month value
	CPI   0AH       ; Test if month >= 10
	MVI   B,30H     ; Load ASCII '0' in case month < 10
	JC    L1941H    ; Jump to save '0' as 1st digit of month if month < 10
	MVI   B,31H     ; Load ASCII '1' for 1st digit of month
	SUI   0AH       ; Subtract 10 from month to convert to ASCII
L1941H:	MOV   M,B       ; Save 1st digit of month to output string
	INX   H         ; Increment to 2nd digit of month
	CALL  L199AH    ; Convert binary digit in A to ASCII digit at (HL) and increment
	DCX   D         ; Decrement pointer to days in clock chip registers
	MVI   M,2FH     ; Add a '/' between month and day
	INX   H         ; Increment output string pointer
	CALL  L1996H    ; Convert 2 binary digits at (DE) to ASCII digits at (HL) and increment
	MVI   M,2FH     ; Add a '/' between day and year
	LXI   D,F92EH   ; Year (tens)
	JMP   L1920H    ; Convert 2 binary digits at (DE) to ASCII digits at (HL+1) and increment
	
	
; ======================================================
; DAY function
; ======================================================
L1955H:	RST   2         ; Get next non-white char from M
	PUSH  H         ; Preserve HL on stack
	MVI   A,03H     ; Prepare to create a 3-byte string
	CALL  L198FH    ; Create a string with length A and return address in HL
	CALL  L1962H    ; Read day and store at M
	JMP   L278DH    ; Add new transient string to string stack
	
	
; ======================================================
; Read day and store at M
; ======================================================
L1962H:	CALL  L19A0H    ; Update in-memory (F923H) clock values
	LDA   F92BH     ; Day code (0=Sun), 1=Mon), etc.)
	MOV   C,A       ; Save the day code in A
	ADD   A         ; Multiply day code x2
	ADD   C         ; Multiply day code x3 (size of ASCII days)
	MOV   C,A       ; Move day code x3 to C for offset into Day table
	MVI   B,00H     ; Zero out MSB of BC for add
	XCHG            ; Save HL (the pointer to BASIC string)
	LXI   H,L1978H  ; Load pointer to ASCII table with Days
	DAD   B         ; Index into Day ASCII table
	MVI   B,03H     ; Prepare to copy 3 bytes from Day table
	JMP   L2542H    ; Move B bytes from M to (DE)
	
L1978H:
    DB	"Sun"           
    DB	"Mon"           
    DB	"Tue"           
    DB	"Wed"           ; Do I really need to explain these line by line? :)
    DB	"Thu"           
    DB	"Fri"           
    DB	"Sat"           
L198DH:	MVI   A,08H     ; Prepare to create an 8-byte transient string
L198FH:	CALL  L275DH    ; Create a transient string of length A
	LHLD  FB8AH     ; Address of transient string
	RET             
	
L1996H:	CALL  L1999H    ; Convert binary digit at (DE) to ASCII digit at (HL)
L1999H:	LDAX  D         ; Load binary value
L199AH:	ORI   30H       ; Convert to ASCII digit
	MOV   M,A       ; Save ASCII digit at M
	DCX   D         ; Decrement source pointer
	INX   H         ; Increment destination pointer
	RET             
	
	
; ======================================================
; Update in-memory (F923H) clock values
; ======================================================
L19A0H:	PUSH  H         ; Preserve BASIC string pointer to stack
	LXI   H,F923H   ; Seconds (ones)
	DI              ; Disable interrupts during copy
	CALL  L7329H    ; Copy clock chip regs to M
	EI              ; Re-enable interrupts
	POP   H         ; Restore BASIC string pointer
	RET             
	
	
; ======================================================
; TIME$ statement
; ======================================================
	CPI   DDH       ; Test for '=' token
	JNZ   L1AA5H    ; Jump to process ON/OFF/STOP arguments
	CALL  L1A42H    ; Get time string from command line
	
; ======================================================
; Update clock chip from memory F923H
; ======================================================
L19B3H:	LXI   H,F923H   ; Seconds (ones)
	DI              
	CALL  L732AH    ; Update clock chip regs from M
	EI              
	POP   H         
	RET             
	
	
; ======================================================
; DATE$ statement
; ======================================================
	CALL  L1A2CH    
	JNZ   ERRSYN    ; Generate Syntax error
	CALL  L112EH    ; Evaluate expression at M-1
	DCR   A         
	CPI   0CH       
	JNC   ERRSYN    ; Generate Syntax error
	INR   A         
	LXI   D,F92CH   ; Month (1-12)
	STAX  D         
	RST   1         ; Compare next byte with M
    DB	2FH             ; Test for '/'
	DCX   D         
	CALL  L1A6AH    
	CPI   04H       
	JNC   ERRSYN    ; Generate Syntax error
	CALL  L1A6AH    
	RST   1         ; Compare next byte with M
    DB	2FH             ; Test for '/'
	LXI   D,F92FH   
	CALL  L1A6AH    
	CALL  L1A6AH    
	XRA   A         
	STA   F655H     
	JMP   L19B3H    ; Update clock chip from memory F923H
	
	
; ======================================================
; DAY$ statement
; ======================================================
L19F1H:	CALL  L1A2CH    
	CPI   03H       
	JNZ   ERRSYN    ; Generate Syntax error
	LXI   D,L1978H  
	MVI   C,07H     
L19FEH:	PUSH  H         
	MVI   B,03H     
L1A01H:	LDAX  D         
	PUSH  D         
	CALL  L0FE9H    ; Convert A to uppercase
	MOV   E,A       
	CALL  L0FE8H    ; Get char at M and convert to uppercase
	CMP   E         
	POP   D         
	JNZ   L1A1FH    
	INX   D         
	INX   H         
	DCR   B         
	JNZ   L1A01H    
	POP   H         
	MVI   A,07H     
	SUB   C         
	STA   F92BH     ; Day code (0=Sun), 1=Mon), etc.)
	JMP   L19B3H    ; Update clock chip from memory F923H
	
L1A1FH:	INX   D         
	DCR   B         
	JNZ   L1A1FH    
	POP   H         
	DCR   C         
	JNZ   L19FEH    
	JMP   ERRSYN    ; Generate Syntax error
	
L1A2CH:	RST   1         ; Compare next byte with M
    DB	DDH             ; Test for '=' token ID
L1A2EH:	CALL  L0DABH    ; Main BASIC evaluation routine
	XTHL            
	PUSH  H         
	CALL  L19A0H    ; Update in-memory (F923H) clock values
	CALL  L2916H    ; Get pointer to most recently used string (Len + address)
	MOV   A,M       
	INX   H         
	MOV   E,M       
	INX   H         
	MOV   H,M       
	MOV   L,E       
	CPI   08H       
	RET             
	
	
; ======================================================
; Get time string from command line
; ======================================================
L1A42H:	CALL  L1A2CH    
	JNZ   ERRSYN    ; Generate Syntax error
	XCHG            
	POP   H         
	XTHL            
	PUSH  H         
	XCHG            
	LXI   D,F929H   ; Date (ones)
	CALL  L1A6AH    
	CPI   03H       
	JNC   ERRSYN    ; Generate Syntax error
	CALL  L1A6AH    
	RST   1         ; Compare next byte with M
    DB	3AH             ; Test for ':'
	CALL  L1A62H    
	RST   1         ; Compare next byte with M
    DB	3AH             ; Test for ':'
L1A62H:	CALL  L1A6AH    
	CPI   06H       
	JNC   ERRSYN    ; Generate Syntax error
L1A6AH:	DCX   D         
	MOV   A,M       
	INX   H         
	SUI   30H       
	CPI   0AH       
	JNC   ERRSYN    ; Generate Syntax error
	ANI   0FH       
	STAX  D         
	RET             
	
	
; ======================================================
; IPL statement
; ======================================================
	JZ    L1A96H    ; Erase current IPL program
	CALL  L1A2EH    
	ANA   A         
	JZ    L1A95H    
	CPI   0AH       
	JNC   L08DBH    ; Generate FC error
	MOV   B,A       
	XCHG            
	LXI   H,FAAFH   ; Start of IPL filename
	CALL  L3469H    ; Move B bytes from (DE) to M with increment
	MVI   M,0DH     
	INX   H         
	MOV   M,B       
	POP   H         
	RET             
	
L1A95H:	POP   H         
	
; ======================================================
; Erase current IPL program
; ======================================================
L1A96H:	XRA   A         
	STA   FAAFH     ; Start of IPL filename
	STA   FAB0H     
	RET             
	
	
; ======================================================
; COM and MDM statements
; ======================================================
	PUSH  H         
	LXI   H,F944H   ; On Com flag
	JMP   L1AA9H    
	
L1AA5H:	PUSH  H         ; Preserve HL (BASIC string pointer) on stack
	LXI   H,F947H   ; On Time flag
L1AA9H:	CALL  L1AEAH    ; Determine argument (ON/OFF/STOP) for TIME$ statement
L1AACH:	POP   H         ; Retore HL
	POP   PSW       ; POP return address from stack (we jump directly to BASIC loop)
	RST   2         ; Get next non-white char from M
	JMP   L0811H    ; Jump into BASIC execution loop
	
	
; ======================================================
; KEY() statement
; ======================================================
L1AB2H:	CALL  L112EH    ; Evaluate expression at M-1
	DCR   A         ; Make key selection zero based
	CPI   08H       ; Test if FKey selection > 7 (zero based)
	JNC   L08DBH    ; Generate FC error
	MOV   A,M       ; Get 1st byte of FKey string
	PUSH  H         ; Preserve HL (BASIC string pointer) on stack
	CALL  L1AD4H    ; Process KEY() statement key number - KEY(x) ON/OFF/STOP
	JMP   L1AACH    ; Restore HL from stack, pop return address and jump to BASIC execution
	
	
; ======================================================
; KEY STOP/ON/OFF statements
; ======================================================
L1AC3H:	PUSH  H         ; Preserve HL (BASIC string pointer) to stack
	MVI   E,08H     ;
L1AC6H:	PUSH  D         
	PUSH  PSW       
	CALL  L1AD4H    
	POP   PSW       
	POP   D         
	DCR   E         
	JNZ   L1AC6H    
	JMP   L1AACH    ; Restore HL from stack, pop return address and jump to BASIC execution
	
L1AD4H:	MVI   D,00H     ; Clear MSB of DE for index into KEY ON enabled table
	LXI   H,F62FH   ; Load pointer to KEY ON enabled table
	DAD   D         ; Index into KEY ON enabled table
	PUSH  H         ; Push pointer to KEY ON enabled to stack
	LXI   H,F947H   ; On Time flag
	DAD   D         ; Add key number 3 times to index into ONx interrupt table
	DAD   D         ; ... once for ON-x trigger flag, another for LSB of handler
	DAD   D         ; ... and another for MSB of handler
	CALL  L1AEAH    ; Determine argument (ON/OFF/STOP) for TIME$ statement
	MOV   A,M       ; Get trigger flag for this ONx interrupt
	ANI   01H       ; Test if this key was triggered
	POP   H         ; Restore pointer to KEY ON enabled table
	MOV   M,A       ; Load code indicating if KEY ON enabled for this key
	RET             
	
	
; ======================================================
; Determine argument (ON/OFF/STOP) for TIME$ statement
; ======================================================
L1AEAH:	CPI   97H       ; Load code for ON token
	JZ    L3FA0H    ; TIME$ ON statement
	CPI   CBH       ; Load code for OFF token
	JZ    L3FB2H    ; TIME$ OFF statement
	CPI   8FH       ; Load code for STOP token
	JZ    L3FB9H    ; TIME$ STOP statement
	JMP   ERRSYN    ; Generate Syntax error
	
	
; ======================================================
; Determine device (KEY/TIME/COM/MDM) for ON GOSUB
; ======================================================
L1AFCH:	CPI   ADH       ; Compare with value of COM token
	LXI   B,L0001H  ; Load value for COM/MDM device
	RZ              ; Return if COM
	CPI   AEH       ; Compare with value of MDM token
	RZ              ; Return if MDM
	CPI   AFH       ; Compare with value of KEY token
	LXI   B,L0208H  ; Load value for KEY device
	RZ              ; Return if KEY
	CPI   AAH       ; Compare with value for TIME$ token
	STC             ; Set C flag to indicate invalid device
	RNZ             ; Return if not TIME$ token
	
; ======================================================
; ON TIME$ statement
; ======================================================
	INX   H         ; Increment to next BASIC line text (Skip QUOTE perhaps?)
	CALL  L1A42H    ; Get time string from command line
	LXI   H,F93DH   ; Time for ON TIME interrupt (SSHHMM)
	MVI   B,06H     ; Prepare to copy 6 bytes of string "SSMMHH"
	CALL  L3469H    ; Move B bytes from (DE) to M with increment
	POP   H         ; POP pointer to BASIC line string from stack
	DCX   H         ; Decrement pointer. Why?
	LXI   B,L0101H  ; Load value for TIME$ device
	ANA   A         ; Clear C flag to indicate valid device
	RET             
	
	
; ======================================================
; ON COM handler
; ======================================================
L1B22H:	PUSH  H         ; Preserve HL on stack
	MOV   B,A       ; Copy device number to B
	ADD   A         ; Multiply device number x2
	ADD   B         ; Multiply device number x3
	MOV   L,A       ; Move device number x 3 to L for index into ON COM table
	MVI   H,00H     ; Clear MSB of index
	LXI   B,F945H   ; On Com routine address
	DAD   B         ; Index into ON COM/KEY/TIME$ interrupt table
	MOV   M,E       ; Save LSB of line number to ON COM/KEY/TIME$ interrupt table
	INX   H         ; Increment to MSB of line number
	MOV   M,D       ; Save MSB of line number to ON COM/KEY/TIME$ interrupt table
	POP   H         ; Restore HL
	RET             
	
	
; ======================================================
; RST 7.5 interrupt routine
; ======================================================
L1B32H:	CALL  VTLINH    ; RST 7.5 RAM Vector
	PUSH  H         ; \
	PUSH  D         ; \ Save all registers on stack
	PUSH  B         ; /
	PUSH  PSW       ; /
	MVI   A,0DH     ; Prepare to re-enable RST 7.5 interrupt
	SIM             ; Re-enable RST 7.5 interrupt
	EI              ; Re-enable interrupts
	LXI   H,F92FH   ; Load address of 2Hz count-down value
	DCR   M         ; Decrement the 2Hz count-down counter
	JNZ   L1BAEH    ; Jump if not zero to skip 10Hz background logic
	MVI   M,7DH     ; Re-load count-down value for 2 Hz
	INX   H         ; Point to 6-second count-down counter (F930H)
	DCR   M         ; Decrement 6-second count-down counter
	JNZ   L1B65H    ; Jump if not zero to refresh from clock chip
	MVI   M,0CH     ; Re-load 6-second count-down value
	INX   H         ; Increment to power-down count-down
	PUSH  H         ; Preserve HL on stack
	LHLD  F67AH     ; Current executing line number
	INX   H         ; Prepare to check if BASIC is executing. Increment line #
	MOV   A,H       ; Get MSB of line number in A
	ORA   L         ; OR in LSB to test for zero (tests for FFFFH because of INX H)
	POP   H         ; Restore pointer to power-down count-down
	CNZ   L1BB1H    ; Renew automatic power-off counter
	MOV   A,M       ; Load current power-down count-down
	ANA   A         ; Test if count-down is zero (disabled)
	JZ    L1B65H    ; Skip power-down count-down if disabled
	DCR   M         ; Decrement power-down count-down (HL = F931H)
	JNZ   L1B65H    ; Skip update of power-down enable flag if count != 0
	INX   H         ; Increment to power-down enable flag
	MVI   M,FFH     ; Set power-down enable flag (HL = F932H)
L1B65H:	LXI   H,F933H   ; Seconds (ones)
	PUSH  H         ; Push pointer to current time on stack
	CALL  L7329H    ; Copy clock chip regs to M
	POP   D         ; Get pointer to current time in DE
	LXI   H,F93DH   ; Time for ON TIME interrupt (SSHHMM)
	MVI   B,06H     ; Prepare to compare 6 bytes of time to detect ON TIME interrupt
L1B72H:	LDAX  D         ; Load next byte of current time
	SUB   M         ; Subtract ON TIME value
	JNZ   L1B88H    ; Exit loop if it doesn't match
	INX   D         ; Increment to next byte of current time
	INX   H         ; Increment to next byte of ON TIME value
	DCR   B         ; Decrement byte counter
	JNZ   L1B72H    ; Jump to test next byte if count != 0
	ORA   M         ; Test if ON TIME already triggered (F943H)
	JNZ   L1B8CH    ; Jump to skip setting ON TIME interrupt if already triggered
	LXI   H,F947H   ; On Time flag
	CALL  L3FD2H    ; Trigger interrupt. HL points to interrupt table
	MVI   A,AFH     ; Create a MVI A,AFH instruction using following byte.
	STA   F943H     ; Save ON TIME interrupt indication (A has either AFH or zero)
L1B8CH:	JMP   L1BABH    ; Different from m100, likely bug fix for year increase
	
L1B8FH:	CALL  L20D5H    ; Load pointer to storage of last known month
	RZ              ; Test if month changed from the last time
	CPI   F0H       ; Update last known month with current month
	RNZ             
	INR   A         
	RET             ; Point to Year (ones) to increment to increment the year
	
L1B98H:	LHLD  VCURLN    ; Cursor row (1-8)
	SHLD  F6E7H     ; Load the 1's place of the year to test for roll-over to 10's
	LXI   H,L66E6H  ; Jump if not 10 to skip incrementing 10's place
	SHLD  F652H     ; Save new 1's place (A is now zero)
	JMP   L659BH    ; Get 10's place to test for century roll-over
	
L1BA7H:	XRA   A         ; Jump to skip update if not a new century
L1BA8H:	JMP   L7D33H    ; End different from m100
	
L1BABH:	CALL  L7682H    ; Check for optional external controller
L1BAEH:	JMP   L7391H    ; Jump to Cursor BLINK - Continuation of RST 7.5 Background hook
	
	
; ======================================================
; Renew automatic power-off counter
; ======================================================
L1BB1H:	LDA   VPROFT    ; Get Power down time (1/10ths of a minute)
	STA   F931H     ; Update power-down count-down
	RET             
	
	
; ======================================================
; KEY statement
; ======================================================
	CPI   A5H       ; Load value of LIST token
	JNZ   L1BF6H    ; Jump if not LIST to test for ON/OFF
	
; ======================================================
; KEY LIST statement
; ======================================================
	RST   2         ; Get next non-white char from M
	PUSH  H         ; Preserve HL on stack
	LXI   H,F789H   ; Function key definition area
	MVI   C,04H     ; Prepare to print 4 lines of FKey text, 2 per line
L1BC4H:	CALL  L1BD3H    ; Print 1st FKey text for this line
	CALL  L1BD3H    ; Print 2nd FKey text for this line
	CALL  CRLF      ; Send CRLF to screen or printer
	DCR   C         ; Decrement line counter
	JNZ   L1BC4H    ; Keep looping until count=0
	POP   H         ; Restore HL from stack
	RET             
	
L1BD3H:	MVI   B,10H     ; Prepare to send 16 bytes of FKey text
	CALL  L1BE0H    ; Send B characters from M to the screen
	MVI   B,03H     ; Prepare to send 3 spaces
L1BDAH:	RST   4         ; Send character in A to screen/printer
	DCR   B         ; Decrement counter
	JNZ   L1BDAH    ; Loop until 3 spaces sent
	RET             
	
	
; ======================================================
; Send B characters from M to the screen
; ======================================================
L1BE0H:	MOV   A,M       ; Get next character from string
	CPI   7FH       ; Test for non-printable character
	JZ    L1BEBH    ; Print SPACE for non-printable characters
	CPI   20H       ; Test if less than SPACE
	JNC   L1BEDH    ; Skip to print the character
L1BEBH:	MVI   A,20H     ; Substitute a SPACE for non-printable characters
L1BEDH:	RST   4         ; Send character in A to screen/printer
	INX   H         ; Increment to next byte to print
	DCR   B         ; Decrement byte counter
	JNZ   L1BE0H    ; Send B characters from M to the screen
	MVI   A,20H     ; Leave a SPACE in A for return
	RET             
	
L1BF6H:	CPI   28H       ; Test for '('
	JZ    L1AB2H    ; KEY() statement
	CPI   97H       ; Test for OFF token
	JZ    L1AC3H    ; KEY STOP/ON/OFF statements
	CPI   CBH       ; Test for ON token
	JZ    L1AC3H    ; KEY STOP/ON/OFF statements
	CPI   8FH       ; Test for STOP token
	JZ    L1AC3H    ; KEY STOP/ON/OFF statements
	CALL  L112EH    ; Evaluate expression at M-1
	DCR   A         ; Decrement KEY number to make it zero based
	CPI   08H       ; Test if KEY number too big
	JNC   L08DBH    ; Generate FC error
	XCHG            ; Save HL in DE
	MOV   L,A       ; Prepare to multiply key number x16 (up to 16 bytes per key)
	MVI   H,00H     ; Make MSB of HL zero
	DAD   H         ; x2
	DAD   H         ; x4
	DAD   H         ; x8
	DAD   H         ; x16
	LXI   B,F789H   ; Function key definition area
	DAD   B         ; Index into function key definition area
	PUSH  H         ; Save address to FKey text
	XCHG            ; Restore HL (BASIC string pointer)
	RST   1         ; Compare next byte with M
    DB	2CH             ; ','
	CALL  L0DABH    ; Main BASIC evaluation routine
	PUSH  H         ; Save BASIC string pointer to stack
	CALL  L2916H    ; Get pointer to most recently used string (Len + address)
	MOV   B,M       ; Get length of string for FKey
	INX   H         ; Increment to LSB of string address
	MOV   E,M       ; Get LSB of string address
	INX   H         ; Increment to MSB of string address
	MOV   D,M       ; Get MSB of string address
	POP   H         ; Retrieve BASIC string pointer from stack
	XTHL            ; HL=string address, DE=BASIC string pointer
	MVI   C,0FH     ; Prepare to copy up to 15 bytes of string data (Need 1 byte for NULL)
	MOV   A,B       ; Get length of string to set as FKey text
	ANA   A         ; Test for zero length string
	JZ    L1C48H    ; Jump if string length is zero to skip string copy
L1C38H:	LDAX  D         ; Get next byte of string from BASIC command string
	ANA   A         ; Test for NULL in string (shouldn't happen)
	JZ    L08DBH    ; Generate FC error
	MOV   M,A       ; Save byte to FKey table
	INX   D         ; Increment to next byte of BASIC string
	INX   H         ; Increment to next byte of FKey table
	DCR   C         ; Decrement max string copy size
	JZ    L1C4EH    ; Jump NULL terminate FKey string if max length reached
	DCR   B         ; Decrement length of source string from BASIC command line
	JNZ   L1C38H    ; Jump to copy next string if not zero
L1C48H:	MOV   M,B       ; Zero out next byte of FKey text
	INX   H         ; Increment to next FKey text byte
	DCR   C         ; Decrement FKey string length count
	JNZ   L1C48H    ; Keep zero'ing out FKey until count = 0
L1C4EH:	MOV   M,C       ; NULL terminate the FKey text
	CALL  FNKSB     ; Display function keys on 8th line
	CALL  L6C93H    ; Copy BASIC Function key table to key definition area
	POP   H         ; POP address of FKey text from stack.
	RET             
	
	
; ======================================================
; PSET statement
; ======================================================
L1C57H:	CALL  L1D2EH    ; Get (X),Y) coordinate from tokenized string at M
L1C5AH:	RRC             
	PUSH  H         
	PUSH  PSW       
	CC    PLOT      ; Plot (set) point (D),E) on the LCD
	POP   PSW       
	CNC   UNPLOT    ; Clear (reset) point (D),E) on the LCD
	POP   H         
	RET             
	
	
; ======================================================
; PRESET statement
; ======================================================
	CALL  L1D2EH    ; Get (X),Y) coordinate from tokenized string at M
	CMA             
	JMP   L1C5AH    
	
	
; ======================================================
; LINE statement
; ======================================================
L1C6DH:	CPI   D1H       ; Test for '-' token ID
	XCHG            ; Save BASIC line pointer in DE
	LHLD  VXPIXS    ; X coord of last point plotted
	XCHG            ; Default to last coord in case of "LINE -(1,3)"
	CNZ   L1D2EH    ; Get (X),Y) coordinate from tokenized string at M
	PUSH  D         ; Save starting coords on stack
	RST   1         ; Compare next byte with M
    DB	D1H             ; Test for '-' token ID
	CALL  L1D2EH    ; Get (X),Y) coordinate from tokenized string at M
	PUSH  D         ; Save 2nd coord on stack
	LXI   D,PLOT    ; Load address of PSET routine to plot points
	JZ    L1C94H    ; Skip test for option args if end of line
	PUSH  D         ; Save address of routine to stack
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	CALL  L112EH    ; Evaluate expression at M-1
	POP   D         ; Restore address of plot routine
	RRC             ; Rotate A to test for PSET or PRESET
	JC    L1C92H    ; If PSET selected, skip replacement of routine
	LXI   D,UNPLOT  ; Get address of PRESET routine
L1C92H:	DCX   H         ; Rewind BASIC line pointer
	RST   2         ; Get next non-white char from M
L1C94H:	XCHG            ; Put PSET / PRESET address in HL
	SHLD  F661H     ; Address last called
	XCHG            ; Restore HL/DE
	JZ    L1CD2H    ; Jump to draw line if optional args not present
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	RST   1         ; Compare next byte with M
    DB	42H             ; Test for 'B'
	JZ    L1CBCH    ; Draw an unfilled box on LCD. Coords are on stack
	RST   1         ; Compare next byte with M
    DB	46H             ; Test for 'F'
	POP   D         
	
; ======================================================
; Draw a filled box on LCD. Coords are on stack
; ======================================================
	XTHL            
	MOV   A,E       
	SUB   L         
	JNC   L1CAFH    
	CMA             
	INR   A         
	MOV   L,E       
L1CAFH:	MOV   B,A       
	INR   B         
L1CB1H:	MOV   E,L       
	CALL  L1CD9H    
	INR   L         
	DCR   B         
	JNZ   L1CB1H    
	POP   H         
	RET             
	
	
; ======================================================
; Draw an unfilled box on LCD. Coords are on stack
; ======================================================
L1CBCH:	POP   D         
	XTHL            
	PUSH  D         
	MOV   E,L       
	CALL  L1CD9H    
	POP   D         
	PUSH  D         
	MOV   D,H       
	CALL  L1CD9H    
	POP   D         
	PUSH  H         
	MOV   H,D       
	CALL  L1CD9H    
	POP   H         
	MOV   L,E       
	LXI   B,E3D1H   ; Make POP D and XTHL look like LXI B,E3D1H
	CALL  L1CD9H    
	POP   H         
	RET             
	
L1CD9H:	PUSH  H         
	PUSH  D         
	PUSH  B         
	MOV   A,L       
	SUB   E         
	JNC   L1CE4H    
	XCHG            
	CMA             
	INR   A         
L1CE4H:	MOV   B,A       
	MVI   C,14H     
	MOV   A,H       
	SUB   D         
	JNC   L1CEFH    
	CMA             
	INR   A         
	INR   C         
L1CEFH:	CMP   B         
	JC    L1CFAH    
	MOV   H,A       
	MOV   L,B       
	MVI   A,1CH     
	JMP   L1CFFH    
	
L1CFAH:	MOV   L,A       
	MOV   H,B       
	MOV   A,C       
	MVI   C,1CH     
L1CFFH:	STA   F663H     
L1D02H:	MOV   A,C       
	STA   F665H     
	MOV   B,H       
	INR   B         
	MOV   A,H       
	ANA   A         
	RAR             
	MOV   C,A       
L1D0CH:	PUSH  H         
	PUSH  D         
	PUSH  B         
	CALL  F660H     
	POP   B         
	POP   D         
	POP   H         
	CALL  F665H     
	MOV   A,C       
	ADD   L         
	MOV   C,A       
	JC    L1D22H    
	CMP   H         
	JC    L1D27H    
L1D22H:	SUB   H         
	MOV   C,A       
	CALL  F663H     
L1D27H:	DCR   B         
	JNZ   L1D0CH    
	JMP   L14EEH    ; POP BC, DE, HL from stack
	
	
; ======================================================
; Get (X),Y) coordinate from tokenized string at M
; ======================================================
L1D2EH:	RST   1         ; Compare next byte with M
    DB	28H             ; Test for '('
	CALL  L112EH    ; Evaluate expression at M-1
	CPI   F0H       ; Test if X coord > 240
	JNC   L08DBH    ; Generate FC error
	PUSH  PSW       ; Save X coord
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	CALL  L112EH    ; Evaluate expression at M-1
	CPI   40H       ; Test if Y coord > 64
	JNC   L08DBH    ; Generate FC error
	POP   PSW       ; Pop X Coord from stack
	MOV   D,A       ; Save X coord in D
	XCHG            ; Put coords in HL for save
	SHLD  VXPIXS    ; X coord of last point plotted
	XCHG            ; Restore HL/DE
	MOV   A,M       ; Get next char from BASIC line
	CPI   29H       ; Test for ')'
	JNZ   L1D54H    ; If not ')', jump to test PSET/PRESET arg
	RST   2         ; Get next non-white char from M
	MVI   A,01H     ; Default to PSET on
	RET             
	
L1D54H:	PUSH  D         ; Preserve DE on stack
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	CALL  L112EH    ; Evaluate expression at M-1
	RST   1         ; Compare next byte with M
    DB	29H             ; Test for ')'
	MOV   A,E       ; Save PSET/PRESE value in A
	POP   D         ; Restore DE
	RET             
	
L1D5FH:	CALL  L1112H    ; Evaluate expression at M
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	PUSH  H         
	XCHG            
	LDA   VACTCC    ; Active columns count (1-40)
	CMA             
	INR   A         
	MOV   C,A       
	MVI   B,FFH     
	MOV   E,B       
L1D6FH:	INR   E         
	MOV   D,L       
	DAD   B         
	JC    L1D6FH    
	LDA   VACTCC    ; Active columns count (1-40)
	INR   D         
	CMP   D         
	JC    L08DBH    ; Generate FC error
	LDA   VACTLC    ; Active rows count (1-8)
	INR   E         
	CMP   E         
	JC    L08DBH    ; Generate FC error
	XCHG            
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	MOV   A,H       
	DCR   A         
	STA   F788H     ; Horiz. position of cursor (0-39)
	POP   H         
	RET             
	
	
; ======================================================
; CSRLIN function
; ======================================================
L1D90H:	PUSH  H         
	LDA   VCURLN    ; Cursor row (1-8)
	DCR   A         
L1D95H:	CALL  L340AH    ; SGN function
	POP   H         
	RST   2         ; Get next non-white char from M
	RET             
	
	
; ======================================================
; MAX function
; ======================================================
L1D9BH:	RST   2         ; Get next non-white char from M
	CPI   9DH       ; Test for FILES Token ID
	JZ    L1DB2H    ; MAXFILES function
	RST   1         ; Compare next byte with M
    DB	52H             ; Test for 'R'
	RST   1         ; Compare next byte with M
    DB	41H             ; Test for 'A'
	RST   1         ; Compare next byte with M
    DB	4DH             ; Test for 'M'
	
; ======================================================
; MAXRAM function
; ======================================================
	PUSH  H         
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	02H             
	LXI   H,VSSYS   ; Active system signature -- Warm vs Cold boot
	CALL  L37DBH    ; Convert unsigned HL to single precision in FAC1
	POP   H         
	RET             
	
	
; ======================================================
; MAXFILES function
; ======================================================
L1DB2H:	PUSH  H         
	LDA   FC82H     ; Maxfiles
	JMP   L1D95H    
	
	
; ======================================================
; HIMEM function
; ======================================================
L1DB9H:	PUSH  H         ; Save BASIC line pointer to stack
	LHLD  VHIMEM    ; HIMEM
	CALL  L37DBH    ; Convert unsigned HL to single precision in FAC1
	POP   H         ; Restore BASIC line pointer
	RST   2         ; Get next non-white char from M
	RET             
	
	
; ======================================================
; WIDTH statement
; ======================================================
L1DC3H:	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	3AH             
	
; ======================================================
; SOUND statement
; ======================================================
	CPI   97H       ; Test for ON token ID
	JZ    L1DE6H    ; SOUND ON statement
	CPI   CBH       ; Test for OFF token ID
	JZ    L1DE5H    ; SOUND OFF statement
	CALL  L1297H    ; Evaluate expression at M
	MOV   A,D       ; Get MSB of frequency
	ANI   C0H       ; Test for negative or > 16383
	JNZ   L08DBH    ; Generate FC error
	PUSH  D         ; Save frequency on stack
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	CALL  L112EH    ; Evaluate expression at M-1
	ANA   A         ; Test for duration of zero
	MOV   B,A       ; Save duration in B
	POP   D         ; Pop frequency from stack
	JNZ   L72C5H    ; Produce a tone of DE freq and B duration
	RET             
	
	
; ======================================================
; SOUND OFF statement
; ======================================================
L1DE5H:	MVI   A,AFH     ; Makes AFH below look like MVI A,AFH
	STA   FF44H     ; Sound flag
	RST   2         ; Get next non-white char from M
	RET             
	
	
; ======================================================
; MOTOR statement
; ======================================================
	SUI   CBH       
	JZ    L1DF5H    ; MOTOR OFF statement
	
; ======================================================
; MOTOR ON statement
; ======================================================
	RST   1         ; Compare next byte with M
    DB	97H             ; Test for ON token ID
	DCX   H         
	MOV   A,H       
	
; ======================================================
; MOTOR OFF statement
; ======================================================
L1DF5H:	MOV   E,A       
	RST   2         ; Get next non-white char from M
	JMP   L7043H    ; Cassette REMOTE routine - turn motor on or off
	
	
; ======================================================
; CALL statement
; ======================================================
	CALL  L1297H    ; Evaluate expression at M
	XCHG            
	SHLD  F661H     ; Address last called
	XCHG            
	DCX   H         
	RST   2         ; Get next non-white char from M
	JZ    L1E1BH    
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	CPI   2CH       
	JZ    L1E14H    
	CALL  L112EH    ; Evaluate expression at M-1
	JZ    L1E1BH    
L1E14H:	PUSH  PSW       
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	CALL  L1297H    ; Evaluate expression at M
	POP   PSW       
L1E1BH:	PUSH  H         
	XCHG            
	CALL  F660H     
	POP   H         
	RET             
	
	
; ======================================================
; SCREEN statement
; ======================================================
	CPI   2CH       ; Test if 1st byte of parameter is ','
	LDA   F638H     ; New Console device flag
	CNZ   L112EH    ; Evaluate expression at M-1
	CALL  L1E3CH    ; Process SCREEN number selection (0 or 1)
	DCX   H         ; Back command line pointer up to previous char
	RST   2         ; Get next non-white char from M
	RZ              ; Return if no more arguments
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test if byte is ',' and return only if it is
	CALL  L112EH    ; Evaluate expression at M-1
	PUSH  H         ; Save BASIC command line pointer to stack
	ANA   A         ; Test if Label Line requested
	CALL  L13AFH    ; Erase or Display function key line based on Z flag
	POP   H         ; Restore BASIC command line pointer
	RET             
	
L1E3CH:	PUSH  H         ; Preserve HL on stack
	STA   F638H     ; New Console device flag
	ANA   A         ; Test if New Console flag set
	LXI   D,L2808H  ; Load ROW,COL value for 8,40
	LHLD  F640H     ; Cursor row (1-8)
	MVI   A,0EH     ; Value of last column before wrap for PRINT ,
	JZ    L1E52H    ; Jump over RST7 if not New Console Device
	XRA   A         ; Clear New Console device flag
	STA   F638H     ; New Console device flag
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	3EH             ; SCREEN statement hook
L1E52H:	SHLD  VCURLN    ; Cursor row (1-8)
	XCHG            ; DE has active ROWS,COLS (for LCD or DVI)
	SHLD  VACTLC    ; Active rows count (1-8)
	STA   F676H     ; Store value of column wrap for PRINT , (14 or 56 if 80 COL mode)
	POP   H         ; Restore HL from stack
	RET             
	
	
; ======================================================
; L1E5EH: LCOPY statement: Print contents of LCD
; Entry conditions: none
; Exit conditions:  none
; ======================================================
PRTLCD:	PUSH H
    	CALL L4BA0
    	LXI  H,FE00H    ; Start of LCD character buffer
    	MVI  E,08H
L1E67:	MVI  D,28H
L1E69:	MOV  A,M
    	CALL PNOTAB     ; Output character to printer
    	INX  H
    	DCR  D
    	JNZ  L1E69
    	CALL L4BA0
    	DCR  E
    	JNZ  L1E67
    	POP  H
    	RET
	
; ======================================================
; Handle RUN "RAM:file" processing
; ======================================================
L1E7BH:	PUSH  H         
	CALL  L2146H    ; Update system pointers for .DO, .CO, vars, etc.
	LHLD  FC99H     ; Get extension of current BASIC filename
	LXI   D,L2020H  ; Load ASCII " " in DE
	RST   3         ; Compare DE and HL
	PUSH  PSW       
	JZ    L1E91H    ; Jump if extension is blank to default to "BA"
	LXI   D,L4142H  ; Load ASCII "BA" in DE
	RST   3         ; Compare DE and HL
	JNZ   L1EC7H    ; If not blank and not "BA", jump to deal with it
L1E91H:	CALL  L20A6H    ; Copy "BA" extension to BASIC program and search for file
	JZ    L1EC7H    ; Jump if file not found to deal with it
	POP   PSW       
	POP   B         
	POP   PSW       
	JZ    L08DBH    ; Generate FC error
	MVI   A,00H     
	PUSH  PSW       
	PUSH  B         
	SHLD  FA8CH     
	XCHG            
	SHLD  VBASPP    ; Start of BASIC program pointer
	CALL  L05F0H    ; Update line addresses for current BASIC program
	POP   H         
	MOV   A,M       
	CPI   2CH       
	JNZ   L1EBAH    
	RST   2         ; Get next non-white char from M
	RST   1         ; Compare next byte with M
    DB	52H             ; Test for 'R'
	POP   PSW       
	MVI   A,80H     
	STC             
	PUSH  PSW       
L1EBAH:	POP   PSW       
	STA   FCA7H     
	JC    L3F28H    ; Initialize BASIC Variables for new execution
	CALL  L3F28H    ; Initialize BASIC Variables for new execution
	JMP   L0502H    ; Vector to BASIC ready - print Ok
	
L1EC7H:	POP   PSW       
	POP   H         
	MVI   D,F8H     ; Load device ID for RAM
	JNZ   L4D8DH    ; Jump into RUN statement
	PUSH  H         
	LXI   H,L2020H  ; Load ASCII " " extension in HL
	SHLD  FC99H     ; Save Extension in current BASIC filename
	POP   H         
	JMP   L4D8DH    ; Jump into RUN statement
	
L1ED9H:	PUSH  H         
	LHLD  FC99H     ; Load extention of current BASIC filename
	LXI   D,L4F44H  ; Load ASCII "DO" extension in DE
	RST   3         ; Compare DE and HL
	MVI   B,00H     
	JZ    L1EF8H    
	LXI   D,L4142H  ; Load ASCII "BA" extension in DE
	RST   3         ; Compare DE and HL
	MVI   B,01H     
	JZ    L1EF8H    
	LXI   D,L2020H  ; Load ASCII " " extension in DE
	RST   3         ; Compare DE and HL
	MVI   B,02H     
	JNZ   L504EH    ; Generate NM error
L1EF8H:	POP   H         
	PUSH  B         
	DCX   H         
L1EFBH:	RST   2         ; Get next non-white char from M
	JZ    L1F10H    
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	RST   1         ; Compare next byte with M
    DB	41H             ; Test for 'A'
	POP   B         
	DCR   B         
	JZ    L504EH    ; Generate NM error
L1F08H:	XRA   A         
	LXI   D,F802H   
	PUSH  PSW       
	JMP   L4E0BH    
	
L1F10H:	POP   B         
	DCR   B         
	JM    L1F08H    
	CALL  L2081H    ; Test if an unsaved BASIC program exists
	JNZ   L08DBH    ; Generate FC error
	CALL  L20A6H    ; Copy "BA" extension to BASIC program and search for file
	CNZ   L2017H    
	CALL  L2146H    ; Update system pointers for .DO, .CO, vars, etc.
L1F24H:	CALL  L20E4H    
	SHLD  FA8CH     ; Mark Active BASIC program
	MVI   A,80H     
	XCHG            
	LHLD  VBASPP    ; Start of BASIC program pointer
	XCHG            
	CALL  L2239H    ; Save new entry to Catalog
	CALL  L21D4H    
	JMP   L0502H    ; Vector to BASIC ready - print Ok
	
	
; ======================================================
; FILES statement
; ======================================================
	PUSH  H         ; Save BASIC execution pointer to stack
	CALL  L1F42H    ; Display Catalog
	POP   H         ; Retriev BASIC execution pointer from stack
	JMP   L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	
	
; ======================================================
; Display Catalog
; ======================================================
L1F42H:	LXI   H,F957H   ; Load address of RAM Catalog (-1 entry, or 11 bytes)
L1F45H:	MVI   C,03H     ; Initialize to 3 entries per line
	LDA   VACTCC    ; Active columns count (1-40)
	CPI   28H       ; Test if 40-column SCREEN mode
	JZ    L1F51H    ; Jump if 40-column mode
	MVI   C,06H     ; Change to 6 enries per line for 80-col mode
L1F51H:	CALL  L20D5H    ; Find next Non-Empty catalog entry
	RZ              ; Return if all entries displayed
	ANI   18H       ; Test file mode bits for invisible, etc.
	JNZ   L1F51H    ; Skip this entry if it is invisible
	PUSH  H         ; Save pointer to start of this entry in catalog
	INX   H         ; Skip File type byte
	MOV   E,M       ; Get LSB of pointer to file
	INX   H         ; Advance to MSB
	MOV   D,M       ; Get MSB of pointer to file
	INX   H         ; Advance to filename
	PUSH  D         ; Push file address to stack
	MVI   B,06H     ; Preapre to print 6 characters
L1F63H:	MOV   A,M       ; Get next character to display
	RST   4         ; Send character in A to screen/printer
	INX   H         ; Increment pointer
	DCR   B         ; Decrement counter
	JNZ   L1F63H    ; Jump to display all 6 bytes
	MVI   A,2EH     ; Load ASCII '.'
	RST   4         ; Send character in A to screen/printer
	MOV   A,M       ; Get 1st Extension byte
	RST   4         ; Send character in A to screen/printer
	INX   H         ; Point to 2nd extension byte
	MOV   A,M       ; Get 2nd extension byte
	RST   4         ; Send character in A to screen/printer
	POP   D         ; Pop file address from stack
	LHLD  VBASPP    ; Start of BASIC program pointer
	RST   3         ; Compare DE and HL
	MVI   A,2AH     ; For active BASIC program, display a '*'
	MVI   B,20H     ; Load ASCII space
	JZ    L1F7FH    ; If active BASIC entry, skip to keep the '*'
	MOV   A,B       ; Replace '*' with space if not active entry
L1F7FH:	RST   4         ; Send character in A to screen/printer
	MOV   A,B       ; Get space in A`
	RST   4         ; Send character in A to screen/printer
	RST   4         ; Send character in A to screen/printer
	POP   H         ; Restore pointer to current catalog entry
	DCR   C         ; Decrement entry per line counter
	JNZ   L1F51H    ; Jump to display next entry on this line
	CALL  CRLF      ; Send CRLF to screen or printer
	CALL  L13F3H    ; Test for CTRL-C or CTRL-S to cancel listing
	JMP   L1F45H    ; Jump to reload entries per line counter
	
	
; ======================================================
; KILL statement
; ======================================================
	CALL  L207AH    ; Parse filename for device and default to RAM
	DCX   H         
	RST   2         ; Get next non-white char from M
	JNZ   ERRSYN    ; Generate Syntax error
	MOV   A,D       
	CPI   F8H       
	JZ    L1FA1H    
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	58H             
L1FA1H:	PUSH  H         
	XRA   A         
	STA   FCA7H     
	CALL  L4E22H    
	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	CALL  L20AFH    
	JZ    L5057H    ; Generate FF error
	MOV   B,A       
	ANI   20H       
	JNZ   L1FDAH    
	MOV   A,B       
	ANI   40H       
	JZ    L2005H    
	
; ======================================================
; Kill a text file
; ======================================================
	MVI   A,E5H     ; Make "PUSH H" look like "MVI A,E5H" for pass-thru
	LXI   B,0000H  ; Set deletion length to zero
	MOV   M,C       ; Zero out (HL). Why?
	MOV   L,E       ; Copy LSB of DE to HL
	MOV   H,D       ; Copy MSB of DE to HL.
L1FC6H:	LDAX  D         ; Load next byte of DO file to test for EOF
	INX   D         ; Increment to next byte
	INX   B         ; Increment length of deletion count
	CPI   1AH       ; Test if at end of DO file
	JNZ   L1FC6H    ; Jump to test next byte until EOF
	CALL  L6B9FH    ; Delete BC characters at M
L1FD1H:	CALL  L18DDH    
	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	POP   H         ; Restore HL from stack
	RET             
	
L1FD9H:	PUSH  H         
L1FDAH:	MVI   M,00H     
	LHLD  FBB0H     ; Start of CO files pointer
	PUSH  H         
	XCHG            
	PUSH  H         
	INX   H         
	INX   H         
	MOV   C,M       
	INX   H         
	MOV   B,M       
	LXI   H,L0006H  
	DAD   B         
	MOV   B,H       
	MOV   C,L       
	POP   H         
	CALL  L6B9FH    ; Delete BC characters at M
	POP   H         
	SHLD  FBB0H     ; Start of CO files pointer
	JMP   L1FD1H    
	
L1FF8H:	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	LHLD  F9B0H     
	XCHG            
	LXI   H,F9AFH   
	JMP   L1FBFH    ; Kill a text file
	
L2005H:	PUSH  H         
	LHLD  VBASPP    ; Start of BASIC program pointer
	RST   3         ; Compare DE and HL
	POP   H         
	JZ    L08DBH    ; Generate FC error
	CALL  L2017H    
	CALL  L3F2CH    ; Initialize BASIC Variables for new execution
	JMP   L0502H    ; Vector to BASIC ready - print Ok
	
L2017H:	MVI   M,00H     
	LHLD  VBASPP    ; Start of BASIC program pointer
	RST   3         ; Compare DE and HL
	PUSH  PSW       
	PUSH  D         
	CALL  L05F4H    ; Update line addresses for BASIC program at (DE)
	POP   D         
	INX   H         
	CALL  L2134H    ; Delete bytes between HL and DE
	PUSH  B         
	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	POP   B         
	POP   PSW       
	RZ              
	RC              
	LHLD  VBASPP    ; Start of BASIC program pointer
	DAD   B         
	SHLD  VBASPP    ; Start of BASIC program pointer
	RET             
	
	
; ======================================================
; NAME statement
; ======================================================
L2037H:	CALL  L207AH    ; Parse filename for device and default to RAM
	PUSH  D         ; Save device ID to stack
	CALL  L224CH    ; Swap filenames in current BASIC and last loaded from tape
	RST   1         ; Compare next byte with M
    DB	41H             ; Test for 'A'
	RST   1         ; Compare next byte with M
    DB	53H             ; Test for 'S'
	CALL  L207AH    ; Parse filename for device and default to RAM
	MOV   A,D       
	POP   D         
	CMP   D         
	JNZ   L08DBH    ; Generate FC error
	CPI   F8H       
	JZ    L2052H    
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	5AH             
L2052H:	PUSH  H         
	CALL  L20AFH    
	JNZ   L08DBH    ; Generate FC error
	CALL  L224CH    ; Swap filenames in current BASIC and last loaded from tape
	CALL  L20AFH    
	JZ    L5057H    ; Generate FF error
	PUSH  H         
	LHLD  FC99H     ; Load extension from current BASIC program
	XCHG            
	LHLD  FCA2H     
	RST   3         ; Compare DE and HL
	JNZ   L08DBH    ; Generate FC error
	POP   H         
	CALL  L224CH    ; Swap filenames in current BASIC and last loaded from tape
	INX   H         
	INX   H         
	INX   H         
	CALL  L2241H    
	POP   H         
	RET             
	
L207AH:	CALL  L4C0FH    ; Evaluate arguments to RUN/OPEN/SAVE commands
	RNZ             ; Return if device specified
	MVI   D,F8H     ; Load device ID for RAM device
	RET             
	
L2081H:	LHLD  FA8CH     ; Get address of acive program or F999H (unsaved)
	LXI   D,F999H   ; Test for "unsaved BASIC" program marker
	RST   3         ; Compare DE and HL
	RET             
	
L2089H:	LXI   B,L434FH  ; Load ASCII "DO" into BC
	JMP   L20A9H    ; Copy BC to current BASIC program ext and search for file
	
L208FH:	LHLD  FC99H     ; Load HL with 2 extension bytes from current BASIC program
	LXI   D,L2020H  ; Load DE with two spaces
	RST   3         ; Compare DE and HL
	JZ    L20A0H    ; Jump ahead if filename extension is " "
	LXI   D,L4F44H  ; Load DE with filename extension "DO"
	RST   3         ; Compare DE and HL
	JNZ   L504EH    ; Generate NM error
L20A0H:	LXI   B,L444FH  ; Put "DO" filename extension in BC
	JMP   L20A9H    ; Copy BC to current BASIC program ext and search for file
	
L20A6H:	LXI   B,L4241H  
L20A9H:	LXI   H,FC99H   ; Get pointer to current BASIC filename extension
	MOV   M,B       ; Save B in 1st extension byte
	INX   H         ; Increment pointer
	MOV   M,C       ; Save C in 2nd extension byte
L20AFH:	LXI   H,F957H   ; Load address of RAM Catalog (-1 entry, or 11 bytes)
	MVI   A,E1H     ; Make POP H below look like MVI A,E1H
	CALL  L20D5H    ; Find next Non-Empty catalog entry
	RZ              ; Return if no entries available
	PUSH  H         ; Save address of catalog entry
	INX   H         ; Point to address LSB
	INX   H         ; Point to address MSB
	LXI   D,FC92H   ; Load address of current BASIC filename - 1
	MVI   B,08H     ; Load lenght of filename (base + ext)
L20C0H:	INX   D         ; Increment to next byte of BASIC filename
	INX   H         ; Increment to next byte of catalog filename
	LDAX  D         ; Load byte from BASIC filename storage
	CMP   M         ; Compare with next byte in catalog
	JNZ   L20B3H    ; Jump to test next entry if they don't match
	DCR   B         ; Decrement filename length
	JNZ   L20C0H    ; Loop for all bytes
	POP   H         ; Pop HL from stack
	MOV   A,M       ; Get file type in A
	INX   H         ; Increment to LSB of file address
	MOV   E,M       ; Get file address in DE
	INX   H         ; Point to MSB
	MOV   D,M       ; Get MSB
	DCX   H         ; Point back to start of catalog entry
	DCX   H         ; ...
	ANA   A         ; Test for zero file type
	RET             
	
L20D5H:	PUSH  B         ; Preserve BC on stack
	LXI   B,L000BH  ; Load offset to next Catalog entry
	DAD   B         ; Advance pointer to next Catalog entry
	POP   B         ; Restore BC from stack
	MOV   A,M       ; Get Catalog file type byte
	CPI   FFH       ; Test for FFH termination marker
	RZ              ; Return if at end of Directory
	ANA   A         ; Test if entry is empty (MSB zero = empty)
	JP    L20D5H    ; Jump to test next entry in Catalog if empty
	RET             
	
L20E4H:	LDA   F651H     ; In TEXT because of BASIC EDIT flag
	ANA   A         
	LXI   H,F9AFH   
	RNZ             
	LXI   H,F9AFH   
	LXI   B,L000BH  
L20F2H:	DAD   B         
	MOV   A,M       
	CPI   FFH       
	JZ    L5066H    ; Generate FL error
	ADD   A         
	JC    L20F2H    
	RET             
	
	
; ======================================================
; NEW statement
; ======================================================
	RNZ             
L20FFH:	CALL  L2081H    ; Test if an unsaved BASIC program exists
	CNZ   L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	LXI   H,F999H   ; Load marker for "Unsaved BASIC program"
	SHLD  FA8CH     ; Save as active BASIC program
	LHLD  F99AH     ; BASIC program not saved pointer
	SHLD  VBASPP    ; Start of BASIC program pointer
	XRA   A         ; Prepare to zero out BASIC program not savedpointer
	MOV   M,A       ; Zero LSB of BASIC program not saved
	INX   H         ; Increment to MSB
	MOV   M,A       ; Zero out MSB of BASIC program not saved
	INX   H         ; Point to next byte beyond (now) empty BASIC program
	XCHG            ; Put address beyond empty BASIC program in DE
	LHLD  FBAEH     ; Start of DO files pointer
	CALL  L2134H    ; Call routine to delete bytes between last BASIC program and DO files
	LHLD  FAD8H     
	DAD   B         
	SHLD  FAD8H     
	LXI   H,FFFFH   ; Load code to indicate no paste operation in progress
	SHLD  F62EH     ; Save as index into paste buffer of "active paste operation"
	JMP   L3F28H    ; Initialize BASIC Variables for new execution
	
L212DH:	LHLD  FABAH     ; Address where last BASIC list started
	XCHG            
	LHLD  FABCH     
L2134H:	MOV   A,L       ; Prepare to calc LSB of length to delete
	SUB   E         ; Calculate LSB of delete length
	MOV   C,A       ; Save LSB in BC
	MOV   A,H       ; Prepare to calc MSB of delete length
	SBB   D         ; Calculate MSB of delete length
	MOV   B,A       ; Save MSB in BC
	XCHG            ; Put lower address in HL for the delete
	CALL  L6B9FH    ; Delete BC characters at M
	LHLD  FBAEH     ; Start of DO files pointer
	DAD   B         ; Update Start of DO files pointer by delete length
	SHLD  FBAEH     ; Start of DO files pointer
	RET             
	
	
; ======================================================
; Update system pointers for .DO), .CO), vars), etc.
; ======================================================
L2146H:	XRA   A         ; Mark type of file being searched as "BA" (BA=0, DO=1, CO=2)
	CALL  L6C42H    ; Different from M1002
	LHLD  FAC0H     ; Lowest RAM address used by system
	INX   H         ; Increment Lowest RAM address used by system
L214EH:	PUSH  H         ; And save it to the stack
	LXI   H,F98EH   ; Point to first Catalog Entry past ROM programs (-1 entry)
	LXI   D,FFFFH   ; Initialize "Min address" to FFFFH
L2155H:	CALL  L1B8FH    ; Different from M1002
	JZ    L2175H    ; Exit loop if at end of Catalog
	RRC             ; Get LSB of Catalog entry type into C flag
	JC    L2155H    ; Jump to get next entry if LSB of file type is set - skip these.
	PUSH  H         ; Preserve starting address of this entry on stack
	INX   H         ; Increment to LSB of the file's address
	MOV   A,M       ; Get LSB of catalog file's address
	INX   H         ; Increment to MSB of address
	MOV   H,M       ; Get MSB of file's address
	MOV   L,A       ; Move LSB to HL for comparison
	RST   3         ; Compare DE and HL
	POP   H         ; Restore pointer to catalog entry
	JNC   L2155H    ; Test if HL < DE (find lowest file address)
	MOV   B,H       ; Save address of file with lowest address in BC
	MOV   C,L       ; Save LSB too
	INX   H         ; Increment past file type to get file's address into DE
	MOV   E,M       ; Get LSB of file's address
	INX   H         ; Increment to MSB
	MOV   D,M       ; Get MSB of file's address
	DCX   H         ; Decrement back to LSB of address
	DCX   H         ; Decrement back to start of Catalog entry
	JMP   L2155H    ; Jump to test if next file has a lower address
	
L2175H:	MOV   A,E       ; Get LSB of lowest RAM file address
	ANA   D         ; AND with MSB to test for FFFFH
	INR   A         ; Increment to complete the test
	POP   D         ; Pop lowest RAM address used by system from stack
	JZ    L218DH    ; If FFFFH, Clear LSB of File Type byte for all Catalog entries.
	MOV   H,B       ; Get pointer to Catalog entry with lowest RAM address
	MOV   L,C       ; Get LSB too
	MOV   A,M       ; Get the file type byte for that entry
	ORI   01H       ; Set the LSB of the file type byte
	MOV   M,A       ; And write it back to the catalog. What are we marking here, the fact it is lowest?
	INX   H         ; Increment to the file's address LSB
	MOV   M,E       ; Get LSB of that file
	INX   H         ; Increment to MSB of the address
	MOV   M,D       ; Get MSB of the file's address
	XCHG            ; HL = Address of file, DE = address of Catalog entry for the file
	CALL  L219AH    ; Advance HL past end of current file based on type
	JMP   L214EH    ; Jump to process next file
	
L218DH:	LXI   H,F957H   ; Load address of RAM Catalog (-1 entry, or 11 bytes)
L2190H:	CALL  L20D5H    ; Find next Non-Empty catalog entry
	RZ              ; Return if empty catalog entry
	ANI   FEH       ; Clear LSB of Catalog entry type
	MOV   M,A       ; Save modified Catalog entry type
	JMP   L2190H    ; Jump to find next catalog entry
	
L219AH:	LDA   F809H     ; Load type of files being processed (BA, DO, CO)
	DCR   A         ; Test type being processed
	JM    L21C2H    ; Jump if BA (BA=0)
	JZ    L21AEH    ; Jump if DO (DO=1)
	INX   H         ; Skip LSB of load address of CO file
	INX   H         ; Skip MSB of load address of CO file
	MOV   E,M       ; Get LSB of length of CO file
	INX   H         ; Increment to MSB of length
	MOV   D,M       ; Get MSB of length of CO file
	INX   H         ; Increment to LSB of entry of CO file
	INX   H         ; Increment to MSB of entry
	INX   H         ; Increment again to get past end of file
	DAD   D         ; Offset to end of file by adding length
	RET             
	
L21AEH:	MVI   A,1AH     ; Load End-Of-File marker
L21B0H:	CMP   M         ; Test if at end of file
	INX   H         ; Increment to next byte in file
	JNZ   L21B0H    ; Loop until EOF marker found
	XCHG            ; Save HL in DE
	LHLD  FBB0H     ; Start of CO files pointer
	XCHG            ; Restore HL
	RST   3         ; Compare DE and HL
	RNZ             ; Return if not at end of DO file space
	MVI   A,02H     ; At end of DO. Change type to CO
	STA   F809H     ; And store it
	RET             
	
L21C2H:	XCHG            ; Move file pointer HL to DE
	CALL  L05F4H    ; Update line addresses for BASIC program at (DE)
	INX   H         ; Increment to next file
	XCHG            ; Store HL in DE
	LHLD  FBAEH     ; Start of DO files pointer
	XCHG            ; Restore HL from DE
	RST   3         ; Compare DE and HL
	RNZ             ; Return if not at end of BASIC file space
	MVI   A,01H     ; Indicate we are now in DO file space
	STA   F809H     ; And save it
	RET             
	
L21D4H:	LHLD  FBB2H     ; Start of variable data pointer
	SHLD  FBB4H     ; Start of array table pointer
	SHLD  FBB6H     ; Unused memory pointer
	LHLD  FBAEH     ; Start of DO files pointer
	DCX   H         
	SHLD  F99AH     ; BASIC program not saved pointer
	INX   H         
	LXI   B,L0002H  
	XCHG            
	CALL  L6B7FH    
	XRA   A         
	MOV   M,A       
	INX   H         
	MOV   M,A       
	LHLD  FBAEH     ; Start of DO files pointer
	DAD   B         
	SHLD  FBAEH     ; Start of DO files pointer
	JMP   L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	
	
; ======================================================
; Count length of string at M
; ======================================================
L21FAH:	PUSH  H         
	MVI   E,FFH     
L21FDH:	INR   E         
	MOV   A,M       
	INX   H         
	ANA   A         
	JNZ   L21FDH    
	POP   H         
	RET             
	
	
; ======================================================
; Get .DO filename and locate in RAM directory
; ======================================================
L2206H:	CALL  L21FAH    ; Count length of string at M
	CALL  L4C0BH    
	JNZ   ERRSYN    ; Generate Syntax error
	
; ======================================================
; Open a text file at (FC93H)
; ======================================================
L220FH:	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	CALL  L208FH    ; Find .DO or ." " file in catalog
	XCHG            
	STC             
	RNZ             
	CALL  L20E4H    
	PUSH  H         
	LHLD  FBAEH     ; Start of DO files pointer
	PUSH  H         
	MVI   A,1AH     
	CALL  L6B61H    ; Insert A into text file at M
	JC    L3F17H    ; Reinit BASIC stack and generate OM error
	POP   D         
	POP   H         
	PUSH  H         
	PUSH  D         
	MVI   A,C0H     
	DCX   D         
	CALL  L2239H    ; Save new entry to Catalog
	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	POP   H         
	POP   D         
	ANA   A         
	RET             
	
	
; ======================================================
; Save new entry to Catalog
; ======================================================
L2239H:	PUSH  D         
	MOV   M,A       
	INX   H         
	MOV   M,E       
	INX   H         
	MOV   M,D       
	INX   H         
	MVI   A,D5H     
	LXI   D,FC93H   ; Filename of current BASIC program
	MVI   B,08H     
	CALL  L3469H    ; Move B bytes from (DE) to M with increment
	POP   D         
	RET             
	
L224CH:	PUSH  H         ; Preserve HL on stack
	MVI   B,09H     ; Swap 9 bytes of filename
	LXI   D,FC93H   ; Filename of current BASIC program
	LXI   H,FC9CH   ; Filename of last program loaded from tape
L2255H:	MOV   C,M       ; Get byte from loaded from tape buffer
	LDAX  D         ; Get byte from current BASIC program buffer
	MOV   M,A       ; \
	MOV   A,C       ; Swap the bytes
	STAX  D         ; /
	INX   D         ; Increment both pointers
	INX   H         
	DCR   B         ; Decrement the loop counter
	JNZ   L2255H    ; Jump to swap all 9 bytes
	POP   H         ; Restore HL from stack
	RET             
	
L2262H:	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	LXI   H,FFFFH   ; Load code to indicate no paste operation in progress
	SHLD  F62EH     ; Save as index into paste buffer of "active paste operation"
	MOV   B,H       
	MOV   C,L       
	LHLD  F9A5H     ; Start of Paste Buffer
	PUSH  H         
	MVI   A,1AH     
L2273H:	CMP   M         
	INX   B         
	INX   H         
	JNZ   L2273H    
	POP   H         
	CALL  L6B9FH    ; Delete BC characters at M
	JMP   L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	
	
; ======================================================
; CSAVE statement
; ======================================================
	CPI   4DH       ; Test next byte is "M"
	JZ    L22DDH    ; CSAVEM statement
	CALL  L25FCH    ; Validate or default to "CAS" devce for CSAVE/CSAVEM
L2288H:	DCX   H         ; Rewind BASIC line pointer
	RST   2         ; Get next non-white char from M
	JZ    L2298H    ; If no more arguments, jump to save as tokenized
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	RST   1         ; Compare next byte with M
    DB	41H             ; Test for 'A'
	MVI   E,02H     ; Load DCB index for CAS so LIST will print to cassette
	ANA   A         ; Clear the carry bit
	PUSH  PSW       ; And push it to the stack
	JMP   L4E0BH    ; Jump to open a device and perform a LIST
	
L2298H:	CALL  L05F0H    ; Update line addresses for current BASIC program
	XCHG            ; Put address of end of BASIC program in DE
	LHLD  VBASPP    ; Start of BASIC program pointer
	MOV   A,E       ; Start calculation for length of BASIC program
	SUB   L         ; Subtract starting address LSB
	MOV   L,A       ; Save LSB difference in L
	MOV   A,D       ; Get MSB of end of BASIC program
	SUB   H         ; Subtract MSB of beginning
	MOV   H,A       ; Save MSB of difference in H
	DCX   H         ; Decrement the length
	MOV   A,H       ; Prepare to test for zero length
	ORA   L         ; OR in LSB to test for zero length
	JZ    L0501H    ; Pop stack and vector to BASIC ready
	SHLD  FAD0H     ; Length of last program loaded/saved to tape
	PUSH  H         ; Save length on Stack
	CALL  L260BH    ; Open CAS for output of BASIC files
	CALL  L2648H    ; Write 8DH data packet header to TAPE
	POP   D         
	LHLD  VBASPP    ; Start of BASIC program pointer
	
; ======================================================
; Save buffer at M to tape
; ======================================================
L22B9H:	MVI   C,00H     ; Clear the checksum
L22BBH:	MOV   A,M       ; Get next byte to send
	CALL  L14C1H    ; Write byte to tape & update checksum
	INX   H         ; Increment pointer
	DCX   D         ; Decrement count
	MOV   A,D       ; Get MSB of count
	ORA   E         ; OR in LSB of count
	JNZ   L22BBH    ; Jump to send all bytes until zero
	CALL  L2635H    ; Write checksum to TAPE
	JMP   L0501H    ; Pop stack and vector to BASIC ready
	
	
; ======================================================
; SAVEM statement
; ======================================================
L22CCH:	RST   2         ; Get next non-white char from M
	CALL  L207AH    ; Parse filename for device and default to RAM
	MOV   A,D       ; Put device ID in A
	CPI   FDH       ; Test for "CAS" device
	JZ    L22E1H    ; Jump to CSAVEM code if "CAS" specified
	CPI   F8H       ; Test for "RAM" device
	JZ    L22F4H    ; Jump to save to RAM if "RAM" specified
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	5CH             ; Go test for special device name handling
	
; ======================================================
; CSAVEM statement
; ======================================================
L22DDH:	RST   2         ; Get next non-white char from M
	CALL  L25FCH    ; Validate or default to "CAS" devce for CSAVE/CSAVEM
L22E1H:	CALL  L2346H    ; Process SAVEM Arguments
	CALL  L2611H    ; Open CAS for output of CO files
	CALL  L2648H    ; Write 8DH data packet header to TAPE
	LHLD  FAD0H     ; Length of last program loaded/saved to tape
	XCHG            
	LHLD  FACEH     ; 'Load address' of current program
	JMP   L22B9H    ; Save buffer at M to tape
	
L22F4H:	CALL  L2346H    ; Process SAVEM Arguments
	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	CALL  L2089H    ; Add .DO extension to filename and search catalog for match
	CNZ   L1FD9H    
	CALL  L20E4H    
	PUSH  H         
	LHLD  FBB0H     ; Start of CO files pointer
	PUSH  H         
	LHLD  FAD0H     ; Length of last program loaded/saved to tape
	MOV   A,H       ; Test for zero length file
	ORA   L         ; OR in LSB to test for zero
	JZ    L3F17H    ; Reinit BASIC stack and generate OM error
	PUSH  H         
	LXI   B,L0006H  
	DAD   B         
	MOV   B,H       
	MOV   C,L       
	LHLD  FBB2H     ; Start of variable data pointer
	SHLD  FB99H     ; Address of last variable assigned
	CNC   L6B6DH    ; Insert BC spaces at M
	JC    L3F17H    ; Reinit BASIC stack and generate OM error
	XCHG            
	LXI   H,FACEH   ; 'Load address' of current program
	CALL  L2540H    ; Copy 6 bytes from (DC) to (HL)
	LHLD  FACEH     ; 'Load address' of current program
	POP   B         
	CALL  L6BDBH    ; Move BC bytes from M to (DE) with increment
	POP   H         
	SHLD  FBB0H     ; Start of CO files pointer
	POP   H         
	MVI   A,A0H     
	XCHG            
	LHLD  FB99H     ; Address of last variable assigned
	XCHG            
	CALL  L2239H    ; Save new entry to Catalog
	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	JMP   L0502H    ; Vector to BASIC ready - print Ok
	
	
; ======================================================
; Process SAVEM Arguments
; ======================================================
L2346H:	CALL  L2372H    ; Call routine to process ",arg"
	PUSH  D         ; Save argument on stack - begin address
	CALL  L2372H    ; Call routine to process ",arg"
	PUSH  D         ; Save argument on stack - end address
	DCX   H         ; Rewind BASIC line pointer to test for ','
	RST   2         ; Get next non-white char from M
	LXI   D,0000H  ; Set execution address to NULL
	CNZ   L2372H    ; Call routine to process ",arg" if provided
	DCX   H         ; Rewind BASIC line pointer
	RST   2         ; Get next non-white char from M
	JNZ   ERRSYN    ; Generate Syntax error
	XCHG            ; Put execute address in HL
	SHLD  FAD2H     ; Save exec address in TAPE header buffer
	POP   D         ; Pop end address
	POP   H         ; Pop start address
	SHLD  FACEH     ; 'Load address' of current program
	MOV   A,E       ; Prepare to calculate length of CO file
	SUB   L         ; Subtract LSB of start from LSB of end
	MOV   L,A       ; Save LSB of length in L
	MOV   A,D       ; Get MSB of end of CO
	SUB   H         ; Subtract MSB of start of CO
	MOV   H,A       ; Save MSB of length in H
	JC    L08DBH    ; Generate FC error
	INX   H         ; Increment length
	SHLD  FAD0H     ; Length of last program loaded/saved to tape
	RET             
	
L2372H:	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	JMP   L1297H    ; Evaluate expression at M
	
	
; ======================================================
; CLOAD statement
; ======================================================
L2377H:	CPI   4DH       ; Test for 'M' character
	JZ    L24A7H    ; CLOADM statement
	CPI   A3H       ; Test for PRINT token ID
	JZ    L2456H    ; If "CLOAD PRINT", jump to compare TAPE file with RAM file
	CALL  L25E7H    ; Evaluate arguments to CLOAD/CLOADM & Clear current BASIC program
	ORI   FFH       
	PUSH  PSW       
L2387H:	POP   PSW       
	PUSH  PSW       
	JNZ   L2391H    
	DCX   H         
	RST   2         ; Get next non-white char from M
	JNZ   L08DBH    ; Generate FC error
L2391H:	DCX   H         
	RST   2         ; Get next non-white char from M
	MVI   A,00H     
	STC             
	CMC             
	JZ    L23A6H    
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	RST   1         ; Compare next byte with M
    DB	52H             ; Test for 'R' (RUN option)
	JNZ   ERRSYN    ; Generate Syntax error
	POP   PSW       
	STC             
	PUSH  PSW       
	MVI   A,80H     
L23A6H:	PUSH  PSW       
	STA   FCA7H     
L23AAH:	CALL  L2667H    ; Read file header from tape
	CPI   D3H       ; Test for tokenized BASIC file tag
	JZ    L23BDH    ; Jump to load tokenized BASIC
	CPI   9CH       ; Test for ASCII / DO file
	JZ    L2432H    ; Jump to load ASCII / DO file
L23B7H:	CALL  L26DDH    ; Print program on tape being skipped
	JMP   L23AAH    ; Jump to load next file on tape
	
L23BDH:	POP   B         
	POP   PSW       
	PUSH  PSW       
	PUSH  B         
	JZ    L23B7H    
	POP   PSW       
	POP   PSW       
	SBB   A         
	STA   FC92H     
	CALL  L26E3H    ; Print selected program/file "Found" on tape
	CALL  L20FFH    ; NEW statement
	LHLD  FAD0H     ; Length of last program loaded/saved to tape
	PUSH  H         
	MOV   B,H       
	MOV   C,L       
	LHLD  VBASPP    ; Start of BASIC program pointer
	PUSH  H         
	CALL  L6B6DH    ; Insert BC spaces at M
	JC    L3F17H    ; Reinit BASIC stack and generate OM error
	LXI   H,L2426H  ; ON ERROR handler for CLOAD
	SHLD  F652H     ; Save as active ON ERROR handler vector
	LHLD  FBAEH     ; Start of DO files pointer
	DAD   B         ; Update start of DO files pointer based on load length
	SHLD  FBAEH     ; Start of DO files pointer
	CALL  L26D1H    ; Load Tape sync, header and 8DH marker & validate
	POP   H         
	POP   D         
	CALL  L2413H    ; Load record from tape and store at M
	JNZ   L2426H    ; On-error return handler for CLOAD statement
	MOV   L,A       ; Prepare to NULL error long jump address
	MOV   H,A       ; Prepare to NULL error long jump address
	SHLD  F652H     ; Long jump return address on error
	CALL  L14AAH    ; Turn cassette motor off
	CALL  L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	CALL  L05F0H    ; Update line addresses for current BASIC program
	CALL  L3F28H    ; Initialize BASIC Variables for new execution
	LDA   FC92H     ; Flag to execute BASIC program
	ANA   A         ; Test if execute requested
	JNZ   L0804H    ; Execute BASIC program
	JMP   L0502H    ; Vector to BASIC ready - print Ok
	
	
; ======================================================
; Load record from tape and store at M
; ======================================================
L2413H:	MVI   C,00H     ; Clear the checksum
L2415H:	CALL  L14B0H    ; Read byte from tape & update checksum
	MOV   M,A       ; Save next byte loaded from tape
	INX   H         ; Increment destination pointer
	DCX   D         ; Decrement length
	MOV   A,D       ; Prepare to test for zero length remaining
	ORA   E         ; OR in LSB of length
	JNZ   L2415H    ; Jump to read more data from tape until zero
	CALL  L14B0H    ; Read byte from tape & update checksum
	MOV   A,C       ; Move checksum to A
	ANA   A         ; Test checksum for zero
	RET             
	
	
; ======================================================
; On-error return handler for CLOAD statement
; ======================================================
L2426H:	CALL  L20FFH    ; NEW statement
	LXI   H,0000H  ; Prepare to clear ON ERROR handler vector
	SHLD  F652H     ; Save as active ON ERROR handler vector
	JMP   L1491H    ; Turn cassette motor off and generate I/O Error
	
L2432H:	CALL  L26E3H    ; Print selected program/file "Found" on tape
	CALL  L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	LHLD  FC83H     ; File number description table pointer
	MOV   A,M       
	INX   H         
	MOV   H,M       
	MOV   L,A       
	SHLD  FC8CH     ; Save pointer to FCB for ASCII / tokenization
	MVI   M,01H     
	INX   H         
	INX   H         
	INX   H         
	INX   H         
	MVI   M,FDH     ; Save file type as CAS device ID
	INX   H         
	INX   H         
	XRA   A         
	MOV   M,A       
	INX   H         
	MOV   M,A       
	STA   FA8EH     
	JMP   L4DA6H    
	
L2456H:	CALL  L25E8H    ; Evaluate arguments to CLOAD/CLOADM & Clear current BASIC program
	PUSH  H         ; Preserve HL on stack
	CALL  L2650H    ; Open CAS for input of BASIC files
	CALL  L26D1H    ; Load Tape sync, header and 8DH marker & validate
	LHLD  FAD0H     ; Length of last program loaded/saved to tape
	XCHG            
	LHLD  VBASPP    ; Start of BASIC program pointer
	CALL  L2590H    ; Compare the file on tape with file at HL
	JNZ   L2478H    ; Generate Verify Failed error
	MOV   A,M       ; Get next line pointer of BASIC program
	INX   H         ; Increment to MSB of pointer
	ORA   M         ; OR in MSB to test for end of BASIC program
	JNZ   L2478H    ; Generate Verify Failed error
L2473H:	CALL  L14AAH    ; Turn cassette motor off
	POP   H         ; Restore HL
	RET             
	
	
; ======================================================
; Generate Verify Failed error
; ======================================================
L2478H:	LXI   H,L2481H  ; Load pointer to "Verify failed" text
	CALL  L5791H    ; Print buffer at M until NULL or '"'
	JMP   L2473H    ; Turn the cassette motor off, POP H and return
	
L2481H:	"Verifyfailed",0DH,0AH,00H
	
	
; ======================================================
; LOADM and RUNM statement
; ======================================================
L2491H:	RST   2         ; Get next non-white char from M
	POP   PSW       
	PUSH  PSW       
	JZ    L08DBH    ; Generate FC error
	CALL  L207AH    ; Parse filename for device and default to RAM
	MOV   A,D       
	CPI   FDH       ; Test for load from CAS device
	JZ    L24B3H    ; Jump to CLOADM routine if load from CAS
	CPI   F8H       ; Test for load from RAM device
	JZ    L24E7H    ; Jump to load from RAM if RAM device
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	5EH             
	
; ======================================================
; CLOADM statement
; ======================================================
L24A7H:	RST   2         ; Get next non-white char from M
	CPI   A3H       ; Test for PRINT token ID
	JZ    L2573H    ; If "CLOADM PRINT", jump to verify the TAPE file to RAM file
	CALL  L25E7H    ; Evaluate arguments to CLOAD/CLOADM & Clear current BASIC program
	ORI   FFH       
	PUSH  PSW       
L24B3H:	DCX   H         
	RST   2         ; Get next non-white char from M
	JNZ   ERRSYN    ; Generate Syntax error
	PUSH  H         
	CALL  L2656H    ; Open CAS for input of CO files
	LHLD  FAD2H     
	MOV   A,H       
	ORA   L         
	JNZ   L24CBH    
	POP   H         
	POP   PSW       
	PUSH  PSW       
	PUSH  H         
	JC    L08DBH    ; Generate FC error
L24CBH:	CALL  L2531H    ; Print .CO info and test HIMEM for space to load
	JC    L3F17H    ; Reinit BASIC stack and generate OM error
	CALL  L26D1H    ; Load Tape sync, header and 8DH marker & validate
	LHLD  FAD0H     ; Length of last program loaded/saved to tape
	XCHG            
	LHLD  FACEH     ; 'Load address' of current program
	CALL  L2413H    ; Load record from tape and store at M
	JNZ   L1491H    ; Turn cassette motor off and generate I/O Error
	CALL  L14AAH    ; Turn cassette motor off
	JMP   L251AH    
	
L24E7H:	PUSH  H         
	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	CALL  L2089H    ; Add .DO extension to filename and search catalog for match
	JZ    L5057H    ; Generate FF error
	XCHG            
	CALL  L253DH    ; Copy .CO 6-byte header to Current Program Area
	PUSH  H         
	LHLD  FAD2H     
	MOV   A,H       
	ORA   L         
	JNZ   L2507H    
	POP   D         
	POP   H         
	POP   PSW       
	PUSH  PSW       
	PUSH  H         
	PUSH  D         
	JC    L08DBH    ; Generate FC error
L2507H:	CALL  L2531H    ; Print .CO info and test HIMEM for space to load
	JC    L3F17H    ; Reinit BASIC stack and generate OM error
	LHLD  FAD0H     ; Length of last program loaded/saved to tape
	MOV   B,H       
	MOV   C,L       
	LHLD  FACEH     ; 'Load address' of current program
	XCHG            
	POP   H         
	CALL  L6BDBH    ; Move BC bytes from M to (DE) with increment
L251AH:	POP   H         
	POP   PSW       
	JNC   L3F2CH    ; Initialize BASIC Variables for new execution
	CALL  L3F2CH    ; Initialize BASIC Variables for new execution
	LHLD  FAD2H     
	SHLD  F661H     ; Address last called
	CALL  F660H     
	LHLD  FB99H     ; Address of last variable assigned
	JMP   L0804H    ; Execute BASIC program
	
L2531H:	CALL  L25A4H    ; Print .CO information to LCD (start address, etc.)
L2534H:	LHLD  VHIMEM    ; HIMEM
	XCHG            ; Swap HL and DE for comparison
	LHLD  FACEH     ; 'Load address' of current program
	RST   3         ; Compare DE and HL
	RET             
	
	
; ======================================================
; Copy .CO 6-byte header to Current Program Area
; ======================================================
L253DH:	LXI   D,FACEH   ; 'Load address' of current program
L2540H:	MVI   B,06H     ; Load count of 6 bytes to copy
	
; ======================================================
; Move B bytes from M to (DE)
; ======================================================
L2542H:	MOV   A,M       ; Get next source byte
	STAX  D         ; Save next dest byte
	INX   H         ; Increment source
	INX   D         ; Increment dest
	DCR   B         ; Decrement count
	JNZ   L2542H    ; Move B bytes from M to (DE)
	RET             
	
	
; ======================================================
; Launch .CO files from MENU
; ======================================================
L254BH:	CALL  L253DH    ; Copy .CO 6-byte header to Current Program Area
	PUSH  H         ; Save pointer to .CO data on stack
	CALL  L2534H    ; Test HIMEM for space to load CO file
	JC    L256DH    ; BEEP and return to MENU
	XCHG            
	LHLD  FAD0H     ; Length of last program loaded/saved to tape
	MOV   B,H       ; Save length in BC
	MOV   C,L       ; ...save LSB too
	POP   H         ; Restore pointer to .CO data
	CALL  L6BDBH    ; Move BC bytes from M to (DE) with increment
	LHLD  FAD2H     ; Point .CO header entry address
	MOV   A,H       ; Validate entry address is not NULL
	ORA   L         ; OR in LSB to test for NULL
	SHLD  F661H     ; Address last called
	CNZ   F660H     ; Call to launch .CO if entry address not zero
	JMP   L5797H    ; MENU Program
	
L256DH:	CALL  BEEP      ; BEEP statement
	JMP   L5797H    ; MENU Program
	
L2573H:	RST   2         ; Get next non-white char from M
	CALL  L25E7H    ; Evaluate arguments to CLOAD/CLOADM & Clear current BASIC program
	PUSH  H         ; Save pointer to BASIC command line
	CALL  L2656H    ; Open CAS for input of CO files
	CALL  L26D1H    ; Load Tape sync, header and 8DH marker & validate
	LHLD  FAD0H     ; Length of last program loaded/saved to tape
	XCHG            
	LHLD  FACEH     ; 'Load address' of current program
	CALL  L2590H    ; Compare the file on tape with file at HL
	JNZ   L2478H    ; Generate Verify Failed error
	CALL  L14AAH    ; Turn cassette motor off
	POP   H         ; Restore pointer to BASIC command line
	RET             
	
L2590H:	MVI   C,00H     ; Clear the checksum byte
L2592H:	CALL  L14B0H    ; Read byte from tape & update checksum
	CMP   M         ; Compare next byte of file
	RNZ             ; Return if no match
	INX   H         ; Point to next byte in RAM file
	DCX   D         ; Decrement length
	MOV   A,D       ; Prepare to test for zero
	ORA   E         ; OR in LSB of length
	JNZ   L2592H    ; Jump to validate more if not at end
	CALL  L14B0H    ; Read byte from tape & update checksum
	MOV   A,C       ; Get checksum
	ANA   A         ; Check for zero
	RET             
	
L25A4H:	LHLD  F67AH     ; Current executing line number
	INX   H         ; Increment address of executing BASIC line
	MOV   A,H       ; Put MSB in A (current line pointer is 0xFFFF when no BASIC exec)
	ORA   L         ; OR in LSB to test for zero
	RNZ             ; Return if a BASIC program is running ... don't print
	LHLD  FACEH     ; 'Load address' of current program
	PUSH  H         ; Save start address on stack
	XCHG            ; Put it in DE
	LXI   H,L25D5H  ; Load pointer to "Top: " text
	CALL  L25CDH    ; Call to print HL and binary DE
	LHLD  FAD0H     ; Length of last program loaded/saved to tape
	DCX   H         ; Decrement length to calculate last address
	POP   D         ; Pop start adddress from stack
	DAD   D         ; Calculate last address
	XCHG            ; Put last address in DE for print
	LXI   H,L25DBH  ; Load pointer to "End: " text
	CALL  L25CDH    ; Call to print HL and binary DE
	LHLD  FAD2H     ; Load .CO entry address from TAPE buffer
	MOV   A,H       ; Prepare to test for NULL entry address
	ORA   L         ; OR in LSB to test for NULL entry address
	RZ              ; Return if entry is null
	XCHG            ; Put entry address in DE
	LXI   H,L25E1H  ; Load pointer to "Exe: " text
L25CDH:	PUSH  D         ; Save binary address to print on stack
	CALL  L5791H    ; Print buffer at M until NULL or '"'
	POP   H         ; Pop binary address to print into HL
	JMP   L39D4H    ; Print binary number in HL at current position
	
L25D5H:
    DB	"Top: ",00H     
L25DBH:
    DB	"End: ",00H     
L25E1H:
    DB	"Exe: ",00H     
	
L25E7H:	DCX   H         ; Point to byte before SPACE in command line
L25E8H:	RST   2         ; Get next non-white char from M
	JNZ   L25FCH    ; Validate or default to "CAS" devce for CSAVE/CSAVEM
	MVI   B,06H     ; Get length of filenames
	LXI   D,FC93H   ; Filename of current BASIC program
	MVI   A,20H     ; Prepare to clear out the current BASIC program
L25F3H:	STAX  D         ; Set next byte of current BASIC program to SPACE
	INX   D         ; Point to next byte
	DCR   B         ; Decrement counter
	JNZ   L25F3H    ; Keep looping until counter is zero
	JMP   L2602H    
	
L25FCH:	CALL  L4C0FH    ; Evaluate arguments to RUN/OPEN/SAVE commands
	JNZ   L2604H    ; Skip if device name provided in filename
L2602H:	MVI   D,FDH     ; Default to CAS device
L2604H:	MOV   A,D       ; Copy device name to A
	CPI   FDH       ; Test if provided device name is "CAS"
	JNZ   L08DBH    ; Generate FC error
	RET             
	
	
; ======================================================
; Open CAS for output of BASIC files
; ======================================================
L260BH:	MVI   A,D3H     ; Load Tape header ID for BASIC program
	LXI   B,9C3EH   ; Make MVI A,9CH look like LXI B,9C3EH
	LXI   B,D03EH   ; Make MVI A,D0H look like LXI B,D03EH
	PUSH  PSW       ; Save program type ID to stack
	CALL  L1499H    ; Turn cassette motor on and detect sync header
	POP   PSW       ; Restore program type ID from stack
	CALL  L14C1H    ; Write byte to tape & update checksum
	MVI   C,00H     ; Zero out the checksum
	LXI   H,FC93H   ; Filename of current BASIC program
	LXI   D,L0602H  ; Write 6 filename bytes and set E loop
L2623H:	MOV   A,M       ; Get next byte to write
	CALL  L14C1H    ; Write byte to tape & update checksum
	INX   H         ; Increment to next byte to send
	DCR   D         ; Decrement loop counter
	JNZ   L2623H    ; Loop for all bytes to send
	LXI   H,FACEH   ; 'Load address' of current program
	MVI   D,0AH     ; For 2nd loop, write 10 dummy values
	DCR   E         ; Decrement outer loop
	JNZ   L2623H    ; Loop for header bytes
L2635H:	MOV   A,C       ; Get checksum byte
	CMA             ; Compliment checksum
	INR   A         ; And add 1 (2's compliment)
	CALL  L14C1H    ; Write byte to tape & update checksum
	MVI   B,14H     ; Prepare to send 20 NULL bytes to tape
L263DH:	XRA   A         ; Clear out A
	CALL  L14C1H    ; Write byte to tape & update checksum
	DCR   B         ; Decrement counter
	JNZ   L263DH    ; Loop to send all 20 NULL bytes
	JMP   L14AAH    ; Turn cassette motor off
	
L2648H:	CALL  L1499H    ; Turn cassette motor on and detect sync header
	MVI   A,8DH     ; Load code for block header
	JMP   L14C1H    ; Write byte to tape & update checksum
	
	
; ======================================================
; Open CAS for input of BASIC files
; ======================================================
L2650H:	MVI   B,D3H     ; Load TAPE header byte for tokenized BASIC file
	LXI   D,9C06H   ; Make MVI B,9CH look like LXI D,9C06H
	LXI   D,D006H   ; Make MVI B,D0H look like LXI D,D006H
L2658H:	PUSH  B         ; Save header ID on stack
	CALL  L2667H    ; Read file header from tape
	POP   B         ; Restore header ID from stack
	CMP   B         ; Test if ID on tape matches the type we are looking for
	JZ    L26E3H    ; Print selected program/file "Found" on tape if match
	CALL  L6C37H    ; Different from M1002
	JMP   L2658H    ; Jump to find next file on tape
	
L2667H:	CALL  L148AH    ; Start tape and load tape header
	CALL  L14B0H    ; Read byte from tape & update checksum
	CPI   D3H       ; Test for tokenized BASIC ID byte
	JZ    L267CH    ; Jump if tokenized BASIC file
	CPI   9CH       ; Test for ASCII / DO file ID type
	JZ    L267CH    ; Jump if ASCII / DO file
	CPI   D0H       ; Test for .CO file type marker
	JNZ   L2667H    ; Jump to skip file if not a valid header byte
L267CH:	PUSH  PSW       ; Save file type on stack
	LXI   H,FC9CH   ; Filename of last program loaded from tape
	LXI   D,L0602H  ; Prepare to read filename and 10 byte header
	MVI   C,00H     ; Zero out the checksum
L2685H:	CALL  L14B0H    ; Read byte from tape & update checksum
	MOV   M,A       ; Save next byte (filename or header)
	INX   H         ; Increment the destination pointer
	DCR   D         ; Decrement the loop count
	JNZ   L2685H    ; Jump to read all bytes
	LXI   H,FACEH   ; 'Load address' of current program
	MVI   D,0AH     ; Load 10 bytes on 2nd loop
	DCR   E         ; Decrement loop counter
	JNZ   L2685H    ; Jump for 2nd loop to read 10 header bytes
	CALL  L14B0H    ; Read byte from tape & update checksum
	MOV   A,C       ; Get the checksum
	ANA   A         ; Test for zero
	JNZ   L26CDH    ; Jump if not zero to find next file on tape
	CALL  L14AAH    ; Turn cassette motor off
	LXI   H,FC93H   ; Filename of current BASIC program
	MVI   B,06H     ; Get length of filename
	MVI   A,20H     ; Load ASCII space
L26A9H:	CMP   M         ; Test for blank filename
	JNZ   L26B5H    ; Jump if filename not blank
	INX   H         ; Increment filename pointer
	DCR   B         ; Decrement count
	JNZ   L26A9H    ; Jump to test next byte for non-space
	JMP   L26C8H    ; Jump to return if not looking for specific file
	
L26B5H:	LXI   D,FC93H   ; Filename of current BASIC program
	LXI   H,FC9CH   ; Filename of last program loaded from tape
	MVI   B,06H     ; Prepare to compare 6 bytes of filename
L26BDH:	LDAX  D         ; Load next byte of filename we want to load
	CMP   M         ; Compare with next byte of filename on tape
	JNZ   L26CAH    ; Jump if they don't match
	INX   D         ; Increment target filename pointer
	INX   H         ; Increment tape filename pointer
	DCR   B         ; Decrement length
	JNZ   L26BDH    ; Loop to test all bytes
L26C8H:	POP   PSW       ; Cleanup stack
	RET             ; File found
	
L26CAH:	CALL  L26DDH    ; Print program on tape being skipped
L26CDH:	POP   PSW       ; Cleanup stack
	JMP   L2667H    ; Go read next file from tape
	
L26D1H:	CALL  L148AH    ; Start tape and load tape header
	CALL  L14B0H    ; Read byte from tape & update checksum
	CPI   8DH       ; Test for 8Dh block header byte
	JNZ   L1491H    ; Turn cassette motor off and generate I/O Error
	RET             
	
L26DDH:	LXI   D,L2705H  ; Point to "Skip :" text
	JMP   L26E6H    ; Print selected program/file "Found" on tape
	
L26E3H:	LXI   D,L26FEH  ; Point to "Found:" text
L26E6H:	LHLD  F67AH     ; Current executing line number
	INX   H         ; Prepare to test if BASIC running
	MOV   A,H       ; Get MSB of exec line number
	ORA   L         ; Get LSB
	RNZ             ; Return if BASIC exectuing ... don't print
	XCHG            ; Put pointer to string in HL
	CALL  L5791H    ; Print buffer at M until NULL or '"'
	XRA   A         
	STA   FCA2H     
	LXI   H,FC9CH   ; Filename of last program loaded from tape
	CALL  L27B1H    ; Print buffer at M until NULL or '"'
	JMP   ERABOL    ; Erase from cursor to end of line
	
L26FEH:
    DB	"Found:",00H          
L2705H:
    DB	"Skip :",00H    
L270CH:	CALL  L2916H    ; Get pointer to most recently used string (Len + address)
	MOV   A,M       ; Get length of most recently used string
	INX   H         ; Increment to LSB of string pointer
	MOV   C,M       ; Get LSB of string pointer
	INX   H         ; Increment to MSB of string pointer
	MOV   B,M       ; Get MSB of string pointer
	POP   D         
	PUSH  B         ; Push pointer to string on stack
	PUSH  PSW       ; Preserve string length
	CALL  L291DH    ; Get pointer to stack string (Len + address). POP based on DE
	POP   PSW       ; Restore length of most recently used string
	MOV   D,A       ; Save length in D
	MOV   E,M       ; Get length of string from stack into E
	INX   H         ; Increment to LSB of stack string
	MOV   C,M       ; Get LSB of pointer to string from stack
	INX   H         ; Increment to MSB
	MOV   B,M       ; Get MSB of pointer to string
	POP   H         ; Restore pointer to most recently used string
L2722H:	MOV   A,E       ; Get length of string from string stack
	ORA   D         ; Or in length of most recently used string
	RZ              ; Return if both lengths are zero
	MOV   A,D       ; Get length of most recently used string
	SUI   01H       ; Subtract 1 from length to test for zero
	RC              ; Return if at end of string
	XRA   A         ; Zero out A
	CMP   E         ; Test if at end of string from string stack
	INR   A         ; Increment A (I guess to indicate strings different length)
	RNC             ; Return if at end of string from string stack
	DCR   D         ; Decrement length of string 1
	DCR   E         ; Decrement length of string 2
	LDAX  B         ; Load next byte of string from string stack
	INX   B         ; Increment string pointer
	CMP   M         ; Compare with next byte from most recently used string
	INX   H         ; Increment pointer
	JZ    L2722H    ; If they are equal, jump back to test the length again until at end
	CMC             ; Compliment the Carry flag for calculation of which string is larger
	JMP   L33E9H    ; Jump to return 1 or -1 in A based on Carry flag
	
	
; ======================================================
; STR$ function
; ======================================================
L273AH:	CALL  L39E8H    ; Convert binary number in FAC1 to ASCII at M
	CALL  L276BH    ; Search string at M until QUOTE found
	CALL  L2919H    ; Get pointer to most recently used string
	LXI   B,L2969H  
	PUSH  B         
L2747H:	MOV   A,M       
	INX   H         
	PUSH  H         
	CALL  L27C8H    ; Find space in BASIC String storage for A bytes
	POP   H         
	MOV   C,M       
	INX   H         
	MOV   B,M       
	CALL  L2760H    
	PUSH  H         
	MOV   L,A       
	CALL  L290CH    
	POP   D         
	RET             
	
L275BH:	MVI   A,01H     ; Prepare to find 1 byte in BASIC String storage
L275DH:	CALL  L27C8H    ; Find space in BASIC String storage for A bytes
L2760H:	LXI   H,FB89H   ; Load address of transient string
	PUSH  H         ; Save address on stack
	MOV   M,A       ; Copy A to transient string
	INX   H         ; Increment to next byte
	MOV   M,E       ; Save LSB of DE to transient
	INX   H         ; Increment to next byte
	MOV   M,D       ; Save MSB of DE to transient
	POP   H         ; Restore address of transient
	RET             
	
L276BH:	DCX   H         ; Pre-decrement HL
L276CH:	MVI   B,22H     ; Load ASCII code for QUOTE
L276EH:	MOV   D,B       ; Make B & D termination chars the same
L276FH:	PUSH  H         ; Save HL on stack
	MVI   C,FFH     ; Initialize counter / index
L2772H:	INX   H         ; Increment to next byte in string
	MOV   A,M       ; Get next byte in string
	INR   C         ; Increment count / index
	ORA   A         ; Test for zero (end of string)
	JZ    L2781H    ; Jump if end of string
	CMP   D         ; Compare with character in D
	JZ    L2781H    ; Exit loop if match
	CMP   B         ; Compare with character in B
	JNZ   L2772H    ; Jump back to compare next byte in string if no match
L2781H:	CPI   22H       ; Compare with QUOTE
	CZ    L0858H    ; RST 10H routine with pre-increment of HL
	XTHL            ; Restore pointer to string from stack
	INX   H         
	XCHG            
	MOV   A,C       
	CALL  L2760H    ; Save A and DE to transient string storage
L278DH:	LXI   D,FB89H   ; Point to transient string storage
	MVI   A,D5H     ; TODO: another half instruction trick, resolve
	LHLD  FB69H     ; Get current location in string stack maybe?
	SHLD  FC1AH     ; Start of FAC1 for integers
	MVI   A,03H     ; Make type of last variable a string
	STA   FB65H     ; Type of last variable used
	CALL  L3465H    ; Copy transient string onto string stack perhaps?
	LXI   D,FB8CH   ; Pointer to current location in BASIC string buffer
	RST   3         ; Compare DE and HL
	SHLD  FB69H     ; Save new location in string stack?
	POP   H         
	MOV   A,M       
	RNZ             
	LXI   D,L0010H  ; Load code for ST error (String too Complex)
	JMP   L045DH    ; Generate error in E
	
L27B0H:	INX   H         
	
; ======================================================
; Print buffer at M until NULL or '"'
; ======================================================
L27B1H:	CALL  L276BH    ; Search string at M until QUOTE found
L27B4H:	CALL  L2919H    ; Get pointer to most recently used string
	CALL  L3452H    ; Load strlen to D, str pointer to BC
	INR   D         ; Pre increment length
L27BBH:	DCR   D         ; Decrement len to test for zero
	RZ              ; Return if length is zero (nothing to print)
	LDAX  B         ; Get next byte
	RST   4         ; Send character in A to screen/printer
	CPI   0DH       ; Test for CR
	CZ    L4BD1H    ; Call routine to print CR
	INX   B         ; Increment string pointer
	JMP   L27BBH    ; Loop to print all bytes in string
	
L27C8H:	ORA   A         ; Test if A is zero
	MVI   C,F1H     ; I think this is a hidden "(F1H) POP PSW" at address 27CAH
	PUSH  PSW       ; Save A & flags to stack
	LHLD  VTPRAM    ; BASIC string buffer pointer
	XCHG            
	LHLD  FB8CH     ; Pointer to current location in BASIC string buffer
	CMA             ; Compliment A to determine how much space needed in buffer for string
	MOV   C,A       ; Move Negative value to C
	MVI   B,FFH     ; Sign extend BC
	DAD   B         ; Subtract length from current buffer location
	INX   H         ; Increment for 2's compliment
	RST   3         ; Compare DE and HL
	JC    L27E4H    ; Jump to move stuff around if no space
	SHLD  FB8CH     ; Save new current BASIC string buffer location
	INX   H         ; Increment to next location in BASIC string buffer. Why?
	XCHG            ; DE has current location, HL has start
L27E2H:	POP   PSW       ; Restore stack frame
	RET             
	
L27E4H:	POP   PSW       ; Get Flags from stack
	LXI   D,L000EH  ; Prepare to generate OS Error
	JZ    L045DH    ; Generate error in E
	CMP   A         
	PUSH  PSW       
	LXI   B,L27CAH  ; I think this is a RET address to a POP PSW above
	PUSH  B         
L27F1H:	LHLD  FB67H     ; File buffer area pointer
L27F4H:	SHLD  FB8CH     ; Pointer to current location in BASIC string buffer
	LXI   H,0000H  
	PUSH  H         
	LHLD  FBB6H     ; Unused memory pointer
	PUSH  H         
	LXI   H,FB6BH   
L2802H:	XCHG            
	LHLD  FB69H     
	XCHG            
	RST   3         ; Compare DE and HL
L2808H:	LXI   B,L2802H  
	JNZ   L2887H    
	LXI   H,FBD9H   
	SHLD  FBE2H     
	LHLD  FBB4H     ; Start of array table pointer
	SHLD  FBDFH     
	LHLD  FBB2H     ; Start of variable data pointer
L281DH:	XCHG            
	LHLD  FBDFH     
	XCHG            
	RST   3         ; Compare DE and HL
	JZ    L283AH    
	MOV   A,M       
	INX   H         
	INX   H         
	INX   H         
	CPI   03H       
	JNZ   L2833H    
	CALL  L2888H    
	XRA   A         
L2833H:	MOV   E,A       
	MVI   D,00H     
	DAD   D         
	JMP   L281DH    
	
L283AH:	LHLD  FBE2H     
	MOV   E,M       
	INX   H         
	MOV   D,M       
	MOV   A,D       
	ORA   E         
	LHLD  FBB4H     ; Start of array table pointer
	JZ    L285CH    
	XCHG            
	SHLD  FBE2H     
	INX   H         
	INX   H         
	MOV   E,M       
	INX   H         
	MOV   D,M       
	INX   H         
	XCHG            
	DAD   D         
	SHLD  FBDFH     
	XCHG            
	JMP   L281DH    
	
L285BH:	POP   B         
L285CH:	XCHG            
	LHLD  FBB6H     ; Unused memory pointer
	XCHG            
	RST   3         ; Compare DE and HL
	JZ    L28A8H    
	MOV   A,M       
	INX   H         
	CALL  L3450H    ; Reverse load single precision at M to DEBC
	PUSH  H         
	DAD   B         
	CPI   03H       
	JNZ   L285BH    
	SHLD  FB90H     
	POP   H         
	MOV   C,M       
	MVI   B,00H     
	DAD   B         
	DAD   B         
	INX   H         
L287BH:	XCHG            
	LHLD  FB90H     
	XCHG            
	RST   3         ; Compare DE and HL
	JZ    L285CH    
	LXI   B,L287BH  
L2887H:	PUSH  B         
L2888H:	XRA   A         
	ORA   M         
	INX   H         
	MOV   E,M       
	INX   H         
	MOV   D,M       
	INX   H         
	RZ              
	MOV   B,H       
	MOV   C,L       
	LHLD  FB8CH     ; Pointer to current location in BASIC string buffer
	RST   3         ; Compare DE and HL
	MOV   H,B       
	MOV   L,C       
	RC              
	POP   H         
	XTHL            
	RST   3         ; Compare DE and HL
	XTHL            
	PUSH  H         
	MOV   H,B       
	MOV   L,C       
	RNC             
	POP   B         
	POP   PSW       
	POP   PSW       
	PUSH  H         
	PUSH  D         
	PUSH  B         
	RET             
	
L28A8H:	POP   D         
	POP   H         
	MOV   A,H       
	ORA   L         
	RZ              
	DCX   H         
	MOV   B,M       
	DCX   H         
	MOV   C,M       
	PUSH  H         
	DCX   H         
	MOV   L,M       
	MVI   H,00H     
	DAD   B         
	MOV   D,B       
	MOV   E,C       
	DCX   H         
	MOV   B,H       
	MOV   C,L       
	LHLD  FB8CH     ; Pointer to current location in BASIC string buffer
	CALL  L3EF3H    
	POP   H         
	MOV   M,C       
	INX   H         
	MOV   M,B       
	MOV   H,B       
	MOV   L,C       
	DCX   H         
	JMP   L27F4H    
	
L28CCH:	PUSH  B         
	PUSH  H         
	LHLD  FC1AH     ; Start of FAC1 for integers
	XTHL            
	CALL  L0F1CH    ; Evaluate function at M
	XTHL            
	CALL  L35D9H    ; Generate TM error if last variable type not string or RET
	MOV   A,M       
	PUSH  H         
	LHLD  FC1AH     ; Start of FAC1 for integers
	PUSH  H         
	ADD   M         
	LXI   D,L000FH  ; Prepare to generate LS Error (String too Long)
	JC    L045DH    ; Generate error in E
	CALL  L275DH    ; Create a transient string of length A
	POP   D         
	CALL  L291DH    
	XTHL            
	CALL  L291CH    
	PUSH  H         
	LHLD  FB8AH     ; Address of transient string
	XCHG            
	CALL  L2904H    ; Memory copy using args following the CALL statement
	CALL  L2904H    ; Memory copy using args following the CALL statement
	LXI   H,L0DB7H  
	XTHL            
	PUSH  H         
	JMP   L278DH    ; Add new transient string to string stack
	
	
; ======================================================
; Memory copy using args following the CALL statement
; ======================================================
L2904H:	POP   H         ; POP return address from Stack
	XTHL            ; Swap RET address with top of Stack (Pointer to var)
	MOV   A,M       ; Get length of variable (2, 4, or 8)
	INX   H         ; Increment to variable address LSB
	MOV   C,M       ; Get LSB of variable address in C
	INX   H         ; Increment to variable address MSB
	MOV   B,M       ; Get MSB of variable address
	MOV   L,A       ; Move variable length to L
L290CH:	INR   L         ; Pre-increment L
L290DH:	DCR   L         ; Decrement loop counter
	RZ              ; Return if counter is zero
	
; ======================================================
; Move L bytes from (BC) to (DE)
; ======================================================
	LDAX  B         ; Load next byte from BC
	STAX  D         ; Store byte in DE
	INX   B         ; Increment Source ptr
	INX   D         ; Increment Dest ptr
	JMP   L290DH    ; Jump to test loop counter
	
L2916H:	CALL  L35D9H    ; Generate TM error if last variable type not string or RET
L2919H:	LHLD  FC1AH     ; Start of FAC1 for integers
L291CH:	XCHG            ; DE = Start of FAC1 for integers
L291DH:	CALL  L2935H    ; POP next string from string stack for computation into BC
	XCHG            ; HL = Start of FAC1 for integers
	RNZ             ; Return if string stack empty
	PUSH  D         ; Save address of "POPed" string to stack
	MOV   D,B       ; Load address of string to DE
	MOV   E,C       ; Load LSB too
	DCX   D         
	MOV   C,M       
	LHLD  FB8CH     ; Pointer to current location in BASIC string buffer
	RST   3         ; Compare DE and HL
	JNZ   L2933H    
	MOV   B,A       
	DAD   B         
	SHLD  FB8CH     ; Pointer to current location in BASIC string buffer
L2933H:	POP   H         
	RET             
	
L2935H:	LHLD  FB69H     ; Load current string stack address
	DCX   H         ; Pre-decrement to get MSB of string address
	MOV   B,M       ; Get MSB of top entry
	DCX   H         ; Decrement to LSB of string address
	MOV   C,M       ; Get LSB of top entry
	DCX   H         ; Decrement again to point to string length
	RST   3         ; Compare DE and HL
	RNZ             ; Don't save new stack location if HL == DE?
	SHLD  FB69H     ; Save new stack location
	RET             
	
	
; ======================================================
; LEN function
; ======================================================
	LXI   B,L10D1H  ; Address of Load integer in A into FAC1 routine
	PUSH  B         ; PUSH return address to load A to FAC1
L2947H:	CALL  L2916H    ; Get pointer to most recently used string (Len + address)
	XRA   A         ; Zero out A. Not sure why, we overwrite below
	MOV   D,A       ; Zero out D. Why?
	MOV   A,M       ; Get Length of string
	ORA   A         ; Test length for zero
	RET             
	
	
; ======================================================
; ASC function
; ======================================================
	LXI   B,L10D1H  ; Address of Load integer in A into FAC1 routine
	PUSH  B         ; PUSH return address to load A to FAC1
L2953H:	CALL  L2947H    ; Why not just call 2943? Get Length of most recently used String
	JZ    L08DBH    ; Generate FC error
	INX   H         ; Increment past string length to LSB of string
	MOV   E,M       ; Get LSB of string pointer
	INX   H         ; Increment to MSB
	MOV   D,M       ; Get MSB of string pointer
	LDAX  D         ; Get value of 1st character = ASC function
	RET             
	
	
; ======================================================
; CHR$ function
; ======================================================
	CALL  L275BH    ; Create a 1-byte transient string (for CHR$ & INKEY$)
	CALL  L1131H    ; Get expression integer < 256 in A or FC Error
L2965H:	LHLD  FB8AH     ; Address of transient string
	MOV   M,E       
L2969H:	POP   B         
	JMP   L278DH    ; Add new transient string to string stack
	
	
; ======================================================
; STRING$ function
; ======================================================
L296DH:	RST   2         ; Get next non-white char from M
	RST   1         ; Compare next byte with M
    DB	28H             ; Test for '('
	CALL  L112EH    ; Evaluate expression at M-1
	PUSH  D         
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	CALL  L0DABH    ; Main BASIC evaluation routine
	RST   1         ; Compare next byte with M
    DB	29H             ; Test for ')'
	XTHL            
	PUSH  H         
	RST   5         ; Determine type of last var used
	JZ    L2987H    
	CALL  L1131H    ; Get expression integer < 256 in A or FC Error
	JMP   L298AH    
	
L2987H:	CALL  L2953H    
L298AH:	POP   D         
	CALL  L2993H    
	
; ======================================================
; SPACE$ function
; ======================================================
L298EH:	CALL  L1131H    ; Get expression integer < 256 in A or FC Error
	MVI   A,20H     
L2993H:	PUSH  PSW       
	MOV   A,E       
	CALL  L275DH    ; Create a transient string of length A
	MOV   B,A       
	POP   PSW       
	INR   B         
	DCR   B         
	JZ    L2969H    
	LHLD  FB8AH     ; Address of transient string
L29A2H:	MOV   M,A       
	INX   H         
	DCR   B         
	JNZ   L29A2H    
	JMP   L2969H    
	
	
; ======================================================
; LEFT$ function
; ======================================================
	CALL  L2A2FH    
	XRA   A         
L29AFH:	XTHL            
	MOV   C,A       
	MVI   A,E5H     ; This is a Hidden (E5H) PUSH H at 29B2H
L29B3H:	PUSH  H         
	MOV   A,M       
	CMP   B         
	JC    L29BBH    
	MOV   A,B       
	LXI   D,L000EH  
	PUSH  B         
	CALL  L27C8H    ; Find space in BASIC String storage for A bytes
	POP   B         
	POP   H         
	PUSH  H         
	INX   H         
	MOV   B,M       
	INX   H         
	MOV   H,M       
	MOV   L,B       
	MVI   B,00H     
	DAD   B         
	MOV   B,H       
	MOV   C,L       
	CALL  L2760H    
	MOV   L,A       
	CALL  L290CH    
	POP   D         
	CALL  L291DH    
	JMP   L278DH    ; Add new transient string to string stack
	
	
; ======================================================
; RIGHT$ function
; ======================================================
	CALL  L2A2FH    
	POP   D         
	PUSH  D         
	LDAX  D         
	SUB   B         
	JMP   L29AFH    
	
	
; ======================================================
; MID$ function
; ======================================================
	XCHG            
	MOV   A,M       
	CALL  L2A32H    
	INR   B         
	DCR   B         
	JZ    L08DBH    ; Generate FC error
	PUSH  B         
	CALL  L2B3DH    
	POP   PSW       
	XTHL            
	LXI   B,L29B3H  
	PUSH  B         
	DCR   A         
	CMP   M         
	MVI   B,00H     
	RNC             
	MOV   C,A       
	MOV   A,M       
	SUB   C         
	CMP   E         
	MOV   B,A       
	RC              
	MOV   B,E       
	RET             
	
	
; ======================================================
; VAL function
; ======================================================
	CALL  L2947H    
	JZ    L10D1H    ; Load integer in A into FAC1
	MOV   E,A       
	INX   H         
	MOV   A,M       
	INX   H         
	MOV   H,M       
	MOV   L,A       
	PUSH  H         
	DAD   D         
	MOV   B,M       
	SHLD  F67EH     
	MOV   A,B       
	STA   FBE6H     
	MOV   M,D       
	XTHL            
	PUSH  B         
	DCX   H         
	RST   2         ; Get next non-white char from M
	CALL  L3840H    ; Convert ASCII number at M to double precision in FAC1
	LXI   H,0000H  
	SHLD  F67EH     
	POP   B         
	POP   H         
	MOV   M,B       
	RET             
	
L2A2FH:	XCHG            
	RST   1         ; Compare next byte with M
    DB	29H             ; compare with ')'
L2A32H:	POP   B         
	POP   D         
	PUSH  B         
	MOV   B,E       
	RET             
	
	
; ======================================================
; INSTR function
; ======================================================
L2A37H:	RST   2         ; Get next non-white char from M
	CALL  L0DA9H    
	RST   5         ; Determine type of last var used
	MVI   A,01H     
	PUSH  PSW       
	JZ    L2A53H    
	POP   PSW       
	CALL  L1131H    ; Get expression integer < 256 in A or FC Error
	ORA   A         
	JZ    L08DBH    ; Generate FC error
	PUSH  PSW       
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	CALL  L0DABH    ; Main BASIC evaluation routine
	CALL  L35D9H    
L2A53H:	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	PUSH  H         
	LHLD  FC1AH     ; Start of FAC1 for integers
	XTHL            
	CALL  L0DABH    ; Main BASIC evaluation routine
	RST   1         ; Compare next byte with M
    DB	29H             ; Test for ')'
	PUSH  H         
	CALL  L2916H    ; Get pointer to most recently used string (Len + address)
	XCHG            
	POP   B         
	POP   H         
	POP   PSW       
	PUSH  B         
	LXI   B,L383EH  
	PUSH  B         
	LXI   B,L10D1H  ; Load integer in A into FAC1
	PUSH  B         
	PUSH  PSW       
	PUSH  D         
	CALL  L291CH    
	POP   D         
	POP   PSW       
	MOV   B,A       
	DCR   A         
	MOV   C,A       
	CMP   M         
	MVI   A,00H     
	RNC             
	LDAX  D         
	ORA   A         
	MOV   A,B       
	RZ              
	MOV   A,M       
	INX   H         
	MOV   B,M       
	INX   H         
	MOV   H,M       
	MOV   L,B       
	MVI   B,00H     
	DAD   B         
	SUB   C         
	MOV   B,A       
	PUSH  B         
	PUSH  D         
	XTHL            
	MOV   C,M       
	INX   H         
	MOV   E,M       
	INX   H         
	MOV   D,M       
	POP   H         
L2A96H:	PUSH  H         
	PUSH  D         
	PUSH  B         
L2A99H:	LDAX  D         
	CMP   M         
	JNZ   L2AB7H    
	INX   D         
	DCR   C         
	JZ    L2AAEH    
	INX   H         
	DCR   B         
	JNZ   L2A99H    
	POP   D         
	POP   D         
	POP   B         
L2AABH:	POP   D         
	XRA   A         
	RET             
	
L2AAEH:	POP   H         
	POP   D         
	POP   D         
	POP   B         
	MOV   A,B       
	SUB   H         
	ADD   C         
	INR   A         
	RET             
	
L2AB7H:	POP   B         
	POP   D         
	POP   H         
	INX   H         
	DCR   B         
	JNZ   L2A96H    
	JMP   L2AABH    
	
L2AC2H:	RST   1         ; Compare next byte with M
    DB	28H             ; Test for '(' character
	CALL  L4790H    ; Find address of variable at M
	CALL  L35D9H    
	PUSH  H         
	PUSH  D         
	XCHG            
	INX   H         
	MOV   E,M       
	INX   H         
	MOV   D,M       
	LHLD  FBB6H     ; Unused memory pointer
	RST   3         ; Compare DE and HL
	JC    L2AE9H    
	LHLD  VBASPP    ; Start of BASIC program pointer
	RST   3         ; Compare DE and HL
	JNC   L2AE9H    
	POP   H         
	PUSH  H         
	CALL  L2747H    
	POP   H         
	PUSH  H         
	CALL  L3465H    
L2AE9H:	POP   H         
	XTHL            
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ',' character
	CALL  L112EH    ; Evaluate expression at M-1
	ORA   A         
	JZ    L08DBH    ; Generate FC error
	PUSH  PSW       
	MOV   A,M       
	CALL  L2B3DH    
	PUSH  D         
	CALL  L0DA4H    
	PUSH  H         
	CALL  L2916H    ; Get pointer to most recently used string (Len + address)
	XCHG            
	POP   H         
	POP   B         
	POP   PSW       
	MOV   B,A       
	XTHL            
	PUSH  H         
	LXI   H,L383EH  
	XTHL            
	MOV   A,C       
	ORA   A         
	RZ              
	MOV   A,M       
	SUB   B         
	JC    L08DBH    ; Generate FC error
	INR   A         
	CMP   C         
	JC    L2B1AH    
	MOV   A,C       
L2B1AH:	MOV   C,B       
	DCR   C         
	MVI   B,00H     
	PUSH  D         
	INX   H         
	MOV   E,M       
	INX   H         
	MOV   H,M       
	MOV   L,E       
	DAD   B         
	MOV   B,A       
	POP   D         
	XCHG            
	MOV   C,M       
	INX   H         
	MOV   A,M       
	INX   H         
	MOV   H,M       
	MOV   L,A       
	XCHG            
	MOV   A,C       
	ORA   A         
	RZ              
L2B32H:	LDAX  D         
	MOV   M,A       
	INX   D         
	INX   H         
	DCR   C         
	RZ              
	DCR   B         
	JNZ   L2B32H    
	RET             
	
L2B3DH:	MVI   E,FFH     
	CPI   29H       
	JZ    L2B49H    
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ',' character
	CALL  L112EH    ; Evaluate expression at M-1
L2B49H:	RST   1         ; Compare next byte with M
    DB	29H             ; Test for ')' character
	RET             
	
	
; ======================================================
; FRE function
; ======================================================
	LHLD  FBB6H     ; Unused memory pointer
	XCHG            ; Move unused memory location to DE
	LXI   H,0000H  ; Prepare to get current SP to calc free space
	DAD   SP        ; Get current SP
	RST   5         ; Determine type of last var used
	JNZ   L10BFH    ; If not string, Subtract HL - DE and unsigned convert to SNGL in FAC1
	CALL  L2919H    ; Get pointer to most recently used string
	CALL  L27F1H    
	XCHG            
	LHLD  VTPRAM    ; BASIC string buffer pointer
	XCHG            
	LHLD  FB8CH     ; Pointer to current location in BASIC string buffer
	JMP   L10BFH    ; Subtract HL - DE and unsigned convert to SNGL in FAC1
	
	
; ======================================================
; Double precision subtract (FAC1=FAC1-FAC2)
; ======================================================
L2B69H:	LXI   H,FC69H   ; Start of FAC2 for single and double precision
	MOV   A,M       
	ORA   A         
	RZ              
	XRI   80H       
	MOV   M,A       
	JMP   L2B7EH    
	
L2B75H:	CALL  L3461H    ; Move M to FAC2 using precision at (FB65H)
	
; ======================================================
; Double precision addition (FAC1=FAC1+FAC2)
; ======================================================
L2B78H:	LXI   H,FC69H   ; Start of FAC2 for single and double precision
	MOV   A,M       
	ORA   A         
	RZ              
L2B7EH:	ANI   7FH       
	MOV   B,A       
	LXI   D,FC18H   ; Start of FAC1 for single and double precision
	LDAX  D         
	ORA   A         
	JZ    L347BH    ; Copy FAC2 to FAC1
	ANI   7FH       
	SUB   B         
	JNC   L2BA2H    
	CMA             
	INR   A         
	PUSH  PSW       
	PUSH  H         
	MVI   B,08H     
L2B95H:	LDAX  D         
	MOV   C,M       
	MOV   M,A       
	MOV   A,C       
	STAX  D         
	INX   D         
	INX   H         
	DCR   B         
	JNZ   L2B95H    
	POP   H         
	POP   PSW       
L2BA2H:	CPI   10H       
	RNC             
	PUSH  PSW       
	XRA   A         
	STA   FC20H     ; Temp BCD value for computation?
	STA   FC71H     
	LXI   H,FC6AH   
	POP   PSW       
	CALL  L2CADH    
	LXI   H,FC69H   ; Start of FAC2 for single and double precision
	LDA   FC18H     ; Start of FAC1 for single and double precision
	XRA   M         
	JM    L2BDBH    
	LDA   FC71H     
	STA   FC20H     ; Temp BCD value for computation?
	CALL  L2C46H    ; Add FAC2 to FAC1
	JNC   L2C27H    
	XCHG            
	MOV   A,M       
	INR   M         
	XRA   M         
	JM    L0455H    ; Generate OV error
	CALL  L2CF2H    
	MOV   A,M       
	ORI   10H       
	MOV   M,A       
	JMP   L2C27H    
	
L2BDBH:	CALL  L2C5AH    
L2BDEH:	LXI   H,FC19H   ; Point to BCD portion of FAC1
	LXI   B,L0800H  ; Prepare to process 8 bytes, C = 0 = BCD Shift distance
L2BE4H:	MOV   A,M       ; Test next 2 digits from FAC1
	ORA   A         ; Test for digits "00"
	JNZ   L2BF3H    ; Jump if not "00"
	INX   H         ; Increment to next 2 digits in FAC1 - Skip this byte
	DCR   C         ; Decrement Digit counter
	DCR   C         ; Decrement Digit counter
	DCR   B         ; Decrement byte counter
	JNZ   L2BE4H    ; Keep looping until all bytes processed
	JMP   L33EDH    ; Initialize FAC1 for SGL & DBL precision to zero
	
L2BF3H:	ANI   F0H       ; Mask off the lower digit to see if BCD shift needed (4-bit shift)
	JNZ   L2BFEH    ; Jump ahead if not zero MSB of this byte isn't zero
	PUSH  H         ; Save pointer to current location in FAC1
	CALL  L2C94H    ; Rotate FAC1 1 BCD digit left to normalize starting at HL for B bytes
	POP   H         ; Restore current pointer into FAC1
	DCR   C         ; Decrement the digit counter
L2BFEH:	MVI   A,08H     ; Prepare to calculate number of bytes with "00" that were skipped
	SUB   B         ; Subtract 8 from the byte counter to test if first set of digits
	JZ    L2C17H    ; Skip copying bytes to FAC1 if no bytes to copy (already normalized)
	PUSH  PSW       ; Preserve count of bytes skipped on stack
	PUSH  B         ; Preserve BC on stack
	MOV   C,B       ; Move number of bytes to copy to C
	LXI   D,FC19H   ; Point to BCD portion of FAC1
	CALL  L2EDDH    ; Move C bytes from M to (DE) with increment - shift the bytes
	POP   B         ; Restore byte counter from stack
	POP   PSW       ; Restore A from stack
	MOV   B,A       ; Move count of bytes skipped to B to use as a count to zero out the end
	XRA   A         ; Prepare to zero out B bytes from end of FAC1 that were shifted left
L2C11H:	STAX  D         ; Zero out next LSB from BCD
	INX   D         ; Increment to next lower BCD value in FAC1
	DCR   B         ; Decrement the counter
	JNZ   L2C11H    ; Loop until all bytes zeroed
L2C17H:	MOV   A,C       ; Get digit count from normalize
	ORA   A         ; Test if no bytes copied from normalize (don't need to adjust decimal point)
	JZ    L2C27H    ; Jump to round if BCD value was not shifted / normalized
	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	MOV   B,M       ; Get current sign / decimal point location
L2C20H:	ADD   M         ; Add number of BCD digits shifted to calculate new decimal location
	MOV   M,A       ; Save new decimal point location
	XRA   B         ; Test for overflow in shift (too small)
	JM    L0455H    ; Generate OV error
	RZ              ; Return if FAC1 is zero -- no need to round
L2C27H:	LXI   H,FC20H   ; Point to end of FAC1+1 = "Fraction portion" for accuracy
	MVI   B,07H     ; Prepare to perform rounding operation on 7 byte of BCD
L2C2CH:	MOV   A,M       ; Get "fraction portion" of FAC1
	CPI   50H       ; Test for value 0.50 decimal (this is BCD)
	RC              ; Return if less than 0.50 - no rounding needed
	DCX   H         ; Decrement to next higher BCD pair
	XRA   A         ; Clear A to perform ADD of 1 to FAC1 (to perform round up)
	STC             ; Set the C flag (this is our "1")
L2C33H:	ADC   M         ; Add Zero with carry to the next BCD pair
	DAA             ; Decimal adjust for BCD calculations
	MOV   M,A       ; Save this byte of BCD data
	RNC             ; Return if no more carry to additional bytes
	DCX   H         ; Decrement to next higher BCD pair
	DCR   B         ; Decrement byte count
	JNZ   L2C33H    ; Loop until all bytes rounded (or no carry)
	MOV   A,M       ; We rounded to the last byte and had Carry. Must shift decimal point.
	INR   M         ; Increment the decimal point position to account for carry
	XRA   M         ; Test for overflow during rounding
	JM    L0455H    ; Generate OV error
	INX   H         ; Increment to 1st BCD pair to change from .99 to 1.00
	MVI   M,10H     ; Change value to 1.0 since our "carry" was really a decimal point shift
	RET             
	
L2C46H:	LXI   H,FC70H   ; Point to end of FAC2
	LXI   D,FC1FH   ; Point to end of FAC1
	MVI   B,07H     ; Prepare to add 7 bytes of BCD (14 digits)
L2C4EH:	XRA   A         ; Clear C flag for 1st ADD
	
; ======================================================
; Add the BCD num in M to the one in (DE)
; ======================================================
L2C4FH:	LDAX  D         ; Load first byte into A
	ADC   M         ; ADD with carry the next byte from M
	DAA             ; Decimal Adjust for BCD add
	STAX  D         ; Store sum at (DE)
	DCX   D         ; Decrement to next higher position of DE
	DCX   H         ; Decrement to next higher position of HL
	DCR   B         ; Decrement byte counter
	JNZ   L2C4FH    ; Add the BCD num in M to the one in (DE)
	RET             
	
L2C5AH:	LXI   H,FC71H   ; Point to extended precision portion of FAC2
	MOV   A,M       ; Get extended precision portion to test for rounding
	CPI   50H       ; Compare with 50 BCD (represent 0.50)
	JNZ   L2C64H    ; Jump if extended precision portion of FAC2 != 0.50
	INR   M         ; Increment extended precision portion of FAC2
L2C64H:	LXI   D,FC20H   ; Point to extended precision portion of FAC1
	MVI   B,08H     ; Prepare to subtract FAC2 from 0.999999999999 maybe?
	STC             ; Set carry to initiate no-borrow
L2C6AH:	MVI   A,99H     ; Load 0.99 BCD into A
	ACI   00H       ; Add 00 BCD to set AC flag2
	SUB   M         ; Subtract extended precision portion of FAC2 from 0.99 BCD
	MOV   C,A       ; Save difference in C
	LDAX  D         ; Load next byte from FAC1
	ADD   C         ; Add difference of 0.99-FAC2
	DAA             ; Decimal adjust for BCD value
	STAX  D         ; Store in FAC1 (FAC1 = FAC1 + (0.999999999 - FAC2))
	DCX   D         ; Decrement to next higher BCD pair for FAC1
	DCX   H         ; Decrement to next higher BCD pair for FAC2
	DCR   B         ; Decrement byte count
	JNZ   L2C6AH    ; Keep looping until count = 0
	RC              ; Return if no borrow
	XCHG            
	MOV   A,M       
	XRI   80H       
	MOV   M,A       
	LXI   H,FC20H   ; Point to extended precision portion of FAC1
	MVI   B,08H     
	XRA   A         
L2C86H:	MVI   A,9AH     
	SBB   M         
	ACI   00H       
	DAA             
	CMC             
	MOV   M,A       
	DCX   H         
	DCR   B         
	JNZ   L2C86H    
	RET             
	
L2C94H:	LXI   H,FC20H   ; Point to end of FAC1 (+1 to rotate in a "0")
L2C97H:	PUSH  B         ; Preserve byte & digit count on stack
	MOV   D,B       ; Move byte count to D
	MVI   C,04H     ; Prepare to rotate the remaining bytes 4 bits to populate MSB of 1st byte
L2C9BH:	PUSH  H         ; Preserve the pointer to end of FAC1 for next shift loop
	ORA   A         ; Clear the C flag so we rotate 0 in
L2C9DH:	MOV   A,M       ; Get the next highest byte from FAC1
	RAL             ; Rotate the C bit (bit 8 from previous byte) into this byte & shift
	MOV   M,A       ; Save the shifted byte back to FAC1
	DCX   H         ; Decrement to next higher BCD value pair
	DCR   B         ; Decrement the byte count
	JNZ   L2C9DH    ; Keep looping until B bytes shifted
	MOV   B,D       ; Restore B for next pass (we rotate through B bytes 4 times)
	POP   H         ; Restore the pointer to the end of FAC1 for next shift loop
	DCR   C         ; Decrement the bit shift count
	JNZ   L2C9BH    ; Keep looping until we have shifted 4 times (1 BCD digit)
	POP   B         ; Restore byte & digit counts from stack
	RET             
	
L2CADH:	ORA   A         
	RAR             
	PUSH  PSW       
	ORA   A         
	JZ    L2CFAH    
	PUSH  PSW       
	CMA             
	INR   A         
	MOV   C,A       
	MVI   B,FFH     
	LXI   D,L0007H  
	DAD   D         
	MOV   D,H       
	MOV   E,L       
	DAD   B         
	MVI   A,08H     
	ADD   C         
	MOV   C,A       
	PUSH  B         
	CALL  L2EE6H    ; Move C bytes from M to (DE)
	POP   B         
	POP   PSW       
	INX   H         
	INX   D         
	PUSH  D         
	MOV   B,A       
	XRA   A         
L2CD0H:	MOV   M,A       
	INX   H         
	DCR   B         
	JNZ   L2CD0H    
	POP   H         
	POP   PSW       
	RNC             
	MOV   A,C       
L2CDAH:	PUSH  B         
	PUSH  D         
	MOV   D,A       
	MVI   C,04H     
L2CDFH:	MOV   B,D       
	PUSH  H         
	ORA   A         
L2CE2H:	MOV   A,M       
	RAR             
	MOV   M,A       
	INX   H         
	DCR   B         
	JNZ   L2CE2H    
	POP   H         
	DCR   C         
	JNZ   L2CDFH    
	POP   D         
	POP   B         
	RET             
	
L2CF2H:	LXI   H,FC19H   ; Point to BCD portion of FAC1
L2CF5H:	MVI   A,08H     
	JMP   L2CDAH    
	
L2CFAH:	POP   PSW       
	RNC             
	JMP   L2CF5H    
	
	
; ======================================================
; Double precision multiply (FAC1=FAC1*FAC2)
; ======================================================
L2CFFH:	RST   6         ; Get sign of FAC1
	RZ              ; Return if FAC1 is zero - product is zero also
	LDA   FC69H     ; Start of FAC2 for single and double precision
	ORA   A         ; Test if FAC2 is zero
	JZ    L33EDH    ; Set FAC1 to zero - Initialize FAC1 for SGL & DBL precision to zero
	MOV   B,A       ; Save Sign and Decimal point for FAC2
	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	XRA   M         ; Test if Sign of FAC1 and FAC2 are different
	ANI   80H       ; Keep only the sign bit
	MOV   C,A       ; Save the resulting sign of the product in C
	MOV   A,B       ; Restore the sign and decimal point of FAC2
	ANI   7FH       ; Mask the sign bit out
	MOV   B,A       ; Save the decimal point info in B
	MOV   A,M       ; Get the sign and decimal point for FAC1
	ANI   7FH       ; Mask off the sign bit
	ADD   B         ; Add the decimal point for FAC1 and FAC2 for multiply
	MOV   B,A       ; Save the sum in B
	MVI   M,00H     ; Initialize FAC1 decimal point to zero
	ANI   C0H       ; Mask off lower 6 bits of the sum of decimal points
	RZ              ; Return if it's zero. Not sure why - we didn't actually multiply anything yet
	CPI   C0H       ; Test if upper 2 bits of sum of decimal points are both 1
	JNZ   L2D26H    ; Jump if not C0H
	JMP   L0455H    ; Generate OV error
	
L2D26H:	MOV   A,B       ; Reload the sum of the decimal points
	ADI   40H       ; Add 40H to it (the "zero" point)
	ANI   7FH       ; Mask off the upper bit (where sign bit goes)
	RZ              ; Return if the product generates zero
	ORA   C         ; OR in the sign of the product
	DCX   H         ; Decrement HL to save decimal point & sign temporarily
	MOV   M,A       ; Save decimal & sign
	LXI   D,FC67H   ; Temp BCD value for computation (BCD_TEMP8)
	LXI   B,L0008H  ; Prepare to copy 8 bytes of BCD
	LXI   H,FC1FH   ; Point to end of FAC1
	PUSH  D         ; Preserve address of temp float to stack
	CALL  L2EE6H    ; Move C bytes from M to (DE)
	INX   H         ; Increment to beginning of FAC1
	XRA   A         ; Clear A
	MVI   B,08H     ; Prepare to clear 8 bytes of FAC1
L2D40H:	MOV   M,A       ; Zero out next byte of FAC1
	INX   H         ; Increment to next byte of FAC1
	DCR   B         ; Decrement loop counter
	JNZ   L2D40H    ; Keep looping until count = 0
	POP   D         ; Restore address of BCD_TEMP8
	LXI   B,L2DA8H  ; Load address of routine to retrieve saved Decimal/sign byte and normalize FAC1
	PUSH  B         ; PUSH new RETurn address to stack
L2D4BH:	CALL  L2DAFH    ; Multiply BCD at (DE) x2, x4 and x8 into BCD_TEMP7, BCD_TEMP6, BCD_TEMP5
	PUSH  H         ; Push address of BCD_TEMP4 to stack
	LXI   B,L0008H  ; Prepare to copy 8 BCD bytes
	XCHG            ; HL=BCD_TEMP5 (x8), DE=BCD_TEMP4
	CALL  L2EE6H    ; Move C bytes from M to (DE)
	XCHG            ; HL=BCD_TEMP3, DE=BCD_TEMP4 (x8)
	LXI   H,FC5FH   ; Point to BCD_TEMP7 (x2)
	MVI   B,08H     ; Prepare to add 8 bytes of BCD (Add BCD_TEMP3 to BCD_TEMP7)
	CALL  L2C4EH    ; Add BCD value at (HL) to the one at (DE) -- BCD_TEMP4 = x8 + x2 = x10
	POP   D         ; POP address of BCD_TEMP4 from stack
	CALL  L2DAFH    ; Multiply BCD_TEMP4 (x10) times 2, 4 and 8 into BCD_TEMP3, BCD_TEMP2, BCD_TEMP1
	MVI   C,07H     ; Prepare to multiply 7 bytes of BCD from FAC2?
	LXI   D,FC70H   ; Point to end of FAC2
L2D68H:	LDAX  D         ; Load next BCD pair from FAC2
	ORA   A         ; Test if byte pair is "00"
	JNZ   L2D72H    ; Jump to start multiply when first non "00" BCD found
	DCX   D         ; Decrement to next higher BCD pair
	DCR   C         ; Decrement byte counter (no need to test for zero - we won't be here if FAC2=0.0000)
	JMP   L2D68H    ; Jump to test next byte of FAC2
	
L2D72H:	LDAX  D         ; Load next byte of BCD from FAC2
	DCX   D         ; Decrement to next higher BCD pair in FAC2
	PUSH  D         ; Save address of BCD pair being processed in FAC2 to stack
	LXI   H,FC2FH   ; Point to BCD_TEMP1 (this is FAC1 x 80)
L2D78H:	ADD   A         ; Multiply BCD from FAC2 x 2
	JC    L2D86H    ; Add BCD value at (HL) to FAC1
	JZ    L2D95H    ; If zero (overflow to 100H), then jump to divide by 100
L2D7FH:	LXI   D,L0008H  ; Prepare to point to next BCD_TEMPx value
	DAD   D         ; Advance HL to next BCD_TEMPx value
	JMP   L2D78H    ; Jump to test if this BCD_TEMPx value should be added to FAC1
	
L2D86H:	PUSH  PSW       ; Save A on stack
	MVI   B,08H     ; Load BCD byte count
	LXI   D,FC1FH   ; Point to end of FAC1
	PUSH  H         ; Preserve HL on stack
	CALL  L2C4EH    ; Add BCD value at (HL) to the one at FAC1
	POP   H         ; Restore HL
	POP   PSW       ; Restore A
	JMP   L2D7FH    ; Jump to test if next BCD_TEMPx value should be added to FAC1
	
L2D95H:	MVI   B,0FH     ; Prepare to shift 15 bytes (extended precision) of FAC1
	LXI   D,FC26H   ; Start 1 byte from end of FAC1 (extended precision)
	LXI   H,FC27H   ; Move to last byte of FAC1 (this is /100 because of BCD)
	CALL  L3472H    ; Move B bytes from (DE) to M with decrement
	MVI   M,00H     ; Set the 1st byte (sign / decimal point) to zero
	POP   D         ; Restore pointer to current BCD pair in FAC2
	DCR   C         ; Decrement BCD count for FAC2
	JNZ   L2D72H    ; Jump to process next byte
	RET             ; Return to our hook (below) to retrieve the Decimal/sign & normalize
	
L2DA8H:	DCX   H         ; Decrement from start of FAC1 to save byte for sign/decimal point
	MOV   A,M       ; Get saved sign/decimal point
	INX   H         ; Increment back to start of FAC1
	MOV   M,A       ; Copy saved sign/decimal point to FAC1
	JMP   L2BDEH    ; Normalize FAC1 such that the 1st BCD digit isn't zero
	
L2DAFH:	LXI   H,FFF8H   ; Load -8 into HL
	DAD   D         ; HL=DE-8 -- Point to next lower temp BCD value
	MVI   C,03H     ; Prepare to process 3 floating point values
L2DB5H:	MVI   B,08H     ; Load byte counter for 1 floating point value
	ORA   A         ; Clear C flag
L2DB8H:	LDAX  D         ; Load next byte of floating point value
	ADC   A         ; Add with carry (x2)
	DAA             ; Decimal adjust for BCD math
	MOV   M,A       ; Save byte x 2 to next lower temp floating point value
	DCX   H         ; Decrement pointer to temp floating point 1
	DCX   D         ; Decrement pointer to temp floating point 2
	DCR   B         ; Decrement byte counter
	JNZ   L2DB8H    ; Keep looping until byte counter = 0
	DCR   C         ; Decrement x2 loop counter
	JNZ   L2DB5H    ; Keep looping until count=0 (x2, x4, x8)
	RET             
	
	
; ======================================================
; Double precision divide (FAC1=FAC1/FAC2)
; ======================================================
L2DC7H:	LDA   FC69H     ; Start of FAC2 for single and double precision
	ORA   A         
	JZ    L0449H    ; Generate /0 error
	MOV   B,A       
	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	MOV   A,M       
	ORA   A         
	JZ    L33EDH    ; Initialize FAC1 for SGL & DBL precision to zero
	XRA   B         
	ANI   80H       
	MOV   C,A       
	MOV   A,B       
	ANI   7FH       
	MOV   B,A       
	MOV   A,M       
	ANI   7FH       
	SUB   B         
	MOV   B,A       
	RAR             
	XRA   B         
	ANI   40H       
	MVI   M,00H     
	JZ    L2DF4H    
	MOV   A,B       
	ANI   80H       
	RNZ             
L2DF1H:	JMP   L0455H    ; Generate OV error
	
L2DF4H:	MOV   A,B       
	ADI   41H       
	ANI   7FH       
	MOV   M,A       
	JZ    L2DF1H    
	ORA   C         
	MVI   M,00H     
	DCX   H         
	MOV   M,A       
	LXI   D,FC1FH   ; Point to end of FAC1
	LXI   H,FC70H   ; Point to end of FAC2
	MVI   B,07H     
L2E0AH:	MOV   A,M       
	ORA   A         
	JNZ   L2E15H    
	DCX   D         
	DCX   H         
	DCR   B         
	JNZ   L2E0AH    
L2E15H:	SHLD  FC14H     
	XCHG            
	SHLD  FC12H     
	MOV   A,B       
	STA   FC16H     
	LXI   H,FC60H   ; Floating Point Temp 2
L2E23H:	MVI   B,0FH     
L2E25H:	PUSH  H         
	PUSH  B         
	LHLD  FC14H     
	XCHG            
	LHLD  FC12H     
	LDA   FC16H     
	MVI   C,FFH     
L2E33H:	STC             
	INR   C         
	MOV   B,A       
	PUSH  H         
	PUSH  D         
L2E38H:	MVI   A,99H     
	ACI   00H       
	XCHG            
	SUB   M         
	XCHG            
	ADD   M         
	DAA             
	MOV   M,A       
	DCX   H         
	DCX   D         
	DCR   B         
	JNZ   L2E38H    
	MOV   A,M       
	CMC             
	SBI   00H       
	MOV   M,A       
	POP   D         
	POP   H         
	LDA   FC16H     
	JNC   L2E33H    
	MOV   B,A       
	XCHG            
	CALL  L2C4EH    ; Add BCD value at (HL) to the one at FAC1
	JNC   L2E5FH    
	XCHG            
	INR   M         
L2E5FH:	MOV   A,C       
	POP   B         
	MOV   C,A       
	PUSH  B         
	MOV   A,B       
	ORA   A         
	RAR             
	MOV   B,A       
	INR   B         
	MOV   E,B       
	MVI   D,00H     
	LXI   H,FC17H   
	DAD   D         
	CALL  L2C97H    
	POP   B         
	POP   H         
	MOV   A,B       
	INR   C         
	DCR   C         
	JNZ   L2EBBH    
	CPI   0FH       
	JZ    L2EACH    
	RRC             
	RLC             
	JNC   L2EBBH    
	PUSH  B         
	PUSH  H         
	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	MVI   B,08H     
L2E8BH:	MOV   A,M       
	ORA   A         
	JNZ   L2EA6H    
	INX   H         
	DCR   B         
	JNZ   L2E8BH    
	POP   H         
	POP   B         
	MOV   A,B       
	ORA   A         
	RAR             
	INR   A         
	MOV   B,A       
	XRA   A         
L2E9DH:	MOV   M,A       
	INX   H         
	DCR   B         
	JNZ   L2E9DH    
	JMP   L2ECFH    
	
L2EA6H:	POP   H         
	POP   B         
	MOV   A,B       
	JMP   L2EBBH    
	
L2EACH:	LDA   FC17H     
	MOV   E,A       
	DCR   A         
	STA   FC17H     
	XRA   E         
	JP    L2E23H    
	JMP   L33EDH    ; Initialize FAC1 for SGL & DBL precision to zero
	
L2EBBH:	RAR             
	MOV   A,C       
	JC    L2EC6H    
	ORA   M         
	MOV   M,A       
	INX   H         
	JMP   L2ECBH    
	
L2EC6H:	ADD   A         
	ADD   A         
	ADD   A         
	ADD   A         
	MOV   M,A       
L2ECBH:	DCR   B         
	JNZ   L2E25H    
L2ECFH:	LXI   H,FC20H   ; Point to extended precision portion of FAC1
	LXI   D,FC67H   ; Temp BCD value for computation?
	MVI   B,08H     ; Prepare to copy BCD value
	CALL  L3472H    ; Move B bytes from (DE) to M with decrement
	JMP   L2DA8H    
	
L2EDDH:	MOV   A,M       ; Get next byte from M
	STAX  D         ; Save at (DE)
	INX   H         ; Increment source pointer
	INX   D         ; Increment destination pointer
	DCR   C         ; Decrement loop counter
	JNZ   L2EDDH    ; Keep looping until C = 0
	RET             
	
	
; ======================================================
; Move C bytes from M to (DE)
; ======================================================
L2EE6H:	MOV   A,M       ; Get next byte from M
	STAX  D         ; Store at (DE)
	DCX   H         ; Decrement source pointer
	DCX   D         ; Decrement dest pointer
	DCR   C         ; Decrement loop counter
	JNZ   L2EE6H    ; Move C bytes from M to (DE)
	RET             
	
	
; ======================================================
; COS function
; ======================================================
L2EEFH:	LXI   H,L32CEH  ; Load pointer to FP 0.15915494309190
	CALL  L31A3H    ; Double precision math (FAC1=M * FAC2))
	LDA   FC18H     ; Start of FAC1 for single and double precision
	ANI   7FH       ; ABS(FAC1)
	STA   FC18H     ; Start of FAC1 for single and double precision
	LXI   H,L328EH  ; Load pointer to FP 0.2500000000000
	CALL  L319AH    ; Double precision subtract FP at (HL) from FAC1
	CALL  L33FDH    ; Perform ABS function on FAC1
	JMP   L2F0FH    
	
	
; ======================================================
; SIN function
; ======================================================
L2F09H:	LXI   H,L32CEH  ; Load pointer to FP 0.15915494309190
	CALL  L31A3H    ; Double precision math (FAC1=M * FAC2))
L2F0FH:	LDA   FC18H     ; Start of FAC1 for single and double precision
	ORA   A         ; Test if FAC1 negative
	CM    L31E3H    ; If negative, Take ABS(FAC1) and push return address to ABS(FAC1)
	CALL  L3234H    ; Push FAC1 on stack
	CALL  L3654H    ; INT function
	CALL  L31B5H    ; Move FAC1 to FAC2
	CALL  L324BH    ; Pop FAC1 from stack
	CALL  L2B69H    ; Double precision subtract (FAC1=FAC1-FAC2)
	LDA   FC18H     ; Start of FAC1 for single and double precision
	CPI   40H       
	JC    L2F52H    
	LDA   FC19H     ; Get 1st byte of BCD portion of FAC1
	CPI   25H       ; Test for 0.25
	JC    L2F52H    
	CPI   75H       ; Test for 0.75
	JNC   L2F49H    ; Subtract 1.00 from FAC1 and do table based math
	CALL  L31B5H    ; Move FAC1 to FAC2
	LXI   H,L327CH  ; Load pointer to FP 0.500000000
	CALL  L31C4H    ; Move floating point number M to FAC1
	CALL  L2B69H    ; Double precision subtract (FAC1=FAC1-FAC2)
	JMP   L2F52H    ; Jump to perform table based math for SIN function
	
L2F49H:	LXI   H,L3286H  ; Load pointer to FP 1.000000000
	CALL  L31B8H    ; Move floating point number M to FAC2
	CALL  L2B69H    ; Double precision subtract (FAC1=FAC1-FAC2)
L2F52H:	LXI   H,L335AH  ; Table of FP numbers for SIN function
	JMP   L31F7H    ; FAC1 = FAC1 * (FAC1^2 * table based math)
	
	
; ======================================================
; TAN function
; ======================================================
	CALL  L3234H    ; Push FAC1 on stack
	CALL  L2EEFH    ; COS function
	CALL  L31D2H    ; Swap FAC1 with Floating Point number on stack
	CALL  L2F09H    ; SIN function
	CALL  L3245H    ; Pop FAC2 from stack
	LDA   FC69H     ; Start of FAC2 for single and double precision
	ORA   A         ; Test if FAC2 is zero
	JNZ   L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	JMP   L0455H    ; Generate OV error
	
	
; ======================================================
; ATN function
; ======================================================
	LDA   FC18H     ; Start of FAC1 for single and double precision
	ORA   A         ; Test if FAC1 is zero
	RZ              ; Return if FAC1 is zero - answer also zero
	CM    L31E3H    ; If negative, take ABS(FAC1) and push return address to ABS(FAC1)
	CPI   41H       ; Test if FAC1 > 1.0
	JC    L2F99H    ; Perform series approximation for ATN
	CALL  L31B5H    ; Move FAC1 to FAC2
	LXI   H,L3286H  ; Load pointer to FP 1.000000000
	CALL  L31C4H    ; Move floating point number M to FAC1
	CALL  L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	CALL  L2F99H    ; Perform series approximation for ATN
	CALL  L31B5H    ; Move FAC1 to FAC2
	LXI   H,L32AEH  ; Load pointer to FP 1.5707963267949
	CALL  L31C4H    ; Move floating point number M to FAC1
	JMP   L2B69H    ; Double precision subtract (FAC1=FAC1-FAC2)
	
L2F99H:	LXI   H,L32B6H  ; Load pointer to FP 0.26794919243112
	CALL  L31AFH    ; Double precision compare FAC1 with floating point at HL
	JM    L2FC9H    ; Do table based math for ATN
	CALL  L3234H    ; Push FAC1 on stack
	LXI   H,L32BEH  ; Load pointer to FP 1.7320508075689
	CALL  L3194H    ; Double precision add FP at (HL) to FAC1
	CALL  L31D2H    ; Swap FAC1 with Floating Point number on stack
	LXI   H,L32BEH  ; Load pointer to FP 1.7320508075689
	CALL  L31A3H    ; Double precision math (FAC1=M * FAC2))
	LXI   H,L3286H  ; Load pointer to FP 1.000000000
	CALL  L319AH    ; Double precision subtract FP at (HL) from FAC1
	CALL  L3245H    ; Pop FAC2 from stack
	CALL  L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	CALL  L2FC9H    ; Do Table based math for ATN
	LXI   H,L32C6H  ; Load pointer to FP 0.52359877559830
	JMP   L3194H    ; Double precision add FP at (HL) to FAC1
	
L2FC9H:	LXI   H,L339BH  ; Load pointer to FP table for ATN
	JMP   L31F7H    ; FAC1 = FAC1 * (FAC1^2 * table based math)
	
	
; ======================================================
; LOG function
; ======================================================
L2FCFH:	RST   6         ; Get sign of FAC1
	JM    L08DBH    ; Generate FC error
	JZ    L08DBH    ; Generate FC error
	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	MOV   A,M       
	PUSH  PSW       
	MVI   M,41H     
	LXI   H,L3296H  ; Load pointer to FP 3.1622776601684
	CALL  L31AFH    ; Double precision compare FAC1 with floating point at HL
	JM    L2FEDH    
	POP   PSW       
	INR   A         
	PUSH  PSW       
	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	DCR   M         
L2FEDH:	POP   PSW       
	STA   FB8EH     
	CALL  L3234H    ; Push FAC1 on stack
	LXI   H,L3286H  ; Load pointer to FP 1.000000000
	CALL  L3194H    ; Double precision add FP at (HL) to FAC1
	CALL  L31D2H    ; Swap FAC1 with Floating Point number on stack
	LXI   H,L3286H  ; Load pointer to FP 1.000000000
	CALL  L319AH    ; Double precision subtract FP at (HL) from FAC1
	CALL  L3245H    ; Pop FAC2 from stack
	CALL  L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	CALL  L3234H    ; Push FAC1 on stack
	CALL  L31A0H    ; Double precision Square (FAC1=SQR(FAC1))
	CALL  L3234H    ; Push FAC1 on stack
	CALL  L3234H    ; Push FAC1 on stack
	LXI   H,L3331H  ; Point to 1st table of FP numbers for LOG
	CALL  L3209H    ; Table based math (FAC1=(((FAC1*M)+(M+1))*(M+2)+(M+3)...
	CALL  L31D2H    ; Swap FAC1 with Floating Point number on stack
	LXI   H,L3310H  ; Point to 2nd table of FP numbers for LOG
	CALL  L3209H    ; Table based math (FAC1=(((FAC1*M)+(M+1))*(M+2)+(M+3)...
	CALL  L3245H    ; Pop FAC2 from stack
	CALL  L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	CALL  L3245H    ; Pop FAC2 from stack
	CALL  L2CFFH    ; Double precision multiply (FAC1=FAC1*FAC2)
	LXI   H,L329EH  ; Load pointer to FP 0.86858896380650
	CALL  L3194H    ; Double precision add FP at (HL) to FAC1
	CALL  L3245H    ; Pop FAC2 from stack
	CALL  L2CFFH    ; Double precision multiply (FAC1=FAC1*FAC2)
	CALL  L3234H    ; Push FAC1 on stack
	LDA   FB8EH     
	SUI   41H       
	MOV   L,A       
	ADD   A         
	SBB   A         
	MOV   H,A       
	CALL  L3543H    ; Convert signed integer HL to single precision FAC1
	CALL  L35C2H    ; Convert FAC11 to double precision
	CALL  L3245H    ; Pop FAC2 from stack
	CALL  L2B78H    ; Double precision addition (FAC1=FAC1+FAC2)
	LXI   H,L32A6H  ; Load pointer to FP 2.3025850929940
	JMP   L31A3H    ; Double precision math (FAC1=M * FAC2))
	
	
; ======================================================
; SQR function
; ======================================================
	RST   6         ; Get sign of FAC1
	RZ              
	JM    L08DBH    ; Generate FC error
	CALL  L31B5H    ; Move FAC1 to FAC2
	LDA   FC18H     ; Start of FAC1 for single and double precision
	ORA   A         
	RAR             
	ACI   20H       
	STA   FC69H     ; Start of FAC2 for single and double precision
	LDA   FC19H     ; Get 1st byte of BCD portion of FAC1
	ORA   A         
	RRC             
	ORA   A         
	RRC             
	ANI   33H       
	ADI   10H       
	STA   FC6AH     
	MVI   A,07H     
L307CH:	STA   FB8EH     
	CALL  L3234H    ; Push FAC1 on stack
	CALL  L322EH    ; Push FAC2 on stack
	CALL  L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	CALL  L3245H    ; Pop FAC2 from stack
	CALL  L2B78H    ; Double precision addition (FAC1=FAC1+FAC2)
	LXI   H,L327CH  ; Load pointer to FP 0.500000000
	CALL  L31A3H    ; Double precision math (FAC1=M * FAC2))
	CALL  L31B5H    ; Move FAC1 to FAC2
	CALL  L324BH    ; Pop FAC1 from stack
	LDA   FB8EH     
	DCR   A         
	JNZ   L307CH    
	JMP   L31C1H    ; Move FAC2 to FAC1
	
	
; ======================================================
; EXP function
; ======================================================
L30A4H:	LXI   H,L3274H  
	CALL  L31A3H    ; Double precision math (FAC1=M * FAC2))
	CALL  L3234H    ; Push FAC1 on stack
	CALL  L3501H    ; CINT function
	MOV   A,L       
	RAL             
	SBB   A         
	CMP   H         
	JZ    L30CBH    
	MOV   A,H       
	ORA   A         
	JP    L30C8H    
	CALL  L35CFH    ; Set type of last variable to DBL
	CALL  L324BH    ; Pop FAC1 from stack
	LXI   H,L327EH  
	JMP   L31C4H    ; Move floating point number M to FAC1
	
L30C8H:	JMP   L0455H    ; Generate OV error
	
L30CBH:	SHLD  FB8EH     
	CALL  L35BAH    ; CDBL function
	CALL  L31B5H    ; Move FAC1 to FAC2
	CALL  L324BH    ; Pop FAC1 from stack
	CALL  L2B69H    ; Double precision subtract (FAC1=FAC1-FAC2)
	LXI   H,L327CH  ; Load pointer to FP 0.500000000
	CALL  L31AFH    ; Double precision compare FAC1 with floating point at HL
	PUSH  PSW       
	JZ    L30EDH    
	JC    L30EDH    
	LXI   H,L327CH  ; Load pointer to FP 0.500000000
	CALL  L319AH    ; Double precision subtract FP at (HL) from FAC1
L30EDH:	CALL  L3234H    ; Push FAC1 on stack
	LXI   H,L32F7H  ; Load pointer to FP table for EXP function
	CALL  L31F7H    ; FAC1 = FAC1 * (FAC1^2 * table based math)
	CALL  L31D2H    ; Swap FAC1 with Floating Point number on stack
	LXI   H,L32D6H  
	CALL  L31EBH    ; Square FAC1 & do table based math
	CALL  L3245H    ; Pop FAC2 from stack
	CALL  L322EH    ; Push FAC2 on stack
	CALL  L3234H    ; Push FAC1 on stack
	CALL  L2B69H    ; Double precision subtract (FAC1=FAC1-FAC2)
	LXI   H,FC60H   ; Floating Point Temp 2
	CALL  L31CAH    ; Move FAC1 to M
	CALL  L3245H    ; Pop FAC2 from stack
	CALL  L324BH    ; Pop FAC1 from stack
	CALL  L2B78H    ; Double precision addition (FAC1=FAC1+FAC2)
	LXI   H,FC60H   ; Floating Point Temp 2
	CALL  L31B8H    ; Move floating point number M to FAC2
	CALL  L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	POP   PSW       
	JC    L3130H    
	JZ    L3130H    
	LXI   H,L3296H  ; Load pointer to FP 3.1622776601684
	CALL  L31A3H    ; Double precision math (FAC1=M * FAC2))
L3130H:	LDA   FB8EH     
	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	MOV   C,M       
	ADD   M         
	MOV   M,A       
	XRA   C         
	RP              
	JMP   L0455H    ; Generate OV error
	
	
; ======================================================
; RND function
; ======================================================
L313EH:	RST   6         ; Get sign of FAC1
	LXI   H,FC79H   ; Floating Point Temp 3
	JZ    L3173H    ; If argument to RND is zero, then return last value
	CM    L31CAH    ; Move FAC1 to M
	LXI   H,FC60H   ; Floating Point Temp 2
	LXI   D,FC79H   ; Floating Point Temp 3
	CALL  L31CDH    ; Move Floating point at (DE) to M
	LXI   H,L3264H  ; Load pointer to FP 2.1132486540519e-65
	CALL  L31B8H    ; Move floating point number M to FAC2
	LXI   H,L325CH  ; Load pointer to FP 1.4389820420821e-65
	CALL  L31C4H    ; Move floating point number M to FAC1
	LXI   D,FC67H   ; Load pointer to BCD_TEMP8
	CALL  L2D4BH    ; Multiply BCD at (DE) times FAC2
	LXI   D,FC20H   ; Load pointer to extended precision portion of FAC1
	LXI   H,FC7AH   ; Point to BCD portion of Floating point number
	MVI   B,07H     ; Prepare to move BCD portion of floating point
	CALL  L3469H    ; Move B bytes from (DE) to M with increment
	LXI   H,FC79H   ; Floating Point Temp 3
	MVI   M,00H     ; Make RND seed exponent "e-65"
L3173H:	CALL  L31C4H    ; Move floating point number M to FAC1
	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	MVI   M,40H     ; Make RND number a sane value < 1 (vs 1.332e-65, etc)
	XRA   A         ; Clear A
	STA   FC20H     ; Zero out 1st byte of extended precision portion of FAC1
	JMP   L2BDEH    ; Normalize FAC1 such that the 1st BCD digit isn't zero
	
	
; ======================================================
; Initialize FP_TEMP3 for new program
; ======================================================
L3182H:	LXI   D,L326CH  ; Load pointer to REALLY small number
	LXI   H,FC79H   ; Floating Point Temp 3
	JMP   L31CDH    ; Move Floating point at (DE) to M
	
	CALL  L3543H    ; Convert signed integer HL to single precision FAC1
	LXI   H,FC79H   ; Floating Point Temp 3
	JMP   L31CAH    ; Move FAC1 to M
	
L3194H:	CALL  L31B8H    ; Move floating point number M to FAC2
	JMP   L2B78H    ; Double precision addition (FAC1=FAC1+FAC2)
	
L319AH:	CALL  L31B8H    ; Move floating point number M to FAC2
	JMP   L2B69H    ; Double precision subtract (FAC1=FAC1-FAC2)
	
	
; ======================================================
; Double precision Square (FAC1=SQR(FAC1))
; ======================================================
L31A0H:	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	
; ======================================================
; Double precision math (FAC1=M * FAC2))
; ======================================================
L31A3H:	CALL  L31B8H    ; Move floating point number M to FAC2
	JMP   L2CFFH    ; Double precision multiply (FAC1=FAC1*FAC2)
	
	CALL  L31B8H    ; Move floating point number M to FAC2
	JMP   L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	
L31AFH:	CALL  L31B8H    ; Move floating point number M to FAC2
	JMP   L34D2H    ; Double precision compare FAC1 with FAC2
	
	
; ======================================================
; Move FAC1 to FAC2
; ======================================================
L31B5H:	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	
; ======================================================
; Move floating point number M to FAC2
; ======================================================
L31B8H:	LXI   D,FC69H   ; Start of FAC2 for single and double precision
L31BBH:	XCHG            ; DE = floating point number to move, HL = FAC2
	CALL  L31CDH    ; Call routine to Move
	XCHG            ; HL = Floating point number
	RET             
	
	
; ======================================================
; Move FAC2 to FAC1
; ======================================================
L31C1H:	LXI   H,FC69H   ; Start of FAC2 for single and double precision
	
; ======================================================
; Move floating point number M to FAC1
; ======================================================
L31C4H:	LXI   D,FC18H   ; Start of FAC1 for single and double precision
	JMP   L31BBH    ; Jump to routine to copy FP in DE to HL
	
	
; ======================================================
; Swap FAC1 and FAC2
; ======================================================
L31CAH:	LXI   D,FC18H   ; Start of FAC1 for single and double precision
L31CDH:	MVI   B,08H     ; Prepare to move 8 bytes of floating point number
	JMP   L3469H    ; Move B bytes from (DE) to M with increment
	
L31D2H:	POP   H         ; POP return address from stack
	SHLD  FBE7H     ; Floating Point Temp 1
	CALL  L3245H    ; Pop FAC2 from stack
	CALL  L3234H    ; Push FAC1 on stack
	CALL  L31C1H    ; Move FAC2 to FAC1
	LHLD  FBE7H     ; Floating Point Temp 1
	PCHL            ; RETurn (HL has return address)
	
L31E3H:	CALL  L33FDH    ; Perform ABS function on FAC1
	LXI   H,L33FDH  ; Load address to Perform ABS function on FAC1
	XTHL            ; Change return address to Perform ABS function on FAC1
	PCHL            ; Return to calling program (we changed his RET address)
	
	
; ======================================================
; Square FAC1 & do table based math
; ======================================================
L31EBH:	SHLD  FBE7H     ; Floating Point Temp 1
	CALL  L31A0H    ; Double precision Square (FAC1=SQR(FAC1))
	LHLD  FBE7H     ; Floating Point Temp 1
	JMP   L3209H    ; Table based math (FAC1=(((FAC1*M)+(M+1))*(M+2)+(M+3)...
	
L31F7H:	SHLD  FBE7H     ; Floating Point Temp 1
	CALL  L3234H    ; Push FAC1 on stack
	LHLD  FBE7H     ; Floating Point Temp 1
	CALL  L31EBH    ; Square FAC1 & do table based math
	CALL  L3245H    ; Pop FAC2 from stack
	JMP   L2CFFH    ; Double precision multiply (FAC1=FAC1*FAC2)
	
	
; ======================================================
; Table based math (FAC1=(((FAC1*M)+(M+1))*(M+2)+(M+3)...
; ======================================================
L3209H:	MOV   A,M       ; Get count of products to add
	PUSH  PSW       ; Save count on stack
	INX   H         ; Increment to first term
	PUSH  H         ; Save address of first term on stack
	LXI   H,FBE7H   ; Floating Point Temp 1
	CALL  L31CAH    ; Move FAC1 to M
	POP   H         ; Restore first term from stack
	CALL  L31C4H    ; Move floating point number M to FAC1
L3217H:	POP   PSW       ; Restore count of products to add from stack
	DCR   A         ; Decrement count
	RZ              ; Return if count = 0
	PUSH  PSW       ; Save new count to stack
	PUSH  H         ; Save address of next term to stack
	LXI   H,FBE7H   ; Floating Point Temp 1
	CALL  L31A3H    ; Double precision math (FAC1=M * FAC2))
	POP   H         ; Restore address of next term from stack
	CALL  L31B8H    ; Move floating point number M to FAC2
	PUSH  H         ; Save address to stack again
	CALL  L2B78H    ; Double precision addition (FAC1=FAC1+FAC2)
	POP   H         ; Restore address of next term from stack
	JMP   L3217H    ; Jump to process next term in series
	
	
; ======================================================
; Push FAC2 on stack
; ======================================================
L322EH:	LXI   H,FC70H   ; Point to end of FAC2
	JMP   L3237H    ; Jump to push 4 bytes to stack
	
	
; ======================================================
; Push FAC1 on stack
; ======================================================
L3234H:	LXI   H,FC1FH   ; Point to end of FAC1
L3237H:	MVI   A,04H     ; Load byte counter
	POP   D         ; POP return address (so we can push to stack)
L323AH:	MOV   B,M       ; Get next BCD byte from (M) to MSB (BCD is stored big endian)
	DCX   H         ; Decrement to next higher byte
	MOV   C,M       ; Get next BCD byte into LSB (BCD is stored big endian)
	DCX   H         ; Decrement to next higher byte
	PUSH  B         ; Push next 2 bytes to stack
	DCR   A         ; Decrement counter (each count is 2 bytes)
	JNZ   L323AH    ; Keep looping until 8 bytes (4 words) pushed
	XCHG            ; Put RETurn address in HL
	PCHL            ; RETurn (we modified the stack)
	
	
; ======================================================
; Pop FAC2 from stack
; ======================================================
L3245H:	LXI   H,FC69H   ; Start of FAC2 for single and double precision
	JMP   L324EH    ; Jump to POP a BCD value from the stack
	
	
; ======================================================
; Pop FAC1 from stack
; ======================================================
L324BH:	LXI   H,FC18H   ; Start of FAC1 for single and double precision
L324EH:	MVI   A,04H     ; Prepare to pop 4 words (8 bytes)
	POP   D         ; POP the return address to get to the BCD number
L3251H:	POP   B         ; POP next 2 bytes
	MOV   M,C       ; Move next byte to FAC1 / 2
	INX   H         ; Increment to next byte of FAC
	MOV   M,B       ; Move next byte to FAC1 / 2
	INX   H         ; Increment to next byte of FAC
	DCR   A         ; Decrement word counter
	JNZ   L3251H    ; Keep looping until 4 words POPed
	XCHG            ; Put return address in HL
	PCHL            ; Return (return address from stack is in HL)
	
	
; ======================================================
; Floating point numbers for math operations 
; ======================================================
L325CH:
    DB	00H,14H,38H,98H,20H,42H,08H,21H          ; 1.4389820420821e-65 - RND
L3264H:
    DB	00H,21H,13H,24H,86H,54H,05H,19H          ; 2.1132486540519e-65 - RND
L326CH:
    DB	00H,40H,64H,96H,51H,37H,23H,58H          ; 4.0649651372358e-65 - BASIC initialize
L3274H:
    DB	40H,43H,42H,94H,48H,19H,03H,24H          ; 0.43429448190324 - EXP
	
	
; ======================================================
; Floating point num-shares 6 bytes from next number
; ======================================================
L327CH:
    DB	40H,50H          ; 0.500000000000 - SIN, SQR, EXP
	
	
; ======================================================
; Floating point numbers for math operations 
; ======================================================
L327EH:
    DB	00H,00H,00H,00H,00H,00H,00H,00H          ; 0.0000000000000 - Various
L3286H:
    DB	41H,10H,00H,00H,00H,00H,00H,00H          ; 1.0000000000000 - Various
L328EH:
    DB	40H,25H,00H,00H,00H,00H,00H,00H          ; 0.2500000000000 - COS
L3296H:
    DB	41H,31H,62H,27H,76H,60H,16H,84H          ; 3.1622776601684 - LOG & EXP
L329EH:
    DB	40H,86H,85H,88H,96H,38H,06H,50H          ; 0.86858896380650 - LOG
L32A6H:
    DB	41H,23H,02H,58H,50H,92H,99H,40H          ; 2.3025850929940 - LOG
L32AEH:
    DB	41H,15H,70H,79H,63H,26H,79H,49H          ; 1.5707963267949 - ATN
L32B6H:
    DB	40H,26H,79H,49H,19H,24H,31H,12H          ; 0.26794919243112 - ATN
L32BEH:
    DB	41H,17H,32H,05H,08H,07H,56H,89H          ; 1.7320508075689 - ATN
L32C6H:
    DB	40H,52H,35H,98H,77H,55H,98H,30H          ; 0.52359877559830 - ATN
L32CEH:
    DB	40H,15H,91H,54H,94H,30H,91H,90H          ; 0.15915494309190 - SIN & COS
	
	
; ======================================================
; Count of Floating point numbers to follow for EXP
; ======================================================
L32D6H:
    DB	04H             
	
    DB	41H,10H,00H,00H,00H,00H,00H,00H          ; 1.0000000000000
    DB	43H,15H,93H,74H,15H,23H,60H,31H          ; 159.37415236031
    DB	44H,27H,09H,31H,69H,40H,85H,16H          ; 2709.3169408516
    DB	44H,44H,97H,63H,35H,57H,40H,58H          ; 4497.6335574058
	
	
; ======================================================
; Count of Floating point numbers to follow for EXP
; ======================================================
L32F7H:
    DB	03H             
	
    DB	42H,18H,31H,23H,60H,15H,92H,75H          ; 18.312360159275
    DB	43H,83H,14H,06H,72H,12H,93H,71H          ; 831.40672129371
    DB	44H,51H,78H,09H,19H,91H,51H,62H          ; 5178.0919915162
	
	
; ======================================================
; Count of Floating point numbers to follow for LOG
; ======================================================
L3310H:
    DB	04H             
	
    DB	C0H,71H,43H,33H,82H,15H,32H,26H          ; -0.71433382153226
    DB	41H,62H,50H,36H,51H,12H,79H,08H          ; 6.2503651127908
    DB	C2H,13H,68H,23H,70H,24H,15H,03H          ; -13.682370241503
    DB	41H,85H,16H,73H,19H,87H,23H,89H          ; 8.5167319872389
	
	
; ======================================================
; Count of Floating point numbers to follow for LOG
; ======================================================
L3331H:
    DB	05H             
	
    DB	41H,10H,00H,00H,00H,00H,00H,00H          ; 1.0000000000000
    DB	C2H,13H,21H,04H,78H,35H,01H,56H          ; -13.210478350156
    DB	42H,47H,92H,52H,56H,04H,38H,73H          ; 47.925256043873
    DB	C2H,64H,90H,66H,82H,74H,09H,43H          ; -64.906682740943
    DB	42H,29H,41H,57H,50H,17H,23H,23H          ; 29.415750172323
	
	
; ======================================================
; Count of Floating point numbers to follow for SIN
; ======================================================
L335AH:
    DB	08H             
	
    DB	C0H,69H,21H,56H,92H,29H,18H,09H          ; -0.69215692291809
    DB	41H,38H,17H,28H,86H,38H,57H,71H          ; 3.8172886385771
    DB	C2H,15H,09H,44H,99H,47H,48H,01H          ; -15.094499474801
    DB	42H,42H,05H,86H,89H,66H,73H,55H          ; 42.058689667355
    DB	C2H,76H,70H,58H,59H,68H,32H,91H          ; -76.705859683291
    DB	42H,81H,60H,52H,49H,27H,55H,13H          ; 81.605249275513
    DB	C2H,41H,34H,17H,02H,24H,03H,98H          ; -41.341702240398
    DB	41H,62H,83H,18H,53H,07H,17H,96H          ; 6.2831853071796
	
	
; ======================================================
; Count of Floating point numbers to follow for ATN
; ======================================================
L339BH:
    DB	08H             
	
    DB	BFH,52H,08H,69H,39H,04H,00H,00H          ; -0.052086939040000
    DB	3FH,75H,30H,71H,49H,13H,48H,00H          ; 0.075307149134800
    DB	BFH,90H,81H,34H,32H,24H,70H,50H          ; -0.090813432247050
    DB	40H,11H,11H,07H,94H,18H,40H,29H          ; 0.11110794184029
    DB	C0H,14H,28H,57H,08H,55H,48H,84H          ; Different from M1002
    DB	40H,19H,99H,99H,99H,94H,89H,67H          ; 0.19999999948967
    DB	C0H,33H,33H,33H,33H,33H,31H,60H          ; -0.33333333333160
    DB	41H,10H,00H,00H,00H,00H,00H,00H          ; 1.0000000000000
	
	
; ======================================================
; RST 30H routine
; ======================================================
L33DCH:	LDA   FC18H     ; Start of FAC1 for single and double precision
	ORA   A         ; Test if zero
	RZ              ; Return if zero
	LDA   FC18H     ; Start of FAC1 for single and double precision
	JMP   L33E8H    ; Return 1 or -1 in A based on Sign bit in A
	
L33E7H:	CMA             ; Compliment sign of A
L33E8H:	RAL             ; Rotate sign bit to C flag
L33E9H:	SBB   A         ; Subtract with borrow generates -1 or 0 based on C
	RNZ             ; Return if -1
	INR   A         ; Increment zero to 1
	RET             
	
L33EDH:	XRA   A         ; Zero out A
	STA   FC18H     ; Start of FAC1 for single and double precision
	RET             
	
	
; ======================================================
; ABS function
; ======================================================
	CALL  L3411H    ; Determine sign of last variable used
	RP              ; Return if already positive
L33F6H:	RST   5         ; Determine type of last var used
	JM    L37D0H    ; If integer, jump to ABS function for integer FAC1
	JZ    L045BH    ; Generate TM error
L33FDH:	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	MOV   A,M       ; Get sign / decimal point byte
	ORA   A         ; Test if FAC1 is zero
	RZ              ; Return if zero
	XRI   80H       ; Invert the sign bit - make positive
	MOV   M,A       ; Save inverted sign bit to FAC1
	RET             
	
	
; ======================================================
; SGN function
; ======================================================
L3407H:	CALL  L3411H    ; Get sign in A of last variable used
L340AH:	MOV   L,A       ; Move sign to LSB of HL
	RAL             ; Prepare to sign extend into MSB
	SBB   A         ; Generate zero or 1 based C flag (sign of integer)
	MOV   H,A       ; Sign extend into MSB of HL (HL has FFFFH, 0001H or 0000H)
	JMP   L3510H    ; Load signed integer in HL to FAC1
	
L3411H:	RST   5         ; Determine type of last var used
	JZ    L045BH    ; Generate TM error
	JP    L33DCH    ; RST 30H routine
	LHLD  FC1AH     ; Start of FAC1 for integers
L341BH:	MOV   A,H       ; Get MSB of integer
	ORA   L         ; OR in LSB to test for zero
	RZ              ; Return if zero
L341EH:	MOV   A,H       ; Get MSB of integer to test sign
	JMP   L33E8H    ; Return 1 or -1 in A based on Sign bit in A
	
	
; ======================================================
; Push single precision FAC1 on stack
; ======================================================
L3422H:	XCHG            
	LHLD  FC1AH     ; Start of FAC1 for integers
	XTHL            
	PUSH  H         
	LHLD  FC18H     ; Start of FAC1 for single and double precision
	XTHL            
	PUSH  H         
	XCHG            
	RET             
	
	
; ======================================================
; Load single precision at M to FAC1
; ======================================================
	CALL  L3450H    ; Reverse load single precision at M to DEBC
	
; ======================================================
; Load single precision in BCDE to FAC1
; ======================================================
L3432H:	XCHG            ; Load DE to HL, save HL
	SHLD  FC1AH     ; Start of FAC1 for integers
	MOV   H,B       ; Copy MSB of BE to HL
	MOV   L,C       ; Copy LSB
	SHLD  FC18H     ; Start of FAC1 for single and double precision
	XCHG            ; Restore HL
	RET             
	
	
; ======================================================
; Load single precision FAC1 to BCDE
; ======================================================
L343DH:	LHLD  FC1AH     ; Start of FAC1 for integers
	XCHG            ; Move LSW of FAC1 to DE
	LHLD  FC18H     ; Start of FAC1 for single and double precision
	MOV   C,L       ; Copy LSB of MSW from FAC1 to C
	MOV   B,H       ; Copy MSB of FAC1 to B
	RET             
	
	
; ======================================================
; Load single precision at M to BCDE
; ======================================================
L3447H:	MOV   C,M       ; Load 2 MSB BCD digits to C
	INX   H         ; Increment to next 2 BCD digits
	MOV   B,M       ; Load next 2 BCD to B
	INX   H         ; Increment to next 2 lower digits
	MOV   E,M       ; Load next 2 BCD to E
	INX   H         ; Increment to least significant BCD digits
	MOV   D,M       ; Load 2 LSB BCD digits to D
	INX   H         ; Increment to next BCD
	RET             
	
	
; ======================================================
; Reverse load single precision at M to DEBC
; ======================================================
L3450H:	MOV   E,M       ; Load 2 MSB BCD digits to E
	INX   H         ; Increment to next 2 lower BCD digits
L3452H:	MOV   D,M       ; Move next 2 BCD to D
	INX   H         ; Increment to next 2 lower BCD digits
	MOV   C,M       ; Load next 2 BCD to C
	INX   H         ; Increment to 2 least significant BCD digits
	MOV   B,M       ; Load 2 LSB BCD digits to B
L3457H:	INX   H         ; Final increment
	RET             
	
	
; ======================================================
; Move single precision FAC1 to M
; ======================================================
L3459H:	LXI   D,FC18H   ; Start of FAC1 for single and double precision
	MVI   B,04H     ; Prepare to copy 4 bytes
	JMP   L3469H    ; Move B bytes from (DE) to M with increment
	
	
; ======================================================
; Move M to FAC2 using precision at (FB65H)
; ======================================================
L3461H:	LXI   D,FC69H   ; Start of FAC2 for single and double precision
L3464H:	XCHG            ; Swap SRC and DEST address in HL & DE
L3465H:	LDA   FB65H     ; Type of last variable used
	MOV   B,A       ; Prepare to copy bytes based on precision of last var (2, 4 or 8)
	
; ======================================================
; Move B bytes from (DE) to M with increment
; ======================================================
L3469H:	LDAX  D         ; Load next byte to copy
	MOV   M,A       ; Save byte in destination address
	INX   D         ; Increment source pointer
	INX   H         ; Increment destination pointer
	DCR   B         ; Decrement byte counter
	JNZ   L3469H    ; Move B bytes from (DE) to M with increment
	RET             
	
	
; ======================================================
; Move B bytes from (DE) to M with decrement
; ======================================================
L3472H:	LDAX  D         ; Load next byte to copy
	MOV   M,A       ; Save next byte to destination
	DCX   D         ; Decrement source pointer
	DCX   H         ; Decrement destination pointer
	DCR   B         ; Decrement counter
	JNZ   L3472H    ; Move B bytes from (DE) to M with decrement
	RET             
	
L347BH:	LXI   H,FC69H   ; Start of FAC2 for single and double precision
L347EH:	LXI   D,L3464H  ; Copy (HL) to (DE) using precision of last var used (FB65H)
	JMP   L348AH    ; Jump to push copy operation to stack & copy to from FAC1
	
L3484H:	LXI   H,FC69H   ; Start of FAC2 for single and double precision
L3487H:	LXI   D,L3465H  ; Copy (DE) to (HL) using precision of last var used (FB65H)
L348AH:	PUSH  D         ; Push address of copy operation to stack
	LXI   D,FC18H   ; Start of FAC1 for single and double precision
	LDA   FB65H     ; Type of last variable used
	CPI   02H       ; Test if type of last variable is integer
	RNZ             ; Return to start copy if not integer FAC
	LXI   D,FC1AH   ; Start of FAC1 for integers
	RET             ; Return to PUSHed copy routine to perform copy (to / from FAC1)
	
	
; ======================================================
; Compare single precision in BCDE with FAC1
; ======================================================
L3498H:	MOV   A,C       ; Move sign/decimal point to A
	ORA   A         ; Test if value is zero
	JZ    L33DCH    ; RST 30H routine
	LXI   H,L33E7H  ; Load address of routine to teturn 1 or -1 in A
	PUSH  H         ; Push new return address to stack to return SGN
	RST   6         ; Get sign of FAC1
	MOV   A,C       ; Move sign/decimal point of BCDE to A
	RZ              ; If FAC1 is zero, return to calc sign of BCDE as return value
	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	XRA   M         ; Compare sign bit of BCDE and FAC1
	MOV   A,C       ; Get sign/decimal point of BCDE in A
	RM              ; Return to calc sign of BCDE as result if BCDE & FAC1 have different sign
	CALL  L34B0H    ; Compare single precision in BCDE with M
	RAR             ; Rotate the C bit into A to determine which is bigger based on sign
	XRA   C         ; XOR the sign of BCDE with A
	RET             ; Return to routine to calc 1 or -1 base on sign of A
	
	
; ======================================================
; Compare single precision in BCDE with M
; ======================================================
L34B0H:	MOV   A,C       
	CMP   M         
	RNZ             
	INX   H         
	MOV   A,B       
	CMP   M         
	RNZ             
	INX   H         
	MOV   A,E       
	CMP   M         
	RNZ             
	INX   H         
	MOV   A,D       
	SUB   M         
	RNZ             
	POP   H         
	POP   H         
	RET             
	
	
; ======================================================
; Compare signed integer in DE with that in HL
; ======================================================
L34C2H:	MOV   A,D       ; Prepare to compare MSB of DE and HL
	XRA   H         ; Test if sign of 2 integers are different
	MOV   A,H       ; Load sign of H in case they are different
	JM    L33E8H    ; Return 1 or -1 in A based on Sign bit in A
	CMP   D         ; Compare MSB of DE and HL to test if equal
	JNZ   L34CFH    ; Jump if not equal to determine which is bigger
	MOV   A,L       ; Prepare to compare LSB of HL and DE
	SUB   E         ; Compare LSB of HL and DE
	RZ              ; Return zero in A if they are equal
L34CFH:	JMP   L33E9H    ; Return 1 or -1 in A based on Carry flag
	
L34D2H:	LXI   D,FC69H   ; Start of FAC2 for single and double precision
	LDAX  D         ; Get Sign and Decimal point location for FAC2
	ORA   A         ; Test if FAC2 is zero
	JZ    L33DCH    ; RST 30H routine
	LXI   H,L33E7H  ; Return 1 or -1 in A based on Inverse of Sign bit in A
	PUSH  H         ; Push address of routine to return 1 or -1 based on A to stack
	RST   6         ; Get sign of FAC1
	LDAX  D         ; Get Sign and Decimal point location for FAC2
	MOV   C,A       ; Save sign of FAC2 in C
	RZ              ; If FAC1 is zero, return to calculate 1 or -1 base on sign of FAC2
	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	XRA   M         ; XOR sign bit of FAC1 and FAC2 to determine if they are equal
	MOV   A,C       ; Restore sign of FAC2 to A
	RM              ; Return to calculate 1 or -1 based on sign of FAC2 if sign of FAC1 != FAC2
	MVI   B,08H     ; Prepare to compare 8 bytes of floating point
L34EAH:	LDAX  D         ; Get next byte from FAC2
	SUB   M         ; Subtract next byte from FAC1
	JNZ   L34F7H    ; If not equal, jump to determine which is bigger
	INX   D         ; Point to next byte of FAC2
	INX   H         ; Increment to next byte of FAC1
	DCR   B         ; Decrement byte counter
	JNZ   L34EAH    ; Keep looping until 8 bytes compared
	POP   B         ; POP address of of SIGN routine ... they are equal and A already has zero
	RET             
	
L34F7H:	RAR             ; Get C flag from last subtract
	XRA   C         ; XOR with sign of FAC1 & FAC2
	RET             ; Return to calculate 1 or -1 based on A
	
	
; ======================================================
; Compare double precision FAC1 with FAC2
; ======================================================
	CALL  L34D2H    ; Double precision compare FAC1 with FAC2
	JNZ   L33E7H    ; Return 1 or -1 in A based on Inverse of Sign bit in A
	RET             
	
	
; ======================================================
; CINT function
; ======================================================
L3501H:	RST   5         ; Determine type of last var used
	LHLD  FC1AH     ; Start of FAC1 for integers
	RM              ; Return if already an integer
	JZ    L045BH    ; Generate TM error
	CALL  L35DEH    
	JC    L0455H    ; Generate OV error
	XCHG            
	
; ======================================================
; Load signed integer in HL to FAC1
; ======================================================
L3510H:	SHLD  FC1AH     ; Start of FAC1 for integers
L3513H:	MVI   A,02H     ; Load code for integer type variable
L3515H:	STA   FB65H     ; Type of last variable used
	RET             
	
L3519H:	LXI   B,L32C5H  ; SNGL precision value for 32768
	LXI   D,8076H   ; "
	CALL  L3498H    ; Compare single precision in BCDE with FAC1
	RNZ             ; Return if FAC1 != 32768.0
	LXI   H,8000H   ; Load HL with Decimal 32768
L3526H:	POP   D         
	JMP   L3510H    ; Load signed integer in HL to FAC1
	
	
; ======================================================
; CSNG function
; ======================================================
L352AH:	RST   5         ; Determine type of last var used
	RPO             
	JM    L3540H    ; Convert signed integer in FAC1 to single precision
	JZ    L045BH    ; Generate TM error
	CALL  L35D4H    ; Set type of last variable to SGL
	CALL  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
	INX   H         
	MOV   A,B       
	ORA   A         
	RAR             
	MOV   B,A       
	JMP   L2C2CH    
	
	
; ======================================================
; Convert signed integer in FAC1 to single precision
; ======================================================
L3540H:	LHLD  FC1AH     ; Start of FAC1 for integers
	
; ======================================================
; Convert signed integer HL to single precision FAC1
; ======================================================
L3543H:	MOV   A,H       
L3544H:	ORA   A         
	PUSH  PSW       
	CM    L37C6H    
	CALL  L35D4H    ; Set type of last variable to SGL
	XCHG            
	LXI   H,0000H  
	SHLD  FC18H     ; Start of FAC1 for single and double precision
	SHLD  FC1AH     ; Start of FAC1 for integers
	MOV   A,D       
	ORA   E         
	JZ    L27E2H    
	LXI   B,L0500H  
	LXI   H,FC19H   ; Point to BCD portion of FAC1
	PUSH  H         
	LXI   H,L35B0H  
L3565H:	MVI   A,FFH     
	PUSH  D         
	MOV   E,M       
	INX   H         
	MOV   D,M       
	INX   H         
	XTHL            
	PUSH  B         
L356EH:	MOV   B,H       
	MOV   C,L       
	DAD   D         
	INR   A         
	JC    L356EH    
	MOV   H,B       
	MOV   L,C       
	POP   B         
	POP   D         
	XCHG            
	INR   C         
	DCR   C         
	JNZ   L358BH    
	ORA   A         
	JZ    L35A1H    
	PUSH  PSW       
	MVI   A,40H     
	ADD   B         
	STA   FC18H     ; Start of FAC1 for single and double precision
	POP   PSW       
L358BH:	INR   C         
	XTHL            
	PUSH  PSW       
	MOV   A,C       
	RAR             
	JNC   L359CH    
	POP   PSW       
	ADD   A         
	ADD   A         
	ADD   A         
	ADD   A         
	MOV   M,A       
	JMP   L35A0H    
	
L359CH:	POP   PSW       
	ORA   M         
	MOV   M,A       
	INX   H         
L35A0H:	XTHL            
L35A1H:	MOV   A,D       
	ORA   E         
	JZ    L35AAH    
	DCR   B         
	JNZ   L3565H    
L35AAH:	POP   H         
	POP   PSW       
	RP              
	JMP   L33FDH    ; Perform ABS function on FAC1
	
L35B0H:	RP              
	RC              
	RLDE            
	CM    FF9CH     
	ORI   FFH       
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	FFH             
	
; ======================================================
; CDBL function
; ======================================================
L35BAH:	RST   5         ; Determine type of last var used
	RNC             ; Return if already double precision
	JZ    L045BH    ; Generate TM error
	CM    L3540H    ; Convert signed integer in FAC1 to single precision
L35C2H:	LXI   H,0000H   ; Prepare to "zero out" the double precision portion of FAC1
	SHLD  FC1CH     ; Zero out next 4 digits of FAC1
	SHLD  FC1EH     ; Zero out least 4 significant digits of FAC1
	MOV   A,H       ; Prepare to zero out extended precision portion of FAC1
	STA   FC20H     ; Zero out extended precision portion of FAC1
L35CFH:	MVI   A,08H     ; Load code for double precision variable type
	JMP   L35D6H    ; Jump to set type of last variable
	
L35D4H:	MVI   A,04H     ; Load code for Single Precision variable type
L35D6H:	JMP   L3515H    ; Save type of last variable from A
	
L35D9H:	RST   5         ; Determine type of last var used
	RZ              ; Return if type is string
	JMP   L045BH    ; Generate TM error
	
L35DEH:	LXI   H,L3641H  
	PUSH  H         
	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	MOV   A,M       
	ANI   7FH       
	CPI   46H       
	RNC             
	SUI   41H       
	JNC   L35F6H    
	ORA   A         
	POP   D         
	LXI   D,0000H  
	RET             
	
L35F6H:	INR   A         
	MOV   B,A       
	
; ======================================================
; Signed integer subtract (FAC1=HL-DE)
; ======================================================
	LXI   D,0000H  
	MOV   C,D       
	INX   H         
L35FDH:	MOV   A,C       
	INR   C         
	RAR             
	MOV   A,M       
	JC    L360BH    
	RAR             
	RAR             
	RAR             
	RAR             
	JMP   L360CH    
	
L360BH:	INX   H         
L360CH:	ANI   0FH       
	SHLD  FC12H     
	MOV   H,D       
	MOV   L,E       
	DAD   H         
	RC              
	DAD   H         
	RC              
	DAD   D         
	RC              
	DAD   H         
	RC              
	MOV   E,A       
	MVI   D,00H     
L361EH:	DAD   D         
	RC              
	XCHG            
	LHLD  FC12H     
	DCR   B         
	JNZ   L35FDH    
	LXI   H,8000H   
	RST   3         ; Compare DE and HL
	LDA   FC18H     ; Start of FAC1 for single and double precision
	RC              
	JZ    L363DH    
	POP   H         
	ORA   A         
	RP              
	XCHG            
	CALL  L37C6H    
	XCHG            
	ORA   A         
	RET             
	
L363DH:	ORA   A         
	RP              
	POP   H         
	RET             
	
L3641H:	STC             
	RET             
	
L3643H:	DCX   B         
	RET             
	
	
; ======================================================
; FIX function
; ======================================================
	RST   5         ; Determine type of last var used
	RM              
	RST   6         ; Get sign of FAC1
	JP    L3654H    ; INT function
	CALL  L33FDH    ; Perform ABS function on FAC1
	CALL  L3654H    ; INT function
	JMP   L33F6H    
	
	
; ======================================================
; INT function
; ======================================================
L3654H:	RST   5         ; Determine type of last var used
	RM              
	LXI   H,FC20H   ; Temp BCD value for computation?
	MVI   C,0EH     
	JNC   L3666H    
	JZ    L045BH    ; Generate TM error
	LXI   H,FC1CH   
	MVI   C,06H     
L3666H:	LDA   FC18H     ; Start of FAC1 for single and double precision
	ORA   A         
	JM    L3688H    
	ANI   7FH       
	SUI   41H       
	JC    L33EDH    ; Initialize FAC1 for SGL & DBL precision to zero
	INR   A         
	SUB   C         
	RNC             
	CMA             
	INR   A         
	MOV   B,A       
L367AH:	DCX   H         
	MOV   A,M       
	ANI   F0H       
	MOV   M,A       
	DCR   B         
	RZ              
	XRA   A         
	MOV   M,A       
	DCR   B         
	JNZ   L367AH    
	RET             
	
L3688H:	ANI   7FH       
	SUI   41H       
	JNC   L3695H    
	LXI   H,FFFFH   
	JMP   L3510H    ; Load signed integer in HL to FAC1
	
L3695H:	INR   A         
	SUB   C         
	RNC             
	CMA             
	INR   A         
	MOV   B,A       
	MVI   E,00H     
L369DH:	DCX   H         
	MOV   A,M       
	MOV   D,A       
	ANI   F0H       
	MOV   M,A       
	CMP   D         
	JZ    L36A8H    
	INR   E         
L36A8H:	DCR   B         
	JZ    L36B7H    
	XRA   A         
	MOV   M,A       
	CMP   D         
	JZ    L36B3H    
	INR   E         
L36B3H:	DCR   B         
	JNZ   L369DH    
L36B7H:	INR   E         
	DCR   E         
	RZ              
	MOV   A,C       
	CPI   06H       
	LXI   B,L10C1H  
	LXI   D,0000H  
	JZ    L37F4H    ; Single precision addition (FAC1=FAC1+BCDE)
	XCHG            
	SHLD  FC6FH     
	SHLD  FC6DH     
	SHLD  FC6BH     ; Start of FAC2 for integers
	MOV   H,B       
	MOV   L,C       
	SHLD  FC69H     ; Start of FAC2 for single and double precision
	JMP   L2B78H    ; Double precision addition (FAC1=FAC1+FAC2)
	
L36D8H:	PUSH  H         
	LXI   H,0000H  
	MOV   A,B       
	ORA   C         
	JZ    L36F5H    
	MVI   A,10H     
L36E3H:	DAD   H         
	JC    L48F6H    
	XCHG            
	DAD   H         
	XCHG            
	JNC   L36F1H    
	DAD   B         
	JC    L48F6H    
L36F1H:	DCR   A         
	JNZ   L36E3H    
L36F5H:	XCHG            
	POP   H         
	RET             
	
	MOV   A,H       
	RAL             
	SBB   A         
	MOV   B,A       
	CALL  L37C6H    
	MOV   A,C       
	SBB   B         
	JMP   L3707H    
	
	
; ======================================================
; Signed integer addition (FAC1=HL+DE)
; ======================================================
L3704H:	MOV   A,H       
	RAL             
	SBB   A         
L3707H:	MOV   B,A       
	PUSH  H         
	MOV   A,D       
	RAL             
	SBB   A         
	DAD   D         
	ADC   B         
	RRC             
	XRA   H         
	JP    L3526H    
	PUSH  B         
	XCHG            
	CALL  L3543H    ; Convert signed integer HL to single precision FAC1
	POP   PSW       
	POP   H         
	CALL  L3422H    ; Push single precision FAC1 on stack
	CALL  L3543H    ; Convert signed integer HL to single precision FAC1
	POP   B         
	POP   D         
	JMP   L37F4H    ; Single precision addition (FAC1=FAC1+BCDE)
	
	
; ======================================================
; Signed integer muliply (FAC1=HL*DE)
; ======================================================
L3725H:	MOV   A,H       
	ORA   L         
	JZ    L3510H    ; Load signed integer in HL to FAC1
	PUSH  H         
	PUSH  D         
	CALL  L37BAH    
	PUSH  B         
	MOV   B,H       
	MOV   C,L       
	LXI   H,0000H  
	MVI   A,10H     
L3737H:	DAD   H         
	JC    L375FH    
	XCHG            
	DAD   H         
	XCHG            
	JNC   L3745H    
	DAD   B         
	JC    L375FH    
L3745H:	DCR   A         
	JNZ   L3737H    
	POP   B         
	POP   D         
L374BH:	MOV   A,H       
	ORA   A         
	JM    L3755H    
	POP   D         
	MOV   A,B       
	JMP   L37C2H    
	
L3755H:	XRI   80H       
	ORA   L         
	JZ    L3770H    
	XCHG            
	JMP   L3761H    
	
L375FH:	POP   B         
	POP   H         
L3761H:	CALL  L3543H    ; Convert signed integer HL to single precision FAC1
	POP   H         
	CALL  L3422H    ; Push single precision FAC1 on stack
	CALL  L3543H    ; Convert signed integer HL to single precision FAC1
	POP   B         
	POP   D         
	JMP   L3803H    ; Single precision multiply (FAC1=FAC1*BCDE)
	
L3770H:	MOV   A,B       
	ORA   A         
	POP   B         
	JM    L3510H    ; Load signed integer in HL to FAC1
	PUSH  D         
	CALL  L3543H    ; Convert signed integer HL to single precision FAC1
	POP   D         
	JMP   L33FDH    ; Perform ABS function on FAC1
	
	
; ======================================================
; Signed integer divide (FAC1=DE/HL)
; ======================================================
L377EH:	MOV   A,H       
	ORA   L         
	JZ    L0449H    ; Generate /0 error
	CALL  L37BAH    
	PUSH  B         
	XCHG            
	CALL  L37C6H    
	MOV   B,H       
	MOV   C,L       
	LXI   H,0000H  
	MVI   A,11H     
	PUSH  PSW       
	ORA   A         
	JMP   L37A3H    
	
L3797H:	PUSH  PSW       
	PUSH  H         
	DAD   B         
	JNC   L37A2H    
	POP   PSW       
	STC             
	JMP   L37A3H    
	
L37A2H:	POP   H         
L37A3H:	MOV   A,E       
	RAL             
	MOV   E,A       
	MOV   A,D       
	RAL             
	MOV   D,A       
	MOV   A,L       
	RAL             
	MOV   L,A       
	MOV   A,H       
	RAL             
	MOV   H,A       
	POP   PSW       
	DCR   A         
	JNZ   L3797H    
	XCHG            
	POP   B         
	PUSH  D         
	JMP   L374BH    
	
L37BAH:	MOV   A,H       
	XRA   D         
	MOV   B,A       
	CALL  L37C1H    
	XCHG            
L37C1H:	MOV   A,H       
L37C2H:	ORA   A         
	JP    L3510H    ; Load signed integer in HL to FAC1
L37C6H:	XRA   A         
	MOV   C,A       
	SUB   L         
	MOV   L,A       
	MOV   A,C       
	SUB   H         
	MOV   H,A       
	JMP   L3510H    ; Load signed integer in HL to FAC1
	
L37D0H:	LHLD  FC1AH     ; Start of FAC1 for integers
	CALL  L37C6H    
	MOV   A,H       
	XRI   80H       
	ORA   L         
	RNZ             
L37DBH:	XRA   A         ; Clear A to perform unsigned comparison
	JMP   L3544H    ; Jump into Convert Signed to single precision in FAC1
	
L37DFH:	PUSH  D         
	CALL  L377EH    ; Signed integer divide (FAC1=DE/HL)
	XRA   A         
	ADD   D         
	RAR             
	MOV   H,A       
	MOV   A,E       
	RAR             
	MOV   L,A       
	CALL  L3513H    
	POP   PSW       
	JMP   L37C2H    
	
	CALL  L3450H    ; Reverse load single precision at M to DEBC
	
; ======================================================
; Single precision addition (FAC1=FAC1+BCDE)
; ======================================================
L37F4H:	CALL  L3827H    ; Single precision load (FAC2=BCDE)
	
; ======================================================
; Single precision addition (FAC1=FAC1+FAC2)
; ======================================================
	CALL  L35C2H    ; Convert FAC1 to double precision
	JMP   L2B78H    ; Double precision addition (FAC1=FAC1+FAC2)
	
	
; ======================================================
; Single precision subtract (FAC1=FAC1-BCDE)
; ======================================================
L37FDH:	CALL  L33FDH    ; Perform ABS function on FAC1
	JMP   L37F4H    ; Single precision addition (FAC1=FAC1+BCDE)
	
	
; ======================================================
; Single precision multiply (FAC1=FAC1*BCDE)
; ======================================================
L3803H:	CALL  L3827H    ; Single precision load (FAC2=BCDE)
	
; ======================================================
; Single precision multiply (FAC1=FAC2*FAC2)
; ======================================================
	CALL  L35C2H    ; Convert FAC1 to double precision
	JMP   L2CFFH    ; Double precision multiply (FAC1=FAC1*FAC2)
	
L380CH:	POP   B         
	POP   D         
	
; ======================================================
; Single precision divide (FAC1=BCDE/FAC1)
; ======================================================
	LHLD  FC1AH     ; Start of FAC1 for integers
	XCHG            
	SHLD  FC1AH     ; Start of FAC1 for integers
	PUSH  B         
	LHLD  FC18H     ; Start of FAC1 for single and double precision
	XTHL            
	SHLD  FC18H     ; Start of FAC1 for single and double precision
	POP   B         
L381EH:	CALL  L3827H    ; Single precision load (FAC2=BCDE)
	CALL  L35C2H    ; Convert FAC11 to double precision
	JMP   L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	
	
; ======================================================
; Single precision load (FAC2=BCDE)
; ======================================================
L3827H:	XCHG            
	SHLD  FC6BH     ; Start of FAC2 for integers
	MOV   H,B       
	MOV   L,C       
	SHLD  FC69H     ; Start of FAC2 for single and double precision
	LXI   H,0000H  
	SHLD  FC6DH     
	SHLD  FC6FH     
	RET             
	
L383AH:	DCR   A         
	RET             
	
L383CH:	DCX   H         
	RET             
	
L383EH:	POP   H         
	RET             
	
	
; ======================================================
; Convert ASCII number at M to double precision in FAC1
; ======================================================
L3840H:	XCHG            
	LXI   B,L00FFH  
	MOV   H,B       
	MOV   L,B       
	CALL  L3510H    ; Load signed integer in HL to FAC1
	XCHG            
	MOV   A,M       
	CPI   2DH       
	PUSH  PSW       
	JZ    L3857H    
	CPI   2BH       
	JZ    L3857H    
	DCX   H         
L3857H:	RST   2         ; Get next non-white char from M
	JC    L3940H    ; Convert ASCII number that starts with a Digit
	CPI   2EH       
	JZ    L3904H    ; Found '.' in ASCII number
	CPI   65H       
	JZ    L3867H    ; Found 'e' in ASCII number
	CPI   45H       
	
; ======================================================
; Found 'e' in ASCII number
; ======================================================
L3867H:	JNZ   L388AH    ; Found 'E' in ASCII number
	PUSH  H         
	RST   2         ; Get next non-white char from M
	CPI   6CH       
	JZ    L387DH    
	CPI   4CH       
	JZ    L387DH    
	CPI   71H       
	JZ    L387DH    
	CPI   51H       
L387DH:	POP   H         
	JZ    L3889H    
	RST   5         ; Determine type of last var used
	JNC   L38A3H    
	XRA   A         
	JMP   L38A4H    
	
L3889H:	MOV   A,M       
	
; ======================================================
; Found 'E' in ASCII number
; ======================================================
L388AH:	CPI   25H       ; Compare next byte with '%'
	JZ    L391AH    ; Found '%' in ASCII number
	CPI   23H       ; Compare next byte with '#'
	JZ    L3929H    ; Found '#' in ASCII number
	CPI   21H       ; Compare next byte with '!'
	JZ    L392AH    ; Jump if found '!' in ASCII number
	CPI   64H       ; Compare next byte with 'd'
	JZ    L38A3H    
	CPI   44H       ; Compare next byte with 'D'
	JNZ   L38D1H    
L38A3H:	ORA   A         
L38A4H:	CALL  L3931H    ; Deal with single & double precision ASCII conversions
	RST   2         ; Get next non-white char from M
	PUSH  D         
	MVI   D,00H     
	CALL  L1037H    ; ASCII num conversion - find ASCII or tokenized '+' or '-' in A
	MOV   C,D       
	POP   D         
L38B0H:	RST   2         ; Get next non-white char from M
	JNC   L38CAH    
	MOV   A,E       
	CPI   0CH       
	JNC   L38C5H    
	RLC             
	RLC             
	ADD   E         
	RLC             
	ADD   M         
	SUI   30H       
	MOV   E,A       
	JMP   L38B0H    
	
L38C5H:	MVI   E,80H     
	JMP   L38B0H    
	
L38CAH:	INR   C         
	JNZ   L38D1H    
	XRA   A         
	SUB   E         
	MOV   E,A       
L38D1H:	RST   5         ; Determine type of last var used
	JM    L38E8H    ; Skip ahead if last var type was integer
	LDA   FC18H     ; Start of FAC1 for single and double precision
	ORA   A         ; Test if FAC1 is zero
	JZ    L38E8H    ; Skip ahead if FAC1 is zero
	MOV   A,D       
	SUB   B         
	ADD   E         
	ADI   40H       
	STA   FC18H     ; Start of FAC1 for single and double precision
	ORA   A         
	CM    L3901H    
L38E8H:	POP   PSW       
	PUSH  H         
	CZ    L33F6H    
	RST   5         ; Determine type of last var used
	JNC   L38FCH    
	POP   H         
	RPE             
	PUSH  H         
	LXI   H,L383EH  
	PUSH  H         
	CALL  L3519H    
	RET             
	
L38FCH:	CALL  L2C27H    
	POP   H         
	RET             
	
L3901H:	JMP   L0455H    ; Generate OV error
	
	
; ======================================================
; Found '.' in ASCII number
; ======================================================
L3904H:	RST   5         ; Determine type of last var used
	INR   C         
	JNZ   L38D1H    
	JNC   L3917H    
	CALL  L3931H    ; Deal with single & double precision ASCII conversions
	LDA   FC18H     ; Start of FAC1 for single and double precision
	ORA   A         
	JNZ   L3917H    
	MOV   D,A       
L3917H:	JMP   L3857H    
	
	
; ======================================================
; Found '%' in ASCII number
; ======================================================
L391AH:	RST   2         ; Get next non-white char from M
	POP   PSW       
	PUSH  H         
	LXI   H,L383EH  
	PUSH  H         
	LXI   H,L3501H  ; Load address of CINT function
	PUSH  H         ; Push new return address to stack
	PUSH  PSW       
	JMP   L38D1H    
	
	
; ======================================================
; Found '#' in ASCII number
; ======================================================
L3929H:	ORA   A         ; Clear Z flag to denote double precision
L392AH:	CALL  L3931H    ; Deal with single & double precision ASCII conversions
	RST   2         ; Get next non-white char from M
	JMP   L38D1H    
	
	
; ======================================================
; Deal with single & double precision ASCII conversions
; ======================================================
L3931H:	PUSH  H         ; Preserve HL on stack
	PUSH  D         ; Preserve DE on stack
	PUSH  B         ; Preserve BC on stack
	PUSH  PSW       ; Save flags on stack
	CZ    L352AH    ; CSNG function
	POP   PSW       ; Restore flags
	CNZ   L35BAH    ; CDBL function
	POP   B         ; Restore BC
	POP   D         ; Restore DE
	POP   H         ; Restore HL
	RET             
	
	
; ======================================================
; Convert ASCII number that starts with a Digit
; ======================================================
L3940H:	SUI   30H       
	JNZ   L394DH    
	ORA   C         
	JZ    L394DH    
	ANA   D         
	JZ    L3857H    
L394DH:	INR   D         
	MOV   A,D       
	CPI   07H       
	JNZ   L3958H    
	ORA   A         
	CALL  L3931H    ; Deal with single & double precision ASCII conversions
L3958H:	PUSH  D         
	MOV   A,B       
	ADD   C         
	INR   A         
	MOV   B,A       
	PUSH  B         
	PUSH  H         
	MOV   A,M       
	SUI   30H       
	PUSH  PSW       
	RST   5         ; Determine type of last var used
	JP    L398DH    
	LHLD  FC1AH     ; Start of FAC1 for integers
	LXI   D,L0CCDH  
	RST   3         ; Compare DE and HL
	JNC   L398AH    
	MOV   D,H       
	MOV   E,L       
	DAD   H         
	DAD   H         
	DAD   D         
	DAD   H         
	POP   PSW       
	MOV   C,A       
	DAD   B         
	MOV   A,H       
	ORA   A         
	JM    L3988H    
	SHLD  FC1AH     ; Start of FAC1 for integers
L3982H:	POP   H         
	POP   B         
	POP   D         
	JMP   L3857H    
	
L3988H:	MOV   A,C       
	PUSH  PSW       
L398AH:	CALL  L3540H    ; Convert signed integer in FAC1 to single precision
L398DH:	POP   PSW       
	POP   H         
	POP   B         
	POP   D         
	JNZ   L39A1H    
	LDA   FC18H     ; Start of FAC1 for single and double precision
	ORA   A         
	MVI   A,00H     
	JNZ   L39A1H    
	MOV   D,A       
	JMP   L3857H    
	
L39A1H:	PUSH  D         
	PUSH  B         
	PUSH  H         
	PUSH  PSW       
	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	MVI   M,01H     
	MOV   A,D       
	CPI   10H       
	JC    L39B4H    
	POP   PSW       
	JMP   L3982H    
	
L39B4H:	INR   A         
	ORA   A         
	RAR             
	MVI   B,00H     
	MOV   C,A       
	DAD   B         
	POP   PSW       
	MOV   C,A       
	MOV   A,D       
	RAR             
	MOV   A,C       
	JNC   L39C7H    
	ADD   A         
	ADD   A         
	ADD   A         
	ADD   A         
L39C7H:	ORA   M         
	MOV   M,A       
	JMP   L3982H    
	
	
; ======================================================
; Finish printing BASIC ERROR message " in " line #
; ======================================================
L39CCH:	PUSH  H         ; Preserve line number in HL on stack
	LXI   H,L03F1H  ; Load pointer to " in " text
	CALL  L27B1H    ; Print buffer at M until NULL or '"'
	POP   H         ; Restore line number to HL
	
; ======================================================
; Print binary number in HL at current position
; ======================================================
L39D4H:	LXI   B,L27B0H  ; Load address of Print buffer at M-1 until NULL or '"'
	PUSH  B         
	CALL  L3510H    ; Load signed integer in HL to FAC1
	XRA   A         
	STA   FB8EH     
	LXI   H,FBE8H   
	MVI   M,20H     
	ORA   M         
	JMP   L3A05H    
	
	
; ======================================================
; Convert binary number in FAC1 to ASCII at M
; ======================================================
L39E8H:	XRA   A         
L39E9H:	CALL  L3D11H    ; Initialize FAC1 with 0.0 if it has no value
	
; ======================================================
; Convert binary number in FAC1 to ASCII at M with format
; ======================================================
	ANI   08H       
	JZ    L39F3H    
	MVI   M,2BH     
L39F3H:	XCHG            
	CALL  L3411H    ; Determine sign of last variable used
	XCHG            
	JP    L3A05H    ; Jump if single precision
	MVI   M,2DH     ; Store a '-'
	PUSH  B         
	PUSH  H         
	CALL  L33F6H    
	POP   H         
	POP   B         
	ORA   H         
L3A05H:	INX   H         
	MVI   M,30H     ; Store a '0'
	LDA   FB8EH     
	MOV   D,A       
	RAL             
	LDA   FB65H     ; Type of last variable used
	JC    L3ACAH    
	JZ    L3AC2H    
	CPI   04H       ; Test if last variable type is Double Precision?
	JNC   L3A6FH    
	LXI   B,0000H  
L3A1EH:	CALL  L3CC3H    
L3A21H:	LXI   H,FBE8H   
	MOV   B,M       
	MVI   C,20H     
	LDA   FB8EH     
	MOV   E,A       
	ANI   20H       
	JZ    L3A3EH    
	MOV   A,B       
	CMP   C         
	MVI   C,2AH     
	JNZ   L3A3EH    
	MOV   A,E       
	ANI   04H       
	JNZ   L3A3EH    
	MOV   B,C       
L3A3EH:	MOV   M,C       
	RST   2         ; Get next non-white char from M
	JZ    L3A5CH    
	CPI   45H       ; Test for 'E'
	JZ    L3A5CH    
	CPI   44H       ; Test for 'D'
	JZ    L3A5CH    
	CPI   30H       ; Test for '0'
	JZ    L3A3EH    
	CPI   2CH       ; Test for ','
	JZ    L3A3EH    
	CPI   2EH       ; Test for '.'
	JNZ   L3A5FH    
L3A5CH:	DCX   H         
	MVI   M,30H     ; Store a '0'
L3A5FH:	MOV   A,E       
	ANI   10H       
	JZ    L3A68H    
	DCX   H         
	MVI   M,24H     ; Store a '$'
L3A68H:	MOV   A,E       
	ANI   04H       
	RNZ             
	DCX   H         
	MOV   M,B       
	RET             
	
L3A6FH:	PUSH  H         
	CALL  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
	MOV   D,B       
	INR   D         
	LXI   B,L0300H  
	LDA   FC18H     ; Start of FAC1 for single and double precision
	SUI   3FH       
	JC    L3A89H    
	INR   D         
	CMP   D         
	JNC   L3A89H    
	INR   A         
	MOV   B,A       
	MVI   A,02H     
L3A89H:	SUI   02H       
	POP   H         
	PUSH  PSW       
	CALL  L3C70H    
	MVI   M,30H     ; Store a '0'
	CZ    L3457H    ; Increment HL and return
	CALL  L3C97H    
L3A98H:	DCX   H         
	MOV   A,M       
	CPI   30H       ; Test for '0'
	JZ    L3A98H    ; Skip leading zero maybe?
	CPI   2EH       ; Test for '.'
	CNZ   L3457H    ; Increment HL and return
	POP   PSW       
	JZ    L3AC3H    
L3AA8H:	MVI   M,45H     ; Store a 'E'
	INX   H         ; Increment output string pointer
	MVI   M,2BH     ; Store a '+'
	JP    L3AB4H    
	MVI   M,2DH     ; Store a '-'
	CMA             
	INR   A         
L3AB4H:	MVI   B,2FH     
L3AB6H:	INR   B         
	SUI   0AH       
	JNC   L3AB6H    
	ADI   3AH       
	INX   H         
	MOV   M,B       
	INX   H         
	MOV   M,A       
L3AC2H:	INX   H         
L3AC3H:	MVI   M,00H     
	XCHG            
	LXI   H,FBE8H   
	RET             
	
L3ACAH:	INX   H         
	PUSH  B         
	CPI   04H       
	MOV   A,D       
	JNC   L3B42H    
	RAR             
	JC    L3BCCH    
	LXI   B,L0603H  
	CALL  L3C68H    
	POP   D         
	MOV   A,D       
	SUI   05H       
	CP    L3C44H    
	CALL  L3CC3H    
L3AE6H:	MOV   A,E       
	ORA   A         
	CZ    L383CH    
	DCR   A         
	CP    L3C44H    
L3AEFH:	PUSH  H         
	CALL  L3A21H    
	POP   H         
	JZ    L3AF9H    
	MOV   M,B       
	INX   H         
L3AF9H:	MVI   M,00H     
	LXI   H,FBE7H   ; Floating Point Temp 1
L3AFEH:	INX   H         
L3AFFH:	LDA   FBA8H     
	SUB   L         
	SUB   D         
	RZ              
	MOV   A,M       
	CPI   20H       ; Test for space
	JZ    L3AFEH    
	CPI   2AH       ; Test for '*'
	JZ    L3AFEH    
	DCX   H         
	PUSH  H         
L3B12H:	PUSH  PSW       
	LXI   B,L3B12H  
	PUSH  B         
	RST   2         ; Get next non-white char from M
	CPI   2DH       ; Test for '-'
	RZ              
	CPI   2BH       ; Test for '+'
	RZ              
	CPI   24H       ; Test for '$'
	RZ              
	POP   B         
	CPI   30H       ; Test for '0'
	JNZ   L3B3AH    
	INX   H         
	RST   2         ; Get next non-white char from M
	JNC   L3B3AH    
	DCX   H         
	JMP   L3B32H    
	
L3B30H:	DCX   H         
	MOV   M,A       
L3B32H:	POP   PSW       
	JZ    L3B30H    
	POP   B         
	JMP   L3AFFH    
	
L3B3AH:	POP   PSW       
	JZ    L3B3AH    
	POP   H         
	MVI   M,25H     ; Store a '%'
	RET             
	
L3B42H:	PUSH  H         
	RAR             
	JC    L3BD2H    
	CALL  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
	MOV   D,B       
	LDA   FC18H     ; Start of FAC1 for single and double precision
	SUI   4FH       
	JC    L3B5EH    
	POP   H         
	POP   B         
	CALL  L39E8H    ; Convert binary number in FAC1 to ASCII at M
	LXI   H,FBE7H   ; Floating Point Temp 1
	MVI   M,25H     ; Store a '%'
	RET             
	
L3B5EH:	RST   6         ; Get sign of FAC1
	CNZ   L3D55H    
	POP   H         
	POP   B         
	JM    L3B81H    
	PUSH  B         
	MOV   E,A       
	MOV   A,B       
	SUB   D         
	SUB   E         
	CP    L3C44H    
	CALL  L3C5BH    
	CALL  L3C97H    
	ORA   E         
	CNZ   L3C54H    
	ORA   E         
	CNZ   L3C83H    ; Format output with ',' and '.' based on digit count
	POP   D         
	JMP   L3AE6H    
	
L3B81H:	MOV   E,A       
	MOV   A,C       
	ORA   A         
	CNZ   L383AH    
	ADD   E         
	JM    L3B8CH    
	XRA   A         
L3B8CH:	PUSH  B         
	PUSH  PSW       
	CM    L3D2DH    
	POP   B         
	MOV   A,E       
	SUB   B         
	POP   B         
	MOV   E,A       
	ADD   D         
	MOV   A,B       
	JM    L3BA7H    
	SUB   D         
	SUB   E         
	CP    L3C44H    
	PUSH  B         
	CALL  L3C5BH    
	JMP   L3BB8H    
	
L3BA7H:	CALL  L3C44H    
	MOV   A,C       
	CALL  L3C87H    
	MOV   C,A       
	XRA   A         
	SUB   D         
	SUB   E         
	CALL  L3C44H    
	PUSH  B         
	MOV   B,A       
	MOV   C,A       
L3BB8H:	CALL  L3C97H    
	POP   B         
	ORA   C         
	JNZ   L3BC3H    
	LHLD  FBA8H     
L3BC3H:	ADD   E         
	DCR   A         
	CP    L3C44H    
	MOV   D,B       
	JMP   L3AEFH    
	
L3BCCH:	PUSH  H         
	PUSH  D         
	CALL  L3540H    ; Convert signed integer in FAC1 to single precision
	POP   D         
L3BD2H:	CALL  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
	MOV   E,B       
	RST   6         ; Get sign of FAC1
	PUSH  PSW       
	CNZ   L3D55H    
	POP   PSW       
	POP   H         
	POP   B         
	PUSH  PSW       
	MOV   A,C       
	ORA   A         
	PUSH  PSW       
	CNZ   L383AH    
	ADD   B         
	MOV   C,A       
	MOV   A,D       
	ANI   04H       
	CPI   01H       
	SBB   A         
	MOV   D,A       
	ADD   C         
	MOV   C,A       
	SUB   E         
	PUSH  PSW       
	JP    L3C04H    
	CALL  L3D2DH    
	JNZ   L3C04H    
	PUSH  H         
	CALL  L2CF2H    
	LXI   H,FC18H   ; Start of FAC1 for single and double precision
	INR   M         
	POP   H         
L3C04H:	POP   PSW       
	PUSH  B         
	PUSH  PSW       
	JM    L3C0BH    
	XRA   A         
L3C0BH:	CMA             
	INR   A         
	ADD   B         
	INR   A         
	ADD   D         
	MOV   B,A       
	MVI   C,00H     
	CZ    L3C70H    
	CALL  L3C97H    
	POP   PSW       
	CP    L3C4DH    
	CALL  L3C83H    ; Format output with ',' and '.' based on digit count
	POP   B         
	POP   PSW       
	JNZ   L3C31H    
	CALL  L383CH    
	MOV   A,M       
	CPI   2EH       
	CNZ   L3457H    ; Increment HL and return
	SHLD  FBA8H     
L3C31H:	POP   PSW       
	LDA   FC18H     ; Start of FAC1 for single and double precision
	JZ    L3C3BH    
	ADD   E         
	SUB   B         
	SUB   D         
L3C3BH:	PUSH  B         
	CALL  L3AA8H    
	XCHG            
	POP   D         
	JMP   L3AEFH    
	
L3C44H:	ORA   A         
L3C45H:	RZ              
	DCR   A         
	MVI   M,30H     ; Store a '0'
	INX   H         ; Increment output string pointer
	JMP   L3C45H    
	
L3C4DH:	JNZ   L3C54H    
L3C50H:	RZ              
	CALL  L3C83H    ; Format output with ',' and '.' based on digit count
L3C54H:	MVI   M,30H     ; Store a '0'
	INX   H         ; Increment output string pointer
	DCR   A         
	JMP   L3C50H    
	
L3C5BH:	MOV   A,E       
	ADD   D         
	INR   A         
	MOV   B,A       
	INR   A         
L3C60H:	SUI   03H       
	JNC   L3C60H    
	ADI   05H       
	MOV   C,A       
L3C68H:	LDA   FB8EH     
	ANI   40H       
	RNZ             
	MOV   C,A       
	RET             
	
L3C70H:	DCR   B         
	JP    L3C84H    
	SHLD  FBA8H     
	MVI   M,2EH     ; Store a '.'
L3C79H:	INX   H         
	MVI   M,30H     ; Store a '0'
	INR   B         
	MOV   C,B       
	JNZ   L3C79H    
	INX   H         
	RET             
	
L3C83H:	DCR   B         ; Decrement count of digits before '.'
L3C84H:	JNZ   L3C8FH    ; If not time for '.', go test for ','
L3C87H:	MVI   M,2EH     ; Store a '.'
	SHLD  FBA8H     
	INX   H         ; Increment the output string pointer
	MOV   C,B       ; Set comma counter to zero ... no more ','
	RET             
	
L3C8FH:	DCR   C         ; Decrement digit counter for ','
	RNZ             ; Return if not 3 digits yet
	MVI   M,2CH     ; Store a ','
	INX   H         ; Increment pointer to output string
	MVI   C,03H     ; Reload digit counter for next ','
	RET             
	
L3C97H:	PUSH  D         
	PUSH  H         
	PUSH  B         
	CALL  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
	MOV   A,B       
	POP   B         
	POP   H         
	LXI   D,FC19H   ; Point to BCD portion of FAC1
	STC             
L3CA4H:	PUSH  PSW       
	CALL  L3C83H    ; Format output with ',' and '.' based on digit count
	LDAX  D         
	JNC   L3CB3H    
	RAR             
	RAR             
	RAR             
	RAR             
	JMP   L3CB4H    
	
L3CB3H:	INX   D         
L3CB4H:	ANI   0FH       
	ADI   30H       
	MOV   M,A       
	INX   H         
	POP   PSW       
	DCR   A         
	CMC             
	JNZ   L3CA4H    
	JMP   L3CF4H    
	
L3CC3H:	PUSH  D         
	LXI   D,L3CFAH  ; Load pointer to Power of 10 table
	MVI   A,05H     ; Five entries in power of 10 table
L3CC9H:	CALL  L3C83H    ; Format output with ',' and '.' based on digit count
	PUSH  B         
	PUSH  PSW       ; Save power of 10 value counter to stack
	PUSH  H         
	XCHG            ; HL has power of 10 table pointer
	MOV   C,M       ; Load LSB of next power of 10 value
	INX   H         ; Point to MSB of power of 10 value
	MOV   B,M       ; Load MSB of next power of 10 value
	PUSH  B         ; Save power of 10 value on stack
	INX   H         ; Increment power of 10 table pointer
	XTHL            ; Extrace power of 10 value from stack
	XCHG            ; Put power of 10 value in DE
	LHLD  FC1AH     ; Start of FAC1 for integers
	MVI   B,2FH     ; Start with ASCII '0' minus 1
L3CDCH:	INR   B         ; Increment ASCII value
	MOV   A,L       ; Prepare to subtract HL - DE
	SUB   E         ; Subtract LSB
	MOV   L,A       ; Save it in HL
	MOV   A,H       ; Get MSB
	SBB   D         ; Subtract with borrow MSB
	MOV   H,A       ; Save it back
	JNC   L3CDCH    ; Loop until borrow occurs
	DAD   D         ; Add power of 10 back in for last loop
	SHLD  FC1AH     ; Start of FAC1 for integers
	POP   D         
	POP   H         ; Get pointer to output
	MOV   M,B       ; Save the calculated ASCII value
	INX   H         ; Increment pointer to output string
	POP   PSW       ; Get power of 10 value loop counter from stack
	POP   B         
	DCR   A         ; Decrement power of 10 value counter
	JNZ   L3CC9H    ; Jump to process all 5 powe of 10 values
L3CF4H:	CALL  L3C83H    ; Format output with ',' and '.' based on digit count
	MOV   M,A       
	POP   D         
	RET             
	
L3CFAH:	ASHR            ; 10000, 1000
	DAA             
	RPE             
	INX   B         
	MOV   H,H       ; 100, 10
	NOP             
	LDAX  B         
	NOP             
	LXI   B,EF00H   ; 1
	LXI   H,FC1FH   ; Point to end of FAC1
	MVI   B,0EH     ; Size of double is 14 bytes
	RNC             ; Return if double precision
	LXI   H,FC1BH   ; Point to end of single precision
	MVI   B,06H     ; Size of single is 6 bytes
	RET             
	
	
; ======================================================
; Initialize FAC1 with 0.0 if it has no value
; ======================================================
L3D11H:	STA   FB8EH     
	PUSH  PSW       
	PUSH  B         
	PUSH  D         
	CALL  L35BAH    ; CDBL function
	LXI   H,L327EH  
	LDA   FC18H     ; Start of FAC1 for single and double precision
	ANA   A         
	CZ    L31C4H    ; Move floating point number M to FAC1
	POP   D         
	POP   B         
	POP   PSW       
	LXI   H,FBE8H   
	MVI   M,20H     
	RET             
	
L3D2DH:	PUSH  H         
	PUSH  D         
	PUSH  B         
	PUSH  PSW       
	CMA             
	INR   A         
	MOV   E,A       
	MVI   A,01H     
	JZ    L3D4FH    
	CALL  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
	PUSH  H         
L3D3DH:	CALL  L2CF2H    
	DCR   E         
	JNZ   L3D3DH    
	POP   H         
	INX   H         
	MOV   A,B       
	RRC             
	MOV   B,A       
	CALL  L2C2CH    
	CALL  L3D67H    
L3D4FH:	POP   B         
	ADD   B         
	POP   B         
	POP   D         
	POP   H         
	RET             
	
L3D55H:	PUSH  B         
	PUSH  H         
	CALL  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
	LDA   FC18H     ; Start of FAC1 for single and double precision
	SUI   40H       
	SUB   B         
	STA   FC18H     ; Start of FAC1 for single and double precision
	POP   H         
	POP   B         
	ORA   A         
	RET             
	
L3D67H:	PUSH  B         
	CALL  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
L3D6BH:	MOV   A,M       
	ANI   0FH       
	JNZ   L3D7CH    
	DCR   B         
	MOV   A,M       
	ORA   A         
	JNZ   L3D7CH    
	DCX   H         
	DCR   B         
	JNZ   L3D6BH    
L3D7CH:	MOV   A,B       
	POP   B         
	RET             
	
	
; ======================================================
; Single precision exponential function
; ======================================================
	CALL  L3827H    ; Single precision load (FAC2=BCDE)
	CALL  L35C2H    ; Convert FAC11 to double precision
	CALL  L322EH    ; Push FAC2 on stack
	CALL  L31D2H    ; Swap FAC1 with Floating Point number on stack
	CALL  L3245H    ; Pop FAC2 from stack
	
; ======================================================
; Double precision exponential function
; ======================================================
	LDA   FC69H     ; Start of FAC2 for single and double precision
	ORA   A         
	JZ    L3DFCH    
	MOV   H,A       
	LDA   FC18H     ; Start of FAC1 for single and double precision
	ORA   A         
	JZ    L3E07H    
	CALL  L3234H    ; Push FAC1 on stack
	CALL  L3EDCH    
	JC    L3DE2H    
	XCHG            
	SHLD  FB90H     
	CALL  L35CFH    ; Set type of last variable to DBL
	CALL  L3245H    ; Pop FAC2 from stack
	CALL  L3EDCH    
	CALL  L35CFH    ; Set type of last variable to DBL
	LHLD  FB90H     
	JNC   L3E15H    
	LDA   FC69H     ; Start of FAC2 for single and double precision
	PUSH  PSW       
	PUSH  H         
	CALL  L31C1H    ; Move FAC2 to FAC1
	LXI   H,FBE7H   ; Floating Point Temp 1
	CALL  L31CAH    ; Move FAC1 to M
	LXI   H,L3286H  ; Load pointer to FP 1.000000000
	CALL  L31C4H    ; Move floating point number M to FAC1
	POP   H         
	MOV   A,H       
	ORA   A         
	PUSH  PSW       
	JP    L3DDEH    
	XRA   A         
	MOV   C,A       
	SUB   L         
	MOV   L,A       
	MOV   A,C       
	SUB   H         
	MOV   H,A       
L3DDEH:	PUSH  H         
	JMP   L3E53H    
	
L3DE2H:	CALL  L35CFH    ; Set type of last variable to DBL
	CALL  L31C1H    ; Move FAC2 to FAC1
	CALL  L31D2H    ; Swap FAC1 with Floating Point number on stack
	CALL  L2FCFH    ; LOG function
	CALL  L3245H    ; Pop FAC2 from stack
	CALL  L2CFFH    ; Double precision multiply (FAC1=FAC1*FAC2)
	JMP   L30A4H    ; EXP function
	
	
; ======================================================
; Integer exponential function
; ======================================================
	MOV   A,H       ; Prepare to test for zero
	ORA   L         ; OR in LSB to test for zero
	JNZ   L3E02H    ; Jump if not zero to calc exp
L3DFCH:	LXI   H,L0001H  ; Set result equal to 1
	JMP   L3E12H    ; Jump to set the result
	
L3E02H:	MOV   A,D       ; Test value for zero
	ORA   E         
	JNZ   L3E15H    ; Jump if not zero
L3E07H:	MOV   A,H       ; Get MSB of exponent
	RAL             ; Test for negative
	JNC   L3E0FH    ; Jump to set result to zero if not negative
	JMP   L0449H    ; Generate /0 error
	
L3E0FH:	LXI   H,0000H  ; Zero ^ some positive value = 0
L3E12H:	JMP   L3510H    ; Load signed integer in HL to FAC1
	
L3E15H:	SHLD  FB90H     
	PUSH  D         
	MOV   A,H       
	ORA   A         
	PUSH  PSW       
	CM    L37C6H    
	MOV   B,H       
	MOV   C,L       
	LXI   H,L0001H  
L3E24H:	ORA   A         
	MOV   A,B       
	RAR             
	MOV   B,A       
	MOV   A,C       
	RAR             
	MOV   C,A       
	JNC   L3E34H    
	CALL  L3ECFH    
	JNZ   L3E85H    
L3E34H:	MOV   A,B       
	ORA   C         
	JZ    L3E9EH    
	PUSH  H         
	MOV   H,D       
	MOV   L,E       
	CALL  L3ECFH    
	XCHG            
	POP   H         
	JZ    L3E24H    
	PUSH  B         
	PUSH  H         
	LXI   H,FBE7H   ; Floating Point Temp 1
	CALL  L31CAH    ; Move FAC1 to M
	POP   H         
	CALL  L3543H    ; Convert signed integer HL to single precision FAC1
	CALL  L35C2H    ; Convert FAC11 to double precision
L3E53H:	POP   B         
	MOV   A,B       
	ORA   A         
	RAR             
	MOV   B,A       
	MOV   A,C       
	RAR             
	MOV   C,A       
	JNC   L3E66H    
	PUSH  B         
	LXI   H,FBE7H   ; Floating Point Temp 1
	CALL  L31A3H    ; Double precision math (FAC1=M * FAC2))
	POP   B         
L3E66H:	MOV   A,B       
	ORA   C         
	JZ    L3E9EH    
	PUSH  B         
	CALL  L3234H    ; Push FAC1 on stack
	LXI   H,FBE7H   ; Floating Point Temp 1
	PUSH  H         
	CALL  L31C4H    ; Move floating point number M to FAC1
	POP   H         
	PUSH  H         
	CALL  L31A3H    ; Double precision math (FAC1=M * FAC2))
	POP   H         
	CALL  L31CAH    ; Move FAC1 to M
	CALL  L324BH    ; Pop FAC1 from stack
	JMP   L3E53H    
	
L3E85H:	PUSH  B         
	PUSH  D         
	CALL  L7FF4H    
	POP   H         
	CALL  L3543H    ; Convert signed integer HL to single precision FAC1
	CALL  L35C2H    ; Convert FAC11 to double precision
	LXI   H,FBE7H   ; Floating Point Temp 1
	CALL  L31CAH    ; Move FAC1 to M
	CALL  L31C1H    ; Move FAC2 to FAC1
	POP   B         
	JMP   L3E66H    
	
L3E9EH:	POP   PSW       
	POP   B         
	RP              
	LDA   FB65H     ; Type of last variable used
	CPI   02H       ; Test if last type was Integer
	JNZ   L3EB1H    
	PUSH  B         
	CALL  L3543H    ; Convert signed integer HL to single precision FAC1
	CALL  L35C2H    ; Convert FAC11 to double precision
	POP   B         
L3EB1H:	LDA   FC18H     ; Start of FAC1 for single and double precision
	ORA   A         
	JNZ   L3EC3H    
	LHLD  FB90H     
	ORA   H         
	RP              
	MOV   A,L       
	RRC             
	ANA   B         
	JMP   L0455H    ; Generate OV error
	
L3EC3H:	CALL  L31B5H    ; Move FAC1 to FAC2
	LXI   H,L3286H  ; Load pointer to FP 1.000000000
	CALL  L31C4H    ; Move floating point number M to FAC1
	JMP   L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	
L3ECFH:	PUSH  B         
	PUSH  D         
	CALL  L3725H    ; Signed integer muliply (FAC1=HL*DE)
	LDA   FB65H     ; Type of last variable used
	CPI   02H       ; Test if last type was integer
	POP   D         
	POP   B         
	RET             
	
L3EDCH:	CALL  L31C1H    ; Move FAC2 to FAC1
	CALL  L322EH    ; Push FAC2 on stack
	CALL  L3654H    ; INT function
	CALL  L3245H    ; Pop FAC2 from stack
	CALL  L34D2H    ; Double precision compare FAC1 with FAC2
	STC             
	RNZ             
	JMP   L35DEH    
	
L3EF0H:	CALL  L3F08H    ; Test HL against stack space for collision
L3EF3H:	PUSH  B         ; \
	XTHL            ; > Swap HL and BC
	POP   B         ; /
L3EF6H:	RST   3         ; Compare DE and HL
	MOV   A,M       ; Get next byte
	STAX  B         ; Save next byte
	RZ              ; Return if all bytes copied
	DCX   B         ; Decrement dest pointer
	DCX   H         ; Decrement src pointer
	JMP   L3EF6H    ; Jump to copy all bytes
	
L3EFFH:	PUSH  H         
	LHLD  FBB6H     ; Unused memory pointer
	MVI   B,00H     
	DAD   B         
	DAD   B         
	MVI   A,E5H     ; Makes pass-through code look like "MVI A,E5H"
	MVI   A,88H     
	SUB   L         
	MOV   L,A       
	MVI   A,FFH     
	SUB   H         
	MOV   H,A       
	JC    L3F17H    ; Reinit BASIC stack and generate OM error
	DAD   SP        
	POP   H         
	RC              
L3F17H:	CALL  L05F0H    ; Update line addresses for current BASIC program
	LHLD  VTPRAM    ; BASIC string buffer pointer
	DCX   H         
	DCX   H         
	SHLD  FB9DH     ; SP used by BASIC to reinitialize the stack
	LXI   D,L0007H  ; Prepare to generate OM Error
	JMP   L045DH    ; Generate error in E
	
	
; ======================================================
; Initialize BASIC Variables for new execution
; ======================================================
L3F28H:	LHLD  VBASPP    ; Start of BASIC program pointer
	DCX   H         
L3F2CH:	SHLD  FB99H     ; Address of last variable assigned
L3F2FH:	CALL  L4009H    ; Clear all COM), TIME), and KEY interrupt definitions
	MVI   B,1AH     
	LXI   H,FBBAH   ; DEF definition table
L3F37H:	MVI   M,08H     
	INX   H         
	DCR   B         
	JNZ   L3F37H    
	CALL  L3182H    ; Initialize FP_TEMP3 for new program
	XRA   A         
	STA   FBA7H     ; BASIC Program Running Flag
	MOV   L,A       
	MOV   H,A       
	SHLD  FBA5H     ; Address of ON ERROR routine
	SHLD  FBACH     ; Address where program stopped on last break), END), or STOP
	LHLD  FB67H     ; File buffer area pointer
	SHLD  FB8CH     ; Pointer to current location in BASIC string buffer
	CALL  L407FH    ; RESTORE statement
	LHLD  FBB2H     ; Start of variable data pointer
	SHLD  FBB4H     ; Start of array table pointer
	SHLD  FBB6H     ; Unused memory pointer
	CALL  L4E22H    
	LDA   FCA7H     
	ANI   01H       
	JNZ   L3F6DH    ; Initialize BASIC for new execution
	STA   FCA7H     
L3F6DH:	POP   B         
	LHLD  VTPRAM    ; BASIC string buffer pointer
	DCX   H         
	DCX   H         
	SHLD  FB9DH     ; SP used by BASIC to reinitialize the stack
	INX   H         
	INX   H         
L3F78H:	SPHL            ; Re-initialize stack location
	LXI   H,FB6BH   
	SHLD  FB69H     
	CALL  ROTLCD    ; Reinitialize output back to LCD
	CALL  L0C39H    ; Call routine to terminate running BASIC?
	XRA   A         
	MOV   H,A       
	MOV   L,A       
	SHLD  FBD6H     
	STA   FBE1H     
	SHLD  FBDBH     
	SHLD  FBE4H     
	SHLD  FBD4H     
	STA   FB96H     ; FOR/NEXT loop active flag
	PUSH  H         
	PUSH  B         
L3F9CH:	LHLD  FB99H     ; Address of last variable assigned
	RET             
	
	
; ======================================================
; TIME$ ON statement
; ======================================================
L3FA0H:	DI              
	MOV   A,M       
	ANI   04H       
	ORI   01H       
	CMP   M         
	MOV   M,A       
	JZ    L3FB0H    
	ANI   04H       
	JNZ   L3FE8H    
L3FB0H:	EI              
	RET             
	
	
; ======================================================
; TIME$ OFF statement
; ======================================================
L3FB2H:	DI              
	MOV   A,M       
	MVI   M,00H     
	JMP   L3FC0H    
	
	
; ======================================================
; TIME$ STOP statement
; ======================================================
L3FB9H:	DI              
	MOV   A,M       
	PUSH  PSW       
	ORI   02H       
	MOV   M,A       
	POP   PSW       
L3FC0H:	XRI   05H       
	JZ    L3FFCH    
	EI              
	RET             
	
L3FC7H:	DI              
	MOV   A,M       
	ANI   05H       
	CMP   M         
	MOV   M,A       
	JNZ   L3FE1H    
	EI              
	RET             
	
	
; ======================================================
; Trigger interrupt.  HL points to interrupt table
; ======================================================
L3FD2H:	DI              ; Disable interrupts
	MOV   A,M       ; Load trigger control for this interrupt
	ANI   01H       ; Test if interrupt needs to be triggered maybe?
	JZ    L3FE6H    ; Jump if source hasn't issued a trigger
	MOV   A,M       ; Load trigger control again
	ORI   04H       ; Prepare to test if interrupt already counted
	CMP   M         ; Test if interrupt already reported / counted
	JZ    L3FE6H    ; Jump to return if interrupt already reported
	MOV   M,A       ; Mark interrupt as counted
L3FE1H:	XRI   05H       ; Validate the interrupt should be counted
	JZ    L3FE8H    ; Jump to increment the interrupt count
L3FE6H:	EI              ; Re-enable interrupts
	RET             
	
L3FE8H:	LDA   F654H     ; Load current pending interrupt count
	INR   A         ; Increment
	STA   F654H     ; Save new pending interrupt count
	EI              ; Re-enable interrupts
	RET             
	
	
; ======================================================
; Clear interrupt.  HL points to interrupt table
; ======================================================
L3FF1H:	DI              ; Disable interrupts for protection
	MOV   A,M       ; Get interrupt control register
	ANI   03H       ; Clear bit indicating interrupt reported as "pending"
	CMP   M         ; Test if interrupt had been reported as "pending"
	MOV   M,A       ; Mark interrupt as not pending
	JNZ   L3FFCH    ; Jump if interrupt previously marked as pending to decrement count
L3FFAH:	EI              ; Re-enable interrupts
	RET             
	
L3FFCH:	LDA   F654H     ; Load pending interrupt count
	SUI   01H       ; Decrement the count
	JC    L3FFAH    ; Skip save if count was already zero
	STA   F654H     ; Save new pending interrupt count
	EI              ; Re-enable interrupts
L4008H:	RET             
	
	
; ======================================================
; Clear all COM), TIME), and KEY interrupt definitions
; ======================================================
L4009H:	LXI   H,F944H   ; On Com flag
	MVI   B,0AH     
	XRA   A         
L400FH:	MOV   M,A       
	INX   H         
	MOV   M,A       
	INX   H         
	MOV   M,A       
	INX   H         
	DCR   B         
	JNZ   L400FH    
	LXI   H,F630H   ; Function key status table (1 = on)
	MVI   B,08H     
L401EH:	MOV   M,A       
	INX   H         
	DCR   B         
	JNZ   L401EH    
	STA   F654H     
	RET             
	
L4028H:	MVI   B,02H     ; Mark entry from ON COM
	LXI   D,L0106H  ; Make "MVI B,01H" look like "LXI D,0106H"
	LDA   FBA7H     ; BASIC Program Running Flag
	ORA   A         ; Test if BASIC runnin
	RNZ             ; Return if BASIC program not running
	PUSH  H         ; Preserve HL on stack
	LHLD  F67AH     ; Current executing line number
	MOV   A,H       ; Get line number MSB
	ANA   L         ; and with line number LSB
	INR   A         ; Test if line number = 0xFFFF
	JZ    L4052H    ; Jump to exit if line number = 0xFFFF
	DCR   B         ; Test for entry from ON COM
	JNZ   L4075H    ; Jump if entered from ON COM
	LXI   H,F947H   ; On Time flag
	MVI   B,09H     ; Loop for 9 ON-TIME, ON-KEY, etc. interrupts
L4045H:	MOV   A,M       ; Get the ON-XXX flag
	CPI   05H       ; Test if Interrupt triggered by this event F1, F2, TIME$, etc.
	JZ    L4054H    ; Jump to process ON-XXX interrupt
L404BH:	INX   H         ; Skip ON-XXX flag
	INX   H         ; Skip ON-XXX line number LSB
	INX   H         ; SKip ON-XXX line number MSB
	DCR   B         ; Decrement number of ON-XXX events checked
	JNZ   L4045H    ; Jump to process next ON-XXX interrupt?
L4052H:	POP   H         ; Restore HL from stack
	RET             
	
L4054H:	PUSH  B         ; Save the ON-XXX index number
	INX   H         ; Skip to the BASIC line number LSB
	MOV   E,M       ; Read the BASIC line number LSB
	INX   H         ; Skip to the MSB
	MOV   D,M       ; Read the BASIC line number MSB
	DCX   H         ; Restore HL back to ON-XXX flag
	DCX   H         ; "
	MOV   A,D       ; Prepare to test if the ON-XXX line = 0
	ORA   E         ; OR in the MSB of the line
	POP   B         ; Restore the stack frame
	JZ    L404BH    ; SKip processing if line number = 0
	PUSH  D         ; Preserve DE on Stack
	PUSH  H         ; Preserve HL on Stack
	CALL  L3FF1H    ; Clear interrupt. HL points to interrupt table
	CALL  L3FB9H    ; TIME$ STOP statement
	MVI   C,03H     ; Prepare to validate 6 bytes free in Unused memory
	CALL  L3EFFH    ; Validate 6 bytes free from stack space
	POP   B         ; POP H from stack. We don't really need to keep this one
	POP   D         ; Restore DE from stack
	POP   H         ; Restore HL from stack
	POP   PSW       
	JMP   L0952H    
	
L4075H:	LXI   H,F944H   ; On Com flag
	MOV   A,M       ; Get COM flag
	DCR   A         ; Decrement to test for 1
	JZ    L4054H    ; If 1, jump to process interrupt
	POP   H         ; Restore HL from stack
	RET             
	
	
; ======================================================
; RESTORE statement
; ======================================================
L407FH:	XCHG            
L4080H:	LHLD  VBASPP    ; Start of BASIC program pointer
	JZ    L4094H    
	XCHG            
	CALL  L08EBH    ; Convert ASCII number at M to binary
	PUSH  H         
	CALL  L0628H    ; Find line number in DE
	MOV   H,B       
	MOV   L,C       
	POP   D         
	JNC   L094DH    ; Generate UL error
L4094H:	DCX   H         
L4095H:	SHLD  FBB8H     ; Address where DATA search will begin next
	XCHG            
	RET             
	
	
; ======================================================
; STOP statement
; ======================================================
L409AH:	RNZ             
	INR   A         
	JMP   L40A9H    
	
	
; ======================================================
; END statement
; ======================================================
L409FH:	RNZ             
	XRA   A         
	STA   FBA7H     ; BASIC Program Running Flag
	PUSH  PSW       
	CZ    L4E22H    
	POP   PSW       
L40A9H:	SHLD  FB9BH     ; Most recent or currenly running line pointer
	LXI   H,FB6BH   
	SHLD  FB69H     
	LXI   H,FFF6H   
	POP   B         
L40B6H:	LHLD  F67AH     ; Current executing line number
	PUSH  H         
	PUSH  PSW       
	MOV   A,L       
	ANA   H         
	INR   A         
	JZ    L40CAH    
	SHLD  FBAAH     ; Line where break), END), or STOP occurred
	LHLD  FB9BH     ; Most recent or currenly running line pointer
	SHLD  FBACH     ; Address where program stopped on last break), END), or STOP
L40CAH:	CALL  ROTLCD    ; Reinitialize output back to LCD
	CALL  L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	POP   PSW       
	LXI   H,L03FBH  ; Load pointer to "Break" text
	JNZ   L04F6H    
	JMP   L0501H    ; Pop stack and vector to BASIC ready
	
	
; ======================================================
; CONT sttement
; ======================================================
L40DAH:	LHLD  FBACH     ; Address where program stopped on last break), END), or STOP
	MOV   A,H       
	ORA   L         
	LXI   D,L0011H  ; Prepare to generate CN Error (Can't Continue)
	JZ    L045DH    ; Generate error in E
	XCHG            
	LHLD  FBAAH     ; Line where break), END), or STOP occurred
	SHLD  F67AH     ; Current executing line number
	XCHG            
	RET             
	
	JMP   L08DBH    ; Generate FC error
	
	
; ======================================================
; Check if M is alpha character
; ======================================================
L40F1H:	MOV   A,M       
	
; ======================================================
; Check if A is alpha character
; ======================================================
L40F2H:	CPI   41H       
	RC              
	CPI   5BH       
	CMC             
	RET             
	
	
; ======================================================
; CLEAR statement
; ======================================================
	PUSH  H         
	CALL  L2262H    
	POP   H         
	DCX   H         
	RST   2         ; Get next non-white char from M
	JZ    L3F2CH    ; Initialize BASIC Variables for new execution
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	00H             
	CALL  L08D7H    
	DCX   H         
	RST   2         ; Get next non-white char from M
	PUSH  H         
	LHLD  VHIMEM    ; HIMEM
	MOV   B,H       
	MOV   C,L       
	LHLD  FB67H     ; File buffer area pointer
	JZ    L4140H    
	POP   H         
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ',' character
	PUSH  D         
	CALL  L1297H    ; Evaluate expression at M
	DCX   H         
	RST   2         ; Get next non-white char from M
	JNZ   ERRSYN    ; Generate Syntax error
	XTHL            
	XCHG            
	MOV   A,H       
	ANA   A         
	JP    L08DBH    ; Generate FC error
	PUSH  D         
	LXI   D,F5F1H   
	RST   3         ; Compare DE and HL
	JNC   L08DBH    ; Generate FC error
	POP   D         
	PUSH  H         
	LXI   B,FEF5H   
	LDA   FC82H     ; Maxfiles
L4139H:	DAD   B         
	DCR   A         
	JP    L4139H    
	POP   B         
	DCX   H         
L4140H:	MOV   A,L       
	SUB   E         
L4142H:	MOV   E,A       
	MOV   A,H       
	SBB   D         
	MOV   D,A       
	JC    L3F17H    ; Reinit BASIC stack and generate OM error
	PUSH  H         
	LHLD  FBB2H     ; Start of variable data pointer
	PUSH  B         
	LXI   B,L00A0H  
	DAD   B         
	POP   B         
	RST   3         ; Compare DE and HL
	JNC   L3F17H    ; Reinit BASIC stack and generate OM error
	XCHG            
	SHLD  VTPRAM    ; BASIC string buffer pointer
	MOV   H,B       
	MOV   L,C       
	SHLD  VHIMEM    ; HIMEM
	POP   H         
	SHLD  FB67H     ; File buffer area pointer
	POP   H         
	CALL  L3F2CH    ; Initialize BASIC Variables for new execution
	LDA   FC82H     ; Maxfiles
	CALL  L7F2BH    ; Adjust SP location based on CLEAR parameters
	LHLD  FB99H     ; Address of last variable assigned
	JMP   L0804H    ; Execute BASIC program
	
	
; ======================================================
; NEXT statement
; ======================================================
	LXI   D,0000H  
L4177H:	CNZ   L4790H    ; Find address of variable at M
	SHLD  FB99H     ; Address of last variable assigned
	CALL  POPRET    ; Pop return address for NEXT or RETURN
	JNZ   L044CH    ; Generate NF error
	SPHL            
	PUSH  D         
	MOV   A,M       
	PUSH  PSW       
	INX   H         
	PUSH  D         
	MOV   A,M       
	INX   H         
	ORA   A         
	JM    L41BBH    
	DCR   A         
	JNZ   L4197H    
	LXI   B,L0008H  
	DAD   B         
L4197H:	ADI   04H       
	STA   FB65H     ; Type of last variable used
	CALL  L347EH    
	XCHG            
	XTHL            
	PUSH  H         
	RST   5         ; Determine type of last var used
	JNC   L41F6H    
	CALL  L3447H    ; Load single precision at M to BCDE
	CALL  L37F4H    ; Single precision addition (FAC1=FAC1+BCDE)
	POP   H         
	CALL  L3459H    ; Move single precision FAC1 to M
	POP   H         
	CALL  L3450H    ; Reverse load single precision at M to DEBC
	PUSH  H         
	CALL  L3498H    ; Compare single precision in BCDE with FAC1
	JMP   L41E4H    
	
L41BBH:	LXI   B,L000CH  
	DAD   B         
	MOV   C,M       
	INX   H         
	MOV   B,M       
	INX   H         
	XTHL            
	MOV   E,M       
	INX   H         
	MOV   D,M       
	PUSH  H         
	MOV   L,C       
	MOV   H,B       
	CALL  L3704H    ; Signed integer addition (FAC1=HL+DE)
	LDA   FB65H     ; Type of last variable used
	CPI   02H       ; Test if last type was integer
	JNZ   L0455H    ; Generate OV error
	XCHG            
	POP   H         
	MOV   M,D       
	DCX   H         
	MOV   M,E       
	POP   H         
	PUSH  D         
	MOV   E,M       
	INX   H         
	MOV   D,M       
	INX   H         
	XTHL            
	CALL  L34C2H    ; Compare signed integer in DE with that in HL
L41E4H:	POP   H         
	POP   B         
	SUB   B         
	CALL  L3450H    ; Reverse load single precision at M to DEBC
	JZ    L4208H    
	XCHG            
	SHLD  F67AH     ; Current executing line number
	MOV   L,C       
	MOV   H,B       
	JMP   L0800H    
	
L41F6H:	CALL  L2B75H    
	POP   H         
	CALL  L3487H    
	POP   H         
	CALL  L3461H    ; Move M to FAC2 using precision at (FB65H)
	PUSH  D         
	CALL  L34D2H    ; Double precision compare FAC1 with FAC2
	JMP   L41E4H    
	
L4208H:	SPHL            
	SHLD  FB9DH     ; SP used by BASIC to reinitialize the stack
	XCHG            
	LHLD  FB99H     ; Address of last variable assigned
	MOV   A,M       
	CPI   2CH       
	JNZ   L0804H    ; Execute BASIC program
	RST   2         ; Get next non-white char from M
	CALL  L4177H    
L421AH:	PUSH  H         
	LHLD  FC8CH     
	MOV   A,H       
	ORA   L         
	POP   H         
	RET             
	
	
; ======================================================
; L4222H: Generate a Carriage Return and Line Feed
; ======================================================
CRLF:	MVI  A,0DH      ; Send CR to screen or printer
    	RST  4          ; Send character in A to screen/printer
    	MVI  A,0AH      ; Send LF to screen or printer
    	RST  4          ; Send character in A to screen/printer
    	RET
	
	
; ======================================================
; L4229H: BEEP statement
; ======================================================
BEEP:	MVI  A,07H
    	RST  4          ; Send character in A to screen/printer
    	RET
	
	
; ======================================================
; L422DH: Move cursor to home position (1,1)
; ======================================================
HOME:	MVI  A,0BH
    	RST  4          ; Send character in A to screen/printer
    	RET
	
	
; ======================================================
; L4231H: Clears display
; ======================================================
CLS:	MVI  A,0CH
    	RST  4          ; Send character in A to screen/printer
    	RET
	
	
; ======================================================
; L4235H: Sets system line (lock line 8, LABEL)
; ======================================================
SETSYS:	MVI  A,54H     ; ESC T
    	JMP  ESCA      ; End escape sequence
	
	
; ======================================================
; L423AH: Reset system line (unlock line 8, LABEL)
; ======================================================
RSTSYS:	MVI  A,55H     ; ESC U
    	JMP  ESCA      ; End escape sequence
	
	
; ======================================================
; L423FH: Lock display (no scrolling)
; ======================================================
LOCK:	MVI  A,56H     ; ESC Y
    	JMP  ESCA      ; End escape sequence
	
	
; ======================================================
; L4244H: Unlock display (scrolling)
; ======================================================
UNLOCK:	MVI  A,57H     ; ESC W
    	JMP  ESCA      ; End escape sequence
	
	
; ======================================================
; L4249H: Turn on cursor
; ======================================================
CURSON:	MVI  A,50H     ; ESC P
    	JMP  ESCA      ; End escape sequence
	
	
; ======================================================
; L424EH: Turn off cursor
; ======================================================
CUROFF: MVI  A,51H     ; ESC Q
    	JMP  ESCA      ; End escape sequence
	
	
; ======================================================
; L4253H: Delete line at current cursor position
; ======================================================
DELLIN:	MVI  A,4DH     ; ESC M
    	JMP  ESCA      ; End escape sequence
	
	
; ======================================================
; L4258H: Insert a blank line at cursor position
; ======================================================
INSLIN:	MVI  A,4CH     ; ESC L
    	JMP  ESCA      ; End escape sequence
	
	
; ======================================================
; L425DH: Erase from cursor to end of line
; ======================================================
ERABOL:	MVI  A,4BH     ; ESC K
    	JMP  ESCA      ; End escape sequence
	
	
; ======================================================
; L4262H: Send ESC X
; Entry conditions: none
; Exit conditions:  none
; ======================================================
SDESCX:	MVI  A,58H     ; ESC X
    	JMP  ESCA      ; End escape sequence
L4267:	ORA  M
    	RZ
	
; ======================================================
; L4269H: Set Reverse character mode
; ======================================================
ENTREV:	MVI  A,70H     ; ESC p
    	JMP  ESCA      ; End escape sequence
	
	
; ======================================================
; L426EH: Turn off Reverse character mode
; ======================================================
EXTREF:	MVI  A,71H     ; ESC q
	
; ======================================================
; L4270H: Send specified Escape Code Sequence
; Entry conditions: A = escape code
; Exit conditions:  none
; ======================================================
ESCA:	PUSH PSW
    	MVI  A,1BH
    	RST  4          ; Send character in A to screen/printer
    	POP  PSW
    	RST  4          ; Send character in A to screen/printer
    	RET
	
	
; ======================================================
; Send cursor to lower left of CRT
; ======================================================
L4277H:	LHLD  VACTLC    ; Active rows count (1-8)
	MVI   H,01H     
	
; ======================================================
; L427CH: Set cursor position
; Entry conditions: H = column number (1-40)
;                   L = row number (1-8)
; Exit conditions:  none
; ======================================================
POSIT:	MVI  A,59H
    	CALL ESCA       ; End escape sequence
    	MOV  A,L
    	ADI  1FH
    	RST  4          ; Send character in A to screen/printer
    	MOV  A,H
    	ADI  1FH
    	RST  4          ; Send character in A to screen/printer
    	RET
	
	
; ======================================================
; L428AH Erase function key display
; Entry conditions: none
; Exit conditions: none
; ======================================================
ERAFNK:	LDA  VLABLF     ; Label line protect status
    	ANA  A
    	RZ
    	CALL RSTSYS     ; Unprotect line 8.  An ESC U is printed
    	LHLD VCURLN     ; Cursor row (1-8)
    	PUSH H
    	CALL L4277H     ; Send cursor to lower left of CRT
    	CALL ERABOL     ; Erase from cursor to end of line
    	POP  H
    	CALL POSIT      ; Set the current cursor position (H=Row),L=Col)
    	CALL SDESCX     ; Send ESC X
    	XRA  A
    	RET
	
	
; ======================================================
; L42A5H: Set and display function keys
; Entry conditions:
;           HL = Start address of function table
; Exit conditions: none
; ======================================================
STDSPF:	CALL STFNK      ; Set new function key table
	
; ======================================================
; L42A8H: Display function keys
; Entry conditions: none
; Exit conditions:  none
; ======================================================
DSPNFK:	LHLD VCURLN     ; Cursor row (1-8)
    	LDA  VACTLC     ; Active rows count (1-8)
    	CMP  L
    	JNZ  L42C0
    	PUSH H
    	CALL L45EDH
    	MVI  L,01H
    	CALL POSIT      ; Set the current cursor position (H=Row),L=Col)
    	CALL DELLIN     ; Delete current line on screen
    	POP  H
    	DCR  L
L42C0:	PUSH H
    	CALL RSTSYS     ; Unprotect line 8.  An ESC U is printed
    	CALL L4277H     ; Send cursor to lower left of CRT
    	LXI  H,F789H    ; Function key definition area
    	MVI  E,08H
    	LDA  VRVIDF     ; Reverse video switch
    	PUSH PSW
    	CALL EXTREF     ; Cancel inverse character mode
L42D3:	LDA  VACTCC     ; Active columns count (1-40)
    	CPI  28H
    	LXI  B,L040CH
    	JZ   L42E1
    	LXI  B,L0907H
L42E1:	PUSH H
    	LXI  H,FAC3H
    	MOV  A,E
    	SUI  06H
    	JZ   L42ED
    	DCR  A
    	DCX  H
L42ED:	CZ   L4267
    	POP  H
    	CALL L1BE0H     ; Send B characters from M to the screen
    	DAD  B
    	CALL EXTREF     ; Cancel inverse character mode
    	DCR  E
    	CNZ  L001EH     ; Send a space to screen/printer
    	JNZ  L42D3
    	CALL ERABOL     ; Erase from cursor to end of line
    	CALL SETSYS     ; Protect line 8.  An ESC T is printed
    	POP  PSW
    	ANA  A
    	CNZ  ENTREV     ; Start inverse character mode
    	POP  H
    	CALL POSIT      ; Set the current cursor position (H=Row),L=Col)
    	CALL SDESCX     ; Send ESC X
    	XRA  A
    	RET
	
	
; ======================================================
; Print A to the screen
; ======================================================
L4313H:	PUSH  H         ; Preserve registers on stack
	PUSH  D         
	PUSH  B         
	PUSH  PSW       
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	08H             
	CALL  L431FH    ; RST 7 returned to us. Print to the LCD.
	JMP   L14EDH    ; Pop AF), BC), DE), HL from stack
	
L431FH:	MOV   C,A       ; Save value to PLOT to LCD to C
	XRA   A         ; Clear A to indicate POP of PSW not required
	STA   FAC7H     ; Indicate POP of PSW not required
	LDA   F638H     ; New Console device flag
	ANA   A         ; Test if new console flag set
	JNZ   L434AH    ; Jump if New Console flag set
	CALL  L4335H    ; Character plotting level 4. Turn off background task & call level 5
	LHLD  VCURLN    ; Cursor row (1-8)
	SHLD  F640H     ; Cursor row (1-8)
	RET             
	
	
; ======================================================
; Character plotting level 4. Turn off background task & call level 5
; ======================================================
L4335H:	CALL  L73C5H    ; Turn off background task, blink & reinitialize cursor blink time
	CALL  L434CH    ; Character plotting level 5. Handle ESC sequences & call level 6
L433BH:	LHLD  VCURLN    ; Cursor row (1-8)
	XCHG            
	CALL  SETCUR    ; Disable Automatic Scrolling
	LDA   F63FH     ; Cursor status (0 = off)
	ANA   A         ; Test if cursor is off
	RZ              ; Return if cursor off
	JMP   L73D9H    ; Initialize Cursor Blink to start blinking
	
L434AH:	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	3CH             
	
; ======================================================
; Character plotting level 5. Handle ESC sequences & call level 6
; ======================================================
L434CH:	LXI   H,F646H   ; ESC mode flag for RST 20H
L434FH:	MOV   A,M       
	ANA   A         
	JNZ   L43FAH    ; ESCape sequence driver
	MOV   A,C       
	LHLD  VCURLN    ; Cursor row (1-8)
	CPI   09H       
	JZ    L4480H    ; Tab routine
	CPI   7FH       ; Test for DEL
	JZ    L451FH    ; Jump to handle DEL
	CPI   20H       
	JC    L4373H    ; LCD output driver
	CALL  L4560H    ; Character plotting level 6. Save character in C to LCD RAM & call level 7
	CALL  L4453H    ; ESC C routine (move cursor right)
	RNZ             
	MVI   H,01H     
	JMP   L4494H    ; Linefeed routine
	
	
; ======================================================
; LCD output driver
; ======================================================
L4373H:	LXI   H,L4388H  ; Point to LCD code handler table
	MVI   C,08H     ; Indicate 8 entries in table
	
; ======================================================
; Key table handler function processing routine
; ======================================================
L4378H:	INX   H         ; Skip entry handler address
	INX   H         ; Skip handler address MSB
	DCR   C         ; Decrement entry counter
	RM              ; Return if entry not found in table
	CMP   M         ; Test if this entry matches
	INX   H         ; Skip the key value
	JNZ   L4378H    ; If no match, jump to test next entry
	MOV   A,M       ; Get LSB of handler address
	INX   H         ; Point to handler address MSB
	MOV   H,M       ; Get handler MSB
	MOV   L,A       ; Copy handler LSB to L
	PUSH  H         ; Push the key handler address on stack
	LHLD  VCURLN    ; Cursor row (1-8)
	RET             ; "RETurn" to the key handler address
	
	
; ======================================================
; RST 20H lookup table
; ======================================================
    DB	07H             
	DW	7662H          ; Beep routine
    DB	08H             
	DW	4461H          ; Backspace routine
    DB	09H             
	DW	4480H          ; Tab routine
    DB	0AH             
	DW	4494H          ; Linefeed routine
    DB	0BH             
	DW	44A8H          ; Vertical tab and ESC H routine (home cursor)
    DB	0CH             
	DW	4548H          ; Form Feed (0CH), CLS, ESC E, and ESC J routine
    DB	0DH             
	DW	44AAH          ; CR routine
    DB	1BH             
	DW	43B2H          ; LCD output Escape routine
L43A2H:	LDA   FAC7H     ; Get value at FAC7H
	ANA   A         ; Test if zero
	RZ              ; Return if zero (No POP needed)
	POP   PSW       ; POP PSW from stack
	RET             
	
L43A9H:	LDA   VLABLF    ; Label line protect status
	ADI   08H       
	RET             
	
	
; ======================================================
; ESC Y routine (Set cursor position)
; ======================================================
L43AFH:	MVI   A,02H     
	LXI   B,AF3EH   
	STA   F646H     ; ESC mode flag for RST 20H
	RET             
	
	
; ======================================================
; LCD Escape sequence lookup table
; ======================================================
    DB	'j'             
	DW	4548H          ; Form Feed (0CH), CLS, ESC E, and ESC J routine
    DB	'E'             
	DW	4548H          ; Form Feed (0CH), CLS, ESC E, and ESC J routine
    DB	'K'             
	DW	4537H          
    DB	'J'             
	DW	454EH          
    DB	'l'             
	DW	4535H          
    DB	'L'             
	DW	44EAH          
    DB	'M'             
	DW	44C4H          
    DB	'Y'             
	DW	43AFH          
    DB	'A'             
	DW	4469H          
    DB	'B'             
	DW	446EH          
    DB	'C'             
	DW	4453H          
    DB	'D'             
	DW	445CH          
    DB	'H'             
	DW	44A8H          ; Vertical tab and ESC H routine (home cursor)
    DB	'p'             
	DW	4431H          
    DB	'q'             
	DW	4432H          
    DB	'P'             
	DW	44AFH          
    DB	'Q'             
	DW	44BAH          
    DB	'T'             
	DW	4439H          
    DB	'U'             
	DW	4437H          
    DB	'V'             
	DW	443FH          
    DB	'W'             
	DW	4440H          
    DB	'X'             
	DW	444AH          
	
; ======================================================
; ESCape sequence driver
; ======================================================
L43FAH:	MOV   A,C       
	CPI   1BH       
	MOV   A,M       
	JZ    L4445H    
	ANA   A         
	JP    L4411H    
	CALL  L43B3H    
	MOV   A,C       
	LXI   H,L43B6H  ; Load pointer to key vector table
	MVI   C,16H     ; 16 entries in table
	JMP   L4378H    ; Key Vector table lookup
	
L4411H:	DCR   A         
	STA   F646H     ; ESC mode flag for RST 20H
	LDA   VACTCC    ; Active columns count (1-40)
	LXI   D,VCURCL  ; Cursor column (1-40)
	JZ    L4426H    
	LDA   VACTLC    ; Active rows count (1-8)
	LXI   H,VLABLF  ; Label line protect status
	ADD   M         
	DCX   D         
L4426H:	MOV   B,A       
	MOV   A,C       
	SUI   20H       
	CMP   B         
	INR   A         
	STAX  D         
	RC              
	MOV   A,B       
	STAX  D         
	RET             
	
	
; ======================================================
; ESC p routine (start inverse video)
; ======================================================
L4431H:	ORI   AFH       
	STA   VRVIDF    ; Reverse video switch
	RET             
	
	
; ======================================================
; ESC U routine (unprotect line 8)
; ======================================================
L4437H:	XRA   A         
	JNZ   FF3EH     
	STA   VLABLF    ; Label line protect status
	RET             
	
	
; ======================================================
; ESC V routine (stop automatic scrolling)
; ======================================================
L443FH:	ORI   AFH       
	STA   F63EH     ; Scroll disable flag
	RET             
	
L4445H:	INX   H         
	MOV   M,A       
	JMP   L43B2H    ; LCD output Escape routine
	
L444AH:	LXI   H,F647H   
	MOV   A,M       
	MVI   M,00H     
	DCX   H         
	MOV   M,A       
	RET             
	
	
; ======================================================
; ESC C routine (move cursor right)
; ======================================================
L4453H:	LDA   VACTCC    ; Active columns count (1-40)
	CMP   H         
	RZ              
	INR   H         
	JMP   L4477H    
	
	
; ======================================================
; ESC D routine (move cursor left)
; ======================================================
L445CH:	DCR   H         
	RZ              
	JMP   L4477H    
	
	
; ======================================================
; Backspace routine
; ======================================================
L4461H:	CALL  L445CH    ; ESC D routine (move cursor left)
	RNZ             
	LDA   VACTCC    ; Active columns count (1-40)
	MOV   H,A       
	
; ======================================================
; ESC A routine (move cursor up)
; ======================================================
L4469H:	DCR   L         
	RZ              
	JMP   L4477H    
	
	
; ======================================================
; ESC B routine (move cursor down)
; ======================================================
L446EH:	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	CMP   L         
	RZ              
	JC    L447BH    
	INR   L         
L4477H:	SHLD  VCURLN    ; Cursor row (1-8)
	RET             
	
L447BH:	DCR   L         
	XRA   A         
	JMP   L4477H    
	
	
; ======================================================
; Tab routine
; ======================================================
L4480H:	LDA   VCURCL    ; Cursor column (1-40)
	PUSH  PSW       
	MVI   A,20H     
	RST   4         ; Send character in A to screen/printer
	POP   B         
	LDA   VCURCL    ; Cursor column (1-40)
	CMP   B         
	RZ              
	DCR   A         
	ANI   07H       
	JNZ   L4480H    ; Tab routine
	RET             
	
	
; ======================================================
; Linefeed routine
; ======================================================
L4494H:	CALL  L446EH    ; ESC B routine (move cursor down)
	RNZ             
	LDA   F63EH     ; Scroll disable flag
	ANA   A         
	RNZ             
	CALL  L4477H    
	CALL  L45EDH    
	MVI   L,01H     
	JMP   L44C7H    
	
	
; ======================================================
; Verticle tab and ESC H routine (home cursor)
; ======================================================
L44A8H:	MVI   L,01H     ; Set ROW to 1 (TOP)
	
; ======================================================
; CR routine
; ======================================================
L44AAH:	MVI   H,01H     ; Set COL to 1 (Left)
	JMP   L4477H    ; Jump to set new ROW,COL
	
	
; ======================================================
; ESC P routine (turn cursor on)
; ======================================================
L44AFH:	MVI   A,01H     
	STA   F63FH     ; Cursor status (0 = off)
	CALL  L43A2H    ; Conditionally POP PSW from stack based on value at FAC7H
	JMP   L73D9H    ; Initialize Cursor Blink to start blinking
	
	
; ======================================================
; ESC Q routine (turn cursor off)
; ======================================================
L44BAH:	XRA   A         
	STA   F63FH     ; Cursor status (0 = off)
	CALL  L43A2H    ; Conditionally POP PSW from stack based on value at FAC7H
	JMP   L73C5H    ; Turn off background task, blink & reinitialize cursor blink time
	
	
; ======================================================
; ESC M routine
; ======================================================
L44C4H:	CALL  L44AAH    ; CR routine
L44C7H:	CALL  L43A2H    ; Conditionally POP PSW from stack based on value at FAC7H
	CALL  L43A9H    
	SUB   L         
	RC              
	JZ    L4535H    ; ESC l routine (erase current line)
	
; ======================================================
; Scroll LCD screen A times at line number in L
; ======================================================
L44D2H:	PUSH  PSW       
	MVI   H,28H     
L44D5H:	INR   L         
	CALL  L4512H    ; Get character at (H),L) from LCD RAM)
	DCR   L         
	CALL  L4566H    
	DCR   H         
	JNZ   L44D5H    
	INR   L         
	POP   PSW       
	DCR   A         
	JNZ   L44D2H    ; Scroll LCD screen A times at line number in L
	JMP   L4535H    ; ESC l routine (erase current line)
	
	
; ======================================================
; ESC L routine (insert line)
; ======================================================
L44EAH:	CALL  L44AAH    ; CR routine
	CALL  L43A2H    ; Conditionally POP PSW from stack based on value at FAC7H
	CALL  L43A9H    
	MOV   H,A       
	SUB   L         
	RC              
	JZ    L4535H    ; ESC l routine (erase current line)
	MOV   L,H       
L44FAH:	PUSH  PSW       
	MVI   H,28H     
L44FDH:	DCR   L         
	CALL  L4512H    ; Get character at (H),L) from LCD RAM)
	INR   L         
	CALL  L4566H    
	DCR   H         
	JNZ   L44FDH    
	DCR   L         
	POP   PSW       
	DCR   A         
	JNZ   L44FAH    
	JMP   L4535H    ; ESC l routine (erase current line)
	
	
; ======================================================
; Get character at (H),L) from LCD RAM)
; ======================================================
L4512H:	PUSH  H         ; Save the H,L position on stack
	PUSH  H         ; Save it again
	CALL  L4586H    ; Calculate offset within LCD RAM for ROW / COL in HL
	MOV   C,M       ; Save the character in C
	POP   H         ; Get (H,L) position to calculate Reverse Video location
	CALL  L45AAH    ; Calculate address and bit mask of Reverse Video flag for char at (H,L)
	ANA   M         ; Get the Reverse Video flag status
	POP   H         ; Restore original (H,L) position from stack
	RET             
	
L451FH:	LDA   VRVIDF    ; Reverse video switch
	PUSH  PSW       
	CALL  EXTREF    ; Cancel inverse character mode
	MVI   A,08H     
	RST   4         ; Send character in A to screen/printer
	MVI   A,20H     
	RST   4         ; Send character in A to screen/printer
	MVI   A,08H     
	RST   4         ; Send character in A to screen/printer
	POP   PSW       
	ANA   A         
	RZ              
	JMP   ENTREV    ; Start inverse character mode
	
	
; ======================================================
; ESC l routine (erase current line)
; ======================================================
L4535H:	MVI   H,01H     
	
; ======================================================
; ESC K routine (erase to EOL)
; ======================================================
L4537H:	CALL  L43A2H    ; Conditionally POP PSW from stack based on value at FAC7H
L453AH:	MVI   C,20H     
	XRA   A         
	CALL  L4566H    
	INR   H         
	MOV   A,H       
	CPI   29H       
	JC    L453AH    
	RET             
	
	
; ======================================================
; Form Feed (0CH)), CLS), ESC E), and ESC J routine
; ======================================================
L4548H:	CALL  L44A8H    ; Verticle tab and ESC H routine (home cursor)
	CALL  L45D3H    
	
; ======================================================
; ESC J routine
; ======================================================
L454EH:	CALL  L43A2H    ; Conditionally POP PSW from stack based on value at FAC7H
L4551H:	CALL  L4537H    ; ESC K routine (erase to EOL)
	CALL  L43A9H    
	CMP   L         
	RC              
	RZ              
	MVI   H,01H     
	INR   L         
	JMP   L4551H    
	
	
; ======================================================
; Character plotting level 6.  Save character in C to LCD RAM & call level 7
; ======================================================
L4560H:	CALL  L43A2H    ; Conditionally POP PSW from stack based on value at FAC7H
	LDA   VRVIDF    ; Reverse video switch
L4566H:	PUSH  H         
	PUSH  PSW       
	PUSH  H         
	PUSH  H         
	CALL  L459AH    
	POP   H         
	CALL  L4586H    ; Calculate offset within LCD RAM for ROW / COL in HL
	MOV   M,C       
	POP   D         
	CALL  L73EEH    ; Character plotting level 7. Plot character in C on LCD at (H),L)
	POP   PSW       
	ANA   A         
	POP   H         
	RZ              
	DI              
	MVI   A,0DH     
	SIM             
	EI              
	CALL  L73A9H    ; Blink the cursor
	MVI   A,09H     
	SIM             
	RET             
	
L4586H:	MOV   A,L       ; Put ROW number in A
	ADD   A         ; A = L*2
	ADD   A         ; A = L*4
	ADD   L         ; A = L*5
	ADD   A         ; A = L*10
	ADD   A         ; A = L*20
	ADD   A         ; A = L*40
	MOV   E,A       ; Save in DE
	SBB   A         ; Calculate MSB of ROW*40
	CMA             ; Compiliment the result
	MOV   D,A       ; And save in DE
	MOV   L,H       ; Get COL into L
	MVI   H,00H     ; Zero out MSB of RAM offset
	DAD   D         ; Add ROW RAM offset
	LXI   D,FED7H   ; Load base address of LCD RAM minus 41
	DAD   D         ; Index into LCD RAM (ROW/COl is 1 based, so 41
	RET             ; offset above puts the start at FF00H)
	
L459AH:	MOV   B,A       ; Save normal/reverse video flag in B
	CALL  L45AAH    ; Calculate address and bit mask of Reverse Video flag for char at (H,L)
	INR   B         ; Prepare to test for normal video
	DCR   B         ; Test for normal video (zero)
	JZ    L45A6H    ; Jump if normal video to clear the bit in the bit-field
	ORA   M         ; OR in current byte with the calculated mask
	MOV   M,A       ; Save new byte back to the buffer
	RET             
	
L45A6H:	CMA             ; Compliment the contents of A to clear the bit
	ANA   M         ; AND with current byte
	MOV   M,A       ; Save the bit field back to the buffer
	RET             
	
L45AAH:	MOV   A,L       ; Put ROW in A
	ADD   A         ; A=ROW*2
	ADD   A         ; A=ROW*4
	ADD   L         ; A=ROW*5 (5 bit-field bytes per row)
	MOV   L,A       ; Put Offset of start of row in L
	MOV   A,H       ; Get col number
	DCR   A         ; Decrement col number
	PUSH  PSW       
	RRC             ; Divide col number by 8 to get byte number
	RRC             
	RRC             
	ANI   1FH       ; Keep only lower 5 bits
	ADD   L         ; Add the row start byte
	MOV   L,A       ; Save in L for index into buffer
	MVI   H,00H     ; Zero out MSB
	LXI   D,FB35H   ; Load pointer to buffer (minus 5 since Row is 1 based)
	DAD   D         ; Index into buffer
	POP   PSW       ; Restore col number
	ANI   07H       ; Calculate col % 8
	MOV   D,A       ; Save in D
	XRA   A         ; Clear A
	STC             ; Prepare to rotate a '1' through a to find bit position
L45C5H:	RAR             ; Rotate '1' through MSB
	DCR   D         ; Decrement bit count
	JP    L45C5H    ; Jump until zero
	RET             
	
L45CBH:	PUSH  H         ; Preserve HL on stack
	CALL  L45AAH    ; Calculate address and bit mask of Reverse Video flag for char at (H,L)
	XRA   M         ; Invert the current position bit
	MOV   M,A       ; Save it back
	POP   H         ; Restore HL
	RET             
	
L45D3H:	CALL  L43A2H    ; Conditionally POP PSW from stack based on value at FAC7H
	LDA   F650H     
	ADD   A         
	RP              
	PUSH  H         
	LXI   H,FCC0H   ; Start of Alt LCD character buffer
	LXI   B,L0140H  ; TODO: figure out where this points
L45E2H:	MVI   M,20H     
	INX   H         
	DCX   B         
	MOV   A,B       
	ORA   C         
	JNZ   L45E2H    
	POP   H         
	RET             
	
L45EDH:	CALL  L43A2H    ; Conditionally POP PSW from stack based on value at FAC7H
	LDA   F650H     
	ADD   A         
	RP              
	LXI   D,FCC0H   ; Start of Alt LCD character buffer
	LXI   H,FCE8H   
	LXI   B,L0140H  
	JMP   L6BDBH    ; Move BC bytes from M to (DE) with increment
	
L4601H:	CALL  L73C5H    ; Turn off background task, blink & reinitialize cursor blink time
	MVI   L,01H     ; Prepare to point to LCD RAM (1,1)
L4606H:	MVI   H,01H     ; "
L4608H:	CALL  L4512H    ; Get character at (H),L) from LCD RAM)
	CALL  L4566H    ; Call Level 6 Character Draw routine
	INR   H         ; Increment column
	MOV   A,H       ; Prepare to test for column 40
	CPI   29H       ; Test if beyond column 40
	JNZ   L4608H    ; Jump if more columns on this line
	INR   L         ; Increment line
	MOV   A,L       ; Prepare to test if last line refreshed
	CPI   09H       ; Test if beyond line 8
	JNZ   L4606H    ; Jump back to refresh next line if not on line 9
	JMP   L433BH    ; Get Cursor ROW,COL in DE and start cursor blinking if cursor on
	
L461FH:	LXI   H,FCC0H   ; Start of Alt LCD character buffer
	MVI   E,01H     
L4624H:	MVI   D,01H     
L4626H:	PUSH  H         
	PUSH  D         
	MOV   C,M       
	CALL  L73EEH    ; Character plotting level 7. Plot character in C on LCD at (H),L)
	POP   D         
	POP   H         
	INX   H         
	INR   D         
	MOV   A,D       
	CPI   29H       
	JNZ   L4626H    
	INR   E         
	MOV   A,E       
	CPI   09H       
	JNZ   L4624H    
	RET             
	
	
; ======================================================
; Input and display line and store
; ======================================================
L463EH:	MVI   A,3FH     ; Load ASCII value for '?'
	RST   4         ; Send character in A to screen/printer
	MVI   A,20H     ; Load ASCII value for space
	RST   4         ; Send character in A to screen/printer
	
; ======================================================
; L4644H: Get line from keyboard (terminated by <ENTER>)
; Entry conditions: none
; Exit conditions:  data stored at location VKYBBF
; ======================================================
INLIN:	CALL L421AH
    	JNZ  L4703
    	LDA  VCURCL     ; Cursor column (1-40)
    	STA  FACAH
    	LXI  D,VKYBBF   ; Keyboard buffer
    	MVI  B,01H
L4655:	CALL CHGET      ; Wait for key from keyboard
    	LXI  H,L4655
    	PUSH H
    	RC
    	CPI  7FH
    	JZ   IHBACK     ; Input routine backspace, left arrow, CTRL-H handler
    	CPI  20H
    	JNC  L46CC
    	LXI  H,KYVTAB-2 ; Load pointer to key vector table, it points to two bytes lower, as the lookup routine increments HL twice first.
    	MVI  C,07H      ; Seven entries in table
    	JMP  L4378H     ; Key Vector table lookup
	
; ======================================================
; L466FH: Input routine Key vector table
; ======================================================
KYVTAB:
    DB   03H
    DW   IHCTC          ; CTRL-C Handler
    DB   08H
    DW   IHBACK         ; Backspace handler
    DB   09H
    DW   IHTAB          ; TAB handler
    DB   0DH
    DW   IHENTR         ; ENTER key handler
    DB   15H
    DW   IHCTUX         ; CTRL-U handler
    DB   18H
    DW   IHCTUX         ; CTRL-X Handler
    DB   1DH
    DW   IHBACK         ; Left arrow handler
	
; ======================================================
; L4684H: Input routine Control-C handler
; ======================================================
IHCTC:	POP  H
    	MVI  A,5EH
    	RST  4          ; Send character in A to screen/printer
    	MVI  A,43H
    	RST  4          ; Send character in A to screen/printer
    	CALL CRLF       ; Send CRLF to screen or printer
    	LXI  H,VKYBBF   ; Keyboard buffer
    	MVI  M,00H
    	DCX  H
    	STC
    	RET
	
	
; ======================================================
; L4696H: Input routine ENTER handler
; ======================================================
IHENTR:	POP  H
    	CALL CRLF       ; Send CRLF to screen or printer
    	XRA  A
    	STAX D
    	JMP  L7FFAH     ; Different from M100
    	RET
	
	
; ======================================================
; L46A0H: Input routine backspace, left arrow, CTRL-H handler
; ======================================================
IHBACK:	MOV  A,B
    	DCR  A
    	STC 
    	RZ 
    	DCR  B
    	DCX  D
    	CALL l46D8
L46A9:	PUSH PSW
	MVI  A,7FH
	RST  4          ; Send character in A to screen/printer
	LHLD VCURLN     ; Cursor row (1-8)
	DCR  L
	DCR  H
	MOV  A,H
	ORA  L
	JZ   L46C0
	LXI  H,VCURCL   ; Cursor column (1-40)
	POP  PSW
	CMP  M
	JNZ  L46A9
	RET
L46C0:	POP  PSW
    	STC
    	RET
	
	
; ======================================================
; L46C3H: Input routine CTRL-U & X handler
; ======================================================
IHCTUX:	CALL IHBACK     ; Input routine backspace, left arrow, CTRL-H handler
    	JNC  IHCTUX     ; Input routine CTRL-U & X handler
    	RET
	
	
; ======================================================
; L46CAH: Input routine Tab handler
; ======================================================
IHTAB:	MVI  A,09H      ; Load the code for a TAB
L46CC:	INR  B          ; Increment the length
    	JZ   L46D4      ; Test if 255 bytes entered
    	RST  4          ; Send character in A to screen/printer
    	STAX D
    	INX  D
    	RET
L46D4:	DCR  B
    	JMP  BEEP       ; BEEP statement
l46D8:	PUSH B
    	LDA  FACAH
    	DCR  B
    	JZ   l4701
    	MOV  C,A
    	LXI  H,VKYBBF   ; Keyboard buffer
L46E4:	INR  C
	MOV  A,M
	CPI  09H
	JNZ  l46F2
	MOV  A,C
	DCR  A
	ANI  07H
	JNZ  L46E4
l46F2:	LDA  VACTCC     ; Active columns count (1-40)
    	CMP  C
    	JNC  L46FB
    	MVI  C,01H
L46FB:	INX  H
	DCR  B
	JNZ  L46E4
	MOV  A,C
l4701:	POP  B
    	RET
L4703:	LHLD FC8CH      ; Load pointer to File Control Block
	PUSH H          ; Save address on stack
	INX  H          ; \
	INX  H          ;  \  Offset to file device type byte
	INX  H          ;  /
	INX  H          ; /
	MOV  A,M        ; Get file device type
	SUI  F8H        ; Test for RAM device
	JNZ  L4728      ; Jump if not RAM device
	MOV  L,A        ; Zero out the Address (A=0 from SUI)
	MOV  H,A
	SHLD FC8CH      ; Clear out the ASCII / Tokenize FCB address
	LXI  H,FAC4H
	INR  M
	MOV  A,M
	RRC
	CNC  ENTREV     ; Start inverse character mode
	LXI  H,L5593H   ; Load pointer to 0DH," Wait" text
	CALL L27B1H     ; Print buffer at M until NULL or '"'
	CALL EXTREF     ; Cancel inverse character mode
L4728:	POP  H          ; Restore ASCII / Tokenize FCB address from stack
    	SHLD FC8CH      ; Save back in ASCII / Tokenize FCB address variable
    	MVI  B,00H
    	LXI  H,VKYBBF   ; Keyboard buffer
L4731:	XRA  A
	STA  FAA2H
	STA  FAA3H
	CALL L4E7AH
	JC   L4759
	MOV  M,A
	CPI  0DH
	JZ   L4753
	CPI  09H
	JZ   L474E
	CPI  20H
	JC   L4731
L474E:	INX  H
   	DCR  B
    	JNZ  L4731
L4753:	XRA  A
	MOV  M,A
	LXI  H,F684H
	RET
L4759:	MOV  A,B
	ANA  A
	JNZ  L4753
	LDA  FCA7H
	ANI  80H
	STA  FCA7H
	CALL L4F45H
	MVI  A,0DH
	RST  4          ; Send character in A to screen/printer
	CALL ERABOL     ; Erase from cursor to end of line
	LDA  FC92H      ; Flag to execute BASIC program
	ANA  A
	JZ   NOBEXE
	CALL L3F28H     ; Initialize BASIC Variables for new execution
	JMP  L0804H     ; Execute BASIC program
NOBEXE:	LDA  F651H      ; In TEXT because of BASIC EDIT flag
	ANA  A
	JNZ  L5EBAH
	JMP  L0501H     ; Pop stack and vector to BASIC ready

; ======================================================
; DIM ',' entry separator handler function
; ======================================================
L4786H:	DCX   H         ; Decrement BASIC file byte pointer
	RST   2         ; Get next non-white char from M
	RZ              ; Return if end of statement
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ',' separator for DIM
	
; ======================================================
; DIM statement
; ======================================================
	LXI   B,L4786H  ; Load "RET"urn address of ',' DIM separator routine
	PUSH  B         ; Push retrun address to stack
	ORI   AFH       ; Makes AFH below look like ORI AFH
	STA   FB64H     ; Variable Create/Locate switch
	MOV   C,M       
	CALL  L40F1H    ; Check if M is alpha character
	JC    ERRSYN    ; Generate Syntax error
	XRA   A         
	MOV   B,A       
	RST   2         ; Get next non-white char from M
	JC    L47A7H    
	CALL  L40F2H    ; Check if A is alpha character
	JC    L47B2H    
L47A7H:	MOV   B,A       
L47A8H:	RST   2         ; Get next non-white char from M
	JC    L47A8H    
	CALL  L40F2H    ; Check if A is alpha character
	JNC   L47A8H    
L47B2H:	CPI   26H       ; Test for &
	JNC   L47CEH    
	LXI   D,L47DCH  
	PUSH  D         
	MVI   D,02H     
	CPI   25H       ; Test for %
	RZ              
	INR   D         
	CPI   24H       ; Test for $
	RZ              
	INR   D         
	CPI   21H       ; Test for !
	RZ              
	MVI   D,08H     
	CPI   23H       ; Test for #
	RZ              
	POP   PSW       
L47CEH:	MOV   A,C       
	ANI   7FH       
	MOV   E,A       
	MVI   D,00H     
	PUSH  H         
	LXI   H,FB79H   
	DAD   D         
	MOV   D,M       
	POP   H         
	DCX   H         
L47DCH:	MOV   A,D       
	STA   FB65H     ; Type of last variable used
	RST   2         ; Get next non-white char from M
	LDA   FB96H     ; FOR/NEXT loop active flag
	DCR   A         
	JZ    L48BCH    
	JP    L47F6H    
	MOV   A,M       
	SUI   28H       
	JZ    L488DH    
	SUI   33H       
	JZ    L488DH    
L47F6H:	XRA   A         
	STA   FB96H     ; FOR/NEXT loop active flag
	PUSH  H         
	LHLD  FBB2H     ; Start of variable data pointer
	JMP   L481AH    
	
L4801H:	LDAX  D         
	MOV   L,A       
	INX   D         
	LDAX  D         
	INX   D         
	CMP   C         
	JNZ   L4816H    
	LDA   FB65H     ; Type of last variable used
	CMP   L         
	JNZ   L4816H    
	LDAX  D         
	CMP   B         
	JZ    L4876H    
L4816H:	INX   D         
	MVI   H,00H     
	DAD   D         
L481AH:	XCHG            
	LDA   FBB4H     ; Start of array table pointer
	CMP   E         
	JNZ   L4801H    
	LDA   FBB5H     
	CMP   D         
	JNZ   L4801H    
	JMP   L4835H    
	
L482CH:	CALL  L4790H    ; Find address of variable at M
L482FH:	RET             
	
L4830H:	MOV   D,A       
	MOV   E,A       
	POP   B         
	XTHL            
	RET             
	
L4835H:	POP   H         
	XTHL            
	PUSH  D         
	LXI   D,L482FH  
	RST   3         ; Compare DE and HL
	JZ    L4830H    
	LXI   D,L0FDDH  
	RST   3         ; Compare DE and HL
	POP   D         
	JZ    L4879H    
	XTHL            
	PUSH  H         
	PUSH  B         
	LDA   FB65H     ; Type of last variable used
	MOV   C,A       
	PUSH  B         
	MVI   B,00H     
	INX   B         
	INX   B         
	INX   B         
	LHLD  FBB6H     ; Unused memory pointer
	PUSH  H         
	DAD   B         
	POP   B         
	PUSH  H         
	CALL  L3EF0H    ; Copy bytes from BC to HL with decriment until BC=DE
	POP   H         
	SHLD  FBB6H     ; Unused memory pointer
	MOV   H,B       
	MOV   L,C       
	SHLD  FBB4H     ; Start of array table pointer
L4867H:	DCX   H         
	MVI   M,00H     
	RST   3         ; Compare DE and HL
	JNZ   L4867H    
	POP   D         
	MOV   M,E       
	INX   H         
	POP   D         
	MOV   M,E       
	INX   H         
	MOV   M,D       
	XCHG            
L4876H:	INX   D         
	POP   H         
	RET             
	
L4879H:	STA   FC18H     ; Start of FAC1 for single and double precision
	MOV   H,A       
	MOV   L,A       
	SHLD  FC1AH     ; Start of FAC1 for integers
	RST   5         ; Determine type of last var used
	JNZ   L488BH    
	LXI   H,L03F5H  
	SHLD  FC1AH     ; Start of FAC1 for integers
L488BH:	POP   H         
	RET             
	
L488DH:	PUSH  H         
	LHLD  FB64H     ; Variable Create/Locate switch
	XTHL            
	MOV   D,A       
L4893H:	PUSH  D         
	PUSH  B         
	CALL  L08D6H    
	POP   B         
	POP   PSW       
	XCHG            
	XTHL            
	PUSH  H         
	XCHG            
	INR   A         
	MOV   D,A       
	MOV   A,M       ; Get next byte from BASIC line
	CPI   2CH       ; Test for ','
	JZ    L4893H    
	CPI   29H       ; Test for ')'
	JZ    L48B0H    
	CPI   5DH       ; Test for ']'
	JNZ   ERRSYN    ; Generate Syntax error
L48B0H:	RST   2         ; Get next non-white char from M
	SHLD  FBA8H     
	POP   H         
	SHLD  FB64H     ; Variable Create/Locate switch
	MVI   E,00H     
	PUSH  D         
	LXI   D,F5E5H   
	LHLD  FBB4H     ; Start of array table pointer
	MVI   A,19H     
	XCHG            
	LHLD  FBB6H     ; Unused memory pointer
	XCHG            
	RST   3         ; Compare DE and HL
	JZ    L48FCH    
	MOV   E,M       
	INX   H         
	MOV   A,M       
	INX   H         
	CMP   C         
	JNZ   L48DDH    
	LDA   FB65H     ; Type of last variable used
	CMP   E         
	JNZ   L48DDH    
	MOV   A,M       
	CMP   B         
L48DDH:	INX   H         
	MOV   E,M       
	INX   H         
	MOV   D,M       
	INX   H         
	JNZ   L48C2H    
	LDA   FB64H     ; Variable Create/Locate switch
	ORA   A         
	JNZ   L044FH    ; Generate DD error
	POP   PSW       
	MOV   B,H       
	MOV   C,L       
	JZ    L383EH    
	SUB   M         
	JZ    L495AH    
L48F6H:	LXI   D,L0009H  ; Prepare to generate BS Error (Bad Subscript)
	JMP   L045DH    ; Generate error in E
	
L48FCH:	LDA   FB65H     ; Type of last variable used
	MOV   M,A       
	INX   H         
	MOV   E,A       
	MVI   D,00H     
	POP   PSW       
	JZ    L08DBH    ; Generate FC error
	MOV   M,C       
	INX   H         
	MOV   M,B       
	INX   H         
	MOV   C,A       
	CALL  L3EFFH    ; Test for C * 2 bytes free space in Stack
	INX   H         
	INX   H         
	SHLD  FB8EH     
	MOV   M,C       
	INX   H         
	LDA   FB64H     ; Variable Create/Locate switch
	RAL             
	MOV   A,C       
L491CH:	LXI   B,L000BH  
	JNC   L4924H    
	POP   B         
	INX   B         
L4924H:	MOV   M,C       
	PUSH  PSW       
	INX   H         
	MOV   M,B       
	INX   H         
	CALL  L36D8H    
	POP   PSW       
	DCR   A         
	JNZ   L491CH    
	PUSH  PSW       
	MOV   B,D       
	MOV   C,E       
	XCHG            
	DAD   D         
	JC    L3F17H    ; Reinit BASIC stack and generate OM error
	CALL  L3F08H    ; Test HL against stack space for collision
	SHLD  FBB6H     ; Unused memory pointer
L493FH:	DCX   H         
	MVI   M,00H     
	RST   3         ; Compare DE and HL
	JNZ   L493FH    
	INX   B         
	MOV   D,A       
	LHLD  FB8EH     
	MOV   E,M       
	XCHG            
	DAD   H         
	DAD   B         
	XCHG            
	DCX   H         
	DCX   H         
	MOV   M,E       
	INX   H         
	MOV   M,D       
	INX   H         
	POP   PSW       
	JC    L498DH    
L495AH:	MOV   B,A       
	MOV   C,A       
	MOV   A,M       
	INX   H         
	MVI   D,E1H     
	MOV   E,M       
	INX   H         
	MOV   D,M       
	INX   H         
	XTHL            
	PUSH  PSW       
	RST   3         ; Compare DE and HL
	JNC   L48F6H    
	CALL  L36D8H    
	DAD   D         
	POP   PSW       
	DCR   A         
	MOV   B,H       
	MOV   C,L       
	JNZ   L495FH    
	LDA   FB65H     ; Type of last variable used
	MOV   B,H       
	MOV   C,L       
	DAD   H         
	SUI   04H       
	JC    L4985H    
	DAD   H         
	JZ    L498AH    
	DAD   H         
L4985H:	ORA   A         
	JPO   L498AH    
	DAD   B         
L498AH:	POP   B         
	DAD   B         
	XCHG            
L498DH:	LHLD  FBA8H     
	RET             
	
	
; ======================================================
; USING function
; ======================================================
L4991H:	CALL  L0DACH    ; Main BASIC evaluation routine
	CALL  L7304H    ; Different from M100
	RST   1         ; Compare next byte with M
    DB	3BH             
	XCHG            
	LHLD  FC1AH     ; Start of FAC1 for integers
	JMP   L49A9H    
	
L49A0H:	LDA   FB98H     
	ORA   A         
	JZ    L49B4H    
	POP   D         
	XCHG            
L49A9H:	PUSH  H         
	XRA   A         
	STA   FB98H     
	INR   A         
	PUSH  PSW       
	PUSH  D         
	MOV   B,M       
	INR   B         
	DCR   B         
L49B4H:	JZ    L08DBH    ; Generate FC error
	INX   H         
	MOV   A,M       
	INX   H         
	MOV   H,M       
	MOV   L,A       
	JMP   L49DCH    
	
L49BFH:	MOV   E,B       
	PUSH  H         
	MVI   C,02H     
L49C3H:	MOV   A,M       ; Get next char from BASIC line
	INX   H         
	CPI   5CH       ; Test for '\'
	JZ    L4B07H    
	CPI   20H       ; Test for space
	JNZ   L49D4H    
	INR   C         
	DCR   B         
	JNZ   L49C3H    
L49D4H:	POP   H         
	MOV   B,E       
	MVI   A,5CH     
L49D8H:	CALL  L4B3AH    
	RST   4         ; Send character in A to screen/printer
L49DCH:	XRA   A         
	MOV   E,A       
	MOV   D,A       
L49DFH:	CALL  L4B3AH    
	MOV   D,A       
	MOV   A,M       
	INX   H         
	CPI   21H       ; Test for !
	JZ    L4B04H    
	CPI   23H       ; Test for #
	JZ    L4A2EH    
	DCR   B         
	JZ    L4AF0H    
	CPI   2BH       ; Test for +
	MVI   A,08H     
	JZ    L49DFH    
	DCX   H         
	MOV   A,M       
	INX   H         
	CPI   2EH       ; Test for .
	JZ    L4A4DH    
	CPI   5CH       ; Test for \
	JZ    L49BFH    
	CMP   M         
	JNZ   L49D8H    
	CPI   24H       ; Test for $
	JZ    L4A27H    
	CPI   2AH       ; Test for *
	JNZ   L49D8H    
	INX   H         
	MOV   A,B       
	CPI   02H       
	JC    L4A1FH    
	MOV   A,M       
	CPI   24H       
L4A1FH:	MVI   A,20H     
	JNZ   L4A2BH    
	DCR   B         
	INR   E         
	CPI   AFH       
	ADI   10H       
	INX   H         
L4A2BH:	INR   E         
	ADD   D         
	MOV   D,A       
L4A2EH:	INR   E         
	MVI   C,00H     
	DCR   B         
	JZ    L4A83H    
	MOV   A,M       
	INX   H         
	CPI   2EH       ; Test for .
	JZ    L4A58H    
	CPI   23H       ; Test for #
	JZ    L4A2EH    
	CPI   2CH       ; Test for ,
	JNZ   L4A64H    
	MOV   A,D       
	ORI   40H       
	MOV   D,A       
	JMP   L4A2EH    
	
L4A4DH:	MOV   A,M       
	CPI   23H       
	MVI   A,2EH     
	JNZ   L49D8H    
	MVI   C,01H     
	INX   H         
L4A58H:	INR   C         
	DCR   B         
	JZ    L4A83H    
	MOV   A,M       
	INX   H         
	CPI   23H       
	JZ    L4A58H    
L4A64H:	PUSH  D         
	LXI   D,L4A81H  
	PUSH  D         
	MOV   D,H       
	MOV   E,L       
	CPI   5EH       
	RNZ             
	CMP   M         
	RNZ             
	INX   H         
	CMP   M         
	RNZ             
	INX   H         
	CMP   M         
	RNZ             
	INX   H         
	MOV   A,B       
	SUI   04H       
	RC              
	POP   D         
	POP   D         
	MOV   B,A       
	INR   D         
	INX   H         
	JZ    D1EBH     
L4A83H:	MOV   A,D       
	DCX   H         
	INR   E         
	ANI   08H       
	JNZ   L4AA3H    
	DCR   E         
	MOV   A,B       
	ORA   A         
	JZ    L4AA3H    
	MOV   A,M       
	SUI   2DH       
	JZ    L4A9EH    
	CPI   FEH       
	JNZ   L4AA3H    
	MVI   A,08H     
L4A9EH:	ADI   04H       
	ADD   D         
	MOV   D,A       
	DCR   B         
L4AA3H:	POP   H         
	POP   PSW       
	JZ    L4AF9H    
	PUSH  B         
	PUSH  D         
	CALL  L0DABH    ; Main BASIC evaluation routine
	POP   D         
	POP   B         
	PUSH  B         
	PUSH  H         
	MOV   B,E       
	MOV   A,B       
	ADD   C         
	CPI   19H       
	JNC   L08DBH    ; Generate FC error
	MOV   A,D       
	ORI   80H       
	CALL  L39E9H    
	CALL  L27B1H    ; Print buffer at M until NULL or '"'
L4AC2H:	POP   H         
	DCX   H         
	RST   2         ; Get next non-white char from M
	STC             
	JZ    L4AD7H    
	STA   FB98H     
	CPI   3BH       
	JZ    L4AD6H    
	CPI   2CH       
	JNZ   ERRSYN    ; Generate Syntax error
L4AD6H:	RST   2         ; Get next non-white char from M
L4AD7H:	POP   B         
	XCHG            
	POP   H         
	PUSH  H         
	PUSH  PSW       
	PUSH  D         
	MOV   A,M       
	SUB   B         
	INX   H         
	MVI   D,00H     
	MOV   E,A       
	MOV   A,M       
	INX   H         
	MOV   H,M       
	MOV   L,A       
	DAD   D         
	MOV   A,B       
	ORA   A         
	JNZ   L49DCH    
	JMP   L4AF4H    
	
L4AF0H:	CALL  L4B3AH    
	RST   4         ; Send character in A to screen/printer
L4AF4H:	POP   H         
	POP   PSW       
	JNZ   L49A0H    
L4AF9H:	CC    L4BCBH    
	XTHL            
	CALL  L291CH    
	POP   H         
	JMP   L0C39H    ; Jump to address of routine to terminate BASIC?
	
L4B04H:	MVI   C,01H     
	MVI   A,F1H     ; Make F1H below look like MVI A,F1H
	DCR   B         
	CALL  L4B3AH    
	POP   H         
	POP   PSW       
	JZ    L4AF9H    
	PUSH  B         
	CALL  L0DABH    ; Main BASIC evaluation routine
	CALL  L35D9H    ; Generate TM error if last variable type not string or RET
	POP   B         
	PUSH  B         
	PUSH  H         
	LHLD  FC1AH     ; Start of FAC1 for integers
	MOV   B,C       
	MVI   C,00H     
	MOV   A,B       
	PUSH  PSW       
	CALL  L29B2H    
	CALL  L27B4H    
	LHLD  FC1AH     ; Start of FAC1 for integers
	POP   PSW       
	SUB   M         
	MOV   B,A       
	MVI   A,20H     
	INR   B         
L4B32H:	DCR   B         
	JZ    L4AC2H    
	RST   4         ; Send character in A to screen/printer
	JMP   L4B32H    
	
L4B3AH:	PUSH  PSW       
	MOV   A,D       
	ORA   A         
	MVI   A,2BH     
	CNZ   LCD       ; Send A to screen or printer
	POP   PSW       
	RET             
	
	
; ======================================================
; L4B44H: Displays a character on the LCD at current 
;        cursor position. (Also RST 4)
; Entry conditions: A = character to be displayed
; Exit conditions:  none
; ======================================================
LCD:	PUSH PSW     	; Preserve character on stack
	PUSH H
	CALL L421AH     ; Test for output to a file
	JNZ  L4E52H     ; Jump to send to file instead if enabled
	POP  H
	LDA  VOUTSW     ; Output device for RST 20H (0=screen)
	ORA  A          ; Test for output to LCD or LPT
	JZ   DCHSTK     ; Jump if output to LCD
	POP  PSW        ; Restore char to be sent to LPT
	
; ======================================================
; L4B55H: Print a character expanding tabs to spaces
; Entry conditions: A = character to be printed
; Exit conditions:  none
; ======================================================
PRTTAB:	PUSH PSW        ; Save character on stack
    	CPI  09H        ; Test for TAB char
    	JNZ  SNTABC     ; Jump if not TAB to send to LPT
LSNDSP:	MVI  A,20H      ; Prepare to send spaces
	CALL PRTTAB     ; Print A to printer, expanding tabs if necessary
	LDA  VLPPCL     ; Line printer head position
	ANI  07H        ; Test if col is factor of 8
	JNZ  LSNDSP     ; Jump to send more spaces
	POP  PSW        ; Restore character
	RET
; ======================================================
; L4B6AH: Send non-TAB character to printer
; ======================================================
SNTABC:	SUI  0DH        ; Test for CR
	JZ   ISCRCH     ; Jump if CR character
	JC   NCRCHA     ; Jump if not LF character
	LDA  VLPPCL     ; Line printer head position
	INR  A          ; Increment printer line (LF detected)
ISCRCH:	STA  VLPPCL     ; Line printer head position
NCRCHA:	POP  PSW        ; Restore character from stack
L4B7A:	CPI  0AH        ; Test for LF
	JNZ  L4B88      ; Jump to skip CRLF test if not LF
	PUSH B          ; Preserve BC on stack
	MOV  B,A        ; Save char in B
	LDA  FAACH      ; Last char sent to printer
	CPI  0DH        ; Test if 0Ah following 0Dh
	MOV  A,B        ; Restore character
	POP  B          ; Restore BC
L4B88:	STA  FAACH      ; Last char sent to printer
	RZ              ; Don't send 0Ah if last char was 0Dh
	CPI  1AH        ; Test for EOF char
	RZ              ; Return if EOF character
	JMP  PNOTAB     ; Output character to printer
	
; ======================================================
; L4B92H: Reinitialize output back to LCD
; ======================================================
ROTLCD:	XRA  A          ; Zero out A
	STA  VOUTSW     ; Output device for RST 20H (0=screen)
	LDA  VLPPCL     ; Line printer head position
	ORA  A
	RZ
	LDA  FACDH
	ORA  A
	RZ
L4BA0:	MVI  A,0DH
	CALL L4B7A
	XRA  A
	STA  VLPPCL     ; Line printer head position
	RET
	
; ======================================================
; L4BAAH: Restore char to send to LCD from stack and display it
; ======================================================
DCHSTK:	POP  PSW        ; Pop char to display from stack
	
; ======================================================
; LCD character output routine
; ======================================================
	PUSH  PSW       ; Preserve character
	CALL  L4313H    ; Print A to the screen
	LDA   VCURCL    ; Cursor column (1-40)
	DCR   A         
	STA   F788H     ; Horiz. position of cursor (0-39)
	POP   PSW       ; Restore character
	RET             
	
	
; ======================================================
; Move LCD to blank line (send CRLF if needed)
; ======================================================
L4BB8H:	LDA   VCURCL    ; Cursor column (1-40)
	DCR   A         
	RZ              
	JMP   L4BCBH    
	
	MVI   M,00H     
	CALL  L421AH    
	LXI   H,F684H   
	JNZ   L4BD1H    
L4BCBH:	MVI   A,0DH     
	RST   4         ; Send character in A to screen/printer
	MVI   A,0AH     
	RST   4         ; Send character in A to screen/printer
L4BD1H:	CALL  L421AH    
	JZ    L4BD9H    
	XRA   A         
	RET             
	
L4BD9H:	LDA   VOUTSW    ; Output device for RST 20H (0=screen)
	ORA   A         
	JZ    L4BE5H    
	XRA   A         
	STA   VLPPCL    ; Line printer head position
	RET             
	
L4BE5H:	XRA   A         
	STA   F788H     ; Horiz. position of cursor (0-39)
	RET             
	
	
; ======================================================
; INKEY$ function
; ======================================================
L4BEAH:	RST   2         ; Get next non-white char from M
	PUSH  H         
	CALL  CHSNS     ; Check keyboard queue for pending characters
	JZ    L4BFEH    
	CALL  CHGET     ; Wait for key from keyboard
	PUSH  PSW       
	CALL  L275BH    ; Create a 1-byte transient string (for CHR$ & INKEY$)
	POP   PSW       
	MOV   E,A       
	CALL  L2965H    
L4BFEH:	LXI   H,L03F5H  
	SHLD  FC1AH     ; Start of FAC1 for integers
	MVI   A,03H     ; Load code for String variable type
	STA   FB65H     ; Type of last variable used
	POP   H         
	RET             
	
L4C0BH:	PUSH  H         
	JMP   L4C21H    
	
L4C0FH:	CALL  L0DABH    ; Main BASIC evaluation routine
	PUSH  H         ; Save HL on stack
	CALL  L2916H    ; Get pointer to most recently used string (Len + address)
	MOV   A,M       ; Get length of the string
	ORA   A         ; Test for zero length string
	JZ    L4C55H    ; Generate NM error if zero length string
	INX   H         ; Point to string data pointer
	MOV   E,M       ; Get LSB of string data pointer
	INX   H         ; Point to MSB of string data pointer
	MOV   H,M       ; Get MSB of string data pointer
	MOV   L,E       ; Put LSB of string data pointer in L
	MOV   E,A       ; Put length of string in E
L4C21H:	CALL  L5075H    ; DSKI$ function - test for special device name
	PUSH  PSW       ; Push device index to stack
	LXI   B,FC93H   ; Filename of current BASIC program
	MVI   D,09H     ; Max filename len, counting '.'
	INR   E         ; Pre-increment string length
L4C2BH:	DCR   E         ; Decrement remaining argument string length
	JZ    L4C72H    ; Copy D SPACES to (BC)
	CALL  L0FE8H    ; Get char at M and convert to uppercase
	CPI   20H       ; Test for space
	JC    L4C55H    ; Generate NM error if any chars less than space
	CPI   7FH       ; Test for DEL
	JZ    L4C55H    ; Generate NM error if DEL part of filename
	CPI   2EH       ; Test for '.' in filename
	JZ    L4C5CH    ; Handle '.' found in RUN/LOAD/SAVE filename
	STAX  B         ; Save this byte in current BASIC program filename
	INX   B         ; Increment the pointer to BASIC program filename
	INX   H         ; Increment pointer to the typed argument
	DCR   D         ; Decrement the remaining filename length
	JNZ   L4C2BH    ; Jump to process more argument bytes
L4C48H:	POP   PSW       ; Restore device name index from stack
	PUSH  PSW       ; ... and push it back
	MOV   D,A       ; Put device index in D
	LDA   FC93H     ; Filename of current BASIC program
	INR   A         ; Test if first filename byte is 0xFF
	JZ    L4C55H    ; Generate NM error if first filename byte is 0xFF
	POP   PSW       ; Pop device name index from stack
	POP   H         ; Restore HL
	RET             
	
L4C55H:	JMP   L504EH    ; Generate NM error
	
L4C58H:	INX   H         ; Increment pointer to argument to skip '.'
	JMP   L4C2BH    ; Continue processing the argument
	
L4C5CH:	MOV   A,D       ; Get filename length count
	CPI   09H       ; Test for '.' as first byte of filename
	JZ    L4C55H    ; Generate NM error if first byte is '.'
	CPI   03H       ; Test for filename base > 6 bytes
	JC    L4C55H    ; Generate NM error if base filename > 6 bytes
	JZ    L4C58H    ; Jump to simply skip '.' if base filename = 6 bytes
	MVI   A,20H     ; Prepare to space fill base filename to 6 bytes
	STAX  B         ; Space pad a byte in base filename
	INX   B         ; Increment pointer to converted filename
	DCR   D         ; Decrement remaining filename length count
	JMP   L4C5CH    ; Go test if more SPACE padding needed
	
L4C72H:	MVI   A,20H     ; Load ASCII value for SPACE
	STAX  B         ; Store next SPACE at (BC)
	INX   B         ; Increment pointer
	DCR   D         ; Decrement counter
	JNZ   L4C72H    ; Keep looping until counter is zero
	JMP   L4C48H    
	
L4C7DH:	MOV   A,M       
	INX   H         
	DCR   E         
	RET             
	
L4C81H:	CALL  L1131H    ; Get expression integer < 256 in A or FC Error
	
; ======================================================
; Get file descriptor for file in A
; ======================================================
L4C84H:	MOV   L,A       
	LDA   FC82H     ; Maxfiles
	CMP   L         
	JC    L505DH    ; Generate BN error
	MVI   H,00H     
	SHLD  FAA2H     
	DAD   H         
	XCHG            
	LHLD  FC83H     ; File number description table pointer
	DAD   D         
	MOV   A,M       
	INX   H         
	MOV   H,M       
	MOV   L,A       
	MOV   A,M       
	ORA   A         
	RZ              
	PUSH  H         
	LXI   D,L0004H  
	DAD   D         
	MOV   A,M       
	CPI   09H       
	JNC   L4CAEH    
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	1EH             
	JMP   L5060H    ; Generate IE error
	
L4CAEH:	POP   H         
	MOV   A,M       
	ORA   A         
	STC             
	RET             
	
L4CB3H:	DCX   H         
	RST   2         ; Get next non-white char from M
	CPI   23H       ; Test for '#'
	CZ    L0858H    ; RST 10H routine with pre-increment of HL
	CALL  L112EH    ; Evaluate expression at M-1
	XTHL            
	PUSH  H         
L4CBFH:	CALL  L4C84H    ; Get file descriptor for file in A
	JZ    L505AH    ; Generate CF error
	SHLD  FC8CH     ; Save FCB pointer in ASCII output variable
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	0CH             
	RET             
	
	
; ======================================================
; OPEN statement
; ======================================================
	LXI   B,L0C39H  ; Load address of routine to terminate BASIC?
	PUSH  B         
	CALL  L4C0FH    ; Evaluate arguments to RUN/OPEN/SAVE commands
	JNZ   L4CD7H    ; Test if device name specified ... jump if it was
	MVI   D,F8H     ; Default to RAM device
L4CD7H:	RST   1         ; Compare next byte with M
    DB	81H             ; Test for FOR token ID
	CPI   84H       ; Test for INPUT token ID
	MVI   E,01H     ; Load code for INPUT open mode
	JZ    L4CFCH    ; If "INPUT", Jump to test for "AT"
	CPI   96H       ; Test for OUT token ID
	JZ    L4CF2H    ; Jump if OUT token ID found to test for "PUT"
	RST   1         ; Compare next byte with M
    DB	41H             ; Test for 'A'
	RST   1         ; Compare next byte with M
    DB	50H             ; Test for 'P'
	RST   1         ; Compare next byte with M
    DB	50H             ; Test for 'P'
	RST   1         ; Compare next byte with M
    DB	80H             ; Test for END token ID ("APPEND")
	MVI   E,08H     ; Load code for APPEND open mode
	JMP   L4CFDH    
	
L4CF2H:	RST   2         ; Get next non-white char from M
	RST   1         ; Compare next byte with M
    DB	50H             ; Test for 'P'
	RST   1         ; Compare next byte with M
    DB	55H             ; Test for 'U'
	RST   1         ; Compare next byte with M
    DB	54H             ; Test for 'T'
	MVI   E,02H     ; Load code for OUTPUT open mode
	MVI   A,D7H     ; Make D7H below look like MVI A,D7H
L4CFDH:	RST   1         ; Compare next byte with M
    DB	41H             ; Test for 'A'
	RST   1         ; Compare next byte with M
    DB	53H             ; Test for 'T'
	PUSH  D         ; Save open mode on stack
	MOV   A,M       ; Get next char from BASIC line
	CPI   23H       ; Test for '#'
	CZ    L0858H    ; RST 10H routine with pre-increment of HL
	CALL  L112EH    ; Evaluate expression at M-1
	ORA   A         
	JZ    L505DH    ; Generate BN error
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	18H             
	MVI   E,D5H     ; Make PUSH D below look like MVI E,D5H
	DCX   H         ; Rewind BASIC line pointer
	MOV   E,A       ; Save file number to open in E
	RST   2         ; Get next non-white char from M
	JNZ   ERRSYN    ; Generate Syntax error
	XTHL            ; Extract open mode from stack
	MOV   A,E       ; Put open mode (INPUT, APPEND, etc.) in A
	PUSH  PSW       ; And save it to the stack
	PUSH  H         ; Preserve open mode on stack
	CALL  L4C84H    ; Get file descriptor for file in A
	JNZ   L5051H    ; Generate AO error
	POP   D         ; Pop device number and open mode from stack
	MOV   A,D       ; Put device number in A
	CPI   09H       ; Compare with 09H ?
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	1CH             
	JC    L5060H    ; Generate IE error
	PUSH  H         ; Save pointer to file DCB entry
	LXI   B,L0004H  ; Load offset of device type in DCB
	DAD   B         ; Offset into DCB
	MOV   M,D       ; Store file device type in DCB
	MVI   A,00H     ; Load ID for OPEN vector
	POP   H         ; Restore pointer to file DCB entry
	JMP   L5123H    ; Call OPEN Hook and DCB Vector identified in A
	
L4D38H:	PUSH  H         
	ORA   A         
	JNZ   L4D45H    
	LDA   FCA7H     
	ANI   01H       
	JNZ   L4F08H    
L4D45H:	CALL  L4C84H    ; Get file descriptor for file in A
	JZ    L4D5DH    
	SHLD  FC8CH     ; Save FCB pointer in ASCII output variable
	PUSH  H         
	MVI   A,02H     
	JC    L5123H    ; Call OPEN Hook and DCB Vector identified in A
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	14H             
	JMP   L5060H    ; Generate IE error
	
	
; ======================================================
; LCD), CRT), and LPT file close routine
; ======================================================
L4D59H:	CALL  L4EFFH    
	POP   H         
L4D5DH:	PUSH  H         
	LXI   D,L0007H  
	DAD   D         
	MOV   M,A       
	MOV   H,A       
	MOV   L,A       
	SHLD  FC8CH     
	POP   H         
	ADD   M         
	MVI   M,00H     
	POP   H         
	RET             
	
	
; ======================================================
; RUN statement
; ======================================================
L4D6EH:	STC             
	LXI   D,AFF6H   
	PUSH  PSW       
	DCX   H         ; Point to byte in BASIC command before space
	RST   2         ; Get next non-white char from M
	CPI   4DH       ; Test for "M"
	JZ    L2491H    ; LOADM and RUNM statement
	CALL  L4C0FH    ; Evaluate arguments to RUN/OPEN/SAVE commands
	JZ    L1E7BH    
	MOV   A,D       
	CPI   F8H       ; Test for RAM device ID
	JZ    L1E7BH    
	CPI   FDH       ; Test for CAS device ID
	JZ    L2387H    ; Jump into CLOAD function
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	1AH             
L4D8DH:	POP   PSW       
	PUSH  PSW       
	JZ    L4D9FH    
	MOV   A,M       ; Get next character from BASIC line
	SUI   2CH       ; Test for ','
	ORA   A         
	JNZ   L4D9FH    ; Skip test for ",R" if not ','
	RST   2         ; Get next non-white char from M
	RST   1         ; Compare next byte with M
    DB	52H             ; Test for 'R'
	POP   PSW       
	STC             
L4D9EH:	PUSH  PSW       
L4D9FH:	PUSH  PSW       
	XRA   A         
	MVI   E,01H     
	CALL  L4D12H    ; Call into the OPEN file code to open the device in E
L4DA6H:	LHLD  FC8CH     
	LXI   B,L0007H  
	DAD   B         
	POP   PSW       
	SBB   A         
	ANI   80H       
	ORI   01H       
	STA   FCA7H     
	POP   PSW       
	PUSH  PSW       
	SBB   A         
	STA   FC92H     ; Flag to execute BASIC program
	MOV   A,M       
	ORA   A         
	JM    L4E1DH    
	POP   PSW       
	CNZ   L20FFH    ; NEW statement
	CALL  L4E22H    
	XRA   A         
	CALL  L4CBFH    
	JMP   L0511H    ; Silent vector to BASIC ready
	
	
; ======================================================
; SAVE statement
; ======================================================
	CPI   4DH       ; Test for 'M'
	JZ    L22CCH    ; SAVEM statement
	CALL  L3F2CH    ; Initialize BASIC Variables for new execution
	CALL  L4C0FH    ; Evaluate arguments to RUN/OPEN/SAVE commands
	JZ    L1ED9H    
	MOV   A,D       
	CPI   F8H       
	JZ    L1ED9H    
	CPI   FDH       
	JZ    L2288H    
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	16H             
	DCX   H         
	RST   2         ; Get next non-white char from M
	MVI   E,80H     
	STC             
	JZ    L4DF9H    
	RST   1         ; Compare next byte with M
    DB	2CH             ; Test for ','
	RST   1         ; Compare next byte with M
    DB	41H             ; Test for 'A'
	ORA   A         
	MVI   E,02H     
L4DF9H:	PUSH  PSW       
	MOV   A,D       
	CPI   09H       
	JC    L4E0BH    ; Jump to open a device and perform a LIST
	MOV   A,E       
	ANI   80H       
	JZ    L4E0BH    ; Jump to open a device and perform a LIST
	MVI   E,02H     
	POP   PSW       
	XRA   A         
	PUSH  PSW       
L4E0BH:	XRA   A         ; Set file number to zero to prevent errors
	CALL  L4D12H    ; Call into the OPEN file code to open the device in E
	POP   PSW       ; Pop "perform LIST" status from stack
	JC    L4E18H    ; Test if a LIST operation requested, jump if not
	DCX   H         ; Rewind BASIC line pointer 1 character
	RST   2         ; Get next non-white char from M
	JMP   L1140H    ; LIST statement
	
L4E18H:	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	22H             
	JMP   L504EH    ; Generate NM error
	
L4E1DH:	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	24H             
	JMP   L504EH    ; Generate NM error
	
L4E22H:	LDA   FCA7H     
	ORA   A         
	RM              
	XRA   A         
	
; ======================================================
; CLOSE statement
; ======================================================
	LDA   FC82H     ; Maxfiles
	JNZ   L4E3BH    
	PUSH  H         
L4E2FH:	PUSH  PSW       
	ORA   A         
	CALL  L4D38H    
	POP   PSW       
	DCR   A         
	JP    L4E2FH    
	POP   H         
	RET             
	
L4E3BH:	MOV   A,M       ; Get next character from BASIC line
	CPI   23H       ; Test for '#'
	CZ    L0858H    ; RST 10H routine with pre-increment of HL
	CALL  L112EH    ; Evaluate expression at M-1
	PUSH  H         
	STC             
	CALL  L4D38H    
	POP   H         
	MOV   A,M       ; Get next character from BASIC line
	CPI   2CH       ; Test for ','
	RNZ             
	RST   2         ; Get next non-white char from M
	JMP   L4E3BH    
	
L4E52H:	POP   H         
	POP   PSW       
	PUSH  H         
	PUSH  D         
	PUSH  B         
	PUSH  PSW       
	LHLD  FC8CH     
	MVI   A,04H     
	CALL  L4E65H    
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	20H             
	JMP   L504EH    ; Generate NM error
	
L4E65H:	PUSH  PSW       
	PUSH  D         
	XCHG            
	LXI   H,L0004H  
	DAD   D         
	MOV   A,M       
	XCHG            
	POP   D         
	CPI   09H       
	JC    L4F1AH    
	POP   PSW       
	XTHL            
	POP   H         
	JMP   L5123H    ; Call OPEN Hook and DCB Vector identified in A
	
L4E7AH:	PUSH  B         
	PUSH  H         
	PUSH  D         
	LHLD  FC8CH     
	MVI   A,06H     
	CALL  L4E65H    
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	0EH             
	JMP   L504EH    ; Generate NM error
	
L4E8AH:	POP   D         
	POP   H         
	POP   B         
	RET             
	
	
; ======================================================
; INPUT statement
; ======================================================
L4E8EH:	RST   2         ; Get next non-white char from M
	RST   1         ; Compare next byte with M
    DB	24H             ; Test for '$'
	RST   1         ; Compare next byte with M
    DB	28H             ; Test for '('
	PUSH  H         
	LHLD  FC8CH     
	PUSH  H         
	LXI   H,0000H  
	SHLD  FC8CH     
	POP   H         
	XTHL            
	CALL  L112EH    ; Evaluate expression at M-1
	PUSH  D         
	MOV   A,M       
	CPI   2CH       
	JNZ   L4EBBH    
	RST   2         ; Get next non-white char from M
	CALL  L4CB3H    
	CPI   01H       
	JZ    L4EB8H    
	CPI   04H       
	JNZ   L5063H    ; Generate EF error
L4EB8H:	POP   H         
	XRA   A         
	MOV   A,M       
L4EBBH:	PUSH  PSW       
	RST   1         ; Compare next byte with M
    DB	29H             ; Test for '('
	POP   PSW       
	XTHL            
	PUSH  PSW       
	MOV   A,L       
	ORA   A         
	JZ    L08DBH    ; Generate FC error
	PUSH  H         
	CALL  L275DH    ; Create a transient string of length A
	XCHG            
	POP   B         
L4ECCH:	POP   PSW       
	PUSH  PSW       
	JZ    L4EF6H    
	CALL  CHGET     ; Wait for key from keyboard
	CPI   03H       
	JZ    L4EEBH    
L4ED9H:	MOV   M,A       
	INX   H         
	DCR   C         
	JNZ   L4ECCH    
	POP   PSW       
	POP   B         
	POP   H         
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	10H             
	SHLD  FC8CH     
	PUSH  B         
	JMP   L278DH    ; Add new transient string to string stack
	
L4EEBH:	POP   PSW       
	LHLD  F67AH     ; Current executing line number
	SHLD  FB9FH     ; Line number of last error
	POP   H         
	JMP   L0422H    ; Initialize system and go to BASIC ready
	
L4EF6H:	CALL  L4E7AH    
	JC    L5063H    ; Generate EF error
	JMP   L4ED9H    
	
L4EFFH:	CALL  L4F12H    
	PUSH  H         
	MVI   B,00H     
	CALL  L4F0AH    ; Zero B bytes at M
L4F08H:	POP   H         
	RET             
	
	
; ======================================================
; Zero B bytes at M
; ======================================================
L4F0AH:	XRA   A         
	
; ======================================================
; Load B bytes at M with A
; ======================================================
L4F0BH:	MOV   M,A       
	INX   H         
	DCR   B         
	JNZ   L4F0BH    ; Load B bytes at M with A
	RET             
	
L4F12H:	LHLD  FC8CH     
	LXI   D,L0009H  
	DAD   D         
	RET             
	
L4F1AH:	POP   PSW       
	RET             
	
L4F1CH:	CALL  L421AH    
	JZ    L083AH    ; Start executing BASIC program at HL
	XRA   A         
	CALL  L4D38H    
	JMP   L5054H    ; Generate DS error
	
L4F29H:	MVI   C,01H     ; Set PRINT # init entry marker
L4F2BH:	CPI   23H       ; Test for '#' character
	RNZ             
	
; ======================================================
; PRINT # initialization routine
; ======================================================
	PUSH  B         
	CALL  L112DH    ; Evaluate expression at M
	RST   1         ; Compare next byte with M
    DB	2CH             
	MOV   A,E       
	PUSH  H         
	CALL  L4CBFH    
	MOV   A,M       
	POP   H         
	POP   B         
	CMP   C         
	JZ    L4F43H    
	JMP   L505DH    ; Generate BN error
	
L4F43H:	MOV   A,M       
L4F44H:	RET             
	
L4F45H:	LXI   B,L3F9CH  ; Address of routine to get address of last variable used
	PUSH  B         
	XRA   A         
	JMP   L4D38H    
	
L4F4DH:	RST   5         ; Determine type of last var used
	LXI   B,L0D31H  
	LXI   D,L2C20H  
	JNZ   L4F6FH    
	MOV   E,D       
	JMP   L4F6FH    
	
	
; ======================================================
; LINE INPUT # statement
; ======================================================
L4F5BH:	LXI   B,L0C39H  
	PUSH  B         
	CALL  L4F29H    ; Test for '#' char and process argument
	CALL  L4790H    ; Find address of variable at M
	CALL  L35D9H    ; Generate TM error if last variable type not string or RET
	PUSH  D         
	LXI   B,L09BDH  ; Load address of routine to perform variable assignment
	XRA   A         
	MOV   D,A       
	MOV   E,A       
L4F6FH:	PUSH  PSW       
	PUSH  B         ; Push variable assignment "RET"urn address to stack
	PUSH  H         
L4F72H:	CALL  L4E7AH    
	JC    L5063H    ; Generate EF error
	CPI   20H       
	JNZ   L4F82H    
	INR   D         
	DCR   D         
	JNZ   L4F72H    
L4F82H:	CPI   22H       ; Test for quote
	JNZ   L4F97H    
	MOV   A,E       
	CPI   2CH       ; Test for ,
	MVI   A,22H     
	JNZ   L4F97H    
	MOV   D,A       
	MOV   E,A       
	CALL  L4E7AH    
	JC    L4FEAH    
L4F97H:	LXI   H,VKYBBF  ; Keyboard buffer
	MVI   B,FFH     
L4F9CH:	MOV   C,A       
	MOV   A,D       
	CPI   22H       ; Test for quote
	MOV   A,C       
	JZ    L4FD5H    
	CPI   0DH       ; Test for CR
	PUSH  H         
	JZ    L500AH    ; Jump if CR found
	POP   H         
	CPI   0AH       ; Test for LF
	JNZ   L4FD5H    
L4FB0H:	MOV   C,A       
	MOV   A,E       
	CPI   2CH       ; Test for ,
	MOV   A,C       
	CNZ   L5044H    ; Call if not comma
	CALL  L4E7AH    
	JC    L4FEAH    
	CPI   0AH       ; Test for LF
	JZ    L4FB0H    ; Jump if LF found
	CPI   0DH       ; Test for CR
	JNZ   L4FD5H    
	MOV   A,E       
	CPI   20H       ; Test for space
	JZ    L4FE4H    
	CPI   2CH       ; Test for ,
	MVI   A,0DH     
	JZ    L4FE4H    
L4FD5H:	ORA   A         
	JZ    L4FE4H    
	CMP   D         
	JZ    L4FEAH    
	CMP   E         
	JZ    L4FEAH    
	CALL  L5044H    
L4FE4H:	CALL  L4E7AH    
	JNC   L4F9CH    
L4FEAH:	PUSH  H         
	CPI   22H       ; Test for quote
	JZ    L4FF5H    
	CPI   20H       ; Test for space
	JNZ   L5023H    
L4FF5H:	CALL  L4E7AH    
	JC    L5023H    
	CPI   20H       ; Test for space
	JZ    L4FF5H    
	CPI   2CH       ; Test for ,
	JZ    L5023H    
	CPI   0DH       ; Test for CR
	JNZ   L5015H    
L500AH:	CALL  L4E7AH    
	JC    L5023H    
	CPI   0AH       ; Test for LF
	JZ    L5023H    
L5015H:	LHLD  FC8CH     
	MOV   C,A       
	MVI   A,08H     
	CALL  L4E65H    
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	12H             
	JMP   L504EH    ; Generate NM error
	
L5023H:	POP   H         
L5024H:	MVI   M,00H     
	LXI   H,F684H   
	MOV   A,E       
	SUI   20H       
	JZ    L5036H    
	MVI   B,00H     
	CALL  L276EH    
	POP   H         
	RET             
	
L5036H:	RST   5         ; Determine type of last var used
	PUSH  PSW       
	RST   2         ; Get next non-white char from M
	POP   PSW       
	PUSH  PSW       
	CC    L3840H    ; Convert ASCII number at M to double precision in FAC1
	POP   PSW       
	CNC   L3840H    ; Convert ASCII number at M to double precision in FAC1
	POP   H         
	RET             
	
L5044H:	ORA   A         
	RZ              
	MOV   M,A       
	INX   H         
	DCR   B         
	RNZ             
	POP   PSW       
	JMP   L5024H    
	
	
; ======================================================
; Generate NM error
; ======================================================
L504EH:	MVI   E,37H     
	LXI   B,L351EH  
	LXI   B,L381EH  
	LXI   B,L341EH  
	LXI   B,L3A1EH  
	LXI   B,L331EH  
	LXI   B,L321EH  
	LXI   B,L361EH  
	LXI   B,L391EH  
	JMP   L045DH    ; Generate error in E
	
	
; ======================================================
; LOF function
; ======================================================
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	4EH             
	
; ======================================================
; LOC function
; ======================================================
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	50H             
	
; ======================================================
; LFILES function
; ======================================================
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	52H             
	
; ======================================================
; DSKO$ function
; ======================================================
L5071H:	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	56H             
	
; ======================================================
; DSKI$ function
; ======================================================
L5073H:	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	54H             
L5075H:	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	28H             
	MOV   A,M       ; Get next BASIC line character
	CPI   3AH       ; Test for ':'
	JC    L5096H    ; If less than ':', call RST 7 hook for special processing
	PUSH  H         ; Save pointer to BASIC line on stack
	MOV   D,E       ; Save current count in D in case ':' not found
	CALL  L4C7DH    ; Read next byte and decrement count
	JZ    L5090H    ; Jump to exit if count reaches 0 with no ':' found
L5085H:	CPI   3AH       ; Test for ':' in filename
	JZ    L509BH    ; Jump if ':' found to test length of "DEV:"
	CALL  L4C7DH    ; Read next byte and decrement count
	JP    L5085H    ; Jump to test for ':' if count > 0
L5090H:	MOV   E,D       ; No ':' found. Restore current count from D
	POP   H         ; Restore pointer to BASIC line from stack
	XRA   A         ; Set DCB index to 0
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	2AH             
	RET             
	
L5096H:	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	2EH             
	JMP   L504EH    ; Generate NM error
	
L509BH:	MOV   A,D       ; Get Saved count value
	SUB   E         ; Subtract count prior to ':'
	DCR   A         ; Decrement to account for ':'
	CPI   02H       ; Test if length > 2
	JNC   L50A8H    ; Jump if length > 2 ("CAS", "MDM", etc.)
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	2CH             ; Test for hook to deal with shorter device names
	JMP   L504EH    ; Generate NM error
	
L50A8H:	CPI   05H       ; Test if length > 4 ("WAND" is special)
	JNC   L504EH    ; Generate NM error
	POP   B         ; Pop BASIC line pointer from stack
	PUSH  D         ; Push device length info to stack
	PUSH  B         ; Push BASIC line pointer to stack
	MOV   C,A       ; Put device lenght in B and C to perform multiple search
	MOV   B,A       
	LXI   D,L50F1H  ; Load pointer to known device names table
	XTHL            ; Get BASIC line pointer from stack
	PUSH  H         ; And push another copy back to stack
L50B7H:	CALL  L0FE8H    ; Get char at M and convert to uppercase
	PUSH  B         ; Save calculated device length to stack
	MOV   B,A       ; Put device name character in B
	LDAX  D         ; Get next character from name lookup table
	INX   H         ; Increment BASIC line pointer
	INX   D         ; Increment name lookup pointer
	CMP   B         ; Test for match
	POP   B         ; Restore length from stack
	JNZ   L50DCH    ; Jump to advance to next device if no match
	DCR   C         ; Decrement the length count
	JNZ   L50B7H    ; Jump to test next byte if not zero
L50C8H:	LDAX  D         ; Get next byte from name lookup table
	ORA   A         ; Prepare to test for full name match
	JM    L50D7H    ; If upper bit set (full match), jump to exit
	CPI   31H       ; Test for ASCII '1'? Why?
	JNZ   L50DCH    ; Jump to advance to next device if not '1'?
	INX   D         ; Skip the ASCII '1'. I don't see any in the table
	LDAX  D         ; Load next byte
	JMP   L50DCH    ; Jump to advance to next device name entry
	
L50D7H:	POP   H         ; Pop calculated length
	POP   H         ; Pop BASIC line pointer
	POP   D         ; Pop device length info
	ORA   A         ; Set return flags
	RET             
	
L50DCH:	ORA   A         ; Test if at end of entry
	JM    L50C8H    ; Jump to start search if at end already
L50E0H:	LDAX  D         ; Load next byte from name table
	ORA   A         ; Test for ASCII / control terminator
	INX   D         ; Increment name table pointer
	JP    L50E0H    ; Jump to skip next byte if not at end
	MOV   C,B       ; Restore device length count for next search
	POP   H         ; Restore pointer to BASIC line
	PUSH  H         ; And push it back
	LDAX  D         ; Get 1st byte of device name
	ORA   A         ; Test for terminating NULL
	JNZ   L50B7H    ; Jump if not at end to test next name
	JMP   L504EH    ; Generate NM error
	
	
; ======================================================
; Device name table
; ======================================================
L50F1H:
    DB	"LCD",FFH          
    DB	"CRT",FEH          
    DB	"CAS",FDH          
    DB	"COM",FCH          
    DB	"WAND",FBH          
    DB	"LPT",FAH          
    DB	"MDM",F9H          
    DB	"RAM",F8H          
    DB	00H             
	
; ======================================================
; Device control block vector addresses table
; ======================================================
L5113H:
	DW	14D2H,14F2H,167FH,1762H; LCD, CRT, CAS, COM
	DW	1877H,1754H,17D1H,14FCH; WAND, LPT, MDM, RAM
	
L5123H:	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	30H             ; OPEN hook
	PUSH  H         ; Save FCB pointer on stack
	PUSH  D         ; Preserve DE
	PUSH  PSW       ; Save vector number to stack
	LXI   D,L0004H  ; Load offset in FCB of device type identifier
	DAD   D         ; Point to FCB device type location
	MVI   A,FFH     ; Prepare to calculate device type offset
	SUB   M         ; Calculate device type offset in DCB vector address table
	ADD   A         ; Multiply x2 since each entry is 2 bytes
	MOV   E,A       ; Move to DE to index into table
	MVI   D,00H     ; Clear MSB of index
	LXI   H,L5113H  ; Load pointer to DCB vector address table
	DAD   D         ; Index into the DCB vector address table for appropriate device
	MOV   E,M       ; Get LSB of pointer to DCB vector address table
	INX   H         ; Point to MSB
	MOV   D,M       ; Get MSB of pointer to DCB vector address table
	POP   PSW       ; Restore index of DCB vector to call
	MOV   L,A       ; Prepare to point to selected vector in table
	MVI   H,00H     ; Clear MSB to perform index into table
	DAD   D         ; Index into DCB vector table
	MOV   E,M       ; Get LSB of selected DCB table vector
	INX   H         ; Point to MSB
	MOV   D,M       ; Get MSB of selected DCB table vector
	XCHG            ; Put vector in HL
	POP   D         ; DE now has pointer to FCB
	XTHL            ; Put selected table vector on Stack
	RET             ; And return to it
	
	
; ======================================================
; TELCOM Entry point
; ======================================================
L5146H:	CALL  UNLOCK    ; Resume automatic scrolling
	LXI   H,L51A4H  ; Get pointer to TELCOM FKey labels
	CALL  STDSPF    ; Set and display function keys (M has key table)
	JMP   L51C7H    ; Print current STAT settings
	
; ======================================================
; TELCOM ON ERROR Handler
; ======================================================
L5152H:	CALL  BEEP      ; BEEP statement
	LXI   H,L51A4H  ; Load pointer to Main FKeys
	CALL  STFNK     ; Set new function key table
	
; ======================================================
; Re-entry point for TELCOM commands
; ======================================================
L515BH:	CALL  L5D53H    ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
	LXI   H,L5152H  ; Load pointer to TELCOM ON ERROR handler
	SHLD  F652H     ; Save as active ON ERROR handler vector
	LXI   H,L517CH  ; Load pointer to "Telcom: " prompt
	CALL  L5791H    ; Print buffer at M until NULL or '"'
	CALL  INLIN     ; Input and display (no "?") line and store
	RST   2         ; Get next non-white char from M
	ANA   A         ; Test if TELCOM command is NULL
	JZ    L515BH    ; Re-entry point for TELCOM commands
	LXI   D,L5185H  ; Load pointer to TELCOM instruction vector table
	CALL  L6CA7H    
	JZ    L5152H    ; Jump to ON ERROR handler if error
	RET             
	
L517CH:
    DB	"Telcom:",00H     
	
	
; ======================================================
; TELCOM instruction vector table
; ======================================================
L5185H:
    DB	"STAT"          
	DW	51C0H          
    DB	"TERM"          
	DW	5455H          
    DB	"CALL"          
	DW	522FH          
    DB	"FIND"          
	DW	524DH          
    DB	"MENU"          
	DW	5797H          
    DB	FFH             
	
	
; ======================================================
; TELCOM label line text table
; ======================================================
L51A4H:
    DB	"Find",A0H          
    DB	"Call",A0H          
    DB	"Stat",A0H          
    DB	"Term",8DH          
    DB	80H             
    DB	80H             
    DB	80H             
    DB	"Menu",8DH          
	
; ======================================================
; TELCOM STAT instruction routine
; ======================================================
L51C0H:	DCX   H         
	RST   2         ; Get next non-white char from M
	INR   A         
	DCR   A         
	JNZ   L51EDH    ; Set STAT and return to TELCOM ready
	
; ======================================================
; Print current STAT settings
; ======================================================
L51C7H:	LXI   H,VISTAT  ; RS232 parameter setting table
	MVI   B,05H     
L51CCH:	MOV   A,M       
	RST   4         ; Send character in A to screen/printer
	INX   H         
	DCR   B         
	JNZ   L51CCH    
	MVI   A,2CH     
	RST   4         ; Send character in A to screen/printer
	LDA   VPPSST    ; Dial speed (1=10pps), 2=20pps
	RRC             
	MVI   A,32H     
	SBB   B         
	RST   4         ; Send character in A to screen/printer
	LXI   H,L51E7H  ; Load pointer to "0 pps" text
	CALL  L27B1H    ; Print buffer at M until NULL or '"'
	JMP   L515BH    ; Re-entry point for TELCOM commands
	
L51E7H:
    DB	"0    pps",00H  
	
	
; ======================================================
; Set STAT and return to TELCOM ready
; ======================================================
L51EDH:	JC    L51FEH    
	CPI   2CH       
	JZ    L520AH    
	CALL  L0FE9H    ; Convert A to uppercase
	CPI   4DH       
	JNZ   L5152H    ; Jump to ON ERROR handler if error
	INX   H         
L51FEH:	CALL  L17E6H    ; Set RS232 parameters from string at M
	CALL  L6ECBH    ; Deactivate RS232 or modem
	DCX   H         
	RST   2         ; Get next non-white char from M
	ANA   A         
	JZ    L515BH    ; Re-entry point for TELCOM commands
L520AH:	RST   1         ; Compare next byte with M
    DB	2CH             
	CALL  L112EH    ; Evaluate expression at M-1
	CPI   14H       
	JZ    L521AH    
	SUI   0AH       
	JNZ   L5152H    ; Jump to ON ERROR handler if error
	INR   A         
L521AH:	STA   VPPSST    ; Dial speed (1=10pps), 2=20pps
	JMP   L515BH    ; Re-entry point for TELCOM commands
	
L5220H:	LXI   H,L5244H  ; Load pointer to "Calling " text
	CALL  L5A58H    ; Print NULL terminated string at M
	POP   D         
	CALL  L5284H    ; Display text at (DE) until EOF or EOL
	JZ    L5152H    ; Jump to ON ERROR handler if error
	XCHG            
	ORI   37H       
	PUSH  H         
	LXI   H,L5244H  ; Load pointer to "Calling " text
	CC    L5A58H    ; Print NULL terminated string at M
	POP   H         
	CALL  L532DH    ; Execute logon sequence at M
	JC    L5152H    ; Jump to ON ERROR handler if error
	JNZ   L515BH    ; Re-entry point for TELCOM commands
	JMP   L5468H    ; Jump into TELCOM TERM routine
	
L5244H:
    DB	"Calling",00H     
	
	
; ======================================================
; TELCOM FIND instruction routine
; ======================================================
L524DH:	SUB   A         
	CALL  L5DB1H    
	PUSH  H         
	CALL  L5AA6H    ; Search directory for ADRS.DO file
	JZ    L5152H    ; Jump to ON ERROR handler if error
	CALL  L5AE3H    ; Get start address of file at M
	XCHG            
	POP   H         
L525DH:	CALL  L5C3FH    ; Find text at M in the file at (DE)
	JNC   L515BH    ; Re-entry point for TELCOM commands
	PUSH  H         
	PUSH  D         
	CALL  L5DC5H    ; Setup word-wrap / wrap width based on LCD / Printer output
	CALL  L5284H    ; Display text at (DE) until EOF or EOL
	CNZ   L5292H    ; Print byte in A, continuing until ':' found, expanding '<' to '<>'
	CALL  CRLF      ; Send CRLF to screen or printer
	CALL  L5C7FH    ; TELCOM FIND display / keyscan routine
	JZ    L515BH    ; Re-entry point for TELCOM commands
	CPI   43H       ; Test for 'C'all response
	JZ    L5220H    
	POP   D         
	CALL  L5C6DH    ; Increment DE past next CRLF in text file at (DE)
	POP   H         
	JMP   L525DH    
	
L5284H:	CALL  L52A8H    ; Test for EOL or EOF
	RZ              ; Return if EOL
	RST   4         ; Send character in A to screen/printer
	CPI   3AH       ; Test for ':'
	INX   D         ; Increment pointer
	JNZ   L5284H    ; Jump to print more if not ':'
	JMP   L52AEH    ; Jump to test for EOF
	
L5292H:	CALL  L52A8H    ; Test for EOL or EOF
	RZ              ; Return if EOL
	CPI   3CH       ; Test for '<' character
	JZ    L52A3H    ; If it is '<', Print it followed by '>'
	CPI   3AH       ; Test if character is ':'
	RZ              ; Return if ':'
	RST   4         ; Send character in A to screen/printer
	INX   D         ; Increment file pointer
	JMP   L5292H    
	
L52A3H:	RST   4         ; Send character in A to screen/printer
	MVI   A,3EH     ; Load ASCII '>'
	RST   4         ; Send character in A to screen/printer
	RET             
	
L52A8H:	CALL  L5C74H    ; Check next byte(s) at (DE) for CRLF
	DCX   D         
	LDAX  D         
	RZ              
L52AEH:	CPI   1AH       ; Test for EOF
	JZ    L5152H    ; Jump to ON ERROR handler if error
	RET             
	
	
; ======================================================
; Go off-hook
; ======================================================
L52B4H:	IN    BAH       ; Get current value of 8155 Port B
	ANI   7FH       ; Clear /RTS bit to connect phone line
	OUT   BAH       ; Send new value to I/O port
	RET             
	
	
; ======================================================
; Disconnect phone line and disable modem carrier
; ======================================================
L52BBH:	CALL  L52D8H    ; Disable modem carrier
	CALL  L5351H    
L52C1H:	IN    BAH       ; Get current value of 8155 Port B
	ORI   80H       ; Set /RTS bit to disconnect phone line
	OUT   BAH       ; Send new value to I/O port
	RET             
	
L52C8H:	LDA   FAAEH     ; Contents of port A8H
	ORI   01H       ; Set bit to connect phone line
	JMP   L52DDH    ; Update Modem enable and RS-232 mux settings from A
	
	
; ======================================================
; Connect phone line and enable modem carrier
; ======================================================
L52D0H:	CALL  L52B4H    ; Go off-hook
	MVI   A,03H     ; Set bits to connect phone & enable modem
	JMP   L52DDH    ; Update Modem enable and RS-232 mux settings from A
	
L52D8H:	LDA   FAAEH     ; Contents of port A8H
	ANI   01H       ; Clear Modem Enable bit
L52DDH:	STA   FAAEH     ; Contents of port A8H
	OUT   A8H       
	STC             
	RET             
	
	
; ======================================================
; Go off-hook and wait for carrier
; ======================================================
L52E4H:	IN    BBH       
	ANI   10H       
	JZ    L52F9H    
	CALL  L52D0H    ; Connect phone line and enable modem carrier
L52EEH:	CALL  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	RC              
	CALL  L6EEFH    ; Check for carrier detect
	JNZ   L52EEH    
	RET             
	
L52F9H:	CALL  L52C8H    ; Connect phone line
	CALL  L52B4H    ; Go off-hook
	NOP             
	NOP             
	NOP             
	CALL  L52EEH    
	RC              
	MVI   A,05H     
	CALL  L5316H    
	CALL  L52D0H    ; Connect phone line and enable modem carrier
	ANA   A         
	RET             
	
	
; ======================================================
; Pause for about 2 seconds
; ======================================================
L5310H:	XRA   A         
	MVI   A,05H     
L5313H:	CNZ   L531AH    
L5316H:	DCR   A         
	JNZ   L5313H    
L531AH:	MVI   C,C8H     
L531CH:	CALL  L5326H    
	CALL  L5326H    
	DCR   C         
	JNZ   L531CH    
L5326H:	MVI   B,ACH     
L5328H:	DCR   B         
	JNZ   L5328H    
	RET             
	
	
; ======================================================
; Execute logon sequence at M
; ======================================================
L532DH:	IN    BAH       
	PUSH  PSW       
	ORI   08H       
	OUT   BAH       
	CALL  L5359H    ; Dialing routine
	POP   B         
	PUSH  PSW       
	MOV   A,B       
	ANI   08H       
	MOV   B,A       
	IN    BAH       
	ANI   F7H       
	ORA   B         
	OUT   BAH       
	POP   PSW       
	RNC             
	CALL  L52BBH    ; Disconnect phone line and disable modem carrier
	CALL  L52C8H    ; Connect phone line??
	MVI   A,03H     
	CALL  L5316H    
L5351H:	LDA   FAAEH     ; Contents of port A8H
	ANI   02H       
	JMP   L52DDH    ; Update Modem enable and RS-232 mux settings from A
	
	
; ======================================================
; Dialing routine
; ======================================================
L5359H:	XRA   A         
	STA   FAAEH     ; Contents of port A8H
	CALL  L52C1H    
	CALL  L52C8H    ; Connect phone line
	CALL  L531AH    
	CALL  L52D0H    ; Connect phone line and enable modem carrier
	CALL  L52D8H    ; Disable modem carrier
	CALL  L5310H    ; Pause for about 2 seconds
	DCX   H         
L5370H:	CALL  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	RC              
	PUSH  H         
	XCHG            
	CALL  L5C74H    ; Check next byte(s) at (DE) for CRLF
	DCX   D         
	LDAX  D         
	POP   H         
	JZ    L539EH    ; Auto logon sequence
	CPI   1AH       
	JZ    L539EH    ; Auto logon sequence
	RST   2         ; Get next non-white char from M
	JZ    L539EH    ; Auto logon sequence
	PUSH  PSW       
	CC    L540AH    ; Dial the digit in A & print on LCD
	POP   PSW       
	JC    L5370H    
	CPI   3CH       
	STC             
	JZ    L539EH    ; Auto logon sequence
	CPI   3DH       
	CZ    L5310H    ; Pause for about 2 seconds
	JMP   L5370H    
	
	
; ======================================================
; Auto logon sequence
; ======================================================
L539EH:	PUSH  PSW       
	LDA   VPPSST    ; Dial speed (1=10pps), 2=20pps
	RRC             
	CNC   L531AH    
	POP   PSW       
	JNC   L52BBH    ; Disconnect phone line and disable modem carrier
	LDA   VISTAT    ; RS232 parameter setting table
	CPI   4DH       
	STC             
	RNZ             
	PUSH  H         
	LXI   H,F65CH   
	ANA   A         
	CALL  L17E6H    ; Set RS232 parameters from string at M
	MVI   A,04H     
	CALL  L5316H    
	POP   H         
	CALL  L52E4H    ; Go off-hook and wait for carrier
	RC              
L53C3H:	CALL  L5673H    
	CALL  L5406H    ; Get next auto logon sequence byte and test for NULL
	RZ              ; Return if sequence complete
	CPI   3EH       ; Test for '>'
	RZ              
	CPI   3DH       ; Test for '='
	JZ    L53E7H    
	CPI   5EH       ; Test for '^'
	JZ    L53FDH    ; Jump to send CTRL code if '^'
	CPI   3FH       ; Test for '?'
	JZ    L53EDH    ; Jump to Display only the next byte if '?'
	CPI   21H       ; Test for '!'
	CZ    L5406H    ; Get next auto logon sequence byte and test for NULL
	RZ              ; Return if sequence complete
L53E2H:	CALL  L6E32H    ; Send character in A to serial port using XON/XOFF
	XRA   A         
	INR   A         
L53E7H:	CZ    L5310H    ; Pause for about 2 seconds
	JMP   L53C3H    ; Jump to process next sequence byte
	
L53EDH:	CALL  L5406H    ; Get next auto logon sequence byte and test for NULL
	RZ              ; Return if sequence complete
L53F1H:	CALL  L6D7EH    ; Get a character from RS232 receive queue
	RC              
	RST   4         ; Send character in A to screen/printer
	CMP   M         
	JNZ   L53F1H    
	JMP   L53C3H    ; Jump to process next sequence byte
	
L53FDH:	CALL  L5406H    ; Get next auto logon sequence byte and test for NULL
	RZ              ; Return if sequence complete
	ANI   1FH       ; Convert next byte ASCII to a control code
	JMP   L53E2H    ; Jump to send the control code
	
L5406H:	INX   H         ; Increment sequence pointer
	MOV   A,M       ; Get next byte
	ANA   A         ; Test for zero
	RET             
	
	
; ======================================================
; Dial the digit in A & print on LCD
; ======================================================
L540AH:	RST   4         ; Send character in A to screen/printer
	DI              
	ANI   0FH       
	MOV   C,A       
	JNZ   L5414H    
	MVI   C,0AH     
L5414H:	LDA   VPPSST    ; Dial speed (1=10pps), 2=20pps
	RRC             
	LXI   D,L161CH  
	JNC   L5421H    
	LXI   D,L2440H  
L5421H:	CALL  L52C1H    
L5424H:	CALL  L5326H    
	DCR   E         
	JNZ   L5424H    
	CALL  L52B4H    ; Go off-hook
L542EH:	CALL  L5326H    
	DCR   D         
	JNZ   L542EH    
	DCR   C         
	JNZ   L5414H    
	EI              
	LDA   VPPSST    ; Dial speed (1=10pps), 2=20pps
	ANI   01H       
	INR   A         
	JMP   L5316H    
	
L5443H:
    DB	"Pre",F6H          
    DB	"Dow",EEH          
    DB	"     U",F0H    
    DB	80H             
    DB	80H             
    DB	80H             
    DB	80H             
    DB	"By",E5H          
	
; ======================================================
; TELCOM TERM instruction routine
; ======================================================
L5455H:	LXI   H,F65AH   ; RS232 auto linefeed switch
	RST   2         ; Get next non-white char from M
	CNC   L3457H    ; Increment HL and return
	PUSH  PSW       
	CALL  L17E6H    ; Set RS232 parameters from string at M
	POP   PSW       
	CMC             
	CC    L52E4H    ; Go off-hook and wait for carrier
	JC    L5739H    
L5468H:	MVI   A,40H     
	STA   F650H     
	STA   F67BH     
	XRA   A         
	STA   FAC2H     
	STA   FAC3H     
	CALL  L45D3H    
	LXI   H,L5443H  ; Load TELCOM TERM FKey table pointer
	CALL  STFNK     ; Set new function key table
	CALL  L5544H    
	CALL  L5556H    
	CALL  L5562H    
	CALL  DSPNFK    ; Display function key line
	CALL  CURSON    ; Turn the cursor on
L548FH:	CALL  L5D5DH    
	LXI   H,L54EFH  ; TELCOM TERM on-error return handler.
	SHLD  F652H     ; Long jump return address on error
	LDA   FF42H     ; XON/XOFF enable flag
	ANA   A         
	JZ    L54AAH    
	LDA   FF40H     ; XON/XOFF protocol control
	LXI   H,F7D9H   
	XRA   M         
	RRC             
	CC    L5562H    
L54AAH:	CALL  CHSNS     ; Check keyboard queue for pending characters
	JZ    L54C6H    
	CALL  CHGET     ; Wait for key from keyboard
	JC    L54FCH    ; TELCOM "dispatcher" routine
	MOV   B,A       
	LDA   F658H     ; Full/Half duplex switch
	ANA   A         
	MOV   A,B       
	CZ    LCD       ; Send A to screen or printer
	ANA   A         
	CNZ   L6E32H    ; Send character in A to serial port using XON/XOFF
	JC    L54E2H    
L54C6H:	CALL  L6D6DH    ; Check RS232 queue for pending characters
	JZ    L548FH    
	CALL  L7315H    ; Different from M100: Get a character from RS232 receive queue
	JC    L548FH    
	RST   4         ; Send character in A to screen/printer
	MOV   B,A       
	LDA   F659H     
	ANA   A         
	MOV   A,B       
	CNZ   PRTTAB    ; Print A to printer), expanding tabs if necessary
	CALL  L56C5H    
	JMP   L548FH    
	
L54E2H:	XRA   A         
	STA   FF40H     ; XON/XOFF protocol control
L54E6H:	CALL  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	JC    L54E6H    
	JMP   L548FH    
	
L54EFH:	CALL  BEEP      ; BEEP statement
	XRA   A         
	STA   F659H     
	CALL  L5556H    
	JMP   L548FH    
	
	
; ======================================================
; TELCOM "dispatcher" routine
; ======================================================
L54FCH:	MOV   E,A       
	MVI   D,FFH     
	LXI   H,L551DH  ; TERM Mode function key vector table
	DAD   D         
	DAD   D         
	MOV   A,M       
	INX   H         
	MOV   H,M       
	MOV   L,A       
	LXI   D,L548FH  
	PUSH  D         
	PCHL            
	
	
; ======================================================
; TERM Mode function key vector table
; ======================================================
	DW	5523H,567EH,559DH,553EH
	DW	5550H,551DH,5520H,571EH
	
L551DH:
    DB	FFH             ; Jump to RST 38H Vector entry of following byte
	
	STA   FFC9H     
	INR   M         
	RET             
	
	
; ======================================================
; TELCOM PREV function routine
; ======================================================
L5523H:	CALL  L43A2H    ; Conditionally POP PSW from stack based on value at FAC7H
	CALL  CUROFF    ; Turn the cursor off
	CALL  L461FH    
L552CH:	CALL  CHSNS     ; Check keyboard queue for pending characters
	JZ    L552CH    
	CALL  CHGET     ; Wait for key from keyboard
	CALL  L4601H    
	CALL  CURSON    ; Turn the cursor on
	JMP   SDESCX    ; Send ESC X
	
	
; ======================================================
; TELCOM FULL/HALF function routine
; ======================================================
	LXI   H,F658H   ; Full/Half duplex switch
	MOV   A,M       
	CMA             
	MOV   M,A       
L5544H:	LDA   F658H     ; Full/Half duplex switch
	LXI   D,F7B9H   
	LXI   H,L5583H  ; Load pointer to TELCOM "FullHalfEcho" text
	JMP   L556BH    
	
	
; ======================================================
; TELCOM ECHO function routine
; ======================================================
L5550H:	LXI   H,F659H   
	MOV   A,M       
	CMA             
	MOV   M,A       
L5556H:	LDA   F659H     
	LXI   D,F7C9H   
	LXI   H,L558BH  
	JMP   L556BH    
	
L5562H:	LDA   FF40H     ; XON/XOFF protocol control
	LXI   D,F7D9H   
	LXI   H,L5595H  ; Load pointer to "Wait" text
L556BH:	ANA   A         
	LXI   B,L0004H  
	JNZ   L5573H    
	DAD   B         
L5573H:	MOV   B,C       
	CALL  L2542H    ; Move B bytes from M to (DE)
	MVI   B,0CH     
	XRA   A         
L557AH:	STAX  D         
	INX   D         
	DCR   B         
	JNZ   L557AH    
	JMP   FNKSB     ; Display function keys on 8th line
	
L5583H:
    DB	"FullHalfEcho",0DH     
    DB	"     Wait",00H 
    DB	20H,20H          
	
	
; ======================================================
; TELCOM UP function routine
; ======================================================
	LXI   H,L56EFH  ; Load TELCOM UP ON ERROR handler address
	SHLD  F652H     ; Save as active ON ERROR handler vector
	PUSH  H         
	LDA   FAC2H     
	ANA   A         
	RNZ             
	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	LXI   H,L5751H  ; Load pointer to "File to upload" text
	CALL  L5791H    ; Print buffer at M until NULL or '"'
	CALL  L463EH    ; Input and display line and store
	RST   2         ; Get next non-white char from M
	ANA   A         
	RZ              
	STA   FAC6H     
	CALL  L21FAH    ; Count length of string at M
	CALL  L4C0BH    
	RNZ             
	CALL  L208FH    ; Find .DO or ." " file in catalog
	LXI   H,L577CH  ; Load pointer to "No file" text
	JZ    L5791H    ; Print buffer at M until NULL or '"'
	XCHG            
	XTHL            
	PUSH  H         
	LXI   H,L670CH  ; Load pointer to "Width:" text
	CALL  L5791H    ; Print buffer at M until NULL or '"'
	CALL  INLIN     ; Input and display (no "?") line and store
	RC              
	RST   2         ; Get next non-white char from M
	ANA   A         
	MVI   A,01H     
	STA   FAC3H     
	STA   F920H     
	JZ    L55FDH    
	CALL  L112EH    ; Evaluate expression at M-1
	CPI   0AH       
	RC              
	CPI   85H       
	RNC             
	LXI   H,F894H   
	SHLD  F892H     ; Save pointer to current position in line buffer
	STA   F922H     ; Output format width (40 or something else for CTRL-Y)
	STA   FAC3H     
	POP   PSW       
	POP   D         
	LXI   B,E1F1H   
	PUSH  D         
	PUSH  H         
	CALL  FNKSB     ; Display function keys on 8th line
	POP   H         
	POP   D         
L5606H:	LDA   FAC3H     
	DCR   A         
	JZ    L562DH    
	PUSH  D         
	XCHG            
	LHLD  F892H     ; Get pointer to current position in line buffer
	XCHG            
	RST   3         ; Compare DE and HL
	POP   D         
	JNZ   L562DH    
	CALL  L67DFH    ; Build next line from .DO file at (DE) into line buffer
	MOV   A,D       
	ANA   E         
	INR   A         
	JNZ   L562AH    
	LHLD  F892H     ; Get pointer to current position in line buffer
	MVI   M,1AH     
	INX   H         
	SHLD  F892H     ; Save pointer to current position in line buffer
L562AH:	LXI   H,F894H   
L562DH:	MOV   A,M       
	CPI   1AH       
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	36H             
	JZ    L566CH    
	CPI   0AH       
	JNZ   L5646H    
	LDA   F65AH     ; RS232 auto linefeed switch
	ANA   A         
	JNZ   L5646H    
	LDA   FAC6H     
	CPI   0DH       
L5646H:	MOV   A,M       
	STA   FAC6H     
	JZ    L5653H    
	CALL  L6E32H    ; Send character in A to serial port using XON/XOFF
	CALL  L5673H    
L5653H:	INX   H         
	CALL  CHSNS     ; Check keyboard queue for pending characters
	JZ    L5606H    
	CALL  CHGET     ; Wait for key from keyboard
	CPI   03H       
	JZ    L566CH    
	CPI   13H       
	CZ    CHGET     ; Wait for key from keyboard
	CPI   03H       
	JNZ   L5606H    
L566CH:	XRA   A         
	STA   FAC3H     
	JMP   FNKSB     ; Display function keys on 8th line
	
L5673H:	CALL  L6D6DH    ; Check RS232 queue for pending characters
	RZ              
	CALL  L6D7EH    ; Get a character from RS232 receive queue
	RST   4         ; Send character in A to screen/printer
	JMP   L5673H    
	
	
; ======================================================
; TELCOM DOWN function routine
; ======================================================
	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	LDA   FAC2H     
	XRI   FFH       
	STA   FAC2H     
	JZ    L56BFH    
	LXI   H,L56E2H  ; Load address of TELCOM DOWN ON ERROR handler
	SHLD  F652H     ; Save as active ON ERROR handler vector
	PUSH  H         
	LXI   H,L5760H  ; Load pointer to "File to download" text
	CALL  L5791H    ; Print buffer at M until NULL or '"'
	CALL  L463EH    ; Input and display line and store
	RST   2         ; Get next non-white char from M
	ANA   A         
	RZ              
	STA   FAC6H     
	POP   PSW       
L56A3H:	PUSH  H         
	CALL  L2206H    ; Get .DO filename and locate in RAM directory
	JC    L56B7H    
	SHLD  FAC4H     
	CALL  L6B2DH    ; Find end of DO file (find the 1Ah) at (HL)
	POP   PSW       
	CALL  L634AH    ; Expand .DO file so it fills all memory for editing
	JMP   FNKSB     ; Display function keys on 8th line
	
L56B7H:	XCHG            
	CALL  L1FBFH    ; Kill a text file
	POP   H         
	JMP   L56A3H    
	
L56BFH:	CALL  FNKSB     ; Display function keys on 8th line
	JMP   L6383H    ; Delete zeros from end of edited DO file and update pointers
	
L56C5H:	MOV   C,A       
	LDA   FAC2H     
	ANA   A         
	MOV   A,C       
	RZ              
	CALL  L56FEH    ; Test char in A for EOF,CR,LF,DEL,other
	RZ              ; Return if control char (EOF,CR,LF,DEL)
	JNC   L56D8H    
	CALL  L56D8H    
	MVI   A,0AH     
L56D8H:	LHLD  FAC4H     
	CALL  L6396H    ; Insert byte in A to .DO file at address HL.
	SHLD  FAC4H     
	RNC             
L56E2H:	XRA   A         
	STA   FAC2H     
	CALL  FNKSB     ; Display function keys on 8th line
	LXI   H,L5768H  ; Load pointer to "Download" text
	JMP   L56F2H    ; Jump to print M to SCREEN
	
L56EFH:	LXI   H,L5759H  ; Load pointer to "Upload" text
L56F2H:	CALL  L5791H    ; Print buffer at M until NULL or '"'
	LXI   H,L5771H  ; Load pointer to "aborted" text
	CALL  L27B1H    ; Print buffer at M until NULL or '"'
	JMP   L548FH    
	
L56FEH:	MOV   C,A       ; Save character in C
	ANA   A         ; Test if character is zero
	RZ              ; Return if zero
	CPI   1AH       ; Test for EOF character
	RZ              ; Return if EOF
	CPI   7FH       ; Test for DEL character
	RZ              ; Return if DEL
	CPI   0AH       ; Test for newline character
	JNZ   L5711H    ; Jump ahead if not newline
	LDA   FAC6H     
	CPI   0DH       ; Test for CR character
L5711H:	MOV   A,C       ; Restore the byte
	STA   FAC6H     ; Save the byte in FAC6H
	RZ              ; Return if CR or LF
	CPI   0DH       ; Test if it was CR
	STC             
	CMC             
	RNZ             
	ANA   A         
	STC             
	RET             
	
	
; ======================================================
; TELCOM BYE function routine
; ======================================================
	LXI   H,L5786H  ; Load pointer to "Disconnect" text
	CALL  L5791H    ; Print buffer at M until NULL or '"'
	CALL  L463EH    ; Input and display line and store
	RST   2         ; Get next non-white char from M
	CALL  L0FE9H    ; Convert A to uppercase
	CPI   59H       ; Test for "Y" response
	JZ    L5739H    ; Jump if "Y" pressed
	LXI   H,L5771H  ; Load pointer to "aborted" text
	CALL  L5791H    ; Print buffer at M until NULL or '"'
	JMP   L548FH    ; Jump back into TELCOM TERM routine
	
L5739H:	XRA   A         
	STA   F650H     
	MOV   L,A       
	MOV   H,A       
	SHLD  FAC2H     
	CALL  L6ECBH    ; Deactivate RS232 or modem
	CALL  CUROFF    ; Turn the cursor off
	CALL  L52BBH    ; Disconnect phone line and disable modem carrier
	CALL  L6370H    ; Test for an expanded .DO file and re-collapse if expanded
	JMP   L5146H    ; TELCOM Entry point
	
L5751H:
    DB	"File toUpload",00H
L5760H:
    DB	"File toDownload",00H
L5771H:
    DB	"     aborted",0DH,0AH,00H
L577CH:
    DB	"No   file",0DH,0AH,00H
L5786H:
    DB	"Disconnect",00H          
	
	
; ======================================================
; Print buffer at M until NULL or '"'
; ======================================================
L5791H:	CALL  L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	JMP   L27B1H    ; Print buffer at M until NULL or '"'
	
	
; ======================================================
; MENU Program
; ======================================================
L5797H:	LHLD  FB67H     ; File buffer area pointer
	SHLD  VTPRAM    ; BASIC string buffer pointer
	CALL  L3F2CH    ; Initialize BASIC variables for new execution
	CALL  L6ECBH    ; Deactivate RS232 or modem
	CALL  L6370H    ; Test for an expanded .DO file and re-collapse if expanded
	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	CALL  EXTREF    ; Cancel inverse character mode
	CALL  CUROFF    ; Turn the cursor off
	CALL  ERAFNK    ; Erase function key display
	CALL  LOCK      ; Stop automatic scrolling
	LDA   F638H     ; New Console device flag
	STA   FDFAH     ; Save SCREEN selection
	MVI   A,FFH     
	STA   FAC8H     
	INR   A         ; Increment A to zero
	STA   F650H     ; Clear Keyboard Scan modifier
	STA   FAADH     ; Label line enable flag
	CALL  L1E3CH    ; Switch to SCREEN 0 (LCD. MENU never on DVI)
	CALL  L5D4DH    ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
	LXI   H,L5797H  ; Set MENU program as the ON ERROR handler
	SHLD  F652H     ; Save as active ON ERROR handler vector
	CALL  CLRFLKH   ; Clear function key definition table
	CALL  L5A12H    ; Print time), day and date on first line of screen
	LXI   H,L1C01H  ; Load code for ROW1, COL 28 (Copyright notice location)
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	LXI   H,L5B0DH  ; Load pointer to copyright text
	CALL  L5A58H    ; Print NULL terminated string at M
	LXI   H,FDA1H   ; Map of MENU entry positions to RAM directory positions
	SHLD  FDD7H     ; Current position in Map of MENU entry positions
	MVI   B,36H     ; Prepare to set all Map entries to 0xFFFF
L57EDH:	MVI   M,FFH     ; Set next byte in map to 0xFF
	INX   H         ; Increment pointer to Map
	DCR   B         ; Decrement counter
	JNZ   L57EDH    ; Loop for all 2-byte pointer entries
	MOV   L,B       ; Zero out count of entries displayed
	LXI   D,L5B1EH  ; Directory file-type display order table
	
; ======================================================
; Display directory entries
; ======================================================
L57F8H:	LDAX  D         ; Get the next type of entries to display from table
	ORA   A         ; Test for end of file
	JZ    L5807H    ; Exit loop if at end of table
	MOV   C,A       ; Put display file type in C
	PUSH  D         ; Save table pointer
	CALL  L5970H    ; Display directory entries of type in register C
	POP   D         ; Restore table pointer
	INX   D         ; Increment to next file type to be displayed
	JMP   L57F8H    ; Display directory entries
	
L5807H:	MOV   A,L       
	DCR   A         
	STA   FDEFH     ; Maximum MENU directory location
	CPI   17H       
	JZ    L5823H    
L5811H:	CALL  L59C9H    ; Position cursor for next directory entry
	PUSH  H         ; Save cursor position to stack
	LXI   H,L5B1AH  ; Load pointer to "-.-" text
	CALL  L5A58H    ; Print NULL terminated string at M
	POP   H         ; Restore cursor position
	INR   L         ; Increment MENU entry counter
	MOV   A,L       ; Put counter in A
	CPI   18H       ; Test if 24 entries populated
	JNZ   L5811H    ; Jump until all 24 entries populated
L5823H:	SUB   A         ; Set A to zero
	STA   FDD9H     ; Temp storage for converted filename string
	STA   FDEEH     ; Current MENU directory location
	MOV   L,A       ; Prepare to invert menu entry zero
	CALL  L59E5H    ; Invert the "BASIC" directory entry
	LXI   H,L1808H  ; Set the cursor on the bottom row
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	CALL  L7EACH    ; Display number of free bytes on LCD
	
; ======================================================
; Handle CTRL-U key from MENU command loop
; ======================================================
L5837H:	CALL  L5D4DH    ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
	LXI   H,L5906H  ; Load pointer to CTRL-U ON ERROR handler
	SHLD  F652H     ; Save as active ON ERROR handler vector
	LXI   H,L0108H  ; Cursor position is Col1, row 8
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	LXI   H,L5B24H  ; Load poiner to "Select: _" text
	CALL  L5A58H    ; Print NULL terminated string at M
	LXI   H,L0908H  ; Position the cursor after the "Select: " text
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	SUB   A         
	STA   FDEDH     ; Flag to indicate MENU entry location or command entry
	LXI   H,FDD9H   ; Temp storage for converted filename string
	INR   A         
	
; ======================================================
; MENU Program command loop
; ======================================================
L585AH:	CZ    BEEP      ; BEEP statement
L585DH:	CALL  L5D70H    ; Print time on top line until key pressed
	CALL  L5D64H    ; Wait for char from keyboard & convert to uppercase
	CPI   0DH       ; Test for enter
	JZ    L58F7H    ; Handle ENTER key from MENU command loop
	CPI   08H       ; Test for backspace
	JZ    L588EH    ; Handle Backspace key from MENU command loop
	CPI   7FH       ; Test for DEL
	JZ    L588EH    ; Handle Backspace key from MENU command loop
	CPI   15H       
	JZ    L5837H    ; Handle CTRL-U key from MENU command loop
	CPI   20H       ; Test for SPACE
	JC    L589CH    ; Jump to handle arrow keys
	MOV   C,A       
	LDA   FDEDH     ; Flag to indicate MENU entry location or command entry
	CZ    L5897H    ; Call to handle SPACE if space pressed
	CPI   09H       ; Test for TAB
	JZ    L585AH    ; MENU Program command loop
	CALL  L5D88H    ; Print the keystroke followed by '_'
	JMP   L585DH    ; Loop in MENU program - no BEEP
	
	
; ======================================================
; Handle Backspace key from MENU command loop
; ======================================================
L588EH:	CALL  L5D9EH    ; Delete keystroke from MENU command buffer and erase from LCD
	JZ    L585AH    ; MENU Program command loop
	JMP   L585DH    ; MENU Program command loop - no BEEP
	
L5897H:	ORA   A         ; Test if keyboard entry active
	RNZ             ; Return if keyboard entry active - space not allowed
	POP   PSW       ; Pop the return address and discard it
	MVI   A,1CH     ; SPACE is same as RIGHT
L589CH:	PUSH  PSW       ; Push keystroke to stack
	LDA   FDEEH     ; Current MENU directory location
	MOV   E,A       ; Put current MENU directory location in E
	POP   PSW       ; Pop keystroke
	SUI   1CH       ; Subtract value of lowest ARROW (left)
	LXI   B,L585DH  ; Load address of MENU loop re-entry
	PUSH  B         ; And push it to the stack
	RM              ; Return if not arrow key
	LXI   B,L58C3H  ; Load address of routine to update cursor position
	PUSH  B         ; Push it to the stack as the return address
	JZ    L58EBH    ; If RIGHT ARROW, jump to Increment MENU entry location and wrap
	DCR   A         ; Test for LEFT arrow
	JZ    L58E2H    ; If LEFT ARROW, jump to Decrement MENU entry and wrap to max entries
	DCR   A         ; Decrement to test for UP / DOWN arrow
	POP   B         ; Pop "update routine" return address from stack
	JZ    L58DBH    ; If UP arrow, jump to move cursor up 1 line
	MOV   A,E       ; Get current MENU directory location
	ADI   04H       ; Add 4 (down 1 row)
	MOV   D,A       ; Save in D
	LDA   FDEFH     ; Maximum MENU directory location
	CMP   D         ; Test if beyond last entry
	RM              ; Return if beyond last entry (no update needed)
	MOV   A,D       ; Restore value
L58C3H:	STA   FDEEH     ; Current MENU directory location
	PUSH  H         ; Preserve HL
	LHLD  VCURLN    ; Cursor row (1-8)
	PUSH  H         ; Save the cursor ROW/COL to the stack
	MOV   L,E       ; Put old cursor location in L
	PUSH  D         ; Save old MENU location to stack
	CALL  L59E5H    ; Invert MENU directory entry in L
	POP   D         ; Pop new MENU location from stack
	MOV   L,D       ; Move new location to L
	CALL  L59E5H    ; Invert MENU directory entry in L
	POP   H         ; Restore the cursor ROW/COL from stack
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	POP   H         ; Restore HL
	RET             
	
L58DBH:	MOV   A,E       ; Get current MENU directory location
	SUI   04H       ; Subtract 4 (up 1 line)
	MOV   D,A       ; Save updated value
	RM              ; Return if at top of LCD (no update)
	PUSH  B         ; Cursor update needed ... push address of routine to stack
	RET             ; And "return" to it
	
L58E2H:	MOV   A,E       ; Get current entry
	DCR   A         ; Decrement
	MOV   D,A       ; Save new value in D
	RP              ; Return if still positive
	LDA   FDEFH     ; Maximum MENU directory location
	MOV   D,A       ; Save new entry in D
	RET             ; This returns to the update cursor routine
	
L58EBH:	MOV   A,E       ; Get current MENU directory location
	INR   A         ; Increment the entry location
	MOV   D,A       ; Save it in D
	LDA   FDEFH     ; Maximum MENU directory location
	CMP   D         ; Test if entry > max
	MOV   A,D       ; Restore entry
	RP              ; Return if not > max
	SUB   A         ; Wrap back to zero
	MOV   D,A       ; Put updated entry in D
	RET             ; This returns to the update cursor routine
	
	
; ======================================================
; Handle ENTER key from MENU command loop
; ======================================================
L58F7H:	LDA   FDEDH     ; Flag to indicate MENU entry location or command entry
	ORA   A         ; Test if keyboard entry made
	JZ    L590CH    ; Jump if no keyboard entry to launch selected item
	MVI   M,00H     ; NULL terminate the keyboard entered selection
	CALL  L5AB1H    ; Search directory for filename
	JNZ   L5921H    ; Launch program / file whose catalog address is in HL
L5906H:	CALL  BEEP      ; BEEP statement
	JMP   L5837H    ; Handle CTRL-U key from MENU command loop
	
L590CH:	LDA   FDEEH     ; Current MENU directory location
	LXI   H,FDA1H   ; Map of MENU entry positions to RAM directory positions
	LXI   D,L0002H  ; Size of each MENU Map entry
L5915H:	ORA   A         ; Test if this MENU entry was selected
	JZ    L591EH    ; Jump if it is this entry
	DAD   D         ; Point to next entry in the map
	DCR   A         ; Decrement the entry counter
	JMP   L5915H    ; Loop to find the entry
	
L591EH:	CALL  L5AE4H    ; Load HL = (HL) using DE ... Get address of catalog entry
L5921H:	PUSH  H         ; Save Catalog Entry address to stack
	CALL  CLS       ; CLS statement
	CALL  UNLOCK    ; Resume automatic scrolling
	LDA   FDFAH     ; Restore SCREEN selection
	CALL  L1E3CH    ; Process SCREEN number selection (0 or 1)
	MVI   A,0CH     ; Load Clear Screen code
	RST   4         ; Send character in A to screen/printer
	SUB   A         ; Set A=0
	STA   FAC8H     
	MOV   L,A       ; Prepare to NULL error long jump return address
	MOV   H,L       ; Prepare to NULL error long jump return address
	SHLD  F652H     ; Long jump return address on error
	DCR   A         ; Set A=0xFF
	STA   FAADH     ; Label line enable flag
	POP   H         ; Pop Catalog entry address from stack
	MOV   A,M       ; Get selected entry type byte
	CALL  L5AE3H    ; Get start address of file at M
	CPI   A0H       
	JZ    L254BH    ; Launch .CO files from MENU
	CPI   B0H       
	JZ    L596FH    ; Launch ROM command file from MENU program
	CPI   F0H       
	JZ    F624H     ; Call Hook routine copied to RAM to jump to OptROM
	CPI   C0H       
	JZ    L5F65H    ; Edit .DO files
	SHLD  VBASPP    ; Start of BASIC program pointer
	DCX   D         
	DCX   D         
	XCHG            
	SHLD  FA8CH     ; Mark BASIC program as active program
	CALL  L05F0H    ; Update line addresses for current BASIC program
	CALL  L6C9CH    ; Copy BASIC Function key table to key definition area
	CALL  L6C7FH    
	CALL  L3F28H    ; Initialize BASIC Variables for new execution
	JMP   L0804H    ; Execute BASIC program
	
	
; ======================================================
; Launch ROM command file from MENU program
; ======================================================
L596FH:	PCHL            
	
	
; ======================================================
; Display directory entries of type in register C
; ======================================================
L5970H:	MVI   B,1BH     ; Max 27 entries in catalog
	LXI   D,F962H   ; Start of RAM directory
L5975H:	LDAX  D         ; Get file type byte from directory
	INR   A         ; Test for unused 0xFF
	RZ              ; Return if no more files
	DCR   A         ; Restore value
	CMP   C         ; Test if type matches C
	JNZ   L59A1H    ; If type doesn't match, go advance pointer
	PUSH  B         ; \
	PUSH  D         ; > Save regs
	PUSH  H         ; /
	LHLD  FDD7H     ; Map of MENU entry positions to RAM directory positions
	MOV   M,E       ; Save directory entry address of this menu item, LSB
	INX   H         ; Advance pointer to map
	MOV   M,D       ; Save directory entry address of this menu item, MSB
	INX   H         ; Advance map pointer
	INX   D         ; Advance to catalog entry filename
	INX   D         ; ...
	INX   D         ; ...
	SHLD  FDD7H     ; Map of MENU entry positions to RAM directory positions
	POP   H         ; Get count from stack
	CALL  L59C9H    ; Position cursor for next directory entry
	PUSH  H         ; Push count back to stack
	LXI   H,FDD9H   ; Temp storage for converted filename string
	PUSH  H         ; Save start of string on stack
	CALL  L59ADH    ; Convert filename from space padded to '.ext' format
	POP   H         ; Restore strat of string for printing
	CALL  L5A58H    ; Print NULL terminated string at M
	POP   H         ; Restore count from stack
	INR   L         ; Increment count of entries displayed
	POP   D         ; Restore DE
	POP   B         ; Restore BC
L59A1H:	PUSH  H         ; Preserve count (in L)
	LXI   H,L000BH  ; Each entry is 11 bytes
	DAD   D         ; Point to next entry in catalog
	XCHG            ; Put new pointer back in DE
	POP   H         ; Restore count
	DCR   B         ; Decrement max entry count
	JNZ   L5975H    ; Process next entry if not at end
	RET             
	
	
; ======================================================
; Convert filename from space padded to '.ext' format
; ======================================================
L59ADH:	MVI   A,06H     ; Copy 6 filename bytes
	CALL  L5A62H    ; Copy A bytes from (DE) to M
	MVI   A,20H     ; Get ASCII space
L59B4H:	DCX   H         ; Decrement HL to find trailing spaces
	CMP   M         ; Test for padding space
	JZ    L59B4H    ; Jump to decrement again if SPACE found
	INX   H         ; Post-loop increment .. last was not SPACE
	MVI   M,00H     ; NULL terminate after filename
	LDAX  D         ; Get filename extension byte
	CPI   20H       ; Test for space
	RZ              ; Return if extension byte is space
	MVI   M,2EH     ; Add a '.'
	INX   H         ; Increment the string pointer
	CALL  L5A60H    ; Copy 2 bytes from (DE) to M
	MVI   M,00H     ; NULL terminate the string
	RET             
	
	
; ======================================================
; Position cursor for next directory entry
; ======================================================
L59C9H:	PUSH  D         ; Save regs on stack
	PUSH  H         ; ...
	MOV   A,L       ; Put entry count in A
	RAR             ; A = count / 2
	RAR             ; A = count / 4
	ANI   3FH       ; Keep only lower bits (this is the row #)
	MOV   E,A       ; Put row number in E
	INR   E         ; Make row number 1 based
	INR   E         ; Skip top row (Time, copyright, etc. goes there)
	MOV   A,L       ; Get count in A
	ANI   03H       ; Determine which of the 4 columns to display in
	ADD   A         ; A = COL * 2
	MOV   D,A       ; Save in D
	ADD   A         ; A = COL * 4
	ADD   A         ; A = COL * 8
	ADD   D         ; A = COL * 10 (10 chars per entry)
	MOV   D,A       ; Save in D
	INR   D         ; Display the entry 2 COLS indented
	INR   D         ; ...
	XCHG            ; Put COL / ROW
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	POP   H         ; Restore regs
	POP   D         ; ...
	RET             
	
L59E5H:	CALL  L73C5H    ; Turn off background task, blink & reinitialize cursor blink time
	CALL  L59C9H    ; Position cursor for next directory entry
	MVI   B,0AH     ; Invert 10 characters
	PUSH  H         
	LXI   H,VCURCL  ; Cursor column (1-40)
	DCR   M         
L59F2H:	PUSH  B         
	PUSH  D         
	LHLD  VCURLN    ; Cursor row (1-8)
	CALL  L45CBH    ; Invert the Reverse Video flag for LCD position at (H,L)
	XCHG            
	CALL  SETCUR    
	DI              
	CALL  L73A9H    ; Blink the cursor
	EI              
	POP   D         
	LXI   H,VCURCL  ; Cursor column (1-40)
	INR   M         
	POP   B         
	DCR   B         ; Decrement character counter
	JNZ   L59F2H    ; Loop to invert all 10 LCD characters
	CALL  L73C5H    ; Turn off background task, blink & reinitialize cursor blink time
	POP   H         
	RET             
	
	
; ======================================================
; Print time), day and date on first line of screen
; ======================================================
L5A12H:	CALL  CLS       ; CLS statement
	
; ======================================================
; Print time),day),date on first line w/o CLS
; ======================================================
L5A15H:	CALL  L5D6AH    ; Home cursor
	LXI   H,FD8BH   
	CALL  L192FH    ; DATE$ function
	MVI   M,20H     
	INX   H         
	CALL  L1962H    ; Read day and store at M
	XCHG            
	MVI   M,20H     
	INX   H         
	CALL  L190FH    ; Read time and store it at M
	MVI   M,00H     
	LDA   F92CH     ; Month (1-12)
	LXI   H,L5AE6H  ; Load pointer to Month ASCII table (-3)
	LXI   B,L0003H  ; Point to "MENU" Text
L5A36H:	DAD   B         
	DCR   A         
	JNZ   L5A36H    
	LXI   D,FD88H   
	XCHG            
	PUSH  H         
	MOV   A,C       
	CALL  L5A62H    ; Copy A bytes from (DE) to M
	MOV   D,H       
	MOV   E,L       
	MVI   M,20H     
	INX   D         
	INX   D         
	INX   D         
	INX   H         
	CALL  L5A60H    ; Copy 2 bytes from (DE) to M
	MVI   M,2CH     ; Load ASCII ':'
	INX   H         
	MVI   M,32H     ; Put Year 10's in string
	INX   H         
	MVI   M,30H     ; Put Year 1's in string
	POP   H         
	
; ======================================================
; Print NULL terminated string at M
; ======================================================
L5A58H:	MOV   A,M       ; Get next byte from string
	ORA   A         ; Test for NULL termination
	RZ              ; Return if at end
	RST   4         ; Send character in A to screen/printer
	INX   H         ; Increment string pointer
	JMP   L5A58H    ; Print NULL terminated string at M
	
L5A60H:	MVI   A,02H     
	
; ======================================================
; Copy A bytes from (DE) to M
; ======================================================
L5A62H:	PUSH  PSW       ; Save count to stack
	LDAX  D         ; Get next byte from DE
	MOV   M,A       ; Copy byte to (HL)
	INX   D         ; Increment src pointer
	INX   H         ; Increment dest pointer
	POP   PSW       ; Get count from stack
	DCR   A         ; Decrement count
	JNZ   L5A62H    ; Copy A bytes from (DE) to M
	RET             
	
	
; ======================================================
; Compare string at DE with that at M (max C bytes)
; ======================================================
L5A6DH:	LDAX  D         ; Get next byte
	CMP   M         ; Compare with next byte
	RNZ             ; Return if no match
	ORA   A         ; Test for end of string
	RZ              ; Return if end of string
	INX   H         ; Increment pointer
	INX   D         ; Increment pointer
	DCR   C         ; Decrement counter
	JNZ   L5A6DH    ; Compare string at DE with that at M (max C bytes)
	RET             
	
	
; ======================================================
; L5A79H: Clear function key definition table (fills
;        with 80's)
; Entry conditions: none
; Exit conditions: none
; ======================================================
CLRFLK:	LXI  H,L5B3EH
	
; ======================================================
; L5A7CH: Set function key definitions
; Entry conditions:
;       HL = Address of function table (above)
; Exit conditions: none
; ======================================================
STFNK:	LXI  D,F789H    ; Function key definition area
    	MVI  B,08H
L5A81:	MVI  C,10H
L5A83:	MOV  A,M
	INX  H
	ORA  A
	PUSH PSW
	ANI  7FH
	STAX D
	POP  PSW
	JM   L5A93
	INX  D
	DCR  C
	JNZ  L5A83
L5A93:	SUB  A
l5A94:	INX  D
	DCR  C
	STAX D
	JNZ  l5A94
	DCR  B
	JNZ  L5A81
	
; ======================================================
; L5A9EH Display function table (if enabled)
; Entry conditions: none
; Exit conditions:  none
; ======================================================
FNKSB:	LDA  VLABLF     ; Label line protect status
	ORA  A
	CNZ  DSPNFK     ; Display function key line
	RET
	
; ======================================================
; Search directory for ADRS.DO file
; ======================================================
L5AA6H:	LXI   D,L5CCEH  ; Load address of "ADRS.DO" text
	
; ======================================================
; Search directory for filename
; ======================================================
L5AA9H:	MVI   A,08H     
	LXI   H,FDD9H   
	CALL  L5A62H    ; Copy A bytes from (DE) to M
L5AB1H:	MVI   B,1BH     
	LXI   D,F962H   ; Start of RAM directory
L5AB6H:	LXI   H,FDF0H   
	LDAX  D         
	INR   A         
	RZ              
	ANI   80H       
	JZ    L5AD9H    
	PUSH  D         
	INX   D         
	INX   D         
	INX   D         
	PUSH  H         
	CALL  L59ADH    ; Convert filename from space padded to '.ext' format
	POP   H         
	MVI   C,09H     
	LXI   D,FDD9H   
	CALL  L5A6DH    ; Compare string at DE with that at M (max C bytes)
	JNZ   L5AD8H    
	POP   H         
	INR   C         
	RET             
	
L5AD8H:	POP   D         ; Restore start of current entry
L5AD9H:	LXI   H,L000BH  ; 11 bytes per entry
	DAD   D         ; Point to next entry
	XCHG            ; Put address back in DE
	DCR   B         ; Decrement catalog entry count
	JNZ   L5AB6H    ; Jump to continue search if more entries
	RET             
	
	
; ======================================================
; Get start address of file at M
; ======================================================
L5AE3H:	INX   H         ; Skip File Type Byte
L5AE4H:	MOV   E,M       ; Get LSB of start of file
	INX   H         ; Skip to MSB
L5AE6H:	MOV   D,M       ; Get MSB of start of file
	XCHG            ; Put file address in DE
	RET             
	
    DB	"Jan"           
    DB	"Feb"           
    DB	"Mar"           
    DB	"Apr"           
    DB	"May"           
    DB	"Jun"           
    DB	"Jly"           
    DB	"Aug"           
    DB	"Sep"           
    DB	"Oct"           
    DB	"Nov"           
    DB	"Dec"           
L5B0DH:
    DB	"(C)Microsoft",00H          
L5B1AH:
    DB	"-.-",00H          
	
	
; ======================================================
; Directory file-type display order table
; ======================================================
L5B1EH:
    DB	B0H,F0H,C0H,80H,A0H,00H          
	
L5B24H:
    DB	"Select:_",00H    
	
L5B37H:
    DB	20H,08H,08H,5FH,08H,00H,00H          
L5B3EH:
    DB	80H,80H,80H,80H,80H,80H,80H,80H          
	
L5B46H:
    DB	"Files",8DH          
    DB	"Load ",A2H     
    DB	"Save ",A2H     
    DB	"Run",8DH          
    DB	"List",8DH          
    DB	80H             
    DB	80H             
    DB	"Menu",8DH          
	
; ======================================================
; ADDRSS Entry point
; ======================================================
L5B68H:	LXI   D,L5CCEH  ; Load address of "ADRS.DO" text
	
; ======================================================
; ADDRSS entry with (DE) pointing to filename
; ======================================================
	SUB   A         
	JMP   L5B74H    
	
	
; ======================================================
; SCHEDL Entry point
; ======================================================
L5B6FH:	LXI   D,L5D02H  ; Load pointer to "NOTE.DO" text
	
; ======================================================
; SCHEDL entry with (DE) pointing to filename
; ======================================================
	MVI   A,FFH     
L5B74H:	STA   FDEDH     ; Flag to indicate MENU entry location or command entry
	CALL  L5D4DH    ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
	PUSH  D         
	CALL  L5AA9H    ; Search directory for filename
	CALL  L5AE3H    ; Get start address of file at M
	JNZ   L5BA9H    ; Jump if "NOTE.DO" / "ADRS.DO" found
	POP   H         
	SHLD  FDEEH     ; Current MENU directory location
L5B88H  (21H) LXI H,L5B88H	; Point to self for ON ERROR handler to keep looping
	SHLD  F652H     ; Long jump return address on error
	CALL  CLS       ; CLS statement
	CALL  BEEP      ; BEEP statement
	LHLD  FDEEH     ; Current MENU directory location
	CALL  L5A58H    ; Print NULL terminated string at M
	LXI   H,L5CD6H  ; Point to " not found" text
	CALL  L5A58H    ; Print NULL terminated string at M
	LXI   H,L0003H  ; Point to "MENU" Text
	CALL  L5F24H    ; Display "Press space bar for " (Text at HL)
	JMP   L5797H    ; MENU Program
	
L5BA9H:	SHLD  FDD7H     ; Save address of NOTE.DO / ADRS.DO file
	CALL  CLS       ; CLS statement
	LXI   H,L5D0AH  
	CALL  STDSPF    ; Set and display function keys (M has key table)
	LXI   H,L5BE2H  
	SHLD  F652H     ; Long jump return address on error
L5BBBH:	CALL  L5D5DH    
	SUB   A         
	STA   VOUTSW    ; Output device for RST 20H (0=screen)
	LXI   H,L5CE1H  
	LDA   FDEDH     ; Flag to indicate MENU entry location or command entry
	ORA   A         
	JZ    L5BCFH    
	LXI   H,L5CE8H  
L5BCFH:	CALL  L5A58H    ; Print NULL terminated string at M
	CALL  INLIN     ; Input and display (no "?") line and store
	INX   H         
	MOV   A,M       
	ORA   A         
	JZ    L5BBBH    
	LXI   D,L5CEFH  
	CALL  L6CA7H    
	RNZ             
L5BE2H:	SUB   A         
	STA   VOUTSW    ; Output device for RST 20H (0=screen)
	CALL  L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	CALL  BEEP      ; BEEP statement
	LXI   H,L5D0AH  
	CALL  STFNK     ; Set new function key table
	JMP   L5BBBH    
	
	
; ======================================================
; FIND instruction for ADDRSS/SCHEDL
; ======================================================
L5BF5H:	SUB   A         
	LXI   B,FF3EH   
	CALL  L5DB1H    
L5BFCH:	CALL  L5C3FH    ; Find text at M in the file at (DE)
	JNC   L5BBBH    
	PUSH  H         
	PUSH  D         
	CALL  L5DC5H    ; Setup word-wrap / wrap width based on LCD / Printer output
L5C07H:	CALL  L67DFH    ; Build next line from .DO file at (DE) into line buffer
	LDA   FDEEH     ; Current MENU directory location
	STA   VOUTSW    ; Output device for RST 20H (0=screen)
	CALL  L6A10H    
	SUB   A         
	STA   VOUTSW    ; Output device for RST 20H (0=screen)
	LDA   FDEEH     ; Current MENU directory location
	ORA   A         
	JNZ   L5C24H    
	CALL  L5DE4H    
	JZ    L5BBBH    ; Jump if 'Q'uit selected from keyboard
L5C24H:	DCX   D         
	LDAX  D         
	INX   D         
	CPI   0AH       ; Test for newline character
	JZ    L5C37H    ; Skip ahead to next line of ADRS.DO / NOTE.DO
	PUSH  D         
	INX   D         
	MOV   A,E       
	ORA   D         
	POP   D         
	JNZ   L5C07H    
	JMP   L5BBBH    
	
L5C37H:	POP   D         
	CALL  L5C6DH    ; Increment DE past next CRLF in text file at (DE)
	POP   H         
	JMP   L5BFCH    
	
	
; ======================================================
; Find text at M in the file at (DE)
; ======================================================
L5C3FH:	PUSH  D         
L5C40H:	PUSH  H         
	PUSH  D         
L5C42H:	LDAX  D         ; Get next byte from file
	CALL  L0FE9H    ; Convert A to uppercase
	MOV   C,A       ; Put byte from file in C
	CALL  L0FE8H    ; Get char at M and convert to uppercase
	CMP   C         ; Compare byte at M to byte in file
	JNZ   L5C53H    ; Jump if no match
	INX   D         ; Increment file pointer
	INX   H         ; Increment string pointer
	JMP   L5C42H    ; Loop to continue search
	
L5C53H:	CPI   00H       ; Test for end of string at M
	MOV   A,C       ; Restore file byte to A
	POP   B         
	POP   H         ; Restore pointer to start of search string
	JZ    L5C6AH    ; Jump if end of string reached
	CPI   1AH       ; Test for end of file
	JZ    L5C96H    ; Jump if end of FILE reached
	CALL  L5C74H    ; Check next byte(s) at (DE) for CRLF
	JNZ   L5C40H    ; Continue search for M at next file position
	POP   PSW       
	JMP   L5C3FH    ; Find text at M in the file at (DE)
	
L5C6AH:	POP   D         
	STC             
	RET             
	
	
; ======================================================
; Increment DE past next CRLF in text file at (DE)
; ======================================================
L5C6DH:	CALL  L5C74H    ; Check next byte(s) at (DE) for CRLF
	JNZ   L5C6DH    ; Increment DE past next CRLF in text file at (DE)
	RET             
	
	
; ======================================================
; Check next byte(s) at (DE) for CRLF
; ======================================================
L5C74H:	LDAX  D         
	CPI   0DH       
	INX   D         
	RNZ             
	LDAX  D         
	CPI   0AH       
	RNZ             
	INX   D         
	RET             
	
L5C7FH:	PUSH  D         
	LXI   H,L5D2BH  ; TELCOM FIND FKey table
	CALL  STFNK     ; Set new function key table
	CALL  L5CAEH    ; FIND - found entry keyscan loop
	PUSH  PSW       
	LXI   H,L51A4H  ; Get pointer to TELCOM FKey labels
L5C8DH:	CALL  STFNK     ; Set new function key table
	CALL  L5DBCH    
	POP   PSW       
	CPI   51H       ; Test for 'Q' response
L5C96H:	POP   D         
	RET             
	
L5C98H:	PUSH  D         
	LXI   H,L5D1EH  
	CALL  STFNK     ; Set new function key table
L5C9FH:	CALL  L5CAEH    ; FIND - found entry keyscan loop
	CPI   43H       ; Test for 'C'all response
	JZ    L5C9FH    ; Jump to re-scan if 'C' pressed ... not supported from NOTE
	PUSH  PSW       
	LXI   H,L5D0AH  
	JMP   L5C8DH    
	
L5CAEH:	CALL  CHGET     ; Wait for key from keyboard
	PUSH  PSW       
	SUB   A         
	STA   F62DH     
	POP   PSW       
	CALL  L0FE9H    ; Convert A to uppercase
	CPI   51H       ; Test for 'Q'
	RZ              
	CPI   20H       ; Test for space
	RZ              
	CPI   4DH       ; Test for 'M'
	RZ              
	CPI   43H       ; Test for 'C'
	RZ              
	CPI   0DH       ; Test for enter
	JNZ   L5CAEH    ; None of the above, loop for another key
	ADI   36H       
	RET             
	
L5CCEH:
    DB	"ADRS.DO",00H          
L5CD6H:
    DB	"     notfound",00H
L5CE1H:
    DB	"Adrs:",00H     
L5CE8H:
    DB	"Schd:",00H     
	
	
; ======================================================
; ADDRSS/SCHEDL instruction vector table
; ======================================================
L5CEFH:
    DB	"FIND"          
	DW	5BF5H          
    DB	"LFND"          
	DW	5BF7H          
    DB	"MENU"          
	DW	5797H          
    DB	FFH             
	
L5D02H:
    DB	"NOTE.DO",00H          
	
L5D0AH:
    DB	"Find",A0H          
    DB	80H             
    DB	80H             
    DB	80H             
    DB	"Lfnd",A0H          
    DB	80H             
    DB	80H             
    DB	"Menu",8DH          
L5D1EH:
    DB	80H             
    DB	80H             
    DB	"Mor",E5H          
    DB	"Qui",F4H          
    DB	80H             
    DB	80H             
    DB	80H             
L5D2BH:
    DB	80H             
    DB	"Call",A0H          
    DB	"Mor",E5H          
    DB	"Qui",F4H          
    DB	80H             
    DB	80H             
    DB	80H             
    DB	80H             
	JMP   L5797H    ; MENU Program
	
	LXI   D,L0010H  
	DAD   D         
	DCR   C         
	RET             
	
L5D46H:	MOV   A,M       ; Get next byte
	INX   H         ; Increment pointer in case of SPACE
	CPI   20H       ; Test for space
	RZ              ; Return if space
	DCX   H         ; Not SPACE. Decrement pointer (don't skip)
	RET             
	
L5D4DH:	LXI   H,L5B3CH  ; Point to a NULL key sequence
	SHLD  F88AH     ; Save as key sequence for SHIFT-PRINT key
L5D53H:	LXI   H,FFFFH   ; Load "BASIC not executing" line number
	SHLD  F67AH     ; Current executing line number
	INX   H         ; Set HL to zero
	SHLD  FAC2H     
L5D5DH:	POP   B         ; Get return address from stack
	LHLD  FB9DH     ; SP used by BASIC to reinitialize the stack
	SPHL            ; Rewind stack to location for BASIC start
	PUSH  B         ; Push return address back to stack
	RET             
	
	
; ======================================================
; Wait for char from keyboard & convert to uppercase
; ======================================================
L5D64H:	CALL  CHGET     ; Wait for key from keyboard
	JMP   L0FE9H    ; Convert A to uppercase
	
	
; ======================================================
; Home cursor
; ======================================================
L5D6AH:	LXI   H,L0101H  ; Load code for ROW 1, COL 1
	JMP   POSIT     ; Set the current cursor position (H=Row),L=Col)
	
	
; ======================================================
; Print time on top line until key pressed
; ======================================================
L5D70H:	PUSH  H         
	LHLD  VCURLN    ; Cursor row (1-8)
	PUSH  H         
	CALL  CHSNS     ; Check keyboard queue for pending characters
	PUSH  PSW       
	CZ    L5A15H    ; Print time),day),date on first line w/o CLS
	POP   PSW       
	POP   H         
	PUSH  PSW       
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	POP   PSW       
	POP   H         
	JZ    L5D70H    ; Print time on top line until key pressed
	RET             
	
L5D88H:	MOV   M,C       ; Save the keystroke in the command buffer
	INX   H         ; Increment the command buffer pointer
	PUSH  H         ; Save it on the stack
	LXI   H,FDEDH   ; Flag to indicate MENU entry location or command entry
	INR   M         ; Indicate a command was entered (vs. a MENU selection)
	MOV   A,C       ; Restore keystroke for display
	RST   4         ; Send character in A to screen/printer
	LXI   H,L5B3AH  ; Load pointer to '_' BKSP text
	CALL  L5A58H    ; Print NULL terminated string at M
	POP   H         ; Restore the command buffer pointer
	RET             
	
L5D99H:	LDA   FDEDH     ; Flag to indicate MENU entry location or command entry
	ORA   A         ; Test for non-zero value indicating keyboard cmd entry
	RET             
	
L5D9EH:	CALL  L5D99H    ; Test if command entered from keyboard in MENU program
	RZ              ; Return if no keys in command buffer
	DCR   A         ; Decrement key count in command buffer
	STA   FDEDH     ; Flag to indicate MENU entry location or command entry
	DCX   H         ; Decrement pointer into command buffer
	PUSH  H         ; Save it on the stack
	LXI   H,L5B37H  ; Load string for erasing a character and printing "_"
	CALL  L5A58H    ; Print NULL terminated string at M
	POP   H         ; Restore pointer to command buffer
	INR   A         
	RET             
	
L5DB1H:	STA   FDEEH     ; Current MENU directory location
	CALL  L5D46H    ; Skip current byte if it is SPACE
	XCHG            
	LHLD  FDD7H     ; Load address of file to search (NOTE.DO / ADRS.DO)
	XCHG            
L5DBCH:	LDA   VACTLC    ; Active rows count (1-8)
	DCR   A         
	DCR   A         
	STA   FDEFH     ; Maximum MENU directory location
	RET             
	
L5DC5H:	LXI   H,VACTCC  ; Active columns count (1-40)
	MVI   A,FFH     
	STA   F921H     ; Set word-wrap enable flag
	STA   F920H     ; LCD vs Printer output indication
	LDA   FDEEH     ; Current MENU directory location
	ORA   A         
	JZ    L5DDFH    ; Jump if printing to LCD
	MVI   A,01H     
	STA   F920H     ; LCD vs Printer output indication
	LXI   H,F649H   ; Printer output width from CTRL-Y
L5DDFH:	MOV   A,M       ; Get width of output to printer or screen
	STA   F922H     ; Output format width (40 or something else for CTRL-Y)
	RET             
	
L5DE4H:	LXI   H,FDEFH   ; Maximum MENU directory location
	DCR   M         
	CZ    L5C98H    ; ADDRSS/SCHEDL FIND display / keyscan routine
	CPI   51H       ; Test or 'Q'uit response
	RET             
	
	
; ======================================================
; TEXT Entry point
; ======================================================
L5DEEH:	LXI   H,L5DFBH  ; Load address of Main TEXT loop ON ERROR Handler
	SHLD  F652H     ; Save as active ON ERROR handler vector
	LXI   H,L5E22H  ; TEXT Function key table - empty
	CALL  STFNK     ; Set new function key table
	XRA   A         
L5DFBH:	CNZ   BEEP      ; BEEP statement
	CALL  L5D53H    ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
	LXI   H,L5E15H  ; Point to "File to edit" text
	CALL  L27B1H    ; Print buffer at M until NULL or '"'
	CALL  L463EH    ; Input and display line and store
	RST   2         ; Get next non-white char from M
	ANA   A         
	JZ    L5797H    ; MENU Program
	CALL  L2206H    ; Get .DO filename and locate in RAM directory
	JMP   L5F65H    ; Edit .DO files
	
L5E15H:
    DB	"File toedit",00H
	
	
; ======================================================
; TEXT Function key table - empty
; ======================================================
L5E22H:
    DB	80H,80H,80H,80H,80H,80H,80H,83H          
	
L5E2AH:
    DB	"Find",8EH          
    DB	"Load",96H          
    DB	"Save",87H          
    DB	80H             
    DB	"Copy",8FH          
    DB	"Cut  ",95H     
    DB	"Sel  ",8CH     
    DB	"Menu",1BH          
	SBB   E         
L5E4FH:	DAD   D         
	NOP             
	
; ======================================================
; EDIT statement
; ======================================================
	PUSH  H         
	PUSH  PSW       
	MVI   A,01H     
	JZ    L5E5AH    
	MVI   A,FFH     
L5E5AH:	STA   F651H     ; In TEXT because of BASIC EDIT flag
	XRA   A         
	STA   FC95H     
	LXI   H,L2020H  ; Get ASCII " " in HL
	SHLD  FC99H     ; Save " " as current BASIC filename extension
	LXI   H,L5EDAH  ; Load address of EDIT statement ON ERROR handler
	SHLD  F652H     ; Long jump return address on error
	LXI   D,F802H   
	LXI   H,L5F48H  
	CALL  L4D12H    
	LXI   H,L5ED5H  ; Load address of EDIT command ON ERROR handler
	SHLD  F652H     ; Long jump return address on error
	POP   PSW       
	POP   H         
	PUSH  H         
	JMP   L1140H    ; LIST statement
	
L5E82H:	CALL  L4F45H    
	CALL  L212DH    
	LDA   VLABLF    ; Label line protect status
	STA   FACCH     
	LXI   H,0000H  
	SHLD  F6E7H     
L5E94H:	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	CALL  L4009H    ; Clear all COM), TIME), and KEY interrupt definitions
	LHLD  F9B0H     
	MOV   A,M       
	CPI   1AH       
	JZ    L5EBDH    
	PUSH  H         
	XRA   A         
	LXI   H,L5EABH  
	JMP   L5F71H    
	
L5EABH:	XRA   A         
	LXI   H,L5EEBH  ; Load ON ERROR handler for LIST Command???
	SHLD  F652H     ; Long jump return address on error
	LXI   H,L5F48H  
	MVI   D,F8H     
	JMP   L4D9EH    
	
L5EBAH:	CALL  CLS       ; CLS statement
L5EBDH:	XRA   A         
	STA   F651H     ; In TEXT because of BASIC EDIT flag
	MOV   L,A       ; Prepare to clear the ON ERROR handler
	MOV   H,A       ; Clear the MSB too
	SHLD  F652H     ; Save as active ON ERROR handler vector
	CALL  L1FF8H    
	CALL  L3F6DH    
	LDA   FACCH     
	STA   VLABLF    ; Label line protect status
	JMP   L6C5BH    
	
L5ED5H:	PUSH  D         
	CALL  L1FF8H    
	POP   D         
L5EDAH:	PUSH  D         
	XRA   A         ; Prepare to zero out BASIC EDIT flag and ON ERROR vector
	STA   F651H     ; In TEXT because of BASIC EDIT flag
	MOV   L,A       ; Prepare to zero out the ON ERROR handler
	MOV   H,A       ; Zero out MSB too
	SHLD  F652H     ; Save as active ON ERROR handler vector
	CALL  L4F45H    
	POP   D         
	JMP   L045DH    ; Generate error in E
	
L5EEBH:	MOV   A,E       
	PUSH  PSW       
	LHLD  FC87H     
	DCX   H         
	MOV   B,M       
	DCR   B         
	DCX   H         
	MOV   C,M       
	DCX   H         
	MOV   L,M       
	XRA   A         
	MOV   H,A       
	DAD   B         
	LXI   B,FFFFH   
	DAD   B         
	JC    L5F03H    
	MOV   L,A       
	MOV   H,A       
L5F03H:	SHLD  F6E7H     
	CALL  L4F45H    
	POP   PSW       
	CPI   07H       
	LXI   H,L60B1H  ; Load pointer to "Memory full" text
	JZ    L5F15H    
	LXI   H,L5F38H  ; Load pointer to "Text ill-formed" text
L5F15H:	CALL  CLS       ; CLS statement
	CALL  L27B1H    ; Print buffer at M until NULL or '"'
	LXI   H,L5F60H  ; Load pointer to "TEXT" text
	CALL  L5F24H    ; Display "Press space bar for " (Text at HL)
	JMP   L5E94H    
	
L5F24H:	PUSH  H         ; Push pointer to "MENU" or "TEXT"
	LXI   H,L5F49H  ; Load pointer to "Press space bar for" text
	CALL  L27B1H    ; Print buffer at M until NULL or '"'
	POP   H         ; Pop pointer to "MENU" or "TEXT"
	CALL  L27B1H    ; Print buffer at M until NULL or '"'
	
; ======================================================
; Wait for a space to be entered on keyboard
; ======================================================
L5F2FH:	CALL  CHGET     ; Wait for key from keyboard
	CPI   20H       ; Test if SPACE pressed
	JNZ   L5F2FH    ; Wait for a space to be entered on keyboard
	RET             
	
L5F38H:
    DB	"Text ill-formed",07H,00H
	
L5F49H:
    DB	0DH,0AH          
	
    DB	"Pressspacebarfor",00H
	
L5F60H:
    DB	"TEXT",00H          
	
	
; ======================================================
; Edit .DO files
; ======================================================
L5F65H:	PUSH  H         ; Push address of .DO file
	LXI   H,0000H  
	SHLD  F6E7H     
	MVI   A,01H     
	LXI   H,L5797H  ; Load pointer to MENU routine
L5F71H:	STA   F921H     ; Set word-wrap enable flag
	SHLD  F765H     ; Save pointer to MENU as return for ESC
	CALL  EXTREF    ; Cancel inverse character mode
	CALL  ERAFNK    ; Erase function key display
	CALL  LOCK      ; Stop automatic scrolling
	CALL  CUROFF    ; Turn the cursor off
	CALL  L65B9H    
	LXI   H,L5E2AH  ; Load pointer to TEXT function key table
	CALL  STFNK     ; Set new function key table
	LDA   F651H     ; Load flag if launched from EDIT command or MENU
	ANA   A         ; Test if loaded by EDIT command
	JZ    L5F9FH    ; Skip ahead if loaded from MENU
	LXI   H,L7845H  ; Load 1st two bytes of "Exit" text
	SHLD  F7F9H     ; Replace Function Key Table text with "Ex"
	LXI   H,L7469H  ; Load last two bytes if "Exit" text
	SHLD  F7FBH     ; Replace function key table text with "it"
L5F9FH:	LXI   H,L5E4FH  ; CTRL-Y (Print) Keystroke emulation
	SHLD  F88AH     
	LDA   VACTCC    ; Active columns count (1-40)
	STA   F922H     ; Output format width (40 or something else for CTRL-Y)
	MVI   A,80H     
	STA   F650H     ; Set Keyboard Scan modifier
	XRA   A         ; Zero A
	MOV   L,A       ; Zero HL
	MOV   H,A       
	STA   F6DFH     ; Clear storage for key read from keyboard to test for ESC ESC
	STA   F920H     ; LCD vs Printer output indication - output to LCD
	STA   F6E1H     ; Set "Redraw Bottom Line" flag to zero
	STA   F71FH     
	SHLD  F6E2H     ; Start address in .DO file of SELection for copy/cut
	POP   H         ; Pop address of .DO file
	SHLD  F767H     ; Save as address of .DO file being edited
	PUSH  H         
	CALL  L6B2AH    ; Find end of DO file (find the 1Ah)
	CALL  L634AH    ; Expand .DO file so it fills all memory for editing
	POP   D         
	LHLD  F6E7H     
	DAD   D         
	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	PUSH  H         
	CALL  L6986H    ; Display 'A' lines of the .DO file for editing
	POP   H         
	CALL  L630BH    ; Reposition TEXT LCD cursor to file pos in HL
	
; ======================================================
; Main TEXT edit loop
; ======================================================
L5FDDH:	CALL  L5D53H    ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
	LXI   H,L5FDDH  ; Make the ON ERROR handler the Main TEXT loop
	SHLD  F652H     ; Long jump return address on error
	PUSH  H         ; Push "RET"urn address back to TEXT loop
	LDA   F6DFH     ; Load value of last key processed
	STA   F6E0H     ; Save as previous key value to test for ESC ESC
	CALL  L63E5H    ; Get next byte for TEXT Program entry
	STA   F6DFH     ; Save as last key press (for ESC ESC detection)
	PUSH  PSW       ; Preserve PSW
	CALL  L65ECH    ; Test for and redraw of bottom TEXT line after error prompt
	POP   PSW       ; Restore PSW
	JC    L6501H    ; Paste routine. Insert PASTE buffer into .DO file
	CPI   7FH       ; Test for DEL key
	JZ    L6118H    ; Jump to Handler for DEL key
	CPI   20H       ; Test for SPACE
	JNC   L608AH    ; TEXT control I routine
	MOV   C,A       ; Load control code to BC to offset into table
	MVI   B,00H     
	LXI   H,L6016H  ; TEXT control character vector table
	DAD   B         ; Offset into table
	DAD   B         ; Offset into table (each entry 2 bytes)
	MOV   C,M       ; Get the LSB of the handler function pointer
	INX   H         ; Increment to MSB of handler function pointer
	MOV   H,M       ; Get MSB of handler function pointer
	MOV   L,C       ; Put LSB of handler function pointer to HL
	PUSH  H         ; Push handler function to stack
	LHLD  VCURLN    ; Cursor row (1-8)
L6015H:	RET             ; "RET"urn to handler function
	
	
; ======================================================
; TEXT control character vector table
; ======================================================
L6016H:
	DW	6015H,618CH,61D7H,628FH
	DW	60DEH,6155H,617AH,6713H
	DW	610BH,608AH,6015H,6015H
	DW	6242H,60BEH,6551H,6431H
	DW	607CH,620BH,61FDH,6151H
	DW	61C2H,6445H,6774H,6210H
	DW	60E2H,6691H,621CH,6056H
	DW	60DEH,6151H,6155H,60E2H
	
	
; ======================================================
; TEXT ESCape routine
; ======================================================
	LDA   F6E0H     ; Load value of previous key (testing for ESC ESC)
	SUI   1BH       ; Test if previous key was also ESC
	RNZ             ; Return if previous key wasn't ESC ... only exit if ESC ESC
	MOV   L,A       ; Prepare to NULL out long jump return address
	MOV   H,A       ; Prepare to NULL out long jump return address
	SHLD  F652H     ; Long jump return address on error
	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	38H             
	CALL  L65B9H    
	CALL  UNLOCK    ; Resume automatic scrolling
	CALL  ERAFNK    ; Erase function key display
	CALL  L63DBH    ; Get number of LCD rows based on label protect + cols in HL
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	CALL  CRLF      ; Send CRLF to screen or printer
	CALL  L6383H    ; Delete zeros from end of edited DO file and update pointers
	LHLD  F765H     ; Load return address (MENU or BASIC) for ESC
	PCHL            ; Jump to TEXT ESC (exit) routine. This could be MENU or BASIC
	
	
; ======================================================
; TEXT control P routine
; ======================================================
L607CH:	CALL  L63E5H    ; Get next byte for TEXT Program entry
	JC    L6501H    ; Paste routine. Insert PASTE buffer into .DO file
	ANA   A         
	RZ              
	CPI   1AH       
	RZ              
	CPI   7FH       
	RZ              
	
; ======================================================
; TEXT control I routine
; ======================================================
L608AH:	PUSH  PSW       ; Save byte (TAB) on stack
	CALL  L628FH    ; TEXT control C routine
	CALL  L6A9BH    
	CALL  L6AF9H    ; Get address in .DO file of current cursor position
	POP   PSW       ; Restore byte from stack
L6095H:	CALL  L6396H    ; Insert byte in A to .DO file at address HL.
	JC    L60A3H    ; Jump if Memory full
	PUSH  H         
	CALL  L6253H    ; Update Line Starts array after insert
	POP   H         
	JMP   L6146H    ; Jump to redraw text on LCD after insert
	
L60A3H:	CALL  L659BH    
	PUSH  H         
	LXI   H,L60B1H  ; Load pointer to "Memory full" text
	CALL  L65AEH    ; Draw "Memory full" text and set "Redraw last line" flag
L60ADH:	POP   H         
	JMP   POSIT     ; Set the current cursor position (H=Row),L=Col)
	
L60B1H:
    DB	"Memoryfull",07H,00H
	
	
; ======================================================
; TEXT control M routine
; ======================================================
	CALL  L628FH    ; TEXT control C routine
	CALL  L6A9BH    
	LHLD  FB62H     ; Pointer to end of .DO file
	INX   H         
	MOV   A,M       
	INX   H         
	ORA   M         
	JNZ   L60A3H    ; Display "Memory Full"
	CALL  L6253H    ; Update Line Starts array after insert
	CALL  L6AF9H    ; Get address in .DO file of current cursor position
	MVI   A,0DH     
	CALL  L6396H    ; Insert byte in A to .DO file at address HL.
	MVI   A,0AH     
	JMP   L6095H    
	
	
; ======================================================
; TEXT right arrow and control D routine
; ======================================================
L60DEH:	CALL  L60E8H    ; Call right arrow processing
	STC             ; Set Carry to prevent call below
	
; ======================================================
; TEXT down arrow and control X routine
; ======================================================
L60E2H:	CNC   L60F5H    ; Call Down arrow processing if no fall-through
	JMP   L62A0H    
	
L60E8H:	LHLD  VCURLN    ; Cursor row (1-8)
	LDA   VACTCC    ; Active columns count (1-40)
	INR   H         ; Increment the col number
	CMP   H         ; Test for wrap to next line
	JNC   L6175H    ; Update the current cursor position if no wrap
	MVI   H,01H     ; Wrap to col 1 and fall through to DOWN arrow logic
L60F5H:	INR   L         ; Increment the ROW number
	MOV   A,L       ; Put ROW number in A for line starts array lookup
	PUSH  H         ; Preserve HL
	CALL  L6A48H    ; Get address in .DO file of start of row in 'A' using Line Starts array
	MOV   A,E       ; Get LSB of address from line starts array
	ANA   D         ; And with MSB to test for 0xFFFF
	INR   A         ; Test for 0xFFFF address (no more lines in .DO file)
	POP   H         ; Restore HL
	STC             
	RZ              ; Return if no more lines in .DO file
	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	CMP   L         ; Test if scroll occurred (beyond last LCD row)
	CC    L6311H    ; Scroll TEXT .DO file up by one line, displaying new line
	JMP   L6175H    ; Update the current cursor position
	
	
; ======================================================
; TEXT control H routine
; ======================================================
L610BH:	CALL  L628FH    ; TEXT control C routine
	CALL  L6AF9H    ; Get address in .DO file of current cursor position
	CALL  L630BH    ; Reposition TEXT LCD cursor to file pos in HL
	CALL  L615BH    ; Call left arrow processing routine
	RC              
L6118H:	CALL  L628FH    ; TEXT control C routine
	CALL  L6AF9H    ; Get address in .DO file of current cursor position
	PUSH  H         
	CALL  L630BH    ; Reposition TEXT LCD cursor to file pos in HL
	POP   H         
	MOV   A,M       
	CPI   1AH       
	RZ              
	PUSH  PSW       
	PUSH  H         
	PUSH  H         
	CALL  L6A9BH    
	POP   H         
L612EH:	CALL  L63B6H    
	CALL  L6256H    ; Update Line Starts array after insert/DEL ("Hidden" entry)
	POP   H         
	POP   PSW       
	CPI   0DH       
	JNZ   L6146H    ; Jump to redraw text on LCD after insert
	MOV   A,M       
	CPI   0AH       
	JNZ   L6146H    ; Jump to redraw text on LCD after insert
	PUSH  PSW       
	PUSH  H         
	JMP   L612EH    
	
L6146H:	PUSH  H         ; Preserve HL
	LDA   VCURLN    ; Cursor row (1-8)
	CALL  L699EH    ; Display TEXT lines on LCD starting at current row.
	POP   H         ; Restore HL
	JMP   L62F6H    
	
	
; ======================================================
; TEXT left arrow and control S routine
; ======================================================
	CALL  L615BH    ; Call left arrow processing routine
	STC             ; Set carry and fall through
	
; ======================================================
; TEXT up arrow and control E routine
; ======================================================
	CNC   L6166H    ; Handle UP key if not fall-through
	JMP   L62A0H    
	
L615BH:	LHLD  VCURLN    ; Cursor row (1-8)
	DCR   H         ; Decrement COL
	JNZ   L6175H    ; Jump to simply update the cursor position if not zero
	LDA   VACTCC    ; Active columns count (1-40)
	MOV   H,A       ; Place column on right edge of screen
L6166H:	PUSH  H         ; Save new COL on stack
	CALL  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	LHLD  F767H     ; Load start address of .DO file being edited
	RST   3         ; Compare DE and HL
	POP   H         ; Pop current COL from stack
	CMC             ; Compliment the sign of the comparison
	RC              ; Return if at top of text ... no update
	DCR   L         ; Decrement the LCD row
	CZ    L631DH    ; If decremented off-screen, call to update the LCD
L6175H:	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	ANA   A         ; Clear the Carry flag for return processing
	RET             
	
	
; ======================================================
; TEXT control F routine
; ======================================================
	CALL  L6AF9H    ; Get address in .DO file of current cursor position
L617DH:	CALL  L61A4H    ; Test for EOF. If not EOF, test for word-wrap char
	JNZ   L617DH    
L6183H:	CALL  L61A4H    ; Test for EOF. If not EOF, test for word-wrap char
	JZ    L6183H    
	JMP   L619EH    
	
	
; ======================================================
; TEXT control A routine
; ======================================================
	CALL  L6AF9H    ; Get address in .DO file of current cursor position
L618FH:	CALL  L61AFH    ; Test for start of .DO file and word-wrap
	JZ    L618FH    
L6195H:	CALL  L61AFH    ; Test for start of .DO file and word-wrap
	JNZ   L6195H    
	CALL  L61A4H    ; Test for EOF. If not EOF, test for word-wrap char
L619EH:	CALL  L62F6H    
	JMP   L62A0H    
	
L61A4H:	MOV   A,M       ; Get next byte from file
	CPI   1AH       ; Test for end of file
	POP   B         ; Pop return address
	JZ    L619EH    ; If EOF, jump to complete processing
	INX   H         ; Increment file pointer
	JMP   L61BAH    ; Get next byte from file and test for word-wrap character
	
L61AFH:	XCHG            
	LHLD  F767H     ; Load start address of .DO file being edited
	XCHG            
	RST   3         ; Compare DE and HL
	POP   B         ; Pop return address
	JZ    L619EH    ; If at start of file, jump to complete processing
	DCX   H         ; Decrement to previous byte in file
L61BAH:	PUSH  B         ; Push return address back to stack
	PUSH  H         ; Save pointer to file on stack
	MOV   A,M       ; Get next byte from file in A
	CALL  L6965H    ; Test byte in A for word-wrap characters like '-', '(', ')', etc.
	POP   H         ; Restore pointer to file
	RET             
	
	
; ======================================================
; TEXT control T routine
; ======================================================
L61C2H:	DCR   L         
	MVI   L,01H     
	JNZ   L61D1H    
	PUSH  H         
	CALL  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	XCHG            
	CALL  L6230H    
	POP   H         
L61D1H:	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	JMP   L62A0H    
	
	
; ======================================================
; TEXT control B routine
; ======================================================
	PUSH  H         
	INR   L         
	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	INR   A         
	CMP   L         
	JNZ   L61ECH    
	PUSH  PSW       
	CALL  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	XCHG            
	MVI   A,01H     
	CALL  L6233H    
	POP   PSW       
L61ECH:	DCR   A         
	CALL  L6A48H    ; Get address in .DO file of start of row in 'A' using Line Starts array
	MOV   B,A       
	INX   D         
	MOV   A,D       
	ORA   E         
	MOV   A,B       
	JZ    L61ECH    
	POP   H         
	MOV   L,A       
	JMP   L61D1H    
	
	
; ======================================================
; TEXT control R routine
; ======================================================
	LDA   VACTCC    ; Active columns count (1-40)
	MOV   H,A       
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	CALL  L6AF9H    ; Get address in .DO file of current cursor position
	CALL  L6AA3H    ; Find address of 1st char on LCD line for ROW containing file pos in HL
	LXI   B,L0126H  
	JMP   L61D1H    
	
	
; ======================================================
; TEXT control W routine
; ======================================================
	LHLD  F767H     ; Load start address of .DO file being edited
	CALL  L6236H    
	CALL  HOME      ; Home cursor
	JMP   L62A0H    
	
	
; ======================================================
; TEXT control Z routine
; ======================================================
	LHLD  FB62H     ; Pointer to end of .DO file
	PUSH  H         
	CALL  L6A3EH    ; Get address in .DO file of start of row just below visible LCD
	POP   H         
	RST   3         ; Compare DE and HL
	PUSH  H         
	CNC   L6230H    
L6229H:	POP   H         
	CALL  L630BH    ; Reposition TEXT LCD cursor to file pos in HL
	JMP   L62A0H    
	
L6230H:	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
L6233H:	CALL  L6B39H    
L6236H:	CALL  L0013H    ; Load pointer to Storage of TEXT Line Starts in DE
	RZ              
	SHLD  F6EBH     ; Storage of TEXT Line Starts
	MVI   A,01H     
	JMP   L69CBH    ; Display line 'A' of the .DO file at HL for editing base on line starts array
	
	
; ======================================================
; TEXT control L routine
; ======================================================
L6242H:	CALL  L628FH    ; TEXT control C routine
	CALL  L6AF9H    ; Get address in .DO file of current cursor position
	SHLD  F6E2H     ; Start address in .DO file of SELection for copy/cut
	SHLD  F6E4H     ; End address in .DO file of SELection for copy/cut
	MOV   E,L       
	MOV   D,H       
	JMP   L62B3H    
	
L6253H:	MVI   C,00H     ; Indicate insert operation
	LXI   H,800EH   ; Hidden entry. Makes 0EH,80H below look like LXI H,800EH
	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	LXI   H,VCURLN  ; Cursor row (1-8)
	SUB   M         ; Subtract the #rows - current row = #rows to update
	MOV   B,A       ; Move # of Line Start pointers to be updated in B
	CALL  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	INX   H         ; Increment Line Start pointer pointer
L6264H:	INX   H         
	MOV   E,M       ; Get address of start of NEXT row of text
	INX   H         ; Increment pointer
	MOV   D,M       ; Get MSB of start address of NEXT row of text
	INX   D         ; Increment address of start of next row
	MOV   A,D       ; Prepare to test for 0xFFFF (They didn't know about K flag ... too bad)
	ORA   E         ; OR in LSB to test for zero
	RZ              ; Return if at end of line starts array
	DCR   C         ; Test routine entry method (C=00H or 80H)
	JM    L6272H    ; Skip Decrements if C=00H
	DCX   D         ; If DEL, then decrement instead of increment
	DCX   D         ; We need 2 decrements
L6272H:	DCX   H         ; Decrement back to LSB of Line Starts pointer
	MOV   M,E       ; Save updated LSB of NEXT row pointer
	INX   H         ; Advance to MSB of Line Starts pointer
	MOV   M,D       ; Save updated MSB of NEXT row pointer
	DCR   B         ; Decrement count of Line Start pointers to update
	JP    L6264H    ; Jump to process next Line Start pointer
	RET             
	
L627BH:	CALL  HOME      ; Home cursor
	CALL  DELLIN    ; Delete current line on screen
	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
L6284H:	ADD   A         
	MOV   B,A       
	LXI   D,F6EBH   ; Storage of TEXT Line Starts
	LXI   H,F6EDH   
	JMP   L2542H    ; Move B bytes from M to (DE)
	
	
; ======================================================
; TEXT control C routine
; ======================================================
L628FH:	CALL  L62EEH    ; Test for a valid SEL region. If none, return to caller to skip the copy/cut
	PUSH  H         
	LXI   H,0000H  
	SHLD  F6E2H     ; Start address in .DO file of SELection for copy/cut
	CALL  L6AF9H    ; Get address in .DO file of current cursor position
	POP   D         
	JMP   L62B0H    
	
L62A0H:	CALL  L62EEH    ; Test for a valid SEL region. If none, return to caller to skip the copy/cut
	CALL  L6AF9H    ; Get address in .DO file of current cursor position
	XCHG            
	LHLD  F6E4H     ; End address in .DO file of SELection for copy/cut
	RST   3         ; Compare DE and HL
	RZ              
	XCHG            
	SHLD  F6E4H     ; End address in .DO file of SELection for copy/cut
L62B0H:	CALL  L64B2H    
L62B3H:	PUSH  H         
	PUSH  D         
	CALL  L6A3EH    ; Get address in .DO file of start of row just below visible LCD
	POP   H         
	RST   3         ; Compare DE and HL
	JC    L62C0H    
	CALL  L63DBH    ; Get number of LCD rows based on label protect + cols in HL
L62C0H:	CC    L6AA3H    ; Find address of 1st char on LCD line for ROW containing file pos in HL
	MOV   H,L       
	XTHL            
	CALL  L0013H    ; Load pointer to Storage of TEXT Line Starts in DE
	JNC   L62CDH    
	MVI   L,01H     
L62CDH:	CNC   L6AA3H    ; Find address of 1st char on LCD line for ROW containing file pos in HL
	POP   PSW       
	SUB   L         
	MOV   C,A       
	XCHG            
	LHLD  VCURLN    ; Cursor row (1-8)
	XCHG            
	PUSH  D         
	MVI   H,01H     
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	CALL  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	MOV   A,C       
L62E2H:	PUSH  PSW       
	CALL  L6A0DH    ; Build and display next line from .DO file at (DE)
	POP   PSW       
	DCR   A         
	JP    L62E2H    
	JMP   L60ADH    ; Pop H and set current cursor position
	
L62EEH:	LHLD  F6E2H     ; Start address in .DO file of SELection for copy/cut
	MOV   A,H       ; Prepare to test if address is NULL
	ORA   L         ; Test if address is NULL
	RNZ             ; Return if not NULL (valid SELection exists)
	POP   H         ; No SELection exists, pop return address to RET to parent's caller
	RET             ; Return, but not to copy/cut but rather to it's caller
	
L62F6H:	CALL  L0013H    ; Load pointer to Storage of TEXT Line Starts in DE
	CC    L631EH    
	JC    L62F6H    
L62FFH:	PUSH  H         
	CALL  L6A3EH    ; Get address in .DO file of start of row just below visible LCD
	POP   H         
	RST   3         ; Compare DE and HL
	CNC   L6312H    
	JNC   L62FFH    
L630BH:	CALL  L6AA3H    ; Find address of 1st char on LCD line for ROW containing file pos in HL
	JMP   POSIT     ; Set the current cursor position (H=Row),L=Col)
	
L6311H:	DCR   L         ; Decrement the current ROW number
L6312H:	PUSH  PSW       
	PUSH  H         
	CALL  L627BH    ; Clear current line and update line starts array after scroll
	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	JMP   L6344H    ; Display line 'A' of the .DO file at HL for editing base on line starts array
	
L631DH:	INR   L         ; Increment the ROW back to 1
L631EH:	PUSH  PSW       ; Preserve PSW on stack
	PUSH  H         ; Save ROW and COL
	CALL  L65DFH    ; Position cursor at left of bottom row and erase to EOL
	CALL  HOME      ; Home cursor
	CALL  INSLIN    ; Insert line a current line
	CALL  L6A55H    ; Get address in .DO file of start of line for the previous row
	PUSH  D         
	CALL  L6A3EH    ; Get address in .DO file of start of row just below visible LCD
	INX   H         
	MOV   E,L       
	MOV   D,H       
	DCX   H         
	DCX   H         
	DCR   A         
	ADD   A         
	MOV   C,A       
	MVI   B,00H     
	CALL  L6BE6H    ; Move BC bytes from M to (DE) with decrement
	XCHG            
	POP   D         
	MOV   M,D       
	DCX   H         
	MOV   M,E       
	MVI   A,01H     
L6344H:	CALL  L69CBH    ; Display line 'A' of the .DO file at HL for editing base on line starts array
	POP   H         ; Pop ROW and COL from stack
	POP   PSW       ; Restore PSW
	RET             
	
L634AH:	LHLD  FBB6H     ; Unused memory pointer
	LXI   B,L00C8H  ; Reserve 200 bytes for stack
	DAD   B         ; Calculate unused memory pointer + 200
	XRA   A         ; Calculate 65536 - calculated pointer
	SUB   L         
	MOV   L,A       
	SBB   A         
	SUB   H         
	MOV   H,A       ; HL now has count of free memory - 200
	DAD   SP        ; Add current SP to free memory count
	RNC             
	MOV   A,H       
	ORA   L         
	RZ              
	MOV   B,H       
	MOV   C,L       
	LHLD  FB62H     ; Pointer to end of .DO file
	XCHG            
	INX   D         
	CALL  L6B7FH    ; Move all files / variables after this file
L6366H:	MVI   M,00H     ; Fill next byte in DO file with zero
	INX   H         
	DCX   B         
	MOV   A,B       
	ORA   C         
	JNZ   L6366H    
	RET             
	
L6370H:	LHLD  FBAEH     ; Start of DO files pointer
L6373H:	CALL  L6B2DH    ; Find end of DO file (find the 1Ah at (HL))
	INX   H         ; Get address beyond end of file
	XCHG            ; Put it in DE
	LHLD  FBB0H     ; Start of CO files pointer
	XCHG            ; Swap DE / HL
	RST   3         ; Compare DE and HL
	RNC             ; Return with no action if everything in place
	MOV   A,M       ; Get byte from file
	ANA   A         ; Test for zero (check if it's this .DO file that is expanded)
	JNZ   L6373H    ; Jump to test if next file is the one expanded
L6383H:	LHLD  FB62H     ; Pointer to end of .DO file
	PUSH  H         
	LXI   B,FFFFH   ; Initialize zero count to -1
	XRA   A         ; Prepare to test for zero in file
L638BH:	INX   H         ; Increment file pointer
	INX   B         ; Increment zero byte count
	CMP   M         ; Test if next byte is zero
	JZ    L638BH    ; Keep incrementing while zero
	POP   H         ; Restore pointer to end of edit file
	INX   H         ; Increment to 1st zero in file
	JMP   L6B9FH    ; Delete BC characters at M
	
L6396H:	XCHG            ; Save address of current file pointer eo DE
	LHLD  FB62H     ; Pointer to end of .DO file
	INX   H         ; Prepare to test if room in .DO file
	INR   M         ; Increment byte at end of .DO file
	DCR   M         ; Decrement back to test for zero
	STC             ; Set Carry to indicate full just in case
	RNZ             ; Return if no room left in .DO file
	PUSH  PSW       ; Save byte to insert to stack
	SHLD  FB62H     ; Pointer to end of .DO file
	XCHG            
	MOV   A,E       ; Calculate number of bytes to move from
	SUB   L         ; ... current file position to the end
	MOV   C,A       ; ... of the file,
	MOV   A,D       ; ... save LSB of copy to address
	SUB   H         ; Subtract end of .DO location MSB
	MOV   B,A       ; Save as copy length MSB
	MOV   L,E       ; Restore copy from LSB
	MOV   H,D       ; Restore copy from MSB
	DCX   H         ; Decrement H to insert one byte
	CALL  L6BE6H    ; Move BC bytes from M to (DE) with decrement
	INX   H         ; Increment back to insertion point after move above
	POP   PSW       ; Retrieve byte to be inserted from stack
	MOV   M,A       ; Insert the byte into the .DO file
	INX   H         ; Increment current file pointer
	ANA   A         ; Clear carry to indicate not full
	RET             
	
L63B6H:	XCHG            
	LHLD  FB62H     ; Pointer to end of .DO file
	MOV   A,L       
	SUB   E         
	MOV   C,A       
	MOV   A,H       
	SBB   D         
	MOV   B,A       
	DCX   H         
	SHLD  FB62H     ; Pointer to end of .DO file
	MOV   L,E       
	MOV   H,D       
	INX   H         
	CALL  L6BDBH    ; Move BC bytes from M to (DE) with increment
	XRA   A         
	STAX  D         
	RET             
	
L63CDH:	PUSH  H         ; Preserve HL on stack
	PUSH  PSW       ; Preserve flags on stack
	LXI   H,VLABLF  ; Label line protect status
	LDA   VACTLC    ; Active rows count (1-8)
	ADD   M         ; Add label protection indication to get actual ROW count
	MOV   L,A       ; Save actual ROW count to L
	POP   PSW       ; Restore FLAGS
	MOV   A,L       ; Copy actual ROW count to A
	POP   H         ; Restore HL from stack
	RET             
	
L63DBH:	PUSH  PSW       ; Preserve A on stack
	LHLD  VACTLC    ; Active rows count (1-8)
	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	MOV   L,A       ; Update L with actual rows based on label protect
	POP   PSW       ; Restore A from stack
	RET             
	
	
; ======================================================
; Get next byte for TEXT Program entry
; ======================================================
L63E5H:	LHLD  VCURLN    ; Cursor row (1-8)
	PUSH  H         
	MOV   A,L       
	STA   FAADH     ; Label line enable flag
	LDA   VLABLF    ; Label line protect status
	PUSH  PSW       
	CALL  CHGET     ; Wait for key from keyboard
	POP   B         
	POP   H         
	PUSH  PSW       
	XRA   A         
	STA   FAADH     ; Label line enable flag
	LDA   VLABLF    ; Label line protect status
	CMP   B         
	JNZ   L6404H    
	POP   PSW       
	RET             
	
L6404H:	ANA   A         
L6405H:	JZ    L6414H    
	LDA   VCURLN    ; Cursor row (1-8)
	CMP   L         
	LDA   VACTLC    ; Active rows count (1-8)
	CNZ   L6284H    
	POP   PSW       
	RET             
	
L6414H:	PUSH  H         
	LDA   VACTLC    ; Active rows count (1-8)
	DCR   A         
	CALL  L6A48H    ; Get address in .DO file of start of row in 'A' using Line Starts array
	INX   H         
	MVI   M,FEH     
	INX   H         
	INX   H         
	MVI   M,FEH     
	DCR   A         
	CALL  L69CBH    ; Display line 'A' of the .DO file at HL for editing base on line starts array
	XRA   A         
	STA   F6E1H     ; Set "Redraw Bottom Line" flag to zero
	POP   H         
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	POP   PSW       
	RET             
	
	
; ======================================================
; TEXT control O routine
; ======================================================
	CALL  L62EEH    ; Test for a valid SEL region. If none, return to caller to skip the copy/cut
	CALL  L6383H    ; Delete zeros from end of edited DO file and update pointers
	CALL  L64B6H    
	PUSH  PSW       
	CALL  L634AH    ; Expand .DO file so it fills all memory for editing
	POP   PSW       
	JNC   L628FH    ; TEXT control C routine
	JMP   L60A3H    ; Display "Memory Full"
	
	
; ======================================================
; TEXT control U routine
; ======================================================
	CALL  L62EEH    ; Test for a valid SEL region. If none, return to caller to skip the copy/cut
	CALL  L6383H    ; Delete zeros from end of edited DO file and update pointers
	CALL  L64B6H    
	PUSH  PSW       
	CNC   L6B9FH    ; Delete BC characters at M
	POP   PSW       
	JNC   L646FH    
	MOV   A,B       
	ANA   A         
	JZ    L646AH    
L645BH:	CALL  L1BB1H    ; Renew automatic power-off counter
	PUSH  B         
	LXI   B,L0100H  
	CALL  L6488H    
	POP   B         
	DCR   B         
	JNZ   L645BH    
L646AH:	MOV   A,C       
	ANA   A         
	CNZ   L6488H    
L646FH:	LXI   D,0000H  
	XCHG            
	SHLD  F6E2H     ; Start address in .DO file of SELection for copy/cut
	XCHG            
	PUSH  H         
	LDA   VCURLN    ; Cursor row (1-8)
	CALL  L6986H    ; Display 'A' lines of the .DO file for editing
	POP   H         
	CALL  L630BH    ; Reposition TEXT LCD cursor to file pos in HL
	CALL  L6B2AH    ; Find end of DO file (find the 1Ah)
	JMP   L634AH    ; Expand .DO file so it fills all memory for editing
	
L6488H:	PUSH  H         
	PUSH  B         
	XCHG            
	LHLD  FC87H     
	XCHG            
	CALL  L6BDBH    ; Move BC bytes from M to (DE) with increment
	POP   B         
	POP   H         
	PUSH  H         
	PUSH  B         
	CALL  L6B9FH    ; Delete BC characters at M
	LHLD  F9A5H     ; Start of Paste Buffer
	DAD   B         
	XCHG            
	POP   B         
	CALL  L6B7FH    
	XCHG            
	LHLD  FC87H     
	CALL  L6BDBH    ; Move BC bytes from M to (DE) with increment
	POP   H         
	RET             
	
L64ABH:	LHLD  F6E2H     ; Start address in .DO file of SELection for copy/cut
	XCHG            
	LHLD  F6E4H     ; End address in .DO file of SELection for copy/cut
L64B2H:	RST   3         ; Compare DE and HL
	RC              
	XCHG            
	RET             
	
L64B6H:	CALL  L2262H    
	LHLD  F9A5H     ; Start of Paste Buffer
	SHLD  VPSTBF    ; End of RAM for file storage
	XRA   A         
	STA   F6E6H     
	CALL  L64ABH    ; Return Start / end of copy SEL in HL,DE ensuring HL < DE
	DCX   D         
L64C7H:	MOV   A,E       ; Calculate length of SELection
	SUB   L         ; Calculate LSB of SEL length
	MOV   C,A       ; Save LSB of SEL length in BC
	MOV   A,D       
	SUB   H         ; Calculate MSB of SEL length
	MOV   B,A       ; Save MSB of SEL length in BC
	JC    L64E3H    
	LDAX  D         
	CPI   1AH       
	JZ    L64E4H    
	CPI   0DH       
	JNZ   L64E3H    
	INX   D         
	LDAX  D         
	CPI   0AH       
	JNZ   L64E3H    
	INX   B         
L64E3H:	INX   B         
L64E4H:	MOV   A,B       
	ORA   C         
	RZ              
	PUSH  H         
	LHLD  VPSTBF    ; End of RAM for file storage
	CALL  L6B6DH    ; Insert BC spaces at M
	XCHG            
	POP   H         
	RC              
	LDA   F6E6H     
	ANA   A         
	JZ    L64F9H    
	DAD   B         
L64F9H:	PUSH  H         
	PUSH  B         
	CALL  L6BDBH    ; Move BC bytes from M to (DE) with increment
	POP   B         
	POP   H         
	RET             
	
L6501H:	CALL  L628FH    ; TEXT control C routine
	CALL  L6383H    ; Delete zeros from end of edited DO file and update pointers
	CALL  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	CALL  L6AF9H    ; Get address in .DO file of current cursor position
	SHLD  VPSTBF    ; End of RAM for file storage
	MOV   A,H       
	STA   F6E6H     
	LHLD  F9A5H     ; Start of Paste Buffer
	MOV   A,M       
	CPI   1AH       
	JZ    L634AH    ; Expand .DO file so it fills all memory for editing
	MOV   E,L       
	MOV   D,H       
	DCX   D         
L6520H:	INX   D         
	LDAX  D         
	CPI   1AH       
	JNZ   L6520H    
	CALL  L64C7H    ; Copy paste buffer to .DO file
	PUSH  PSW       
	PUSH  D         
	CALL  L6B2AH    ; Find end of DO file (find the 1Ah)
	CALL  L634AH    ; Expand .DO file so it fills all memory for editing
	POP   D         
	POP   PSW       
	JC    L60A3H    ; Jump to print "Memory Full" if paste not successful
	PUSH  D         
	LHLD  VPSTBF    ; End of RAM for file storage
	LDA   VCURLN    ; Cursor row (1-8)
	CALL  L6986H    ; Display 'A' lines of the .DO file for editing
	CALL  L6A3EH    ; Get address in .DO file of start of row just below visible LCD
	POP   H         
L6545H:	RST   3         ; Compare DE and HL
	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	PUSH  H         
	CNC   L6986H    ; Display 'A' lines of the .DO file for editing
	POP   H         
	JMP   L630BH    ; Reposition TEXT LCD cursor to file pos in HL
	
	
; ======================================================
; TEXT control N routine
; ======================================================
	CALL  L1B98H    ; Different from M100
	CALL  L6AF9H    ; Get address in .DO file of current cursor position
	PUSH  H         
	LXI   H,L65D7H  ; Load pointer to "String:" text
	LXI   D,F71FH   
	PUSH  D         
	CALL  L6603H    
	POP   D         
	INX   H         
	MOV   A,M       
	ANA   A         
	STC             
	JZ    L658BH    
	CALL  L65C3H    ; Copy NULL terminated string at M to (DE)
	POP   D         
	PUSH  D         
	LDAX  D         
	CPI   1AH       
	JZ    L658FH    
	INX   D         
	CALL  L5C3FH    ; Find text at M in the file at (DE)
	JNC   L658FH    
	POP   D         
	PUSH  B         
	PUSH  B         
	CALL  L6A3EH    ; Get address in .DO file of start of row just below visible LCD
	POP   H         
	RST   3         ; Compare DE and HL
	JC    L658BH    
	CALL  L6981H    ; Display entire screen of lines of the .DO file at HL for editing
	ANA   A         
L658BH:	CC    L65F3H    
	STC             
L658FH:	LXI   H,L65CEH  ; Load pointer to "No match" text
	CNC   L65AEH    ; Draw "No match" text and set "Redraw last line" flag
	JMP   L6229H    
	
L6598H:	CALL  L628FH    ; TEXT control C routine
L659BH:	LHLD  VCURLN    ; Cursor row (1-8)
	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	CMP   L         
	RNZ             
	DCR   L         
	PUSH  H         
	CALL  L627BH    ; Clear current line and update line starts array after scroll
	JMP   L60ADH    ; Pop H and set current cursor position
	
L65ABH:	LXI   H,L5771H  ; Load pointer to "aborted" text
L65AEH:	MVI   A,01H     
	STA   F6E1H     ; Set "Redraw Bottom Line" flag to 1
L65B3H:	CALL  L65DFH    ; Position cursor at left of bottom row and erase to EOL
	CALL  L27B1H    ; Print buffer at M until NULL or '"'
L65B9H:	CALL  CHSNS     ; Check keyboard queue for pending characters
	RZ              ; Return if a key was pressed
	CALL  CHGET     ; Wait for key from keyboard
	JMP   L65B9H    ; Loop until a key pressed
	
	
; ======================================================
; Copy NULL terminated string at M to (DE)
; ======================================================
L65C3H:	PUSH  H         
L65C4H:	MOV   A,M       
L65C5H:	STAX  D         
	INX   H         
	INX   D         
	ANA   A         
	JNZ   L65C4H    
	POP   H         
	RET             
	
L65CEH:
    DB	"No   match",00H
L65D7H:
    DB	"String:",00H          
	
L65DFH:	PUSH  H         ; Preserve HL
	CALL  L63DBH    ; Get number of LCD rows based on label protect + cols in HL
	MVI   H,01H     ; Go to Left of bottom row
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	POP   H         ; Restore HL
	JMP   ERABOL    ; Erase from cursor to end of line
	
L65ECH:	LXI   H,F6E1H   ; Point to "Redraw bottom line" flag
	XRA   A         ; Clear A
	CMP   M         ; Test if bottom line needs to be redrawn (error was displayed)
	RZ              ; Return if no re-draw needed
	MOV   M,A       
L65F3H:	LHLD  VCURLN    ; Cursor row (1-8)
	PUSH  H         
	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	CALL  L69CBH    ; Display line 'A' of the .DO file at HL for editing base on line starts array
	JMP   L60ADH    ; Pop H and set current cursor position
	
L6600H:	LXI   D,L5F48H  ; Load pointer just before "Press space bar for" text
L6603H:	PUSH  D         
	CALL  L65B3H    ; Display prompt at bottom row of LCD and wait for keystroke
	LDA   VCURCL    ; Cursor column (1-40)
	STA   FACAH     
	POP   H         
	PUSH  H         
	CALL  L27B1H    ; Print buffer at M until NULL or '"'
L6612H:	CALL  CHGET     ; Wait for key from keyboard
	JC    L6612H    
	ANA   A         
	JZ    L6612H    
	POP   H         
	CPI   0DH       
	JZ    L6654H    
	PUSH  PSW       
	CALL  L63DBH    ; Get number of LCD rows based on label protect + cols in HL
	LDA   FACAH     
	MOV   H,A       
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	CALL  ERABOL    ; Erase from cursor to end of line
	POP   PSW       
	LXI   D,VKYBBF  ; Keyboard buffer
	MVI   B,01H     
	ANA   A         
	JMP   L663DH    
	
L663AH:	CALL  CHGET     ; Wait for key from keyboard
L663DH:	LXI   H,L663AH  
	PUSH  H         
	RC              
	CPI   7FH       
	JZ    IHBACK    ; Input routine backspace), left arrow), CTRL-H handler
	CPI   20H       ; Test for SPACE
	JNC   L667EH    
	LXI   H,L665BH  ; Load pointer to Key vector mapping table
	MVI   C,07H     ; Indicate 7 entries in table
	JMP   L4378H    ; Key Vector table lookup
	
L6654H:	LXI   D,VKYBBF  ; Keyboard buffer
	CALL  L65C3H    ; Copy NULL terminated string at M to (DE)
	JMP   L6678H    
	
    DB	03H             
	DW	6672H          
    DB	08H             ; Backspace Key
	DW	IHBACK          ; Backspace key handler
    DB	09H             ; TAB Key
	DW	667CH           ; TAB Key handler
    DB	0DH             
	DW	6675H          
    DB	15H             
	DW	IHCTUX          ; CTRL-U handler
    DB	18H             
	DW	IHCTUX          ; CTRL-X handler
    DB	1DH             
	DW	IHBACK          ; Input routine backspace, left arrow, CTRL-H handler
L6672H:	LXI   D,VKYBBF  ; Keyboard buffer
L6675H:	POP   H         
	XRA   A         
	STAX  D         
L6678H:	LXI   H,F684H   
	RET             
	
L667CH:	MVI   A,09H     ; Load A with TAB character
L667EH:	MOV   C,A       ; Save in C
	LDA   VACTCC    ; Active columns count (1-40)
	SUI   09H       ; Tab stops are 8 characters
	LXI   H,VCURCL  ; Cursor column (1-40)
	CMP   M         ; Test if column < 9
	JC    BEEP      ; BEEP statement
	MOV   A,C       ; Restore TAB character to A
	INR   B         
	RST   4         ; Send character in A to screen/printer
	STAX  D         
	INX   D         
	RET             
	
	
; ======================================================
; TEXT control Y routine
; ======================================================
	CALL  L6598H    
	LXI   H,L66F2H  
	SHLD  F652H     ; Save as active ON ERROR handler vector
	PUSH  H         
	LHLD  VCURLN    ; Cursor row (1-8)
	SHLD  F6E7H     ; Save current cursor col/row in temp HL store
	LXI   H,L670CH  ; Load pointer to "Width:" text
	LXI   D,F64AH   
	CALL  L6603H    
	RST   2         ; Get next non-white char from M
	XRA   A         
	CMP   M         
	JZ    L66E6H    
	STA   VCRPOS    
	CALL  L112EH    ; Evaluate expression at M-1
	CPI   0AH       
	RC              
	CPI   85H       
	RNC             
	POP   D         
	STA   F649H     ; Printer output width from CTRL-Y
	STA   F922H     ; Output format width (40 or something else for CTRL-Y)
	STA   VOUTSW    ; Output device for RST 20H (0=screen)
	LXI   D,F64AH   
	LXI   H,VKYBBF  ; Keyboard buffer
	CALL  L65C3H    ; Copy NULL terminated string at M to (DE)
	INR   A         
	STA   F920H     ; LCD vs Printer output indication
	CALL  CRLF      ; Send CRLF to screen or printer
	LHLD  F767H     ; Load start address of .DO file being edited
	XCHG            
L66DAH:	CALL  L6A0DH    ; Build and display next line from .DO file at (DE)
	MOV   A,D       
	ANA   E         
	INR   A         
	JNZ   L66DAH    
	CALL  L66FEH    
L66E6H:	CALL  L65F3H    
L66E9H:	LHLD  F6E7H     ; Restore col/row from temp HL storage
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	JMP   L5FDDH    ; Main TEXT edit loop
	
L66F2H:	CALL  L66FEH    
	CALL  L4F45H    
	CALL  L65ABH    ; Draw "aborted" on bottom line of LCD
	JMP   L66E9H    
	
L66FEH:	LDA   VACTCC    ; Active columns count (1-40)
	STA   F922H     ; Output format width (40 or something else for CTRL-Y)
	XRA   A         
	STA   VOUTSW    ; Output device for RST 20H (0=screen)
	STA   F920H     ; LCD vs Printer output indication - LCD
	RET             
	
L670CH:
    DB	"Width:",00H          
	
	
; ======================================================
; TEXT control G routine
; ======================================================
	LXI   D,L6735H  ; Load pointer to "Save to:" prompt
	CALL  L673EH    
	JC    L66F2H    
	JZ    L66E6H    
	MVI   E,02H     
	CALL  L4D12H    
	LHLD  F767H     ; Load start address of .DO file being edited
L6727H:	MOV   A,M       ; Get next byte from .DO file
	RST   4         ; Send character in A to screen/printer
	INX   H         ; Increment to next byte in .DO file
	CPI   1AH       ; Test for end of file
	JNZ   L6727H    ; Jump to send next character from file if not end
	CALL  L4F45H    
	JMP   L66E6H    
	
L6735H:
    DB	"Save to:",00H  
	
L673EH:	PUSH  D         ; Push pointer to prompt to stack
	CALL  L6598H    
	LXI   H,L66F2H  ; Get pointer to our Long Jump handler
	SHLD  F652H     ; Long jump return address on error
	LHLD  VCURLN    ; Cursor row (1-8)
	SHLD  F6E7H     
	POP   H         ; Pop pointer to text prompt into HL
	CALL  L6600H    
	RST   2         ; Get next non-white char from M
	ANA   A         
	RZ              
	CALL  L21FAH    ; Count length of string at M
	CALL  L4C0BH    
	JNZ   L6760H    
	MVI   D,FDH     
L6760H:	MOV   A,D       
	CPI   F8H       
	STC             
	RZ              
	CPI   FEH       
	STC             
	RZ              
	CPI   FFH       
	STC             
	RZ              
	LXI   H,L5F48H  
	CMC             
	MVI   A,00H     
	RET             
	
	
; ======================================================
; TEXT control V routine
; ======================================================
	LXI   D,L67D4H  ; Pointer to "Load from:" text
	CALL  L673EH    
	JC    L66F2H    
	JZ    L66E6H    
	PUSH  H         
	LXI   H,L67CBH  
	SHLD  F652H     ; Long jump return address on error
	LHLD  FB62H     ; Pointer to end of .DO file
	SHLD  F6E7H     ; Save col/row to temp HL storage
	STA   FAC6H     
	XTHL            
	MVI   E,01H     
	CALL  L4D12H    
	POP   H         
L6797H:	CALL  L4E7AH    
	JC    L67B7H    
	CALL  L56FEH    ; Test char in A for EOF,CR,LF,DEL,other
	JZ    L6797H    ; Jump if control char (EOF,CR,LF,DEL)
	JNC   L67ABH    
	CALL  L6396H    ; Insert byte in A to .DO file at address HL.
	MVI   A,0AH     
L67ABH:	CNC   L6396H    ; Insert byte in A to .DO file at address HL.
	JNC   L6797H    
	CALL  L4F45H    
	CALL  L60A3H    ; Display "Memory Full"
L67B7H:	CALL  L4F45H    
L67BAH:	CALL  L6B2AH    ; Find end of DO file (find the 1Ah)
	LHLD  F6E7H     ; Restore col/row from temp HL storage
	PUSH  H         
	CALL  L6981H    ; Display entire screen of lines of the .DO file at HL for editing
	POP   H         
	CALL  L630BH    ; Reposition TEXT LCD cursor to file pos in HL
	JMP   L5FDDH    ; Main TEXT edit loop
	
L67CBH:	CALL  L4F45H    
	CALL  L65ABH    ; Draw "aborted" on bottom line of LCD
	JMP   L67BAH    
	
L67D4H:
    DB	"Load from:",00H
	
L67DFH:	XRA   A         
	STA   F890H     ; Current column offset within display line buffer
	STA   F6E6H     
	LXI   H,F894H   ; Prepare to point to beginning of line buffer
	SHLD  F892H     ; Save pointer to current position in line buffer
L67ECH:	PUSH  D         ; Save pointer into .DO file
	CALL  L6912H    ; Manage copy/cut SEL highlighting added to line buffer???
	POP   D         ; Restore pointer into .DO file
	LDAX  D         ; Load next character from the .DO file
	INX   D         ; Increment to next byte in .DO file
	CPI   1AH       ; Test for CTRL-Z EOF marker
	JZ    L6887H    ; If EOF, jump to add Left Arrow character to line buffer
	CPI   0DH       ; Test for CR
	JZ    L6897H    ; Add CR character to line buffer
	CPI   09H       ; Test for TAB
	JZ    L6807H    ; Jump it TAB to insert into line buffer
	CPI   20H       ; Test for SPACE
	JC    L685DH    ; Insert control character into line buffer
L6807H:	CALL  L68B2H    ; Add character in A to line buffer with TAB expansion
	JNC   L67ECH    ; Jump to add next character if not at end of line buffer
	LDAX  D         ; Get next byte from .DO file
	CALL  L695EH    ; Test byte in A for word-wrap characters like '-', '(', ')', etc.
	JNZ   L6827H    ; Jump if no word-wrap
	CALL  L6855H    
	LDAX  D         ; Get the next character
	CPI   20H       ; Test if it's a SPACE
	RNZ             ; Return if not a SPACE
	LDA   F920H     ; LCD vs Printer output indication
	ANA   A         ; Test the output location
	RZ              ; Return if output to LCD
	INX   D         ; Increment to next character to test for SPACE
	LDAX  D         ; Get the next character
	CPI   20H       ; Test if next character is SPACE
	RNZ             ; Return if not space
	DCX   D         ; Rewind pointer to character before SPACE
	RET             
	
L6827H:	XCHG            ; HL has .DO pointer
	SHLD  VPSTBF    ; End of RAM for file storage
	XCHG            ; DE has .DO pointer
	LHLD  F892H     ; Get pointer to current position in line buffer
	SHLD  F88EH     ; Save current line buffer position
	DCX   D         ; Decrement to previous byte to test it for word-wrap
	LDAX  D         ; Get the previous byte
	INX   D         ; Back to this byte
	CALL  L695EH    ; Test byte in A for word-wrap characters like '-', '(', ')', etc.
	JZ    L6855H    ; Jump if word-wrap
L683BH:	DCX   D         ; Decrement to previous byte to test it for word-wrap
	LDAX  D         ; Get the previous byte
	INX   D         ; Back to this byte
	CALL  L695EH    ; Test byte in A for word-wrap characters like '-', '(', ')', etc.
	JZ    L68EFH    ; Test for end of format line, add ESC-K + CRLF to line buffer if at end if word-wrap
	DCX   D         
	CALL  L68D9H    
	JNZ   L683BH    
	LHLD  F88EH     ; Restore line buffer position pointer
	SHLD  F892H     ; Save pointer to current position in line buffer
	LHLD  VPSTBF    ; End of RAM for file storage
	XCHG            
L6855H:	LDA   F920H     ; LCD vs Printer output indication
	DCR   A         ; Test if output to printer
	JZ    L6908H    ; Jump if output to printer to add CRLF to line buffer
	RET             
	
L685DH:	PUSH  PSW       ; Preserve character to insert
	MVI   A,5EH     ; Load code for CARET
	CALL  L68B2H    ; Add to line buffer with tab expansion
	JC    L6877H    ; Jump if no room in line buffer for actual code
	POP   PSW       ; Restore character to be inserted
	ORI   40H       ; Convert to lowercase
	CALL  L68B2H    ; Add to line buffer with tab expansion
	JNC   L67ECH    ; If not at end of line, jump to add next character to line buffer
	LDA   F920H     ; LCD vs Printer output indication
	ANA   A         ; Test if output to LCD
	JNZ   L6908H    ; Jump if not output to LCD to add CRLF to line buffer
	RET             
	
L6877H:	POP   PSW       ; Restore stack pointer
	DCX   D         ; Decrement .DO pointer
	LHLD  F892H     ; Get pointer to current position in line buffer
	DCX   H         ; Decrement position in line buffer
	SHLD  F892H     ; Save pointer to current position in line buffer
	LXI   H,F890H   ; Current column offset within display line buffer
	DCR   M         ; Decrement line buffer column counter
	JMP   L68EFH    ; Test for end of format line, add ESC-K + CRLF to line buffer if at end
	
L6887H:	LDA   F920H     ; LCD vs Printer output indication
	ANA   A         ; Test if output to LCD
	MVI   A,9BH     ; Load ASCII code for left arrow
	CZ    L68B2H    ; If output to LCD, add left arrow to line buffer
	CALL  L68EFH    ; Test for end of format line, add ESC-K + CRLF to line buffer if at end
	LXI   D,FFFFH   ; Indicate at EOF
	RET             
	
L6897H:	LDAX  D         ; Get next character to test for CRLF combo
	CPI   0AH       ; Test for LF
	MVI   A,0DH     ; Restore the CR in case we will print it as a control code
	JNZ   L685DH    ; If not CRLF combo, then print CR as control code
	PUSH  D         ; Save pointer into .DO file to stack
	CALL  L6912H    ; Manage copy/cut SEL highlighting added to line buffer???
	POP   D         ; Restore pointer into .DO file
	LDA   F920H     ; LCD vs Printer output indication
	ANA   A         ; Test if output is to LCD
	MVI   A,8FH     ; Load ASCII code for CR mark on LCD
	CZ    L68B2H    ; If output to LCD, add CR mark to line buffer
	CALL  L68EFH    ; Test for end of format line, add ESC-K + CRLF to line buffer if at end
	INX   D         ; Increment to next character to output
	RET             
	
L68B2H:	PUSH  H         ; Save current .DO file pointer
	CALL  L68D0H    ; Add character in A to TEXT display line buffer
	LXI   H,F890H   ; Current column offset within display line buffer
	CPI   09H       ; Test for TAB character
	JZ    L68C2H    ; Jump to process TAB if it's a tab
	INR   M         ; Increment the line buffer column count
	JMP   L68C9H    ; Skip TAB processing and test if at end of line
	
L68C2H:	INR   M         ; Increment the line buffer column
	MOV   A,M       ; Get the line buffer column
	ANI   07H       ; Test if on an 8-column boundry
	JNZ   L68C2H    ; Keep increment column until 8-column tab stop found
L68C9H:	LDA   F922H     ; Output format width (40 or something else for CTRL-Y)
	DCR   A         ; Decrement format width for comparison
	CMP   M         ; Compare format width with current line buffer width
	POP   H         ; Restore pointer to .DO file location
	RET             
	
L68D0H:	LHLD  F892H     ; Get pointer into current column in line buffer
	MOV   M,A       ; Add the character to the line buffer
	INX   H         ; Increment to the next position in line buffer
	SHLD  F892H     ; Save pointer to current position in line buffer
	RET             
	
L68D9H:	LHLD  F892H     ; Get pointer to current position in line buffer
	DCX   H         
	DCX   H         
	DCX   H         
	MOV   A,M       
	CPI   1BH       
	JZ    L68E7H    
	INX   H         
	INX   H         
L68E7H:	SHLD  F892H     ; Save pointer to current position in line buffer
	LXI   H,F890H   ; Current column offset within display line buffer
	DCR   M         
	RET             
	
L68EFH:	LDA   F890H     ; Current column offset within display line buffer
	LXI   H,F922H   ; Output format width (40 or something else for CTRL-Y)
	CMP   M         ; Test if we have reached the output format width
	RNC             ; Return if not at end of format line
	LDA   F920H     ; LCD vs Printer output indication
	ANA   A         ; Test if output to LCD
	JNZ   L6908H    ; Skip adding of ESCape sequence if not LCD
	MVI   A,1BH     ; Load code for ESCape
	CALL  L68D0H    ; Add character in A to TEXT display line buffer??
	MVI   A,4BH     ; Load code for ESC-K
	CALL  L68D0H    ; Add character in A to TEXT display line buffer??
L6908H:	MVI   A,0DH     ; Load code for CR
	CALL  L68D0H    ; Add character in A to TEXT display line buffer??
	MVI   A,0AH     ; Load code for LF
	JMP   L68D0H    ; Add character in A to TEXT display line buffer??
	
L6912H:	CALL  L62EEH    ; Test for a valid SEL region. If none, return to caller to skip the copy/cut
	LDA   F920H     ; LCD vs Printer output indication
	ANA   A         ; Test if output to LCD
	RNZ             ; Return if not output to LCD - no SEL highlighting to printer
	LXI   B,F6E6H   
	PUSH  D         
	XCHG            
	LHLD  F6E4H     ; End address in .DO file of SELection for copy/cut
	XCHG            
	RST   3         ; Compare DE and HL
	POP   D         
	JNC   L693FH    
	XCHG            
	RST   3         ; Compare DE and HL
	JC    L694DH    
	XCHG            
	LHLD  F6E4H     ; End address in .DO file of SELection for copy/cut
	XCHG            
	RST   3         ; Compare DE and HL
	JNC   L694DH    
L6936H:	LDAX  B         
	ANA   A         
	RNZ             
	INR   A         
	MVI   H,70H     
	JMP   L6953H    
	
L693FH:	XCHG            
	RST   3         ; Compare DE and HL
	JNC   L694DH    
	XCHG            
	LHLD  F6E4H     ; End address in .DO file of SELection for copy/cut
	XCHG            
	RST   3         ; Compare DE and HL
	JNC   L6936H    
L694DH:	LDAX  B         
	ANA   A         
	RZ              
	XRA   A         
	MVI   H,71H     
L6953H:	PUSH  H         
	STAX  B         
	MVI   A,1BH     
	CALL  L68D0H    ; Add character in A to TEXT display line buffer??
	POP   PSW       
	JMP   L68D0H    ; Add character in A to TEXT display line buffer??
	
L695EH:	MOV   B,A       ; Save character to B
	LDA   F921H     ; Get word-wrap enable flag
	ANA   A         ; Test for word-wrap enable
	MOV   A,B       ; Restore character from .DO file
	RZ              ; Return if word-wrap disabled?
L6965H:	LXI   H,L6977H  ; Load pointer to wrap character table
	MVI   B,0AH     ; Prapare to test 10 characters from table
L696AH:	CMP   M         ; Test for match with next character from table
	RZ              ; Return if match found
	INX   H         ; Increment to next entry in table
	DCR   B         ; Decrement table count
	JNZ   L696AH    ; Jump to test next entry from table
	CPI   21H       ; Test if character > '!'
	INR   B         ; Clear zero flag to indicate no-wrap
	RNC             ; Return if character is not control code
	DCR   B         ; Set zero flag to indicate wrap
	RET             
	
L6977H:
    DB	"()<>[]+-*/"          
L6981H:	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	ANA   A         
	RAR             ; Multiply row count x 2
L6986H:	CALL  L6B39H    
	SHLD  F6EBH     ; Storage of TEXT Line Starts
	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	ADD   A         
	LXI   H,F6EDH   
L6993H:	MVI   M,FEH     
	INX   H         
	DCR   A         
	JNZ   L6993H    
	INR   A         
	JMP   L69CBH    ; Display line 'A' of the .DO file at HL for editing base on line starts array
	
L699EH:	PUSH  PSW       ; Save Current cursor row on stack
	LHLD  F6E9H     ; Address of 1st byte on last line of TEXT
	MOV   A,H       ; Get MSB of address
	ORA   L         ; Or in LSB to test for NULL address
	JZ    L69CAH    ; Jump if no line currenty displayed on LCD
	XCHG            ; Put Address of last displayed line of TEXT into DE
	CALL  L67DFH    ; Build next line from .DO file at (DE) into line buffer
	POP   PSW       ; Restore current cursor row from stack
	MOV   B,A       ; Put current cursor row into B
	CALL  L6A27H    ; Update line starts array entry for row specified in A
	MOV   A,B       ; Restore current cursor row
	PUSH  PSW       ; Save current cursor row to stack
	JZ    L69CAH    ; If current row is the selected row, skip ahead
	DCR   A         ; Test if on top row
	JZ    L69CAH    ; If on top row, skip ahead
	MOV   L,A       ; Put row number in L
	MVI   H,01H     ; Go to COL 1
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	CALL  L6A10H    
	MOV   A,D       
	ANA   E         
	INR   A         
	POP   B         
	JZ    ERABOL    ; Erase from cursor to end of line
	PUSH  B         
L69CAH:	POP   PSW       ; Restore PSW from stack
L69CBH:	MOV   L,A       
	MVI   H,01H     
	CALL  POSIT     ; Set the current cursor position (H=Row),L=Col)
	CALL  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	MOV   A,E       
	ANA   D         
	INR   A         
	JZ    L6A04H    
	CALL  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
L69DDH:	CALL  L63DBH    ; Get number of LCD rows based on label protect + cols in HL
	CMP   L         
	JZ    L69F4H    
	CALL  L6A0DH    ; Build and display next line from .DO file at (DE)
	MOV   A,D       
	ANA   E         
	INR   A         
	JZ    L69FEH    
	CALL  L6A2EH    ; Update line starts array entry for current Cursor row
	JNZ   L69DDH    
	RET             
	
L69F4H:	CALL  L6A0DH    ; Build and display next line from .DO file at (DE)
L69F7H:	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	INR   A         
	JMP   L6A27H    ; Update line starts array entry for row specified in A
	
L69FEH:	CALL  L6A2EH    ; Update line starts array entry for current Cursor row
	JZ    L69F7H    
L6A04H:	CALL  ERABOL    ; Erase from cursor to end of line
	CALL  CRLF      ; Send CRLF to screen or printer
	JMP   L69FEH    
	
L6A0DH:	CALL  L67DFH    ; Build next line from .DO file at (DE) into line buffer
L6A10H:	PUSH  D         ; Save .DO file pointer on stack
	LHLD  F892H     ; Get pointer to current position in line buffer
	LXI   D,F894H   ; Point to line buffer where current line is built (tab expansion, word wrap)
L6A17H:	LDAX  D         ; Get next byte to be displayed
	RST   4         ; Send character in A to screen/printer
	INX   D         ; Increment to next byte in line buffer
	RST   3         ; Compare DE and HL
	JNZ   L6A17H    ; Loop to display all bytes in line buffer
	LDA   F920H     ; LCD vs Printer output indication
	ANA   A         ; Test if printing to LCD
	CZ    EXTREF    ; Cancel inverse character mode
	POP   D         ; Restore .DO file pointer
	RET             
	
L6A27H:	PUSH  D         ; Push address in .DO file of end of current line
	CALL  L6A48H    ; Get address in .DO file of start of row in 'A' using Line Starts array
	JMP   L6A32H    
	
L6A2EH:	PUSH  D         
	CALL  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
L6A32H:	MOV   C,A       ; Save row number in C
	XTHL            ; Get address of end of current line from stack
	RST   3         ; Compare DE and HL
	MOV   A,C       ; Restore row number
	XCHG            ; Put address of end of current line in DE
	POP   H         ; Pop the address to entry in Line Starts array for current row
	RZ              ; Return if the address match (current row is the selected row maybe?)
	MOV   M,E       ; Update the start address in line starts array for current row
	INX   H         ; Increment to MSB in line starts array
	MOV   M,D       ; Update the start address in line starts array for current row
	MOV   A,C       ; Restore row number
	RET             
	
L6A3EH:	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	INR   A         ; Increment to the line below bottom of LCD
	JMP   L6A48H    ; Get address in .DO file of start of row in 'A' using Line Starts array
	
L6A45H:	LDA   VCURLN    ; Cursor row (1-8)
L6A48H:	MOV   E,A       ; Prepare to index into Line Start Array
	MVI   D,00H     
	LXI   H,F6E9H   ; Pointer to Line Start Addresses
	DAD   D         ; Index into Line Start array
	DAD   D         ; Each entry is 2 bytes
	MOV   E,M       ; Get LSB of address for current row
	INX   H         ; Increment to MSB
	MOV   D,M       ; Get MSB of address for current row
	DCX   H         ; Decrement back to LSB
	RET             
	
L6A55H:	CALL  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	DCR   A         ; Decrement the row nubmer
	JZ    L6A61H    ; Jump if on top row
	DCX   H         ; Decrement pointer into Line Starts array
	MOV   D,M       ; Get MSB of address of start of line for previous row
	DCX   H         ; Decrement address into Line Starts array
	MOV   E,M       ; Get LSB of address of start of line for previous row
	RET             
	
L6A61H:	LHLD  F767H     ; Load start address of .DO file being edited
	RST   3         ; Compare DE and HL
	JC    L6A6CH    
	LXI   D,0000H  
	RET             
	
L6A6CH:	PUSH  D         
	DCX   D         
	RST   3         ; Compare DE and HL
	JNC   L6A8AH    
L6A72H:	DCX   D         
	RST   3         ; Compare DE and HL
	JNC   L6A8AH    
	LDAX  D         
	CPI   0AH       
	JNZ   L6A72H    
	DCX   D         
	RST   3         ; Compare DE and HL
	JNC   L6A8AH    
	LDAX  D         
	INX   D         
	CPI   0DH       
	JNZ   L6A72H    
	INX   D         
L6A8AH:	PUSH  D         
	CALL  L67DFH    ; Build next line from .DO file at (DE) into line buffer
	POP   B         
	XCHG            
	POP   D         
	PUSH  D         
	RST   3         ; Compare DE and HL
	XCHG            
	JC    L6A8AH    
	POP   D         
	MOV   E,C       
	MOV   D,B       
	RET             
	
L6A9BH:	CALL  L6A55H    ; Get address in .DO file of start of line for the previous row
	XCHG            
	SHLD  F6E9H     ; Address of 1st byte on last line of TEXT
	RET             
	
L6AA3H:	SHLD  F6E7H     ; Temp storage for HL
	PUSH  H         
	LXI   H,F6EBH   ; Load pointer to TEXT line start addresses
	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	MOV   B,A       ; Save number of rows to B
L6AAEH:	MOV   E,M       ; Get LSB of address in .DO for 1st byte at next line
	INX   H         ; Increment to MSB
	MOV   D,M       ; Get MSB of address in .DO for 1st byte at next line
	INX   H         ; Increment to pointer for next line
	PUSH  H         
	LHLD  F6E7H     ; Restore HL from temp storage
	RST   3         ; Compare DE and HL
	JC    L6AC4H    
	POP   H         
	XCHG            
	XTHL            
	XCHG            
	DCR   B         
	JP    L6AAEH    
	DI              
	HLT             
L6AC4H:	XCHG            
	POP   H         
	POP   H         
L6AC7H:	PUSH  H         ; Push address of start of current line in .DO
	LXI   H,F894H   ; Point to beginning of line buffer
	SHLD  F892H     ; Save pointer to current position in line buffer
	XRA   A         ; Zero out A to reset column offset
	STA   F890H     ; Current column offset within display line buffer
	POP   H         ; Pop address of start of current line in .DO file
	DCX   H         ; Pre-decrement address because of INX H below
L6AD4H:	INX   H         ; Increment to next character on line
	RST   3         ; Compare DE and HL
	JNC   L6AEEH    ; Jump if at end of row
	MOV   A,M       ; Get next byte from current row
	CALL  L68B2H    ; Add character in A to line buffer with TAB expansion
	MOV   A,M       ; Get the byte again
	CPI   20H       ; Test if it's less than space
	JNC   L6AD4H    ; If not less than space, jump to process next character
	CPI   09H       ; Test if it's a TAB
	JZ    L6AD4H    ; If it's TAB, jump to process next (TAB already correct)
	CALL  L68B2H    ; Add character in A to line buffer again to count the CARET for control codes
	JMP   L6AD4H    ; Jump to process next character in line
	
L6AEEH:	LDA   F890H     ; Current column offset within display line buffer
	INR   A         ; Make column 1-based
	MOV   H,A       ; Move column to H
	CALL  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	SUB   B         ; Calculate number of empty rows (maybe?)
	MOV   L,A       ; Put empty row count in L
	RET             
	
L6AF9H:	CALL  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	PUSH  D         ; Push address to stack
	INR   A         ; Increment the row number
	CALL  L6A48H    ; Get address in .DO file of start of next row
	MOV   A,D       ; Prepare to test for -1
	ANA   E         ; AND LSB
	INR   A         ; Test for -1
	JNZ   L6B0CH    ; Jump if not -1
	LHLD  FB62H     ; Load pointer to end of .DO file
	XCHG            ; Put pointer to end of .DO into DE
	INX   D         ; Pre-Increment pointer because of DCX below
L6B0CH:	DCX   D         ; Decrement to byte prior to this line
	LDAX  D         ; Load the last byte from the previous line
	CPI   0AH       ; Test if it was LF
	JNZ   L6B1BH    ; Jump if not LF
	DCX   D         ; Decrement to next previous byte to test for CR
	LDAX  D         ; Load next previous byte
	CPI   0DH       ; Test for CR
	JZ    L6B1BH    ; If it's CR, skip increment below
	INX   D         ; Not CR, increment back to LF
L6B1BH:	POP   H         ; Pop address of start of current line in .DO file
	PUSH  H         ; Push it back on the stack
	CALL  L6AC7H    ; Get column/row of character in .DO file at (DE)
	LDA   VCURCL    ; Cursor column (1-40)
	CMP   H         ; Test if DE points to current Cursor column
	JC    L6B0CH    ; Jump to decrement DE if location not found yet
	POP   H         ; Pop address of start of current line in .DO file
	XCHG            ; Put the address in DE, HL has COL/ROW
	RET             
	
L6B2AH:	LHLD  F767H     ; Load start address of .DO file being edited
L6B2DH:	MVI   A,1AH     ; Prepare to compare with 1Ah
L6B2FH:	CMP   M         ; Test next byte of file for 1Ah
	INX   H         ; Increment pointer
	JNZ   L6B2FH    ; If not 1Ah, jump to test next byte
	DCX   H         ; Decrement back to 1Ah location
	SHLD  FB62H     ; Save location of end of .DO file
	RET             
	
L6B39H:	PUSH  PSW       ; Push line count to display to stack
	XCHG            ; Put address of .DO file in DE
	LHLD  F767H     ; Load start address of .DO file being edited
	XCHG            ; HL has address in .DO file to display, DE has start of .DO file
L6B3FH:	PUSH  H         ; Push address in .DO file for display to stack
	PUSH  D         ; Push beginning of .DO file address to stack
	CALL  L67DFH    ; Build next line from .DO file at (DE) into line buffer
	POP   B         ; Restore beginning of .DO file address to BC
	POP   H         ; Restore address in .DO file to display
	RST   3         ; Compare DE and HL
	JNC   L6B3FH    
	MOV   H,B       
	MOV   L,C       
	POP   B         ; Pop line count to display from stack
	DCR   B         ; Decrement line count to display
	RZ              ; Return if done
	XCHG            
L6B50H:	PUSH  B         
	CALL  L6A61H    
	POP   B         
	MOV   A,D       
	ORA   E         
	LHLD  F767H     ; Load start address of .DO file being edited
	RZ              
	DCR   B         
	JNZ   L6B50H    
	XCHG            
	RET             
	
	
; ======================================================
; Insert A into text file at M
; ======================================================
L6B61H:	LXI   B,L0001H  ; Prepare to insert 1 space in .DO file to make room
	PUSH  PSW       ; Save character to be inserted to stack
	CALL  L6B6DH    ; Insert BC spaces at M
	POP   B         ; Pop insert character from stack
	RC              ; If out of memory, return
	MOV   M,B       ; Insert the character into .DO file
	INX   H         ; Increment the current file pointer
	RET             
	
	
; ======================================================
; Insert BC spaces at M
; ======================================================
L6B6DH:	XCHG            
	LHLD  FBB6H     ; Unused memory pointer
	DAD   B         
	RC              
	MVI   A,88H     
	SUB   L         
	MOV   L,A       
	MVI   A,FFH     
	SUB   H         
	MOV   H,A       
	RC              
	DAD   SP        
	CMC             
	RC              
L6B7FH:	PUSH  B         
	CALL  L6BC3H    ; Update file pointers using BC (add)
	LHLD  FBB6H     ; Unused memory pointer
	MOV   A,L       
	SUB   E         
	MOV   E,A       
	MOV   A,H       
	SBB   D         
	MOV   D,A       
	PUSH  D         
	MOV   E,L       
	MOV   D,H       
	DAD   B         
	SHLD  FBB6H     ; Unused memory pointer
	XCHG            
	DCX   D         
	DCX   H         
	POP   B         
	MOV   A,B       
	ORA   C         
	CNZ   L6BE6H    ; Move BC bytes from M to (DE) with decrement
	INX   H         
	POP   B         
	RET             
	
	
; ======================================================
; Delete BC characters at M
; ======================================================
L6B9FH:	MOV   A,B       
	ORA   C         
	RZ              
	PUSH  H         
	PUSH  B         
	PUSH  H         
	DAD   B         
	XCHG            
	LHLD  FBB6H     ; Unused memory pointer
	XCHG            
	MOV   A,E       
	SUB   L         
	MOV   C,A       
	MOV   A,D       
	SUB   H         
	MOV   B,A       
	POP   D         
	MOV   A,B       
	ORA   C         
	CNZ   L6BDBH    ; Move BC bytes from M to (DE) with increment
	XCHG            
	SHLD  FBB6H     ; Unused memory pointer
	POP   B         
	XRA   A         
	SUB   C         
	MOV   C,A       
	SBB   A         
	SUB   B         
	MOV   B,A       
	POP   H         
L6BC3H:	PUSH  H         
	LHLD  FBB0H     ; Start of CO files pointer
	DAD   B         
	SHLD  FBB0H     ; Start of CO files pointer
	LHLD  FBB2H     ; Start of variable data pointer
	DAD   B         
	SHLD  FBB2H     ; Start of variable data pointer
	LHLD  FBB4H     ; Start of array table pointer
	DAD   B         
	SHLD  FBB4H     ; Start of array table pointer
	POP   H         
	RET             
	
	
; ======================================================
; Move BC bytes from M to (DE) with increment
; ======================================================
L6BDBH:	MOV   A,M       
	STAX  D         
	INX   H         
	INX   D         
	DCX   B         
	MOV   A,B       
	ORA   C         
	JNZ   L6BDBH    ; Move BC bytes from M to (DE) with increment
	RET             
	
	
; ======================================================
; Move BC bytes from M to (DE) with decrement
; ======================================================
L6BE6H:	MOV   A,M       
	STAX  D         
	DCX   H         
	DCX   D         
	DCX   B         
	MOV   A,B       
	ORA   C         
	JNZ   L6BE6H    ; Move BC bytes from M to (DE) with decrement
	RET             
	
	
; ======================================================
; ROM programs catalog entries
; ======================================================
L6BF1H:
    DB	B0H             
	DW	6C49H          
    DB	"BASIC",00H     
    DB	B0H             
	DW	5DEEH          
    DB	"TEXT ",00H     
    DB	B0H             
	DW	5146H          
    DB	"TELCOM",00H     
    DB	B0H             
	DW	5B68H          
    DB	"ADDRSS",00H     
    DB	B0H             
	DW	5B6FH          
    DB	"SCHEDL",00H     
    DB	88H             
	DW	0000H          
    DB	32H,FBH,FFH,C3H,82H,76H,20H          ; Different from M100
    DB	C8H             
	DW	0000H          
L6C37H:
    DB	C5H,CDH,DDH,26H,C1H,C9H,69H          ; Different from M100
    DB	48H             
	DW	0000H          
L6C42H:
    DB	32H,09H,F8H,C3H,8DH,21H,20H          ; Different from M100
	
; ======================================================
; BASIC Entry point
; ======================================================
L6C49H:	CALL  L6C7FH    
	CALL  L7EA6H    ; Display TRS-80 Model number & Free bytes on LCD
	LXI   H,F999H   
	SHLD  FA8CH     ; Mark Unsaved BASIC program as active program
	LHLD  F99AH     ; BASIC program not saved pointer
	SHLD  VBASPP    ; Start of BASIC program pointer
L6C5BH:	CALL  L6C9CH    ; Copy BASIC Function key table to key definition area
	CALL  FNKSB     ; Display function keys on 8th line
	XRA   A         
	STA   F650H     
	INR   A         
	STA   FAADH     ; Label line enable flag
	LXI   H,L6C78H  ; Load pointer to "llist" text
	SHLD  F88AH     ; Save as key sequence for SHIFT-PRINT key
	CALL  L05F0H    ; Update line addresses for current BASIC program
	CALL  L3F28H    ; Initialize BASIC Variables for new execution
	JMP   L0502H    ; Vector to BASIC ready - print Ok
	
L6C78H:
    DB	"llist",0DH,00H          
	
L6C7FH:	LHLD  FBB2H     ; Start of variable data pointer
	LXI   B,L0178H  
	DAD   B         
	XCHG            
	LHLD  FB67H     ; File buffer area pointer
	RST   3         ; Compare DE and HL
	JC    L6C8FH    
	DCR   H         
L6C8FH:	SHLD  VTPRAM    ; BASIC string buffer pointer
	RET             
	
	
; ======================================================
; Copy BASIC Function key table to key definition area
; ======================================================
L6C93H:	LXI   H,F789H   ; Function key definition area
	LXI   D,F80AH   ; Function key definition area (BASIC)
	JMP   L6CA2H    
	
	
; ======================================================
; Copy BASIC Function key table to key definition area
; ======================================================
L6C9CH:	LXI   H,F80AH   ; Function key definition area (BASIC)
	LXI   D,F789H   ; Function key definition area
L6CA2H:	MVI   B,80H     
	JMP   L2542H    ; Move B bytes from M to (DE)
	
L6CA7H:	DCX   H         
	RST   2         ; Get next non-white char from M
L6CA9H:	LDAX  D         
	INR   A         
	RZ              
	PUSH  H         
	MVI   B,04H     
L6CAFH:	LDAX  D         
	MOV   C,A       
	CALL  L0FE8H    ; Get char at M and convert to uppercase
	CMP   C         
	INX   D         
	INX   H         
	JNZ   L6CCCH    
	DCR   B         
	JNZ   L6CAFH    
	POP   PSW       
	PUSH  H         
	XCHG            
	MOV   E,M       
	INX   H         
	MOV   D,M       
	XCHG            
	POP   D         
	XTHL            
	PUSH  H         
	XCHG            
	INR   H         
	DCR   H         
	RET             
	
L6CCCH:	INX   D         
	DCR   B         
	JNZ   L6CCCH    
	INX   D         
	POP   H         
	JMP   L6CA9H    
	
	
; ======================================================
; Re-initialize system without destroying files
; ======================================================
L6CD6H:	DI              
	LXI   H,FF40H   ; XON/XOFF protocol control
	MVI   B,BDH     
	CALL  L4F0AH    ; Zero B bytes at M
	INR   A         
	
; ======================================================
; Warm start reset entry
; ======================================================
L6CE0H:	PUSH  PSW       
	DI              
	MVI   A,19H     
	SIM             
	IN    C8H       ; Read UART byte to flush any garbage
	MVI   A,43H     ; Load output code for 8155 mode
	OUT   B8H       ; Set 8155 Mode
	MVI   A,05H     
	CALL  L7383H    ; Set clock chip mode
	MVI   A,EDH     ; Initialize value for 8155 Port B
	OUT   BAH       ; Configure 8155 Port B output
	XRA   A         
	STA   FF45H     ; Contents of port E8H
	OUT   E8H       ; Clear OptROM select, STROBE, etc.
	OUT   A8H       
	CALL  L6C2CH    ; Differen from M100: Check for optional external controller
	CALL  L7533H    ; Enable LCD drivers after short delay
	XRA   A         
	OUT   FEH       
	CALL  L7533H    ; Enable LCD drivers after short delay
	MVI   A,3BH     ; Load code to enable LCD drivers
	OUT   FEH       ; Output LCD Enable command to LCD drivers
	CALL  L752BH    ; Set the display top line to zero for all LCD controllers
	CALL  L7533H    ; Enable LCD drivers after short delay
	MVI   A,39H     
	OUT   FEH       
	EI              
	CALL  L76A0H    ; Call routine to test if DVI data available
	JNC   L6D1EH    ; Jump if data available from DVI
L6D1DH:	XRA   A         ; Indicate no DVI present
L6D1EH:	STA   FC81H     ; Store flag indicating DVI present??
	ORA   A         ; Test if DVI present?
	JZ    L6D3DH    ; Branch to exit Warm Start if no DVI
	LDA   FFFCH     ; Load DVI Disk BASIC code initializer value
	ORA   A         ; Test if DVI Disk BASIC already loaded
	JNZ   L6D3DH    ; Jump if already loaded
	POP   PSW       
	RZ              
	LHLD  FBB2H     ; Start of variable data pointer
	LXI   D,E000H   ; Location of init code to be copied from DVI
	RST   3         ; Compare DE and HL
	RNC             ; Return if not enough space to copy DVI init code
	CALL  L76B6H    ; Copy initialization code from DVI to E000h and execute
	PUSH  PSW       
	JC    L6D1DH    
L6D3DH:	POP   PSW       
	RET             
	
	
; ======================================================
; L6D3FH: Send a character to the line printer
; Entry conditions: A = character to be printed
; Exit conditions:
;       Carry -- set if cancelled
;             -- reset if normal return
; ======================================================
PRINTR:	PUSH B
	MOV   C,A       
L6D41:	CALL CHSHBR     ; Check if SHIFT-BREAK is being pressed
	JC   L6D6A     
	IN   BBH       
	ANI  06H       
	XRI  02H       
	JNZ  L6D41     
	CALL L765CH    ; Set interrupt to 1DH
	MOV  A,C       
	OUT  B9H       
	LDA  FF45H     ; Contents of port E8H
	MOV  B,A       
	ORI  02H       
	OUT  E8H       
	MOV  A,B       
	OUT  E8H       
	MVI  B,24H     
L6D63:	DCR  B
	JNZ  L6D63     
	MVI  A,09H     
	SIM            
L6D6A:	MOV  A,C
	POP  B         
	RET             
	
	
; ======================================================
; Check RS232 queue for pending characters
; ======================================================
L6D6DH:	LDA  FF42H      ; XON/XOFF enable flag
	ORA  A         
	JZ   L6D79H    
	LDA  FF41H      ; XON/XOFF protocol control
	INR  A         
	RZ             
L6D79H:	LDA  FF86H      ; RS232 buffer count
	ORA  A         
	RET             
	
	
; ======================================================
; Get a character from RS232 receive queue
; ======================================================
L6D7EH:	PUSH H         
	PUSH D         
	PUSH B         
	LXI  H,L71F8H   ; Interrupt exit routine (pop all regs & RET)
	PUSH H         
	LXI  H,FF86H    ; RS232 buffer count
L6D88H:	CALL CHSHBR     ; Check if SHIFT-BREAK is being pressed
	RC             
	CALL L6D6DH     ; Check RS232 queue for pending characters
	JZ   L6D88H    
	CPI  03H       
	CC   L6E0BH     ; Send XON (CTRL-Q) out RS232
	DI             
	DCR  M         
	CALL L6DFCH     ; Calculate address to save next RS232 character
	MOV  A,M       
	XCHG           
	INX  H         
	INX  H         
	INR  M         
	DCR  M         
	RZ             
	DCR  M         
	JZ   L6DA9H    
	CMP  A         
	RET            
	
L6DA9H:	ORI  FFH       
	RET             
	
	
; ======================================================
; RST 6.5 routine (RS232 receive interrupt)
; ======================================================
L6DACH:	CALL  VUARTH    ; RST 6.5 RAM Vector
	PUSH  H         
	PUSH  D         
	PUSH  B         
	PUSH  PSW       
	LXI   H,L71F7H  ; Interrupt exit routine (pop all regs & RET)
	PUSH  H         
	IN    C8H       
	LXI   H,FF8DH   ; RS232 Parity Control byte
	ANA   M         
	MOV   C,A       
	IN    D8H       
	ANI   0EH       
	MOV   B,A       
	JNZ   L6DDBH    
	MOV   A,C       
	CPI   11H       
	JZ    L6DD2H    
	CPI   13H       
	JNZ   L6DDBH    
	MVI   A,AFH     
	STA   FF40H     ; XON/XOFF protocol control
	LDA   FF42H     ; XON/XOFF enable flag
	ORA   A         
	RNZ             
L6DDBH:	LXI   H,FF86H   ; RS232 buffer count
	MOV   A,M       
	CPI   40H       
	RZ              
	CPI   28H       
	CNC   L6E1EH    ; Turn off XON/XOFF protocol
	PUSH  B         
	INR   M         
	INX   H         
	CALL  L6DFCH    ; Calculate address to save next RS232 character
	POP   B         
	MOV   M,C       
	MOV   A,B       
	ORA   A         
	RZ              
	XCHG            
	INX   H         
	DCR   M         
	INR   M         
	RNZ             
	LDA   FF86H     ; RS232 buffer count
	MOV   M,A       
	RET             
	
	
; ======================================================
; Calculate address to save next RS232 character
; ======================================================
L6DFCH:	INX   H         
	MOV   C,M       
	MOV   A,C       
	INR   A         
	ANI   3FH       
	MOV   M,A       
	XCHG            
	LXI   H,FF46H   ; RS232 Character buffer
	MVI   B,00H     
	DAD   B         
	RET             
	
	
; ======================================================
; Send XON (CTRL-Q) out RS232
; ======================================================
L6E0BH:	LDA   FF42H     ; XON/XOFF enable flag
	ANA   A         
	RZ              
	LDA   FF8AH     ; Control-S status
	DCR   A         
	RNZ             
	STA   FF8AH     ; Control-S status
	PUSH  B         
	MVI   C,11H     
	JMP   L6E3AH    ; Send character in C to serial port
	
	
; ======================================================
; Turn off XON/XOFF protocol
; ======================================================
L6E1EH:	LDA   FF42H     ; XON/XOFF enable flag
	ANA   A         
	RZ              
	LDA   FF8AH     ; Control-S status
	ORA   A         
	RNZ             
	INR   A         
	STA   FF8AH     ; Control-S status
	PUSH  B         
	MVI   C,13H     
	JMP   L6E3AH    ; Send character in C to serial port
	
	
; ======================================================
; Send character in A to serial port using XON/XOFF
; ======================================================
L6E32H:	PUSH  B         
	MOV   C,A       
	CALL  L6E4DH    ; Handle XON/XOFF protocol
	JC    L6E4AH    
	
; ======================================================
; Send character in C to serial port
; ======================================================
L6E3AH:	CALL  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	JC    L6E4AH    
	IN    D8H       
	ANI   10H       
	JZ    L6E3AH    ; Send character in C to serial port
	MOV   A,C       
	OUT   C8H       
L6E4AH:	MOV   A,C       
	POP   B         
	RET             
	
	
; ======================================================
; Handle XON/XOFF protocol
; ======================================================
L6E4DH:	LDA   FF42H     ; XON/XOFF enable flag
	ORA   A         
	RZ              
	MOV   A,C       
	CPI   11H       
	JNZ   L6E5FH    
	XRA   A         
	STA   FF8AH     ; Control-S status
	JMP   L6E65H    
	
L6E5FH:	SUI   13H       
	JNZ   L6E69H    
	DCR   A         
L6E65H:	STA   FF41H     ; XON/XOFF protocol control
	RET             
	
L6E69H:	CALL  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	RC              
	LDA   FF40H     ; XON/XOFF protocol control
	ORA   A         
	JNZ   L6E69H    
	RET             
	
	
; ======================================================
; Set RS232 baud rate stored in H
; ======================================================
L6E75H:	PUSH  H         
	MOV   A,H       
	RLC             
	LXI   H,L6E92H  
	MVI   D,00H     
	MOV   E,A       
	DAD   D         
	SHLD  FF8BH     ; UART baud rate timer value
	POP   H         
L6E83H:	PUSH  H         
	LHLD  FF8BH     ; UART baud rate timer value
	MOV   A,M       
	OUT   BCH       
	INX   H         
	MOV   A,M       
	OUT   BDH       
	MVI   A,C3H     
	OUT   B8H       
L6E92H:	POP   H         
	RET             
	
	
; ======================================================
; RS232 baud rate timer values
; ======================================================
	DW	4800H,456BH,4200H,4100H
	DW	4080H,4040H,4020H,4010H
	DW	4008H          
	
	
; ======================================================
; Initialize RS232 or modem
; ======================================================
L6EA6H:	PUSH  H         
	PUSH  D         
	PUSH  B         
	PUSH  PSW       
	MVI   B,25H     
	JC    L6EB3H    
	MVI   H,03H     
	MVI   B,2DH     
L6EB3H:	DI              
	CALL  L6E75H    ; Set RS232 baud rate stored in H
	MOV   A,B       
	OUT   BAH       
	IN    D8H       
	MOV   A,L       
	ANI   1FH       
	OUT   D8H       
	CALL  L6F39H    ; Initialize serial buffer parameters
	DCR   A         
	STA   FF43H     ; RS232 initialization status
	JMP   L71F7H    ; Interrupt exit routine (pop all regs & RET)
	
	
; ======================================================
; Deactivate RS232 or modem
; ======================================================
L6ECBH:	IN    BAH       
	ORI   C0H       
	OUT   BAH       
	XRA   A         
	STA   FF43H     ; RS232 initialization status
	RET             
	
L6ED6H:	MVI   E,00H     
L6ED8H:	IN    D8H       
	ANI   01H       
	XRA   D         
	JNZ   L6EE5H    ; Click sound port if sound enabled
	INR   E         
	JP    L6ED8H    
	RET             
	
	
; ======================================================
; Click sound port if sound enabled
; ======================================================
L6EE5H:	PUSH  PSW       ; Preserve PSW
	LDA   FF44H     ; Sound flag
	ORA   A         ; Test if sound enabled
	CZ    L7676H    ; Click sound port
	POP   PSW       ; Restore PSW
	RET             
	
	
; ======================================================
; Check for carrier detect
; ======================================================
L6EEFH:	PUSH  H         
	PUSH  D         
	PUSH  B         
	LXI   H,L6F2CH  
	PUSH  H         
	IN    BBH       
	ANI   10H       
	LXI   H,L0249H  
	LXI   B,L1A0EH  
	JNZ   L6F09H    
	LXI   H,L0427H  
	LXI   B,L0C07H  
L6F09H:	DI              
	IN    D8H       
	ANI   01H       
	MOV   D,A       
	CALL  L6ED6H    
	JM    L6F1AH    
	XRA   D         
	MOV   D,A       
	CALL  L6ED6H    
L6F1AH:	EI              
	RM              
	MOV   A,E       
	CMP   B         
	RNC             
	CMP   C         
	RC              
	DCX   H         
	MOV   A,H       
	ORA   L         
	JNZ   L6F09H    
	CALL  L6F39H    ; Initialize serial buffer parameters
	POP   H         
	JNZ   FFF6H     
	JMP   L14EEH    ; POP BC, DE, HL from stack
	
	
; ======================================================
; Enable XON/OFF when CTRL-S / CTRL-Q sent
; ======================================================
L6F31H:	MVI   A,AFH     
	DI              
	STA   FF42H     ; XON/XOFF enable flag
	EI              
	RET             
	
	
; ======================================================
; Initialize serial buffer parameters
; ======================================================
L6F39H:	XRA   A         
	MOV   L,A       
	MOV   H,A       
	SHLD  FF40H     ; XON/XOFF protocol control
	SHLD  FF86H     ; RS232 buffer count
	SHLD  FF88H     ; RS232 buffer input pointer
	RET             
	
	
; ======================================================
; Write cassette header and sync byte
; ======================================================
L6F46H:	LXI   B,L0200H  ; SYNC header is 512 bytes of 55h
L6F49H:	MVI   A,55H     ; Load 55h byte
	PUSH  B         ; Save remaining count
	CALL  L6F5EH    ; Send next 55h byte to CAS
	POP   B         ; Pop count
	DCX   B         ; Decrement count
	MOV   A,B       ; Prepare to test for zero
	ORA   C         ; OR in LSB to test for zero
	JNZ   L6F49H    ; Loop until 512 bytes sent
	MVI   A,7FH     ; After 512 bytes of 55h, send one 7Fh byte
	JMP   L6F5EH    ; Send final 7FH byte to CAS
	
	
; ======================================================
; Write char in A to cassette w/o checksum or sync bit
; ======================================================
L6F5BH:	CALL  L6F71H    ; Call routine to send a single 0 bit before the byte
L6F5EH:	MVI   B,08H     ; Prepare to send 8 bits of data
L6F60H:	CALL  L6F6AH    ; Write bit 0 of A to cassette
	DCR   B         ; Decrement bit counter
	JNZ   L6F60H    ; Loop for all 8 bits
	JMP   CHSHBR    ; Check if SHIFT-BREAK is being pressed
	
	
; ======================================================
; Write bit 0 of A to cassette
; ======================================================
L6F6AH:	RLC             ; Rotate MSB into Carry
	LXI   D,L1F24H  ; Cassette frequency cycle count
	JC    L6F74H    ; Jump if MSB is a 1
L6F71H:	LXI   D,L4349H  ; Cassette frequency cycle count
L6F74H:	DCR   D         ; Decrement the counter
	JNZ   L6F74H    ; Loop until D is zero
	MOV   D,A       ; Save byte being sent in D
	MVI   A,D0H     ; Prepare to set Serial Output data to 1
	SIM             ; Set SOD to 1
L6F7CH:	DCR   E         ; Decrement E
	JNZ   L6F7CH    ; Loop until E is zero
	MVI   A,50H     ; Prepare to set Serial Output Data to 0
	SIM             ; Set SOD to 0
	MOV   A,D       ; Restore byte being sent
	RET             
	
	
; ======================================================
; Read cassette header and sync byte
; ======================================================
L6F85H:	MVI   B,80H     ; Set sync bit counter to 128 (16 bytes)
L6F87H:	CALL  L6FDBH    ; Read Cassette port data bit
	RC              ; Return if CTRL-BREAK pressed
	MOV   A,C       ; Get count of square wave period
	CPI   08H       ; Test if period less than 8
	JC    L6F85H    ; Read cassette header and sync byte
	CPI   40H       ; Test if period greater than 64
	JNC   L6F85H    ; Read cassette header and sync byte
	DCR   B         ; Decrement sync bit count
	JNZ   L6F87H    ; Loop for 128 bits (16 bytes)
L6F9AH:	CALL  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	RC              ; Return if SHIFT-BREAK pressed
	LXI   H,0000H  ; Set count of 0->1 and 0->0 transitions to zero
	MVI   B,40H     ; Load bit count to 64 (8 bytes)
L6FA3H:	CALL  L7016H    ; Read a bit (period in C)
	RC              ; Return if SHIFT-BREAK pressed
	MOV   D,C       ; Save bit period in D
	CALL  L7016H    ; Read next bit (period in C)
	RC              ; Return if SHIFT-BREAK pressed
	MOV   A,D       ; Get period of first bit
	SUB   C         ; Subtract period of 2nd bit
	JNC   L6FB3H    ; \
	CMA             ; > Create ABS(D-C)
	INR   A         ; /
L6FB3H:	CPI   0BH       ; Test for 0->1 or 1->0 bit transition
	JC    L6FBAH    ; Jump to increment 0->0 or 1->1 bit detection
	INR   H         ; Increment 0->1 or 1->0 bit transition count
	MVI   A,2CH     ; Make INR L below look like MVI A,2CH
	DCR   B         ; Decrement bit counter
	JNZ   L6FA3H    ; Jump to test next 2 bits
	MVI   A,40H     ; Prepare to test for 8 bytes of all zero or all FFh
	CMP   L         ; Do the compare
	JZ    L6FC9H    ; If 8 bytes of zeros found, jump to skip test for 55H
	SUB   H         ; Subtract count of 0->1 or 1->0 transition (55H bytes)
	JNZ   L6F9AH    ; If not equal number of zeros and 55H, go read more bits
L6FC9H:	STA   FF8EH     ; Cassette port pulse control
	MVI   D,00H     ; Clear out the packed byte
L6FCEH:	CALL  L6FDBH    ; Read Cassette port data bit
	RC              ; Return if SHIFT-BREAK pressed
	CALL  L7023H    ; Count and pack cassette input bits
	CPI   7FH       ; Test for 7FH sync trailer byte
	JNZ   L6FCEH    ; Jump to read next bit until 7FH found or SHIFT-BREAK
	RET             
	
	
; ======================================================
; Read Cassette port data bit
; ======================================================
L6FDBH:	MVI   C,00H     ; Set raw bit length to 0
	LDA   FF8EH     ; Cassette port pulse control
	ANA   A         ; Test pulse control for zero
	JZ    L6FFAH    
L6FE4H:	CALL  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	RC              ; Return if SHIFT-BREAK
	RIM             ; Read the cassette 0/1 raw bit
	RLC             ; Rotate bit into carry
	JNC   L6FE4H    ; Jump if SID is low to skip increment
L6FEDH:	INR   C         ; Increment SID high length
L6FEEH:	INR   C         ; Increment SID high length
	JZ    L6FE4H    ; Jump if C rolls over the test for CTRL-BREAK
	RIM             ; Read the cassette 0/1 raw bit
	RLC             ; Rotate SID bit into carry
	JC    L6FEEH    ; If SID still high, go increment C again
	JMP   L700DH    ; Jump to screech the speaker
	
L6FFAH:	CALL  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	RC              ; Return if SHIFT-BREAK
	RIM             ; Read the cassette 0/1 raw bit
	RLC             ; Rotate the SID bit into carry
	JC    L6FFAH    ; Jump if SID is high
L7003H:	INR   C         ; Increment SID low length
L7004H:	INR   C         ; Increment SID low length
	JZ    L6FFAH    ; Jump if C rolls over to check for CTRL-BREAK
	RIM             ; Read the cassette 0/1 raw bit
	RLC             ; Rotate SID into carry
	JNC   L7004H    ; Jump if SID still LOW to increment
L700DH:	LDA   FF44H     ; Sound flag
	ANA   A         ; Test if sound enabled
	CZ    L7676H    ; Click sound port
	XRA   A         ; Clear carry flag (no CTRL-BREAK pressed)
	RET             
	
L7016H:	CALL  L7003H    ; Jump to loop to wait for SID high crossing
	RC              ; Return if SHIFT-BREAK pressed
	MVI   C,00H     ; Set SID high count to zero
	CALL  L6FEDH    ; Jump to loop to measure SID high count
	RC              ; Return if SHIFT-BREAK pressed
	JMP   L7003H    ; Now measure the low period
	
	
; ======================================================
; Count and pack cassette input bits
; ======================================================
L7023H:	MOV   A,C       ; Get SID high period count
	CPI   15H       ; Test if 21 or more ('0' bit) to set carry
	MOV   A,D       ; Get current byte packing
	RAL             ; Rotate next bit from carry into the byte
	MOV   D,A       ; Save the byte being built back to D
	RET             
	
	
; ======================================================
; Read character from cassette w/o checksum
; ======================================================
L702AH:	CALL  L6FDBH    ; Read Cassette port data bit
	RC              ; Return if CTRL-BREAK pressed
	MOV   A,C       ; Get length of SID high period
	CPI   15H       ; Test if SID high 21 or more counts ('0' bit)
	JC    L702AH    ; Read character from cassette w/o checksum
	MVI   B,08H     ; Prepare to read 8 bits
L7036H:	CALL  L6FDBH    ; Read Cassette port data bit
	RC              ; Return if CTRL-BREAK pressed
	CALL  L7023H    ; Count and pack cassette input bits
	DCR   B         ; Decrement the bit count
	JNZ   L7036H    ; Jump to loop for all bits
	XRA   A         ; Clear carry (no CTRL-SHIFT pressed)
	RET             
	
	
; ======================================================
; Cassette REMOTE routine - turn motor on or off
; ======================================================
L7043H:	LDA   FF45H     ; Contents of port E8H
	ANI   F1H       
	INR   E         
	DCR   E         
	JZ    L704FH    
	ORI   08H       
L704FH:	OUT   E8H       
	STA   FF45H     ; Contents of port E8H
	RET             
	
	
; ======================================================
; Keyboard scanning management routine
; ======================================================
L7055H:	LXI   H,L71F4H  
	PUSH  H         
	LXI   H,FF8FH   
	DCR   M         
	RNZ             
	MVI   M,03H     
	
; ======================================================
; Key detection -- Determine which keys are pressed
; ======================================================
	LXI   H,FF99H   ; Keyboard scan column storage #1
	LXI   D,FFA2H   ; Keyboard scan column storage @2
	CALL  SCMODK    ; Scan BREAK),CAPS),NUM),CODE),GRAPH),CTRL),SHIFT & set bits in A
	CMA             
	CMP   M         
	MOV   M,A       
	CZ    L7101H    
	XRA   A         
	OUT   B9H       
	IN    E8H       
	INR   A         
	MVI   A,FFH     
	OUT   B9H       
	JZ    L71FDH    
	MVI   A,7FH     
	MVI   C,07H     
L7080H:	DCX   H         
	DCX   D         
	MOV   B,A       
	OUT   B9H       
	IN    E8H       
	CMA             
	CMP   M         
	MOV   M,A       
	JNZ   L7092H    
	LDAX  D         
	CMP   M         
	CNZ   L70C5H    
L7092H:	MVI   A,FFH     
	OUT   B9H       
	MOV   A,B       
	RRC             
	DCR   C         
	JP    L7080H    
	DCX   H         
	MVI   M,02H     
	LXI   H,FFA5H   
	DCR   M         
	JZ    L711AH    
	INR   M         
	RM              
	LDA   FFA7H     
	LHLD  FFA8H     ; Pointer to entry in 2nd Storage Buffer for key
	ANA   M         
	RZ              
	
; ======================================================
; Key repeat detection
; ======================================================
	LDA   FFAAH     ; Keyboard buffer count
	CPI   02H       
	RNC             
	LXI   H,FFA4H   ; Key repeat start delay counter
	DCR   M         
	RNZ             
	MVI   M,06H     
	MVI   A,01H     
	STA   FFF3H     
	JMP   L7122H    ; Key decoding
	
L70C5H:	PUSH  B         
	PUSH  H         
	PUSH  D         
	MOV   B,A       
	MVI   A,80H     
	MVI   E,07H     
L70CDH:	MOV   D,A       
	ANA   M         
	JZ    L70D6H    
	ANA   B         
	JZ    L70E2H    
L70D6H:	MOV   A,D       
	RRC             
	DCR   E         
	JP    L70CDH    
	POP   D         
L70DDH:	POP   H         
	MOV   A,M       
	STAX  D         
	POP   B         
	RET             
	
L70E2H:	LXI   H,FFA5H   
	INR   A         
	CMP   M         
	JNZ   L70EEH    
	POP   D         
	POP   H         
	POP   B         
	RET             
	
L70EEH:	MOV   M,A       
	MOV   A,C       
	RLC             
	RLC             
	RLC             
	ORA   E         
	INX   H         
	MOV   M,A       
	INX   H         
	MOV   M,D       
	POP   D         
	XCHG            
	SHLD  FFA8H     ; Pointer to entry in 2nd Storage Buffer for key
	XCHG            
	JMP   L70DDH    
	
L7101H:	LDAX  D         
	MOV   B,A       
	MOV   A,M       
	STAX  D         
	RLC             
	RNC             
	MOV   A,B       
	RLC             
	RC              
	XTHL            
	LXI   H,L71C4H  
	XTHL            
	MVI   B,00H     
	MOV   D,B       
	MOV   A,M       
	RRC             
	MVI   A,03H     
	RC              
	MVI   A,13H     
	RET             
	
L711AH:	DCX   H         
	MVI   M,54H     
	DCX   H         
	LDA   FFA2H     ; Keyboard scan column storage @2
	MOV   M,A       
	
; ======================================================
; Key decoding
; ======================================================
L7122H:	LDA   FFA6H     ; Key position storage
	MOV   C,A       
	LXI   D,L002CH  
	MOV   B,D       
	CPI   33H       
	JC    L7133H    
	LXI   H,FFA7H   
	MOV   M,B       
L7133H:	LDA   FFA3H     ; Shift key status storage
	RRC             
	PUSH  PSW       
	MOV   A,C       
	CMP   E         
	JC    L7184H    
	CPI   30H       
	JNC   L7148H    
	POP   PSW       
	PUSH  PSW       
	RRC             
	JC    L7184H    
L7148H:	LXI   H,L7CEFH  
	POP   PSW       
	JNC   L7152H    
	LXI   H,L7CDBH  
L7152H:	DAD   B         
	MOV   A,M       
	RLC             
	ORA   A         
	RAR             
	MOV   C,A       
	JNC   L71E4H    ; Keyboard buffer management - place subsequent key in buffer
	CPI   08H       
	JNC   L7180H    
	LDA   F650H     
	ANI   E0H       
	JNZ   L7180H    
	LHLD  F67AH     ; Current executing line number
	MOV   A,H       
	ANA   L         
	INR   A         
	JZ    L7180H    
	LXI   H,F630H   ; Function key status table (1 = on)
	DAD   B         
	MOV   A,M       
	ORA   A         
	JZ    L7180H    
	MOV   A,C       
	ORI   80H       
	JMP   L71D5H    ; Keyboard buffer management - place key in new buffer
	
L7180H:	DCR   B         
	JMP   L71E4H    ; Keyboard buffer management - place subsequent key in buffer
	
L7184H:	POP   PSW       
	JC    L7189H    
	MOV   E,B       
L7189H:	RRC             
	PUSH  PSW       
	JC    L720AH    ; Handle unshifted & non-CTRL key during key decoding
L718EH:	LXI   H,L7C49H  
	RRC             
	JC    L71B5H    
	LXI   H,L7CA1H  
	RRC             
	JC    L71B5H    
	RRC             
	JNC   L71AEH    
	LXI   H,L7BF1H  
	DAD   B         
	PUSH  D         
	MOV   D,A       
	CALL  L7233H    ; Handle NUM key during key decoding
	MOV   A,D       
	POP   D         
	JZ    L71B7H    
L71AEH:	RRC             
	CC    L722CH    ; Handle CAPS LOCK key during key decoding
	LXI   H,L7BF1H  
L71B5H:	DAD   D         
L71B6H:	DAD   B         
L71B7H:	POP   PSW       
	MOV   A,M       
	JNC   L71C2H    
	CPI   60H       
	RNC             
	ANI   3FH       
	JC    C8B7H     
L71C4H:	MOV   C,A       
	ANI   EFH       
	CPI   03H       
	JNZ   L71E4H    ; Keyboard buffer management - place subsequent key in buffer
	LDA   F650H     
	ANI   C0H       
	JNZ   L71E4H    ; Keyboard buffer management - place subsequent key in buffer
	MOV   A,C       
	
; ======================================================
; Keyboard buffer management - place key in new buffer
; ======================================================
L71D5H:	STA   FFEBH     ; Holds CTRL-C or CTRL-S until it is processed
	CPI   03H       
	RNZ             
	LXI   H,FFAAH   ; Keyboard buffer count
	MVI   M,01H     
	INX   H         
	JMP   L71F0H    
	
	
; ======================================================
; Keyboard buffer management - place subsequent key in buffer
; ======================================================
L71E4H:	LXI   H,FFAAH   ; Keyboard buffer count
	MOV   A,M       
	CPI   20H       
	RZ              
	INR   M         
	RLC             
	INX   H         
	MOV   E,A       
	DAD   D         
L71F0H:	MOV   M,C       
	INX   H         
	MOV   M,B       
	POP   PSW       
L71F4H:	MVI   A,09H     
	SIM             
	
; ======================================================
; Interrupt exit routine (pop all regs & RET)
; ======================================================
L71F7H:	POP   PSW       
L71F8H:	POP   B         
	POP   D         
	POP   H         
	EI              
	RET             
	
L71FDH:	LXI   H,FF90H   
	DCR   M         
	RNZ             
	LXI   H,FF91H   
	MVI   B,11H     
	JMP   L4F0AH    ; Zero B bytes at M
	
	
; ======================================================
; Handle unshifted & non-CTRL key during key decoding
; ======================================================
L720AH:	MOV   A,C       
	CPI   1AH       
	LXI   H,L7C1DH  
	JC    L71B6H    
	CPI   2CH       
	JC    L721DH    
	CPI   30H       
	JC    L7222H    ; Handle Arrow keys during key decoding
L721DH:	POP   PSW       
	PUSH  PSW       
	JMP   L718EH    
	
	
; ======================================================
; Handle Arrow keys during key decoding
; ======================================================
L7222H:	SUI   2CH       
	LXI   H,L7D2FH  
	MOV   C,A       
	DAD   B         
	JMP   L71B7H    
	
	
; ======================================================
; Handle CAPS LOCK key during key decoding
; ======================================================
L722CH:	MOV   A,C       
	CPI   1AH       
	RNC             
	MVI   E,2CH     
	RET             
	
	
; ======================================================
; Handle NUM key during key decoding
; ======================================================
L7233H:	MOV   A,M       
	MVI   E,06H     
	LXI   H,L7CF9H  
L7239H:	CMP   M         
	INX   H         
	RZ              
	INX   H         
	DCR   E         
	JP    L7239H    
	RET             
	
	
; ======================================================
; L7242H: Scan keyboard for a key. Return with or without 
;        one. (CTRL-BREAK ==> CTRL-C)
; Entry conditions: none
; Exit conditions:  A = Character, if any
;           Z Flag -- set if no key found
;                  -- reset if key found
;           Carry  -- set (character in code table below)
;                  -- reset (normal characther set code)
; When Carry is set (1), Register A will contain one of 
; the following:
;           Register A  Key pressed
;           ----------  -------------
;             0            F1
;             1            F2
;             2            F3
;             3            F4
;             4            F5
;             5            F6
;             6            F7
;             7            F8
;             8          LABEL
;             9          PRINT
;            10          SHIFT-PRINT
;            11          PASTE
; ======================================================
KYREAD:	CALL L765CH     ; Set interrupt to 1DH
	LDA  FFAAH      ; Keyboard buffer count
	ORA  A
	JZ   L726AH     ; Enable interrupts as normal
	LXI  H,FFACH
	MOV  A,M
	ADI  02H
	DCX  H
	MOV  A,M
	PUSH PSW
	DCX  H
	DCR  M
	MOV  A,M
	RLC
	MOV  C,A
	INX  H
	LXI  D,FFADH
L725E:	DCR  C
	JM   L7269
	LDAX D
	MOV  M,A
	INX  H
	INX  D
	JMP  L725E
L7269:	POP  PSW
	
; ======================================================
; Enable interrupts as normal
; ======================================================
L726AH:	PUSH  PSW       
	MVI   A,09H     
	SIM             
	POP   PSW       
	RET             
	
	
; ======================================================
; L7270H: Check keyboard queue for characters or BREAK
; Entry conditions: none
; Exit conditions:  Z flag set if queue empty,
;                   reset if keys pending
;       Carry -- Set when BREAK entered
;             -- Reset with any other key
; ======================================================
KEYX:	CALL BRKCHK     ; Check for break or wait (CTRL-S)
	JZ   L727E
	CPI  03H
	JNZ  L727E
	ORA  A
	STC
	RET
L727E:	LDA  FFAAH      ; Keyboard buffer count
	    ORA  A
    	RET
	
; ======================================================
; L7283H: Check for BREAK characters only (CTRL-C or -S)
; Entry conditions: none
; Exit conditions:  
;       Carry -- Set when BREAK or PAUSE entered
;             -- Reset if no BREAK characters
; ======================================================
; Check for break or wait (CTRL-S)
BRKCHK:	PUSH H
	LXI  H,FFEBH    ; Holds CTRL-C or CTRL-S until it is processed
	MOV  A,M        ; Test for pending CTRL-C or CTRL-S
	MVI  M,00H      ; Clear pending CTRL-C or CTRL-S
	POP  H
	ORA  A          ; Test if either was pending
	RP              ; Return if CTRL-C or CTRL-S pending
	PUSH H
	PUSH B
	LXI  H,F7CAH
	MOV  C,A
	MVI  B,00H
	DAD  B
	DAD  B
	DAD  B
	CALL L3FD2H     ; Trigger interrupt.  HL points to interrupt table
	POP  B
	POP  H
	XRA  A
	RET
	
; ======================================================
; L729FH: Check if SHIFT-BREAK is being pressed
; ======================================================
CHSHBR:	PUSH B
	IN   B9H
	MOV  C,A
	CALL SCMODK     ; Scan BREAK,CAPS,NUM,CODE,GRAPH,CTRL,SHIFT & set bits in A
	PUSH PSW
	MOV  A,C
	OUT  B9H
	POP  PSW
	POP  B
	ANI  81H
	RNZ
	STC
	RET
; Scan BREAK,CAPS,NUM,CODE,GRAPH,CTRL,SHIFT & set bits in A
SCMODK:	MVI  A,FFH
	OUT  B9H
	IN   BAH
	ANI  FEH
	MOV  B,A
	OUT  BAH
	IN   E8H
	PUSH PSW
	MOV  A,B
	INR  A
	OUT  BAH
	POP  PSW
	RET
	
	
; ======================================================
; Produce a tone of DE freq and B duration
; ======================================================
L72C5H:	DI              
	MOV   A,E       
	OUT   BCH       
	MOV   A,D       
	ORI   40H       
	OUT   BDH       
	MVI   A,C3H     
	OUT   B8H       
	IN    BAH       
	ANI   F8H       
	ORI   20H       
	OUT   BAH       
L72DAH:	CALL  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	JNC   L72E8H    
	MVI   A,03H     
	STA   FFEBH     ; Holds CTRL-C or CTRL-S until it is processed
	JMP   L72F9H    
	
L72E8H:	MVI   C,64H     
L72EAH:	PUSH  B         
	MVI   C,1EH     
	CALL  L7657H    ; Delay routine - decrement C until zero
	POP   B         
	DCR   C         
	JNZ   L72EAH    
	DCR   B         
	JNZ   L72DAH    
L72F9H:	IN    BAH       
	ORI   04H       
	OUT   BAH       
	CALL  L6E83H    
	EI              
	RET             
	
; ======================================================
; In the M100 this address is not called. It is used 
; however in the T102 rom.
; TODO: compare logic to that of the M100, it is
; a different routine all together.
; ======================================================
L7304H:	CALL  L35D9H    ; different from m100 to: 7328H
	PUSH  H         ; /
	LHLD  FC1AH     ; Start of FAC1 for integers
	LXI   D,VSSYS   ; Active system signature -- Warm vs Cold boot
	RST   3         ; Compare DE and HL
	XCHG            
	CC    L2791H    ; Get command byte to send to external I/O
	POP   H         
	RET             ; Point to next command byte
	
L7315H:	CALL  L6D7EH    ; Get a character from RS232 receive queue
	RC              ; Point to 3rd command byte
	CPI   7FH       ; Get 3rd command byte
	STC             
	CMC             ; Get MSB of RX data count
	RNZ             ; OR in LSB of RX data count
	MOV   B,A       ; Jump to pop all regs & EI if count=0
	LDA   VISTAT    ; RS232 parameter setting table
	CPI   3AH       
	MOV   A,B       ; Increment buffer pointer
	CMC             ; Decrement RX count
	RET             ; Jump to receive all data from external device
	
	INR   A         
	RET             
	
; ======================================================
; Copy clock chip regs to M
; ======================================================
L7329H:	ORI   AFH       
	PUSH  PSW       
	CALL  L765CH    ; Disable Background task & barcode interrupts
	MVI   A,03H     
	CNZ   L7383H    ; Set clock chip mode
	MVI   A,01H     
	CALL  L7383H    ; Set clock chip mode
	MVI   C,07H     
	CALL  L7657H    ; Delay routine - decrement C until zero
	MVI   B,0AH     
L7340H:	MVI   C,04H     
	MOV   D,M       
L7343H:	POP   PSW       
	PUSH  PSW       
	JZ    L7352H    ; Read next bit from Clock Chip
	IN    BBH       
	RAR             
	MOV   A,D       
	RAR             
	MOV   D,A       
	XRA   A         
	JMP   L735DH    
	
; ======================================================
; Read next bit from Clock Chip
; ======================================================
L7352H:	MOV   A,D       
	RRC             
	MOV   D,A       
	MVI   A,10H     
	RAR             
	RAR             
	RAR             
	RAR             
	OUT   B9H       
L735DH:	ORI   09H       
	OUT   B9H       
	ANI   F7H       
	OUT   B9H       
	DCR   C         
	JNZ   L7343H    
	MOV   A,D       
	RRC             
	RRC             
	RRC             
	RRC             
	ANI   0FH       
	MOV   M,A       
	INX   H         
	DCR   B         
	JNZ   L7340H    
	POP   PSW       
	MVI   A,02H     
	CZ    L7383H    ; Set clock chip mode
	XRA   A         
	CALL  L7383H    ; Set clock chip mode
	JMP   L743CH    
	
; ======================================================
; Set clock chip mode
; ======================================================
L7383H:	OUT   B9H       ; Write mode to clock chip (lower 3 bits)
	LDA   FF45H     ; Contents of port E8H
	ORI   04H       ; Set CLOCK bit
	OUT   E8H       ; Write CLOCK strobe high
	ANI   FBH       ; Clear CLOCK bit
	OUT   E8H       ; Write CLOCK strobe low
	RET             
	
; ======================================================
; Cursor BLINK - Continuation of RST 7.5 Background hook
; ======================================================
L7391H:	CALL  L765CH    ; Disable Background task & barcode interrupts
	LXI   H,L7055H  ; Load address of Keyboard scanning management routine
	PUSH  H         ; Push return address to stack
	LXI   H,FFF3H   ; Load pointer to cursor blink count-down
	DCR   M         ; Decrement the cursor blink count-down
	RNZ             ; Return (to Keyboard scanning) if not time to blink
	MVI   M,7DH     ; Re-initialize cursor blink counter
	DCX   H         ; Decrement to address of cursor blink on-off status
	MOV   A,M       ; Get current cursor blink blink on-off status
	ORA   A         ; Test if blink disabled
	JP    L73A6H    ; Jump to change blink state if not disabled
	RPO             ; Return if blink on-off status Parity is odd (0x80)
L73A6H:	XRI   01H       ; Toggle the cursor blink on-of state
	MOV   M,A       ; Update the new cursor blink state
	
; ======================================================
; Blink the cursor
; ======================================================
L73A9H:	PUSH  H         ; Save HL on stack
	LXI   H,FFECH   ; Cursor bit pattern storage
	MVI   D,00H     
	CALL  L74A2H    ; Byte Plot - Send bit pattern to LCD for character
	MVI   B,06H     ; Prepare to compliment 6 bytes of Cursor pixels
	DCX   H         ; HL now points to end of cursor bit pattern
L73B5H:	MOV   A,M       ; Get next byte of cursor pattern
	CMA             ; Compliment all bits in Cursor pattern
	MOV   M,A       ; Save it back
	DCX   H         ; Decrement to next col of cursor bits
	DCR   B         ; Decrement loop counter
	JNZ   L73B5H    ; Jump until count = 0
	INX   H         ; Increment to cursor bit storage again
	MVI   D,01H     
	CALL  L74A2H    ; Byte Plot - Send bit pattern to LCD for character
	POP   H         ; Restore HL
	RET             ; This will return to Keyscan routine for RST 7.5 hook from above
	
; ======================================================
; Turn off background task, blink & reinitialize cursor blink time
; ======================================================
L73C5H:	PUSH  H         ; Push registers to stack to preserve
	PUSH  D         
	PUSH  B         
	PUSH  PSW       
	CALL  L765CH    ; Disable Background task & barcode interrupts
	LXI   H,FFF2H   ; Load address of Cursor blink counter
	MOV   A,M       ; Load Cursor blink counter
	RRC             ; Test if time to blink
	CC    L73A9H    ; Blink the cursor
	MVI   M,80H     ; Initialize Cursor blink counter
	JMP   L71F4H    ; Set new interrupt mask and pop all regs & RET
	
; ======================================================
; Initialize Cursor Blink to start blinking
; ======================================================
L73D9H:	PUSH  PSW       ; Preserve PSW on stack
	PUSH  H         ; Preserve HL on stack
	CALL  L765CH    ; Disable Background task & barcode interrupts
	LXI   H,FFF2H   ; Load address of Cursor blink counter
	MOV   A,M       ; Get current Cursor blink flag
	ANI   7FH       ; Mask off upper bit
	MOV   M,A       ; Save new cursor blink flag
	INX   H         ; Point to LSB of cursor blink counter
	MVI   M,01H     ; Set blink count to 1 maybe
	MVI   A,09H     ; Load new interrupt mask value
	SIM             ; Set new interrupt mask
	POP   H         ; Restore HL
	POP   PSW       ; Restore PSW
	RET             
	
; ======================================================
; Character plotting level 7.  Plot character in C on LCD at (H,L)
; ======================================================
L73EEH:	CALL  L765CH    ; Disable Background task & barcode interrupts
	LXI   H,0000H  
	DAD   SP        
	SHLD  FFF8H     
	DCR   D         
	DCR   E         
	XCHG            
	SHLD  FFF4H     
	MOV   A,C       
	LXI   D,L7710H  
	SUI   20H       
	JZ    L7410H    
	INX   D         
	CPI   60H       
	JC    L7410H    
	LXI   D,L76B1H  
L7410H:	PUSH  PSW       
	MOV   L,A       
	MVI   H,00H     
	MOV   B,H       
	MOV   C,L       
	DAD   H         
	DAD   H         
	DAD   B         
	POP   PSW       
	PUSH  PSW       
	JC    L741FH    
	DAD   B         
L741FH:	DAD   D         
	POP   PSW       
	JNC   L7430H    
	LXI   D,FFECH   ; Cursor bit pattern storage
	PUSH  D         
	MVI   B,05H     
	CALL  L2542H    ; Move B bytes from M to (DE)
	XRA   A         
	STAX  D         
	POP   H         
L7430H:	MVI   D,01H     
	CALL  L74A2H    ; Byte Plot - Send bit pattern to LCD for character
L7435H:	XRA   A         
	STA   FFF9H     
	CALL  L752BH    ; Set the display top line to zero for all LCD controllers
L743CH:	MVI   A,09H     
	SIM             
	RET             
	
; ======================================================
; L7440H: Move Cursor to specified location.
; Entry conditions: D = column number (1-40)
;                   E = row number (1-8)
; Exit conditions:  None
; ======================================================
SETCUR:	CALL L765CH     ; Disable Background task & barcode interrupts
	DCR  D
	DCR  E
	XCHG
	SHLD FFF4H
	JMP  L743CH
	
	
; ======================================================
; L744CH: Turn on pixel at specified location.
; Entry conditions: D = x coordinate (0-239)
;                   E = y coordinate (0-63)
; Exit conditions:  None
; ======================================================
PLOT:
    DB  F6H         	; Opcode for ORI, together with the next byte (at 744Dh) forms 'ORI AF', which is the first instruction of PLOT.  
; ======================================================
; L744DH: Turn off pixel at specified location.
; Entry conditions: D = x coordinate (0-239)
;                   E = y coordinate (0-63)
; Exit conditions:  None
; ======================================================
UNPLOT:	XRA  A          ; first instruction of UNPLOT, called at 744Dh. When PLOT is called at 744Ch, this is the 'AF' operand for ORI AF
	PUSH PSW        ; Save PSET / PRESET entry marker
	CALL L765CH     ; Disable Background task & barcode interrupts
	PUSH D
	MVI  C,FEH
	MOV  A,D
L7456:	INR  C
	INR  C
	MOV  D,A
	SUI  32H
	JNC  L7456
	MVI  B,00H
	LXI  H,L7643H   ; 8155 PIO chip bit patterns for Lower LCD drivers
	MOV  A,E
	RAL
	RAL
	RAL
	JNC  L746D
	LXI  H,L764DH
L746D:	DAD  B
	MOV  B,A
	CALL L753BH
	MOV  A,B
	ANI  C0H
	ORA  D
	MOV  B,A
	MVI  E,01H
	LXI  H,FFECH    ; Cursor bit pattern storage
	CALL L74F5H
	POP  D
	MOV  D,B
	MOV  A,E
	ANI  07H
	ADD  A
	MOV  C,A
	MVI  B,00H
	LXI  H,L7643H   ; 8155 PIO chip bit patterns for Lower LCD drivers
	DAD  B
	POP  PSW
	MOV  A,M
	LXI  H,FFECH   	; Cursor bit pattern storage
	JNZ  L7497
	CMA
	ANA  M
    DB  06H         	; Opcode for MVI, together with the next byte (at 7497h) forms 'MVI B,B6H', which is the instruction at 7496h.  
L7497:	ORA  M          ; first instruction of L7497, called at 7497h. When execution reaches 7496h, this is the 'B6h' operand for MVI B,B6H
	MOV  M,A
	MOV  B,D
	MVI  E,01H
	CALL L74F6H
	JMP  L743CH
	
	
; ======================================================
; Byte Plot - Send bit pattern to LCD for character
; ======================================================
L74A2H:	PUSH  H         
	MVI   E,06H     
	LDA   FFF5H     
	CPI   08H       
	JZ    L74B7H    
	CPI   10H       
	JZ    L74B9H    
	CPI   21H       
	JNZ   L74BBH    
L74B7H:	DCR   E         
	DCR   E         
L74B9H:	DCR   E         
	DCR   E         
L74BBH:	MOV   C,A       
	ADD   C         
	ADD   C         
	MOV   C,A       
	MVI   B,00H     
	LDA   FFF4H     
	RAR             
	RAR             
	RAR             
	LXI   H,L75C9H  
	JC    L74D0H    
	LXI   H,L7551H  ; 8155 PIO chip bit patterns for Upper LCD drivers
L74D0H:	DAD   B         
	MOV   B,A       
	CALL  L753BH    ; Enable LCD driver(s) specified by (HL)
	SHLD  FFF6H     
	MOV   A,B       
	ORA   M         
	MOV   B,A       
	POP   H         
	DCR   D         
	CALL  L74F7H    
	INR   D         
	MVI   A,06H     
	SUB   E         
	RZ              
	MOV   E,A       
	PUSH  H         
	LHLD  FFF6H     
	INX   H         
	CALL  L753BH    ; Enable LCD driver(s) specified by (HL)
	POP   H         
	MOV   A,B       
	ANI   C0H       
	MOV   B,A       
	DCR   D         
    DB	DAH             ; Make "ORI AFH" below look like "JC AFF6H" for pass-thru
	
L74F5H:	ORI   AFH       
L74F7H:	PUSH  D         
	PUSH  PSW       
	MOV   A,B       
	CALL  L7548H    ; Wait for LCD driver to be available
	OUT   FEH       
	JZ    L7507H    
	CALL  L7548H    ; Wait for LCD driver to be available
	IN    FFH       
L7507H:	POP   PSW       
	JNZ   L751BH    ; Read E bytes to HL from LCD controller, managing LCD busy
L750BH:	IN    FEH       
	RAL             
	JC    L750BH    
	MOV   A,M       
	OUT   FFH       
	INX   H         
	DCR   E         
	JNZ   L750BH    
	POP   D         
	RET             
	
L751BH:	IN    FEH       ; Read LCD status
	RAL             ; Rotate busy bit into carry
	JC    L751BH    ; Loop until not busy
	IN    FFH       ; Read next byte from LCD controller
	MOV   M,A       ; Save byte at (HL)
	INX   H         ; Increment pointer
	DCR   E         ; Decrement counter
	JNZ   L751BH    ; Loop until count is zero
	POP   D         
	RET             
	
L752BH:	CALL  L7533H    ; Enable LCD drivers after short delay
	MVI   A,3EH     ; Load command to set top line = 0
	OUT   FEH       ; Send the command
	RET             
	
	
; ======================================================
; Enable LCD drivers after short delay
; ======================================================
L7533H:	MVI   C,03H     ; Prepare for a short delay
	CALL  L7657H    ; Delay routine - decrement C until zero
	LXI   H,L7641H  ; Point to LCD enable bits to enable all
L753BH:	MOV   A,M       ; Get Bit pattern for 8 drivers
	OUT   B9H       ; OUTput the bit pattern for 8 drivers
	INX   H         ; Increment to bit pattern for next 2 LCD drivers
	IN    BAH       ; Get current value of I/O port with 2 LCD drivers
	ANI   FCH       ; Mask off LCD driver bit positions
	ORA   M         ; OR in selected LCD driver enable bits
	OUT   BAH       ; OUTput selected LCD driver bits
	INX   H         ; Increment to next set of LCD driver enable bits
	RET             
	
	
; ======================================================
; Wait for LCD driver to be available
; ======================================================
L7548H:	PUSH  PSW       ; Save A on stack
L7549H:	IN    FEH       ; Read the LCD driver input port
	RAL             ; Rotate the busy bit into the C flag
	JC    L7549H    ; Jump to keep waiting until not busy
	POP   PSW       ; Restore A
	RET             
	
	
; ======================================================
; 8155 PIO chip bit patterns for LCD drivers
; ======================================================
L7551H:
    DB	01H,00H,00H,01H,00H,06H,01H,00H          
    DB	0CH,01H,00H,12H,01H,00H,18H,01H          
    DB	00H,1EH,01H,00H,24H,01H,00H,2AH          
    DB	01H,00H,30H,02H,00H,04H,02H,00H          
    DB	0AH,02H,00H,10H,02H,00H,16H,02H          
    DB	00H,1CH,02H,00H,22H,02H,00H,28H          
    DB	02H,00H,2EH,04H,00H,02H,04H,00H          
    DB	08H,04H,00H,0EH,04H,00H,14H,04H          
    DB	00H,1AH,04H,00H,20H,04H,00H,26H          
    DB	04H,00H,2CH,08H,00H,00H,08H,00H          
    DB	06H,08H,00H,0CH,08H,00H,12H,08H          
    DB	00H,18H,08H,00H,1EH,08H,00H,24H          
    DB	08H,00H,2AH,08H,00H,30H,10H,00H          
    DB	04H,10H,00H,0AH,10H,00H,10H,10H          
    DB	00H,16H,10H,00H,1CH,10H,00H,22H          
L75C9H:
    DB	20H,00H,00H,20H,00H,06H,20H,00H          
    DB	0CH,20H,00H,12H,20H,00H,18H,20H          
    DB	00H,1EH,20H,00H,24H,20H,00H,2AH          
    DB	20H,00H,30H,40H,00H,04H,40H,00H          
    DB	0AH,40H,00H,10H,40H,00H,16H,40H          
    DB	00H,1CH,40H,00H,22H,40H,00H,28H          
    DB	40H,00H,2EH,80H,00H,02H,80H,00H          
    DB	08H,80H,00H,0EH,80H,00H,14H,80H          
    DB	00H,1AH,80H,00H,20H,80H,00H,26H          
    DB	80H,00H,2CH,00H,01H,00H,00H,01H          
    DB	06H,00H,01H,0CH,00H,01H,12H,00H          
    DB	01H,18H,00H,01H,1EH,00H,01H,24H          
    DB	00H,01H,2AH,00H,01H,30H,00H,02H          
    DB	04H,00H,02H,0AH,00H,02H,10H,00H          
    DB	02H,16H,00H,02H,1CH,00H,02H,22H          
	
L7641H:	RST   7         ; Jump to RST 38H Vector entry of following byte
    DB	03H             
	
; ======================================================
; 8155 PIO chip bit patterns for LCD drivers
; ======================================================
L7643H:
    DB	01H,00H,02H,00H,04H,00H,08H,00H          
    DB	10H,00H,20H,00H,40H,00H,80H,00H          
    DB	00H,01H,00H,02H          
	
	
; ======================================================
; Delay routine - decrement C until zero
; ======================================================
L7657H:	DCR   C         ; Decrement C
	JNZ   L7657H    ; Delay routine - decrement C until zero
	RET             
	
	
; ======================================================
; Set interrupt to 1DH
; ======================================================
L765CH:	DI              ; Disalbe interrupts
	MVI   A,1DH     ; Load SIM mask to disable RST 5.5 & 7.5
	SIM             ; Set new interrupt mask (disable Background & barcode)
	EI              ; Re-enable interrupts
	RET             
	
	
; ======================================================
; Beep routine
; ======================================================
L7662H:	CALL  L765CH    ; Set interrupt to 1DH
	MVI   B,00H     
L7667H:	CALL  L7676H    ; Click sound port
	MVI   C,50H     
	CALL  L7657H    ; Delay routine - decrement C until zero
	DCR   B         
	JNZ   L7667H    
	JMP   L743CH    
	
	
; ======================================================
; Click sound port
; ======================================================
L7676H:	IN    BAH       ; Load current value of I/O port BAH
	XRI   20H       ; Toggle the speaker I/O bit
	OUT   BAH       ; Write new value to speaker to cause a "click"
	RET             
	
L767DH:	LDA   FFFBH     ; Flag if external DVI is present
	INR   A         ; Increment flag to test if present
	RET             
	
	
; ======================================================
; Check for optional external controller
; ======================================================
L7682H:	LXI   H,FFFBH   ; Pointer to bytes count received???
	IN    82H       ; Read DVI STATUS byte
	ANI   07H       ; Mask all but byte count???
	JZ    L768FH    ; Optional external controller driver
	MVI   M,00H     ; No bytes to read � indicate Zero bytes transferred???
	RET             
	
	
; ======================================================
; Optional external controller driver
; ======================================================
L768FH:	ORA   M         ; Test if we already initialized DVI
	RNZ             ; Return if already initialized
	MVI   M,FFH     ; Indicate DVI detected & initialized
L7693H:	MVI   A,C1H     ; Prepare to send 0xC1 to DVI port 83H
	OUT   83H       ; Send 0xC1 to DVI ort 83H
	IN    80H       ; Get response from DVI
	MVI   A,04H     ; Prepare to send 04H to DVI port 81H
	OUT   81H       ; Send 04H to DVI port 81H
	OUT   80H       ; Send 04H to DVI port 80H
	RET             
	
L76A0H:	CALL  L767DH    ; Get count of bytes received from DVI?
	STC             ; Indicate more bytes to process
	RNZ             ; Return if in the middle of a transfer to/from DVI
	MVI   A,03H     ; Load value of DVI CONTROl MAILBOX maybe??
	STA   FFFAH     ; Save in DVI MAILBOX SELECT area
	XRA   A         ; Zero A
	CALL  L76DEH    ; Send Zero to DVI CONTROL MAILBOX
	CALL  L76FBH    ; Read response byte from DVI
L76B1H:	RLC             ; Move upper 2 bits to lower
	RLC             
	ANI   03H       ; Keep only the upper 2 bits
	RET             
	
L76B6H:	MVI   A,03H     ; Load A with value to send to DVI Control port 81H
	STA   FFFAH     ; Save 03H as value to send to DVI Control port 81H
	LXI   H,L770BH  ; Load address of Byte sequence to sent to DVI (2, 1, 0, 0, 1)
	MVI   B,05H     ; Prepare to send 5 bytes
L76C0H:	MOV   A,M       ; Load next byte to send to DVI
	CALL  L76DEH    ; Send byte to DVI
	INX   H         ; Increment to next byte in ROM table to send to DVI
	DCR   B         ; Decrement byte counter
	JNZ   L76C0H    ; Loop until all bytes sent
	CALL  L76FBH    ; Get response from DVI
	ORA   A         ; Test if response is Zero
	STC             
	RNZ             ; Return if the response is not zero
	LXI   H,E000H   ; Point to RAM address to receive hook routine from DVI
L76D2H:	CALL  L76FBH    ; Read next byte from DVI
	MOV   M,A       ; Save next byte to RAM hook location
	INX   H         ; Increment to next RAM hook location
	DCR   B         ; Decrement byte counter
	JNZ   L76D2H    ; Jump to read next byte if until all bytes read
	JMP   E000H     
	
L76DEH:	PUSH  PSW       ; Save the PSW
L76DFH:	CALL  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	JC    L76F4H    ; Jump to exit loop if SHIFT-BREAK pressed
	IN    82H       ; Get DVI status byte
	RLC             ; Rotate DVI TX EMPTY bit (MSB) into C flag
	JNC   L76DFH    ; Jump if not ready to keep waiting
	LDA   FFFAH     ; Retrieve value to send to DVI port 81H
	OUT   81H       ; Send value in FFFAH (03H) to DVI port 81H
	POP   PSW       ; Pop byte to be sent to DVI from stack
	OUT   80H       ; Send next byte to DVI
	RET             
	
L76F4H:	POP   PSW       ; POP Write data from stack
L76F5H:	POP   PSW       
	CALL  L7693H    ; Re-initialize the DVI
	STC             ; Indicate SHIFT-BREAK pressed
	RET             
	
L76FBH:	CALL  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	JC    L76F5H    ; Jump to exit if SHIFT-BREAK being pressed
	IN    82H       ; Get DVI STATUS byte
	ANI   20H       ; Test if RX_FULL bit is set
	JZ    L76FBH    ; Jump to keep waiting for RX_FULL to be set
	IN    80H       ; Read data from DVI
	RET             ; Return
	
L770BH:
    DB	02H,01H,00H,00H,01H,00H          
	
	
; ======================================================
; LCD char generator shape table (20H-7FH
; ======================================================
    DB	00H,00H,00H,00H,00H,00H,00H,4FH          
    DB	00H,00H,00H,07H,00H,07H,00H,14H          
    DB	7FH,14H,7FH,14H,24H,2AH,7FH,2AH          
    DB	12H,23H,13H,08H,64H,62H,3AH,45H          
    DB	4AH,30H,28H,00H,04H,02H,01H,00H          
    DB	00H,1CH,22H,41H,00H,00H,41H,22H          
    DB	1CH,00H,22H,14H,7FH,14H,22H,08H          
    DB	08H,3EH,08H,08H,00H,80H,60H,00H          
    DB	00H,08H,08H,08H,08H,08H,00H,60H          
    DB	60H,00H,00H,40H,20H,10H,08H,04H          
    DB	3EH,51H,49H,45H,3EH,44H,42H,7FH          
    DB	40H,40H,62H,51H,51H,49H,46H,22H          
    DB	41H,49H,49H,36H,18H,14H,12H,7FH          
    DB	10H,47H,45H,45H,29H,11H,3CH,4AH          
    DB	49H,49H,30H,03H,01H,79H,05H,03H          
    DB	36H,49H,49H,49H,36H,06H,49H,49H          
    DB	29H,1EH,00H,00H,24H,00H,00H,00H          
    DB	80H,64H,00H,00H,08H,1CH,36H,63H          
    DB	41H,14H,14H,14H,14H,14H,41H,63H          
    DB	36H,1CH,08H,02H,01H,51H,09H,06H          
    DB	32H,49H,79H,41H,3EH,7CH,12H,11H          
    DB	12H,7CH,7FH,49H,49H,49H,36H,3EH          ; Different from M100
    DB	41H,41H,41H,22H,7FH,41H,41H,41H          ; Different from M100
    DB	3EH,7FH,49H,49H,49H,41H,7FH,09H          ; Different from M100
    DB	09H,09H,01H,3EH,41H,49H,49H,3AH          
    DB	7FH,08H,08H,08H,7FH,00H,41H,7FH          
    DB	41H,00H,30H,40H,41H,3FH,01H,7FH          
    DB	08H,14H,22H,41H,7FH,40H,40H,40H          
    DB	40H,7FH,02H,0CH,02H,7FH,7FH,06H          
    DB	08H,30H,7FH,3EH,41H,41H,41H,3EH          
    DB	7FH,09H,09H,09H,06H,3EH,41H,51H          
    DB	21H,5EH,7FH,09H,19H,29H,46H,26H          
    DB	49H,49H,49H,32H,01H,01H,7FH,01H          
    DB	01H,3FH,40H,40H,40H,3FH,0FH,30H          
    DB	40H,30H,0FH,7FH,20H,18H,20H,7FH          
    DB	63H,14H,08H,14H,63H,07H,08H,78H          
    DB	08H,07H,61H,51H,49H,45H,43H,00H          
    DB	7FH,41H,41H,00H,04H,08H,10H,20H          
    DB	40H,00H,41H,41H,7FH,00H,04H,02H          
    DB	01H,02H,04H,40H,40H,40H,40H,40H          
    DB	00H,01H,02H,04H,00H,20H,54H,54H          
    DB	54H,78H,7FH,28H,44H,44H,38H,38H          
    DB	44H,44H,44H,28H,38H,44H,44H,28H          
    DB	7FH,38H,54H,54H,54H,18H,08H,08H          
    DB	7EH,09H,0AH,18H,A4H,A4H,98H,7CH          
    DB	7FH,04H,04H,04H,78H,00H,44H,7DH          
    DB	40H,00H,40H,80H,84H,7DH,00H,00H          
    DB	7FH,10H,28H,44H,00H,41H,7FH,40H          
    DB	00H,7CH,04H,78H,04H,78H,7CH,08H          
    DB	04H,04H,78H,38H,44H,44H,44H,38H          
    DB	FCH,28H,44H,44H,38H,38H,44H,44H          ; Different from M100
    DB	28H,FCH,7CH,08H,04H,04H,08H,48H          ; Different from M100
    DB	54H,54H,54H,24H,04H,3FH,44H,44H          
    DB	20H,3CH,40H,40H,20H,7CH,1CH,20H          ; Different from M100
    DB	40H,20H,1CH,3CH,40H,38H,40H,3CH          
    DB	44H,28H,10H,28H,44H,1CH,A0H,A0H          
    DB	90H,7CH,44H,64H,54H,4CH,44H,00H          
    DB	08H,36H,41H,41H,00H,00H,77H,00H          
    DB	00H,41H,41H,36H,08H,00H,02H,01H          
    DB	02H,04H,02H,00H,00H,00H,00H,00H          
	
	
; ======================================================
; LCD char generator shape table (80H-FFH)
; ======================================================
    DB	66H,77H,49H,49H,77H,66H,FCH,86H          
    DB	D7H,EEH,FCH,00H,7FH,63H,14H,08H          
    DB	14H,00H,78H,76H,62H,4AH,0EH,00H          
    DB	EEH,44H,FFH,FFH,44H,EEH,0CH,4CH          
    DB	7FH,4CH,0CH,00H,7CH,56H,7FH,56H          
    DB	7CH,00H,7DH,77H,47H,77H,7FH,00H          
    DB	02H,7EH,02H,3EH,42H,00H,10H,20H          ; Different from M100
    DB	1CH,02H,02H,02H,54H,34H,1CH,16H          
    DB	15H,00H,41H,63H,55H,49H,63H,00H          
    DB	24H,12H,12H,24H,12H,00H,44H,44H          
    DB	5FH,44H,44H,00H,00H,40H,3EH,01H          
    DB	00H,00H,00H,08H,1CH,3EH,00H,00H          
    DB	98H,F4H,12H,12H,F4H,98H,F8H,94H          
    DB	12H,12H,94H,F8H,14H,22H,7FH,22H          
    DB	14H,00H,A0H,56H,3DH,56H,A0H,00H          
    DB	4CH,2AH,1DH,2AH,48H,00H,38H,28H          
    DB	39H,05H,03H,0FH,00H,16H,3DH,16H          
    DB	00H,00H,42H,25H,15H,28H,54H,22H          
    DB	04H,02H,3FH,02H,04H,00H,10H,20H          
    DB	7EH,20H,10H,00H,08H,08H,2AH,1CH          
    DB	08H,00H,08H,1CH,2AH,08H,08H,00H          
    DB	1CH,57H,61H,57H,1CH,00H,08H,14H          
    DB	22H,14H,08H,00H,1EH,22H,44H,22H          
    DB	1EH,00H,1CH,12H,71H,12H,1CH,00H          
    DB	00H,00H,02H,01H,00H,00H,20H,55H          ; Different from M100
    DB	56H,54H,78H,00H,38H,44H,C4H,44H          ; Different from M100
    DB	28H,00H,64H,7FH,45H,45H,20H,00H          ; Different from M100
    DB	00H,00H,01H,02H,00H,00H,FCH,40H          ; Different from M100
    DB	40H,3CH,40H,00H,00H,02H,05H,02H          ; Different from M100
    DB	00H,00H,04H,0CH,1CH,0CH,04H,00H          
    DB	00H,04H,7FH,04H,00H,00H,1AH,A5H          ; Different from M100
    DB	A5H,A5H,58H,00H,7FH,41H,65H,51H          ; Different from M100
    DB	7FH,00H,7FH,41H,5DH,49H,7FH,00H          
    DB	40H,2FH,10H,68H,44H,E2H,15H,3FH          ; Different from M100
    DB	10H,68H,44H,E2H,40H,2FH,10H,08H          ; Different from M100
    DB	D4H,B2H,06H,09H,7FH,01H,7FH,00H          ; Different from M100
    DB	29H,2AH,7CH,2AH,29H,00H,78H,15H          ; Different from M100
    DB	12H,15H,78H,00H,3CH,43H,42H,43H          ; Different from M100
    DB	3CH,00H,3EH,41H,40H,41H,3EH,00H          ; Different from M100
    DB	1CH,22H,7FH,22H,14H,00H,02H,01H          ; Different from M100
    DB	01H,02H,01H,00H,20H,55H,54H,55H          ; Different from M100
    DB	78H,00H,38H,45H,44H,45H,38H,00H          ; Different from M100
    DB	3CH,41H,40H,21H,7CH,00H,80H,7CH          ; Different from M100
    DB	4AH,4AH,34H,00H,71H,11H,67H,11H          ; Different from M100
    DB	71H,00H,38H,54H,56H,55H,18H,00H          
    DB	3CH,41H,42H,20H,7CH,00H,38H,55H          
    DB	56H,54H,18H,00H,00H,01H,00H,01H          ; Different from M100
    DB	00H,00H,88H,7EH,09H,09H,02H,00H          ; Different from M100
    DB	20H,56H,55H,56H,78H,00H,38H,56H          ; Different from M100
    DB	55H,56H,18H,00H,00H,4AH,79H,42H          ; Different from M100
    DB	00H,00H,38H,46H,45H,46H,38H,00H          ; Different from M100
    DB	38H,42H,41H,22H,78H,00H,00H,02H          ; Different from M100
    DB	01H,02H,00H,00H,38H,55H,54H,55H          ; Different from M100
    DB	18H,00H,00H,45H,7CH,41H,00H,00H          ; Different from M100
    DB	20H,54H,56H,55H,78H,00H,00H,48H          ; Different from M100
    DB	7AH,41H,00H,00H,30H,48H,4AH,49H          ; Different from M100
    DB	30H,00H,3CH,40H,42H,21H,7CH,00H          
    DB	00H,00H,7DH,00H,00H,00H,7AH,11H          ; Different from M100
    DB	09H,0AH,71H,00H,22H,55H,55H,56H          ; Different from M100
    DB	79H,00H,3AH,45H,45H,46H,39H,00H          ; Different from M100
    DB	7CH,12H,11H,7FH,49H,00H,24H,54H          ; Different from M100
    DB	78H,54H,58H,00H,78H,14H,13H,14H          ; Different from M100
    DB	78H,00H,20H,54H,55H,54H,78H,00H          ; Different from M100
    DB	3EH,51H,49H,45H,3EH,00H,38H,64H          ; Different from M100
    DB	54H,4CH,38H,00H,7EH,09H,11H,22H          ; Different from M100
    DB	7DH,00H,7CH,54H,56H,55H,44H,00H          ; Different from M100
    DB	70H,28H,26H,29H,70H,00H,00H,44H          ; Different from M100
    DB	7EH,45H,00H,00H,38H,44H,46H,45H          ; Different from M100
    DB	38H,00H,3CH,40H,42H,41H,3CH,00H          ; Different from M100
    DB	30H,48H,45H,40H,20H,00H,3CH,41H          ; Different from M100
    DB	42H,40H,3CH,00H,7CH,55H,56H,54H          
    DB	44H,00H,70H,29H,26H,28H,70H,00H          ; Different from M100
    DB	00H,00H,00H,00H,00H,00H,0FH,0FH          
    DB	0FH,00H,00H,00H,00H,00H,00H,0FH          
    DB	0FH,0FH,F0H,F0H,F0H,00H,00H,00H          
    DB	00H,00H,00H,F0H,F0H,F0H,0FH,0FH          
    DB	0FH,F0H,F0H,F0H,F0H,F0H,F0H,0FH          
    DB	0FH,0FH,0FH,0FH,0FH,0FH,0FH,0FH          
    DB	F0H,F0H,F0H,F0H,F0H,F0H,FFH,FFH          
    DB	FFH,00H,00H,00H,00H,00H,00H,FFH          
    DB	FFH,FFH,FFH,FFH,FFH,0FH,0FH,0FH          
    DB	0FH,0FH,0FH,FFH,FFH,FFH,FFH,FFH          
    DB	FFH,F0H,F0H,F0H,F0H,F0H,F0H,FFH          
    DB	FFH,FFH,FFH,FFH,FFH,FFH,FFH,FFH          
    DB	00H,00H,F8H,08H,08H,08H,08H,08H          
    DB	08H,08H,08H,08H,08H,08H,F8H,00H          
    DB	00H,00H,08H,08H,F8H,08H,08H,08H          
    DB	00H,00H,FFH,08H,08H,08H,00H,00H          
    DB	FFH,00H,00H,00H,00H,00H,0FH,08H          
    DB	08H,08H,08H,08H,0FH,00H,00H,00H          
    DB	08H,08H,0FH,08H,08H,08H,08H,08H          
    DB	FFH,00H,00H,00H,08H,08H,FFH,08H          
    DB	08H,08H,3FH,1FH,0FH,07H,03H,01H          
    DB	80H,C0H,E0H,F0H,F8H,FCH,01H,03H          
    DB	07H,0FH,1FH,3FH,FCH,F8H,F0H,E0H          
    DB	C0H,80H,55H,AAH,55H,AAH,55H,AAH          
	
	
; ======================================================
; Keyboard conversion matrix
; ======================================================
L7BF1H:
    DB	7AH,78H,63H,76H,62H,6EH,6DH,6CH          
    DB	61H,73H,64H,66H,67H,68H,6AH,6BH          
    DB	71H,77H,65H,72H,74H,79H,75H,69H          
    DB	6FH,70H,5BH,3BH,27H,2CH,2EH,2FH          
    DB	31H,32H,33H,34H,35H,36H,37H,38H          
    DB	39H,30H,2DH,3DH,5AH,58H,43H,56H          
    DB	42H,4EH,4DH,4CH,41H,53H,44H,46H          
    DB	47H,48H,4AH,4BH,51H,57H,45H,52H          
    DB	54H,59H,55H,49H,4FH,50H,5DH,3AH          
    DB	22H,3CH,3EH,3FH,21H,40H,23H,24H          
    DB	25H,5EH,26H,2AH,28H,29H,5FH,2BH          
L7C49H:
    DB	00H,83H,84H,00H,95H,96H,81H,9AH          
    DB	85H,8BH,00H,82H,00H,86H,00H,9BH          
    DB	93H,94H,8FH,89H,87H,90H,91H,8EH          
    DB	98H,80H,60H,92H,8CH,99H,97H,8AH          
    DB	88H,9CH,9DH,9EH,9FH,B4H,B0H,A3H          
    DB	7BH,7DH,5CH,8DH,E0H,EFH,FFH,00H          
    DB	00H,00H,F6H,F9H,EBH,ECH,EDH,EEH          
    DB	FDH,FBH,F4H,FAH,E7H,E8H,E9H,EAH          
    DB	FCH,FEH,F0H,F3H,F2H,F1H,7EH,F5H          
    DB	00H,F8H,F7H,00H,E1H,E2H,E3H,E4H          
    DB	E5H,E6H,00H,00H,00H,00H,7CH,00H          
L7CA1H:
    DB	A1H,D1H,BDH,CEH,CFH,CDH,BCH,CAH          ; Different from M100
    DB	C8H,A9H,BBH,A2H,00H,00H,CBH,C9H          ; Different from M100
    DB	B6H,D3H,C6H,00H,00H,00H,B8H,C7H          ; Different from M100
    DB	B7H,ACH,B5H,ADH,A0H,00H,D5H,AEH          ; Different from M100
    DB	C0H,00H,C1H,00H,00H,00H,C4H,C2H          
    DB	C3H,AFH,C5H,BEH,DFH,D0H,DEH,00H          ; Different from M100
    DB	00H,D6H,DDH,DAH,D8H,B9H,D7H,BFH          ; Different from M100
    DB	00H,00H,DBH,D9H,B1H,D2H,00H,AAH          ; Different from M100
    DB	BAH,ABH,B3H,00H,B2H,00H,A5H,00H          ; Different from M100
    DB	A4H,00H,D4H,DCH,CCH,00H,00H,00H          ; Different from M100
    DB	00H,00H,00H,00H,00H,A6H,A7H,A8H          ; Different from M100
L7CF9H:
    DB	6DH,30H,6AH,31H,6BH,32H,6CH,33H          
    DB	75H,34H,69H,35H,6FH,36H,01H,06H          
    DB	14H,02H,20H,7FH,09H,1BH,8BH,88H          
    DB	8AH,0DH,80H,81H,82H,83H,84H,85H          
    DB	86H,87H,1DH,1CH,1EH,1FH,20H,08H          
    DB	09H,1BH,8BH,88H,89H,0DH,80H,81H          
    DB	82H,83H,84H,85H,86H,87H,51H,52H          
    DB	57H,5AH          
	
	
; ======================================================
; Boot routine
; ======================================================
L7D33H:	LXI   SP,FCC0H  ; Different from M100: Start of Alt LCD character buffer
	DCR   A         ; Different from M100
	JNZ   L1BA8H    ; Different from M100
L7D3AH:	IN    D8H       ; Different from M100
	ANA   A         ; Different from M100
	JP    L7D3AH    ; Different from M100
	MVI   A,43H     ; Load configuration for PIO (A=OUT, B=OUT, C=IN, Stop Timer counter)
	OUT   B8H       ; Set PIO chip configuration
	MVI   A,ECH     ; PIO B configuration (RTS low, DTR low, SPKR=1, Serial=Modem, Keyscan col 9 enable)
	OUT   BAH       ; Set PIO chip port B configuration
	MVI   A,FFH     ; PIO A configuration (Used for Key scan, LCD data, etc.)
	OUT   B9H       ; Initialize PIO chip port A
	IN    E8H       ; Scan Keyboard to test for CTRL-BREAK (cold boot indicator)
	ANI   82H       ; Mask all but CTRL-BREAK keys
	MVI   A,EDH     ; Load code to disable key-scan col 9 (for CTRL-BREAK)
	OUT   BAH       ; Disable key-scan col 9
	JZ    L7DE7H    ; Cold boot routine
	LHLD  VSSYS     ; Active system signature -- Warm vs Cold boot
	LXI   D,8A4DH   ; Compare value to test if cold boot needed
	RST   3         ; Compare DE and HL
	JNZ   L7DE7H    ; Cold boot routine
	LDA   FAC1H     ; Load MSB of lowest known RAM address
	MOV   D,A       ; Save value of last physical RAM
	CALL  L7EE1H    ; Calculate physical RAM available
	CMP   D         ; Test if more or less RAM than last boot-up
	JNZ   L7DE7H    ; Cold boot routine
	CALL  VOPTRD    ; Call RAM routine to Detect Option ROM (copied to RAM by cold-boot)
	MVI   A,00H     ; Indicate no Option ROM detected
	JNZ   L7D75H    ; Jump if it's really true to skip DEC
	DCR   A         ; Indicate OptROM detected
L7D75H:	LXI   H,VOPTRF  ; Option ROM flag
	CMP   M         ; Test if option ROM added or removed
	JNZ   L7DE7H    ; Cold boot routine
	LHLD  VSPOPD    ; Load signature for Auto Poweroff
	XCHG            ; Put signature in DE
	LXI   H,0000H  ; Prepare to clear signature for Auto Poweroff
	SHLD  VSPOPD    ; Clear signature for Auto Poweroff
	LXI   H,9C0BH   ; Load comparison signature saved by Auto Poweroff
	RST   3         ; Compare DE and HL
	JNZ   L7DA8H    ; Jump if last power-off wasn't an auto power-off
	LHLD  FABEH     ; SP save area for power up/down
	SPHL            ; Restore the stack pointer from auto-power off location
	CALL  VPWONH    ; Call Boot-up Hook
	CALL  L7DD0H    ; Call to a "hidden" XRA in the boot routine
	LHLD  FFF8H     
	PUSH  H         
	CALL  L4601H    
	POP   H         
	MOV   A,H       
	ANA   A         
	JZ    L14EDH    ; Pop AF), BC), DE), HL from stack
	SPHL            
	JMP   L7435H    
	
L7DA8H:	LDA   F651H     ; In TEXT because of BASIC EDIT flag
	ANA   A         ; Test if power off during a BASIC edit session
	JZ    L7DBBH    ; Jump if we weren't in a BASIC edit session at power off
	CALL  L7DD0H    ; Call Boot-up sequence below, skipping IPL, BASIC NEW, etc.
	CALL  L5D53H    ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
	CALL  L4601H    
	JMP   L5FDDH    ; Main TEXT edit loop
	
L7DBBH:	LXI   H,FAAFH   ; Start of IPL filename
	SHLD  F62CH     ; Save as simulated "FKey text" to be entered
	LHLD  VTPRAM    ; BASIC string buffer pointer
	SPHL            ; Restore the SP
	CALL  VPWONH    ; Call Boot-up Hook
	CALL  L3F6DH    ; Initialize BASIC for new execution
	LXI   H,L5797H  ; Load address of the MENU program
	PUSH  H         ; And push it to the stack as a RET address
	ORI   AFH       ; Hidden entry .. make AFH below look like ORI AFH
	CALL  L6CE0H    ; Warm start reset entry
	XRA   A         
	STA   VPROFS    ; Power off exit condition switch
	LDA   FF43H     ; RS232 initialization status
	ANA   A         ; Test if RS232 was active at power-off
	RZ              ; Return if RS-232 was not active
	LXI   H,F65AH   ; RS232 auto linefeed switch
	RST   2         ; Get next non-white char from M
	CNC   L3457H    ; Increment HL and return
	JMP   L17E6H    ; Set RS232 parameters from string at M
	
	
; ======================================================
; Cold boot routine
; ======================================================
L7DE7H:	LXI   SP,F5E6H  ; Load the SP with Cold Boot location
	CALL  L7EE1H    ; Calculate physical RAM available
	MVI   B,90H     ; Prepare to copy 90H bytes of code to RAM
	LXI   D,VSSYS   ; Active system signature -- Warm vs Cold boot
	LXI   H,L035AH  ; Initialization image loaded to VSSYS
	CALL  L2542H    ; Move B bytes from M to (DE)
	CALL  L7EC6H    ; Initialize RST 38H RAM vector table
	MVI   A,0CH     ; Count value for 6-second background timer
	STA   F930H     ; Initialize 6-second background timer
	MVI   A,64H     ; Count value for 10 minute auto power-off timer
	STA   F931H     ; Initizliae auto power-down counter
	LXI   H,L5B46H  ; Point to Function key labels for BASIC
	CALL  STFNK     ; Set new function key table
	CALL  L6C93H    ; Copy BASIC Function key table to key definition area
	MVI   B,58H     
	LXI   D,L6BF1H  ; ROM programs catalog entries
	LXI   H,F962H   ; Start of RAM directory
	CALL  L3469H    ; Move B bytes from (DE) to M with increment
	MVI   B,D1H     ; Length of RAM directory (19 entries x 11 bytes)
	XRA   A         ; Prepare to zero out RAM directory
L7E1CH:	MOV   M,A       ; Zero out next byte of RAM directory
	INX   H         ; Increment to next RAM directory location
	DCR   B         ; Decrement counter
	JNZ   L7E1CH    ; Loop until all bytes zeroed
	MVI   M,FFH     
	CALL  VOPTRD    ; Detect Option ROM
	JNZ   L7E43H    
	DCR   A         
	STA   VOPTRF    ; Option ROM flag
	LXI   H,F9BAH   
	MVI   M,F0H     
	INX   H         
	INX   H         
	INX   H         
	LXI   D,FAA6H   
	MVI   B,06H     
	CALL  L3469H    ; Move B bytes from (DE) to M with increment
	MVI   M,20H     
	INX   H         
	MVI   M,00H     
L7E43H:	XRA   A         
	STA   F787H     
	STA   FCA7H     
	CALL  L1A96H    ; Erase current IPL program
	STA   F932H     
	MVI   A,3AH     ; Load ASCII ':'
	STA   F680H     ; End of statement marker
	LXI   H,FBD4H   
	SHLD  FBD9H     
	SHLD  VTPRAM    ; BASIC string buffer pointer
	SHLD  FB67H     ; File buffer area pointer
	MVI   A,01H     
	STA   FBB3H     
	CALL  L7F2BH    ; Adjust SP location based on CLEAR parameters
	CALL  L3F6DH    ; Initialize BASIC for new execution
	LHLD  FAC0H     ; Lowest RAM address used by system
	XRA   A         
	MOV   M,A       
	INX   H         
	SHLD  VBASPP    ; Start of BASIC program pointer
	SHLD  F99AH     ; BASIC program not saved pointer
	MOV   M,A       ; Initialize BASIC Program ... no program
	INX   H         
	MOV   M,A       ; Set MSB of BASIC program to NULL
	INX   H         
	SHLD  FBAEH     ; Start of DO files pointer
	SHLD  F9A5H     ; Start of Paste Buffer
	MVI   M,1AH     ; Initialize DO file area with EOF marker ... no files
	INX   H         
	SHLD  FBB0H     ; Start of CO files pointer
	SHLD  FBB2H     ; Start of variable data pointer
	LXI   H,F999H   
	SHLD  FA8CH     ; Mark Unsaved BASIC program as active program
	CALL  L20FFH    ; NEW statement
	CALL  L6CD6H    ; Re-initialize system without destroying files
	LXI   H,0000H  
	SHLD  F92DH     ; Year (ones)
	LXI   H,L7F01H  ; Initial clock chip register values
	CALL  L732AH    ; Update clock chip regs from M
	JMP   L5797H    ; MENU Program
	
	
; ======================================================
; Display TRS-80 Model number & Free bytes on LCD
; ======================================================
L7EA6H:	LXI   H,L7FA4H  ; TRS-80 model number string
	CALL  L27B1H    ; Print buffer at M until NULL or '"'
	
; ======================================================
; Display number of free bytes on LCD
; ======================================================
L7EACH:	LHLD  FBB2H     ; Start of variable data pointer
	XCHG            
	LHLD  VTPRAM    ; BASIC string buffer pointer
	MOV   A,L       ;
	SUB   E         ;
	MOV   L,A       ; Calculate difference between BASIC String
	MOV   A,H       ; buffer area and Start of Variable data
	SBB   D         ; area. This is the free space.
	MOV   H,A       ;
	LXI   B,FFF2H   ; Load value for (-14)
	DAD   B         ; Subtract 14 from reported Free space
	CALL  L39D4H    ; Print binary number in HL at current position
	LXI   H,L7F98H  ; MENU Text Strings
	JMP   L27B1H    ; Print buffer at M until NULL or '"'
	
	
; ======================================================
; Initialize RST 38H RAM vector table
; ======================================================
L7EC6H:	LXI   H,FADAH   ; Start of RST 38H vector table
	LXI   B,L1D02H  
	LXI   D,L7FF3H  
L7ECFH:	MOV   M,E       
	INX   H         
	MOV   M,D       
	INX   H         
	DCR   B         
	JNZ   L7ECFH    
	MVI   B,13H     
	LXI   D,L08DBH  ; Generate FC error
	DCR   C         
	JNZ   L7ECFH    
	RET             
	
	
; ======================================================
; Calculate physical RAM available
; ======================================================
L7EE1H:	LXI   H,C000H   ; Ram modules start at High memory (8K chunks)
L7EE4H:	MOV   A,M       ; Load current value at this address
	CMA             ; Compliment the value
	MOV   M,A       ; And write it back (non-destructive test)
	CMP   M         ; Compare if the value "took" (i.e. there's RAM there)
	CMA             ; Compliment data back to original value
	MOV   M,A       ; Save original value (in case there IS RAM there)
	MOV   A,H       ; Load MSB of current RAM bank to A
	JNZ   L7EF8H    ; Jump if no RAM present in this bank
	INR   L         ; Increment LSB of RAM (test 256 bytes per 8K)
	JNZ   L7EE4H    ; Jump to test next byte of this RAM
	SUI   20H       ; Decrement to next lower 8K memory range
	MOV   H,A       ; Save the new MSB of this 8K range
	JM    L7EE4H    ; Jump back to test if RAM in this memory range
L7EF8H:	MVI   L,00H     ; Clear LSB of lowest RAM address
	ADI   20H       ; Add 8K back to address (we over shot)
	MOV   H,A       ; Save MSB of lowest RAM address with RAM in it
	SHLD  FAC0H     ; Lowest RAM address used by system
	RET             
	
	
; ======================================================
; Initial clock chip register values
; ======================================================
L7F01H:
    DB	00H,00H,00H,00H,00H,00H,01H,00H          
    DB	00H,01H,CFH,9DH,CFH,DDH          
	
	CALL  L112EH    ; Evaluate expression at M-1
	JNZ   ERRSYN    ; Generate Syntax error
	CPI   10H       ; Test if setting MAXFILES to 16 or more
	JNC   L08DBH    ; Generate FC error
	SHLD  FB99H     ; Address of last variable assigned
	PUSH  PSW       
	CALL  L4E22H    ; CLOSE file if it is opened?
	POP   PSW       
	CALL  L7F2BH    ; Adjust SP location based on CLEAR parameters
	CALL  L3F2FH    ; Initialize BASIC Variables for new execution
	JMP   L0804H    ; Execute BASIC program
	
L7F2BH:	PUSH  PSW       
	LHLD  VHIMEM    ; HIMEM
	LXI   D,FEF5H   ; Load DE with -267
L7F32H:	DAD   D         
	DCR   A         
	JP    L7F32H    
	XCHG            
	LHLD  VTPRAM    ; BASIC string buffer pointer
	MOV   B,H       
	MOV   C,L       
	LHLD  FB67H     ; File buffer area pointer
	MOV   A,L       
	SUB   C         
	MOV   L,A       
	MOV   A,H       
	SBB   B         
	MOV   H,A       
	POP   PSW       
	PUSH  H         
	PUSH  PSW       
	LXI   B,L008CH  
	DAD   B         
	MOV   B,H       
	MOV   C,L       
	LHLD  FBB2H     ; Start of variable data pointer
	DAD   B         
	RST   3         ; Compare DE and HL
	JNC   L3F17H    ; Reinit BASIC stack and generate OM error
	POP   PSW       
	STA   FC82H     ; Maxfiles
	MOV   L,E       
	MOV   H,D       
	SHLD  FC83H     ; File number description table pointer
	DCX   H         
	DCX   H         
	SHLD  FB67H     ; File buffer area pointer
	POP   B         
	MOV   A,L       
	SUB   C         
	MOV   L,A       
	MOV   A,H       
	SBB   B         
	MOV   H,A       
	SHLD  VTPRAM    ; BASIC string buffer pointer
	DCX   H         
	DCX   H         
	POP   B         
	SPHL            
	PUSH  B         
	LDA   FC82H     ; Maxfiles
	MOV   L,A       
	INR   L         
	MVI   H,00H     
	DAD   H         
	DAD   D         
	XCHG            
	PUSH  D         
	LXI   B,L0109H  
L7F82H:	MOV   M,E       
	INX   H         
	MOV   M,D       
	INX   H         
	XCHG            
	MVI   M,00H     
	DAD   B         
	XCHG            
	DCR   A         
	JP    L7F82H    
	POP   H         
	LXI   B,L0009H  
	DAD   B         
	SHLD  FC87H     
	RET             
	
	
; ======================================================
; MENU Text Strings
; ======================================================
L7F98H:
    DB	"     Bytesfree",00H
L7FA4H:
    DB	"TRS-80Model100Software",0DH,0AH
    DB	"Copr.1983Microsoft",0DH,0AH,00H
	
	
; ======================================================
; RST 38H RAM vector driver routine
; ======================================================
L7FD6H:	XTHL            ; Get PC from stack to read vector byte
	PUSH  PSW       ; Save PSW
	MOV   A,M       ; Get the vector number
	STA   FAC9H     ; Offset of last RST 38H call
	POP   PSW       ; Restore PSW
	INX   H         ; Increment PC past vector byte
	XTHL            ; Save updated PC (on the stack)
	PUSH  H         ; Save HL
	PUSH  B         ; Save BC
	PUSH  PSW       ; Save PSW
	LXI   H,FADAH   ; Start of RST 38H vector table
	LDA   FAC9H     ; Offset of last RST 38H call
	MOV   C,A       ; Copy vector number to C
	MVI   B,00H     ; Zero out B to prepare for DAD
	DAD   B         ; Multiply vector * 2 to index into table
	MOV   A,M       ; Get LSB of vector address
	INX   H         ; Increment to MSB of vector address
	MOV   H,M       ; Get MSB of vector address
	MOV   L,A       ; Copy LSB of address to L
	POP   PSW       ; Restore PSW
	POP   B         ; Restore BC
	XTHL            ; Restore HL & "PUSH" return address of the RST vector
L7FF3H:	RET             ; Return (to the vector address from the table)
	
L7FF4H:	CALL  L35BAH    ; CDBL function
	JMP   L31B5H    ; Move FAC1 to FAC2
	
L7FFAH:	LXI   H,F684H   ; Different from M100
	MVI   M,2CH     ; Different from M100
	RET             ; Different from M100
