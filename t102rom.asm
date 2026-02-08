.cpu 8085

L0001H .const 00001H
L0002H .const 00002H
L0004H .const 00004H
L0005H .const 00005H
L0016H .const 00016H
L031AH .const 0031AH
L03EAH .const 003EAH
L03F6H .const 003F6H
L007FH .const 0007FH
L0405H .const 00405H
L0758H .const 00758H
L045BH .const 0045BH
L402BH .const 0402BH
L13F3H .const 013F3H
L0262H .const 00262H
L1998H .const 01998H
L09A0H .const 009A0H
L0A1DH .const 00A1DH
L0452H .const 00452H
L40B3H .const 040B3H
L0009H .const 00009H
L4D12H .const 04D12H
L0100H .const 00100H
L099DH .const 0099DH
L0CDEH .const 00CDEH
L02E2H .const 002E2H
L0310H .const 00310H
L02F8H .const 002F8H
L0304H .const 00304H
L0458H .const 00458H
L296DH .const 0296DH
L0040H .const 00040H
L02EEH .const 002EEH
L0080H .const 00080H
L6053H .const 06053H
L14AAH .const 014AAH
L0006H .const 00006H
L260EH .const 0260EH
L2653H .const 02653H
L6F32H .const 06F32H
L0007H .const 00007H
L0018H .const 00018H
L0208H .const 00208H
L0101H .const 00101H
L1B88H .const 01B88H
L1AB2H .const 01AB2H
L1CD2H .const 01CD2H
L1DE6H .const 01DE6H
L13AFH .const 013AFH
L2020H .const 02020H
L2241H .const 02241H
L444FH .const 0444FH
L4241H .const 04241H
L20B3H .const 020B3H
L2611H .const 02611H
L2656H .const 02656H
L0602H .const 00602H
L000EH .const 0000EH
L27CAH .const 027CAH
L000FH .const 0000FH
L29BBH .const 029BBH
L0008H .const 00008H
L0449H .const 00449H
L32C5H .const 032C5H
L00FFH .const 000FFH
L03F1H .const 003F1H
L0300H .const 00300H
L0106H .const 00106H
L03FBH .const 003FBH
L0011H .const 00011H
L00A0H .const 000A0H
L044CH .const 0044CH
L4790H .const 04790H
L000CH .const 0000CH
L0455H .const 00455H
L040CH .const 0040CH
L001EH .const 0001EH
L4388H .const 04388H
L43B3H .const 043B3H
L43B6H .const 043B6H
L43B2H .const 043B2H
L0140H .const 00140H
L5593H .const 05593H
L48BCH .const 048BCH
L48C2H .const 048C2H
L044FH .const 0044FH
L000BH .const 0000BH
L3F08H .const 03F08H
L495FH .const 0495FH
L4B07H .const 04B07H
L4A27H .const 04A27H
L4A81H .const 04A81H
L29B2H .const 029B2H
L03F5H .const 003F5H
L4CFCH .const 04CFCH
L0422H .const 00422H
L161CH .const 0161CH
L2440H .const 02440H
L558BH .const 0558BH
L5595H .const 05595H
L55FDH .const 055FDH
L5768H .const 05768H
L1FBFH .const 01FBFH
L5759H .const 05759H
L1C01H .const 01C01H
L0108H .const 00108H
L0003H .const 00003H
L5B3CH .const 05B3CH
L0010H .const 00010H
L5B3AH .const 05B3AH
L7845H .const 07845H
L7469H .const 07469H
L5F48H .const 05F48H
L6256H .const 06256H
L0013H .const 00013H
L00C8H .const 000C8H
L665BH .const 0665BH
L0178H .const 00178H
L6C2CH .const 06C2CH
L6DD2H .const 06DD2H
L6F2CH .const 06F2CH
L0249H .const 00249H
L1A0EH .const 01A0EH
L0427H .const 00427H
L0200H .const 00200H
L4349H .const 04349H
L6FBAH .const 06FBAH
L002CH .const 0002CH
L7CEFH .const 07CEFH
L7CDBH .const 07CDBH
L71C2H .const 071C2H
L7C1DH .const 07C1DH
L7D2FH .const 07D2FH
L2791H .const 02791H
L7710H .const 07710H
L764DH .const 0764DH
L74F6H .const 074F6H
L035AH .const 0035AH
L008CH .const 0008CH
L0109H .const 00109H
L732AH .const 0732AH
L7DD0H .const 07DD0H

MEMVARS :?= 0
.if MEMVARS == 0
MEMVARS = 1
.include	"memvar.inc"
.endif

    .org 0000H
; ======================================================
; Reset Vector
; ======================================================
        jmp  L1BA7H    ; Different from M100: Jump to boot routine
	
    .org 0003H
    .db  "MENU",00H
	
    .org 0008H
; ======================================================
; Compare next byte with M
; ======================================================
        mov  A,M        ; Get byte from (HL)
        xthl            ; Get address of next inst. from stack
        cmp  M          ; Compare with expected code byte
        jnz  ERRSYN     ; Generate Syntax error if no match
        inx  H          ; Increment past the compare byte
        xthl            ; Put new return address on stack
	
; Fall through to get next BASIC instruction. The code above is
; used to parse the validity of BASIC statements.
	
    .org 0010H
; ======================================================
; Get next non-white char from M
; ======================================================
        jmp  L0858H     ; RST 10H routine with pre-increment of HL

	
; ======================================================
; Load pointer to Storage of TEXT Line Starts in DE
; ======================================================
        xchg
        lhld VTXTLS      ; Storage of TEXT Line Starts
        xchg
	
	
    .org 0018H
; ======================================================
; Compare DE and HL
; ======================================================
        mov  A,H        ; Compare MSB first to test <>
        sub  D          ; Compare with D
        rnz             ; Return if not .equal
        mov  A,L        ; Prepare to test LSB
        sub  E          ; Compare with E
        ret
	
    .org 001EH
; ======================================================
; VRVIDFSend a space to screen/printer
; ======================================================
        mvi  A,20H      ; Load SPACE into A
	
	
    .org 0020H
; ======================================================
; Send character in A to screen/printer
; ======================================================
        jmp  LCD         ; Send A to screen or printer
        nop
	
	
    .org 0024H
; ======================================================
; Power down TRAP
; ======================================================
        jmp  VLPSIH      ; RAM vector for TRAP interrupt
        nop
	
	
    .org 0028H
; ======================================================
; Determine type of last var used
; ======================================================
        jmp  L1069H      ; RST 28H routine
        nop
	
	
    .org 002CH
; ======================================================
; RST 5.5 -- Bar Code Reader
; ======================================================
        di
        jmp  VBCRIH      ; RST 5.5 RAM Vector
	
    
    .org 0030H
; ======================================================
; Get sign of FAC1
; ======================================================
        jmp  L33DCH      ; RST 30H routine
        nop
	
    .org 0034H
; ======================================================
; RST 6.5 -- RS232 character pending
; ======================================================
        di
        jmp  L6DACH      ; RST 6.5 routine (RS232 receive interrupt)
	
	
    .org 0038H
; ======================================================
; RAM vector table driver
; ======================================================
        jmp  L7FD6H      ; RST 38H RAM vector driver routine
        nop
	
	
    .org 003CH
; ======================================================
; RST 7.5 -- Timer background task
; ======================================================
        di
        jmp  L1B32H      ; RST 7.5 interrupt routine
	
	
    .org 0040H
; ======================================================
; Function vector table for SGN to MID$
; ======================================================
    .dw  3407H,3654H,33F2H,2B4CH
    .dw  1100H,10C8H,10CEH,305AH
    .dw  313EH,2FCFH,30A4H,2EEFH
    .dw  2F09H,2F58H,2F71H,1284H
    .dw  1889H,506DH,506BH,3501H
    .dw  352AH,35BAH,3645H,2943H
    .dw  273AH,2A07H,294FH,295FH
    .dw  298EH,29ABH,29DCH,29E6H
	
    .org 0080H
; ======================================================
; BASIC statement keyword table END to NEW
; ======================================================
    .db  80H | 'E',"ND"        ; 0
    .db  80H | 'F',"OR"
    .db  80H | 'N',"EXT"
    .db  80H | 'D',"ATA"
    .db  80H | 'I',"NPUT"
    .db  80H | 'D',"IM"        ; 5
    .db  80H | 'R',"EAD"
    .db  80H | 'L',"ET"
    .db  80H | 'G',"OTO"
    .db  80H | 'R',"UN"
    .db  80H | 'I',"F"         ; 10
    .db  80H | 'R',"ESTORE"
    .db  80H | 'G',"OSUB"
    .db  80H | 'R',"ETURN"
    .db  80H | 'R',"EM"
    .db  80H | 'S',"TOP"       ; 15
    .db  80H | 'W',"IDTH"
    .db  80H | 'E',"LSE"
    .db  80H | 'L',"INE"
    .db  80H | 'E',"DIT"
    .db  80H | 'E',"RROR"      ; 20
    .db  80H | 'R',"ESUME"
    .db  80H | 'O',"UT"
    .db  80H | 'O',"N"
    .db  80H | 'D',"SKO$"
    .db  80H | 'O',"PEN"       ; 25
    .db  80H | 'C',"LOSE"
    .db  80H | 'L',"OAD"
    .db  80H | 'M',"ERGE"
    .db  80H | 'F',"ILES"
    .db  80H | 'S',"AVE"       ; 30
    .db  80H | 'L',"FILES"
    .db  80H | 'L',"PRINT"
    .db  80H | 'D',"EF"
    .db  80H | 'P',"OKE"
    .db  80H | 'P',"RINT"      ; 35
    .db  80H | 'C',"ONT"
    .db  80H | 'L',"IST"
    .db  80H | 'L',"LIST"
    .db  80H | 'C',"LEAR"
    .db  80H | 'C',"LOAD"      ; 40
    .db  80H | 'C',"SAVE"
    .db  80H | 'T',"IME$"
    .db  80H | 'D',"ATE$"
    .db  80H | 'D',"AY$"
    .db  80H | 'C',"OM"        ; 45
    .db  80H | 'M',"DM"
    .db  80H | 'K',"EY"
    .db  80H | 'C',"LS"
    .db  80H | 'B',"EEP"
    .db  80H | 'S',"OUND"      ; 50
    .db  80H | 'L',"COPY"
    .db  80H | 'P',"SET"
    .db  80H | 'P',"RESET"
    .db  80H | 'M',"OTOR"
    .db  80H | 'M',"AX"        ; 55
    .db  80H | 'P',"OWER"
    .db  80H | 'C',"ALL"
    .db  80H | 'M',"ENU"
    .db  80H | 'I',"PL"
    .db  80H | 'N',"AME"       ; 60
    .db  80H | 'K',"ILL"
    .db  80H | 'S',"CREEN"
    .db  80H | 'N',"EW"
	
    .org 018FH
; ======================================================
; Function keyword table TAB to <
; ======================================================
    .db  80H | 'T',"AB("
    .db  80H | 'T',"O"         ; 65
    .db  80H | 'U',"SING"
    .db  80H | 'V',"ARPTR"
    .db  80H | 'E',"RL"
    .db  80H | 'E',"RR"
    .db  80H | 'S',"TRING$"    ; 70
    .db  80H | 'I',"NSTR"
    .db  80H | 'D',"SKI$"
    .db  80H | 'I',"NKEY$"
    .db  80H | 'C',"SRLIN"
    .db  80H | 'O',"FF"        ; 75
    .db  80H | 'H',"IMEM"
    .db  80H | 'T',"HEN"
    .db  80H | 'N',"OT"
    .db  80H | 'S',"TEP"
    .db  80H | '+'             ; 80
    .db  80H | '-'
    .db  80H | '*'
    .db  80H | '/'
    .db  80H | '^'
    .db  80H | 'A',"ND"        ; 85
    .db  80H | 'O',"R"
    .db  80H | 'X',"OR"
    .db  80H | 'E',"QV"
    .db  80H | 'I',"MP"
    .db  80H | 'M',"OD"        ; 90
    .db  80H | '\\'
    .db  80H | '>'
    .db  80H | '='
    .db  80H | '<'
	
    .org 01F0H
; ======================================================
; Function keyword table SGN to MID$
; ======================================================
    .db  80H | 'S',"GN"        ; 95
    .db  80H | 'I',"NT"
    .db  80H | 'A',"BS"
    .db  80H | 'F',"RE"
    .db  80H | 'I',"NP"
    .db  80H | 'L',"POS"       ; 100
    .db  80H | 'P',"OS"
    .db  80H | 'S',"QR"
    .db  80H | 'R',"ND"
    .db  80H | 'L',"OG"
    .db  80H | 'E',"XP"        ; 105
    .db  80H | 'C',"OS"
    .db  80H | 'S',"IN"
    .db  80H | 'T',"AN"
    .db  80H | 'A',"TN"
    .db  80H | 'P',"EEK"       ; 110
    .db  80H | 'E',"OF"
    .db  80H | 'L',"OC"
    .db  80H | 'L',"OF"
    .db  80H | 'C',"INT"
    .db  80H | 'C',"SNG"       ; 115
    .db  80H | 'C',".dbL"
    .db  80H | 'F',"IX"
    .db  80H | 'L',"EN"
    .db  80H | 'S',"TR$"
    .db  80H | 'V',"AL"        ; 120
    .db  80H | 'A',"SC"
    .db  80H | 'C',"HR$"
    .db  80H | 'S',"PACE$"
    .db  80H | 'L',"EFT$"
    .db  80H | 'R',"IGHT$"     ; 125
    .db  80H | 'M',"ID$"
    .db  80H | "'"             ; 127
    .db  80H
	
    .org 0262H
; ======================================================
; BASIC statement vector table for END to NEW
; ======================================================
    .dw  409FH,0726H,4174H,099EH
    .dw  0CA3H,478BH,0CD9H,09C3H
    .dw  0936H,090FH,0B1AH,407FH
    .dw  091EH,0966H,09A0H,409AH
    .dw  1DC3H,09A0H,0C45H,5E51H
    .dw  0B0FH,0AB0H,110CH,0A2FH
    .dw  5071H,4CCBH,4E28H,4D70H
    .dw  4D71H,1F3AH,4DCFH,506FH
    .dw  0B4EH,0872H,128BH,0B56H
    .dw  40DAH,1140H,113BH,40F9H
    .dw  2377H,2280H,19ABH,19BDH
    .dw  19F1H,1A9EH,1A9EH,1BB8H
    .dw  4231H,4229H,1DC5H,1E5EH
    .dw  1C57H,1C66H,1DECH,7F0BH
    .dw  1419H,1DFAH,5797H,1A78H
    .dw  2037H,1F91H,1E22H,20FEH
	
    .org 02E2H
; ======================================================
; Operator order of precedence table
; ======================================================
    .db  079H, 079H, 07CH, 07CH
    .db  07FH, 050H, 046H, 03CH
    .db  032H, 028H, 07AH, 07BH
    .db  0BAH, 035H, 000H, 000H
	
    .org 02F2H
; ======================================================
; Vector table for math operations
; ======================================================
    .dw  3501H,35D9H
    .dw  352AH,2B78H,2B69H,2CFFH
    .dw  2DC7H,3D8EH,34FAH,37F4H
    .dw  37FDH,3803H,380EH,3D7FH
    .dw  3498H,3704H,36F8H,3725H
    .dw  0F0DH,3DF7H,34C2H
	
    .org 031CH
; ======================================================
; BASIC error message text
; ======================================================
    .db  "NF"
    .db  "SN"
    .db  "RG"
    .db  "OD"
    .db  "FC"
    .db  "OV"
    .db  "OM"
    .db  "UL"
    .db  "BS"
    .db  "DD"
    .db  "/0"
    .db  "ID"
    .db  "TM"
    .db  "OS"
    .db  "LS"
    .db  "ST"
    .db  "CN"
    .db  "IO"
    .db  "NR"
    .db  "RW"
    .db  "UE"
    .db  "MO"
    .db  "IE"
    .db  "BN"
    .db  "FF"
    .db  "AO"
    .db  "EF"
    .db  "NM"
    .db  "DS"
    .db  "FL"
    .db  "CF"
	
; ======================================================
; L035AH: Initialization image loaded to F5F0H
; ======================================================
    .db  04DH             ; LSB of COLD vs WARM boot marker (at address VSSYS)
    .db  08AH             ; MSB of COLD vs WARM boot marker
    .db  000H             ; Auto PowerDown signature LSB (at address VSPOPD)
    .db  000H             ; Auto PowerDown signature MSB
    .db  0F0H             ; LSB of HIMEM (VHIMEM)
    .db  0F5H             ; MSB of HIMEM
	ret             ; This RET can be changed to JMP to hook Boot-up (VPWONH)
	nop             ; Space for address for JMP
	nop 
	ei              ; This is the hook for WAND (VBCRIH) (RST 5.5)
	ret             ; Replace EI, RET, NOP with a JMP instruction
	nop 
	ret             ; This is the RST 6.5 routine (RS232 receive interrupt) hook (VUARTH)
	nop             ; Replace RET, NOP, NOP with a JMP instruction
	nop 
	ret             ; This is the RST 7.5 hook (Background tick)  (VTLINH)
	nop 
	nop 
	jmp   L1431H    ; Normal TRAP (low power) interrupt routine - Hook at VLPSIH
	
	
    .org 036FH
; ======================================================
; External ROM detect image loaded at F605H
; ======================================================
    .db  03EH,001H,0D3H,0E8H,021H,040H,000H,011H  ; F605H - MVI A,01H;  OUT 0E8H; LXI H,L0040H;  LXI D,VARETH
    .db  0A4H,0FAH,07EH,012H,023H,013H,07DH,0D6H  ; F60DH - MVI A,M;    STAX D;  INX H; INX D; MOV A,L; SUI 48H
    .db  048H,0C2H,00FH,0F6H,0D3H,0E8H,02AH,0A4H  ; F515H - JNZ F60FH;  OUT 0E8H; LHLD VARETH;   
    .db  0FAH,011H,041H,042H,0C3H,018H,000H,0F3H  ; F61DH - LXI D,L4142H; JMP 0018H;     DI;     ; Different from M100
    .db  03EH,001H,0D3H,0E8H,0C7H,000H,001H,000H  ; F625H - MVI A,01H;  OUT 0E8H; RST 0
    .db  000H,0FFH,0FFH,000H,000H,000H,000H,000H  ; 0F62DH \
    .db  000H,000H,000H,000H,001H,001H,008H,028H  ; F635H  \
    .db  000H,000H,000H,001H,001H,001H,001H,019H  ; F63DH   \
    .db  028H,000H,000H,000H,050H,038H,030H,000H  ; F645H    \
    .db  000H,000H,000H,000H,000H,000H,000H,000H  ; F64DH     \ Initialized Data space at F6XXH
    .db  000H,000H,064H,0FFH,000H,000H,04DH,037H  ; 0F655H    /
    .db  049H,031H,044H,0C3H,000H,000H,000H,0C9H  ; F65DH   /     ; Different from M100
    .db  000H,0C9H,0D3H,000H,0C9H,0DBH,000H,0C9H  ; 0F665H  /
    .db  03AH,000H,000H,000H,000H,000H,000H,000H  ; F66DH /
    .db  000H,00EH,000H,015H,0FDH,0FEH,0FFH,0B2H  ; F675H
    .db  0FCH,000H,000H
	
	
    .org 03EAH
; ======================================================
; BASIC message strings
; ======================================================
    .db  " Error",00H
    .db  " in ",00H
    .db  "Ok",0DH,0AH,00H
    .db  "Break",00H
	
	
; ======================================================
; L0401H: Pop return address for NEXT or RETURN
; ======================================================
POPRET lxi  H,L0004H   ; Prepare to point to BASIC token in stack
        dad  SP         ; Offset into stack
NXTLVL mov  A,M        ; Load BASIC token that caused the push (FOR or GOSUB)
        inx  H          ; Increment back in stack past token
        CPI  81H        ; Test for FOR token
        rnz             ; Return if not FOR token
        mov  C,M
        inx  H
        mov  B,M
        inx  H
        push H
        mov  H,B
        mov  L,C
        mov  A,D
        ora  E
        xchg
        jz   L0419
        xchg
        rst  3          ; Compare DE and HL
L0419  lxi  B,L0016H   ; TODO: find better name
        pop  H
        rz
        dad  B
        jmp  NXTLVL     ; Jump to test next level of FOR/GOSUB
	
; ======================================================
; L0422H: Initialize system and go to BASIC ready
; ======================================================
        lxi  B,L0501H   ; Pop stack and vector to BASIC ready
        jmp  L048DH     ; Restore stack & runtime and jump to BC
	
; ======================================================
; L0428H: Normal end of program reached
; ======================================================
ENDPRG lhld VBSCLN     ; Current executing line number
        mov  A,H        ; Get MSB of executing line number
        ana  L          ; AND LSB of executing line number
        inr  A          ; Test if executing line number is 0FFFFH
        jz   LNFFFF     ; Jump if executing line number is 0FFFFH
        lda  VBASRF     ; BASIC Program Running Flag
        ora  A          ; Test if program running
        mvi  E,13H      ; Load code for NR Error (No RESUME)
        jnz  L045DH     ; Generate error in E if program running
LNFFFF jmp  L40B6H     ; Branch into middle of "END" statement
	
; ======================================================
; L043DH: Never CALLed.  Maybe used by OptROMS?
; ======================================================
        jmp  L045DH     ; Generate error in E   TODO: find out if this is ever reached
	
; ======================================================
; L0440H: Generate SN error on DATA statement line
; ======================================================
GERRSN lhld 0FB94H     ; Line number of current data statement
        shld VBSCLN     ; Current executing line number
	
; ======================================================
; L0446H: Generate Syntax error
; ======================================================
ERRSYN mvi  E,02H      ; Load value for SN Error  TODO: examine this, it doesn't make sense
    .db  01H
        mvi  E,0BH      ; Load value for /0 Error
    .db  01H
        mvi  E,01H      ; Load value for NF Error
    .db  01H
        mvi  E,0AH      ; Load value for DD Error
    .db  01H
        mvi  E,14H      ; Load value for RW Error
    .db  01H
        mvi  E,06H      ; Load value for OV Error
    .db  01H
        mvi  E,16H      ; Load value for MO Error
    .db  01H
        mvi  E,0DH      ; Load value for TM Error 
	
; ======================================================
; Generate error in E
; ======================================================
L045DH	xra   A         
	sta   0FCA7H     
	lhld  0F67EH     
	mov   A,H       
	ora   L         
	jz    L0473H    
	lda   0FBE6H     
	mov   M,A       
	lxi   H,0000H  
	shld  0F67EH     
L0473H	ei              
	lhld  VLJERR    ; Load ON ERROR handler address (may be zero)
	push  H         ; Push ON ERROR handler address to stack
	mov   A,H       ; Get MSB of handler address
	ora   L         ; OR with LSB of handler address
	rnz             ; RETurn to handler if not zero
	lhld  VBSCLN    ; Current executing line number
	shld  0FB9FH     ; Line number of last error
	mov   A,H       ; Move LSB of address of line number to A
	ana   L         ; AND with MSB of address
	inr   A         ; Increment it test for 0FFFFH
	jz    L048AH    ; Skip saving as most recent line # if 0FFFFH
	shld  0FBA1H     ; Most recent used or entered line number
L048AH	lxi   B,L0493H  ; Load address of ERROR print routine in BC
	
; ======================================================
; Restore stack & runtime and jump to BC
; ======================================================
L048DH	lhld  0FB9DH     ; SP used by BASIC to reinitialize the stack
	jmp   L3F78H    ; Jump into BASIC initialize routine
	
; ======================================================
; Generate Error in E Print routine
; ======================================================
L0493H	pop   B         
	mov   A,E       
	mov   C,E       
	sta   0F672H     ; Last Error code
	lhld  VPCURL    ; Most recent or currently running line pointer
	shld  0FBA3H     ; Pointer to occurrence of error
	xchg            
	lhld  0FB9FH     ; Line number of last error
	mov   A,H       
	ana   L         
	inr   A         
	jz    L04B6H    
	shld  0FBAAH     ; Line where break, END, or STOP occurred
	xchg            
	shld  0FBACH     ; Address where program stopped on last break, END, or STOP
	lhld  0FBA5H     ; Address of ON ERROR routine
	mov   A,H       
	ora   L         
	xchg            
L04B6H	lxi   H,VBASRF  ; BASIC Program Running Flag
	jz    L04C5H    ; Print BASIC error message - XX error in XXX
	ana   M         
	jnz   L04C5H    ; Print BASIC error message - XX error in XXX
	dcr   M         
	xchg            
	jmp   L082BH    
	
; ======================================================
; Print BASIC error message - XX error in XXX
; ======================================================
L04C5H	xra   A         
	mov   M,A       
	mov   E,C       
	call  L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	mov   A,E       
	CPI   3BH       
	jnc   L04DBH    
	CPI   32H       
	jnc   L04DDH    
	CPI   17H       
	jc    L04E0H    
L04DBH	mvi   A,30H     
L04DDH	SUI   1BH       
	mov   E,A       
L04E0H	mvi   D,00H     
	lxi   H,L031AH  ; BASIC error message text
	dad   D         
	dad   D         
	mvi   A,3FH     
	rst   4         ; Send character in A to screen/printer
	mov   A,M       
	rst   4         ; Send character in A to screen/printer
	rst   2         ; Get next non-white char from M
	rst   4         ; Send character in A to screen/printer
	lxi   H,L03EAH  ; BASIC message strings
	push  H         
	lhld  0FB9FH     ; Line number of last error
	xthl            
L04F6H	call  L27B1H    ; Print buffer at M until NULL or '"'
	pop   H         
	mov   A,H       
	ana   L         
	inr   A         
	cnz   L39CCH    ; Finish printing BASIC ERROR message " in " line #
L0500H
    .db	3EH             ; Makes "POP B" below look like "MVI A,0C1H"
	
; ======================================================
; Pop stack and vector to BASIC ready
; ======================================================
L0501H	pop   B         ; Cleanup stack
	
; ======================================================
; Vector to BASIC ready - print Ok
; ======================================================
L0502H	call  ROTLCD    ; Reinitialize output back to LCD
	call  L4F45H    
	call  L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	lxi   H,L03F6H  ; Load pointer to "Ok" text
	call  L27B1H    ; Print buffer at M until NULL or '"'
	
; ======================================================
; Silent vector to BASIC ready
; ======================================================
L0511H	lxi   H,0FFFFH   ; Prepare to clear the BASIC executing line number
	shld  VBSCLN    ; Current executing line number
	lxi   H,0F66DH   
	shld  VPCURL    ; Most recent or currently running line pointer
	CALL  INLin     ; Input and display (no "?") line and store
	jc    L0511H    ; Silent vector to BASIC ready
	
; ======================================================
; Perform operation at M and return to ready
; ======================================================
	rst   2         ; Get next non-white char from M
	inr   A         ; Increment A to test if NULL
	dcr   A         ; Decrement A to test if NULL (why not just "ANA A"?)
	jz    L0511H    ; If at end of string, Silent vector to BASIC ready
	push  PSW       ; Save A & flags
	call  L08EBH    ; Check for line number - Convert ASCII number at M to binary
	jnc   L0536H    ; If last character received wasn't ASCII Digit, skip ahead
	call  L421AH    ; Test if address 0FC8CH is Zero. WHY???
	jz    ERRSYN    ; Generate Syntax error - Line Integer too big
L0536H	dcx   H         ; Rewind BASIC command pointer 1 byte
	mov   A,M       ; Get next byte from BASIC command
	CPI   20H       ; Test for SPACE
	jz    L0536H    ; Jump back to test previous byte
	CPI   09H       ; Test for TAB
	jz    L0536H    ; Jump back to test previous byte
	inx   H         ; Point to next byte from BASIC command line
	mov   A,M       ; Get next byte from BASIC command line
	CPI   20H       ; Test for SPACE
	cz    L3457H    ; If SPACE, increment HL and return. Never keep 1st SPACE
	push  D         
	call  L0646H    ; Perform Token compression
	pop   D         
	pop   PSW       
	shld  VPCURL    ; Most recent or currently running line pointer
	jnc   L4F1CH    
	push  D         
	push  B         
	xra   A         
	sta   0FB97H     
	rst   2         ; Get next non-white char from M
	ora   A         
	push  PSW       
	xchg            
	shld  0FBA1H     ; Most recent used or entered line number
	xchg            
	call  L0628H    ; Find line number in DE
	jc    L056FH    
	pop   PSW       
	push  PSW       
	jz    L094DH    ; Generate UL error
	ora   A         
L056FH	push  B         
	jnc   L0591H    
	call  L126CH    
	mov   A,C       
	sub   E         
	mov   C,A       
	mov   A,B       
	sbb   D         
	mov   B,A       
	lhld  VPSDOF    ; Start of DO files pointer
	dad   B         
	shld  VPSDOF    ; Start of DO files pointer
	lhld  VPSCOF    ; Start of CO files pointer
	dad   B         
	shld  VPSCOF    ; Start of CO files pointer
	lhld  VPRINP     
	dad   B         
	shld  VPRINP     
L0591H	pop   D         
	pop   PSW       
	push  D         
	jz    L05DAH    
	pop   D         
	lxi   H,0000H  
	shld  0FBA5H     ; Address of ON ERROR routine
	lhld  VPSVAR    ; Start of variable data pointer
	xthl            
	pop   B         
	push  H         
	dad   B         
	push  H         
	call  L3EF0H    ; Copy bytes from BC to HL with decriment until BC=DE
	pop   H         
	shld  VPSVAR    ; Start of variable data pointer
	xchg            
	mov   M,H       
	pop   B         
	pop   D         
	push  H         
	inx   H         
	inx   H         
	mov   M,E       
	inx   H         
	mov   M,D       
	inx   H         
	lxi   D,0F681H   ; Address of temp storage for tokenized line
	push  H         
	lhld  VPSDOF    ; Start of DO files pointer
	dad   B         
	shld  VPSDOF    ; Start of DO files pointer
	lhld  VPSCOF    ; Start of CO files pointer
	dad   B         
	shld  VPSCOF    ; Start of CO files pointer
	lhld  VPRINP     
	dad   B         
	shld  VPRINP     
	pop   H         
L05D2H	ldax  D         
	mov   M,A       
	inx   H         
	inx   D         
	ora   A         
	jnz   L05D2H    
L05DAH	pop   D         
	call  L05F4H    ; Update line addresses for BASIC program at (DE)
	lhld  0FC8CH     
	shld  0FBA8H     
	call  L3F28H    ; Initialize BASIC Variables for new execution
	lhld  0FBA8H     
	shld  0FC8CH     
	jmp   L0511H    ; Silent vector to BASIC ready
	
	
; ======================================================
; Update line addresses for current BASIC program
; ======================================================
L05F0H	lhld  VBASPP    ; Get Start of BASIC program pointer
	xchg            ; Put start of program in DE
	
; ======================================================
; Update line addresses for BASIC program at (DE)
; ======================================================
L05F4H	mov   H,D       ; Put address of current line in HL
	mov   L,E       
	mov   A,M       ; Get pointer to next line LSB
	inx   H         ; Increment to MSB
	ora   M         ; OR MSB of pointer to test for NULL
	rz              ; Return if at end of program
	inx   H         ; Increment to Line Number LSB
	inx   H         ; Increment to Line Number MSB
	inx   H         ; Increment to first byte of BASIC line
	xra   A         ; Clear A to test for end of line
L05FEH	cmp   M         ; Test for end of BASIC line
	inx   H         ; Increment to next byte of BASIC line
	jnz   L05FEH    ; Jump to test next byte of BASIC if not NULL
L0603H	xchg            ; DE=Address of next line, HL=start of current line
	mov   M,E       ; Save LSB of next line in current line pointer
	inx   H         ; Increment to MSB
	mov   M,D       ; Save MSB of next line in current line pointer
	jmp   L05F4H    ; Jump to update address of next line
	
	
; ======================================================
; Evaluate LIST statement arguments
; ======================================================
L060AH	lxi   D,0000H  
	push  D         
	jz    L061BH    
	pop   D         
	call  L08E0H    ; Evaluate line number text at M
	push  D         
	jz    L0624H    
	rst   1         ; Compare next byte with M
    .db	0D1H             ; Test for '-'
L061BH	lxi   D,0FFFAH   
	cnz   L08E0H    ; Evaluate line number text at M
	jnz   ERRSYN    ; Generate Syntax error
L0624H	xchg            
	pop   D         
L0626H	xthl            ; Preserve HL on stack
	push  H         ; PUSH return address back to stack
	
; ======================================================
; Find line number in DE
; ======================================================
L0628H	lhld  VBASPP    ; Start of BASIC program pointer
	
; ======================================================
; Find line number in DE starting at HL
; ======================================================
L062BH	mov   B,H       ; Save HL in BC
	mov   C,L       ; Save LSB too
	mov   A,M       ; Get LSB of pointer to next BASIC line
	inx   H         ; Increment to MSB
	ora   M         ; OR in MSB with LSB to test for 0000H
	dcx   H         ; Decrement back to LSB
	rz              ; Return if at end of BASIC program
	inx   H         ; Increment to MSB of pointer to next BASIC program
	inx   H         ; Increment to LSB of line number
	mov   A,M       ; Get LSB of line number
	inx   H         ; Increment to MSB of line number
	mov   H,M       ; Get MSB of line number
	mov   L,A       ; Move LSB of line number to HL for comparison
	rst   3         ; Compare DE and HL
	mov   H,B       ; Restore pointer to beginning of this BASIC line
	mov   L,C       ; Restore LSB of pointer too
	mov   A,M       ; Get LSB of next BASIC line number
	inx   H         ; Increment to MSB
	mov   H,M       ; Get MSB of next BASIC line number
	mov   L,A       ; Move LSB to HL
	cmc             ; Compliment C to indicate line found
	rz              ; Return if HL = DE. BC will have pointer to line
	cmc             ; Indicate line not found
	rnc             ; Return if beyond line number being sought
	jmp   L062BH    ; Find line number in DE starting at HL
	
	
; ======================================================
; Perform Token compression
; ======================================================
L0646H	xra   A         ; Prepare to zero out control vars
	sta   0FB66H     ; Zero out DATA statement found marker
	mov   C,A       ; Zero out line length
	lxi   D,0F681H   ; Pointer to temp storage space for tokenized line
L064EH	mov   A,M       ; Get next byte from input string
	CPI   20H       ; Compare with SPACE
	jz    L06EAH    ; Save token in A to (DE)
	mov   B,A       ; Save character to B
	CPI   22H       ; Compare with QUOTE
	jz    L070FH    ; Jump if QUOTE to copy bytes until QUOTE or EOL
	ora   A         ; Test for end of input string
	jz    L0716H    ; Exit tokenize loop if end of string
	inx   H         ; Increment to next byte in input string
	ora   A         ; Test for non-ASCII characters
	jm    L064EH    ; Skip byte if non-ASCII (CODE or GRAPH character)
	dcx   H         ; Decrement back to original byte in input string
	lda   0FB66H     ; Load marker if DATA statement active
	ora   A         ; Test if DATA statement active
	mov   A,M       ; Get next byte from input string
	jnz   L06EAH    ; Copy byte to output if DATA statement active
	CPI   3FH       ; Compare with '?'
	mvi   A,0A3H     ; Load token for PRINT (convert '?' to PRINT)
	jz    L06EAH    ; Save token in A to (DE)
	mov   A,M       ; Get next byte from input string
	CPI   30H       ; Compare with '0'
	jc    L067EH    ; Skip ahead if not '0-9'
	CPI   3CH       ; Compare with '<'
	jc    L06EAH    ; Jump to add digit to output if '0-9'
L067EH	push  D         ; Save output pointer on stack
	lxi   D,L007FH  ; Point to TOKEN table (-1)
	push  B         ; Save line length count on stack
	lxi   B,L06CDH  ; Load address of routine to ???
	push  B         ; Push address to stack
	mvi   B,7FH     ; Initialize token number counter
	mov   A,M       ; Get next byte from input string
	CPI   61H       ; Compare with 'a'
	jc    L0697H    ; Skip uppercase if not 'a-z'
	CPI   7BH       ; Compare with '{' ('z' + 1)
	jnc   L0697H    ; Skip uppercase if not 'a-z'
	ANI   5FH       ; Make uppercase
	mov   M,A       ; Save as uppercase
L0697H	mov   C,M       ; Get next byte (uppercase) from input string in C
	xchg            ; HL now has pointer to Token table
L0699H	inx   H         ; Increment to next byte in token table
	ora   M         ; Test if this is the 1st byte of a token
	jp    L0699H    ; Jump back to increment to next byte if not the 1st byte of token
	inr   B         ; Increment the token # counter
	mov   A,M       ; Get the next byte from the token table
	ANI   7FH       ; Mask off the 1st byte marker
	rz              ; Return to our tokenizer return hook if token not found
	cmp   C         ; Test if input string byte matches next byte from token table
	jnz   L0699H    ; Skip to next token in table if it doesn't match
	xchg            ; 1st Char of token found. Move token table ptr to DE and CMP the rest
	push  H         ; Save pointer to input string in case no match with this token
L06A9H	inx   D         ; Increment to next byte in token table
	ldax  D         ; Load the next byte from token table
	ora   A         ; Test for token 1st byte marker
	jm    L06C9H    ; Jump if 1st byte of next token found = match!
	mov   C,A       ; Save next byte from token table in C
	mov   A,B       ; Load the token counter
	CPI   88H       ; Test for GOTO token??
	jnz   L06B8H    ; Skip ahead if GOTO?
	rst   2         ; Get next non-white char from M
	dcx   H         ; Pre-decrement pointer to next byte from input string
L06B8H	inx   H         ; Increment to next byte from input string
	mov   A,M       ; Get next byte from input string
	CPI   61H       ; Test if byte >= 'a'
	jc    L06C1H    ; Skip uppercase if not >= 'a'
	ANI   5FH       ; Make uppercase
L06C1H	cmp   C         ; Compare byte from input string with next byte from token table
	jz    L06A9H    ; If it matches, jump back to test next byte for this token
	pop   H         ; Restore pointer to input string to test next token
	jmp   L0697H    ; Jump to test input against next token in table
	
L06C9H	mov   C,B       ; Save token number in C
	pop   PSW       ; POP saved pointer to input line
	xchg            ; Pre-XCHG DE and HL
	ret             ; This returns to our Tokenizer return hook
	
L06CDH	xchg            ; Exchange DE & HL so HL = input string, DE = token table pointer
	mov   A,C       ; Move TOKEN or next byte from input to A
	pop   B         ; Restore line length from stack
	pop   D         ; Restore output pointer from stack
	xchg            ; HL=output pointer, DE = input string
	CPI   91H       ; Test for ELSE token
	mvi   M,3AH     ; Insert a ":" before ELSE token
	jnz   L06DBH    ; Skip insertion if not ELSE token
	inr   C         ; It was ELSE token. Increment line length
	inx   H         ; And increment output pointer to keep the ':'
L06DBH	CPI   0FFH       ; Test for "'" token (Alternate REM)
	jnz   L06E9H    ; Skip ahead to add token to output if not "'" token
	mvi   M,3AH     ; Insert a ':REM' before the "'"
	inx   H         ; Increment to next output byte
	mvi   B,8EH     ; Load value for REM token
	mov   M,B       ; Save REM token to output
	inx   H         ; Increment to next output byte
	inr   C         ; Increment line length to account for added ':'
	inr   C         ; Increment line length to account for added REM token
L06E9H	xchg            ; HL=input line, DE = output pointer
L06EAH	inx   H         ; Increment to next input byte
	stax  D         ; Store this token to output (DE)
	inx   D         ; Increment output pointer
	inr   C         ; Increment line length counter
	SUI   3AH       ; Test for ':' token
	jz    L06F8H    ; Jump ahead if ':'
	CPI   49H       ; Test for DATA statement (I think?)
	jnz   L06FBH    ; Skip if not DATA statement
L06F8H	sta   0FB66H     ; Indicate DATA statement found
L06FBH	SUI   54H       ; Test for REM statement
	jz    L0705H    ; Jump ahead to save termination marker as NULL if REM
	SUI   71H       ; Test for 0FFH token
	jnz   L064EH    ; Jump if not 0FFH token
L0705H	mov   B,A       ; Save termination marker as NULL (end of string)
L0706H	mov   A,M       ; Get next byte from input string
	ora   A         ; Test for NULL termination
	jz    L0716H    ; Jump out of loop if end of string
	cmp   B         ; Compare with termination character (QUOTE or NULL)
	jz    L06EAH    ; Jump to Save token if termination char found (QUOTE or NULL)
L070FH	inx   H         ; Increment to next input byte
	stax  D         ; Save this character to (DE) output
	inr   C         ; Increment line length count
	inx   D         ; Increment output pointer
	jmp   L0706H    ; Jump to test next byte for termination marker (QUOTE or NULL)
	
L0716H	lxi   H,L0005H  ; Prepare to add 5 to line length for Address, Line # & termination
	mov   B,H       ; Zero MSB of BC
	dad   B         ; Add 5 to line length
	mov   B,H       ; Save MSB of line length in B
	mov   C,L       ; Save LSB of line length in C
	lxi   H,0F680H   ; End of statement marker
	stax  D         ; Store Zero to output - End of line marker
	inx   D         ; Increment output pointer
	stax  D         ; Store 2nd zero to output - NULL next BASIC line address LSB
	inx   D         ; Increment output pointer
	stax  D         ; Store 3rd zero to output - NULL next BASIC line address MSB
	ret             
	
	
; ======================================================
; FOR statement
; ======================================================
BSFOR	mvi   A,64H     
	sta   0FB96H     ; FOR/NEXT loop active flag
	call  BSLET     ; LET statement
	pop   B         ; Pop BASIC Loop "RET"urn address from stack
	push  H         ; Save pointer to FOR arguments on stack
	call  BSDATA    ; DATA statement
	shld  0FB92H     ; Save address of first statement in FOR loop
	lxi   H,L0002H  
	dad   SP        ; Get SP prior to our PUSH H above
L073AH	call  L0405H    
	jnz   L0758H    
	dad   B         
	push  D         
	dcx   H         
	mov   D,M       
	dcx   H         
	mov   E,M       
	inx   H         
	inx   H         
	push  H         
	lhld  0FB92H     ; Get address of 1st statement in FOR loop
	rst   3         ; Compare DE and HL
	pop   H         
	pop   D         
	jnz   L073AH    
	pop   D         
	sphl            
	shld  0FB9DH     ; SP used by BASIC to reinitialize the stack
	mvi   C,0D1H     ; Make POP D (0D1H) below look like MVI C,0D1H
	xchg            
	mvi   C,0CH     
	call  L3EFFH    ; Test for 24 byte free in stack space
	push  H         
	lhld  0FB92H     ; Get address of 1st statement in FOR loop
	xthl            
	push  H         
	lhld  VBSCLN    ; Current executing line number
	xthl            
	rst   1         ; Compare next byte with M
    .db	0C1H             ; Test for TO token ID
	
; ======================================================
; TO statement
; ======================================================
BSTO	rst   5         ; Determine type of last var used
	jz    L045BH    ; Generate TM error
	push  PSW       ; Save type of last var used
	call  BMEVAL    ; Main BASIC evaluation routine
	pop   PSW       ; Restore type of last var used
	push  H         
	jnc   L0791H    ; Jump if Double Precision
	jp    L07C8H    ; Jump if Single Precision
	call  BFCINT    ; CINT function
	xthl            
	lxi   D,L0001H  
	mov   A,M       
	
; ======================================================
; STEP statement
; ======================================================
BSSTEP	CPI   0CFH       
	cz    L1112H    ; Evaluate expression at M
	push  D         
	push  H         
	xchg            
	call  L341BH    
	jmp   L07EAH    
	
L0791H	call  BFC.dbL    ; C.dbL function
	pop   D         
	lxi   H,0FFF8H   
	dad   SP        
	sphl            
	push  D         
	call  L3487H    
	pop   H         
	mov   A,M       
	CPI   0CFH       
	lxi   D,L3286H  ; Load pointer to FP 1.000000000
	mvi   A,01H     
	jnz   L07B7H    
	rst   2         ; Get next non-white char from M
	call  BMEVAL    ; Main BASIC evaluation routine
	push  H         
	call  BFC.dbL    ; C.dbL function
	rst   6         ; Get sign of FAC1
	lxi   D,VVC1SD  ; Start of FAC1 for single and double precision
	pop   H         
L07B7H	mov   B,H       
	mov   C,L       
	lxi   H,0FFF8H   
	dad   SP        
	sphl            
	push  PSW       
	push  B         
	call  L3465H    
	pop   H         
	pop   PSW       
	jmp   L07F1H    
	
L07C8H	call  BFCSNG    ; CSNG function
	call  L343DH    ; Load single precision FAC1 to BCDE
	pop   H         
	push  B         
	push  D         
	lxi   B,L1041H  
	lxi   D,0000H  
	mov   A,M       
	CPI   0CFH       
	mvi   A,01H     
	jnz   L07EBH    
	call  L0DACH    
	push  H         
	call  BFCSNG    ; CSNG function
	call  L343DH    ; Load single precision FAC1 to BCDE
	rst   6         ; Get sign of FAC1
L07EAH	pop   H         
L07EBH	push  D         
	push  B         
	push  B         
	push  B         
	push  B         
	push  B         
L07F1H	ora   A         
	jnz   L07F7H    
	mvi   A,02H     
L07F7H	mov   C,A       
	rst   5         ; Determine type of last var used
	mov   B,A       
	push  B         
	push  H         
	lhld  0FB99H     ; Address of last variable assigned
	xthl            
L0800H	mvi   B,81H     
	push  B         
	inx   SP        
	
; ======================================================
; Execute BASIC program
; ======================================================
BASEXE	call  L6D6DH    ; Check RS232 queue for pending characters
	cnz   L4028H    ; Call routine to process ON COM interrupt
	lda   0F654H     ; Load pending interrupt (ON KEY/TIME/COM/MDM) count
	ora   A         ; Test for pending interrupts to process
	cnz   L402BH    ; Call routine to process ON KEY/TIME/COM/MDM interrupts
L0811H	call  L13F3H    ; Test for CTRL-C or CTRL-S during BASIC execute
	shld  VPCURL    ; Most recent or currenly running line pointer
	xchg            ; Store line pointer in DE
	lxi   H,0000H   ; Prepare to get Stack Pointer
	dad   SP        ; Get Stack Pointer prior to BASIC Inst. execution
	shld  0FB9DH     ; SP used by BASIC to reinitialize the stack
	xchg            ; Restore line pointer
	mov   A,M       ; Get next byte from executing BASIC line
	CPI   3AH       ; Test for ":" character - Don't update line number
	jz    L083AH    ; Start executing BASIC program at HL
	ora   A         ; Test for NULL byte separating BASIC instructions
	jnz   ERRSYN    ; Generate Syntax error
	inx   H         ; Point to "Next Line #" POINTER to test for end
L082BH	mov   A,M       ; Get LSB of "Next line #" POINTER
	inx   H         ; Point to MSB
	ora   M         ; Test if "Next line #" POINTER is zero - end of program
	jz    ENDPRG    ; Jump to terminate if end of BASIC program
	inx   H         ; Point to LSB of line NUMBER
	mov   E,M       ; Get LSB of Executing Line number
	inx   H         ; Point to MSB of line number
	mov   D,M       ; Get MSB of line number
	xchg            ; HL=Line #, DE=Pointer to line
	shld  VBSCLN    ; Current executing line number
	xchg            ; HL=pointer to line, DE=line #
	
; ======================================================
; Start executing BASIC program at HL
; ======================================================
L083AH	rst   2         ; Get next non-white char from M
	lxi   D,BASEXE  ; Address of routine to process next BASIC line
	push  D         ; Push it to the stack
L083FH	rz              ; Return to process next line if end of current line
	
; ======================================================
; Execute instruction in A), HL points to args
; ======================================================
L0840H	SUI   80H       ; Subtract 80 from instruction ID to make it zero based
	jc    BSLET     ; LET statement
	CPI   40H       ; Test instruction number for bounds
	jnc   L10F4H    ; Test if command to execute is 0FEH, generate SN error if not
	rlc             ; Multiply instruction x2 to get offset in address table
	mov   C,A       ; Move inst# x 2 into C for index into table
	mvi   B,00H     ; Clear MSB of command offset
	xchg            ; Save pointer to command parameters in DE
	lxi   H,L0262H  ; BASIC statement vector table for END to NEW
	dad   B         ; Index into command handler address table
	mov   C,M       ; Load LSB of command handler address
	inx   H         ; Point to MSB of command handler address
	mov   B,M       ; Load MSB of command handler address
	push  B         ; PUSH address of command handler to stack
	xchg            ; Restore pointer to command parameters from DE
	
; ======================================================
; Execute instruction in A), HL points to args
; ======================================================
L0858H	inx   H         ; Point to next byte of executing BASIC line
	
; ======================================================
; RST 10H routine
; ======================================================
	mov   A,M       ; Load next byte from command arguments
	CPI   3AH       ; Test for ":" command separator
	rnc             ; This can "RETurn" to the BASIC statement handler
	CPI   20H       ; Test for space after command
	jz    L0858H    ; RST 10H routine with pre-increment of HL
	CPI   0BH       
	jnc   L086CH    
	CPI   09H       ; Test for TAB
	jnc   L0858H    ; RST 10H routine with pre-increment of HL
L086CH	CPI   30H       ; Test for '0'
	cmc             
	inr   A         
	dcr   A         ; Test for zero in command arguments
	ret             ; "Return" to the command handler routine
	
	
; ======================================================
; DEF statement
; ======================================================
BSDEF	CPI   0E0H       ; Test for INT token ID
	jz    BSDINT    ; DEFINT statement
	CPI   44H       ; Test for 'D' character
	jnz   L088CH    ; Jump if not D to test for "SNG"
	rst   2         ; Get next non-white char from M
	rst   1         ; Compare next byte with M
    .db	42H             ; Test for 'B'
	rst   1         ; Compare next byte with M
    .db	4CH             ; Test for 'L'
	
; ======================================================
; DEF.dbL statement
; ======================================================
BSD.dbL	mvi   E,08H     ; Load variable type for Double precision
	jmp   L08A1H    ; Declare variable at M to be type E
	
	
; ======================================================
; DEFINT statement
; ======================================================
BSDINT	rst   2         ; Get next non-white char from M
	mvi   E,02H     ; Load variable type for Integer
	jmp   L08A1H    ; Declare variable at M to be type E
	
L088CH	rst   1         ; Compare next byte with M
    .db	53H             ; Test for 'S'
	CPI   4EH       ; Test for 'N'
	jnz   L089BH    ; Jump if not "SNG" to test for "STR"
	rst   2         ; Get next non-white char from M
	rst   1         ; Compare next byte with M
    .db	47H             ; Test for 'G'
	
; ======================================================
; DEFSNG statement
; ======================================================
BSDSNG	mvi   E,04H     ; Load variable type for Single Precision
	jmp   L08A1H    ; Declare variable at M to be type E
	
L089BH	rst   1         ; Compare next byte with M
    .db	54H             ; Test for 'T'
	rst   1         ; Compare next byte with M
    .db	52H             ; Test for 'R'
	
; ======================================================
; DEFSTR statement
; ======================================================
BSDSTR	mvi   E,03H     ; Load variable type for String var
	
; ======================================================
; Declare variable at M to be type E
; ======================================================
L08A1H	call  L40F1H    ; Check if M is alpha character
	lxi   B,ERRSYN  ; Address of Generate Syntax error
	push  B         ; Push address of Syntax Error to stack
	rc              ; Return to generate Syntax Error if not alpha
	SUI   41H       ; De-ASCII the variable
	mov   C,A       ; Save in C
	mov   B,A       ; Save in B (for range)
	rst   2         ; Get next non-white char from M
	CPI   0D1H       ; Test for '-' token ID
	jnz   L08BCH    ; Jump if not variable range ("A-D" syntax)
	rst   2         ; Get next non-white char from M
	call  L40F1H    ; Check if M is alpha character
	rc              ; Return to Syntax Error if not alpha
	SUI   41H       ; De-ASCII the variable
	mov   B,A       ; Save in B as a range
	rst   2         ; Get next non-white char from M
L08BCH	mov   A,B       ; Get High range in A
	sub   C         ; Subtract low range
	rc              ; Return if range is inverted
	inr   A         ; Increment range difference (count)
	xthl            ; Replace "Syntax Error" address with BASIC line pointer
	lxi   H,0FBBAH   ; DEF definition table
	mvi   B,00H     ; Zero out MSB of BC for index into table
	dad   B         ; Index into variable definition table
L08C7H	mov   M,E       ; Set type of the variable
	inx   H         ; Increment pointer to variable def table
	dcr   A         ; Decrement range count
	jnz   L08C7H    ; Jump to define all variables in range
	pop   H         ; Pop BASIC line pointer from stack
	mov   A,M       ; Get next line from BASIC
	CPI   2CH       ; Test for ','
	rnz             ; Return if no more variables to declare
	rst   2         ; Get next non-white char from M
	jmp   L08A1H    ; Declare variable at M to be type E
	
L08D6H	rst   2         ; Get next non-white char from M
L08D7H	call  L1113H    ; Evaluate expression at M-1
	rp              
	
; ======================================================
; Generate FC error
; ======================================================
L08DBH	mvi   E,05H     ; Load code for FC Error
	jmp   L045DH    ; Generate error in E
	
	
; ======================================================
; Evaluate line number text at M
; ======================================================
L08E0H	mov   A,M       ; Get next character from BASIC line
	CPI   2EH       
	xchg            
	lhld  0FBA1H     ; Most recent used or entered line number
	xchg            
	jz    L0858H    ; RST 10H routine with pre-increment of HL
	
; ======================================================
; Convert ASCII number at M to binary
; ======================================================
L08EBH	dcx   H         
	
; ======================================================
; Convert ASCII number at M+1 to binary
; ======================================================
L08ECH	lxi   D,0000H   ; Initialize value to zero
L08EFH	rst   2         ; Get next non-white char from M
	rnc             ; Return if not ASCII Digit '0-9'
	push  H         ; Save pointer to BASIC command line
	push  PSW       ; Save next byte from command line
	lxi   H,L1998H  ; Load value of 65520 / 10
	rst   3         ; Compare DE and HL
	jc    L090CH    ; Jump if line # would be too big
	mov   H,D       ; Move MSB of current value to H
	mov   L,E       ; Move LSB of current value to L
	dad   D         ; x2
	dad   H         ; x4
	dad   D         ; x5
	dad   H         ; x10
	pop   PSW       ; Restore A (next char) from stack
	SUI   30H       ; Convert from ASCII '0-9' to binary
	mov   E,A       ; Move to DE to perform 16-bit add
	mvi   D,00H     ; Clear MSB
	dad   D         ; Add to current value (in HL)
L0907H	xchg            ; Put current value back in DE
L0908H	pop   H         ; Restore pointer to BASIC command line
	jmp   L08EFH    ; Jump to read next character
	
L090CH	pop   PSW       ; POP next byte from BASIC command line
	pop   H         ; POP pointer to BASIC command line
	ret             
	
	
; ======================================================
; RUN statement
; ======================================================
BSRUN	jz    L3F28H    ; Initialize BASIC Variables for new execution
	jnc   BSRUN2    ; RUN statement
	call  L3F2CH    ; Initialize BASIC Variables for new execution
	lxi   B,BASEXE  
	jmp   L0935H    
	
	
; ======================================================
; GOSUB statement
; ======================================================
BSGSUB	mvi   C,03H     ; Prepare to test for 6 bytes stack space
	call  L3EFFH    ; Test if enough Stack space
	pop   B         ; POP BASIC exec loop return address from stack
	push  H         ; Save pointer to arguments to stack
	push  H         ; Make space on stack for current line number
	lhld  VBSCLN    ; Current executing line number
	xthl            ; Put line number containing GOSUB to stack
	lxi   B,0000H   ; Load a GOSUB control variable
	push  B         ; Push GOSUB control variable to stack
	lxi   B,BASEXE  ; Address of BASIC execution loop
	mvi   A,8CH     ; BASIC GOSUB token ID
	push  PSW       ; Push GOSUB ID to stack
	inx   SP        ; Don't keep flags on stack, only token ID
L0935H	push  B         ; Push BASIC execution loop return address to stack
	
; ======================================================
; GOTO statement
; ======================================================
BSGOTO	call  L08EBH    ; Convert ASCII number at M to binary
L0939H	call  L09A0H    ; REM statement
	inx   H         ; Increment to next statement to be executed
	push  H         ; Save address of next instruction on stack
	lhld  VBSCLN    ; Current executing line number
	rst   3         ; Compare DE and HL
	pop   H         ; Get address of next instruction from stack
	cc    L062BH    ; Find line number in DE starting at HL
	cnc   L0628H    ; Find line number in DE
	mov   H,B       ; Put new line number in HL
	mov   L,C       ; ...
	dcx   H         ; Test if line number found, plus pre-decrement
	rc              ; Return to BASIC execute loop if new line found
	
; ======================================================
; Generate UL error
; ======================================================
L094DH	mvi   E,08H     ; Load code for UL Error
	jmp   L045DH    ; Generate error in E
	
L0952H	push  H         ; Push line # to Stack
	push  H         ; Push again to preserve through XTHL
	lhld  VBSCLN    ; Current executing line number
	xthl            ; Put Current line number on Stack. HL=new line
	push  B         ; Preserve BC on Stack
	mvi   A,8CH     ; Load token for GOSUB
	push  PSW       ; Push GOSUB Token to Stack
	inx   SP        ; Remove flags from Stack. Keep only GOSUB token
	xchg            ; HL now has pointer to GOSUB line
	dcx   H         ; Decrement to save as currently running line pointer
	shld  VPCURL    ; Most recent or currenly running line pointer
	inx   H         ; Increment back to beginning of line
	jmp   L082BH    ; Jump into Execute BASIC program loop
	
	
; ======================================================
; RETURN statement
; ======================================================
BSRETN	rnz             
	mvi   D,0FFH     
	CALL  POPret    ; Pop return address for NEXT or RETURN
	CPI   8CH       ; Test for GOSUB token ID popped from stack
	jz    L0972H    
	dcx   H         
L0972H	sphl            ; Remove GOSUB return info from stack
	shld  0FB9DH     ; SP used by BASIC to reinitialize the stack
	mvi   E,03H     ; Load code for RG Error
	jnz   L045DH    ; Generate error in E
	pop   H         
	mov   A,H       
	ora   L         
	jz    L0987H    
	mov   A,M       
	ANI   01H       
	cnz   L3FC7H    
L0987H	pop   H         
	shld  VBSCLN    ; Current executing line number
	inx   H         
	mov   A,H       
	ora   L         
	jnz   L0998H    
	lda   0FB97H     
	ora   A         
	jnz   L0501H    ; Pop stack and vector to BASIC ready
L0998H	lxi   H,BASEXE  
	xthl            
	mvi   A,0E1H     
	
; ======================================================
; DATA statement
; ======================================================
BSDATA	lxi   B,L0E3AH  ; Using 0EH below, forms "LXI B,0E3AH"
	nop             
	mvi   B,00H     ; Zero out B. Termination tokens are NULL & C from above
L09A4H	mov   A,C       ; \ Swap termination token when a quote is
	mov   C,B       ; > detected. That way a ':' in the middle of
	mov   B,A       ; / a quoted DATA item doesn't terminate the search
L09A7H	mov   A,M       ; Get next byte to be ignored
	ora   A         ; Test for end of line
	rz              ; Return if end of line
	cmp   B         ; Test for termination token (NULL or ':')
	rz              ; Return if "ignore" termination found
	inx   H         ; Increment to next byte in BASIC line
	CPI   22H       ; Test for quote character in BASIC line
	jz    L09A4H    ; If quote, jump to swap termination tokens
	SUI   8AH       ; Test for IF token ID
	jnz   L09A7H    ; Jump if not IF to ignore next byte
	cmp   B         ; Compare with 0 or 3Eh
	adc   D         ; Add zero + carry to count
	mov   D,A       ; Save updated IF count
	jmp   L09A7H    ; Jump to continue ignoring bytes
	
L09BDH	pop   PSW       ; POP PSW that was left on stack
	Adi   03H       
	jmp   L09D6H    ; Jump into the LET statement
	
	
; ======================================================
; LET statement
; ======================================================
BSLET	call  L4790H    ; Find address of variable at M
	rst   1         ; Compare next byte with M
    .db	0DDH             ; Test for '='
	xchg            
	shld  0FB99H     ; Address of last variable assigned
	xchg            
	push  D         
	lda   0FB65H     ; Type of last variable used
	push  PSW       
	call  BMEVAL    ; Main BASIC evaluation routine
	pop   PSW       
L09D6H	xthl            
L09D7H	mov   B,A       
	lda   0FB65H     ; Type of last variable used
	cmp   B         
	mov   A,B       
	jz    L09E6H    
	call  L10D7H    
	lda   0FB65H     ; Type of last variable used
L09E6H	lxi   D,VVC1SD  ; Start of FAC1 for single and double precision
	CPI   02H       ; Test if last variable type was integer
	jnz   L09F1H    
	lxi   D,VFAC1I  ; Start of FAC1 for integers
L09F1H	push  H         
	CPI   03H       ; Test if last variable type was string
	jnz   L0A29H    
	lhld  VFAC1I    ; Start of FAC1 for integers
	push  H         
	inx   H         
	mov   E,M       
	inx   H         
	mov   D,M       
	lxi   H,0F683H   ; Different from M100
	rst   3         ; Compare DE and HL
	jc    L0A1DH    
	lhld  VPFREM    ; Unused memory pointer
	rst   3         ; Compare DE and HL
	pop   D         
	jnc   L0A25H    
	lxi   H,0FB88H   
	rst   3         ; Compare DE and HL
	jc    L0A1CH    
	lxi   H,0FB6AH   
	rst   3         ; Compare DE and HL
	jc    L0A25H    
L0A1CH	mvi   A,0D1H     
	call  L2935H    
	xchg            
	call  L2747H    
L0A25H	call  L2935H    
	xthl            
L0A29H	call  L3465H    
	pop   D         
	pop   H         
	ret             
	
	
; ======================================================
; ON statement
; ======================================================
BSON	CPI   94H       
	jnz   BSOKTC    ; ON KEY/TIME/COM/MDM GOSUB routine
	
; ======================================================
; ON ERROR statement
; ======================================================
BSONER	rst   2         ; Get next non-white char from M
	rst   1         ; Compare next byte with M
    .db	88H             ; Test for GOTO token ID
	call  L08EBH    ; Convert ASCII number at M to binary
	mov   A,D       
	ora   E         
	jz    L0A48H    
	call  L0626H    ; Find line number in DE (preserve HL on stack)
	mov   D,B       
	mov   E,C       
	pop   H         ; Restore HL from stack
	jnc   L094DH    ; Generate UL error
L0A48H	xchg            
	shld  0FBA5H     ; Address of ON ERROR routine
	xchg            
	rc              
	lda   VBASRF    ; BASIC Program Running Flag
	ora   A         
	mov   A,E       
	rz              
	lda   0F672H     ; Last Error code
	mov   E,A       
	jmp   L048AH    
	
	
; ======================================================
; ON KEY/TIME/COM/MDM GOSUB routine
; ======================================================
BSOKTC	call  L1AFCH    ; Determine device (KEY/TIME/COM/MDM) for ON GOSUB
	jc    BONTIH    ; ON TIME$ handler
	push  B         ; Save device code to stack
	rst   2         ; Get next non-white char from M
	rst   1         ; Compare next byte with M
    .db	8CH             ; GOSUB token (or generate SN error)
	xra   A         ; Clear A
L0A66H	pop   B         ; Get device code from stack
	push  B         ; Push it back on the stach
	cmp   C         ; Compare device count with A
	jnc   ERRSYN    ; Generate Syntax error
	push  PSW       ; Save device count on stack
	call  L08EBH    ; Convert ASCII number at M to binary
	mov   A,D       ; Prepare to test for line# 0
	ora   E         ; Test for line# 0
	jz    L0A7EH    ; Skip finding line# if it is 0
	call  L0626H    ; Find line number in DE (preserve HL on stack)
	mov   D,B       ; Save MSB of line number address to D
	mov   E,C       ; Save LSB of line number address
	pop   H         ; Restore HL from stack
	jnc   L094DH    ; Generate UL error
L0A7EH	pop   PSW       ; Restore device count from stack
	pop   B         ; Restore device code from stack
	push  PSW       ; Push device count to stack
	add   B         ; Calculate device number being accessed (1-10)
	push  B         ; Save device code to stack
	call  L1B22H    ; ON COM handler
	dcx   H         ; Decrement BASIC line pointer to test for EOL
	rst   2         ; Get next non-white char from M
	pop   B         ; Restore device code from stack
	pop   D         ; POP device count (&flags) into DE so we don't clobber flags
	rz              ; Return if at end of BASIC line
	push  B         ; Save device code to stack
	push  D         ; Save device count to stack
	rst   1         ; Compare next byte with M
    .db	2CH             ; ',' - Separator for ON GOSUB x,y,z
	pop   PSW       ; Restore device count from stack
	inr   A         ; Increment to next device number (for ON KEY GOSUB)
	jmp   L0A66H    ; Jump to process next ON KEY GOSUB entry
	
	
; ======================================================
; ON TIME$ handler
; ======================================================
BONTIH	call  L112EH    ; Evaluate expression at M-1
	mov   A,M       
	mov   B,A       
	CPI   8CH       
	jz    L0AA1H    
	rst   1         ; Compare next byte with M
    .db	88H             ; Test for GOTO token ID
	dcx   H         
L0AA1H	mov   C,E       
L0AA2H	dcr   C         
	mov   A,B       
	jz    L0840H    ; Execute instruction in A), HL points to args
	call  L08ECH    ; Convert ASCII number at M+1 to binary
	CPI   2CH       
	rnz             
	jmp   L0AA2H    
	
	
; ======================================================
; RESUME statement
; ======================================================
BSRESU	lda   VBASRF    ; BASIC Program Running Flag
	ora   A         
	jnz   L0AC0H    
	sta   0FBA5H     ; Address of ON ERROR routine
	sta   0FBA6H     
	jmp   L0452H    ; Generate RW error
	
L0AC0H	inr   A         
	sta   0F672H     ; Last Error code
	mov   A,M       
	CPI   82H       
	jz    L0ADBH    
	call  L08EBH    ; Convert ASCII number at M to binary
	rnz             
	mov   A,D       
	ora   E         
	jz    L0AE0H    
	call  L0939H    
	xra   A         
	sta   VBASRF     ; BASIC Program Running Flag
	ret             
	
L0ADBH	rst   2         ; Get next non-white char from M
	rnz             
	jmp   L0AE5H    
	
L0AE0H	xra   A         
	sta   VBASRF     ; BASIC Program Running Flag
	inr   A         
L0AE5H	lhld  0FBA3H     ; Pointer to occurance of error
	xchg            
	lhld  0FB9FH     ; Line number of last error
	shld  VBSCLN     ; Current executing line number
	xchg            
	rnz             
	mov   A,M       
	ora   A         
	jnz   L0AFAH    
	inx   H         
	inx   H         
	inx   H         
	inx   H         
L0AFAH	inx   H         
	mov   A,D       
	ana   E         
	inr   A         
	jnz   L0B08H    
	lda   0FB97H     
	dcr   A         
	jz    L40B3H    
L0B08H	xra   A         
	sta   VBASRF     ; BASIC Program Running Flag
	jmp   BSDATA    ; DATA statement
	
	
; ======================================================
; ERROR statement
; ======================================================
BSERRO	call  L112EH    ; Evaluate expression at M-1
	rnz             
	ora   A         
	jz    L08DBH    ; Generate FC error
	jmp   L045DH    ; Generate error in E
	
	
; ======================================================
; IF statement
; ======================================================
BSIF	call  BMEVAL    ; Main BASIC evaluation routine
	mov   A,M       
	CPI   2CH       
	cz    L0858H    ; RST 10H routine with pre-increment of HL
	CPI   88H       
	jz    L0B2BH    
	rst   1         ; Compare next byte with M
    .db	0CDH             ; Test for THEN token ID
	dcx   H         
L0B2BH	push  H         
	call  L3411H    ; Determine sign of last variable used
	pop   H         
	jz    L0B3AH    
L0B33H	rst   2         ; Get next non-white char from M
	jc    BSGOTO    ; GOTO statement
	jmp   L083FH    
	
L0B3AH	mvi   D,01H     
L0B3CH	call  BSDATA    ; DATA statement
	ora   A         
	rz              
	rst   2         ; Get next non-white char from M
	CPI   91H       
	jnz   L0B3CH    
	dcr   D         
	jnz   L0B3CH    
	jmp   L0B33H    
	
	
; ======================================================
; LPRINT statement
; ======================================================
BSLPRN	mvi   A,01H     ; Prepare to set output to LPT
	sta   VOUTSW    ; Output device for RST 20H (0=screen)
	jmp   L0B60H    ; Jump into PRINT statement
	
	
; ======================================================
; PRINT statement
; ======================================================
BSPRIN	mvi   C,02H     ; Set PRINT # init entry marker
	call  L4F2BH    ; Test for '#' char and process argument
	CPI   40H       
	cz    L1D5FH    
L0B60H	dcx   H         
	rst   2         ; Get next non-white char from M
	cz    L4BCBH    
L0B65H	jz    L0C39H    
	CPI   0C2H       
	jz    BFUSNG    ; USING function
	CPI   0C0H       
	jz    BSTAB     ; TAB statement
	push  H         
	CPI   2CH       
	jz    L0BCDH    
	CPI   3BH       
	jz    L0C34H    
	pop   B         
	call  BMEVAL    ; Main BASIC evaluation routine
	push  H         
	rst   5         ; Determine type of last var used
	jz    L0BC6H    
	call  L39E8H    ; Convert binary number in FAC1 to ASCII at M
	call  L276BH    ; Search string at M until QUOTE found
	mvi   M,20H     
	lhld  VFAC1I    ; Start of FAC1 for integers
	inr   M         
	call  L421AH    
	jnz   L0BC2H    
	lhld  VFAC1I    ; Start of FAC1 for integers
	lda   VOUTSW    ; Output device for RST 20H (0=screen)
	ora   A         
	jz    L0BABH    
	lda   VLPPCL    ; Line printer head position
	add   M         
	CPI   0FFH       
	jmp   L0BB9H    
	
L0BABH	LDA   VACTcc    ; Active columns count (1-40)
	mov   B,A       
	inr   A         
	jz    L0BC2H    
	lda   0F788H     ; Horiz. position of cursor (0-39)
	add   M         
	dcr   A         
	cmp   B         
L0BB9H	jc    L0BC2H    
	cz    L4BD1H    
	cnz   L4BCBH    
L0BC2H	call  L27B4H    
	ora   A         
L0BC6H	cz    L27B4H    
	pop   H         
	jmp   L0B60H    
	
L0BCDH	lxi   B,L0008H  
	lhld  0FC8CH     
	dad   B         
	call  L421AH    
	mov   A,M       
	jnz   L0BF8H    
	lda   VOUTSW    ; Output device for RST 20H (0=screen)
	ora   A         
	jz    L0BEAH    ; Process printing the "," field separator
	lda   VLPPCL    ; Line printer head position
	CPI   0EEH       
	jmp   L0BF2H    
	
L0BEAH	lda   0F676H     ; Get COL of last field for comma separation in PRINT
	mov   B,A       ; Save in B
	lda   0F788H     ; Horiz. position of cursor (0-39)
	cmp   B         ; Compare with 0EH or value from DVI calculation
L0BF2H	cnc   L4BCBH    ; If not beyond last field, then
	jnc   L0C34H    ; Jump to print next item from PRINT statement if it fits
L0BF8H	SUI   0EH       ; Subtract 14 (comma field width)
	jnc   L0BF8H    ; Keep subtracting until negative
	cma             ; 1's compliement the remainder
	jmp   L0C2BH    
	
	
; ======================================================
; TAB statement
; ======================================================
BSTAB	call  L112DH    ; Evaluate expression at M
	rst   1         ; Compare next byte with M
    .db	29H             ; Test for ')'
	dcx   H         
L0C07H	push  H         
	lxi   B,L0008H  
	lhld  0FC8CH     
	dad   B         
	call  L421AH    
	mov   A,M       
	jnz   L0C26H    
	lda   VOUTSW    ; Output device for RST 20H (0=screen)
	ora   A         
	jz    L0C23H    
	lda   VLPPCL    ; Line printer head position
	jmp   L0C26H    
	
L0C23H	lda   0F788H     ; Horiz. position of cursor (0-39)
L0C26H	cma             
	add   E         
	jnc   L0C34H    
L0C2BH	inr   A         ; Pre-increment count
	mov   B,A       ; Save count in B
	mvi   A,20H     ; Load ASCII code for SPACE
L0C2FH	rst   4         ; Send character in A to screen/printer
	dcr   B         ; Decrement counter
	jnz   L0C2FH    ; Keep sending until zero
L0C34H	pop   H         ; Stack cleanup
	rst   2         ; Get next non-white char from M
	jmp   L0B65H    ; Jump into PRINT statement to print next item
	
L0C39H	xra   A         
	sta   VOUTSW    ; Output device for RST 20H (0=screen)
	push  H         
	mov   H,A       
	mov   L,A       
	shld  0FC8CH     ; Clear ASCII
	pop   H         
	ret             
	
	
; ======================================================
; LINE statement
; ======================================================
BLINES	CPI   84H       
	jnz   BSLINE    ; LINE statement
	rst   2         ; Get next non-white char from M
	CPI   23H       
	jz    BSLINP    ; LINE INPUT # statement
	call  L10E6H    ; Check for running program
	mov   A,M       
	call  L0CB4H    
	call  L4790H    ; Find address of variable at M
	call  L35D9H    ; Generate TM error if last variable type not string or RET
	push  D         
	push  H         
	CALL  INLin     ; Input and display (no "?") line and store
	pop   D         
	pop   B         
	jc    L40B3H    
	push  B         
	push  D         
	mvi   B,00H     
	call  L276EH    
	pop   H         
	mvi   A,03H     
	jmp   L09D6H    
	
L0C74H
    .db	"?Redo from start",0DH,0AH,00H
	
L0C87H	lda   VFB98H     
	ora   A         
	jnz   GERRSN    ; Jump to generate SN error on DATA statement line
	pop   B         
	lxi   H,L0C74H  ; Load pointer to "?Redo from start" text
	call  L27B1H    ; Print buffer at M until NULL or '"'
	lhld  VPCURL     ; Most recent or currenly running line pointer
	ret             
	
	
; ======================================================
; INPUT # statement
; ======================================================
BSINPN	call  L4F29H    ; Test for '#' char and process argument
	push  H         
	lxi   H,0F684H   
	jmp   L0CD4H    
	
	
; ======================================================
; INPUT statement
; ======================================================
BSINPU	call  L10E6H    ; Check for running program
	mov   A,M       
	CPI   23H       
	jz    BSINPN    ; INPUT # statement
	call  L10E6H    ; Check for running program
	mov   A,M       
	lxi   B,L0CC4H  
	push  B         
L0CB4H	CPI   22H       
	mvi   A,00H     
	rnz             
	call  L276CH    
	rst   1         ; Compare next byte with M
    .db	3BH             
	push  H         
	call  L27B4H    
	pop   H         
	ret             
	
L0CC4H	push  H         
	call  L463EH    ; Input and display line and store
	pop   B         
	jc    L40B3H    
	inx   H         
L0CCDH	mov   A,M       
	ora   A         
	dcx   H         
	push  B         
	jz    L099DH    
L0CD4H	mvi   M,2CH     
	jmp   L0CDEH    
	
	
; ======================================================
; READ statement
; ======================================================
BSREAD	push  H         
	lhld  VADATS    ; Address where DATA search will begin next
	ORI   0AFH       
	sta   VFB98H     
	xthl            
	jmp   L0CE8H    
	
L0CE6H	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
L0CE8H	call  L4790H    ; Find address of variable at M
	xthl            
	push  D         
	mov   A,M       
	CPI   2CH       
	jz    L0D0EH    
	lda   VFB98H     
	ora   A         
	jnz   L0D82H    
	mvi   A,3FH     
	rst   4         ; Send character in A to screen/printer
	call  L463EH    ; Input and display line and store
	pop   D         
	pop   B         
	jc    L40B3H    
	inx   H         
	mov   A,M       
	dcx   H         
	ora   A         
	push  B         
	jz    L099DH    
	push  D         
L0D0EH	call  L421AH    
	jnz   L4F4DH    
	rst   5         ; Determine type of last var used
	push  PSW       
	jnz   L0D3DH    
	rst   2         ; Get next non-white char from M
	mov   D,A       
	mov   B,A       
	CPI   22H       
	jz    L0D2EH    
	lda   VFB98H     
	ora   A         
	mov   D,A       
	jz    L0D2BH    
	mvi   D,3AH     
L0D2BH	mvi   B,2CH     
	dcx   H         
L0D2EH	call  L276FH    
L0D31H	pop   PSW       
	Adi   03H       
	xchg            
	lxi   H,L0D45H  
	xthl            
	push  D         
	jmp   L09D7H    
	
L0D3DH	rst   2         ; Get next non-white char from M
	lxi   B,L0D31H  
	push  B         
	jmp   L3840H    ; Convert ASCII number at M to double precision in FAC1
	
L0D45H	dcx   H         
	rst   2         ; Get next non-white char from M
	jz    L0D4FH    
	CPI   2CH       
	jnz   L0C87H    
L0D4FH	xthl            
	dcx   H         
	rst   2         ; Get next non-white char from M
	jnz   L0CE6H    
	pop   D         
	lda   VFB98H     
	ora   A         
	xchg            
	jnz   L4095H    
	push  D         
	call  L421AH    
	jnz   L0D6DH    
	mov   A,M       
	ora   A         
	lxi   H,L0D71H  ; Load pointer to "?Extra ignored" text
	cnz   L27B1H    ; Print buffer at M until NULL or '"'
L0D6DH	pop   H         
	jmp   L0C39H    ; Jump to routine to terminate running BASIC?
	
L0D71H
    .db	"?Extra ignored",0DH,0AH,00H
	
L0D82H	call  BSDATA    ; DATA statement
	ora   A         
	jnz   L0D9BH    
	inx   H         
	mov   A,M       
	inx   H         
	ora   M         
	mvi   E,04H     ; Load code for OD Error (Out of Data)
	jz    L045DH    ; Generate error in E
	inx   H         
	mov   E,M       
	inx   H         
	mov   D,M       
	xchg            
	shld  0FB94H     ; Line number of current data statement
	xchg            
L0D9BH	rst   2         ; Get next non-white char from M
	CPI   83H       
	jnz   L0D82H    
	jmp   L0D0EH    
	
L0DA4H	rst   1         ; Compare next byte with M
    .db	0DDH             ; Test for '=' token ID
	jmp   BMEVAL    ; Main BASIC evaluation routine
	
L0DA9H	rst   1         ; Compare next byte with M
    .db	28H             ; Test for '('
	
; ======================================================
; Main BASIC evaluation routine
; ======================================================
BMEVAL	dcx   H         
L0DACH	mvi   D,00H     
L0DAEH	push  D         
	mvi   C,01H     ; Prepare to test for 2 bytes free stack space
	call  L3EFFH    ; Test for 2 bytes free in stack space
	call  L0F1CH    ; Evaluate function at M
L0.db7H	shld  0FBA8H     ; Save new pointer to input string
L0.dbAH	lhld  0FBA8H     ; Restore pointer to input string
	pop   B         
	mov   A,M       ; Get next token from input
	shld  0FB8EH     ; Save new pointer to input string
	CPI   0D0H       ; Compare token with '+'
	rc              ; RETurn to perform next level of precedence operation
	CPI   0DFH       ; Compare with "SGN" function
	rnc             ; RETurn to perform next level of precedence operation
	CPI   0DCH       ; Compare with '>'
	jnc   L0E29H    ; Jump to handle '>', '=', '<' operators
	SUI   0D0H       ; Make operator token zero based
	mov   E,A       ; Save zero-based operator token in E
	jnz   L0DDCH    ; Skip string concatenation test if not '+' token
	lda   0FB65H     ; Type of last variable used
	CPI   03H       ; Test if last type was String
	mov   A,E       ; Copy token to A
	jz    L28CCH    ; Jump (to string concat?) if last variable type was string
L0DDCH	lxi   H,L02E2H  ; Load pointer to operator order of precedence table maybe?
	mvi   D,00H     ; Make MSB of operator token zero
	dad   D         ; Index into order of precedence table
	mov   A,B       
	mov   D,M       ; Get order of precedence from table
	cmp   D         
	rnc             
	push  B         
	lxi   B,L0.dbAH  ; Address of BASIC eval routine for nested evaluations
	push  B         ; Push address to stack
	mov   A,D       
	CPI   51H       
	jc    L0E45H    
	ANI   0FEH       
	CPI   7AH       
	jz    L0E45H    
L0DF8H	lxi   H,VFAC1I   ; Start of FAC1 for integers
	lda   0FB65H     ; Type of last variable used
	SUI   03H       ; Test if last type was String
	jz    L045BH    ; Generate TM error
	ora   A         
	lhld  VFAC1I     ; Start of FAC1 for integers
	push  H         
	jm    L0E1AH    
	lhld  VVC1SD     ; Start of FAC1 for single and double precision
	push  H         
	jpo   L0E1AH    
	lhld  0FC1EH     
	push  H         
	lhld  0FC1CH     
	push  H         
L0E1AH	Adi   03H       
	mov   C,E       
	mov   B,A       
	push  B         
	lxi   B,L0E6CH  ; Load pointer to ??? operation vector
L0E22H	push  B         ; PUSH operation vector to RETurn to later
	lhld  0FB8EH     ; Restore pointer to input string
	jmp   L0DAEH    ; Jump to continue evaluation
	
L0E29H	mvi   D,00H     
L0E2BH	SUI   0DCH       
	jc    L0E51H    
	CPI   03H       
	jnc   L0E51H    
	CPI   01H       
	ral             
	xra   D         
	cmp   D         
L0E3AH	mov   D,A       
	jc    ERRSYN    ; Generate Syntax error
	shld  0FB8EH     
	rst   2         ; Get next non-white char from M
	jmp   L0E2BH    
	
L0E45H	push  D         
	call  BFCINT    ; CINT function
	pop   D         
	push  H         
	lxi   B,L1072H  ; Load pointer to vector for handling logic functions
	jmp   L0E22H    ; PUSH operator vector and continue evaluation
	
L0E51H	mov   A,B       
	CPI   64H       
	rnc             
	push  B         
	push  D         
	lxi   D,L6405H  
	lxi   H,L1047H  
	push  H         
	rst   5         ; Determine type of last var used
	jnz   L0DF8H    
	lhld  VFAC1I     ; Start of FAC1 for integers
	push  H         
	lxi   B,L270CH  
	jmp   L0E22H    ; PUSH operator vector and continue evaluation
	
L0E6CH	pop   B         
	mov   A,C       
	sta   0FB66H     ; Clear tokenization flags
	lda   0FB65H     ; Type of last variable used
	cmp   B         ; Test if last type matches type from Stack
	jnz   L0E85H    
	CPI   02H       ; Test if last type as integer
	jz    L0EA1H    
	CPI   04H       ; Test if last type was Single Precision
	jz    L0EF0H    
	jnc   L0EB4H    
L0E85H	mov   D,A       
	mov   A,B       
	CPI   08H       
	jz    L0EB1H    
	mov   A,D       
	CPI   08H       ; Test if last variable type was Double Precision
	jz    L0ED8H    
	mov   A,B       
	CPI   04H       
	jz    L0EEDH    
	mov   A,D       
	CPI   03H       ; Test if last variable type was String
	jz    L045BH    ; Generate TM error
	jnc   L0EF8H    
L0EA1H	lxi   H,L0310H  
	mvi   B,00H     
	dad   B         
	dad   B         
	mov   C,M       
	inx   H         
	mov   B,M       
	pop   D         
	lhld  VFAC1I     ; Start of FAC1 for integers
	push  B         
	ret             
	
L0EB1H	call  BFC.dbL    ; C.dbL function
L0EB4H	call  L3484H    ; Copy FAC1 to FAC2
	pop   H         
	shld  0FC1CH     
	pop   H         
	shld  0FC1EH     
L0EBFH	pop   B         
	pop   D         
	call  L3432H    ; Load single precision in BCDE to FAC1
L0EC4H	call  BFC.dbL    ; C.dbL function
	lxi   H,L02F8H  
L0ECAH	lda   0FB66H     ; Get tokenization flags
	rlc             
	add   L         
	mov   L,A       
	adc   H         
	sub   L         
	mov   H,A       
	mov   A,M       
	inx   H         
	mov   H,M       
	mov   L,A       
	pchl            
	
L0ED8H	mov   A,B       
	push  PSW       
	call  L3484H    ; Copy FAC1 to FAC2
	pop   PSW       
	sta   0FB65H     ; Type of last variable used
	CPI   04H       ; Test if last type was Single Precision
	jz    L0EBFH    
	pop   H         
	shld  VFAC1I     ; Start of FAC1 for integers
	jmp   L0EC4H    
	
L0EEDH	call  BFCSNG    ; CSNG function
L0EF0H	pop   B         
	pop   D         
L0EF2H	lxi   H,L0304H  
	jmp   L0ECAH    
	
L0EF8H	pop   H         
	call  L3422H    ; Push single precision FAC1 on stack
	call  L3543H    ; Convert signed integer HL to single precision FAC1
	call  L343DH    ; Load single precision FAC1 to BCDE
	pop   H         
	shld  VVC1SD     ; Start of FAC1 for single and double precision
	pop   H         
	shld  VFAC1I     ; Start of FAC1 for integers
	jmp   L0EF2H    
	
	
; ======================================================
; Integer Divide FAC1=DE/HL
; ======================================================
L0F0DH	push  H         
	xchg            
	call  L3543H    ; Convert signed integer HL to single precision FAC1
	pop   H         
	call  L3422H    ; Push single precision FAC1 on stack
	call  L3543H    ; Convert signed integer HL to single precision FAC1
	jmp   L380CH    
	
	
; ======================================================
; Evaluate function at M
; ======================================================
L0F1CH	rst   2         ; Get next non-white char from M
	jz    L0458H    ; Generate MO error
	jc    L3840H    ; Convert ASCII number at M to double precision in FAC1
	call  L40F2H    ; Check if A is alpha character
	jnc   L0FDAH    ; Evaluate variable
	CPI   0D0H       ; If not alpha, test for '+' token ID
	jz    L0F1CH    ; Evaluate function at M
	CPI   2EH       ; Test for '.'
	jz    L3840H    ; Convert ASCII number at M to double precision in FAC1
	CPI   0D1H       ; Test for '-' token ID
	jz    L0FCCH    ; Handle '-' during evaluation
	CPI   22H       ; Test for '"'
	jz    L276CH    
	CPI   0CEH       ; Test for NOT function
	jz    BFNOT    ; NOT function
	CPI   0C5H       ; Test for ERR function
	jnz   L0F51H    ; Jump if not ERR function
	
; ======================================================
; ERR function
; ======================================================
BFERR	rst   2         ; Get next non-white char from M
	lda   0F672H     ; Last Error code
	push  H         
	call  L10D1H    ; Load integer in A into FAC1
	pop   H         
	ret             
	
L0F51H	CPI   0C4H       ; Test for ERL function
	jnz   L0F60H    ; Branch if not ERL
	
; ======================================================
; ERL function
; ======================================================
BFERL	rst   2         ; Get next non-white char from M
	push  H         
	lhld  0FB9FH     ; Line number of last error
	call  L37DBH    ; Convert unsigned HL to single precision in FAC1
	pop   H         
	ret             
	
L0F60H	CPI   0AAH       ; TIME$ token
	jz    BFTIMS    ; TIME$ function
	CPI   0ABH       ; DATE$ token
	jz    L1924H    ; Jump to DATE$ function
	CPI   0ACH       ; DAY token
	jz    BFDAY    ; DAY function
	CPI   0B7H       ; MAX token
	jz    BFMAX    ; MAX function
	CPI   0CCH       ; HIMEM token
	jz    BFHMEM    ; HIMEM function
	CPI   0C3H       ; VARPTR token
	jnz   L0FA3H    ; Jump if not VARPTR to test more
	
; ======================================================
; VARPTR function
; ======================================================
BFVPTR	rst   2         ; Get next non-white char from M
	rst   1         ; Compare next byte with M
    .db	28H             ; Test for '('
	CPI   23H       
	jnz   BFVPTV    ; VARPTR(variable) function
	
; ======================================================
; VARPTR(#buffer) function
; ======================================================
BFVPTB	call  L112DH    ; Evaluate expression at M
	push  H         
	call  L4C84H    ; Get file descriptor for file in A
	xchg            
	pop   H         
	jmp   L0F95H    
	
	
; ======================================================
; VARPTR(variable) function
; ======================================================
BFVPTV	call  L482CH    
L0F95H	rst   1         ; Compare next byte with M
    .db	29H             ; Test for ')'
	push  H         
	xchg            
	mov   A,H       
	ora   L         
	jz    L08DBH    ; Generate FC error
	call  L3510H    ; Load signed integer in HL to FAC1
	pop   H         
	ret             
	
L0FA3H	CPI   0C7H       
	jz    BFINST    ; INSTR function
	CPI   0C9H       
	jz    BFINKY    ; INKEY$ function
	CPI   0C6H       
	jz    L296DH    ; STRING$ function
	CPI   84H       
	jz    BSINPT    ; INPUT statement
	CPI   0CAH       
	jz    BFCSRL    ; CSRLIN function
	CPI   0C8H       
	jz    BFDSKI    ; DSKI$ function
	SUI   0DFH       ; Compare with SGN token to test for function
	jnc   L0FF2H    ; Jump if SGN or higher (function)
L0FC6H	call  L0DA9H    
	rst   1         ; Compare next byte with M
    .db	29H             ; ')'
	ret             
	
L0FCCH	mvi   D,7DH     
	call  L0DAEH    
	lhld  0FBA8H     
	push  H         
	call  L33F6H    ; Call to take ABS value
L0FD8H	pop   H         
	ret             
	
	
; ======================================================
; Evaluate variable
; ======================================================
L0FDAH	call  L4790H    ; Find address of variable at M
L0FDDH	push  H         ; Save address of variable on stack
	xchg            
	shld  VFAC1I     ; Start of FAC1 for integers
	rst   5         ; Determine type of last var used
	cnz   L347EH    ; Copy variable if not string type
	pop   H         ; Get address of variable from stack
	ret             
	
	
; ======================================================
; Get char at M and convert to uppercase
; ======================================================
L0FE8H	mov   A,M       ; Get next character from input string
	
; ======================================================
; Convert A to uppercase
; ======================================================
L0FE9H	CPI   61H       ; Test if >= 'a'
	rc              ; Return if not
	CPI   7BH       ; Test if <= 'z'
	rnc             ; Return if not
	ANI   5FH       ; Make uppercase
	ret             
	
L0FF2H	mvi   B,00H     ; Set MSB of modified BASIC token to zero
	rlc             ; Multiply modified zero based token x2
	mov   C,A       ; Save in C
	push  B         ; And PUSH to the stack. Now we process function args.
	rst   2         ; Get next non-white char from M
	mov   A,C       ; Restore modified BASIC token
	CPI   39H       ; Test for string functions (STR$-MID$)
	jc    L1015H    ; Jump if not string function to handle SGN-ASC
	call  L0DA9H    
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	call  L35D9H    ; Generate TM error if last variable type not string or RET
	xchg            
	lhld  VFAC1I     ; Start of FAC1 for integers
	xthl            ; Get function index from stack
	push  H         ; And PUSH it back to the stack
	xchg            
	call  L112EH    ; Evaluate expression at M-1
	xchg            
	xthl            ; Get function index from stack
	jmp   L102EH    ; Lookup function (SGN-MID$) vector and Jump to it
	
L1015H	call  L0FC6H    
	xthl            ; Get function index from stack
	mov   A,L       
	CPI   0EH       
	jc    L102AH    
	CPI   1DH       
	jnc   L102AH    
	rst   5         ; Determine type of last var used
	push  H         
	cc    BFC.dbL    ; C.dbL function
	pop   H         
L102AH	lxi   D,L0FD8H  
	push  D         
L102EH	lxi   B,L0040H  ; Function vector table for SGN to MID$
L1031H	dad   B         ; Index into Function vector table based on HL
	mov   C,M       ; Get LSB of function address
	inx   H         ; Increment to MSB
	mov   H,M       ; Get MSB of function address
	mov   L,C       ; Copy LSB to HL
	pchl            ; Jump to function
	
	
; ======================================================
; ASCII num conversion - find ASCII or tokenized '+' or '-' in A
; ======================================================
L1037H	dcr   D         
	CPI   0D1H       
	rz              
	CPI   2DH       
	rz              
	inr   D         
	CPI   2BH       
L1041H	rz              
	CPI   0D0H       
	rz              
	dcx   H         
	ret             
	
L1047H	inr   A         
	adc   A         
	pop   B         
	ana   B         
	Adi   0FFH       
	sbb   A         
	call  L340AH    ; SGN function
	jmp   L1066H    
	
	
; ======================================================
; NOT function
; ======================================================
BFNOT	mvi   D,5AH     
	call  L0DAEH    
	call  BFCINT    ; CINT function
	mov   A,L       
	cma             
	mov   L,A       
	mov   A,H       
	cma             
	mov   H,A       
	shld  VFAC1I     ; Start of FAC1 for integers
	pop   B         
L1066H	jmp   L0.dbAH    
	
	
; ======================================================
; RST 28H routine
; ======================================================
L1069H	lda   0FB65H     ; Type of last variable used
	CPI   08H       ; Compare with Double Precision to set C flag (Clear if .dbl)
	dcr   A         ;
	dcr   A         ; Decrement type 3 times to set Z, P and S flags
	dcr   A         ;
	ret             ; Return with flags set / cleared
	
L1072H	mov   A,B       
	push  PSW       
	call  BFCINT    ; CINT function
	pop   PSW       
	pop   D         
	CPI   7AH       
	jz    L37DFH    
	CPI   7BH       
	jz    L377EH    ; Signed integer divide (FAC1=DE/HL)
	lxi   B,L10D3H  
	push  B         
	CPI   46H       
	jnz   L1092H    
	
; ======================================================
; OR function
; ======================================================
BFOR	mov   A,E       ; Move LSB of DE to A
	ora   L         ; OR LSB of HL
	mov   L,A       ; Save in L
	mov   A,H       ; Move MSB of HL to A
	ora   D         ; OR MSB of DE
	ret             
	
L1092H	CPI   50H       ; Compare A with AND token
	jnz   L109DH    ; Jump if not AND to test XOR
	
; ======================================================
; AND function
; ======================================================
BFAND	mov   A,E       ; Move LSB of DE to A
	ana   L         ; AND LSB with HL
	mov   L,A       ; Save in L
	mov   A,H       ; Move MSB of HL to A
	ana   D         ; AND with D
	ret             
	
L109DH	CPI   3CH       ; Compare A with XOR token
	jnz   L10A8H    ; Jump if not XOR to test EQV
	
; ======================================================
; XOR function
; ======================================================
BFXOR	mov   A,E       ; Move LSB of DE to A
	xra   L         ; XOR with LSB of HL
	mov   L,A       ; Save in L
	mov   A,H       ; Move MSB of HL to A
	xra   D         ; XOR with MSB of DE
	ret             
	
L10A8H	CPI   32H       ; Compare A with EQV token
	jnz   BFIMP     ; IMP function
	
; ======================================================
; EQV function
; ======================================================
BFEQV	mov   A,E       ; Move LSB of DE to A
	xra   L         ; XOR with LSB of HL
	cma             ; Compliment the result
	mov   L,A       ; And save in L
	mov   A,H       ; Move MSB of HL to A
	xra   D         ; XOR with D
	cma             ; Compliment that result
	ret             
	
	
; ======================================================
; IMP function
; ======================================================
BFIMP	mov   A,L       ; Load LSB of HL
	cma             ; Compliment HL
	ana   E         ; AND with LSB of DE
	cma             ; Compliment the result
	mov   L,A       ; Save in A
	mov   A,H       ; Get MSB of HL
	cma             ; Compliment HL
	ana   D         ; AND with MSB of DE
	cma             ; Compliment the result
	ret             
	
L10BFH	mov   A,L       ; Load LSB of HL
	sub   E         ; Subtract LSB of DE
L10C1H	mov   L,A       ; Save the result in HL
	mov   A,H       ; Load MSB of HL
	sbb   D         ; Subtract MSB of DE (with borrow)
	mov   H,A       ; Save the result in HL
	jmp   L37DBH    ; Convert unsigned HL to single precision in FAC1
	
	
; ======================================================
; LPOS function
; ======================================================
BFLPOS	lda   VLPPCL    ; Line printer head position
	jmp   L10D1H    ; Load integer in A into FAC1
	
	
; ======================================================
; POS function
; ======================================================
BFPOS	lda   0F788H     ; Horiz. position of cursor (0-39)
	
; ======================================================
; Load integer in A into FAC1
; ======================================================
L10D1H	mov   L,A       
	xra   A         
L10D3H	mov   H,A       
	jmp   L3510H    ; Load signed integer in HL to FAC1
	
L10D7H	push  H         ; Preserve HL on stack
	ANI   07H       ; Limit to 7 function pointers
	lxi   H,L02EEH  ; Vector table for math operations
	mov   C,A       
	mvi   B,00H     
	dad   B         
	call  L1031H    ; Lookup vector of function (index x2 in HL) and Jump to it
	pop   H         ; Restore HL
	ret             
	
	
; ======================================================
; Check for running program
; ======================================================
L10E6H	push  H         
	lhld  VBSCLN     ; Current executing line number
	inx   H         
	mov   A,H       
	ora   L         
	pop   H         
	rnz             
	
; ======================================================
; Generate ID error
; ======================================================
	mvi   E,0CH     ; Load code for ID Error (Illegal Direct)
	jmp   L045DH    ; Generate error in E
	
L10F4H	CPI   7EH       ; Test if command is '~'
	jnz   ERRSYN    ; Generate Syntax error
	inx   H         ; Skip to next byte in command string
	jmp   L2AC2H    
	
	jmp   ERRSYN    ; Generate Syntax error
	
	
; ======================================================
; INP function
; ======================================================
BFINP	call  L1131H    ; Get expression integer < 256 in A or FC Error
	sta   0F66BH     ; Save port number as argument to IN
	call  0F66AH     ; Call the RAM based IN hook
	jmp   L10D1H    ; Load integer in A into FAC1
	
	
; ======================================================
; OUT statement
; ======================================================
BFOUT	call  L111FH    ; Call to process arguments to OUT statement
	jmp   0F667H     ; Jump to RAM based hook
	
	
; ======================================================
; Evaluate expression at M
; ======================================================
L1112H	rst   2         ; Get next non-white char from M
	
; ======================================================
; Evaluate expression at M-1
; ======================================================
L1113H	call  BMEVAL    ; Main BASIC evaluation routine
L1116H	push  H         ; Preserve HL on stack
	call  BFCINT    ; CINT function
	xchg            ; Put Integer into DE
	pop   H         ; Restore HL
	mov   A,D       ; Move MSB of integer to A to test if > 255
	ora   A         ; Test if integer > 255
	ret             
	
L111FH	call  L112EH    ; Evaluate expression at M-1
	sta   0F66BH     ; Save port # as argument to IN? Why?
	sta   0F668H     ; Save port # as argument to OUT. Ok.
	rst   1         ; Compare next byte with M
    .db	2CH             ; Compare next byte with ","
	jmp   L112EH    ; Evaluate expression at M-1
	
	
; ======================================================
; Evaluate expression at M
; ======================================================
L112DH	rst   2         ; Get next non-white char from M
	
; ======================================================
; Evaluate expression at M-1
; ======================================================
L112EH	call  BMEVAL    ; Main BASIC evaluation routine
L1131H	call  L1116H    ; Convert to integer in DE and test if 255 or less
	jnz   L08DBH    ; Generate FC error
	dcx   H         ; Decrement input string pointer
	rst   2         ; Get next non-white char from M
	mov   A,E       ; Copy LSB of integer to A
	ret             
	
	
; ======================================================
; LLIST statement
; ======================================================
BSLLST	mvi   A,01H     
	sta   VOUTSW    ; Output device for RST 20H (0=screen)
	
; ======================================================
; LIST statement
; ======================================================
BSLIST	pop   B         
	call  L060AH    ; Evaluate LIST statement arguments
	push  B         
	mov   H,B       
	mov   L,C       
	shld  0FABAH     ; Address where last BASIC list started
L114AH	lxi   H,0FFFFH   
	shld  VBSCLN    ; Current executing line number
	pop   H         
	shld  0FABCH     
	pop   D         
	mov   C,M       
	inx   H         
	mov   B,M       
	inx   H         
	mov   A,B       
	ora   C         
	jz    L1195H    
	call  L421AH    
	cz    L13F3H    
	push  B         
	mov   C,M       
	inx   H         
	mov   B,M       
	inx   H         
	push  B         
	xthl            
	xchg            
	rst   3         ; Compare DE and HL
	pop   B         
	jc    L1194H    
	xthl            
	push  H         
	push  B         
	xchg            
	shld  0FBA1H     ; Most recent used or entered line number
	call  L39D4H    ; Print binary number in HL at current position
	pop   H         
	mov   A,M       
	CPI   09H       
	jz    L1185H    
	mvi   A,20H     
	rst   4         ; Send character in A to screen/printer
L1185H	call  L11AAH    
	lxi   H,VKYBBF  ; Keyboard buffer
	call  L11A2H    ; Send buffer at M to screen
	call  L4BCBH    
	jmp   L114AH    
	
L1194H	pop   B         
L1195H	lda   0F651H     ; In TEXT because of BASIC EDIT flag
	ana   A         
	jnz   L5E82H    
	mvi   A,1AH     
	rst   4         ; Send character in A to screen/printer
	jmp   L0502H    ; Vector to BASIC ready - print Ok
	
	
; ======================================================
; Send buffer at M to screen
; ======================================================
L11A2H	mov   A,M       ; Get next byte to send to screen
	ora   A         ; Test for NULL termination
	rz              ; Return if NULL found
	rst   4         ; Send character in A to screen/printer
	inx   H         ; Increment the buffer pointer
	jmp   L11A2H    ; Send buffer at M to screen
	
L11AAH	lxi   B,VKYBBF  ; Keyboard buffer
	mvi   D,0FFH     
	xra   A         
	sta   0FB66H     ; Clear tokenization flags
	jmp   L11B9H    
	
L11B6H	inx   B         
	dcr   D         
	rz              
L11B9H	mov   A,M       
	inx   H         
	ora   A         
	stax  B         
	rz              
	CPI   22H       ; Test for open quote
	jnz   L11CDH    ; Jump if not quote
	lda   0FB66H     ; Load tokenization flags
	XRI   01H       ; Invert "in-quote" marker
	sta   0FB66H     ; Save back to tokenization flags
	mvi   A,22H     ; Reload quote character to A
L11CDH	CPI   3AH       ; Test for colon
	jnz   L11E1H    ; Jump if not colon
	lda   0FB66H     ; Get tokenization flags
	rar             
	jc    L11DFH    
	ral             
	ANI   0FDH       
	sta   0FB66H     ; Save tokenization flags
L11DFH	mvi   A,3AH     
L11E1H	ora   A         
	jp    L11B6H    
	lda   0FB66H     ; Get tokenization flags
	rar             
	jc    L11B6H    
	dcx   H         
	rar             
	rar             
	jnc   L1233H    
	mov   A,M       
	CPI   0FFH       
	push  H         
	push  B         
	lxi   H,L121AH  
	push  H         
	rnz             
	dcx   B         
	ldax  B         
	CPI   4DH       
	rnz             
	dcx   B         
	ldax  B         
	CPI   45H       
	rnz             
	dcx   B         
	ldax  B         
	CPI   52H       
	rnz             
	dcx   B         
	ldax  B         
	CPI   3AH       
	rnz             
	pop   PSW       
	pop   PSW       
	pop   H         
	inr   D         
	inr   D         
	inr   D         
	inr   D         
	jmp   L1242H    
	
L121AH	pop   B         
	pop   H         
	mov   A,M       
L121DH	inx   H         
	jmp   L11B6H    
	
L1221H	lda   0FB66H     ; Get tokenization flags
	ORI   02H       
L1226H	sta   0FB66H     ; Clear tokenization flags
	xra   A         
	ret             
	
L122BH	lda   0FB66H     ; Get tokenization flags
	ORI   04H       
	jmp   L1226H    
	
L1233H	ral             
	jc    L121DH    
	mov   A,M       
	CPI   83H       
	cz    L1221H    
	CPI   8EH       
	cz    L122BH    
L1242H	mov   A,M       
	inx   H         
	CPI   91H       
	cz    L3643H    
	SUI   7FH       
	push  H         
	mov   E,A       
	lxi   H,L0080H  ; BASIC statement keyword table END to NEW
L1250H	mov   A,M       
	inx   H         
	ora   A         
	jp    L1250H    
	dcr   E         
	jnz   L1250H    
	ANI   7FH       
L125CH	stax  B         
	inx   B         
	dcr   D         
	jz    L27E2H    
	mov   A,M       
	inx   H         
	ora   A         
	jp    L125CH    
	pop   H         
	jmp   L11B9H    
	
L126CH	xchg            
	lhld  VPSVAR     ; Start of variable data pointer
L1270H	ldax  D         
	stax  B         
	inx   B         
	inx   D         
	rst   3         ; Compare DE and HL
	jnz   L1270H    
	mov   H,B       
	mov   L,C       
	shld  VPSVAR     ; Start of variable data pointer
	shld  VARRTP     ; Start of array table pointer
	shld  VPFREM     ; Unused memory pointer
	ret             
	
	
; ======================================================
; PEEK function
; ======================================================
BFPEEK	call  L12A1H    ; Convert last expression to integer (-32768 to 65535) or OV
	mov   A,M       ; Load A from (HL)
	jmp   L10D1H    ; Load integer in A into FAC1
	
	
; ======================================================
; POKE function
; ======================================================
BFPOKE	call  L1297H    ; Evaluate expression at M
	push  D         ; Save POKE address to stack
	rst   1         ; Compare next byte with M
    .db	2CH             ; ','
	call  L112EH    ; Evaluate expression at M-1
	pop   D         ; Get POKE address form stack
	stax  D         ; POKE the value in a to (DE)
	ret             
	
	
; ======================================================
; Evaluate expression at M
; ======================================================
L1297H	call  BMEVAL    ; Main BASIC evaluation routine
	push  H         
	call  L12A1H    ; Convert last expression to integer (-32768 to 65535) or OV
	xchg            
	pop   H         
	ret             
	
L12A1H	lxi   B,BFCINT  ; CINT function
	push  B         
	rst   5         ; Determine type of last var used
	rm              ; Return to CINT function if last var was integer
	rst   6         ; Get sign of FAC1
	rm              ; Return to CINT function if FAC1 negative
	call  BFCSNG    ; CSNG function
	lxi   B,L3245H  ; Load BCDE with Single precision for 32768.0
	lxi   D,8076H   ; "
	call  L3498H    ; Compare single precision in BCDE with FAC1
	rc              ; Return to CINT function if less than 32768
	lxi   B,L6545H  ; Load BCDE with Single precision for 65536.0
	lxi   D,L6053H  ; "
	call  L3498H    ; Compare single precision in BCDE with FAC1
	jnc   L0455H    ; Generate OV error
	lxi   B,L65C5H  ; Load BCDE with Single precision for -65536.0
	lxi   D,L6053H  ; "
	jmp   L37F4H    ; Single precision addition (FAC1=FAC1+BCDE)
	
	
; ======================================================
; L12CBH: Wait and get character from keyboard.
; Entry conditions: none
; Exit conditions:  A = character code
;           Carry -- set if special character
;                 -- reset if normal character
; (<F1> - <F8> return preprogrammed strings)
; ======================================================
CHGET  push H          ; Preserve HL on stack
        push D          ; Preserve DE on stack
        push B          ; Preserve BC on stack
        call WAITKY     ; Call routine to wait for key
        jmp  L14EEH
WAITKY rst  7          ; Jump to RST 38H Vector entry of following byte
    .db  04H             ; CHGET Hook
; Process next byte of FKey text to "inject" the keys
        lhld 0F62CH      ; Get MSB of pointer to FKey text (from FKey table) for selected FKey
        inr  H          ; Prepare to test if MSB of address is zero
        dcr  H          ; Test for zero
        jz   PPBINJ     ; Jump to process paste buffer injection if no FKey selected
        mov  B,M        ; Get next byte from selected FKey text
        mov  A,B        ; Prepare to test if at end of FKey text
        ora  A          ; Test for NULL termination
        jz   L12EA      ; Jump ahead of at end of text
        inx  H          ; Look ahead to the next byte to see if we are at the end of the FKey text
        mov  A,M        ; Get the byte after this one
        ora  A          ; And test for zero
        jnz  L12EB      ; Jump to save updated FKey address if not at end
L12EA  mov  H,A        ; Load zero into H to indicate FKey no longer active
L12EB  shld 0F62CH      ; Save updated address of active FKey text
        mov  A,B        ; Get the next byte of the FKey text as our "Key"
        ret
; Process PASTE key from keyboard
PPASTE LDA  VKYScm
        add  A
        rc
        lxi  H,0000H   ; Initialize index of next byte to paste from paste buffer
        shld 0F62EH      ; Save as index of next byte to paste from paste buffer
        mvi  A,0DH      ; Prepare to initialize "last paste char" as ENTER
        sta  0FAA1H      ; Initialize "last paste char" as ENTER
; Jump to process paste buffer injection if no FKey selected
PPBINJ lhld 0F62EH      ; Get index into paste buffer
        mov  A,L        ; Get LSB of length?
        ana  H          ; And with MSB
        inr  A          ; Increment to test for 0FFFFH
        jz   TKEYCH     ; Jump if not actively pasting from paste buffer
        push H          ; PUSH index to stack
        lda  0FAA1H      ; Get value of last paste character
        CPI  0DH        ; Test if it was ENTER
        cz   L2146H     ; Update system pointers for .DO), .CO), vars), etc.
        lhld VPSTBP     ; Start of Paste Buffer
        pop  D          ; Restore index of next byte in paste buffer
        dad  D          ; Point to next byte to paste from paste buffer
        mov  A,M        ; Get the next byte to paste
        sta  0FAA1H      ; Store it as the "last paste character"
        mov  B,A        ; Save byte in B
        CPI  1AH        ; Test for end of paste buffer marker maybe
        mvi  A,00H      ; Replace EOL marker with zero in case of match
        jz   ENDPBF     ; Jump if end of paste buffer
        call KEYX       ; Check keyboard queue for pending characters
        jc   ENDPBF     ; If there is keyboard action, halt the paste operation perhaps?
        inx  H          ; Point to next byte in paste buffer
        mov  A,M        ; Peek the next byte in paste buffer to see if at end
        xchg            ; Put index into paste buffer into HL
        inx  H          ; Increment the index count
        shld 0F62EH      ; Save as index into paste buffer of next byte to paste
        CPI  1AH        ; Test if next byte past current byte is end of buffer marker
        mov  A,B        ; Restore the byte to be pasted from B
        stc             ; Set the C flag
        cmc             ; And now clear it
        rnz             ; And return if not at end of paste buffer
; At end of paste buffer.
ENDPBF lxi  H,0FFFFH    ; Load value indication paste is "inactive"
        shld 0F62EH      ; And store it as the active index of paste from paste buffer
        ret             ; Now return the next byte from the paste buffer to "inject"
; Test for actual keystroke characters to process
TKEYCH call  CHSNS     ; Check keyboard queue for pending characters
        jnz   L1358
        call  CONIOB
        mvi   A,0FFH
        sta   VPROFS    ; Power off exit condition switch
CKQPDL call  CHSNS     ; Check keyboard queue for pending characters
        jz    CKQPDL
        xra   A
        sta   VPROFS    ; Power off exit condition switch
        call  COFIOB    ; Turn cursor back off if it was off before
L1358  lxi   H,VPWROF
        mov   A,M
        ana   A
        jnz   L13B5
        call  L1BB1H    ; Renew automatic power-off counter
        call  KYREAD    ; Scan keyboard for character (CTRL-BREAK ==> CTRL-C)
        rnc 
        SUI   0BH       ; Test for PASTE key
        jz    PPASTE    ; Jump to process PASTE key if zero
        jnc   L13C0
        inr   A         ; Test for SHIFT-PRINT key
        jz    PKYSEQ    ; Jump to process special "Paste" of SHIFT-PRINT key s.equence
        inr   A
        jz    BSLCPY     ; LCOPY statement
        inr   A         ; Test for LABEL key
        jz    TOGLAB    ; Toggle function key label line
        mov   E,A
        LDA   VKYScm
        add   A         ;
        add   A         ;
        mov   A,E       ;
        rc              ;
        mvi   D,0FFH     ;
        xchg            ;   KDP: TODO: This is calculating the FKey table entry or FKeys somehow!
        dad   H         ;
        dad   H         ;
        dad   H         ;
        dad   H         ;
        lxi   D,0F809H   ;
        dad   D         ;
        LDA   VKYScm     ;
        ana   A         ;
        jp    SHLPAT    ;
        inx   H
        inx   H
        inx   H
        inx   H

; Set HL as pointer to text to be "PASTED" / injected as keystrokes
SHLPAT shld  0F62CH     ; Points to text for selected FKey from FKey table
        jmp   WAITKY    ; Wait for key from keyboard

; Process paste of key s.equence defined for SHIFT-PRINT key
PKYSEQ lhld  0F88AH     ; Load pointer to SHIFT-PRINT key s.equence for this mode
        jmp   SHLPAT    ; Jump to set HL as pointer to PASTE s.equence

; Toggle function key label line	
TOGLAB lda   0FAADH     ; Label line enable flag
        ana   A         ; Test if Label line is enabled
        rz              ; Return if not enabled
        lda   VLABLF    ; Label line protect status
        XRI   0FFH       ; Test if Label Line is on or off

; Erase or Display function key line based on Z flag
        jz    ERAFNK    ; Erase function key display
        jmp   DSPNFK    ; Display function key line
L13B5  di              ; Disable interrupts for power-down
        mvi   M,00H
        lda   VPROFT    ; Load power-down time (1/10th of a minute)
        dcx   H         ; Point to power-down count-down
        mov   M,A       ; Update power-down count-down for next power-up
        call  L143FH    ; Turn off computer
L13C0  xra   A
        ret

; Turn cursor on if not already during program pause
CONIOB lda   0F63FH     ; Cursor status (0 = off)
        sta   0FACBH     ; Storage if cursor was on before BASIC CTRL-S
        ana   A
        rnz 
        call  CURSON    ; Turn the cursor on
        jmp   SDESCX    ; Send ESC X
; Turn cursor back off if it was off before
COFIOB lda   0FACBH
        ana   A
        rnz 
        call  CUROFF    ; Turn the cursor off
        jmp   SDESCX    ; Send ESC X
	
	
; ======================================================
; L13DBH: Check keyboard queue for characters
; Entry conditions: none
; Exit conditions:  Z flag set if queue empty,
;                   reset if keys pending
; ======================================================
CHSNS  lda  0F62DH
        ana  A
        rnz
        lda  VPWROF
        ana  A
        rnz
        push H
        lhld 0F62EH      ; Load index of active paste buffer paste operation
        mov  A,L        ; Prepare to test for 0FFFFH
        ana  H          ; AND in MSB to test for 0FFFFH
        inr  A          ; Test for 0FFFFH = paste operation inactive
        pop  H          ; Restore HL
        rnz             ; Return if paste operation active
        rst  7          ; Jump to RST 38H Vector entry of following byte
    .db  06H
        jmp  KEYX       ; Check keyboard queue for pending characters

; Test for CTRL-C or CTRL-S during BASIC Execute
        call BRKCHK     ; Check for break or wait (CTRL-S)
        rz
        CPI  03H        ; Test for CTRL-C
        JZ   ICTrlc     ; Jump if CTRL-C
        CPI  13H        ; Test for CTRL-S (pause)
        rnz             ; Return if not CTRL-S - okay to execute
        call CONIOB     ; Turn cursor on if not already during program pause
NCTRLC call BRKCHK     ; Check for break or wait (CTRL-S)
        CPI  13H        ; Test for CTRL-S
        jz   COFIOB     ; Turn cursor back off if it was off before
        CPI  03H        ; Check for CTRL-C
        JNZ  NCTrlc     ; Jump if not CTRL-C
        call COFIOB     ; Turn cursor back off if it was already off
ICTRLC xra  A
        sta  0FFAAH      ; Keyboard buffer count
        jmp  BSSTOP     ; STOP statement
	
	
; ======================================================
; POWER statement
; ======================================================
BSPOWR	SUI   0A4H       ; Test for CONT token
	JZ    BSPWrc    ; POWER CONT statement
	CPI   27H       ; Test for POWER OFF token
	jnz   BSPWRO    ; POWER ON statement
	rst   2         ; Get next non-white char from M
	jz    L1451H    ; If no arguments, jump to turn power off
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	rst   1         ; Compare next byte with M
    .db	95H             ; Test for RESUME token
	jnz   ERRSYN    ; Generate Syntax error
	jmp   L143FH    ; Turn off computer
	
	
; ======================================================
; Normal TRAP (low power) interrupt routine
; ======================================================
L1431H	push  PSW       ; Preserve A on stack
	lda   VPROFS    ; Power off exit condition switch
	ana   A         ; Test if system state preserved through power cycle
	mvi   A,01H     ; Set new exit condition - don't preserve state
	sta   VPROFS    ; Power off exit condition switch
	jnz   L1451H    ; Jump if not saving system state thru power cycle
	pop   PSW       ; Restore A from stack
	
; ======================================================
; Turn off computer
; ======================================================
L143FH	di              ; Disable interrupts for PowerDown
	push  H         ; Push all registers so we can restore
	push  D         ; to the same location upon next
	push  B         ; power on cycle.
	push  PSW       ;
	lxi   H,0000H   ; Prepare to save SP for Auto PowerDown
	dad   SP        ; Get SP into HL
	shld  0FABEH     ; SP save area for power up/down
	lxi   H,9C0BH   ; Load Auto PowerDown signaure
	shld  VSPOPD    ; Save Auto PowerDown signature
L1451H	di              ; Disable interrupts (again?)
	in    0BAH       ; Get Current I/O value of 0BAH
	ORI   10H       ; Set the PowerDown bit
	out   0BAH       ; PowerDown. We will loose power here
	hlt             ; Issue a HLT as power may be left in CAPs, etc.
	
; ======================================================
; POWER CONT statement
; ======================================================
BSPWRC	call  L1469H    ; Store zero to power down time & counter?
	sta   VPWROF     ; Store zero
	rst   2         ; Get next non-white char from M
	ret             
	
	
; ======================================================
; POWER ON statement
; ======================================================
BSPWRO	call  L112EH    ; Evaluate expression at M-1
	CPI   0AH       ; Validate POWER argument is at least 10 (10 * 0.1 min)
	jc    L08DBH    ; Generate FC error
L1469H	sta   VPROFT    ; Store POWER down time (1/10ths of a minute)
	sta   0F931H     ; Update power-off countdown
	ret             
	
	
; ======================================================
; L1470H: Print character without expanding tab characters
; Entry conditions: A = character to be printed
; Exit conditions:  none
; ======================================================
PNOTAB rst  7          ; Jump to RST 38H Vector entry of following byte
    .db  0AH
        call PRINTR     ; Send character in A to the printer
        jnc  L147F
        xra  A
        sta  0FACDH
        jmp  L1494H     ; Generate I/O error
L147F  push PSW
        mvi  A,0FFH
        sta  0FACDH
        call L1BB1H     ; Renew automatic power-off counter
        pop  PSW
        ret
	
	
; ======================================================
; Start tape and load tape header
; ======================================================
L148AH	call  L14A8H    ; Turn cassette motor on
	call  L6F85H    ; Read cassette header and sync byte
	rnc             
L1491H	call  L14AAH    ; Turn cassette motor off
	
; ======================================================
; Generate I/O error
; ======================================================
L1494H	mvi   E,12H     ; Load code for I/O Error
	jmp   L045DH    ; Generate error in E
	
	
; ======================================================
; Turn cassette motor on and detect sync header
; ======================================================
L1499H	call  L14A8H    ; Turn cassette motor on
	lxi   B,0000H   ; Zero out BC to delay prior to writing
L149FH	dcx   B         ; Decrement BC
	mov   A,B       ; Get MSB of count
	ora   C         ; OR in LSB of count to test for zero
	jnz   L149FH    ; Loop for 65536 cycle delay
	jmp   L6F46H    ; Write cassette header and sync byte
	
	
; ======================================================
; Turn cassette motor on
; ======================================================
L14A8H	di              
	lxi   D,L1EFBH  ; Make EI below look like LXI D,1EFBH
	nop             
	jmp   L7043H    ; Cassette REMOTE routine - turn motor on or off
	
	
; ======================================================
; Read byte from tape & update checksum
; ======================================================
L14B0H	push  D         
	push  H         
	push  B         
	call  L702AH    ; Read character from cassette w/o checksum
	jc    L1491H    ; Turn cassette motor off and generate I/O Error
	mov   A,D       
	pop   B         
	add   C         
	mov   C,A       
	mov   A,D       
	pop   H         
	pop   D         
	ret             
	
	
; ======================================================
; Write byte to tape & update checksum
; ======================================================
L14C1H	push  D         
	push  H         
	mov   D,A       
	add   C         
	mov   C,A       
	push  B         
	mov   A,D       
	call  L6F5BH    ; Write char in A to cassette w/o checksum
	jc    L1491H    ; Turn cassette motor off and generate I/O Error
	pop   B         
	pop   H         
	pop   D         
	ret             
	
	
; ======================================================
; LCD Device control block
; ======================================================
L14D2H
    .dw	14D8H,4D59H,14E5H
	
	
; ======================================================
; LCD and PRT file open routine
; ======================================================
L14D8H	mvi   A,02H     
	cmp   E         
	jnz   L504EH    ; Generate NM error
L14DEH	shld  0FC8CH     
	mov   M,E       
	pop   PSW       
	pop   H         
	ret             
	
	
; ======================================================
; Output to LCD file
; ======================================================
	pop   PSW       
	push  PSW       
	call  L431FH    
L14EAH	call  L1BB1H    ; Renew automatic power-off counter
	
; ======================================================
; Pop AF), BC), DE), HL from stack
; ======================================================
L14EDH	pop   PSW       
L14EEH	pop   B         
	pop   D         
	pop   H         
	ret             
	
	
; ======================================================
; CRT device control block
; ======================================================
    .dw	14F8H,4D59H,14FAH
	
L14F8H	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	40H             
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	44H             
	
; ======================================================
; RAM device control block
; ======================================================
    .dw	1506H,158DH,15ACH,15C4H
    .dw	161BH          
	
	
; ======================================================
; Open RAM file
; ======================================================
L1506H	push  H         
	push  D         
	inx   H         
	inx   H         
	push  H         
	mov   A,E       
	CPI   01H       
	jz    L1541H    
	CPI   08H       
	jz    L155CH    
L1516H	call  L220FH    ; Open a text file at (VFNCBP)
	jc    L1580H    
	push  D         
	call  L18DAH    
	pop   D         
L1521H	lxi   B,0000H  
L1524H	pop   H         
	ldax  D         
	ANI   02H       
	jnz   L5051H    ; Generate AO error
	ldax  D         
	ORI   02H       
	stax  D         
	inx   D         
	mov   M,E       
	inx   H         
	mov   M,D       
	inx   H         
	inx   H         
	inx   H         
	mvi   M,00H     
	inx   H         
	mov   M,C       
	inx   H         
	mov   M,B       
	pop   D         
	pop   H         
	jmp   L14DEH    
	
L1541H	lda   0F651H     ; In TEXT because of BASIC EDIT flag
	ana   A         
	lxi   H,0F9AFH   
	cz    L208FH    ; Find .DO or ." " file in catalog
	jz    L5057H    ; Generate FF error
	xchg            
	call  L1675H    
	xra   A         
	mov   M,A       
	mov   L,A       
	mov   H,A       
	shld  VPRINP     
	jmp   L1521H    
	
L155CH	pop   H         
	pop   D         
	mvi   E,02H     
	push  D         
	push  H         
	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	call  L208FH    ; Find .DO or ." " file in catalog
	jz    L1516H    
	mov   E,L       
	mov   D,H       
	inx   H         
	mov   A,M       
	inx   H         
	mov   H,M       
	mov   L,A       
	lxi   B,0FFFFH   
L1575H	mov   A,M       
	inx   H         
	inx   B         
	CPI   1AH       
	jnz   L1575H    
	jmp   L1524H    
	
L1580H	ldax  D         ; Get Open flag
	ANI   02H       ; Test if file already open
	jnz   L5051H    ; Generate AO error
	xchg            
	call  L1FBFH    ; Kill a text file
	jmp   L1516H    
	
	
; ======================================================
; Close RAM file
; ======================================================
	push  H         
	call  L15A0H    
	pop   H         
	call  L172AH    
	cnz   L1621H    
	call  L1675H    
	mvi   M,00H     
	jmp   L4D59H    ; LCD), CRT), and LPT file close routine
	
L15A0H	inx   H         
	inx   H         
	mov   A,M       
	inx   H         
	mov   H,M       
	mov   L,A       
	dcx   H         
	mov   A,M       
	ANI   0FDH       
	mov   M,A       
	ret             
	
	
; ======================================================
; Output to RAM file
; ======================================================
	pop   PSW       
	push  PSW       
	lxi   B,L14EAH  
	push  B         
	ana   A         
	rz              
	CPI   1AH       
	rz              
	CPI   7FH       
	rz              
	call  L1739H    ; Add byte to open file buffer and keep track of length
	rnz             
	lxi   B,L0100H  
	jmp   L1621H    
	
	
; ======================================================
; Input from RAM file
; ======================================================
	xchg            
	call  L1675H    
	call  L18C7H    
	xchg            
	call  L1749H    
	jnz   L1609H    
	xchg            
	lhld  0FC87H     
	rst   3         ; Compare DE and HL
	push  PSW       
	push  D         
	cnz   L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	pop   H         
	pop   PSW       
	lxi   B,0FFF9H   
	dad   B         
	mov   E,M       
	inx   H         
	mov   D,M       
	xchg            
	mov   A,M       
	inx   H         
	mov   H,M       
	mov   L,A       
	jnz   L15F5H    
	push  D         
	xchg            
	lhld  VPRINP     
	xchg            
	dad   D         
	pop   D         
L15F5H	xchg            
	inx   H         
	inx   H         
	inx   H         
	inx   H         
	mov   C,M       
	inx   H         
	mov   B,M       
	inr   M         
	inx   H         
	xchg            
	dad   B         
	mvi   B,00H     
	call  L2542H    ; Move B bytes from M to (DE)
	xchg            
	dcr   H         
	xra   A         
L1609H	mov   C,A       
	dad   B         
	mov   A,M       
	CPI   1AH       
	stc             
	cmc             
	jnz   L4E8AH    
	call  L1675H    
	mov   M,A       
	stc             
	jmp   L4E8AH    
	
	
; ======================================================
; Special RAM file I/O
; ======================================================
L161BH	call  L1675H    
	jmp   L17CDH    
	
L1621H	push  H         
	push  B         
	push  H         
	xchg            
	lhld  0FC87H     
	rst   3         ; Compare DE and HL
	cnz   L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	pop   H         
	dcx   H         
	mov   D,M       
	dcx   H         
	mov   E,M       
	xchg            
	pop   B         
	push  B         
	push  H         
	dad   B         
	xchg            
	mov   M,E       
	inx   H         
	mov   M,D       
	lxi   B,0FFFAH   
	dad   B         
	mov   E,M       
	inx   H         
	mov   D,M       
	ldax  D         
	mov   L,A       
	inx   D         
	ldax  D         
	mov   H,A       
	pop   B         
	dad   B         
	pop   B         
	push  H         
	push  B         
	call  L6B6DH    ; Insert BC spaces at M
	cnc   L18DDH    
	pop   B         
	pop   D         
	pop   H         
	jc    L1669H    
	push  H         
L1658H	mov   A,M       
	stax  D         
	inx   D         
	inx   H         
	dcr   C         
	jnz   L1658H    
	pop   D         
	lhld  0FC87H     
	rst   3         ; Compare DE and HL
	rz              
	jmp   L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	
L1669H	lxi   B,0FFF7H   
	dad   B         
	mvi   M,00H     
	call  L15A0H    
	jmp   L3F17H    ; Reinit BASIC stack and generate OM error
	
L1675H	push  D         
	lhld  VFDAIO     
	lxi   D,VFDARR   
	dad   D         
	pop   D         
	ret             
	
	
; ======================================================
; CAS device control block
; ======================================================
    .dw	1689H,16ADH,16C7H,16D2H
    .dw	1710H          
	
	
; ======================================================
; Open CAS file
; ======================================================
L1689H	push  H         
	push  D         
	lxi   B,L0006H  
	dad   B         
	xra   A         
	mov   M,A       
	sta   0FA8EH     
	mov   A,E       
	CPI   08H       
	jz    L504EH    ; Generate NM error
	CPI   01H       
	jz    L16A7H    
	call  L260EH    ; Open CAS for output of TEXT files
L16A2H	pop   D         
	pop   H         
	jmp   L14DEH    
	
L16A7H	call  L2653H    ; Open CAS for input of TEXT files
	jmp   L16A2H    
	
	
; ======================================================
; Close CAS file
; ======================================================
	call  L172AH    
	jz    L16C0H    
	push  H         
	dad   B         
L16B5H	mvi   M,1AH     
	inx   H         
	inr   C         
	jnz   L16B5H    
	pop   H         
	call  L1716H    
L16C0H	xra   A         
	sta   0FA8EH     
	jmp   L4D59H    ; LCD), CRT), and LPT file close routine
	
	
; ======================================================
; Output to CAS file
; ======================================================
	pop   PSW       
	push  PSW       
	call  L1739H    ; Add byte to open file buffer and keep track of length
	cz    L1716H    
	jmp   L14EAH    
	
	
; ======================================================
; Input from CAS file
; ======================================================
	xchg            
	lxi   H,0FA8EH   
	call  L18C7H    
	xchg            
	call  L1749H    
	jnz   L16FFH    
	push  H         
	call  L26D1H    ; Load Tape sync, header and 8DH marker & validate
	pop   H         
	lxi   B,0000H  
L16E8H	call  L14B0H    ; Read byte from tape & update checksum
	mov   M,A       
	inx   H         
	dcr   B         
	jnz   L16E8H    
	call  L14B0H    ; Read byte from tape & update checksum
	mov   A,C       
	ana   A         
	jnz   L1491H    ; Turn cassette motor off and generate I/O Error
	call  L14AAH    ; Turn cassette motor off
	dcr   H         
	xra   A         
	mov   B,A       
L16FFH	mov   C,A       
	dad   B         
	mov   A,M       
	CPI   1AH       
	stc             
	cmc             
	jnz   L4E8AH    
	sta   0FA8EH     
	stc             
	jmp   L4E8AH    
	
L1710H	lxi   H,0FA8EH   
	jmp   L17CDH    
	
L1716H	push  H         ; Preserve pointer to data
	call  L2648H    ; Write 8DH data packet header to TAPE
	pop   H         ; Restore pointer to data
	lxi   B,0000H   ; Clear out the byte counter + checksum
L171EH	mov   A,M       ; Get next byte to write
	call  L14C1H    ; Write byte to tape & update checksum
	inx   H         ; Increment pointer
	dcr   B         ; Decrement the byte count
	jnz   L171EH    ; Jump to loop for 256 bytes
	jmp   L2635H    ; Write checksum to TAPE
	
L172AH	mov   A,M       
	CPI   01H       
	rz              
	lxi   B,L0006H  
	dad   B         
	mov   A,M       
	mov   C,A       
	mvi   M,00H     
	jmp   L174FH    
	
L1739H	mov   E,A       
	lxi   B,L0006H  
	dad   B         
	mov   A,M       
	inr   M         
	inx   H         
	inx   H         
	inx   H         
	push  H         
	mov   C,A       
	dad   B         
	mov   M,E       
	pop   H         
	ret             
	
L1749H	lxi   B,L0006H  
	dad   B         
	mov   A,M       
	inr   M         
L174FH	inx   H         
	inx   H         
	inx   H         
	ana   A         
	ret             
	
	
; ======================================================
; LPT device control block
; ======================================================
    .dw	14D8H,4D59H,175AH
	
	
; ======================================================
; Output to LPT file
; ======================================================
	pop   PSW       
	push  PSW       
	call  PRTTAB    ; Print A to printer), expanding tabs if necessary
	jmp   L14EAH    
	
	
; ======================================================
; COM device control block
; ======================================================
    .dw	176DH,179EH,17A8H,17B0H
    .dw	17CAH          
	
	
; ======================================================
; Open MDM file
; ======================================================
L176CH	ORI   37H       
	push  PSW       
	cc    L52BBH    ; Disconnect phone line and disable modem carrier
	pop   PSW       
	push  PSW       
	push  H         
	push  D         
	lxi   H,VFNCBP   ; Filename of current BASIC program
	call  L17E6H    ; Set RS232 parameters from string at M
	pop   D         
	mov   A,E       
	CPI   08H       
	jz    L504EH    ; Generate NM error
	SUI   01H       
	jnz   L178BH    
	sta   0FA8FH     
L178BH	pop   H         
	pop   PSW       
	jc    L14DEH    
	call  L52E4H    ; Go off-hook and wait for carrier
	jc    L1494H    ; Generate I/O error
	mvi   A,02H     
	call  L5316H    
	jmp   L14DEH    
	
	
; ======================================================
; Close COM file
; ======================================================
L179EH	call  L6ECBH    ; Deactivate RS232 or modem
	xra   A         
	sta   0FA8FH     
	jmp   L4D59H    ; LCD), CRT), and LPT file close routine
	
	
; ======================================================
; Output to COM/MDM file
; ======================================================
	pop   PSW       
	push  PSW       
	call  L6E32H    ; Send character in A to serial port using XON/XOFF
	jmp   L14EAH    
	
	
; ======================================================
; Input from COM/MDM file
; ======================================================
	lxi   H,0FA8FH   
	call  L18C7H    
	call  L6D7EH    ; Get a character from RS232 receive queue
	jc    L1494H    ; Generate I/O error
	CPI   1AH       
	stc             
	cmc             
	jnz   L4E8AH    
	sta   0FA8FH     
	stc             
	jmp   L4E8AH    
	
	
; ======================================================
; Special COM/MDM file I/O
; ======================================================
L17CAH	lxi   H,0FA8FH   
L17CDH	mov   M,C       
	jmp   L5023H    
	
	
; ======================================================
; MDM Device control block
; ======================================================
    .dw	176CH,17DBH,17A8H,17B0H
    .dw	17CAH          
	
	
; ======================================================
; Close MDM file
; ======================================================
	mvi   A,02H     
	call  L5316H    
	call  L52BBH    ; Disconnect phone line and disable modem carrier
	jmp   L179EH    ; Close COM file
	
	
; ======================================================
; Set RS232 parameters from string at M
; ======================================================
L17E6H	push  PSW       
	lxi   B,L504EH  
	push  B         
	jnc   L17F7H    
	mov   A,M       
	SUI   31H       
	CPI   09H       
	rnc             
	inr   A         
	mov   D,A       
	inx   H         
L17F7H	mov   A,M       
	SUI   36H       
	CPI   03H       
	rnc             
	inr   A         
	add   A         
	add   A         
	add   A         
	mov   E,A       
	inx   H         
	call  L0FE8H    ; Get char at M and convert to uppercase
	CPI   49H       
L1808H	jnz   L181CH    
	mov   A,E       
	CPI   18H       
	rz              
	Adi   0CH       
	mov   E,A       
	ANI   08H       
	add   A         
	add   A         
	add   A         
	ORI   3FH       
	jmp   L1832H    
	
L181CH	CPI   45H       
	mvi   B,02H     
	jz    L182DH    
	SUI   4EH       
	mvi   B,04H     
	jz    L182DH    
	dcr   A         
	rnz             
	mov   B,A       
L182DH	mov   A,B       
	ora   E         
	mov   E,A       
	mvi   A,0FFH     
L1832H	sta   0FF8DH     ; RS232 Parity Control byte
	inx   H         
	mov   A,M       
	SUI   31H       
	CPI   02H       
	rnc             
	ora   E         
	mov   E,A       
	inx   H         
	call  L0FE8H    ; Get char at M and convert to uppercase
	CPI   44H       
	jz    L184EH    
	CPI   45H       
	rnz             
	call  L6F31H    ; Enable XON/OFF when CTRL-S / CTRL-Q sent
	stc             
L184EH	cnc   L6F32H    
	pop   B         
	pop   PSW       
	push  PSW       
	push  D         
	dcx   H         
	dcx   H         
	dcx   H         
	dcx   H         
	lxi   D,VISTAT  ; RS232 parameter setting table
	mvi   B,05H     
	mov   A,M       
	jc    L1864H    
	mvi   A,4DH     
L1864H	stax  D         
	inx   H         
	inx   D         
	call  L0FE8H    ; Get char at M and convert to uppercase
	dcr   B         
	jnz   L1864H    
	xchg            
	pop   H         
	pop   PSW       
	push  D         
	call  L6EA6H    ; Initialize RS232 or modem
	pop   H         
	ret             
	
	
; ======================================================
; Wand device control block
; ======================================================
L1877H
    .dw	1881H,1883H,08DBH,1885H
    .dw	1887H          
	
L1881H	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	46H             
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	48H             
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	4AH             
L1887H	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	4CH             
	
; ======================================================
; EOF function
; ======================================================
BFEOF	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	26H             
	call  L4C81H    
	jz    L505AH    ; Generate CF error
	CPI   01H       
	jnz   L504EH    ; Generate NM error
	push  H         
	call  L18BFH    
	mov   C,A       
	sbb   A         
	call  L340AH    ; SGN function
	pop   H         
	inx   H         
	inx   H         
	inx   H         
	inx   H         
	mov   A,M       
	lxi   H,0FA8FH   
	CPI   0FCH       
	jz    L18BDH    
	CPI   0F9H       
	jz    L18BDH    
	call  L1675H    
	CPI   0F8H       
	jz    L18BDH    
	lxi   H,0FA8EH   
L18BDH	mov   M,C       
	ret             
	
L18BFH	push  B         
	push  H         
	push  D         
	mvi   A,06H     
	jmp   L5123H    ; Call OPEN Hook and DCB Vector identified in A
	
L18C7H	mov   A,M       
	mvi   M,00H     
	ana   A         
	rz              
	inx   SP        
	inx   SP        
	CPI   1AH       
	stc             
	cmc             
	jnz   L4E8AH    
	mov   M,A       
	stc             
	jmp   L4E8AH    
	
L18DAH	lxi   B,L0001H  
L18DDH	lhld  0FB9DH     ; SP used by BASIC to reinitialize the stack
L18E0H	mov   A,M       ; Get next byte from stack
	ana   A         ; Test for zero (end of stack)
	rz              ; Return if at bottom of stack
	xchg            
	lhld  VTPRAM    ; BASIC string buffer pointer
	xchg            
	rst   3         ; Compare DE and HL
	rnc             
	mov   A,M       
	CPI   81H       ; Test if token that PUSHed the stack was FOR
	lxi   D,L0007H  ; Prepare to advance up the stack by 7 bytes (amount pushed by GOSUB)
	jnz   L1900H    ; Jump to add 7 if not FOR statement
	inx   H         ; Increment to address of loop control value
	mov   E,M       ; Get LSB of FOR loop control variable
	inx   H         ; Increment to MSB
	mov   D,M       ; Get MSB of FOR loop control variable
	xchg            ; Put address in HL
	dad   B         ; Point to original FOR loop source variable perhaps?
	xchg            ; HL=stack, DE=address of variable
	mov   M,D       ; Put new variable address on stack?
	dcx   H         ; Decrement to LSB
	mov   M,E       ; Put LSB of new variable location on stack?
	lxi   D,L0018H  ; FOR loop occupies 18H bytes on stack
L1900H	dad   D         ; Rewind the FOR loop
	jmp   L18E0H    ; Jump to process next stack level
	
	
; ======================================================
; TIME$ function
; ======================================================
BFTIMS	rst   2         ; Get next non-white char from M
	push  H         ; Save pointer to BASIC string on stack
	call  L198DH    ; Create an 8-byte transient string and return address in HL
	call  L190FH    ; Read time and store it at M
	jmp   L278DH    ; Add new transient string to string stack
	
	
; ======================================================
; Read time and store it at M
; ======================================================
L190FH	call  L19A0H    ; Update in-memory (0F923H) clock values
	lxi   D,0F928H   ; Hours (tens)
	call  L1996H    ; Hours - Convert 2 binary digits at (DE) to ASCII digits at (HL) and increment
	mvi   M,3AH     ; Add a ":" between hours and minutes
	inx   H         ; Increment string pointer
	call  L1996H    ; Convert 2 binary digits at (DE) to ASCII digits at (HL) and increment
	mvi   M,3AH     ; Add a ":" between minutes and seconds
L1920H	inx   H         ; Increment string pointer
	jmp   L1996H    ; Convert 2 binary digits at (DE) to ASCII digits at (HL) and increment
	
L1924H	rst   2         ; Get next non-white char from M
	push  H         ; Save pointer to BASIC command line
	call  L198DH    ; Create an 8-byte transient string and return address in HL
	call  BFDATS    ; DATE$ function
	jmp   L278DH    ; Add new transient string to string stack
	
	
; ======================================================
; DATE$ function
; ======================================================
BFDATS	call  L19A0H    ; Update in-memory (0F923H) clock values
	lxi   D,0F92CH   ; Month (1-12)
	ldax  D         ; Load month value
	CPI   0AH       ; Test if month >= 10
	mvi   B,30H     ; Load ASCII '0' in case month < 10
	jc    L1941H    ; Jump to save '0' as 1st digit of month if month < 10
	mvi   B,31H     ; Load ASCII '1' for 1st digit of month
	SUI   0AH       ; Subtract 10 from month to convert to ASCII
L1941H	mov   M,B       ; Save 1st digit of month to output string
	inx   H         ; Increment to 2nd digit of month
	call  L199AH    ; Convert binary digit in A to ASCII digit at (HL) and increment
	dcx   D         ; Decrement pointer to days in clock chip registers
	mvi   M,2FH     ; Add a '/' between month and day
	inx   H         ; Increment output string pointer
	call  L1996H    ; Convert 2 binary digits at (DE) to ASCII digits at (HL) and increment
	mvi   M,2FH     ; Add a '/' between day and year
	lxi   D,0F92EH   ; Year (tens)
	jmp   L1920H    ; Convert 2 binary digits at (DE) to ASCII digits at (HL+1) and increment
	
	
; ======================================================
; DAY function
; ======================================================
BFDAY	rst   2         ; Get next non-white char from M
	push  H         ; Preserve HL on stack
	mvi   A,03H     ; Prepare to create a 3-byte string
	call  L198FH    ; Create a string with length A and return address in HL
	call  L1962H    ; Read day and store at M
	jmp   L278DH    ; Add new transient string to string stack
	
	
; ======================================================
; Read day and store at M
; ======================================================
L1962H	call  L19A0H    ; Update in-memory (0F923H) clock values
	lda   0F92BH     ; Day code (0=Sun), 1=Mon), etc.)
	mov   C,A       ; Save the day code in A
	add   A         ; Multiply day code x2
	add   C         ; Multiply day code x3 (size of ASCII days)
	mov   C,A       ; Move day code x3 to C for offset into Day table
	mvi   B,00H     ; Zero out MSB of BC for add
	xchg            ; Save HL (the pointer to BASIC string)
	lxi   H,ASCDYT  ; Load pointer to ASCII table with Days
	dad   B         ; Index into Day ASCII table
	mvi   B,03H     ; Prepare to copy 3 bytes from Day table
	jmp   L2542H    ; Move B bytes from M to (DE)
	
ASCDYT			; ASCII Table with day names
    .db	"Sun"           
    .db	"Mon"           
    .db	"Tue"           
    .db	"Wed"
    .db	"Thu"           
    .db	"Fri"           
    .db	"Sat"           
L198DH	mvi   A,08H     ; Prepare to create an 8-byte transient string
L198FH	call  L275DH    ; Create a transient string of length A
	lhld  0FB8AH     ; Address of transient string
	ret             
	
L1996H	call  L1999H    ; Convert binary digit at (DE) to ASCII digit at (HL)
L1999H	ldax  D         ; Load binary value
L199AH	ORI   30H       ; Convert to ASCII digit
	mov   M,A       ; Save ASCII digit at M
	dcx   D         ; Decrement source pointer
	inx   H         ; Increment destination pointer
	ret             
	
	
; ======================================================
; Update in-memory (0F923H) clock values
; ======================================================
L19A0H	push  H         ; Preserve BASIC string pointer to stack
	lxi   H,0F923H   ; Seconds (ones)
	di              ; Disable interrupts during copy
	call  L7329H    ; Copy clock chip regs to M
	ei              ; Re-enable interrupts
	pop   H         ; Restore BASIC string pointer
	ret             
	
	
; ======================================================
; TIME$ statement
; ======================================================
BSTIMS	CPI   0DDH       ; Test for '=' token
	jnz   L1AA5H    ; Jump to process ON/OFF/STOP arguments
	call  L1A42H    ; Get time string from command line
	
; ======================================================
; Update clock chip from memory 0F923H
; ======================================================
L19B3H	lxi   H,0F923H   ; Seconds (ones)
	di              
	call  L732AH    ; Update clock chip regs from M
	ei              
	pop   H         
	ret             
	
	
; ======================================================
; DATE$ statement
; ======================================================
BSDATS	call  L1A2CH    
	jnz   ERRSYN    ; Generate Syntax error
	call  L112EH    ; Evaluate expression at M-1
	dcr   A         
	CPI   0CH       
	jnc   ERRSYN    ; Generate Syntax error
	inr   A         
	lxi   D,0F92CH   ; Month (1-12)
	stax  D         
	rst   1         ; Compare next byte with M
    .db	2FH             ; Test for '/'
	dcx   D         
	call  L1A6AH    
	CPI   04H       
	jnc   ERRSYN    ; Generate Syntax error
	call  L1A6AH    
	rst   1         ; Compare next byte with M
    .db	2FH             ; Test for '/'
	lxi   D,VCLKTK   
	call  L1A6AH    
	call  L1A6AH    
	xra   A         
	sta   0F655H     
	jmp   L19B3H    ; Update clock chip from memory 0F923H
	
	
; ======================================================
; DAY$ statement
; ======================================================
BSDAYS	call  L1A2CH    
	CPI   03H       
	jnz   ERRSYN    ; Generate Syntax error
	lxi   D,ASCDYT  
	mvi   C,07H     
L19FEH	push  H         
	mvi   B,03H     
L1A01H	ldax  D         
	push  D         
	call  L0FE9H    ; Convert A to uppercase
	mov   E,A       
	call  L0FE8H    ; Get char at M and convert to uppercase
	cmp   E         
	pop   D         
	jnz   L1A1FH    
	inx   D         
	inx   H         
	dcr   B         
	jnz   L1A01H    
	pop   H         
	mvi   A,07H     
	sub   C         
	sta   0F92BH     ; Day code (0=Sun), 1=Mon), etc.)
	jmp   L19B3H    ; Update clock chip from memory 0F923H
	
L1A1FH	inx   D         
	dcr   B         
	jnz   L1A1FH    
	pop   H         
	dcr   C         
	jnz   L19FEH    
	jmp   ERRSYN    ; Generate Syntax error
	
L1A2CH	rst   1         ; Compare next byte with M
    .db	0DDH             ; Test for '=' token ID
L1A2EH	call  BMEVAL    ; Main BASIC evaluation routine
	xthl            
	push  H         
	call  L19A0H    ; Update in-memory (0F923H) clock values
	call  L2916H    ; Get pointer to most recently used string (Len + address)
	mov   A,M       
	inx   H         
	mov   E,M       
	inx   H         
	mov   H,M       
	mov   L,E       
	CPI   08H       
	ret             
	
	
; ======================================================
; Get time string from command line
; ======================================================
L1A42H	call  L1A2CH    
	jnz   ERRSYN    ; Generate Syntax error
	xchg            
	pop   H         
	xthl            
	push  H         
	xchg            
	lxi   D,0F929H   ; Date (ones)
	call  L1A6AH    
	CPI   03H       
	jnc   ERRSYN    ; Generate Syntax error
	call  L1A6AH    
	rst   1         ; Compare next byte with M
    .db	3AH             ; Test for ':'
	call  L1A62H    
	rst   1         ; Compare next byte with M
    .db	3AH             ; Test for ':'
L1A62H	call  L1A6AH    
	CPI   06H       
	jnc   ERRSYN    ; Generate Syntax error
L1A6AH	dcx   D         
	mov   A,M       
	inx   H         
	SUI   30H       
	CPI   0AH       
	jnc   ERRSYN    ; Generate Syntax error
	ANI   0FH       
	stax  D         
	ret             
	
	
; ======================================================
; IPL statement
; ======================================================
BSIPL	jz    L1A96H    ; Erase current IPL program
	call  L1A2EH    
	ana   A         
	jz    L1A95H    
	CPI   0AH       
	jnc   L08DBH    ; Generate FC error
	mov   B,A       
	xchg            
	lxi   H,0FAAFH   ; Start of IPL filename
	call  L3469H    ; Move B bytes from (DE) to M with increment
	mvi   M,0DH     
	inx   H         
	mov   M,B       
	pop   H         
	ret             
	
L1A95H	pop   H         
	
; ======================================================
; Erase current IPL program
; ======================================================
L1A96H	xra   A         
	sta   0FAAFH     ; Start of IPL filename
	sta   0FAB0H     
	ret             
	
	
; ======================================================
; COM and MDM statements
; ======================================================
BSCOMM	push  H         
	lxi   H,0F944H   ; On Com flag
	jmp   L1AA9H    
	
L1AA5H	push  H         ; Preserve HL (BASIC string pointer) on stack
	lxi   H,0F947H   ; On Time flag
L1AA9H	call  L1AEAH    ; Determine argument (ON/OFF/STOP) for TIME$ statement
L1AACH	pop   H         ; Retore HL
	pop   PSW       ; POP return address from stack (we jump directly to BASIC loop)
	rst   2         ; Get next non-white char from M
	jmp   L0811H    ; Jump into BASIC execution loop
	
	
; ======================================================
; KEY() statement
; ======================================================
BSKEYB	call  L112EH    ; Evaluate expression at M-1
	dcr   A         ; Make key selection zero based
	CPI   08H       ; Test if FKey selection > 7 (zero based)
	jnc   L08DBH    ; Generate FC error
	mov   A,M       ; Get 1st byte of FKey string
	push  H         ; Preserve HL (BASIC string pointer) on stack
	call  L1AD4H    ; Process KEY() statement key number - KEY(x) ON/OFF/STOP
	jmp   L1AACH    ; Restore HL from stack, pop return address and jump to BASIC execution
	
	
; ======================================================
; KEY STOP/ON/OFF statements
; ======================================================
BSKYSO	push  H         ; Preserve HL (BASIC string pointer) to stack
	mvi   E,08H     ;
L1AC6H	push  D         
	push  PSW       
	call  L1AD4H    
	pop   PSW       
	pop   D         
	dcr   E         
	jnz   L1AC6H    
	jmp   L1AACH    ; Restore HL from stack, pop return address and jump to BASIC execution
	
L1AD4H	mvi   D,00H     ; Clear MSB of DE for index into KEY ON enabled table
	lxi   H,0F62FH   ; Load pointer to KEY ON enabled table
	dad   D         ; Index into KEY ON enabled table
	push  H         ; Push pointer to KEY ON enabled to stack
	lxi   H,0F947H   ; On Time flag
	dad   D         ; Add key number 3 times to index into ONx interrupt table
	dad   D         ; ... once for ON-x trigger flag, another for LSB of handler
	dad   D         ; ... and another for MSB of handler
	call  L1AEAH    ; Determine argument (ON/OFF/STOP) for TIME$ statement
	mov   A,M       ; Get trigger flag for this ONx interrupt
	ANI   01H       ; Test if this key was triggered
	pop   H         ; Restore pointer to KEY ON enabled table
	mov   M,A       ; Load code indicating if KEY ON enabled for this key
	ret             
	
	
; ======================================================
; Determine argument (ON/OFF/STOP) for TIME$ statement
; ======================================================
L1AEAH	CPI   97H       ; Load code for ON token
	jz    BSTMON    ; TIME$ ON statement
	CPI   0CBH       ; Load code for OFF token
	jz    BSTMOF    ; TIME$ OFF statement
	CPI   8FH       ; Load code for STOP token
	jz    BSTMST    ; TIME$ STOP statement
	jmp   ERRSYN    ; Generate Syntax error
	
	
; ======================================================
; Determine device (KEY/TIME/COM/MDM) for ON GOSUB
; ======================================================
L1AFCH	CPI   0ADH       ; Compare with value of COM token
	lxi   B,L0001H  ; Load value for COM/MDM device
	rz              ; Return if COM
	CPI   0AEH       ; Compare with value of MDM token
	rz              ; Return if MDM
	CPI   0AFH       ; Compare with value of KEY token
	lxi   B,L0208H  ; Load value for KEY device
	rz              ; Return if KEY
	CPI   0AAH       ; Compare with value for TIME$ token
	stc             ; Set C flag to indicate invalid device
	rnz             ; Return if not TIME$ token
	
; ======================================================
; ON TIME$ statement
; ======================================================
BSONTM	inx   H         ; Increment to next BASIC line text (Skip QUOTE perhaps?)
	call  L1A42H    ; Get time string from command line
	lxi   H,VONTMT  ; Time for ON TIME interrupt (SSHHMM)
	mvi   B,06H     ; Prepare to copy 6 bytes of string "SSMMHH"
	call  L3469H    ; Move B bytes from (DE) to M with increment
	pop   H         ; POP pointer to BASIC line string from stack
	dcx   H         ; Decrement pointer. Why?
	lxi   B,L0101H  ; Load value for TIME$ device
	ana   A         ; Clear C flag to indicate valid device
	ret             
	
	
; ======================================================
; ON COM handler
; ======================================================
L1B22H	push  H         ; Preserve HL on stack
	mov   B,A       ; Copy device number to B
	add   A         ; Multiply device number x2
	add   B         ; Multiply device number x3
	mov   L,A       ; Move device number x 3 to L for index into ON COM table
	mvi   H,00H     ; Clear MSB of index
	lxi   B,0F945H   ; On Com routine address
	dad   B         ; Index into ON COM/KEY/TIME$ interrupt table
	mov   M,E       ; Save LSB of line number to ON COM/KEY/TIME$ interrupt table
	inx   H         ; Increment to MSB of line number
	mov   M,D       ; Save MSB of line number to ON COM/KEY/TIME$ interrupt table
	pop   H         ; Restore HL
	ret             
	
	
; ======================================================
; RST 7.5 interrupt routine
; ======================================================
L1B32H	call  VTLINH    ; RST 7.5 RAM Vector
	push  H         ; \
	push  D         ; \ Save all registers on stack
	push  B         ; /
	push  PSW       ; /
	mvi   A,0DH     ; Prepare to re-enable RST 7.5 interrupt
	sim             ; Re-enable RST 7.5 interrupt
	ei              ; Re-enable interrupts
	lxi   H,VCLKTK   ; Load address of 2Hz count-down value
	dcr   M         ; Decrement the 2Hz count-down counter
	jnz   L1BAEH    ; Jump if not zero to skip 10Hz background logic
	mvi   M,7DH     ; Re-load count-down value for 2 Hz
	inx   H         ; Point to 6-second count-down counter (0F930H)
	dcr   M         ; Decrement 6-second count-down counter
	jnz   L1B65H    ; Jump if not zero to refresh from clock chip
	mvi   M,0CH     ; Re-load 6-second count-down value
	inx   H         ; Increment to power-down count-down
	push  H         ; Preserve HL on stack
	lhld  VBSCLN     ; Current executing line number
	inx   H         ; Prepare to check if BASIC is executing. Increment line #
	mov   A,H       ; Get MSB of line number in A
	ora   L         ; OR in LSB to test for zero (tests for 0FFFFH because of INX H)
	pop   H         ; Restore pointer to power-down count-down
	cnz   L1BB1H    ; Renew automatic power-off counter
	mov   A,M       ; Load current power-down count-down
	ana   A         ; Test if count-down is zero (disabled)
	jz    L1B65H    ; Skip power-down count-down if disabled
	dcr   M         ; Decrement power-down count-down (HL = 0F931H)
	jnz   L1B65H    ; Skip update of power-down enable flag if count != 0
	inx   H         ; Increment to power-down enable flag
	mvi   M,0FFH     ; Set power-down enable flag (HL = VPWROF)
L1B65H	lxi   H,0F933H   ; Seconds (ones)
	push  H         ; Push pointer to current time on stack
	call  L7329H    ; Copy clock chip regs to M
	pop   D         ; Get pointer to current time in DE
	lxi   H,VONTMT   ; Time for ON TIME interrupt (SSHHMM)
	mvi   B,06H     ; Prepare to compare 6 bytes of time to detect ON TIME interrupt
L1B72H	ldax  D         ; Load next byte of current time
	sub   M         ; Subtract ON TIME value
	jnz   L1B88H    ; Exit loop if it doesn't match
	inx   D         ; Increment to next byte of current time
	inx   H         ; Increment to next byte of ON TIME value
	dcr   B         ; Decrement byte counter
	jnz   L1B72H    ; Jump to test next byte if count != 0
	ora   M         ; Test if ON TIME already triggered (0F943H)
	jnz   L1B8CH    ; Jump to skip setting ON TIME interrupt if already triggered
	lxi   H,0F947H   ; On Time flag
	call  L3FD2H    ; Trigger interrupt. HL points to interrupt table
	mvi   A,0AFH     ; Create a MVI A,0AFH instruction using following byte.
	sta   0F943H     ; Save ON TIME interrupt indication (A has either 0AFH or zero)
L1B8CH	jmp   L1BABH    ; Different from m100, likely bug fix for year increase
	
L1B8FH	call  L20D5H    ; Load pointer to storage of last known month
	rz              ; Test if month changed from the last time
	CPI   0F0H       ; Update last known month with current month
	rnz             
	inr   A         
	ret             ; Point to Year (ones) to increment to increment the year
	
L1B98H	lhld  VCURLN    ; Cursor row (1-8)
	shld  VTMPHL    ; Load the 1's place of the year to test for roll-over to 10's
	lxi   H,L66E6H  ; Jump if not 10 to skip incrementing 10's place
	shld  VLJERR    ; Save new 1's place (A is now zero)
	jmp   L659BH    ; Get 10's place to test for century roll-over
	
L1BA7H	xra   A         ; Jump to skip update if not a new century
L1BA8H	jmp   BOOT      ; End different from m100
	
L1BABH	call  L7682H    ; Check for optional external controller
L1BAEH	jmp   L7391H    ; Jump to Cursor BLINK - Continuation of RST 7.5 Background hook
	
	
; ======================================================
; Renew automatic power-off counter
; ======================================================
L1BB1H	lda   VPROFT    ; Get Power down time (1/10ths of a minute)
	sta   0F931H     ; Update power-down count-down
	ret             
	
	
; ======================================================
; KEY statement
; ======================================================
BSKEY	CPI   0A5H       ; Load value of LIST token
	jnz   L1BF6H    ; Jump if not LIST to test for ON/OFF
	
; ======================================================
; KEY LIST statement
; ======================================================
BSKYLT	rst   2         ; Get next non-white char from M
	push  H         ; Preserve HL on stack
	lxi   H,0F789H   ; Function key definition area
	mvi   C,04H     ; Prepare to print 4 lines of FKey text, 2 per line
L1BC4H	call  L1BD3H    ; Print 1st FKey text for this line
	call  L1BD3H    ; Print 2nd FKey text for this line
	call  CRLF      ; Send CRLF to screen or printer
	dcr   C         ; Decrement line counter
	jnz   L1BC4H    ; Keep looping until count=0
	pop   H         ; Restore HL from stack
	ret             
	
L1BD3H	mvi   B,10H     ; Prepare to send 16 bytes of FKey text
	call  L1BE0H    ; Send B characters from M to the screen
	mvi   B,03H     ; Prepare to send 3 spaces
L1BDAH	rst   4         ; Send character in A to screen/printer
	dcr   B         ; Decrement counter
	jnz   L1BDAH    ; Loop until 3 spaces sent
	ret             
	
	
; ======================================================
; Send B characters from M to the screen
; ======================================================
L1BE0H	mov   A,M       ; Get next character from string
	CPI   7FH       ; Test for non-printable character
	jz    L1BEBH    ; Print SPACE for non-printable characters
	CPI   20H       ; Test if less than SPACE
	jnc   L1BEDH    ; Skip to print the character
L1BEBH	mvi   A,20H     ; Substitute a SPACE for non-printable characters
L1BEDH	rst   4         ; Send character in A to screen/printer
	inx   H         ; Increment to next byte to print
	dcr   B         ; Decrement byte counter
	jnz   L1BE0H    ; Send B characters from M to the screen
	mvi   A,20H     ; Leave a SPACE in A for return
	ret             
	
L1BF6H	CPI   28H       ; Test for '('
	jz    L1AB2H    ; KEY() statement
	CPI   97H       ; Test for OFF token
	jz    BSKYSO    ; KEY STOP/ON/OFF statements
	CPI   0CBH       ; Test for ON token
	jz    BSKYSO    ; KEY STOP/ON/OFF statements
	CPI   8FH       ; Test for STOP token
	jz    BSKYSO    ; KEY STOP/ON/OFF statements
	call  L112EH    ; Evaluate expression at M-1
	dcr   A         ; Decrement KEY number to make it zero based
	CPI   08H       ; Test if KEY number too big
	jnc   L08DBH    ; Generate FC error
	xchg            ; Save HL in DE
	mov   L,A       ; Prepare to multiply key number x16 (up to 16 bytes per key)
	mvi   H,00H     ; Make MSB of HL zero
	dad   H         ; x2
	dad   H         ; x4
	dad   H         ; x8
	dad   H         ; x16
	lxi   B,0F789H   ; Function key definition area
	dad   B         ; Index into function key definition area
	push  H         ; Save address to FKey text
	xchg            ; Restore HL (BASIC string pointer)
	rst   1         ; Compare next byte with M
    .db	2CH             ; ','
	call  BMEVAL    ; Main BASIC evaluation routine
	push  H         ; Save BASIC string pointer to stack
	call  L2916H    ; Get pointer to most recently used string (Len + address)
	mov   B,M       ; Get length of string for FKey
	inx   H         ; Increment to LSB of string address
	mov   E,M       ; Get LSB of string address
	inx   H         ; Increment to MSB of string address
	mov   D,M       ; Get MSB of string address
	pop   H         ; Retrieve BASIC string pointer from stack
	xthl            ; HL=string address, DE=BASIC string pointer
	mvi   C,0FH     ; Prepare to copy up to 15 bytes of string data (Need 1 byte for NULL)
	mov   A,B       ; Get length of string to set as FKey text
	ana   A         ; Test for zero length string
	jz    L1C48H    ; Jump if string length is zero to skip string copy
L1C38H	ldax  D         ; Get next byte of string from BASIC command string
	ana   A         ; Test for NULL in string (shouldn't happen)
	jz    L08DBH    ; Generate FC error
	mov   M,A       ; Save byte to FKey table
	inx   D         ; Increment to next byte of BASIC string
	inx   H         ; Increment to next byte of FKey table
	dcr   C         ; Decrement max string copy size
	jz    L1C4EH    ; Jump NULL terminate FKey string if max length reached
	dcr   B         ; Decrement length of source string from BASIC command line
	jnz   L1C38H    ; Jump to copy next string if not zero
L1C48H	mov   M,B       ; Zero out next byte of FKey text
	inx   H         ; Increment to next FKey text byte
	dcr   C         ; Decrement FKey string length count
	jnz   L1C48H    ; Keep zero'ing out FKey until count = 0
L1C4EH	mov   M,C       ; NULL terminate the FKey text
	call  FNKSB     ; Display function keys on 8th line
	call  L6C93H    ; Copy BASIC Function key table to key definition area
	pop   H         ; POP address of FKey text from stack.
	ret             
	
	
; ======================================================
; PSET statement
; ======================================================
BSPSET	call  L1D2EH    ; Get (X),Y) coordinate from tokenized string at M
L1C5AH	Rrc             
	push  H         
	push  PSW       
	cc    PLOT      ; Plot (set) point (D),E) on the LCD
	pop   PSW       
	cnc   UNPLOT    ; Clear (reset) point (D),E) on the LCD
	pop   H         
	ret             
	
	
; ======================================================
; PRESET statement
; ======================================================
BSPRST	call  L1D2EH    ; Get (X),Y) coordinate from tokenized string at M
	cma             
	jmp   L1C5AH    
	
	
; ======================================================
; LINE statement
; ======================================================
BSLINE	CPI   0D1H       ; Test for '-' token ID
	xchg            ; Save BASIC line pointer in DE
	lhld  VXPIXS    ; X coord of last point plotted
	xchg            ; Default to last coord in case of "LINE -(1,3)"
	cnz   L1D2EH    ; Get (X),Y) coordinate from tokenized string at M
	push  D         ; Save starting coords on stack
	rst   1         ; Compare next byte with M
    .db	0D1H             ; Test for '-' token ID
	call  L1D2EH    ; Get (X),Y) coordinate from tokenized string at M
	push  D         ; Save 2nd coord on stack
	lxi   D,PLOT    ; Load address of PSET routine to plot points
	jz    L1C94H    ; Skip test for option args if end of line
	push  D         ; Save address of routine to stack
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	call  L112EH    ; Evaluate expression at M-1
	pop   D         ; Restore address of plot routine
	Rrc             ; Rotate A to test for PSET or PRESET
	jc    L1C92H    ; If PSET selected, skip replacement of routine
	lxi   D,UNPLOT  ; Get address of PRESET routine
L1C92H	dcx   H         ; Rewind BASIC line pointer
	rst   2         ; Get next non-white char from M
L1C94H	xchg            ; Put PSET / PRESET address in HL
	shld  0F661H     ; Address last called
	xchg            ; Restore HL/DE
	jz    L1CD2H    ; Jump to draw line if optional args not present
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	rst   1         ; Compare next byte with M
    .db	42H             ; Test for 'B'
	jz    L1CBCH    ; Draw an unfilled box on LCD. Coords are on stack
	rst   1         ; Compare next byte with M
    .db	46H             ; Test for 'F'
	pop   D         
	
; ======================================================
; Draw a filled box on LCD. Coords are on stack
; ======================================================
	xthl            
	mov   A,E       
	sub   L         
	jnc   L1CAFH    
	cma             
	inr   A         
	mov   L,E       
L1CAFH	mov   B,A       
	inr   B         
L1CB1H	mov   E,L       
	call  L1CD9H    
	inr   L         
	dcr   B         
	jnz   L1CB1H    
	pop   H         
	ret             
	
	
; ======================================================
; Draw an unfilled box on LCD. Coords are on stack
; ======================================================
L1CBCH	pop   D         
	xthl            
	push  D         
	mov   E,L       
	call  L1CD9H    
	pop   D         
	push  D         
	mov   D,H       
	call  L1CD9H    
	pop   D         
	push  H         
	mov   H,D       
	call  L1CD9H    
	pop   H         
	mov   L,E       
	lxi   B,0E3D1H   ; Make POP D and XTHL look like LXI B,0E3D1H
	call  L1CD9H    
	pop   H         
	ret             
	
L1CD9H	push  H         
	push  D         
	push  B         
	mov   A,L       
	sub   E         
	jnc   L1CE4H    
	xchg            
	cma             
	inr   A         
L1CE4H	mov   B,A       
	mvi   C,14H     
	mov   A,H       
	sub   D         
	jnc   L1CEFH    
	cma             
	inr   A         
	inr   C         
L1CEFH	cmp   B         
	jc    L1CFAH    
	mov   H,A       
	mov   L,B       
	mvi   A,1CH     
	jmp   L1CFFH    
	
L1CFAH	mov   L,A       
	mov   H,B       
	mov   A,C       
	mvi   C,1CH     
L1CFFH	sta   0F663H     
L1D02H	mov   A,C       
	sta   0F665H     
	mov   B,H       
	inr   B         
	mov   A,H       
	ana   A         
	rar             
	mov   C,A       
L1D0CH	push  H         
	push  D         
	push  B         
	call  0F660H     
	pop   B         
	pop   D         
	pop   H         
	call  0F665H     
	mov   A,C       
	add   L         
	mov   C,A       
	jc    L1D22H    
	cmp   H         
	jc    L1D27H    
L1D22H	sub   H         
	mov   C,A       
	call  0F663H     
L1D27H	dcr   B         
	jnz   L1D0CH    
	jmp   L14EEH    ; POP BC, DE, HL from stack
	
	
; ======================================================
; Get (X),Y) coordinate from tokenized string at M
; ======================================================
L1D2EH	rst   1         ; Compare next byte with M
    .db	28H             ; Test for '('
	call  L112EH    ; Evaluate expression at M-1
	CPI   0F0H       ; Test if X coord > 240
	jnc   L08DBH    ; Generate FC error
	push  PSW       ; Save X coord
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	call  L112EH    ; Evaluate expression at M-1
	CPI   40H       ; Test if Y coord > 64
	jnc   L08DBH    ; Generate FC error
	pop   PSW       ; Pop X Coord from stack
	mov   D,A       ; Save X coord in D
	xchg            ; Put coords in HL for save
	shld  VXPIXS    ; X coord of last point plotted
	xchg            ; Restore HL/DE
	mov   A,M       ; Get next char from BASIC line
	CPI   29H       ; Test for ')'
	jnz   L1D54H    ; If not ')', jump to test PSET/PRESET arg
	rst   2         ; Get next non-white char from M
	mvi   A,01H     ; Default to PSET on
	ret             
	
L1D54H	push  D         ; Preserve DE on stack
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	call  L112EH    ; Evaluate expression at M-1
	rst   1         ; Compare next byte with M
    .db	29H             ; Test for ')'
	mov   A,E       ; Save PSET/PRESE value in A
	pop   D         ; Restore DE
	ret             
	
L1D5FH	call  L1112H    ; Evaluate expression at M
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	push  H         
	xchg            
	LDA   VACTcc    ; Active columns count (1-40)
	cma             
	inr   A         
	mov   C,A       
	mvi   B,0FFH     
	mov   E,B       
L1D6FH	inr   E         
	mov   D,L       
	dad   B         
	jc    L1D6FH    
	LDA   VACTcc    ; Active columns count (1-40)
	inr   D         
	cmp   D         
	jc    L08DBH    ; Generate FC error
	lda   VACTLC    ; Active rows count (1-8)
	inr   E         
	cmp   E         
	jc    L08DBH    ; Generate FC error
	xchg            
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	mov   A,H       
	dcr   A         
	sta   0F788H     ; Horiz. position of cursor (0-39)
	pop   H         
	ret             
	
	
; ======================================================
; CSRLIN function
; ======================================================
BFCSRL	push  H         
	lda   VCURLN    ; Cursor row (1-8)
	dcr   A         
L1D95H	call  L340AH    ; SGN function
	pop   H         
	rst   2         ; Get next non-white char from M
	ret             
	
	
; ======================================================
; MAX function
; ======================================================
BFMAX	rst   2         ; Get next non-white char from M
	CPI   9DH       ; Test for FILES Token ID
	jz    BFMAXF    ; MAXFILES function
	rst   1         ; Compare next byte with M
    .db	52H             ; Test for 'R'
	rst   1         ; Compare next byte with M
    .db	41H             ; Test for 'A'
	rst   1         ; Compare next byte with M
    .db	4DH             ; Test for 'M'
	
; ======================================================
; MAXRAM function
; ======================================================
BFMAXR	push  H         
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	02H             
	lxi   H,VSSYS   ; Active system signature -- Warm vs Cold boot
	call  L37DBH    ; Convert unsigned HL to single precision in FAC1
	pop   H         
	ret             
	
	
; ======================================================
; MAXFILES function
; ======================================================
BFMAXF	push  H         
	lda   0FC82H     ; Maxfiles
	jmp   L1D95H    
	
	
; ======================================================
; HIMEM function
; ======================================================
BFHMEM	push  H         ; Save BASIC line pointer to stack
	lhld  VHIMEM    ; HIMEM
	call  L37DBH    ; Convert unsigned HL to single precision in FAC1
	pop   H         ; Restore BASIC line pointer
	rst   2         ; Get next non-white char from M
	ret             
	
	
; ======================================================
; WIDTH statement
; ======================================================
BSWDTH	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	3AH             
	
; ======================================================
; SOUND statement
; ======================================================
BSSOUN	CPI   97H       ; Test for ON token ID
	jz    L1DE6H    ; SOUND ON statement
	CPI   0CBH       ; Test for OFF token ID
	jz    BSSNDO    ; SOUND OFF statement
	call  L1297H    ; Evaluate expression at M
	mov   A,D       ; Get MSB of fr.equency
	ANI   0C0H       ; Test for negative or > 16383
	jnz   L08DBH    ; Generate FC error
	push  D         ; Save fr.equency on stack
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	call  L112EH    ; Evaluate expression at M-1
	ana   A         ; Test for duration of zero
	mov   B,A       ; Save duration in B
	pop   D         ; Pop fr.equency from stack
	jnz   L72C5H    ; Produce a tone of DE freq and B duration
	ret             
	
	
; ======================================================
; SOUND OFF statement
; ======================================================
BSSNDO	mvi   A,0AFH     ; Makes 0AFH below look like MVI A,0AFH
	sta   0FF44H     ; Sound flag
	rst   2         ; Get next non-white char from M
	ret             
	
	
; ======================================================
; MOTOR statement
; ======================================================
BSMOTR	SUI   0CBH       
	jz    BSMROF    ; MOTOR OFF statement
	
; ======================================================
; MOTOR ON statement
; ======================================================
BSMRON	rst   1         ; Compare next byte with M
    .db	97H             ; Test for ON token ID
	dcx   H         
	mov   A,H       
	
; ======================================================
; MOTOR OFF statement
; ======================================================
BSMROF	mov   E,A       
	rst   2         ; Get next non-white char from M
	jmp   L7043H    ; Cassette REMOTE routine - turn motor on or off
	
	
; ======================================================
; CALL statement
; ======================================================
BSCALL	call  L1297H    ; Evaluate expression at M
	xchg            
	shld  0F661H     ; Address last called
	xchg            
	dcx   H         
	rst   2         ; Get next non-white char from M
	jz    L1E1BH    
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	CPI   2CH       
	jz    L1E14H    
	call  L112EH    ; Evaluate expression at M-1
	jz    L1E1BH    
L1E14H	push  PSW       
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	call  L1297H    ; Evaluate expression at M
	pop   PSW       
L1E1BH	push  H         
	xchg            
	call  0F660H     
	pop   H         
	ret             
	
	
; ======================================================
; SCREEN statement
; ======================================================
BSSCRN	CPI   2CH       ; Test if 1st byte of parameter is ','
	lda   VNCONF    ; New Console device flag
	cnz   L112EH    ; Evaluate expression at M-1
	call  L1E3CH    ; Process SCREEN number selection (0 or 1)
	dcx   H         ; Back command line pointer up to previous char
	rst   2         ; Get next non-white char from M
	rz              ; Return if no more arguments
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test if byte is ',' and return only if it is
	call  L112EH    ; Evaluate expression at M-1
	push  H         ; Save BASIC command line pointer to stack
	ana   A         ; Test if Label Line r.equested
	call  L13AFH    ; Erase or Display function key line based on Z flag
	pop   H         ; Restore BASIC command line pointer
	ret             
	
L1E3CH	push  H         ; Preserve HL on stack
	sta   VNCONF    ; New Console device flag
	ana   A         ; Test if New Console flag set
	lxi   D,L2808H  ; Load ROW,COL value for 8,40
	lhld  VCLNSA    ; Cursor row (1-8)
	mvi   A,0EH     ; Value of last column before wrap for PRINT ,
	jz    L1E52H    ; Jump over RST7 if not New Console Device
	xra   A         ; Clear New Console device flag
	sta   VNCONF    ; New Console device flag
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	3EH             ; SCREEN statement hook
L1E52H	shld  VCURLN    ; Cursor row (1-8)
	xchg            ; DE has active ROWS,COLS (for LCD or DVI)
	shld  VACTLC    ; Active rows count (1-8)
	sta   0F676H     ; Store value of column wrap for PRINT , (14 or 56 if 80 COL mode)
	pop   H         ; Restore HL from stack
	ret             
	
	
; ======================================================
; L1E5EH: LCOPY statement: Print contents of LCD
; Entry conditions: none
; Exit conditions:  none
; ======================================================
BSLCPY	push H
    	call L4BA0
    	lxi  H,VL1LCD   ; Start of LCD character buffer
    	mvi  E,08H
L1E67	mvi  D,28H
L1E69	mov  A,M
    	call PNOTAB     ; Output character to printer
    	inx  H
    	dcr  D
    	jnz  L1E69
    	call L4BA0
    	dcr  E
    	jnz  L1E67
    	pop  H
    	ret
	
; ======================================================
; Handle RUN "RAM:file" processing
; ======================================================
L1E7BH	push  H         
	call  L2146H    ; Update system pointers for .DO, .CO, vars, etc.
	lhld  VFNCBE     ; Get extension of current BASIC filename
	lxi   D,L2020H  ; Load ASCII " " in DE
	rst   3         ; Compare DE and HL
	push  PSW       
	jz    L1E91H    ; Jump if extension is blank to default to "BA"
	lxi   D,L4142H  ; Load ASCII "BA" in DE
	rst   3         ; Compare DE and HL
	jnz   L1EC7H    ; If not blank and not "BA", jump to deal with it
L1E91H	call  L20A6H    ; Copy "BA" extension to BASIC program and search for file
	jz    L1EC7H    ; Jump if file not found to deal with it
	pop   PSW       
	pop   B         
	pop   PSW       
	jz    L08DBH    ; Generate FC error
	mvi   A,00H     
	push  PSW       
	push  B         
	shld  0FA8CH     
	xchg            
	shld  VBASPP    ; Start of BASIC program pointer
	call  L05F0H    ; Update line addresses for current BASIC program
	pop   H         
	mov   A,M       
	CPI   2CH       
	jnz   L1EBAH    
	rst   2         ; Get next non-white char from M
	rst   1         ; Compare next byte with M
    .db	52H             ; Test for 'R'
	pop   PSW       
	mvi   A,80H     
	stc             
	push  PSW       
L1EBAH	pop   PSW       
	sta   0FCA7H     
	jc    L3F28H    ; Initialize BASIC Variables for new execution
	call  L3F28H    ; Initialize BASIC Variables for new execution
	jmp   L0502H    ; Vector to BASIC ready - print Ok
	
L1EC7H	pop   PSW       
	pop   H         
	mvi   D,0F8H     ; Load device ID for RAM
	jnz   L4D8DH    ; Jump into RUN statement
	push  H         
	lxi   H,L2020H  ; Load ASCII " " extension in HL
	shld  VFNCBE     ; Save Extension in current BASIC filename
	pop   H         
	jmp   L4D8DH    ; Jump into RUN statement
	
L1ED9H	push  H         
	lhld  VFNCBE     ; Load extention of current BASIC filename
	lxi   D,L4F44H  ; Load ASCII "DO" extension in DE
	rst   3         ; Compare DE and HL
	mvi   B,00H     
	jz    L1EF8H    
	lxi   D,L4142H  ; Load ASCII "BA" extension in DE
	rst   3         ; Compare DE and HL
	mvi   B,01H     
	jz    L1EF8H    
	lxi   D,L2020H  ; Load ASCII " " extension in DE
	rst   3         ; Compare DE and HL
	mvi   B,02H     
	jnz   L504EH    ; Generate NM error
L1EF8H	pop   H         
	push  B         
	dcx   H         
L1EFBH	rst   2         ; Get next non-white char from M
	jz    L1F10H    
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	rst   1         ; Compare next byte with M
    .db	41H             ; Test for 'A'
	pop   B         
	dcr   B         
	jz    L504EH    ; Generate NM error
L1F08H	xra   A         
	lxi   D,0F802H   
	push  PSW       
	jmp   L4E0BH    
	
L1F10H	pop   B         
	dcr   B         
	jm    L1F08H    
	call  L2081H    ; Test if an unsaved BASIC program exists
	jnz   L08DBH    ; Generate FC error
	call  L20A6H    ; Copy "BA" extension to BASIC program and search for file
	cnz   L2017H    
	call  L2146H    ; Update system pointers for .DO, .CO, vars, etc.
L1F24H	call  L20E4H    
	shld  0FA8CH     ; Mark Active BASIC program
	mvi   A,80H     
	xchg            
	lhld  VBASPP    ; Start of BASIC program pointer
	xchg            
	call  L2239H    ; Save new entry to Catalog
	call  L21D4H    
	jmp   L0502H    ; Vector to BASIC ready - print Ok
	
	
; ======================================================
; FILES statement
; ======================================================
BSFILS	push  H         ; Save BASIC execution pointer to stack
	call  L1F42H    ; Display Catalog
	pop   H         ; Retriev BASIC execution pointer from stack
	jmp   L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	
	
; ======================================================
; Display Catalog
; ======================================================
L1F42H	lxi   H,0F957H   ; Load address of RAM Catalog (-1 entry, or 11 bytes)
L1F45H	mvi   C,03H     ; Initialize to 3 entries per line
	LDA   VACTcc    ; Active columns count (1-40)
	CPI   28H       ; Test if 40-column SCREEN mode
	jz    L1F51H    ; Jump if 40-column mode
	mvi   C,06H     ; Change to 6 enries per line for 80-col mode
L1F51H	call  L20D5H    ; Find next Non-Empty catalog entry
	rz              ; Return if all entries displayed
	ANI   18H       ; Test file mode bits for invisible, etc.
	jnz   L1F51H    ; Skip this entry if it is invisible
	push  H         ; Save pointer to start of this entry in catalog
	inx   H         ; Skip File type byte
	mov   E,M       ; Get LSB of pointer to file
	inx   H         ; Advance to MSB
	mov   D,M       ; Get MSB of pointer to file
	inx   H         ; Advance to filename
	push  D         ; Push file address to stack
	mvi   B,06H     ; Preapre to print 6 characters
L1F63H	mov   A,M       ; Get next character to display
	rst   4         ; Send character in A to screen/printer
	inx   H         ; Increment pointer
	dcr   B         ; Decrement counter
	jnz   L1F63H    ; Jump to display all 6 bytes
	mvi   A,2EH     ; Load ASCII '.'
	rst   4         ; Send character in A to screen/printer
	mov   A,M       ; Get 1st Extension byte
	rst   4         ; Send character in A to screen/printer
	inx   H         ; Point to 2nd extension byte
	mov   A,M       ; Get 2nd extension byte
	rst   4         ; Send character in A to screen/printer
	pop   D         ; Pop file address from stack
	lhld  VBASPP    ; Start of BASIC program pointer
	rst   3         ; Compare DE and HL
	mvi   A,2AH     ; For active BASIC program, display a '*'
	mvi   B,20H     ; Load ASCII space
	jz    L1F7FH    ; If active BASIC entry, skip to keep the '*'
	mov   A,B       ; Replace '*' with space if not active entry
L1F7FH	rst   4         ; Send character in A to screen/printer
	mov   A,B       ; Get space in A`
	rst   4         ; Send character in A to screen/printer
	rst   4         ; Send character in A to screen/printer
	pop   H         ; Restore pointer to current catalog entry
	dcr   C         ; Decrement entry per line counter
	jnz   L1F51H    ; Jump to display next entry on this line
	call  CRLF      ; Send CRLF to screen or printer
	call  L13F3H    ; Test for CTRL-C or CTRL-S to cancel listing
	jmp   L1F45H    ; Jump to reload entries per line counter
	
	
; ======================================================
; KILL statement
; ======================================================
BSKILL	call  L207AH    ; Parse filename for device and default to RAM
	dcx   H         
	rst   2         ; Get next non-white char from M
	jnz   ERRSYN    ; Generate Syntax error
	mov   A,D       
	CPI   0F8H       
	jz    L1FA1H    
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	58H             
L1FA1H	push  H         
	xra   A         
	sta   0FCA7H     
	call  L4E22H    
	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	call  L20AFH    
	jz    L5057H    ; Generate FF error
	mov   B,A       
	ANI   20H       
	jnz   L1FDAH    
	mov   A,B       
	ANI   40H       
	jz    L2005H    
	
; ======================================================
; Kill a text file
; ======================================================
	mvi   A,0E5H     ; Make "PUSH H" look like "MVI A,0E5H" for pass-thru
	lxi   B,0000H   ; Set deletion length to zero
	mov   M,C       ; Zero out (HL). Why?
	mov   L,E       ; Copy LSB of DE to HL
	mov   H,D       ; Copy MSB of DE to HL.
L1FC6H	ldax  D         ; Load next byte of DO file to test for EOF
	inx   D         ; Increment to next byte
	inx   B         ; Increment length of deletion count
	CPI   1AH       ; Test if at end of DO file
	jnz   L1FC6H    ; Jump to test next byte until EOF
	call  L6B9FH    ; Delete BC characters at M
L1FD1H	call  L18DDH    
	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	pop   H         ; Restore HL from stack
	ret             
	
L1FD9H	push  H         
L1FDAH	mvi   M,00H     
	lhld  VPSCOF     ; Start of CO files pointer
	push  H         
	xchg            
	push  H         
	inx   H         
	inx   H         
	mov   C,M       
	inx   H         
	mov   B,M       
	lxi   H,L0006H  
	dad   B         
	mov   B,H       
	mov   C,L       
	pop   H         
	call  L6B9FH    ; Delete BC characters at M
	pop   H         
	shld  VPSCOF     ; Start of CO files pointer
	jmp   L1FD1H    
	
L1FF8H	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	lhld  0F9B0H     
	xchg            
	lxi   H,0F9AFH   
	jmp   L1FBFH    ; Kill a text file
	
L2005H	push  H         
	lhld  VBASPP    ; Start of BASIC program pointer
	rst   3         ; Compare DE and HL
	pop   H         
	jz    L08DBH    ; Generate FC error
	call  L2017H    
	call  L3F2CH    ; Initialize BASIC Variables for new execution
	jmp   L0502H    ; Vector to BASIC ready - print Ok
	
L2017H	mvi   M,00H     
	lhld  VBASPP    ; Start of BASIC program pointer
	rst   3         ; Compare DE and HL
	push  PSW       
	push  D         
	call  L05F4H    ; Update line addresses for BASIC program at (DE)
	pop   D         
	inx   H         
	call  L2134H    ; Delete bytes between HL and DE
	push  B         
	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	pop   B         
	pop   PSW       
	rz              
	rc              
	lhld  VBASPP    ; Start of BASIC program pointer
	dad   B         
	shld  VBASPP    ; Start of BASIC program pointer
	ret             
	
	
; ======================================================
; NAME statement
; ======================================================
BSNAME	call  L207AH    ; Parse filename for device and default to RAM
	push  D         ; Save device ID to stack
	call  L224CH    ; Swap filenames in current BASIC and last loaded from tape
	rst   1         ; Compare next byte with M
    .db	41H             ; Test for 'A'
	rst   1         ; Compare next byte with M
    .db	53H             ; Test for 'S'
	call  L207AH    ; Parse filename for device and default to RAM
	mov   A,D       
	pop   D         
	cmp   D         
	jnz   L08DBH    ; Generate FC error
	CPI   0F8H       
	jz    L2052H    
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	5AH             
L2052H	push  H         
	call  L20AFH    
	jnz   L08DBH    ; Generate FC error
	call  L224CH    ; Swap filenames in current BASIC and last loaded from tape
	call  L20AFH    
	jz    L5057H    ; Generate FF error
	push  H         
	lhld  VFNCBE     ; Load extension from current BASIC program
	xchg            
	lhld  0FCA2H     
	rst   3         ; Compare DE and HL
	jnz   L08DBH    ; Generate FC error
	pop   H         
	call  L224CH    ; Swap filenames in current BASIC and last loaded from tape
	inx   H         
	inx   H         
	inx   H         
	call  L2241H    
	pop   H         
	ret             
	
L207AH	call  L4C0FH    ; Evaluate arguments to RUN/OPEN/SAVE commands
	rnz             ; Return if device specified
	mvi   D,0F8H     ; Load device ID for RAM device
	ret             
	
L2081H	lhld  0FA8CH     ; Get address of acive program or 0F999H (unsaved)
	lxi   D,0F999H   ; Test for "unsaved BASIC" program marker
	rst   3         ; Compare DE and HL
	ret             
	
L2089H	lxi   B,L434FH  ; Load ASCII "DO" into BC
	jmp   L20A9H    ; Copy BC to current BASIC program ext and search for file
	
L208FH	lhld  VFNCBE     ; Load HL with 2 extension bytes from current BASIC program
	lxi   D,L2020H  ; Load DE with two spaces
	rst   3         ; Compare DE and HL
	jz    L20A0H    ; Jump ahead if filename extension is " "
	lxi   D,L4F44H  ; Load DE with filename extension "DO"
	rst   3         ; Compare DE and HL
	jnz   L504EH    ; Generate NM error
L20A0H	lxi   B,L444FH  ; Put "DO" filename extension in BC
	jmp   L20A9H    ; Copy BC to current BASIC program ext and search for file
	
L20A6H	lxi   B,L4241H  
L20A9H	lxi   H,VFNCBE   ; Get pointer to current BASIC filename extension
	mov   M,B       ; Save B in 1st extension byte
	inx   H         ; Increment pointer
	mov   M,C       ; Save C in 2nd extension byte
L20AFH	lxi   H,0F957H   ; Load address of RAM Catalog (-1 entry, or 11 bytes)
	mvi   A,0E1H     ; Make POP H below look like MVI A,0E1H
	call  L20D5H    ; Find next Non-Empty catalog entry
	rz              ; Return if no entries available
	push  H         ; Save address of catalog entry
	inx   H         ; Point to address LSB
	inx   H         ; Point to address MSB
	lxi   D,VBASEF  ; Load address of current BASIC filename - 1
	mvi   B,08H     ; Load lenght of filename (base + ext)
L20C0H	inx   D         ; Increment to next byte of BASIC filename
	inx   H         ; Increment to next byte of catalog filename
	ldax  D         ; Load byte from BASIC filename storage
	cmp   M         ; Compare with next byte in catalog
	jnz   L20B3H    ; Jump to test next entry if they don't match
	dcr   B         ; Decrement filename length
	jnz   L20C0H    ; Loop for all bytes
	pop   H         ; Pop HL from stack
	mov   A,M       ; Get file type in A
	inx   H         ; Increment to LSB of file address
	mov   E,M       ; Get file address in DE
	inx   H         ; Point to MSB
	mov   D,M       ; Get MSB
	dcx   H         ; Point back to start of catalog entry
	dcx   H         ; ...
	ana   A         ; Test for zero file type
	ret             
	
L20D5H	push  B         ; Preserve BC on stack
	lxi   B,L000BH  ; Load offset to next Catalog entry
	dad   B         ; Advance pointer to next Catalog entry
	pop   B         ; Restore BC from stack
	mov   A,M       ; Get Catalog file type byte
	CPI   0FFH       ; Test for 0FFH termination marker
	rz              ; Return if at end of Directory
	ana   A         ; Test if entry is empty (MSB zero = empty)
	jp    L20D5H    ; Jump to test next entry in Catalog if empty
	ret             
	
L20E4H	lda   0F651H     ; In TEXT because of BASIC EDIT flag
	ana   A         
	lxi   H,0F9AFH   
	rnz             
	lxi   H,0F9AFH   
	lxi   B,L000BH  
L20F2H	dad   B         
	mov   A,M       
	CPI   0FFH       
	jz    L5066H    ; Generate FL error
	add   A         
	jc    L20F2H    
	ret             
	
	
; ======================================================
; NEW statement
; ======================================================
BSNEW	rnz             
L20FFH	call  L2081H    ; Test if an unsaved BASIC program exists
	cnz   L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	lxi   H,0F999H   ; Load marker for "Unsaved BASIC program"
	shld  0FA8CH     ; Save as active BASIC program
	lhld  VBASNS    ; BASIC program not saved pointer
	shld  VBASPP    ; Start of BASIC program pointer
	xra   A         ; Prepare to zero out BASIC program not savedpointer
	mov   M,A       ; Zero LSB of BASIC program not saved
	inx   H         ; Increment to MSB
	mov   M,A       ; Zero out MSB of BASIC program not saved
	inx   H         ; Point to next byte beyond (now) empty BASIC program
	xchg            ; Put address beyond empty BASIC program in DE
	lhld  VPSDOF     ; Start of DO files pointer
	call  L2134H    ; Call routine to delete bytes between last BASIC program and DO files
	lhld  VPRINP     
	dad   B         
	shld  VPRINP     
	lxi   H,0FFFFH   ; Load code to indicate no paste operation in progress
	shld  0F62EH     ; Save as index into paste buffer of "active paste operation"
	jmp   L3F28H    ; Initialize BASIC Variables for new execution
	
L212DH	lhld  0FABAH     ; Address where last BASIC list started
	xchg            
	lhld  0FABCH     
L2134H	mov   A,L       ; Prepare to calc LSB of length to delete
	sub   E         ; Calculate LSB of delete length
	mov   C,A       ; Save LSB in BC
	mov   A,H       ; Prepare to calc MSB of delete length
	sbb   D         ; Calculate MSB of delete length
	mov   B,A       ; Save MSB in BC
	xchg            ; Put lower address in HL for the delete
	call  L6B9FH    ; Delete BC characters at M
	lhld  VPSDOF     ; Start of DO files pointer
	dad   B         ; Update Start of DO files pointer by delete length
	shld  VPSDOF     ; Start of DO files pointer
	ret             
	
	
; ======================================================
; Update system pointers for .DO), .CO), vars), etc.
; ======================================================
L2146H	xra   A         ; Mark type of file being searched as "BA" (BA=0, DO=1, CO=2)
	call  L6C42H    ; Different from M1002
	lhld  0FAC0H     ; Lowest RAM address used by system
	inx   H         ; Increment Lowest RAM address used by system
L214EH	push  H         ; And save it to the stack
	lxi   H,0F98EH   ; Point to first Catalog Entry past ROM programs (-1 entry)
	lxi   D,0FFFFH   ; Initialize "Min address" to 0FFFFH
L2155H	call  L1B8FH    ; Different from M1002
	jz    L2175H    ; Exit loop if at end of Catalog
	Rrc             ; Get LSB of Catalog entry type into C flag
	jc    L2155H    ; Jump to get next entry if LSB of file type is set - skip these.
	push  H         ; Preserve starting address of this entry on stack
	inx   H         ; Increment to LSB of the file's address
	mov   A,M       ; Get LSB of catalog file's address
	inx   H         ; Increment to MSB of address
	mov   H,M       ; Get MSB of file's address
	mov   L,A       ; Move LSB to HL for comparison
	rst   3         ; Compare DE and HL
	pop   H         ; Restore pointer to catalog entry
	jnc   L2155H    ; Test if HL < DE (find lowest file address)
	mov   B,H       ; Save address of file with lowest address in BC
	mov   C,L       ; Save LSB too
	inx   H         ; Increment past file type to get file's address into DE
	mov   E,M       ; Get LSB of file's address
	inx   H         ; Increment to MSB
	mov   D,M       ; Get MSB of file's address
	dcx   H         ; Decrement back to LSB of address
	dcx   H         ; Decrement back to start of Catalog entry
	jmp   L2155H    ; Jump to test if next file has a lower address
	
L2175H	mov   A,E       ; Get LSB of lowest RAM file address
	ana   D         ; AND with MSB to test for 0FFFFH
	inr   A         ; Increment to complete the test
	pop   D         ; Pop lowest RAM address used by system from stack
	jz    L218DH    ; If 0FFFFH, Clear LSB of File Type byte for all Catalog entries.
	mov   H,B       ; Get pointer to Catalog entry with lowest RAM address
	mov   L,C       ; Get LSB too
	mov   A,M       ; Get the file type byte for that entry
	ORI   01H       ; Set the LSB of the file type byte
	mov   M,A       ; And write it back to the catalog. What are we marking here, the fact it is lowest?
	inx   H         ; Increment to the file's address LSB
	mov   M,E       ; Get LSB of that file
	inx   H         ; Increment to MSB of the address
	mov   M,D       ; Get MSB of the file's address
	xchg            ; HL = Address of file, DE = address of Catalog entry for the file
	call  L219AH    ; Advance HL past end of current file based on type
	jmp   L214EH    ; Jump to process next file
	
L218DH	lxi   H,0F957H   ; Load address of RAM Catalog (-1 entry, or 11 bytes)
L2190H	call  L20D5H    ; Find next Non-Empty catalog entry
	rz              ; Return if empty catalog entry
	ANI   0FEH       ; Clear LSB of Catalog entry type
	mov   M,A       ; Save modified Catalog entry type
	jmp   L2190H    ; Jump to find next catalog entry
	
L219AH	lda   0F809H     ; Load type of files being processed (BA, DO, CO)
	dcr   A         ; Test type being processed
	jm    L21C2H    ; Jump if BA (BA=0)
	jz    L21AEH    ; Jump if DO (DO=1)
	inx   H         ; Skip LSB of load address of CO file
	inx   H         ; Skip MSB of load address of CO file
	mov   E,M       ; Get LSB of length of CO file
	inx   H         ; Increment to MSB of length
	mov   D,M       ; Get MSB of length of CO file
	inx   H         ; Increment to LSB of entry of CO file
	inx   H         ; Increment to MSB of entry
	inx   H         ; Increment again to get past end of file
	dad   D         ; Offset to end of file by adding length
	ret             
	
L21AEH	mvi   A,1AH     ; Load End-Of-File marker
L21B0H	cmp   M         ; Test if at end of file
	inx   H         ; Increment to next byte in file
	jnz   L21B0H    ; Loop until EOF marker found
	xchg            ; Save HL in DE
	lhld  VPSCOF     ; Start of CO files pointer
	xchg            ; Restore HL
	rst   3         ; Compare DE and HL
	rnz             ; Return if not at end of DO file space
	mvi   A,02H     ; At end of DO. Change type to CO
	sta   0F809H     ; And store it
	ret             
	
L21C2H	xchg            ; Move file pointer HL to DE
	call  L05F4H    ; Update line addresses for BASIC program at (DE)
	inx   H         ; Increment to next file
	xchg            ; Store HL in DE
	lhld  VPSDOF     ; Start of DO files pointer
	xchg            ; Restore HL from DE
	rst   3         ; Compare DE and HL
	rnz             ; Return if not at end of BASIC file space
	mvi   A,01H     ; Indicate we are now in DO file space
	sta   0F809H     ; And save it
	ret             
	
L21D4H	lhld  VPSVAR     ; Start of variable data pointer
	shld  VARRTP     ; Start of array table pointer
	shld  VPFREM     ; Unused memory pointer
	lhld  VPSDOF     ; Start of DO files pointer
	dcx   H         
	shld  VBASNS     ; BASIC program not saved pointer
	inx   H         
	lxi   B,L0002H  
	xchg            
	call  L6B7FH    
	xra   A         
	mov   M,A       
	inx   H         
	mov   M,A       
	lhld  VPSDOF     ; Start of DO files pointer
	dad   B         
	shld  VPSDOF     ; Start of DO files pointer
	jmp   L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	
	
; ======================================================
; Count length of string at M
; ======================================================
L21FAH	push  H         
	mvi   E,0FFH     
L21FDH	inr   E         
	mov   A,M       
	inx   H         
	ana   A         
	jnz   L21FDH    
	pop   H         
	ret             
	
	
; ======================================================
; Get .DO filename and locate in RAM directory
; ======================================================
L2206H	call  L21FAH    ; Count length of string at M
	call  L4C0BH    
	jnz   ERRSYN    ; Generate Syntax error
	
; ======================================================
; Open a text file at (VFNCBP)
; ======================================================
L220FH	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	call  L208FH    ; Find .DO or ." " file in catalog
	xchg            
	stc             
	rnz             
	call  L20E4H    
	push  H         
	lhld  VPSDOF     ; Start of DO files pointer
	push  H         
	mvi   A,1AH     
	call  L6B61H    ; Insert A into text file at M
	jc    L3F17H    ; Reinit BASIC stack and generate OM error
	pop   D         
	pop   H         
	push  H         
	push  D         
	mvi   A,0C0H     
	dcx   D         
	call  L2239H    ; Save new entry to Catalog
	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	pop   H         
	pop   D         
	ana   A         
	ret             
	
	
; ======================================================
; Save new entry to Catalog
; ======================================================
L2239H	push  D         
	mov   M,A       
	inx   H         
	mov   M,E       
	inx   H         
	mov   M,D       
	inx   H         
	mvi   A,0D5H     
	lxi   D,VFNCBP  ; Filename of current BASIC program
	mvi   B,08H     
	call  L3469H    ; Move B bytes from (DE) to M with increment
	pop   D         
	ret             
	
L224CH	push  H         ; Preserve HL on stack
	mvi   B,09H     ; Swap 9 bytes of filename
	lxi   D,VFNCBP  ; Filename of current BASIC program
	lxi   H,VFNLFT  ; Filename of last program loaded from tape
L2255H	mov   C,M       ; Get byte from loaded from tape buffer
	ldax  D         ; Get byte from current BASIC program buffer
	mov   M,A       ; \
	mov   A,C       ; Swap the bytes
	stax  D         ; /
	inx   D         ; Increment both pointers
	inx   H         
	dcr   B         ; Decrement the loop counter
	jnz   L2255H    ; Jump to swap all 9 bytes
	pop   H         ; Restore HL from stack
	ret             
	
L2262H	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	lxi   H,0FFFFH   ; Load code to indicate no paste operation in progress
	shld  0F62EH     ; Save as index into paste buffer of "active paste operation"
	mov   B,H       
	mov   C,L       
	lhld  VPSTBP     ; Start of Paste Buffer
	push  H         
	mvi   A,1AH     
L2273H	cmp   M         
	inx   B         
	inx   H         
	jnz   L2273H    
	pop   H         
	call  L6B9FH    ; Delete BC characters at M
	jmp   L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	
	
; ======================================================
; CSAVE statement
; ======================================================
BSCSAV	CPI   4DH       ; Test next byte is "M"
	jz    BSCSVM    ; CSAVEM statement
	call  L25FCH    ; Validate or default to "CAS" devce for CSAVE/CSAVEM
L2288H	dcx   H         ; Rewind BASIC line pointer
	rst   2         ; Get next non-white char from M
	jz    L2298H    ; If no more arguments, jump to save as tokenized
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	rst   1         ; Compare next byte with M
    .db	41H             ; Test for 'A'
	mvi   E,02H     ; Load DCB index for CAS so LIST will print to cassette
	ana   A         ; Clear the carry bit
	push  PSW       ; And push it to the stack
	jmp   L4E0BH    ; Jump to open a device and perform a LIST
	
L2298H	call  L05F0H    ; Update line addresses for current BASIC program
	xchg            ; Put address of end of BASIC program in DE
	lhld  VBASPP    ; Start of BASIC program pointer
	mov   A,E       ; Start calculation for length of BASIC program
	sub   L         ; Subtract starting address LSB
	mov   L,A       ; Save LSB difference in L
	mov   A,D       ; Get MSB of end of BASIC program
	sbb   H         ; Subtract MSB of beginning
	mov   H,A       ; Save MSB of difference in H
	dcx   H         ; Decrement the length
	mov   A,H       ; Prepare to test for zero length
	ora   L         ; OR in LSB to test for zero length
	jz    L0501H    ; Pop stack and vector to BASIC ready
	shld  VTPLEN     ; Length of last program loaded/saved to tape
	push  H         ; Save length on Stack
	call  L260BH    ; Open CAS for output of BASIC files
	call  L2648H    ; Write 8DH data packet header to TAPE
	pop   D         
	lhld  VBASPP    ; Start of BASIC program pointer
	
; ======================================================
; Save buffer at M to tape
; ======================================================
L22B9H	mvi   C,00H     ; Clear the checksum
L22BBH	mov   A,M       ; Get next byte to send
	call  L14C1H    ; Write byte to tape & update checksum
	inx   H         ; Increment pointer
	dcx   D         ; Decrement count
	mov   A,D       ; Get MSB of count
	ora   E         ; OR in LSB of count
	jnz   L22BBH    ; Jump to send all bytes until zero
	call  L2635H    ; Write checksum to TAPE
	jmp   L0501H    ; Pop stack and vector to BASIC ready
	
	
; ======================================================
; SAVEM statement
; ======================================================
BSSAVM	rst   2         ; Get next non-white char from M
	call  L207AH    ; Parse filename for device and default to RAM
	mov   A,D       ; Put device ID in A
	CPI   0FDH       ; Test for "CAS" device
	jz    L22E1H    ; Jump to CSAVEM code if "CAS" specified
	CPI   0F8H       ; Test for "RAM" device
	jz    L22F4H    ; Jump to save to RAM if "RAM" specified
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	5CH             ; Go test for special device name handling
	
; ======================================================
; CSAVEM statement
; ======================================================
BSCSVM	rst   2         ; Get next non-white char from M
	call  L25FCH    ; Validate or default to "CAS" devce for CSAVE/CSAVEM
L22E1H	call  L2346H    ; Process SAVEM Arguments
	call  L2611H    ; Open CAS for output of CO files
	call  L2648H    ; Write 8DH data packet header to TAPE
	lhld  VTPLEN    ; Length of last program loaded/saved to tape
	xchg            
	lhld  VADCOH    ; 'Load address' of current program
	jmp   L22B9H    ; Save buffer at M to tape
	
L22F4H	call  L2346H    ; Process SAVEM Arguments
	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	call  L2089H    ; Add .DO extension to filename and search catalog for match
	cnz   L1FD9H    
	call  L20E4H    
	push  H         
	lhld  VPSCOF     ; Start of CO files pointer
	push  H         
	lhld  VTPLEN    ; Length of last program loaded/saved to tape
	mov   A,H       ; Test for zero length file
	ora   L         ; OR in LSB to test for zero
	jz    L3F17H    ; Reinit BASIC stack and generate OM error
	push  H         
	lxi   B,L0006H  
	dad   B         
	mov   B,H       
	mov   C,L       
	lhld  VPSVAR     ; Start of variable data pointer
	shld  0FB99H     ; Address of last variable assigned
	cnc   L6B6DH    ; Insert BC spaces at M
	jc    L3F17H    ; Reinit BASIC stack and generate OM error
	xchg            
	lxi   H,VADCOH   ; 'Load address' of current program
	call  L2540H    ; Copy 6 bytes from (DC) to (HL)
	lhld  VADCOH     ; 'Load address' of current program
	pop   B         
	call  L6BDBH    ; Move BC bytes from M to (DE) with increment
	pop   H         
	shld  VPSCOF     ; Start of CO files pointer
	pop   H         
	mvi   A,0A0H     
	xchg            
	lhld  0FB99H     ; Address of last variable assigned
	xchg            
	call  L2239H    ; Save new entry to Catalog
	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	jmp   L0502H    ; Vector to BASIC ready - print Ok
	
	
; ======================================================
; Process SAVEM Arguments
; ======================================================
L2346H	call  L2372H    ; Call routine to process ",arg"
	push  D         ; Save argument on stack - begin address
	call  L2372H    ; Call routine to process ",arg"
	push  D         ; Save argument on stack - end address
	dcx   H         ; Rewind BASIC line pointer to test for ','
	rst   2         ; Get next non-white char from M
	lxi   D,0000H   ; Set execution address to NULL
	cnz   L2372H    ; Call routine to process ",arg" if provided
	dcx   H         ; Rewind BASIC line pointer
	rst   2         ; Get next non-white char from M
	jnz   ERRSYN    ; Generate Syntax error
	xchg            ; Put execute address in HL
	shld  0FAD2H     ; Save exec address in TAPE header buffer
	pop   D         ; Pop end address
	pop   H         ; Pop start address
	shld  VADCOH     ; 'Load address' of current program
	mov   A,E       ; Prepare to calculate length of CO file
	sub   L         ; Subtract LSB of start from LSB of end
	mov   L,A       ; Save LSB of length in L
	mov   A,D       ; Get MSB of end of CO
	sbb   H         ; Subtract MSB of start of CO
	mov   H,A       ; Save MSB of length in H
	jc    L08DBH    ; Generate FC error
	inx   H         ; Increment length
	shld  VTPLEN     ; Length of last program loaded/saved to tape
	ret             
	
L2372H	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	jmp   L1297H    ; Evaluate expression at M
	
	
; ======================================================
; CLOAD statement
; ======================================================
BSCLOD	CPI   4DH       ; Test for 'M' character
	jz    BSCLDM    ; CLOADM statement
	CPI   0A3H       ; Test for PRINT token ID
	jz    L2456H    ; If "CLOAD PRINT", jump to compare TAPE file with RAM file
	call  L25E7H    ; Evaluate arguments to CLOAD/CLOADM & Clear current BASIC program
	ORI   0FFH       
	push  PSW       
L2387H	pop   PSW       
	push  PSW       
	jnz   L2391H    
	dcx   H         
	rst   2         ; Get next non-white char from M
	jnz   L08DBH    ; Generate FC error
L2391H	dcx   H         
	rst   2         ; Get next non-white char from M
	mvi   A,00H     
	stc             
	cmc             
	jz    L23A6H    
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	rst   1         ; Compare next byte with M
    .db	52H             ; Test for 'R' (RUN option)
	jnz   ERRSYN    ; Generate Syntax error
	pop   PSW       
	stc             
	push  PSW       
	mvi   A,80H     
L23A6H	push  PSW       
	sta   0FCA7H     
L23AAH	call  L2667H    ; Read file header from tape
	CPI   0D3H       ; Test for tokenized BASIC file tag
	jz    L23BDH    ; Jump to load tokenized BASIC
	CPI   9CH       ; Test for ASCII / DO file
	jz    L2432H    ; Jump to load ASCII / DO file
L23B7H	call  L26DDH    ; Print program on tape being skipped
	jmp   L23AAH    ; Jump to load next file on tape
	
L23BDH	pop   B         
	pop   PSW       
	push  PSW       
	push  B         
	jz    L23B7H    
	pop   PSW       
	pop   PSW       
	sbb   A         
	sta   VBASEF     
	call  L26E3H    ; Print selected program/file "Found" on tape
	call  L20FFH    ; NEW statement
	lhld  VTPLEN     ; Length of last program loaded/saved to tape
	push  H         
	mov   B,H       
	mov   C,L       
	lhld  VBASPP    ; Start of BASIC program pointer
	push  H         
	call  L6B6DH    ; Insert BC spaces at M
	jc    L3F17H    ; Reinit BASIC stack and generate OM error
	lxi   H,L2426H  ; ON ERROR handler for CLOAD
	shld  VLJERR    ; Save as active ON ERROR handler vector
	lhld  VPSDOF    ; Start of DO files pointer
	dad   B         ; Update start of DO files pointer based on load length
	shld  VPSDOF    ; Start of DO files pointer
	call  L26D1H    ; Load Tape sync, header and 8DH marker & validate
	pop   H         
	pop   D         
	call  L2413H    ; Load record from tape and store at M
	jnz   L2426H    ; On-error return handler for CLOAD statement
	mov   L,A       ; Prepare to NULL error long jump address
	mov   H,A       ; Prepare to NULL error long jump address
	shld  VLJERR    ; Long jump return address on error
	call  L14AAH    ; Turn cassette motor off
	call  L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	call  L05F0H    ; Update line addresses for current BASIC program
	call  L3F28H    ; Initialize BASIC Variables for new execution
	lda   VBASEF     ; Flag to execute BASIC program
	ana   A         ; Test if execute r.equested
	jnz   BASEXE    ; Execute BASIC program
	jmp   L0502H    ; Vector to BASIC ready - print Ok
	
	
; ======================================================
; Load record from tape and store at M
; ======================================================
L2413H	mvi   C,00H     ; Clear the checksum
L2415H	call  L14B0H    ; Read byte from tape & update checksum
	mov   M,A       ; Save next byte loaded from tape
	inx   H         ; Increment destination pointer
	dcx   D         ; Decrement length
	mov   A,D       ; Prepare to test for zero length remaining
	ora   E         ; OR in LSB of length
	jnz   L2415H    ; Jump to read more data from tape until zero
	call  L14B0H    ; Read byte from tape & update checksum
	mov   A,C       ; Move checksum to A
	ana   A         ; Test checksum for zero
	ret             
	
	
; ======================================================
; On-error return handler for CLOAD statement
; ======================================================
L2426H	call  L20FFH    ; NEW statement
	lxi   H,0000H   ; Prepare to clear ON ERROR handler vector
	shld  VLJERR     ; Save as active ON ERROR handler vector
	jmp   L1491H    ; Turn cassette motor off and generate I/O Error
	
L2432H	call  L26E3H    ; Print selected program/file "Found" on tape
	call  L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	lhld  0FC83H     ; File number description table pointer
	mov   A,M       
	inx   H         
	mov   H,M       
	mov   L,A       
	shld  0FC8CH     ; Save pointer to FCB for ASCII / tokenization
	mvi   M,01H     
	inx   H         
	inx   H         
	inx   H         
	inx   H         
	mvi   M,0FDH     ; Save file type as CAS device ID
	inx   H         
	inx   H         
	xra   A         
	mov   M,A       
	inx   H         
	mov   M,A       
	sta   0FA8EH     
	jmp   L4DA6H    
	
L2456H	call  L25E8H    ; Evaluate arguments to CLOAD/CLOADM & Clear current BASIC program
	push  H         ; Preserve HL on stack
	call  L2650H    ; Open CAS for input of BASIC files
	call  L26D1H    ; Load Tape sync, header and 8DH marker & validate
	lhld  VTPLEN     ; Length of last program loaded/saved to tape
	xchg            
	lhld  VBASPP    ; Start of BASIC program pointer
	call  L2590H    ; Compare the file on tape with file at HL
	jnz   L2478H    ; Generate Verify Failed error
	mov   A,M       ; Get next line pointer of BASIC program
	inx   H         ; Increment to MSB of pointer
	ora   M         ; OR in MSB to test for end of BASIC program
	jnz   L2478H    ; Generate Verify Failed error
L2473H	call  L14AAH    ; Turn cassette motor off
	pop   H         ; Restore HL
	ret             
	
	
; ======================================================
; Generate Verify Failed error
; ======================================================
L2478H	lxi   H,L2481H  ; Load pointer to "Verify failed" text
	call  L5791H    ; Print buffer at M until NULL or '"'
	jmp   L2473H    ; Turn the cassette motor off, POP H and return
	
L2481H	
    .db  "Verify failed",0DH,0AH,00H
	
	
; ======================================================
; LOADM and RUNM statement
; ======================================================
BSLORM	rst   2         ; Get next non-white char from M
	pop   PSW       
	push  PSW       
	jz    L08DBH    ; Generate FC error
	call  L207AH    ; Parse filename for device and default to RAM
	mov   A,D       
	CPI   0FDH       ; Test for load from CAS device
	jz    L24B3H    ; Jump to CLOADM routine if load from CAS
	CPI   0F8H       ; Test for load from RAM device
	jz    L24E7H    ; Jump to load from RAM if RAM device
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	5EH             
	
; ======================================================
; CLOADM statement
; ======================================================
BSCLDM	rst   2         ; Get next non-white char from M
	CPI   0A3H       ; Test for PRINT token ID
	jz    L2573H    ; If "CLOADM PRINT", jump to verify the TAPE file to RAM file
	call  L25E7H    ; Evaluate arguments to CLOAD/CLOADM & Clear current BASIC program
	ORI   0FFH       
	push  PSW       
L24B3H	dcx   H         
	rst   2         ; Get next non-white char from M
	jnz   ERRSYN    ; Generate Syntax error
	push  H         
	call  L2656H    ; Open CAS for input of CO files
	lhld  0FAD2H     
	mov   A,H       
	ora   L         
	jnz   L24CBH    
	pop   H         
	pop   PSW       
	push  PSW       
	push  H         
	jc    L08DBH    ; Generate FC error
L24CBH	call  L2531H    ; Print .CO info and test HIMEM for space to load
	jc    L3F17H    ; Reinit BASIC stack and generate OM error
	call  L26D1H    ; Load Tape sync, header and 8DH marker & validate
	lhld  VTPLEN     ; Length of last program loaded/saved to tape
	xchg            
	lhld  VADCOH     ; 'Load address' of current program
	call  L2413H    ; Load record from tape and store at M
	jnz   L1491H    ; Turn cassette motor off and generate I/O Error
	call  L14AAH    ; Turn cassette motor off
	jmp   L251AH    
	
L24E7H	push  H         
	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	call  L2089H    ; Add .DO extension to filename and search catalog for match
	jz    L5057H    ; Generate FF error
	xchg            
	call  L253DH    ; Copy .CO 6-byte header to Current Program Area
	push  H         
	lhld  0FAD2H     
	mov   A,H       
	ora   L         
	jnz   L2507H    
	pop   D         
	pop   H         
	pop   PSW       
	push  PSW       
	push  H         
	push  D         
	jc    L08DBH    ; Generate FC error
L2507H	call  L2531H    ; Print .CO info and test HIMEM for space to load
	jc    L3F17H    ; Reinit BASIC stack and generate OM error
	lhld  VTPLEN     ; Length of last program loaded/saved to tape
	mov   B,H       
	mov   C,L       
	lhld  VADCOH     ; 'Load address' of current program
	xchg            
	pop   H         
	call  L6BDBH    ; Move BC bytes from M to (DE) with increment
L251AH	pop   H         
	pop   PSW       
	jnc   L3F2CH    ; Initialize BASIC Variables for new execution
	call  L3F2CH    ; Initialize BASIC Variables for new execution
	lhld  0FAD2H     
	shld  0F661H     ; Address last called
	call  0F660H     
	lhld  0FB99H     ; Address of last variable assigned
	jmp   BASEXE    ; Execute BASIC program
	
L2531H	call  L25A4H    ; Print .CO information to LCD (start address, etc.)
L2534H	lhld  VHIMEM    ; HIMEM
	xchg            ; Swap HL and DE for comparison
	lhld  VADCOH     ; 'Load address' of current program
	rst   3         ; Compare DE and HL
	ret             
	
	
; ======================================================
; Copy .CO 6-byte header to Current Program Area
; ======================================================
L253DH	lxi   D,VADCOH   ; 'Load address' of current program
L2540H	mvi   B,06H     ; Load count of 6 bytes to copy
	
; ======================================================
; Move B bytes from M to (DE)
; ======================================================
L2542H	mov   A,M       ; Get next source byte
	stax  D         ; Save next dest byte
	inx   H         ; Increment source
	inx   D         ; Increment dest
	dcr   B         ; Decrement count
	jnz   L2542H    ; Move B bytes from M to (DE)
	ret             
	
	
; ======================================================
; Launch .CO files from MENU
; ======================================================
L254BH	call  L253DH    ; Copy .CO 6-byte header to Current Program Area
	push  H         ; Save pointer to .CO data on stack
	call  L2534H    ; Test HIMEM for space to load CO file
	jc    L256DH    ; BSBEEP and return to MENU
	xchg            
	lhld  VTPLEN     ; Length of last program loaded/saved to tape
	mov   B,H       ; Save length in BC
	mov   C,L       ; ...save LSB too
	pop   H         ; Restore pointer to .CO data
	call  L6BDBH    ; Move BC bytes from M to (DE) with increment
	lhld  0FAD2H     ; Point .CO header entry address
	mov   A,H       ; Validate entry address is not NULL
	ora   L         ; OR in LSB to test for NULL
	shld  0F661H     ; Address last called
	cnz   0F660H     ; Call to launch .CO if entry address not zero
	jmp   L5797H    ; MENU Program
	
L256DH	call  BSBEEP      ; BSBEEP statement
	jmp   L5797H    ; MENU Program
	
L2573H	rst   2         ; Get next non-white char from M
	call  L25E7H    ; Evaluate arguments to CLOAD/CLOADM & Clear current BASIC program
	push  H         ; Save pointer to BASIC command line
	call  L2656H    ; Open CAS for input of CO files
	call  L26D1H    ; Load Tape sync, header and 8DH marker & validate
	lhld  VTPLEN     ; Length of last program loaded/saved to tape
	xchg            
	lhld  VADCOH     ; 'Load address' of current program
	call  L2590H    ; Compare the file on tape with file at HL
	jnz   L2478H    ; Generate Verify Failed error
	call  L14AAH    ; Turn cassette motor off
	pop   H         ; Restore pointer to BASIC command line
	ret             
	
L2590H	mvi   C,00H     ; Clear the checksum byte
L2592H	call  L14B0H    ; Read byte from tape & update checksum
	cmp   M         ; Compare next byte of file
	rnz             ; Return if no match
	inx   H         ; Point to next byte in RAM file
	dcx   D         ; Decrement length
	mov   A,D       ; Prepare to test for zero
	ora   E         ; OR in LSB of length
	jnz   L2592H    ; Jump to validate more if not at end
	call  L14B0H    ; Read byte from tape & update checksum
	mov   A,C       ; Get checksum
	ana   A         ; Check for zero
	ret             
	
L25A4H	lhld  VBSCLN     ; Current executing line number
	inx   H         ; Increment address of executing BASIC line
	mov   A,H       ; Put MSB in A (current line pointer is 0xFFFF when no BASIC exec)
	ora   L         ; OR in LSB to test for zero
	rnz             ; Return if a BASIC program is running ... don't print
	lhld  VADCOH     ; 'Load address' of current program
	push  H         ; Save start address on stack
	xchg            ; Put it in DE
	lxi   H,L25D5H  ; Load pointer to "Top: " text
	call  L25CDH    ; Call to print HL and binary DE
	lhld  VTPLEN     ; Length of last program loaded/saved to tape
	dcx   H         ; Decrement length to calculate last address
	pop   D         ; Pop start adddress from stack
	dad   D         ; Calculate last address
	xchg            ; Put last address in DE for print
	lxi   H,L25DBH  ; Load pointer to "End: " text
	call  L25CDH    ; Call to print HL and binary DE
	lhld  0FAD2H     ; Load .CO entry address from TAPE buffer
	mov   A,H       ; Prepare to test for NULL entry address
	ora   L         ; OR in LSB to test for NULL entry address
	rz              ; Return if entry is null
	xchg            ; Put entry address in DE
	lxi   H,L25E1H  ; Load pointer to "Exe: " text
L25CDH	push  D         ; Save binary address to print on stack
	call  L5791H    ; Print buffer at M until NULL or '"'
	pop   H         ; Pop binary address to print into HL
	jmp   L39D4H    ; Print binary number in HL at current position
	
L25D5H
    .db	"Top: ",00H     
L25DBH
    .db	"End: ",00H     
L25E1H
    .db	"Exe: ",00H     
	
L25E7H	dcx   H         ; Point to byte before SPACE in command line
L25E8H	rst   2         ; Get next non-white char from M
	jnz   L25FCH    ; Validate or default to "CAS" devce for CSAVE/CSAVEM
	mvi   B,06H     ; Get length of filenames
	lxi   D,VFNCBP   ; Filename of current BASIC program
	mvi   A,20H     ; Prepare to clear out the current BASIC program
L25F3H	stax  D         ; Set next byte of current BASIC program to SPACE
	inx   D         ; Point to next byte
	dcr   B         ; Decrement counter
	jnz   L25F3H    ; Keep looping until counter is zero
	jmp   L2602H    
	
L25FCH	call  L4C0FH    ; Evaluate arguments to RUN/OPEN/SAVE commands
	jnz   L2604H    ; Skip if device name provided in filename
L2602H	mvi   D,0FDH     ; Default to CAS device
L2604H	mov   A,D       ; Copy device name to A
	CPI   0FDH       ; Test if provided device name is "CAS"
	jnz   L08DBH    ; Generate FC error
	ret             
	
	
; ======================================================
; Open CAS for output of BASIC files
; ======================================================
L260BH	mvi   A,0D3H     ; Load Tape header ID for BASIC program
	lxi   B,9C3EH   ; Make MVI A,9CH look like LXI B,9C3EH
	lxi   B,0D03EH   ; Make MVI A,0D0H look like LXI B,0D03EH
	push  PSW       ; Save program type ID to stack
	call  L1499H    ; Turn cassette motor on and detect sync header
	pop   PSW       ; Restore program type ID from stack
	call  L14C1H    ; Write byte to tape & update checksum
	mvi   C,00H     ; Zero out the checksum
	lxi   H,VFNCBP   ; Filename of current BASIC program
	lxi   D,L0602H  ; Write 6 filename bytes and set E loop
L2623H	mov   A,M       ; Get next byte to write
	call  L14C1H    ; Write byte to tape & update checksum
	inx   H         ; Increment to next byte to send
	dcr   D         ; Decrement loop counter
	jnz   L2623H    ; Loop for all bytes to send
	lxi   H,VADCOH   ; 'Load address' of current program
	mvi   D,0AH     ; For 2nd loop, write 10 dummy values
	dcr   E         ; Decrement outer loop
	jnz   L2623H    ; Loop for header bytes
L2635H	mov   A,C       ; Get checksum byte
	cma             ; Compliment checksum
	inr   A         ; And add 1 (2's compliment)
	call  L14C1H    ; Write byte to tape & update checksum
	mvi   B,14H     ; Prepare to send 20 NULL bytes to tape
L263DH	xra   A         ; Clear out A
	call  L14C1H    ; Write byte to tape & update checksum
	dcr   B         ; Decrement counter
	jnz   L263DH    ; Loop to send all 20 NULL bytes
	jmp   L14AAH    ; Turn cassette motor off
	
L2648H	call  L1499H    ; Turn cassette motor on and detect sync header
	mvi   A,8DH     ; Load code for block header
	jmp   L14C1H    ; Write byte to tape & update checksum
	
	
; ======================================================
; Open CAS for input of BASIC files
; ======================================================
L2650H	mvi   B,0D3H     ; Load TAPE header byte for tokenized BASIC file
	lxi   D,9C06H   ; Make MVI B,9CH look like LXI D,9C06H
	lxi   D,0D006H   ; Make MVI B,0D0H look like LXI D,0D006H
L2658H	push  B         ; Save header ID on stack
	call  L2667H    ; Read file header from tape
	pop   B         ; Restore header ID from stack
	cmp   B         ; Test if ID on tape matches the type we are looking for
	jz    L26E3H    ; Print selected program/file "Found" on tape if match
	call  L6C37H    ; Different from M1002
	jmp   L2658H    ; Jump to find next file on tape
	
L2667H	call  L148AH    ; Start tape and load tape header
	call  L14B0H    ; Read byte from tape & update checksum
	CPI   0D3H       ; Test for tokenized BASIC ID byte
	jz    L267CH    ; Jump if tokenized BASIC file
	CPI   9CH       ; Test for ASCII / DO file ID type
	jz    L267CH    ; Jump if ASCII / DO file
	CPI   0D0H       ; Test for .CO file type marker
	jnz   L2667H    ; Jump to skip file if not a valid header byte
L267CH	push  PSW       ; Save file type on stack
	lxi   H,VFNLFT   ; Filename of last program loaded from tape
	lxi   D,L0602H  ; Prepare to read filename and 10 byte header
	mvi   C,00H     ; Zero out the checksum
L2685H	call  L14B0H    ; Read byte from tape & update checksum
	mov   M,A       ; Save next byte (filename or header)
	inx   H         ; Increment the destination pointer
	dcr   D         ; Decrement the loop count
	jnz   L2685H    ; Jump to read all bytes
	lxi   H,VADCOH   ; 'Load address' of current program
	mvi   D,0AH     ; Load 10 bytes on 2nd loop
	dcr   E         ; Decrement loop counter
	jnz   L2685H    ; Jump for 2nd loop to read 10 header bytes
	call  L14B0H    ; Read byte from tape & update checksum
	mov   A,C       ; Get the checksum
	ana   A         ; Test for zero
	jnz   L26CDH    ; Jump if not zero to find next file on tape
	call  L14AAH    ; Turn cassette motor off
	lxi   H,VFNCBP   ; Filename of current BASIC program
	mvi   B,06H     ; Get length of filename
	mvi   A,20H     ; Load ASCII space
L26A9H	cmp   M         ; Test for blank filename
	jnz   L26B5H    ; Jump if filename not blank
	inx   H         ; Increment filename pointer
	dcr   B         ; Decrement count
	jnz   L26A9H    ; Jump to test next byte for non-space
	jmp   L26C8H    ; Jump to return if not looking for specific file
	
L26B5H	lxi   D,VFNCBP   ; Filename of current BASIC program
	lxi   H,VFNLFT   ; Filename of last program loaded from tape
	mvi   B,06H     ; Prepare to compare 6 bytes of filename
L26BDH	ldax  D         ; Load next byte of filename we want to load
	cmp   M         ; Compare with next byte of filename on tape
	jnz   L26CAH    ; Jump if they don't match
	inx   D         ; Increment target filename pointer
	inx   H         ; Increment tape filename pointer
	dcr   B         ; Decrement length
	jnz   L26BDH    ; Loop to test all bytes
L26C8H	pop   PSW       ; Cleanup stack
	ret             ; File found
	
L26CAH	call  L26DDH    ; Print program on tape being skipped
L26CDH	pop   PSW       ; Cleanup stack
	jmp   L2667H    ; Go read next file from tape
	
L26D1H	call  L148AH    ; Start tape and load tape header
	call  L14B0H    ; Read byte from tape & update checksum
	CPI   8DH       ; Test for 8Dh block header byte
	jnz   L1491H    ; Turn cassette motor off and generate I/O Error
	ret             
	
L26DDH	lxi   D,L2705H  ; Point to "Skip :" text
	jmp   L26E6H    ; Print selected program/file "Found" on tape
	
L26E3H	lxi   D,L26FEH  ; Point to "Found:" text
L26E6H	lhld  VBSCLN     ; Current executing line number
	inx   H         ; Prepare to test if BASIC running
	mov   A,H       ; Get MSB of exec line number
	ora   L         ; Get LSB
	rnz             ; Return if BASIC exectuing ... don't print
	xchg            ; Put pointer to string in HL
	call  L5791H    ; Print buffer at M until NULL or '"'
	xra   A         
	sta   0FCA2H     
	lxi   H,VFNLFT   ; Filename of last program loaded from tape
	call  L27B1H    ; Print buffer at M until NULL or '"'
	jmp   ERABOL    ; Erase from cursor to end of line
	
L26FEH
    .db	"Found:",00H          
L2705H
    .db	"Skip :",00H    
L270CH	call  L2916H    ; Get pointer to most recently used string (Len + address)
	mov   A,M       ; Get length of most recently used string
	inx   H         ; Increment to LSB of string pointer
	mov   C,M       ; Get LSB of string pointer
	inx   H         ; Increment to MSB of string pointer
	mov   B,M       ; Get MSB of string pointer
	pop   D         
	push  B         ; Push pointer to string on stack
	push  PSW       ; Preserve string length
	call  L291DH    ; Get pointer to stack string (Len + address). POP based on DE
	pop   PSW       ; Restore length of most recently used string
	mov   D,A       ; Save length in D
	mov   E,M       ; Get length of string from stack into E
	inx   H         ; Increment to LSB of stack string
	mov   C,M       ; Get LSB of pointer to string from stack
	inx   H         ; Increment to MSB
	mov   B,M       ; Get MSB of pointer to string
	pop   H         ; Restore pointer to most recently used string
L2722H	mov   A,E       ; Get length of string from string stack
	ora   D         ; Or in length of most recently used string
	rz              ; Return if both lengths are zero
	mov   A,D       ; Get length of most recently used string
	SUI   01H       ; Subtract 1 from length to test for zero
	rc              ; Return if at end of string
	xra   A         ; Zero out A
	cmp   E         ; Test if at end of string from string stack
	inr   A         ; Increment A (I guess to indicate strings different length)
	rnc             ; Return if at end of string from string stack
	dcr   D         ; Decrement length of string 1
	dcr   E         ; Decrement length of string 2
	ldax  B         ; Load next byte of string from string stack
	inx   B         ; Increment string pointer
	cmp   M         ; Compare with next byte from most recently used string
	inx   H         ; Increment pointer
	jz    L2722H    ; If they are .equal, jump back to test the length again until at end
	cmc             ; Compliment the Carry flag for calculation of which string is larger
	jmp   L33E9H    ; Jump to return 1 or -1 in A based on Carry flag
	
	
; ======================================================
; STR$ function
; ======================================================
BSTRFS	call  L39E8H    ; Convert binary number in FAC1 to ASCII at M
	call  L276BH    ; Search string at M until QUOTE found
	call  L2919H    ; Get pointer to most recently used string
	lxi   B,L2969H  
	push  B         
L2747H	mov   A,M       
	inx   H         
	push  H         
	call  L27C8H    ; Find space in BASIC String storage for A bytes
	pop   H         
	mov   C,M       
	inx   H         
	mov   B,M       
	call  L2760H    
	push  H         
	mov   L,A       
	call  L290CH    
	pop   D         
	ret             
	
L275BH	mvi   A,01H     ; Prepare to find 1 byte in BASIC String storage
L275DH	call  L27C8H    ; Find space in BASIC String storage for A bytes
L2760H	lxi   H,0FB89H   ; Load address of transient string
	push  H         ; Save address on stack
	mov   M,A       ; Copy A to transient string
	inx   H         ; Increment to next byte
	mov   M,E       ; Save LSB of DE to transient
	inx   H         ; Increment to next byte
	mov   M,D       ; Save MSB of DE to transient
	pop   H         ; Restore address of transient
	ret             
	
L276BH	dcx   H         ; Pre-decrement HL
L276CH	mvi   B,22H     ; Load ASCII code for QUOTE
L276EH	mov   D,B       ; Make B & D termination chars the same
L276FH	push  H         ; Save HL on stack
	mvi   C,0FFH     ; Initialize counter / index
L2772H	inx   H         ; Increment to next byte in string
	mov   A,M       ; Get next byte in string
	inr   C         ; Increment count / index
	ora   A         ; Test for zero (end of string)
	jz    L2781H    ; Jump if end of string
	cmp   D         ; Compare with character in D
	jz    L2781H    ; Exit loop if match
	cmp   B         ; Compare with character in B
	jnz   L2772H    ; Jump back to compare next byte in string if no match
L2781H	CPI   22H       ; Compare with QUOTE
	cz    L0858H    ; RST 10H routine with pre-increment of HL
	xthl            ; Restore pointer to string from stack
	inx   H         
	xchg            
	mov   A,C       
	call  L2760H    ; Save A and DE to transient string storage
L278DH	lxi   D,0FB89H   ; Point to transient string storage
	mvi   A,0D5H     ; TODO: another half instruction trick, resolve
	lhld  0FB69H     ; Get current location in string stack maybe?
	shld  VFAC1I     ; Start of FAC1 for integers
	mvi   A,03H     ; Make type of last variable a string
	sta   0FB65H     ; Type of last variable used
	call  L3465H    ; Copy transient string onto string stack perhaps?
	lxi   D,0FB8CH   ; Pointer to current location in BASIC string buffer
	rst   3         ; Compare DE and HL
	shld  0FB69H     ; Save new location in string stack?
	pop   H         
	mov   A,M       
	rnz             
	lxi   D,L0010H  ; Load code for ST error (String too Complex)
	jmp   L045DH    ; Generate error in E
	
L27B0H	inx   H         
	
; ======================================================
; Print buffer at M until NULL or '"'
; ======================================================
L27B1H	call  L276BH    ; Search string at M until QUOTE found
L27B4H	call  L2919H    ; Get pointer to most recently used string
	call  L3452H    ; Load strlen to D, str pointer to BC
	inr   D         ; Pre increment length
L27BBH	dcr   D         ; Decrement len to test for zero
	rz              ; Return if length is zero (nothing to print)
	ldax  B         ; Get next byte
	rst   4         ; Send character in A to screen/printer
	CPI   0DH       ; Test for CR
	cz    L4BD1H    ; Call routine to print CR
	inx   B         ; Increment string pointer
	jmp   L27BBH    ; Loop to print all bytes in string
	
L27C8H	ora   A         ; Test if A is zero
	mvi   C,0F1H     ; I think this is a hidden "(0F1H) POP PSW" at address 27CAH
	push  PSW       ; Save A & flags to stack
	lhld  VTPRAM    ; BASIC string buffer pointer
	xchg            
	lhld  0FB8CH     ; Pointer to current location in BASIC string buffer
	cma             ; Compliment A to determine how much space needed in buffer for string
	mov   C,A       ; Move Negative value to C
	mvi   B,0FFH     ; Sign extend BC
	dad   B         ; Subtract length from current buffer location
	inx   H         ; Increment for 2's compliment
	rst   3         ; Compare DE and HL
	jc    L27E4H    ; Jump to move stuff around if no space
	shld  0FB8CH     ; Save new current BASIC string buffer location
	inx   H         ; Increment to next location in BASIC string buffer. Why?
	xchg            ; DE has current location, HL has start
L27E2H	pop   PSW       ; Restore stack frame
	ret             
	
L27E4H	pop   PSW       ; Get Flags from stack
	lxi   D,L000EH  ; Prepare to generate OS Error
	jz    L045DH    ; Generate error in E
	cmp   A         
	push  PSW       
	lxi   B,L27CAH  ; I think this is a RET address to a POP PSW above
	push  B         
L27F1H	lhld  0FB67H     ; File buffer area pointer
L27F4H	shld  0FB8CH     ; Pointer to current location in BASIC string buffer
	lxi   H,0000H  
	push  H         
	lhld  VPFREM     ; Unused memory pointer
	push  H         
	lxi   H,0FB6BH   
L2802H	xchg            
	lhld  0FB69H     
	xchg            
	rst   3         ; Compare DE and HL
L2808H	lxi   B,L2802H  
	jnz   L2887H    
	lxi   H,0FBD9H   
	shld  0FBE2H     
	lhld  VARRTP     ; Start of array table pointer
	shld  0FBDFH     
	lhld  VPSVAR     ; Start of variable data pointer
L281DH	xchg            
	lhld  0FBDFH     
	xchg            
	rst   3         ; Compare DE and HL
	jz    L283AH    
	mov   A,M       
	inx   H         
	inx   H         
	inx   H         
	CPI   03H       
	jnz   L2833H    
	call  L2888H    
	xra   A         
L2833H	mov   E,A       
	mvi   D,00H     
	dad   D         
	jmp   L281DH    
	
L283AH	lhld  0FBE2H     
	mov   E,M       
	inx   H         
	mov   D,M       
	mov   A,D       
	ora   E         
	lhld  VARRTP     ; Start of array table pointer
	jz    L285CH    
	xchg            
	shld  0FBE2H     
	inx   H         
	inx   H         
	mov   E,M       
	inx   H         
	mov   D,M       
	inx   H         
	xchg            
	dad   D         
	shld  0FBDFH     
	xchg            
	jmp   L281DH    
	
L285BH	pop   B         
L285CH	xchg            
	lhld  VPFREM     ; Unused memory pointer
	xchg            
	rst   3         ; Compare DE and HL
	jz    L28A8H    
	mov   A,M       
	inx   H         
	call  L3450H    ; Reverse load single precision at M to DEBC
	push  H         
	dad   B         
	CPI   03H       
	jnz   L285BH    
	shld  0FB90H     
	pop   H         
	mov   C,M       
	mvi   B,00H     
	dad   B         
	dad   B         
	inx   H         
L287BH	xchg            
	lhld  0FB90H     
	xchg            
	rst   3         ; Compare DE and HL
	jz    L285CH    
	lxi   B,L287BH  
L2887H	push  B         
L2888H	xra   A         
	ora   M         
	inx   H         
	mov   E,M       
	inx   H         
	mov   D,M       
	inx   H         
	rz              
	mov   B,H       
	mov   C,L       
	lhld  0FB8CH     ; Pointer to current location in BASIC string buffer
	rst   3         ; Compare DE and HL
	mov   H,B       
	mov   L,C       
	rc              
	pop   H         
	xthl            
	rst   3         ; Compare DE and HL
	xthl            
	push  H         
	mov   H,B       
	mov   L,C       
	rnc             
	pop   B         
	pop   PSW       
	pop   PSW       
	push  H         
	push  D         
	push  B         
	ret             
	
L28A8H	pop   D         
	pop   H         
	mov   A,H       
	ora   L         
	rz              
	dcx   H         
	mov   B,M       
	dcx   H         
	mov   C,M       
	push  H         
	dcx   H         
	mov   L,M       
	mvi   H,00H     
	dad   B         
	mov   D,B       
	mov   E,C       
	dcx   H         
	mov   B,H       
	mov   C,L       
	lhld  0FB8CH     ; Pointer to current location in BASIC string buffer
	call  L3EF3H    
	pop   H         
	mov   M,C       
	inx   H         
	mov   M,B       
	mov   H,B       
	mov   L,C       
	dcx   H         
	jmp   L27F4H    
	
L28CCH	push  B         
	push  H         
	lhld  VFAC1I     ; Start of FAC1 for integers
	xthl            
	call  L0F1CH    ; Evaluate function at M
	xthl            
	call  L35D9H    ; Generate TM error if last variable type not string or RET
	mov   A,M       
	push  H         
	lhld  VFAC1I     ; Start of FAC1 for integers
	push  H         
	add   M         
	lxi   D,L000FH  ; Prepare to generate LS Error (String too Long)
	jc    L045DH    ; Generate error in E
	call  L275DH    ; Create a transient string of length A
	pop   D         
	call  L291DH    
	xthl            
	call  L291CH    
	push  H         
	lhld  0FB8AH     ; Address of transient string
	xchg            
	call  L2904H    ; Memory copy using args following the CALL statement
	call  L2904H    ; Memory copy using args following the CALL statement
	lxi   H,L0.db7H  
	xthl            
	push  H         
	jmp   L278DH    ; Add new transient string to string stack
	
	
; ======================================================
; Memory copy using args following the CALL statement
; ======================================================
L2904H	pop   H         ; POP return address from Stack
	xthl            ; Swap RET address with top of Stack (Pointer to var)
	mov   A,M       ; Get length of variable (2, 4, or 8)
	inx   H         ; Increment to variable address LSB
	mov   C,M       ; Get LSB of variable address in C
	inx   H         ; Increment to variable address MSB
	mov   B,M       ; Get MSB of variable address
	mov   L,A       ; Move variable length to L
L290CH	inr   L         ; Pre-increment L
L290DH	dcr   L         ; Decrement loop counter
	rz              ; Return if counter is zero
	
; ======================================================
; Move L bytes from (BC) to (DE)
; ======================================================
	ldax  B         ; Load next byte from BC
	stax  D         ; Store byte in DE
	inx   B         ; Increment Source ptr
	inx   D         ; Increment Dest ptr
	jmp   L290DH    ; Jump to test loop counter
	
L2916H	call  L35D9H    ; Generate TM error if last variable type not string or RET
L2919H	lhld  VFAC1I     ; Start of FAC1 for integers
L291CH	xchg            ; DE = Start of FAC1 for integers
L291DH	call  L2935H    ; POP next string from string stack for computation into BC
	xchg            ; HL = Start of FAC1 for integers
	rnz             ; Return if string stack empty
	push  D         ; Save address of "POPed" string to stack
	mov   D,B       ; Load address of string to DE
	mov   E,C       ; Load LSB too
	dcx   D         
	mov   C,M       
	lhld  0FB8CH     ; Pointer to current location in BASIC string buffer
	rst   3         ; Compare DE and HL
	jnz   L2933H    
	mov   B,A       
	dad   B         
	shld  0FB8CH     ; Pointer to current location in BASIC string buffer
L2933H	pop   H         
	ret             
	
L2935H	lhld  0FB69H     ; Load current string stack address
	dcx   H         ; Pre-decrement to get MSB of string address
	mov   B,M       ; Get MSB of top entry
	dcx   H         ; Decrement to LSB of string address
	mov   C,M       ; Get LSB of top entry
	dcx   H         ; Decrement again to point to string length
	rst   3         ; Compare DE and HL
	rnz             ; Don't save new stack location if HL == DE?
	shld  0FB69H     ; Save new stack location
	ret             
	
	
; ======================================================
; LEN function
; ======================================================
BFLEN	lxi   B,L10D1H  ; Address of Load integer in A into FAC1 routine
	push  B         ; PUSH return address to load A to FAC1
L2947H	call  L2916H    ; Get pointer to most recently used string (Len + address)
	xra   A         ; Zero out A. Not sure why, we overwrite below
	mov   D,A       ; Zero out D. Why?
	mov   A,M       ; Get Length of string
	ora   A         ; Test length for zero
	ret             
	
	
; ======================================================
; ASC function
; ======================================================
BFASC	lxi   B,L10D1H  ; Address of Load integer in A into FAC1 routine
	push  B         ; PUSH return address to load A to FAC1
L2953H	call  L2947H    ; Why not just call 2943? Get Length of most recently used String
	jz    L08DBH    ; Generate FC error
	inx   H         ; Increment past string length to LSB of string
	mov   E,M       ; Get LSB of string pointer
	inx   H         ; Increment to MSB
	mov   D,M       ; Get MSB of string pointer
	ldax  D         ; Get value of 1st character = ASC function
	ret             
	
	
; ======================================================
; CHR$ function
; ======================================================
BFCHRS	call  L275BH    ; Create a 1-byte transient string (for CHR$ & INKEY$)
	call  L1131H    ; Get expression integer < 256 in A or FC Error
L2965H	lhld  0FB8AH     ; Address of transient string
	mov   M,E       
L2969H	pop   B         
	jmp   L278DH    ; Add new transient string to string stack
	
	
; ======================================================
; STRING$ function
; ======================================================
BFSTRS	rst   2         ; Get next non-white char from M
	rst   1         ; Compare next byte with M
    .db	28H             ; Test for '('
	call  L112EH    ; Evaluate expression at M-1
	push  D         
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	call  BMEVAL    ; Main BASIC evaluation routine
	rst   1         ; Compare next byte with M
    .db	29H             ; Test for ')'
	xthl            
	push  H         
	rst   5         ; Determine type of last var used
	jz    L2987H    
	call  L1131H    ; Get expression integer < 256 in A or FC Error
	jmp   L298AH    
	
L2987H	call  L2953H    
L298AH	pop   D         
	call  L2993H    
	
; ======================================================
; SPACE$ function
; ======================================================
BFSPCS	call  L1131H    ; Get expression integer < 256 in A or FC Error
	mvi   A,20H     
L2993H	push  PSW       
	mov   A,E       
	call  L275DH    ; Create a transient string of length A
	mov   B,A       
	pop   PSW       
	inr   B         
	dcr   B         
	jz    L2969H    
	lhld  0FB8AH     ; Address of transient string
L29A2H	mov   M,A       
	inx   H         
	dcr   B         
	jnz   L29A2H    
	jmp   L2969H    
	
	
; ======================================================
; LEFT$ function
; ======================================================
BFLFTS	call  L2A2FH    
	xra   A         
L29AFH	xthl            
	mov   C,A       
	mvi   A,0E5H     ; This is a Hidden (0E5H) PUSH H at 29B2H
L29B3H	push  H         
	mov   A,M       
	cmp   B         
	jc    L29BBH    
	mov   A,B       
	lxi   D,L000EH  
	push  B         
	call  L27C8H    ; Find space in BASIC String storage for A bytes
	pop   B         
	pop   H         
	push  H         
	inx   H         
	mov   B,M       
	inx   H         
	mov   H,M       
	mov   L,B       
	mvi   B,00H     
	dad   B         
	mov   B,H       
	mov   C,L       
	call  L2760H    
	mov   L,A       
	call  L290CH    
	pop   D         
	call  L291DH    
	jmp   L278DH    ; Add new transient string to string stack
	
	
; ======================================================
; RIGHT$ function
; ======================================================
BFRGHT	call  L2A2FH    
	pop   D         
	push  D         
	ldax  D         
	sub   B         
	jmp   L29AFH    
	
	
; ======================================================
; MID$ function
; ======================================================
BFMIDS	xchg            
	mov   A,M       
	call  L2A32H    
	inr   B         
	dcr   B         
	jz    L08DBH    ; Generate FC error
	push  B         
	call  L2B3DH    
	pop   PSW       
	xthl            
	lxi   B,L29B3H  
	push  B         
	dcr   A         
	cmp   M         
	mvi   B,00H     
	rnc             
	mov   C,A       
	mov   A,M       
	sub   C         
	cmp   E         
	mov   B,A       
	rc              
	mov   B,E       
	ret             
	
	
; ======================================================
; VAL function
; ======================================================
BFVAL	call  L2947H    
	jz    L10D1H    ; Load integer in A into FAC1
	mov   E,A       
	inx   H         
	mov   A,M       
	inx   H         
	mov   H,M       
	mov   L,A       
	push  H         
	dad   D         
	mov   B,M       
	shld  0F67EH     
	mov   A,B       
	sta   0FBE6H     
	mov   M,D       
	xthl            
	push  B         
	dcx   H         
	rst   2         ; Get next non-white char from M
	call  L3840H    ; Convert ASCII number at M to double precision in FAC1
	lxi   H,0000H  
	shld  0F67EH     
	pop   B         
	pop   H         
	mov   M,B       
	ret             
	
L2A2FH	xchg            
	rst   1         ; Compare next byte with M
    .db	29H             ; compare with ')'
L2A32H	pop   B         
	pop   D         
	push  B         
	mov   B,E       
	ret             
	
	
; ======================================================
; INSTR function
; ======================================================
BFINST	rst   2         ; Get next non-white char from M
	call  L0DA9H    
	rst   5         ; Determine type of last var used
	mvi   A,01H     
	push  PSW       
	jz    L2A53H    
	pop   PSW       
	call  L1131H    ; Get expression integer < 256 in A or FC Error
	ora   A         
	jz    L08DBH    ; Generate FC error
	push  PSW       
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	call  BMEVAL    ; Main BASIC evaluation routine
	call  L35D9H    
L2A53H	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	push  H         
	lhld  VFAC1I     ; Start of FAC1 for integers
	xthl            
	call  BMEVAL    ; Main BASIC evaluation routine
	rst   1         ; Compare next byte with M
    .db	29H             ; Test for ')'
	push  H         
	call  L2916H    ; Get pointer to most recently used string (Len + address)
	xchg            
	pop   B         
	pop   H         
	pop   PSW       
	push  B         
	lxi   B,L383EH  
	push  B         
	lxi   B,L10D1H  ; Load integer in A into FAC1
	push  B         
	push  PSW       
	push  D         
	call  L291CH    
	pop   D         
	pop   PSW       
	mov   B,A       
	dcr   A         
	mov   C,A       
	cmp   M         
	mvi   A,00H     
	rnc             
	ldax  D         
	ora   A         
	mov   A,B       
	rz              
	mov   A,M       
	inx   H         
	mov   B,M       
	inx   H         
	mov   H,M       
	mov   L,B       
	mvi   B,00H     
	dad   B         
	sub   C         
	mov   B,A       
	push  B         
	push  D         
	xthl            
	mov   C,M       
	inx   H         
	mov   E,M       
	inx   H         
	mov   D,M       
	pop   H         
L2A96H	push  H         
	push  D         
	push  B         
L2A99H	ldax  D         
	cmp   M         
	jnz   L2AB7H    
	inx   D         
	dcr   C         
	jz    L2AAEH    
	inx   H         
	dcr   B         
	jnz   L2A99H    
	pop   D         
	pop   D         
	pop   B         
L2AABH	pop   D         
	xra   A         
	ret             
	
L2AAEH	pop   H         
	pop   D         
	pop   D         
	pop   B         
	mov   A,B       
	sub   H         
	add   C         
	inr   A         
	ret             
	
L2AB7H	pop   B         
	pop   D         
	pop   H         
	inx   H         
	dcr   B         
	jnz   L2A96H    
	jmp   L2AABH    
	
L2AC2H	rst   1         ; Compare next byte with M
    .db	28H             ; Test for '(' character
	call  L4790H    ; Find address of variable at M
	call  L35D9H    
	push  H         
	push  D         
	xchg            
	inx   H         
	mov   E,M       
	inx   H         
	mov   D,M       
	lhld  VPFREM     ; Unused memory pointer
	rst   3         ; Compare DE and HL
	jc    L2AE9H    
	lhld  VBASPP    ; Start of BASIC program pointer
	rst   3         ; Compare DE and HL
	jnc   L2AE9H    
	pop   H         
	push  H         
	call  L2747H    
	pop   H         
	push  H         
	call  L3465H    
L2AE9H	pop   H         
	xthl            
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ',' character
	call  L112EH    ; Evaluate expression at M-1
	ora   A         
	jz    L08DBH    ; Generate FC error
	push  PSW       
	mov   A,M       
	call  L2B3DH    
	push  D         
	call  L0DA4H    
	push  H         
	call  L2916H    ; Get pointer to most recently used string (Len + address)
	xchg            
	pop   H         
	pop   B         
	pop   PSW       
	mov   B,A       
	xthl            
	push  H         
	lxi   H,L383EH  
	xthl            
	mov   A,C       
	ora   A         
	rz              
	mov   A,M       
	sub   B         
	jc    L08DBH    ; Generate FC error
	inr   A         
	cmp   C         
	jc    L2B1AH    
	mov   A,C       
L2B1AH	mov   C,B       
	dcr   C         
	mvi   B,00H     
	push  D         
	inx   H         
	mov   E,M       
	inx   H         
	mov   H,M       
	mov   L,E       
	dad   B         
	mov   B,A       
	pop   D         
	xchg            
	mov   C,M       
	inx   H         
	mov   A,M       
	inx   H         
	mov   H,M       
	mov   L,A       
	xchg            
	mov   A,C       
	ora   A         
	rz              
L2B32H	ldax  D         
	mov   M,A       
	inx   D         
	inx   H         
	dcr   C         
	rz              
	dcr   B         
	jnz   L2B32H    
	ret             
	
L2B3DH	mvi   E,0FFH     
	CPI   29H       
	jz    L2B49H    
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ',' character
	call  L112EH    ; Evaluate expression at M-1
L2B49H	rst   1         ; Compare next byte with M
    .db	29H             ; Test for ')' character
	ret             
	
	
; ======================================================
; FRE function
; ======================================================
BFFRE	lhld  VPFREM     ; Unused memory pointer
	xchg            ; Move unused memory location to DE
	lxi   H,0000H   ; Prepare to get current SP to calc free space
	dad   SP        ; Get current SP
	rst   5         ; Determine type of last var used
	jnz   L10BFH    ; If not string, Subtract HL - DE and unsigned convert to SNGL in FAC1
	call  L2919H    ; Get pointer to most recently used string
	call  L27F1H    
	xchg            
	lhld  VTPRAM    ; BASIC string buffer pointer
	xchg            
	lhld  0FB8CH     ; Pointer to current location in BASIC string buffer
	jmp   L10BFH    ; Subtract HL - DE and unsigned convert to SNGL in FAC1
	
	
; ======================================================
; Double precision subtract (FAC1=FAC1-FAC2)
; ======================================================
L2B69H	lxi   H,0FC69H   ; Start of FAC2 for single and double precision
	mov   A,M       
	ora   A         
	rz              
	XRI   80H       
	mov   M,A       
	jmp   L2B7EH    
	
L2B75H	call  L3461H    ; Move M to FAC2 using precision at (0FB65H)
	
; ======================================================
; Double precision addition (FAC1=FAC1+FAC2)
; ======================================================
L2B78H	lxi   H,0FC69H   ; Start of FAC2 for single and double precision
	mov   A,M       
	ora   A         
	rz              
L2B7EH	ANI   7FH       
	mov   B,A       
	lxi   D,VVC1SD   ; Start of FAC1 for single and double precision
	ldax  D         
	ora   A         
	jz    L347BH    ; Copy FAC2 to FAC1
	ANI   7FH       
	sub   B         
	jnc   L2BA2H    
	cma             
	inr   A         
	push  PSW       
	push  H         
	mvi   B,08H     
L2B95H	ldax  D         
	mov   C,M       
	mov   M,A       
	mov   A,C       
	stax  D         
	inx   D         
	inx   H         
	dcr   B         
	jnz   L2B95H    
	pop   H         
	pop   PSW       
L2BA2H	CPI   10H       
	rnc             
	push  PSW       
	xra   A         
	sta   0FC20H     ; Temp BCD value for computation?
	sta   0FC71H     
	lxi   H,0FC6AH   
	pop   PSW       
	call  L2CADH    
	lxi   H,0FC69H   ; Start of FAC2 for single and double precision
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	xra   M         
	jm    L2BDBH    
	lda   0FC71H     
	sta   0FC20H     ; Temp BCD value for computation?
	call  L2C46H    ; Add FAC2 to FAC1
	jnc   L2C27H    
	xchg            
	mov   A,M       
	inr   M         
	xra   M         
	jm    L0455H    ; Generate OV error
	call  L2CF2H    
	mov   A,M       
	ORI   10H       
	mov   M,A       
	jmp   L2C27H    
	
L2BDBH	call  L2C5AH    
L2BDEH	lxi   H,0FC19H   ; Point to BCD portion of FAC1
	lxi   B,L0800H  ; Prepare to process 8 bytes, C = 0 = BCD Shift distance
L2BE4H	mov   A,M       ; Test next 2 digits from FAC1
	ora   A         ; Test for digits "00"
	jnz   L2BF3H    ; Jump if not "00"
	inx   H         ; Increment to next 2 digits in FAC1 - Skip this byte
	dcr   C         ; Decrement Digit counter
	dcr   C         ; Decrement Digit counter
	dcr   B         ; Decrement byte counter
	jnz   L2BE4H    ; Keep looping until all bytes processed
	jmp   L33EDH    ; Initialize FAC1 for SGL & .dbL precision to zero
	
L2BF3H	ANI   0F0H       ; Mask off the lower digit to see if BCD shift needed (4-bit shift)
	jnz   L2BFEH    ; Jump ahead if not zero MSB of this byte isn't zero
	push  H         ; Save pointer to current location in FAC1
	call  L2C94H    ; Rotate FAC1 1 BCD digit left to normalize starting at HL for B bytes
	pop   H         ; Restore current pointer into FAC1
	dcr   C         ; Decrement the digit counter
L2BFEH	mvi   A,08H     ; Prepare to calculate number of bytes with "00" that were skipped
	sub   B         ; Subtract 8 from the byte counter to test if first set of digits
	jz    L2C17H    ; Skip copying bytes to FAC1 if no bytes to copy (already normalized)
	push  PSW       ; Preserve count of bytes skipped on stack
	push  B         ; Preserve BC on stack
	mov   C,B       ; Move number of bytes to copy to C
	lxi   D,0FC19H   ; Point to BCD portion of FAC1
	call  L2EDDH    ; Move C bytes from M to (DE) with increment - shift the bytes
	pop   B         ; Restore byte counter from stack
	pop   PSW       ; Restore A from stack
	mov   B,A       ; Move count of bytes skipped to B to use as a count to zero out the end
	xra   A         ; Prepare to zero out B bytes from end of FAC1 that were shifted left
L2C11H	stax  D         ; Zero out next LSB from BCD
	inx   D         ; Increment to next lower BCD value in FAC1
	dcr   B         ; Decrement the counter
	jnz   L2C11H    ; Loop until all bytes zeroed
L2C17H	mov   A,C       ; Get digit count from normalize
	ora   A         ; Test if no bytes copied from normalize (don't need to adjust decimal point)
	jz    L2C27H    ; Jump to round if BCD value was not shifted / normalized
	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	mov   B,M       ; Get current sign / decimal point location
L2C20H	add   M         ; Add number of BCD digits shifted to calculate new decimal location
	mov   M,A       ; Save new decimal point location
	xra   B         ; Test for overflow in shift (too small)
	jm    L0455H    ; Generate OV error
	rz              ; Return if FAC1 is zero -- no need to round
L2C27H	lxi   H,0FC20H   ; Point to end of FAC1+1 = "Fraction portion" for accuracy
	mvi   B,07H     ; Prepare to perform rounding operation on 7 byte of BCD
L2C2CH	mov   A,M       ; Get "fraction portion" of FAC1
	CPI   50H       ; Test for value 0.50 decimal (this is BCD)
	rc              ; Return if less than 0.50 - no rounding needed
	dcx   H         ; Decrement to next higher BCD pair
	xra   A         ; Clear A to perform ADD of 1 to FAC1 (to perform round up)
	stc             ; Set the C flag (this is our "1")
L2C33H	adc   M         ; Add Zero with carry to the next BCD pair
	daa             ; Decimal adjust for BCD calculations
	mov   M,A       ; Save this byte of BCD data
	rnc             ; Return if no more carry to additional bytes
	dcx   H         ; Decrement to next higher BCD pair
	dcr   B         ; Decrement byte count
	jnz   L2C33H    ; Loop until all bytes rounded (or no carry)
	mov   A,M       ; We rounded to the last byte and had Carry. Must shift decimal point.
	inr   M         ; Increment the decimal point position to account for carry
	xra   M         ; Test for overflow during rounding
	jm    L0455H    ; Generate OV error
	inx   H         ; Increment to 1st BCD pair to change from .99 to 1.00
	mvi   M,10H     ; Change value to 1.0 since our "carry" was really a decimal point shift
	ret             
	
L2C46H	lxi   H,0FC70H   ; Point to end of FAC2
	lxi   D,0FC1FH   ; Point to end of FAC1
	mvi   B,07H     ; Prepare to add 7 bytes of BCD (14 digits)
L2C4EH	xra   A         ; Clear C flag for 1st ADD
	
; ======================================================
; Add the BCD num in M to the one in (DE)
; ======================================================
L2C4FH	ldax  D         ; Load first byte into A
	adc   M         ; ADD with carry the next byte from M
	daa             ; Decimal Adjust for BCD add
	stax  D         ; Store sum at (DE)
	dcx   D         ; Decrement to next higher position of DE
	dcx   H         ; Decrement to next higher position of HL
	dcr   B         ; Decrement byte counter
	jnz   L2C4FH    ; Add the BCD num in M to the one in (DE)
	ret             
	
L2C5AH	lxi   H,0FC71H   ; Point to extended precision portion of FAC2
	mov   A,M       ; Get extended precision portion to test for rounding
	CPI   50H       ; Compare with 50 BCD (represent 0.50)
	jnz   L2C64H    ; Jump if extended precision portion of FAC2 != 0.50
	inr   M         ; Increment extended precision portion of FAC2
L2C64H	lxi   D,0FC20H   ; Point to extended precision portion of FAC1
	mvi   B,08H     ; Prepare to subtract FAC2 from 0.999999999999 maybe?
	stc             ; Set carry to initiate no-borrow
L2C6AH	mvi   A,99H     ; Load 0.99 BCD into A
	ACI   00H       ; Add 00 BCD to set AC flag2
	sub   M         ; Subtract extended precision portion of FAC2 from 0.99 BCD
	mov   C,A       ; Save difference in C
	ldax  D         ; Load next byte from FAC1
	add   C         ; Add difference of 0.99-FAC2
	daa             ; Decimal adjust for BCD value
	stax  D         ; Store in FAC1 (FAC1 = FAC1 + (0.999999999 - FAC2))
	dcx   D         ; Decrement to next higher BCD pair for FAC1
	dcx   H         ; Decrement to next higher BCD pair for FAC2
	dcr   B         ; Decrement byte count
	jnz   L2C6AH    ; Keep looping until count = 0
	rc              ; Return if no borrow
	xchg            
	mov   A,M       
	XRI   80H       
	mov   M,A       
	lxi   H,0FC20H   ; Point to extended precision portion of FAC1
	mvi   B,08H     
	xra   A         
L2C86H	mvi   A,9AH     
	sbb   M         
	ACI   00H       
	daa             
	cmc             
	mov   M,A       
	dcx   H         
	dcr   B         
	jnz   L2C86H    
	ret             
	
L2C94H	lxi   H,0FC20H   ; Point to end of FAC1 (+1 to rotate in a "0")
L2C97H	push  B         ; Preserve byte & digit count on stack
	mov   D,B       ; Move byte count to D
	mvi   C,04H     ; Prepare to rotate the remaining bytes 4 bits to populate MSB of 1st byte
L2C9BH	push  H         ; Preserve the pointer to end of FAC1 for next shift loop
	ora   A         ; Clear the C flag so we rotate 0 in
L2C9DH	mov   A,M       ; Get the next highest byte from FAC1
	ral             ; Rotate the C bit (bit 8 from previous byte) into this byte & shift
	mov   M,A       ; Save the shifted byte back to FAC1
	dcx   H         ; Decrement to next higher BCD value pair
	dcr   B         ; Decrement the byte count
	jnz   L2C9DH    ; Keep looping until B bytes shifted
	mov   B,D       ; Restore B for next pass (we rotate through B bytes 4 times)
	pop   H         ; Restore the pointer to the end of FAC1 for next shift loop
	dcr   C         ; Decrement the bit shift count
	jnz   L2C9BH    ; Keep looping until we have shifted 4 times (1 BCD digit)
	pop   B         ; Restore byte & digit counts from stack
	ret             
	
L2CADH	ora   A         
	rar             
	push  PSW       
	ora   A         
	jz    L2CFAH    
	push  PSW       
	cma             
	inr   A         
	mov   C,A       
	mvi   B,0FFH     
	lxi   D,L0007H  
	dad   D         
	mov   D,H       
	mov   E,L       
	dad   B         
	mvi   A,08H     
	add   C         
	mov   C,A       
	push  B         
	call  L2EE6H    ; Move C bytes from M to (DE)
	pop   B         
	pop   PSW       
	inx   H         
	inx   D         
	push  D         
	mov   B,A       
	xra   A         
L2CD0H	mov   M,A       
	inx   H         
	dcr   B         
	jnz   L2CD0H    
	pop   H         
	pop   PSW       
	rnc             
	mov   A,C       
L2CDAH	push  B         
	push  D         
	mov   D,A       
	mvi   C,04H     
L2CDFH	mov   B,D       
	push  H         
	ora   A         
L2CE2H	mov   A,M       
	rar             
	mov   M,A       
	inx   H         
	dcr   B         
	jnz   L2CE2H    
	pop   H         
	dcr   C         
	jnz   L2CDFH    
	pop   D         
	pop   B         
	ret             
	
L2CF2H	lxi   H,0FC19H   ; Point to BCD portion of FAC1
L2CF5H	mvi   A,08H     
	jmp   L2CDAH    
	
L2CFAH	pop   PSW       
	rnc             
	jmp   L2CF5H    
	
	
; ======================================================
; Double precision multiply (FAC1=FAC1*FAC2)
; ======================================================
L2CFFH	rst   6         ; Get sign of FAC1
	rz              ; Return if FAC1 is zero - product is zero also
	lda   0FC69H     ; Start of FAC2 for single and double precision
	ora   A         ; Test if FAC2 is zero
	jz    L33EDH    ; Set FAC1 to zero - Initialize FAC1 for SGL & .dbL precision to zero
	mov   B,A       ; Save Sign and Decimal point for FAC2
	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	xra   M         ; Test if Sign of FAC1 and FAC2 are different
	ANI   80H       ; Keep only the sign bit
	mov   C,A       ; Save the resulting sign of the product in C
	mov   A,B       ; Restore the sign and decimal point of FAC2
	ANI   7FH       ; Mask the sign bit out
	mov   B,A       ; Save the decimal point info in B
	mov   A,M       ; Get the sign and decimal point for FAC1
	ANI   7FH       ; Mask off the sign bit
	add   B         ; Add the decimal point for FAC1 and FAC2 for multiply
	mov   B,A       ; Save the sum in B
	mvi   M,00H     ; Initialize FAC1 decimal point to zero
	ANI   0C0H       ; Mask off lower 6 bits of the sum of decimal points
	rz              ; Return if it's zero. Not sure why - we didn't actually multiply anything yet
	CPI   0C0H       ; Test if upper 2 bits of sum of decimal points are both 1
	jnz   L2D26H    ; Jump if not 0C0H
	jmp   L0455H    ; Generate OV error
	
L2D26H	mov   A,B       ; Reload the sum of the decimal points
	Adi   40H       ; Add 40H to it (the "zero" point)
	ANI   7FH       ; Mask off the upper bit (where sign bit goes)
	rz              ; Return if the product generates zero
	ora   C         ; OR in the sign of the product
	dcx   H         ; Decrement HL to save decimal point & sign temporarily
	mov   M,A       ; Save decimal & sign
	lxi   D,0FC67H   ; Temp BCD value for computation (BCD_TEMP8)
	lxi   B,L0008H  ; Prepare to copy 8 bytes of BCD
	lxi   H,0FC1FH   ; Point to end of FAC1
	push  D         ; Preserve address of temp float to stack
	call  L2EE6H    ; Move C bytes from M to (DE)
	inx   H         ; Increment to beginning of FAC1
	xra   A         ; Clear A
	mvi   B,08H     ; Prepare to clear 8 bytes of FAC1
L2D40H	mov   M,A       ; Zero out next byte of FAC1
	inx   H         ; Increment to next byte of FAC1
	dcr   B         ; Decrement loop counter
	jnz   L2D40H    ; Keep looping until count = 0
	pop   D         ; Restore address of BCD_TEMP8
	lxi   B,L2DA8H  ; Load address of routine to retrieve saved Decimal/sign byte and normalize FAC1
	push  B         ; PUSH new RETurn address to stack
L2D4BH	call  L2DAFH    ; Multiply BCD at (DE) x2, x4 and x8 into BCD_TEMP7, BCD_TEMP6, BCD_TEMP5
	push  H         ; Push address of BCD_TEMP4 to stack
	lxi   B,L0008H  ; Prepare to copy 8 BCD bytes
	xchg            ; HL=BCD_TEMP5 (x8), DE=BCD_TEMP4
	call  L2EE6H    ; Move C bytes from M to (DE)
	xchg            ; HL=BCD_TEMP3, DE=BCD_TEMP4 (x8)
	lxi   H,0FC5FH   ; Point to BCD_TEMP7 (x2)
	mvi   B,08H     ; Prepare to add 8 bytes of BCD (Add BCD_TEMP3 to BCD_TEMP7)
	call  L2C4EH    ; Add BCD value at (HL) to the one at (DE) -- BCD_TEMP4 = x8 + x2 = x10
	pop   D         ; POP address of BCD_TEMP4 from stack
	call  L2DAFH    ; Multiply BCD_TEMP4 (x10) times 2, 4 and 8 into BCD_TEMP3, BCD_TEMP2, BCD_TEMP1
	mvi   C,07H     ; Prepare to multiply 7 bytes of BCD from FAC2?
	lxi   D,0FC70H   ; Point to end of FAC2
L2D68H	ldax  D         ; Load next BCD pair from FAC2
	ora   A         ; Test if byte pair is "00"
	jnz   L2D72H    ; Jump to start multiply when first non "00" BCD found
	dcx   D         ; Decrement to next higher BCD pair
	dcr   C         ; Decrement byte counter (no need to test for zero - we won't be here if FAC2=0.0000)
	jmp   L2D68H    ; Jump to test next byte of FAC2
	
L2D72H	ldax  D         ; Load next byte of BCD from FAC2
	dcx   D         ; Decrement to next higher BCD pair in FAC2
	push  D         ; Save address of BCD pair being processed in FAC2 to stack
	lxi   H,0FC2FH   ; Point to BCD_TEMP1 (this is FAC1 x 80)
L2D78H	add   A         ; Multiply BCD from FAC2 x 2
	jc    L2D86H    ; Add BCD value at (HL) to FAC1
	jz    L2D95H    ; If zero (overflow to 100H), then jump to divide by 100
L2D7FH	lxi   D,L0008H  ; Prepare to point to next BCD_TEMPx value
	dad   D         ; Advance HL to next BCD_TEMPx value
	jmp   L2D78H    ; Jump to test if this BCD_TEMPx value should be added to FAC1
	
L2D86H	push  PSW       ; Save A on stack
	mvi   B,08H     ; Load BCD byte count
	lxi   D,0FC1FH   ; Point to end of FAC1
	push  H         ; Preserve HL on stack
	call  L2C4EH    ; Add BCD value at (HL) to the one at FAC1
	pop   H         ; Restore HL
	pop   PSW       ; Restore A
	jmp   L2D7FH    ; Jump to test if next BCD_TEMPx value should be added to FAC1
	
L2D95H	mvi   B,0FH     ; Prepare to shift 15 bytes (extended precision) of FAC1
	lxi   D,0FC26H   ; Start 1 byte from end of FAC1 (extended precision)
	lxi   H,0FC27H   ; Move to last byte of FAC1 (this is /100 because of BCD)
	call  L3472H    ; Move B bytes from (DE) to M with decrement
	mvi   M,00H     ; Set the 1st byte (sign / decimal point) to zero
	pop   D         ; Restore pointer to current BCD pair in FAC2
	dcr   C         ; Decrement BCD count for FAC2
	jnz   L2D72H    ; Jump to process next byte
	ret             ; Return to our hook (below) to retrieve the Decimal/sign & normalize
	
L2DA8H	dcx   H         ; Decrement from start of FAC1 to save byte for sign/decimal point
	mov   A,M       ; Get saved sign/decimal point
	inx   H         ; Increment back to start of FAC1
	mov   M,A       ; Copy saved sign/decimal point to FAC1
	jmp   L2BDEH    ; Normalize FAC1 such that the 1st BCD digit isn't zero
	
L2DAFH	lxi   H,0FFF8H   ; Load -8 into HL
	dad   D         ; HL=DE-8 -- Point to next lower temp BCD value
	mvi   C,03H     ; Prepare to process 3 floating point values
L2.db5H	mvi   B,08H     ; Load byte counter for 1 floating point value
	ora   A         ; Clear C flag
L2.db8H	ldax  D         ; Load next byte of floating point value
	adc   A         ; Add with carry (x2)
	daa             ; Decimal adjust for BCD math
	mov   M,A       ; Save byte x 2 to next lower temp floating point value
	dcx   H         ; Decrement pointer to temp floating point 1
	dcx   D         ; Decrement pointer to temp floating point 2
	dcr   B         ; Decrement byte counter
	jnz   L2.db8H    ; Keep looping until byte counter = 0
	dcr   C         ; Decrement x2 loop counter
	jnz   L2.db5H    ; Keep looping until count=0 (x2, x4, x8)
	ret             
	
	
; ======================================================
; Double precision divide (FAC1=FAC1/FAC2)
; ======================================================
L2DC7H	lda   0FC69H     ; Start of FAC2 for single and double precision
	ora   A         
	jz    L0449H    ; Generate /0 error
	mov   B,A       
	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	mov   A,M       
	ora   A         
	jz    L33EDH    ; Initialize FAC1 for SGL & .dbL precision to zero
	xra   B         
	ANI   80H       
	mov   C,A       
	mov   A,B       
	ANI   7FH       
	mov   B,A       
	mov   A,M       
	ANI   7FH       
	sub   B         
	mov   B,A       
	rar             
	xra   B         
	ANI   40H       
	mvi   M,00H     
	jz    L2DF4H    
	mov   A,B       
	ANI   80H       
	rnz             
L2DF1H	jmp   L0455H    ; Generate OV error
	
L2DF4H	mov   A,B       
	Adi   41H       
	ANI   7FH       
	mov   M,A       
	jz    L2DF1H    
	ora   C         
	mvi   M,00H     
	dcx   H         
	mov   M,A       
	lxi   D,0FC1FH   ; Point to end of FAC1
	lxi   H,0FC70H   ; Point to end of FAC2
	mvi   B,07H     
L2E0AH	mov   A,M       
	ora   A         
	jnz   L2E15H    
	dcx   D         
	dcx   H         
	dcr   B         
	jnz   L2E0AH    
L2E15H	shld  0FC14H     
	xchg            
	shld  0FC12H     
	mov   A,B       
	sta   0FC16H     
	lxi   H,0FC60H   ; Floating Point Temp 2
L2E23H	mvi   B,0FH     
L2E25H	push  H         
	push  B         
	lhld  0FC14H     
	xchg            
	lhld  0FC12H     
	lda   0FC16H     
	mvi   C,0FFH     
L2E33H	stc             
	inr   C         
	mov   B,A       
	push  H         
	push  D         
L2E38H	mvi   A,99H     
	ACI   00H       
	xchg            
	sub   M         
	xchg            
	add   M         
	daa             
	mov   M,A       
	dcx   H         
	dcx   D         
	dcr   B         
	jnz   L2E38H    
	mov   A,M       
	cmc             
	SBI   00H       
	mov   M,A       
	pop   D         
	pop   H         
	lda   0FC16H     
	jnc   L2E33H    
	mov   B,A       
	xchg            
	call  L2C4EH    ; Add BCD value at (HL) to the one at FAC1
	jnc   L2E5FH    
	xchg            
	inr   M         
L2E5FH	mov   A,C       
	pop   B         
	mov   C,A       
	push  B         
	mov   A,B       
	ora   A         
	rar             
	mov   B,A       
	inr   B         
	mov   E,B       
	mvi   D,00H     
	lxi   H,0FC17H   
	dad   D         
	call  L2C97H    
	pop   B         
	pop   H         
	mov   A,B       
	inr   C         
	dcr   C         
	jnz   L2EBBH    
	CPI   0FH       
	jz    L2EACH    
	Rrc             
	rlc             
	jnc   L2EBBH    
	push  B         
	push  H         
	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	mvi   B,08H     
L2E8BH	mov   A,M       
	ora   A         
	jnz   L2EA6H    
	inx   H         
	dcr   B         
	jnz   L2E8BH    
	pop   H         
	pop   B         
	mov   A,B       
	ora   A         
	rar             
	inr   A         
	mov   B,A       
	xra   A         
L2E9DH	mov   M,A       
	inx   H         
	dcr   B         
	jnz   L2E9DH    
	jmp   L2ECFH    
	
L2EA6H	pop   H         
	pop   B         
	mov   A,B       
	jmp   L2EBBH    
	
L2EACH	lda   0FC17H     
	mov   E,A       
	dcr   A         
	sta   0FC17H     
	xra   E         
	jp    L2E23H    
	jmp   L33EDH    ; Initialize FAC1 for SGL & .dbL precision to zero
	
L2EBBH	rar             
	mov   A,C       
	jc    L2EC6H    
	ora   M         
	mov   M,A       
	inx   H         
	jmp   L2ECBH    
	
L2EC6H	add   A         
	add   A         
	add   A         
	add   A         
	mov   M,A       
L2ECBH	dcr   B         
	jnz   L2E25H    
L2ECFH	lxi   H,0FC20H   ; Point to extended precision portion of FAC1
	lxi   D,0FC67H   ; Temp BCD value for computation?
	mvi   B,08H     ; Prepare to copy BCD value
	call  L3472H    ; Move B bytes from (DE) to M with decrement
	jmp   L2DA8H    
	
L2EDDH	mov   A,M       ; Get next byte from M
	stax  D         ; Save at (DE)
	inx   H         ; Increment source pointer
	inx   D         ; Increment destination pointer
	dcr   C         ; Decrement loop counter
	jnz   L2EDDH    ; Keep looping until C = 0
	ret             
	
	
; ======================================================
; Move C bytes from M to (DE)
; ======================================================
L2EE6H	mov   A,M       ; Get next byte from M
	stax  D         ; Store at (DE)
	dcx   H         ; Decrement source pointer
	dcx   D         ; Decrement dest pointer
	dcr   C         ; Decrement loop counter
	jnz   L2EE6H    ; Move C bytes from M to (DE)
	ret             
	
	
; ======================================================
; COS function
; ======================================================
BFCOS	lxi   H,L32CEH  ; Load pointer to FP 0.15915494309190
	call  L31A3H    ; Double precision math (FAC1=M * FAC2))
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	ANI   7FH       ; ABS(FAC1)
	sta   VVC1SD     ; Start of FAC1 for single and double precision
	lxi   H,L328EH  ; Load pointer to FP 0.2500000000000
	call  L319AH    ; Double precision subtract FP at (HL) from FAC1
	call  L33FDH    ; Perform ABS function on FAC1
	jmp   L2F0FH    
	
	
; ======================================================
; SIN function
; ======================================================
BFSIN	lxi   H,L32CEH  ; Load pointer to FP 0.15915494309190
	call  L31A3H    ; Double precision math (FAC1=M * FAC2))
L2F0FH	lda   VVC1SD     ; Start of FAC1 for single and double precision
	ora   A         ; Test if FAC1 negative
	cm    L31E3H    ; If negative, Take ABS(FAC1) and push return address to ABS(FAC1)
	call  L3234H    ; Push FAC1 on stack
	call  BFINT    ; INT function
	call  L31B5H    ; Move FAC1 to FAC2
	call  L324BH    ; Pop FAC1 from stack
	call  L2B69H    ; Double precision subtract (FAC1=FAC1-FAC2)
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	CPI   40H       
	jc    L2F52H    
	lda   0FC19H     ; Get 1st byte of BCD portion of FAC1
	CPI   25H       ; Test for 0.25
	jc    L2F52H    
	CPI   75H       ; Test for 0.75
	jnc   L2F49H    ; Subtract 1.00 from FAC1 and do table based math
	call  L31B5H    ; Move FAC1 to FAC2
	lxi   H,L327CH  ; Load pointer to FP 0.500000000
	call  L31C4H    ; Move floating point number M to FAC1
	call  L2B69H    ; Double precision subtract (FAC1=FAC1-FAC2)
	jmp   L2F52H    ; Jump to perform table based math for SIN function
	
L2F49H	lxi   H,L3286H  ; Load pointer to FP 1.000000000
	call  L31B8H    ; Move floating point number M to FAC2
	call  L2B69H    ; Double precision subtract (FAC1=FAC1-FAC2)
L2F52H	lxi   H,L335AH  ; Table of FP numbers for SIN function
	jmp   L31F7H    ; FAC1 = FAC1 * (FAC1^2 * table based math)
	
	
; ======================================================
; TAN function
; ======================================================
BFTAN	call  L3234H    ; Push FAC1 on stack
	call  BFCOS    ; COS function
	call  L31D2H    ; Swap FAC1 with Floating Point number on stack
	CALL  BFSin    ; SIN function
	call  L3245H    ; Pop FAC2 from stack
	lda   0FC69H     ; Start of FAC2 for single and double precision
	ora   A         ; Test if FAC2 is zero
	jnz   L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	jmp   L0455H    ; Generate OV error
	
	
; ======================================================
; ATN function
; ======================================================
BFATN	lda   VVC1SD     ; Start of FAC1 for single and double precision
	ora   A         ; Test if FAC1 is zero
	rz              ; Return if FAC1 is zero - answer also zero
	cm    L31E3H    ; If negative, take ABS(FAC1) and push return address to ABS(FAC1)
	CPI   41H       ; Test if FAC1 > 1.0
	jc    L2F99H    ; Perform series approximation for ATN
	call  L31B5H    ; Move FAC1 to FAC2
	lxi   H,L3286H  ; Load pointer to FP 1.000000000
	call  L31C4H    ; Move floating point number M to FAC1
	call  L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	call  L2F99H    ; Perform series approximation for ATN
	call  L31B5H    ; Move FAC1 to FAC2
	lxi   H,L32AEH  ; Load pointer to FP 1.5707963267949
	call  L31C4H    ; Move floating point number M to FAC1
	jmp   L2B69H    ; Double precision subtract (FAC1=FAC1-FAC2)
	
L2F99H	lxi   H,L32B6H  ; Load pointer to FP 0.26794919243112
	call  L31AFH    ; Double precision compare FAC1 with floating point at HL
	jm    L2FC9H    ; Do table based math for ATN
	call  L3234H    ; Push FAC1 on stack
	lxi   H,L32BEH  ; Load pointer to FP 1.7320508075689
	call  L3194H    ; Double precision add FP at (HL) to FAC1
	call  L31D2H    ; Swap FAC1 with Floating Point number on stack
	lxi   H,L32BEH  ; Load pointer to FP 1.7320508075689
	call  L31A3H    ; Double precision math (FAC1=M * FAC2))
	lxi   H,L3286H  ; Load pointer to FP 1.000000000
	call  L319AH    ; Double precision subtract FP at (HL) from FAC1
	call  L3245H    ; Pop FAC2 from stack
	call  L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	call  L2FC9H    ; Do Table based math for ATN
	lxi   H,L32C6H  ; Load pointer to FP 0.52359877559830
	jmp   L3194H    ; Double precision add FP at (HL) to FAC1
	
L2FC9H	lxi   H,L339BH  ; Load pointer to FP table for ATN
	jmp   L31F7H    ; FAC1 = FAC1 * (FAC1^2 * table based math)
	
	
; ======================================================
; LOG function
; ======================================================
BFLOG	rst   6         ; Get sign of FAC1
	jm    L08DBH    ; Generate FC error
	jz    L08DBH    ; Generate FC error
	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	mov   A,M       
	push  PSW       
	mvi   M,41H     
	lxi   H,L3296H  ; Load pointer to FP 3.1622776601684
	call  L31AFH    ; Double precision compare FAC1 with floating point at HL
	jm    L2FEDH    
	pop   PSW       
	inr   A         
	push  PSW       
	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	dcr   M         
L2FEDH	pop   PSW       
	sta   0FB8EH     
	call  L3234H    ; Push FAC1 on stack
	lxi   H,L3286H  ; Load pointer to FP 1.000000000
	call  L3194H    ; Double precision add FP at (HL) to FAC1
	call  L31D2H    ; Swap FAC1 with Floating Point number on stack
	lxi   H,L3286H  ; Load pointer to FP 1.000000000
	call  L319AH    ; Double precision subtract FP at (HL) from FAC1
	call  L3245H    ; Pop FAC2 from stack
	call  L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	call  L3234H    ; Push FAC1 on stack
	call  L31A0H    ; Double precision Square (FAC1=SQR(FAC1))
	call  L3234H    ; Push FAC1 on stack
	call  L3234H    ; Push FAC1 on stack
	lxi   H,L3331H  ; Point to 1st table of FP numbers for LOG
	call  L3209H    ; Table based math (FAC1=(((FAC1*M)+(M+1))*(M+2)+(M+3)...
	call  L31D2H    ; Swap FAC1 with Floating Point number on stack
	lxi   H,L3310H  ; Point to 2nd table of FP numbers for LOG
	call  L3209H    ; Table based math (FAC1=(((FAC1*M)+(M+1))*(M+2)+(M+3)...
	call  L3245H    ; Pop FAC2 from stack
	call  L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	call  L3245H    ; Pop FAC2 from stack
	call  L2CFFH    ; Double precision multiply (FAC1=FAC1*FAC2)
	lxi   H,L329EH  ; Load pointer to FP 0.86858896380650
	call  L3194H    ; Double precision add FP at (HL) to FAC1
	call  L3245H    ; Pop FAC2 from stack
	call  L2CFFH    ; Double precision multiply (FAC1=FAC1*FAC2)
	call  L3234H    ; Push FAC1 on stack
	lda   0FB8EH     
	SUI   41H       
	mov   L,A       
	add   A         
	sbb   A         
	mov   H,A       
	call  L3543H    ; Convert signed integer HL to single precision FAC1
	call  L35C2H    ; Convert FAC11 to double precision
	call  L3245H    ; Pop FAC2 from stack
	call  L2B78H    ; Double precision addition (FAC1=FAC1+FAC2)
	lxi   H,L32A6H  ; Load pointer to FP 2.3025850929940
	jmp   L31A3H    ; Double precision math (FAC1=M * FAC2))
	
	
; ======================================================
; SQR function
; ======================================================
BFSQR	rst   6         ; Get sign of FAC1
	rz              
	jm    L08DBH    ; Generate FC error
	call  L31B5H    ; Move FAC1 to FAC2
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	ora   A         
	rar             
	ACI   20H       
	sta   0FC69H     ; Start of FAC2 for single and double precision
	lda   0FC19H     ; Get 1st byte of BCD portion of FAC1
	ora   A         
	Rrc             
	ora   A         
	Rrc             
	ANI   33H       
	Adi   10H       
	sta   0FC6AH     
	mvi   A,07H     
L307CH	sta   0FB8EH     
	call  L3234H    ; Push FAC1 on stack
	call  L322EH    ; Push FAC2 on stack
	call  L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	call  L3245H    ; Pop FAC2 from stack
	call  L2B78H    ; Double precision addition (FAC1=FAC1+FAC2)
	lxi   H,L327CH  ; Load pointer to FP 0.500000000
	call  L31A3H    ; Double precision math (FAC1=M * FAC2))
	call  L31B5H    ; Move FAC1 to FAC2
	call  L324BH    ; Pop FAC1 from stack
	lda   0FB8EH     
	dcr   A         
	jnz   L307CH    
	jmp   L31C1H    ; Move FAC2 to FAC1
	
	
; ======================================================
; EXP function
; ======================================================
BFEXP	lxi   H,L3274H  
	call  L31A3H    ; Double precision math (FAC1=M * FAC2))
	call  L3234H    ; Push FAC1 on stack
	call  BFCINT    ; CINT function
	mov   A,L       
	ral             
	sbb   A         
	cmp   H         
	jz    L30CBH    
	mov   A,H       
	ora   A         
	jp    L30C8H    
	call  L35CFH    ; Set type of last variable to .dbL
	call  L324BH    ; Pop FAC1 from stack
	lxi   H,L327EH  
	jmp   L31C4H    ; Move floating point number M to FAC1
	
L30C8H	jmp   L0455H    ; Generate OV error
	
L30CBH	shld  0FB8EH     
	call  BFC.dbL    ; C.dbL function
	call  L31B5H    ; Move FAC1 to FAC2
	call  L324BH    ; Pop FAC1 from stack
	call  L2B69H    ; Double precision subtract (FAC1=FAC1-FAC2)
	lxi   H,L327CH  ; Load pointer to FP 0.500000000
	call  L31AFH    ; Double precision compare FAC1 with floating point at HL
	push  PSW       
	jz    L30EDH    
	jc    L30EDH    
	lxi   H,L327CH  ; Load pointer to FP 0.500000000
	call  L319AH    ; Double precision subtract FP at (HL) from FAC1
L30EDH	call  L3234H    ; Push FAC1 on stack
	lxi   H,L32F7H  ; Load pointer to FP table for EXP function
	call  L31F7H    ; FAC1 = FAC1 * (FAC1^2 * table based math)
	call  L31D2H    ; Swap FAC1 with Floating Point number on stack
	lxi   H,L32D6H  
	call  L31EBH    ; Square FAC1 & do table based math
	call  L3245H    ; Pop FAC2 from stack
	call  L322EH    ; Push FAC2 on stack
	call  L3234H    ; Push FAC1 on stack
	call  L2B69H    ; Double precision subtract (FAC1=FAC1-FAC2)
	lxi   H,0FC60H   ; Floating Point Temp 2
	call  L31CAH    ; Move FAC1 to M
	call  L3245H    ; Pop FAC2 from stack
	call  L324BH    ; Pop FAC1 from stack
	call  L2B78H    ; Double precision addition (FAC1=FAC1+FAC2)
	lxi   H,0FC60H   ; Floating Point Temp 2
	call  L31B8H    ; Move floating point number M to FAC2
	call  L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	pop   PSW       
	jc    L3130H    
	jz    L3130H    
	lxi   H,L3296H  ; Load pointer to FP 3.1622776601684
	call  L31A3H    ; Double precision math (FAC1=M * FAC2))
L3130H	lda   0FB8EH     
	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	mov   C,M       
	add   M         
	mov   M,A       
	xra   C         
	rp              
	jmp   L0455H    ; Generate OV error
	
	
; ======================================================
; RND function
; ======================================================
BFRND	rst   6         ; Get sign of FAC1
	lxi   H,0FC79H   ; Floating Point Temp 3
	jz    L3173H    ; If argument to RND is zero, then return last value
	cm    L31CAH    ; Move FAC1 to M
	lxi   H,0FC60H   ; Floating Point Temp 2
	lxi   D,0FC79H   ; Floating Point Temp 3
	call  L31CDH    ; Move Floating point at (DE) to M
	lxi   H,L3264H  ; Load pointer to FP 2.1132486540519e-65
	call  L31B8H    ; Move floating point number M to FAC2
	lxi   H,L325CH  ; Load pointer to FP 1.4389820420821e-65
	call  L31C4H    ; Move floating point number M to FAC1
	lxi   D,0FC67H   ; Load pointer to BCD_TEMP8
	call  L2D4BH    ; Multiply BCD at (DE) times FAC2
	lxi   D,0FC20H   ; Load pointer to extended precision portion of FAC1
	lxi   H,0FC7AH   ; Point to BCD portion of Floating point number
	mvi   B,07H     ; Prepare to move BCD portion of floating point
	call  L3469H    ; Move B bytes from (DE) to M with increment
	lxi   H,0FC79H   ; Floating Point Temp 3
	mvi   M,00H     ; Make RND seed exponent "e-65"
L3173H	call  L31C4H    ; Move floating point number M to FAC1
	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	mvi   M,40H     ; Make RND number a sane value < 1 (vs 1.332e-65, etc)
	xra   A         ; Clear A
	sta   0FC20H     ; Zero out 1st byte of extended precision portion of FAC1
	jmp   L2BDEH    ; Normalize FAC1 such that the 1st BCD digit isn't zero
	
	
; ======================================================
; Initialize FP_TEMP3 for new program
; ======================================================
L3182H	lxi   D,L326CH  ; Load pointer to REALLY small number
	lxi   H,0FC79H   ; Floating Point Temp 3
	jmp   L31CDH    ; Move Floating point at (DE) to M
	
	call  L3543H    ; Convert signed integer HL to single precision FAC1
	lxi   H,0FC79H   ; Floating Point Temp 3
	jmp   L31CAH    ; Move FAC1 to M
	
L3194H	call  L31B8H    ; Move floating point number M to FAC2
	jmp   L2B78H    ; Double precision addition (FAC1=FAC1+FAC2)
	
L319AH	call  L31B8H    ; Move floating point number M to FAC2
	jmp   L2B69H    ; Double precision subtract (FAC1=FAC1-FAC2)
	
	
; ======================================================
; Double precision Square (FAC1=SQR(FAC1))
; ======================================================
L31A0H	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	
; ======================================================
; Double precision math (FAC1=M * FAC2))
; ======================================================
L31A3H	call  L31B8H    ; Move floating point number M to FAC2
	jmp   L2CFFH    ; Double precision multiply (FAC1=FAC1*FAC2)
	
	call  L31B8H    ; Move floating point number M to FAC2
	jmp   L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	
L31AFH	call  L31B8H    ; Move floating point number M to FAC2
	jmp   L34D2H    ; Double precision compare FAC1 with FAC2
	
	
; ======================================================
; Move FAC1 to FAC2
; ======================================================
L31B5H	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	
; ======================================================
; Move floating point number M to FAC2
; ======================================================
L31B8H	lxi   D,0FC69H   ; Start of FAC2 for single and double precision
L31BBH	xchg            ; DE = floating point number to move, HL = FAC2
	call  L31CDH    ; Call routine to Move
	xchg            ; HL = Floating point number
	ret             
	
	
; ======================================================
; Move FAC2 to FAC1
; ======================================================
L31C1H	lxi   H,0FC69H   ; Start of FAC2 for single and double precision
	
; ======================================================
; Move floating point number M to FAC1
; ======================================================
L31C4H	lxi   D,VVC1SD   ; Start of FAC1 for single and double precision
	jmp   L31BBH    ; Jump to routine to copy FP in DE to HL
	
	
; ======================================================
; Swap FAC1 and FAC2
; ======================================================
L31CAH	lxi   D,VVC1SD   ; Start of FAC1 for single and double precision
L31CDH	mvi   B,08H     ; Prepare to move 8 bytes of floating point number
	jmp   L3469H    ; Move B bytes from (DE) to M with increment
	
L31D2H	pop   H         ; POP return address from stack
	shld  0FBE7H     ; Floating Point Temp 1
	call  L3245H    ; Pop FAC2 from stack
	call  L3234H    ; Push FAC1 on stack
	call  L31C1H    ; Move FAC2 to FAC1
	lhld  0FBE7H     ; Floating Point Temp 1
	pchl            ; RETurn (HL has return address)
	
L31E3H	call  L33FDH    ; Perform ABS function on FAC1
	lxi   H,L33FDH  ; Load address to Perform ABS function on FAC1
	xthl            ; Change return address to Perform ABS function on FAC1
	pchl            ; Return to calling program (we changed his RET address)
	
	
; ======================================================
; Square FAC1 & do table based math
; ======================================================
L31EBH	shld  0FBE7H     ; Floating Point Temp 1
	call  L31A0H    ; Double precision Square (FAC1=SQR(FAC1))
	lhld  0FBE7H     ; Floating Point Temp 1
	jmp   L3209H    ; Table based math (FAC1=(((FAC1*M)+(M+1))*(M+2)+(M+3)...
	
L31F7H	shld  0FBE7H     ; Floating Point Temp 1
	call  L3234H    ; Push FAC1 on stack
	lhld  0FBE7H     ; Floating Point Temp 1
	call  L31EBH    ; Square FAC1 & do table based math
	call  L3245H    ; Pop FAC2 from stack
	jmp   L2CFFH    ; Double precision multiply (FAC1=FAC1*FAC2)
	
	
; ======================================================
; Table based math (FAC1=(((FAC1*M)+(M+1))*(M+2)+(M+3)...
; ======================================================
L3209H	mov   A,M       ; Get count of products to add
	push  PSW       ; Save count on stack
	inx   H         ; Increment to first term
	push  H         ; Save address of first term on stack
	lxi   H,0FBE7H   ; Floating Point Temp 1
	call  L31CAH    ; Move FAC1 to M
	pop   H         ; Restore first term from stack
	call  L31C4H    ; Move floating point number M to FAC1
L3217H	pop   PSW       ; Restore count of products to add from stack
	dcr   A         ; Decrement count
	rz              ; Return if count = 0
	push  PSW       ; Save new count to stack
	push  H         ; Save address of next term to stack
	lxi   H,0FBE7H   ; Floating Point Temp 1
	call  L31A3H    ; Double precision math (FAC1=M * FAC2))
	pop   H         ; Restore address of next term from stack
	call  L31B8H    ; Move floating point number M to FAC2
	push  H         ; Save address to stack again
	call  L2B78H    ; Double precision addition (FAC1=FAC1+FAC2)
	pop   H         ; Restore address of next term from stack
	jmp   L3217H    ; Jump to process next term in series
	
	
; ======================================================
; Push FAC2 on stack
; ======================================================
L322EH	lxi   H,0FC70H   ; Point to end of FAC2
	jmp   L3237H    ; Jump to push 4 bytes to stack
	
	
; ======================================================
; Push FAC1 on stack
; ======================================================
L3234H	lxi   H,0FC1FH   ; Point to end of FAC1
L3237H	mvi   A,04H     ; Load byte counter
	pop   D         ; POP return address (so we can push to stack)
L323AH	mov   B,M       ; Get next BCD byte from (M) to MSB (BCD is stored big endian)
	dcx   H         ; Decrement to next higher byte
	mov   C,M       ; Get next BCD byte into LSB (BCD is stored big endian)
	dcx   H         ; Decrement to next higher byte
	push  B         ; Push next 2 bytes to stack
	dcr   A         ; Decrement counter (each count is 2 bytes)
	jnz   L323AH    ; Keep looping until 8 bytes (4 words) pushed
	xchg            ; Put RETurn address in HL
	pchl            ; RETurn (we modified the stack)
	
	
; ======================================================
; Pop FAC2 from stack
; ======================================================
L3245H	lxi   H,0FC69H   ; Start of FAC2 for single and double precision
	jmp   L324EH    ; Jump to POP a BCD value from the stack
	
	
; ======================================================
; Pop FAC1 from stack
; ======================================================
L324BH	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
L324EH	mvi   A,04H     ; Prepare to pop 4 words (8 bytes)
	pop   D         ; POP the return address to get to the BCD number
L3251H	pop   B         ; POP next 2 bytes
	mov   M,C       ; Move next byte to FAC1 / 2
	inx   H         ; Increment to next byte of FAC
	mov   M,B       ; Move next byte to FAC1 / 2
	inx   H         ; Increment to next byte of FAC
	dcr   A         ; Decrement word counter
	jnz   L3251H    ; Keep looping until 4 words POPed
	xchg            ; Put return address in HL
	pchl            ; Return (return address from stack is in HL)
	
	
; ======================================================
; Floating point numbers for math operations 
; ======================================================
L325CH
    .db	00H,14H,38H,98H,20H,42H,08H,21H          ; 1.4389820420821e-65 - RND
L3264H
    .db	00H,21H,13H,24H,86H,54H,05H,19H          ; 2.1132486540519e-65 - RND
L326CH
    .db	00H,40H,64H,96H,51H,37H,23H,58H          ; 4.0649651372358e-65 - BASIC initialize
L3274H
    .db	40H,43H,42H,94H,48H,19H,03H,24H          ; 0.43429448190324 - EXP
	
	
; ======================================================
; Floating point num-shares 6 bytes from next number
; ======================================================
L327CH
    .db	40H,50H          ; 0.500000000000 - SIN, SQR, EXP
	
	
; ======================================================
; Floating point numbers for math operations 
; ======================================================
L327EH
    .db	00H,00H,00H,00H,00H,00H,00H,00H          ; 0.0000000000000 - Various
L3286H
    .db	41H,10H,00H,00H,00H,00H,00H,00H          ; 1.0000000000000 - Various
L328EH
    .db	40H,25H,00H,00H,00H,00H,00H,00H          ; 0.2500000000000 - COS
L3296H
    .db	41H,31H,62H,27H,76H,60H,16H,84H          ; 3.1622776601684 - LOG & EXP
L329EH
    .db	40H,86H,85H,88H,96H,38H,06H,50H          ; 0.86858896380650 - LOG
L32A6H
    .db	41H,23H,02H,58H,50H,92H,99H,40H          ; 2.3025850929940 - LOG
L32AEH
    .db	41H,15H,70H,79H,63H,26H,79H,49H          ; 1.5707963267949 - ATN
L32B6H
    .db	40H,26H,79H,49H,19H,24H,31H,12H          ; 0.26794919243112 - ATN
L32BEH
    .db	41H,17H,32H,05H,08H,07H,56H,89H          ; 1.7320508075689 - ATN
L32C6H
    .db	40H,52H,35H,98H,77H,55H,98H,30H          ; 0.52359877559830 - ATN
L32CEH
    .db	40H,15H,91H,54H,94H,30H,91H,90H          ; 0.15915494309190 - SIN & COS
	
	
; ======================================================
; Count of Floating point numbers to follow for EXP
; ======================================================
L32D6H
    .db	04H             
	
    .db	41H,10H,00H,00H,00H,00H,00H,00H          ; 1.0000000000000
    .db	43H,15H,93H,74H,15H,23H,60H,31H          ; 159.37415236031
    .db	44H,27H,09H,31H,69H,40H,85H,16H          ; 2709.3169408516
    .db	44H,44H,97H,63H,35H,57H,40H,58H          ; 4497.6335574058
	
	
; ======================================================
; Count of Floating point numbers to follow for EXP
; ======================================================
L32F7H
    .db	03H             
	
    .db	42H,18H,31H,23H,60H,15H,92H,75H          ; 18.312360159275
    .db	43H,83H,14H,06H,72H,12H,93H,71H          ; 831.40672129371
    .db	44H,51H,78H,09H,19H,91H,51H,62H          ; 5178.0919915162
	
	
; ======================================================
; Count of Floating point numbers to follow for LOG
; ======================================================
L3310H
    .db	04H             
	
    .db	0C0H,71H,43H,33H,82H,15H,32H,26H          ; -0.71433382153226
    .db	41H,62H,50H,36H,51H,12H,79H,08H          ; 6.2503651127908
    .db	0C2H,13H,68H,23H,70H,24H,15H,03H          ; -13.682370241503
    .db	41H,85H,16H,73H,19H,87H,23H,89H          ; 8.5167319872389
	
	
; ======================================================
; Count of Floating point numbers to follow for LOG
; ======================================================
L3331H
    .db	05H             
	
    .db	41H,10H,00H,00H,00H,00H,00H,00H          ; 1.0000000000000
    .db	0C2H,13H,21H,04H,78H,35H,01H,56H          ; -13.210478350156
    .db	42H,47H,92H,52H,56H,04H,38H,73H          ; 47.925256043873
    .db	0C2H,64H,90H,66H,82H,74H,09H,43H          ; -64.906682740943
    .db	42H,29H,41H,57H,50H,17H,23H,23H          ; 29.415750172323
	
	
; ======================================================
; Count of Floating point numbers to follow for SIN
; ======================================================
L335AH
    .db	08H             
	
    .db	0C0H,69H,21H,56H,92H,29H,18H,09H          ; -0.69215692291809
    .db	41H,38H,17H,28H,86H,38H,57H,71H          ; 3.8172886385771
    .db	0C2H,15H,09H,44H,99H,47H,48H,01H          ; -15.094499474801
    .db	42H,42H,05H,86H,89H,66H,73H,55H          ; 42.058689667355
    .db	0C2H,76H,70H,58H,59H,68H,32H,91H          ; -76.705859683291
    .db	42H,81H,60H,52H,49H,27H,55H,13H          ; 81.605249275513
    .db	0C2H,41H,34H,17H,02H,24H,03H,98H          ; -41.341702240398
    .db	41H,62H,83H,18H,53H,07H,17H,96H          ; 6.2831853071796
	
	
; ======================================================
; Count of Floating point numbers to follow for ATN
; ======================================================
L339BH
    .db	08H             
	
    .db	0BFH,52H,08H,69H,39H,04H,00H,00H          ; -0.052086939040000
    .db	3FH,75H,30H,71H,49H,13H,48H,00H          ; 0.075307149134800
    .db	0BFH,90H,81H,34H,32H,24H,70H,50H          ; -0.090813432247050
    .db	40H,11H,11H,07H,94H,18H,40H,29H          ; 0.11110794184029
    .db	0C0H,14H,28H,57H,08H,55H,48H,84H          ; Different from M1002
    .db	40H,19H,99H,99H,99H,94H,89H,67H          ; 0.19999999948967
    .db	0C0H,33H,33H,33H,33H,33H,31H,60H          ; -0.33333333333160
    .db	41H,10H,00H,00H,00H,00H,00H,00H          ; 1.0000000000000
	
	
; ======================================================
; RST 30H routine
; ======================================================
L33DCH	lda   VVC1SD     ; Start of FAC1 for single and double precision
	ora   A         ; Test if zero
	rz              ; Return if zero
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	jmp   L33E8H    ; Return 1 or -1 in A based on Sign bit in A
	
L33E7H	cma             ; Compliment sign of A
L33E8H	ral             ; Rotate sign bit to C flag
L33E9H	sbb   A         ; Subtract with borrow generates -1 or 0 based on C
	rnz             ; Return if -1
	inr   A         ; Increment zero to 1
	ret             
	
L33EDH	xra   A         ; Zero out A
	sta   VVC1SD     ; Start of FAC1 for single and double precision
	ret             
	
	
; ======================================================
; ABS function
; ======================================================
BFABS	call  L3411H    ; Determine sign of last variable used
	rp              ; Return if already positive
L33F6H	rst   5         ; Determine type of last var used
	jm    L37D0H    ; If integer, jump to ABS function for integer FAC1
	jz    L045BH    ; Generate TM error
L33FDH	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	mov   A,M       ; Get sign / decimal point byte
	ora   A         ; Test if FAC1 is zero
	rz              ; Return if zero
	XRI   80H       ; Invert the sign bit - make positive
	mov   M,A       ; Save inverted sign bit to FAC1
	ret             
	
	
; ======================================================
; SGN function
; ======================================================
BFSGN	call  L3411H    ; Get sign in A of last variable used
L340AH	mov   L,A       ; Move sign to LSB of HL
	ral             ; Prepare to sign extend into MSB
	sbb   A         ; Generate zero or 1 based C flag (sign of integer)
	mov   H,A       ; Sign extend into MSB of HL (HL has 0FFFFH, 0001H or 0000H)
	jmp   L3510H    ; Load signed integer in HL to FAC1
	
L3411H	rst   5         ; Determine type of last var used
	jz    L045BH    ; Generate TM error
	jp    L33DCH    ; RST 30H routine
	lhld  VFAC1I     ; Start of FAC1 for integers
L341BH	mov   A,H       ; Get MSB of integer
	ora   L         ; OR in LSB to test for zero
	rz              ; Return if zero
L341EH	mov   A,H       ; Get MSB of integer to test sign
	jmp   L33E8H    ; Return 1 or -1 in A based on Sign bit in A
	
	
; ======================================================
; Push single precision FAC1 on stack
; ======================================================
L3422H	xchg            
	lhld  VFAC1I     ; Start of FAC1 for integers
	xthl            
	push  H         
	lhld  VVC1SD     ; Start of FAC1 for single and double precision
	xthl            
	push  H         
	xchg            
	ret             
	
	
; ======================================================
; Load single precision at M to FAC1
; ======================================================
	call  L3450H    ; Reverse load single precision at M to DEBC
	
; ======================================================
; Load single precision in BCDE to FAC1
; ======================================================
L3432H	xchg            ; Load DE to HL, save HL
	shld  VFAC1I     ; Start of FAC1 for integers
	mov   H,B       ; Copy MSB of BE to HL
	mov   L,C       ; Copy LSB
	shld  VVC1SD     ; Start of FAC1 for single and double precision
	xchg            ; Restore HL
	ret             
	
	
; ======================================================
; Load single precision FAC1 to BCDE
; ======================================================
L343DH	lhld  VFAC1I     ; Start of FAC1 for integers
	xchg            ; Move LSW of FAC1 to DE
	lhld  VVC1SD     ; Start of FAC1 for single and double precision
	mov   C,L       ; Copy LSB of MSW from FAC1 to C
	mov   B,H       ; Copy MSB of FAC1 to B
	ret             
	
	
; ======================================================
; Load single precision at M to BCDE
; ======================================================
L3447H	mov   C,M       ; Load 2 MSB BCD digits to C
	inx   H         ; Increment to next 2 BCD digits
	mov   B,M       ; Load next 2 BCD to B
	inx   H         ; Increment to next 2 lower digits
	mov   E,M       ; Load next 2 BCD to E
	inx   H         ; Increment to least significant BCD digits
	mov   D,M       ; Load 2 LSB BCD digits to D
	inx   H         ; Increment to next BCD
	ret             
	
	
; ======================================================
; Reverse load single precision at M to DEBC
; ======================================================
L3450H	mov   E,M       ; Load 2 MSB BCD digits to E
	inx   H         ; Increment to next 2 lower BCD digits
L3452H	mov   D,M       ; Move next 2 BCD to D
	inx   H         ; Increment to next 2 lower BCD digits
	mov   C,M       ; Load next 2 BCD to C
	inx   H         ; Increment to 2 least significant BCD digits
	mov   B,M       ; Load 2 LSB BCD digits to B
L3457H	inx   H         ; Final increment
	ret             
	
	
; ======================================================
; Move single precision FAC1 to M
; ======================================================
L3459H	lxi   D,VVC1SD   ; Start of FAC1 for single and double precision
	mvi   B,04H     ; Prepare to copy 4 bytes
	jmp   L3469H    ; Move B bytes from (DE) to M with increment
	
	
; ======================================================
; Move M to FAC2 using precision at (0FB65H)
; ======================================================
L3461H	lxi   D,0FC69H   ; Start of FAC2 for single and double precision
L3464H	xchg            ; Swap SRC and DEST address in HL & DE
L3465H	lda   0FB65H     ; Type of last variable used
	mov   B,A       ; Prepare to copy bytes based on precision of last var (2, 4 or 8)
	
; ======================================================
; Move B bytes from (DE) to M with increment
; ======================================================
L3469H	ldax  D         ; Load next byte to copy
	mov   M,A       ; Save byte in destination address
	inx   D         ; Increment source pointer
	inx   H         ; Increment destination pointer
	dcr   B         ; Decrement byte counter
	jnz   L3469H    ; Move B bytes from (DE) to M with increment
	ret             
	
	
; ======================================================
; Move B bytes from (DE) to M with decrement
; ======================================================
L3472H	ldax  D         ; Load next byte to copy
	mov   M,A       ; Save next byte to destination
	dcx   D         ; Decrement source pointer
	dcx   H         ; Decrement destination pointer
	dcr   B         ; Decrement counter
	jnz   L3472H    ; Move B bytes from (DE) to M with decrement
	ret             
	
L347BH	lxi   H,0FC69H   ; Start of FAC2 for single and double precision
L347EH	lxi   D,L3464H  ; Copy (HL) to (DE) using precision of last var used (0FB65H)
	jmp   L348AH    ; Jump to push copy operation to stack & copy to from FAC1
	
L3484H	lxi   H,0FC69H   ; Start of FAC2 for single and double precision
L3487H	lxi   D,L3465H  ; Copy (DE) to (HL) using precision of last var used (0FB65H)
L348AH	push  D         ; Push address of copy operation to stack
	lxi   D,VVC1SD   ; Start of FAC1 for single and double precision
	lda   0FB65H     ; Type of last variable used
	CPI   02H       ; Test if type of last variable is integer
	rnz             ; Return to start copy if not integer FAC
	lxi   D,VFAC1I   ; Start of FAC1 for integers
	ret             ; Return to PUSHed copy routine to perform copy (to / from FAC1)
	
	
; ======================================================
; Compare single precision in BCDE with FAC1
; ======================================================
L3498H	mov   A,C       ; Move sign/decimal point to A
	ora   A         ; Test if value is zero
	jz    L33DCH    ; RST 30H routine
	lxi   H,L33E7H  ; Load address of routine to teturn 1 or -1 in A
	push  H         ; Push new return address to stack to return SGN
	rst   6         ; Get sign of FAC1
	mov   A,C       ; Move sign/decimal point of BCDE to A
	rz              ; If FAC1 is zero, return to calc sign of BCDE as return value
	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	xra   M         ; Compare sign bit of BCDE and FAC1
	mov   A,C       ; Get sign/decimal point of BCDE in A
	rm              ; Return to calc sign of BCDE as result if BCDE & FAC1 have different sign
	call  L34B0H    ; Compare single precision in BCDE with M
	rar             ; Rotate the C bit into A to determine which is bigger based on sign
	xra   C         ; XOR the sign of BCDE with A
	ret             ; Return to routine to calc 1 or -1 base on sign of A
	
	
; ======================================================
; Compare single precision in BCDE with M
; ======================================================
L34B0H	mov   A,C       
	cmp   M         
	rnz             
	inx   H         
	mov   A,B       
	cmp   M         
	rnz             
	inx   H         
	mov   A,E       
	cmp   M         
	rnz             
	inx   H         
	mov   A,D       
	sub   M         
	rnz             
	pop   H         
	pop   H         
	ret             
	
	
; ======================================================
; Compare signed integer in DE with that in HL
; ======================================================
L34C2H	mov   A,D       ; Prepare to compare MSB of DE and HL
	xra   H         ; Test if sign of 2 integers are different
	mov   A,H       ; Load sign of H in case they are different
	jm    L33E8H    ; Return 1 or -1 in A based on Sign bit in A
	cmp   D         ; Compare MSB of DE and HL to test if .equal
	jnz   L34CFH    ; Jump if not .equal to determine which is bigger
	mov   A,L       ; Prepare to compare LSB of HL and DE
	sub   E         ; Compare LSB of HL and DE
	rz              ; Return zero in A if they are .equal
L34CFH	jmp   L33E9H    ; Return 1 or -1 in A based on Carry flag
	
L34D2H	lxi   D,0FC69H   ; Start of FAC2 for single and double precision
	ldax  D         ; Get Sign and Decimal point location for FAC2
	ora   A         ; Test if FAC2 is zero
	jz    L33DCH    ; RST 30H routine
	lxi   H,L33E7H  ; Return 1 or -1 in A based on Inverse of Sign bit in A
	push  H         ; Push address of routine to return 1 or -1 based on A to stack
	rst   6         ; Get sign of FAC1
	ldax  D         ; Get Sign and Decimal point location for FAC2
	mov   C,A       ; Save sign of FAC2 in C
	rz              ; If FAC1 is zero, return to calculate 1 or -1 base on sign of FAC2
	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	xra   M         ; XOR sign bit of FAC1 and FAC2 to determine if they are .equal
	mov   A,C       ; Restore sign of FAC2 to A
	rm              ; Return to calculate 1 or -1 based on sign of FAC2 if sign of FAC1 != FAC2
	mvi   B,08H     ; Prepare to compare 8 bytes of floating point
L34EAH	ldax  D         ; Get next byte from FAC2
	sub   M         ; Subtract next byte from FAC1
	jnz   L34F7H    ; If not .equal, jump to determine which is bigger
	inx   D         ; Point to next byte of FAC2
	inx   H         ; Increment to next byte of FAC1
	dcr   B         ; Decrement byte counter
	jnz   L34EAH    ; Keep looping until 8 bytes compared
	pop   B         ; POP address of of SIGN routine ... they are .equal and A already has zero
	ret             
	
L34F7H	rar             ; Get C flag from last subtract
	xra   C         ; XOR with sign of FAC1 & FAC2
	ret             ; Return to calculate 1 or -1 based on A
	
	
; ======================================================
; Compare double precision FAC1 with FAC2
; ======================================================
	call  L34D2H    ; Double precision compare FAC1 with FAC2
	jnz   L33E7H    ; Return 1 or -1 in A based on Inverse of Sign bit in A
	ret             
	
	
; ======================================================
; CINT function
; ======================================================
BFCINT	rst   5         ; Determine type of last var used
	lhld  VFAC1I     ; Start of FAC1 for integers
	rm              ; Return if already an integer
	jz    L045BH    ; Generate TM error
	call  L35DEH    
	jc    L0455H    ; Generate OV error
	xchg            
	
; ======================================================
; Load signed integer in HL to FAC1
; ======================================================
L3510H	shld  VFAC1I     ; Start of FAC1 for integers
L3513H	mvi   A,02H     ; Load code for integer type variable
L3515H	sta   0FB65H     ; Type of last variable used
	ret             
	
L3519H	lxi   B,L32C5H  ; SNGL precision value for 32768
	lxi   D,8076H   ; "
	call  L3498H    ; Compare single precision in BCDE with FAC1
	rnz             ; Return if FAC1 != 32768.0
	lxi   H,8000H   ; Load HL with Decimal 32768
L3526H	pop   D         
	jmp   L3510H    ; Load signed integer in HL to FAC1
	
	
; ======================================================
; CSNG function
; ======================================================
BFCSNG	rst   5         ; Determine type of last var used
	rpo             
	jm    L3540H    ; Convert signed integer in FAC1 to single precision
	jz    L045BH    ; Generate TM error
	call  L35D4H    ; Set type of last variable to SGL
	call  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
	inx   H         
	mov   A,B       
	ora   A         
	rar             
	mov   B,A       
	jmp   L2C2CH    
	
	
; ======================================================
; Convert signed integer in FAC1 to single precision
; ======================================================
L3540H	lhld  VFAC1I     ; Start of FAC1 for integers
	
; ======================================================
; Convert signed integer HL to single precision FAC1
; ======================================================
L3543H	mov   A,H       
L3544H	ora   A         
	push  PSW       
	cm    L37C6H    
	call  L35D4H    ; Set type of last variable to SGL
	xchg            
	lxi   H,0000H  
	shld  VVC1SD     ; Start of FAC1 for single and double precision
	shld  VFAC1I     ; Start of FAC1 for integers
	mov   A,D       
	ora   E         
	jz    L27E2H    
	lxi   B,L0500H  
	lxi   H,0FC19H   ; Point to BCD portion of FAC1
	push  H         
	lxi   H,L35B0H  
L3565H	mvi   A,0FFH     
	push  D         
	mov   E,M       
	inx   H         
	mov   D,M       
	inx   H         
	xthl            
	push  B         
L356EH	mov   B,H       
	mov   C,L       
	dad   D         
	inr   A         
	jc    L356EH    
	mov   H,B       
	mov   L,C       
	pop   B         
	pop   D         
	xchg            
	inr   C         
	dcr   C         
	jnz   L358BH    
	ora   A         
	jz    L35A1H    
	push  PSW       
	mvi   A,40H     
	add   B         
	sta   VVC1SD     ; Start of FAC1 for single and double precision
	pop   PSW       
L358BH	inr   C         
	xthl            
	push  PSW       
	mov   A,C       
	rar             
	jnc   L359CH    
	pop   PSW       
	add   A         
	add   A         
	add   A         
	add   A         
	mov   M,A       
	jmp   L35A0H    
	
L359CH	pop   PSW       
	ora   M         
	mov   M,A       
	inx   H         
L35A0H	xthl            
L35A1H	mov   A,D       
	ora   E         
	jz    L35AAH    
	dcr   B         
	jnz   L3565H    
L35AAH	pop   H         
	pop   PSW       
	rp              
	jmp   L33FDH    ; Perform ABS function on FAC1
	
; ======================================================
; 35B0H: Table used during signed integer HL to FAC1 conversion
; ======================================================
L35B0H
    .dw  0D8F0H, 0FC18H
    .dw  0FF9CH, 0FFF6H, 0FFFFH

; ======================================================
; C.dbL function
; ======================================================
BFC.dbL	rst   5         ; Determine type of last var used
	rnc             ; Return if already double precision
	jz    L045BH    ; Generate TM error
	cm    L3540H    ; Convert signed integer in FAC1 to single precision
L35C2H	lxi   H,0000H   ; Prepare to "zero out" the double precision portion of FAC1
	shld  0FC1CH     ; Zero out next 4 digits of FAC1
	shld  0FC1EH     ; Zero out least 4 significant digits of FAC1
	mov   A,H       ; Prepare to zero out extended precision portion of FAC1
	sta   0FC20H     ; Zero out extended precision portion of FAC1
L35CFH	mvi   A,08H     ; Load code for double precision variable type
	jmp   L35D6H    ; Jump to set type of last variable
	
L35D4H	mvi   A,04H     ; Load code for Single Precision variable type
L35D6H	jmp   L3515H    ; Save type of last variable from A
	
L35D9H	rst   5         ; Determine type of last var used
	rz              ; Return if type is string
	jmp   L045BH    ; Generate TM error
	
L35DEH	lxi   H,L3641H  
	push  H         
	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	mov   A,M       
	ANI   7FH       
	CPI   46H       
	rnc             
	SUI   41H       
	jnc   L35F6H    
	ora   A         
	pop   D         
	lxi   D,0000H  
	ret             
	
L35F6H	inr   A         
	mov   B,A       
	
; ======================================================
; Signed integer subtract (FAC1=HL-DE)
; ======================================================
	lxi   D,0000H  
	mov   C,D       
	inx   H         
L35FDH	mov   A,C       
	inr   C         
	rar             
	mov   A,M       
	jc    L360BH    
	rar             
	rar             
	rar             
	rar             
	jmp   L360CH    
	
L360BH	inx   H         
L360CH	ANI   0FH       
	shld  0FC12H     
	mov   H,D       
	mov   L,E       
	dad   H         
	rc              
	dad   H         
	rc              
	dad   D         
	rc              
	dad   H         
	rc              
	mov   E,A       
	mvi   D,00H     
L361EH	dad   D         
	rc              
	xchg            
	lhld  0FC12H     
	dcr   B         
	jnz   L35FDH    
	lxi   H,8000H   
	rst   3         ; Compare DE and HL
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	rc              
	jz    L363DH    
	pop   H         
	ora   A         
	rp              
	xchg            
	call  L37C6H    
	xchg            
	ora   A         
	ret             
	
L363DH	ora   A         
	rp              
	pop   H         
	ret             
	
L3641H	stc             
	ret             
	
L3643H	dcx   B         
	ret             
	
	
; ======================================================
; FIX function
; ======================================================
BFFIX	rst   5         ; Determine type of last var used
	rm              
	rst   6         ; Get sign of FAC1
	jp    BFINT    ; INT function
	call  L33FDH    ; Perform ABS function on FAC1
	call  BFINT    ; INT function
	jmp   L33F6H    
	
	
; ======================================================
; INT function
; ======================================================
BFINT	rst   5         ; Determine type of last var used
	rm              
	lxi   H,0FC20H   ; Temp BCD value for computation?
	mvi   C,0EH     
	jnc   L3666H    
	jz    L045BH    ; Generate TM error
	lxi   H,0FC1CH   
	mvi   C,06H     
L3666H	lda   VVC1SD     ; Start of FAC1 for single and double precision
	ora   A         
	jm    L3688H    
	ANI   7FH       
	SUI   41H       
	jc    L33EDH    ; Initialize FAC1 for SGL & .dbL precision to zero
	inr   A         
	sub   C         
	rnc             
	cma             
	inr   A         
	mov   B,A       
L367AH	dcx   H         
	mov   A,M       
	ANI   0F0H       
	mov   M,A       
	dcr   B         
	rz              
	xra   A         
	mov   M,A       
	dcr   B         
	jnz   L367AH    
	ret             
	
L3688H	ANI   7FH       
	SUI   41H       
	jnc   L3695H    
	lxi   H,0FFFFH   
	jmp   L3510H    ; Load signed integer in HL to FAC1
	
L3695H	inr   A         
	sub   C         
	rnc             
	cma             
	inr   A         
	mov   B,A       
	mvi   E,00H     
L369DH	dcx   H         
	mov   A,M       
	mov   D,A       
	ANI   0F0H       
	mov   M,A       
	cmp   D         
	jz    L36A8H    
	inr   E         
L36A8H	dcr   B         
	jz    L36B7H    
	xra   A         
	mov   M,A       
	cmp   D         
	jz    L36B3H    
	inr   E         
L36B3H	dcr   B         
	jnz   L369DH    
L36B7H	inr   E         
	dcr   E         
	rz              
	mov   A,C       
	CPI   06H       
	lxi   B,L10C1H  
	lxi   D,0000H  
	jz    L37F4H    ; Single precision addition (FAC1=FAC1+BCDE)
	xchg            
	shld  0FC6FH     
	shld  0FC6DH     
	shld  0FC6BH     ; Start of FAC2 for integers
	mov   H,B       
	mov   L,C       
	shld  0FC69H     ; Start of FAC2 for single and double precision
	jmp   L2B78H    ; Double precision addition (FAC1=FAC1+FAC2)
	
L36D8H	push  H         
	lxi   H,0000H  
	mov   A,B       
	ora   C         
	jz    L36F5H    
	mvi   A,10H     
L36E3H	dad   H         
	jc    L48F6H    
	xchg            
	dad   H         
	xchg            
	jnc   L36F1H    
	dad   B         
	jc    L48F6H    
L36F1H	dcr   A         
	jnz   L36E3H    
L36F5H	xchg            
	pop   H         
	ret             
	
	mov   A,H       
	ral             
	sbb   A         
	mov   B,A       
	call  L37C6H    
	mov   A,C       
	sbb   B         
	jmp   L3707H    
	
	
; ======================================================
; Signed integer addition (FAC1=HL+DE)
; ======================================================
L3704H	mov   A,H       
	ral             
	sbb   A         
L3707H	mov   B,A       
	push  H         
	mov   A,D       
	ral             
	sbb   A         
	dad   D         
	adc   B         
	Rrc             
	xra   H         
	jp    L3526H    
	push  B         
	xchg            
	call  L3543H    ; Convert signed integer HL to single precision FAC1
	pop   PSW       
	pop   H         
	call  L3422H    ; Push single precision FAC1 on stack
	call  L3543H    ; Convert signed integer HL to single precision FAC1
	pop   B         
	pop   D         
	jmp   L37F4H    ; Single precision addition (FAC1=FAC1+BCDE)
	
	
; ======================================================
; Signed integer muliply (FAC1=HL*DE)
; ======================================================
L3725H	mov   A,H       
	ora   L         
	jz    L3510H    ; Load signed integer in HL to FAC1
	push  H         
	push  D         
	call  L37BAH    
	push  B         
	mov   B,H       
	mov   C,L       
	lxi   H,0000H  
	mvi   A,10H     
L3737H	dad   H         
	jc    L375FH    
	xchg            
	dad   H         
	xchg            
	jnc   L3745H    
	dad   B         
	jc    L375FH    
L3745H	dcr   A         
	jnz   L3737H    
	pop   B         
	pop   D         
L374BH	mov   A,H       
	ora   A         
	jm    L3755H    
	pop   D         
	mov   A,B       
	jmp   L37C2H    
	
L3755H	XRI   80H       
	ora   L         
	jz    L3770H    
	xchg            
	jmp   L3761H    
	
L375FH	pop   B         
	pop   H         
L3761H	call  L3543H    ; Convert signed integer HL to single precision FAC1
	pop   H         
	call  L3422H    ; Push single precision FAC1 on stack
	call  L3543H    ; Convert signed integer HL to single precision FAC1
	pop   B         
	pop   D         
	jmp   L3803H    ; Single precision multiply (FAC1=FAC1*BCDE)
	
L3770H	mov   A,B       
	ora   A         
	pop   B         
	jm    L3510H    ; Load signed integer in HL to FAC1
	push  D         
	call  L3543H    ; Convert signed integer HL to single precision FAC1
	pop   D         
	jmp   L33FDH    ; Perform ABS function on FAC1
	
	
; ======================================================
; Signed integer divide (FAC1=DE/HL)
; ======================================================
L377EH	mov   A,H       
	ora   L         
	jz    L0449H    ; Generate /0 error
	call  L37BAH    
	push  B         
	xchg            
	call  L37C6H    
	mov   B,H       
	mov   C,L       
	lxi   H,0000H  
	mvi   A,11H     
	push  PSW       
	ora   A         
	jmp   L37A3H    
	
L3797H	push  PSW       
	push  H         
	dad   B         
	jnc   L37A2H    
	pop   PSW       
	stc             
	jmp   L37A3H    
	
L37A2H	pop   H         
L37A3H	mov   A,E       
	ral             
	mov   E,A       
	mov   A,D       
	ral             
	mov   D,A       
	mov   A,L       
	ral             
	mov   L,A       
	mov   A,H       
	ral             
	mov   H,A       
	pop   PSW       
	dcr   A         
	jnz   L3797H    
	xchg            
	pop   B         
	push  D         
	jmp   L374BH    
	
L37BAH	mov   A,H       
	xra   D         
	mov   B,A       
	call  L37C1H    
	xchg            
L37C1H	mov   A,H       
L37C2H	ora   A         
	jp    L3510H    ; Load signed integer in HL to FAC1
L37C6H	xra   A         
	mov   C,A       
	sub   L         
	mov   L,A       
	mov   A,C       
	sbb   H         
	mov   H,A       
	jmp   L3510H    ; Load signed integer in HL to FAC1
	
L37D0H	lhld  VFAC1I     ; Start of FAC1 for integers
	call  L37C6H    
	mov   A,H       
	XRI   80H       
	ora   L         
	rnz             
L37DBH	xra   A         ; Clear A to perform unsigned comparison
	jmp   L3544H    ; Jump into Convert Signed to single precision in FAC1
	
L37DFH	push  D         
	call  L377EH    ; Signed integer divide (FAC1=DE/HL)
	xra   A         
	add   D         
	rar             
	mov   H,A       
	mov   A,E       
	rar             
	mov   L,A       
	call  L3513H    
	pop   PSW       
	jmp   L37C2H    
	
	call  L3450H    ; Reverse load single precision at M to DEBC
	
; ======================================================
; Single precision addition (FAC1=FAC1+BCDE)
; ======================================================
L37F4H	call  L3827H    ; Single precision load (FAC2=BCDE)
	
; ======================================================
; Single precision addition (FAC1=FAC1+FAC2)
; ======================================================
	call  L35C2H    ; Convert FAC1 to double precision
	jmp   L2B78H    ; Double precision addition (FAC1=FAC1+FAC2)
	
	
; ======================================================
; Single precision subtract (FAC1=FAC1-BCDE)
; ======================================================
L37FDH	call  L33FDH    ; Perform ABS function on FAC1
	jmp   L37F4H    ; Single precision addition (FAC1=FAC1+BCDE)
	
	
; ======================================================
; Single precision multiply (FAC1=FAC1*BCDE)
; ======================================================
L3803H	call  L3827H    ; Single precision load (FAC2=BCDE)
	
; ======================================================
; Single precision multiply (FAC1=FAC2*FAC2)
; ======================================================
	call  L35C2H    ; Convert FAC1 to double precision
	jmp   L2CFFH    ; Double precision multiply (FAC1=FAC1*FAC2)
	
L380CH	pop   B         
	pop   D         
	
; ======================================================
; Single precision divide (FAC1=BCDE/FAC1)
; ======================================================
	lhld  VFAC1I     ; Start of FAC1 for integers
	xchg            
	shld  VFAC1I     ; Start of FAC1 for integers
	push  B         
	lhld  VVC1SD     ; Start of FAC1 for single and double precision
	xthl            
	shld  VVC1SD     ; Start of FAC1 for single and double precision
	pop   B         
L381EH	call  L3827H    ; Single precision load (FAC2=BCDE)
	call  L35C2H    ; Convert FAC11 to double precision
	jmp   L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	
	
; ======================================================
; Single precision load (FAC2=BCDE)
; ======================================================
L3827H	xchg            
	shld  0FC6BH     ; Start of FAC2 for integers
	mov   H,B       
	mov   L,C       
	shld  0FC69H     ; Start of FAC2 for single and double precision
	lxi   H,0000H  
	shld  0FC6DH     
	shld  0FC6FH     
	ret             
	
L383AH	dcr   A         
	ret             
	
L383CH	dcx   H         
	ret             
	
L383EH	pop   H         
	ret             
	
	
; ======================================================
; Convert ASCII number at M to double precision in FAC1
; ======================================================
L3840H	xchg            
	lxi   B,L00FFH  
	mov   H,B       
	mov   L,B       
	call  L3510H    ; Load signed integer in HL to FAC1
	xchg            
	mov   A,M       
	CPI   2DH       
	push  PSW       
	jz    L3857H    
	CPI   2BH       
	jz    L3857H    
	dcx   H         
L3857H	rst   2         ; Get next non-white char from M
	jc    L3940H    ; Convert ASCII number that starts with a Digit
	CPI   2EH       
	jz    L3904H    ; Found '.' in ASCII number
	CPI   65H       
	jz    L3867H    ; Found 'e' in ASCII number
	CPI   45H       
	
; ======================================================
; Found 'e' in ASCII number
; ======================================================
L3867H	jnz   L388AH    ; Found 'E' in ASCII number
	push  H         
	rst   2         ; Get next non-white char from M
	CPI   6CH       
	jz    L387DH    
	CPI   4CH       
	jz    L387DH    
	CPI   71H       
	jz    L387DH    
	CPI   51H       
L387DH	pop   H         
	jz    L3889H    
	rst   5         ; Determine type of last var used
	jnc   L38A3H    
	xra   A         
	jmp   L38A4H    
	
L3889H	mov   A,M       
	
; ======================================================
; Found 'E' in ASCII number
; ======================================================
L388AH	CPI   25H       ; Compare next byte with '%'
	jz    L391AH    ; Found '%' in ASCII number
	CPI   23H       ; Compare next byte with '#'
	jz    L3929H    ; Found '#' in ASCII number
	CPI   21H       ; Compare next byte with '!'
	jz    L392AH    ; Jump if found '!' in ASCII number
	CPI   64H       ; Compare next byte with 'd'
	jz    L38A3H    
	CPI   44H       ; Compare next byte with 'D'
	jnz   L38D1H    
L38A3H	ora   A         
L38A4H	call  L3931H    ; Deal with single & double precision ASCII conversions
	rst   2         ; Get next non-white char from M
	push  D         
	mvi   D,00H     
	call  L1037H    ; ASCII num conversion - find ASCII or tokenized '+' or '-' in A
	mov   C,D       
	pop   D         
L38B0H	rst   2         ; Get next non-white char from M
	jnc   L38CAH    
	mov   A,E       
	CPI   0CH       
	jnc   L38C5H    
	rlc             
	rlc             
	add   E         
	rlc             
	add   M         
	SUI   30H       
	mov   E,A       
	jmp   L38B0H    
	
L38C5H	mvi   E,80H     
	jmp   L38B0H    
	
L38CAH	inr   C         
	jnz   L38D1H    
	xra   A         
	sub   E         
	mov   E,A       
L38D1H	rst   5         ; Determine type of last var used
	jm    L38E8H    ; Skip ahead if last var type was integer
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	ora   A         ; Test if FAC1 is zero
	jz    L38E8H    ; Skip ahead if FAC1 is zero
	mov   A,D       
	sub   B         
	add   E         
	Adi   40H       
	sta   VVC1SD     ; Start of FAC1 for single and double precision
	ora   A         
	cm    L3901H    
L38E8H	pop   PSW       
	push  H         
	cz    L33F6H    
	rst   5         ; Determine type of last var used
	jnc   L38FCH    
	pop   H         
	rpe             
	push  H         
	lxi   H,L383EH  
	push  H         
	call  L3519H    
	ret             
	
L38FCH	call  L2C27H    
	pop   H         
	ret             
	
L3901H	jmp   L0455H    ; Generate OV error
	
	
; ======================================================
; Found '.' in ASCII number
; ======================================================
L3904H	rst   5         ; Determine type of last var used
	inr   C         
	jnz   L38D1H    
	jnc   L3917H    
	call  L3931H    ; Deal with single & double precision ASCII conversions
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	ora   A         
	jnz   L3917H    
	mov   D,A       
L3917H	jmp   L3857H    
	
	
; ======================================================
; Found '%' in ASCII number
; ======================================================
L391AH	rst   2         ; Get next non-white char from M
	pop   PSW       
	push  H         
	lxi   H,L383EH  
	push  H         
	lxi   H,BFCINT  ; Load address of CINT function
	push  H         ; Push new return address to stack
	push  PSW       
	jmp   L38D1H    
	
	
; ======================================================
; Found '#' in ASCII number
; ======================================================
L3929H	ora   A         ; Clear Z flag to denote double precision
L392AH	call  L3931H    ; Deal with single & double precision ASCII conversions
	rst   2         ; Get next non-white char from M
	jmp   L38D1H    
	
	
; ======================================================
; Deal with single & double precision ASCII conversions
; ======================================================
L3931H	push  H         ; Preserve HL on stack
	push  D         ; Preserve DE on stack
	push  B         ; Preserve BC on stack
	push  PSW       ; Save flags on stack
	cz    BFCSNG    ; CSNG function
	pop   PSW       ; Restore flags
	cnz   BFC.dbL    ; C.dbL function
	pop   B         ; Restore BC
	pop   D         ; Restore DE
	pop   H         ; Restore HL
	ret             
	
	
; ======================================================
; Convert ASCII number that starts with a Digit
; ======================================================
L3940H	SUI   30H       
	jnz   L394DH    
	ora   C         
	jz    L394DH    
	ana   D         
	jz    L3857H    
L394DH	inr   D         
	mov   A,D       
	CPI   07H       
	jnz   L3958H    
	ora   A         
	call  L3931H    ; Deal with single & double precision ASCII conversions
L3958H	push  D         
	mov   A,B       
	add   C         
	inr   A         
	mov   B,A       
	push  B         
	push  H         
	mov   A,M       
	SUI   30H       
	push  PSW       
	rst   5         ; Determine type of last var used
	jp    L398DH    
	lhld  VFAC1I     ; Start of FAC1 for integers
	lxi   D,L0CCDH  
	rst   3         ; Compare DE and HL
	jnc   L398AH    
	mov   D,H       
	mov   E,L       
	dad   H         
	dad   H         
	dad   D         
	dad   H         
	pop   PSW       
	mov   C,A       
	dad   B         
	mov   A,H       
	ora   A         
	jm    L3988H    
	shld  VFAC1I     ; Start of FAC1 for integers
L3982H	pop   H         
	pop   B         
	pop   D         
	jmp   L3857H    
	
L3988H	mov   A,C       
	push  PSW       
L398AH	call  L3540H    ; Convert signed integer in FAC1 to single precision
L398DH	pop   PSW       
	pop   H         
	pop   B         
	pop   D         
	jnz   L39A1H    
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	ora   A         
	mvi   A,00H     
	jnz   L39A1H    
	mov   D,A       
	jmp   L3857H    
	
L39A1H	push  D         
	push  B         
	push  H         
	push  PSW       
	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	mvi   M,01H     
	mov   A,D       
	CPI   10H       
	jc    L39B4H    
	pop   PSW       
	jmp   L3982H    
	
L39B4H	inr   A         
	ora   A         
	rar             
	mvi   B,00H     
	mov   C,A       
	dad   B         
	pop   PSW       
	mov   C,A       
	mov   A,D       
	rar             
	mov   A,C       
	jnc   L39C7H    
	add   A         
	add   A         
	add   A         
	add   A         
L39C7H	ora   M         
	mov   M,A       
	jmp   L3982H    
	
	
; ======================================================
; Finish printing BASIC ERROR message " in " line #
; ======================================================
L39CCH	push  H         ; Preserve line number in HL on stack
	lxi   H,L03F1H  ; Load pointer to " in " text
	call  L27B1H    ; Print buffer at M until NULL or '"'
	pop   H         ; Restore line number to HL
	
; ======================================================
; Print binary number in HL at current position
; ======================================================
L39D4H	lxi   B,L27B0H  ; Load address of Print buffer at M-1 until NULL or '"'
	push  B         
	call  L3510H    ; Load signed integer in HL to FAC1
	xra   A         
	sta   0FB8EH     
	lxi   H,0FBE8H   
	mvi   M,20H     
	ora   M         
	jmp   L3A05H    
	
	
; ======================================================
; Convert binary number in FAC1 to ASCII at M
; ======================================================
L39E8H	xra   A         
L39E9H	call  L3D11H    ; Initialize FAC1 with 0.0 if it has no value
	
; ======================================================
; Convert binary number in FAC1 to ASCII at M with format
; ======================================================
	ANI   08H       
	jz    L39F3H    
	mvi   M,2BH     
L39F3H	xchg            
	call  L3411H    ; Determine sign of last variable used
	xchg            
	jp    L3A05H    ; Jump if single precision
	mvi   M,2DH     ; Store a '-'
	push  B         
	push  H         
	call  L33F6H    
	pop   H         
	pop   B         
	ora   H         
L3A05H	inx   H         
	mvi   M,30H     ; Store a '0'
	lda   0FB8EH     
	mov   D,A       
	ral             
	lda   0FB65H     ; Type of last variable used
	jc    L3ACAH    
	jz    L3AC2H    
	CPI   04H       ; Test if last variable type is Double Precision?
	jnc   L3A6FH    
	lxi   B,0000H  
L3A1EH	call  L3CC3H    
L3A21H	lxi   H,0FBE8H   
	mov   B,M       
	mvi   C,20H     
	lda   0FB8EH     
	mov   E,A       
	ANI   20H       
	jz    L3A3EH    
	mov   A,B       
	cmp   C         
	mvi   C,2AH     
	jnz   L3A3EH    
	mov   A,E       
	ANI   04H       
	jnz   L3A3EH    
	mov   B,C       
L3A3EH	mov   M,C       
	rst   2         ; Get next non-white char from M
	jz    L3A5CH    
	CPI   45H       ; Test for 'E'
	jz    L3A5CH    
	CPI   44H       ; Test for 'D'
	jz    L3A5CH    
	CPI   30H       ; Test for '0'
	jz    L3A3EH    
	CPI   2CH       ; Test for ','
	jz    L3A3EH    
	CPI   2EH       ; Test for '.'
	jnz   L3A5FH    
L3A5CH	dcx   H         
	mvi   M,30H     ; Store a '0'
L3A5FH	mov   A,E       
	ANI   10H       
	jz    L3A68H    
	dcx   H         
	mvi   M,24H     ; Store a '$'
L3A68H	mov   A,E       
	ANI   04H       
	rnz             
	dcx   H         
	mov   M,B       
	ret             
	
L3A6FH	push  H         
	call  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
	mov   D,B       
	inr   D         
	lxi   B,L0300H  
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	SUI   3FH       
	jc    L3A89H    
	inr   D         
	cmp   D         
	jnc   L3A89H    
	inr   A         
	mov   B,A       
	mvi   A,02H     
L3A89H	SUI   02H       
	pop   H         
	push  PSW       
	call  L3C70H    
	mvi   M,30H     ; Store a '0'
	cz    L3457H    ; Increment HL and return
	call  L3C97H    
L3A98H	dcx   H         
	mov   A,M       
	CPI   30H       ; Test for '0'
	jz    L3A98H    ; Skip leading zero maybe?
	CPI   2EH       ; Test for '.'
	cnz   L3457H    ; Increment HL and return
	pop   PSW       
	jz    L3AC3H    
L3AA8H	mvi   M,45H     ; Store a 'E'
	inx   H         ; Increment output string pointer
	mvi   M,2BH     ; Store a '+'
	jp    L3AB4H    
	mvi   M,2DH     ; Store a '-'
	cma             
	inr   A         
L3AB4H	mvi   B,2FH     
L3AB6H	inr   B         
	SUI   0AH       
	jnc   L3AB6H    
	Adi   3AH       
	inx   H         
	mov   M,B       
	inx   H         
	mov   M,A       
L3AC2H	inx   H         
L3AC3H	mvi   M,00H     
	xchg            
	lxi   H,0FBE8H   
	ret             
	
L3ACAH	inx   H         
	push  B         
	CPI   04H       
	mov   A,D       
	jnc   L3B42H    
	rar             
	jc    L3BCCH    
	lxi   B,L0603H  
	call  L3C68H    
	pop   D         
	mov   A,D       
	SUI   05H       
	cp    L3C44H    
	call  L3CC3H    
L3AE6H	mov   A,E       
	ora   A         
	cz    L383CH    
	dcr   A         
	cp    L3C44H    
L3AEFH	push  H         
	call  L3A21H    
	pop   H         
	jz    L3AF9H    
	mov   M,B       
	inx   H         
L3AF9H	mvi   M,00H     
	lxi   H,0FBE7H   ; Floating Point Temp 1
L3AFEH	inx   H         
L3AFFH	lda   0FBA8H     
	sub   L         
	sub   D         
	rz              
	mov   A,M       
	CPI   20H       ; Test for space
	jz    L3AFEH    
	CPI   2AH       ; Test for '*'
	jz    L3AFEH    
	dcx   H         
	push  H         
L3B12H	push  PSW       
	lxi   B,L3B12H  
	push  B         
	rst   2         ; Get next non-white char from M
	CPI   2DH       ; Test for '-'
	rz              
	CPI   2BH       ; Test for '+'
	rz              
	CPI   24H       ; Test for '$'
	rz              
	pop   B         
	CPI   30H       ; Test for '0'
	jnz   L3B3AH    
	inx   H         
	rst   2         ; Get next non-white char from M
	jnc   L3B3AH    
	dcx   H         
	jmp   L3B32H    
	
L3B30H	dcx   H         
	mov   M,A       
L3B32H	pop   PSW       
	jz    L3B30H    
	pop   B         
	jmp   L3AFFH    
	
L3B3AH	pop   PSW       
	jz    L3B3AH    
	pop   H         
	mvi   M,25H     ; Store a '%'
	ret             
	
L3B42H	push  H         
	rar             
	jc    L3BD2H    
	call  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
	mov   D,B       
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	SUI   4FH       
	jc    L3B5EH    
	pop   H         
	pop   B         
	call  L39E8H    ; Convert binary number in FAC1 to ASCII at M
	lxi   H,0FBE7H   ; Floating Point Temp 1
	mvi   M,25H     ; Store a '%'
	ret             
	
L3B5EH	rst   6         ; Get sign of FAC1
	cnz   L3D55H    
	pop   H         
	pop   B         
	jm    L3B81H    
	push  B         
	mov   E,A       
	mov   A,B       
	sub   D         
	sub   E         
	cp    L3C44H    
	call  L3C5BH    
	call  L3C97H    
	ora   E         
	cnz   L3C54H    
	ora   E         
	cnz   L3C83H    ; Format output with ',' and '.' based on digit count
	pop   D         
	jmp   L3AE6H    
	
L3B81H	mov   E,A       
	mov   A,C       
	ora   A         
	cnz   L383AH    
	add   E         
	jm    L3B8CH    
	xra   A         
L3B8CH	push  B         
	push  PSW       
	cm    L3D2DH    
	pop   B         
	mov   A,E       
	sub   B         
	pop   B         
	mov   E,A       
	add   D         
	mov   A,B       
	jm    L3BA7H    
	sub   D         
	sub   E         
	cp    L3C44H    
	push  B         
	call  L3C5BH    
	jmp   L3BB8H    
	
L3BA7H	call  L3C44H    
	mov   A,C       
	call  L3C87H    
	mov   C,A       
	xra   A         
	sub   D         
	sub   E         
	call  L3C44H    
	push  B         
	mov   B,A       
	mov   C,A       
L3BB8H	call  L3C97H    
	pop   B         
	ora   C         
	jnz   L3BC3H    
	lhld  0FBA8H     
L3BC3H	add   E         
	dcr   A         
	cp    L3C44H    
	mov   D,B       
	jmp   L3AEFH    
	
L3BCCH	push  H         
	push  D         
	call  L3540H    ; Convert signed integer in FAC1 to single precision
	pop   D         
L3BD2H	call  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
	mov   E,B       
	rst   6         ; Get sign of FAC1
	push  PSW       
	cnz   L3D55H    
	pop   PSW       
	pop   H         
	pop   B         
	push  PSW       
	mov   A,C       
	ora   A         
	push  PSW       
	cnz   L383AH    
	add   B         
	mov   C,A       
	mov   A,D       
	ANI   04H       
	CPI   01H       
	sbb   A         
	mov   D,A       
	add   C         
	mov   C,A       
	sub   E         
	push  PSW       
	jp    L3C04H    
	call  L3D2DH    
	jnz   L3C04H    
	push  H         
	call  L2CF2H    
	lxi   H,VVC1SD   ; Start of FAC1 for single and double precision
	inr   M         
	pop   H         
L3C04H	pop   PSW       
	push  B         
	push  PSW       
	jm    L3C0BH    
	xra   A         
L3C0BH	cma             
	inr   A         
	add   B         
	inr   A         
	add   D         
	mov   B,A       
	mvi   C,00H     
	cz    L3C70H    
	call  L3C97H    
	pop   PSW       
	cp    L3C4DH    
	call  L3C83H    ; Format output with ',' and '.' based on digit count
	pop   B         
	pop   PSW       
	jnz   L3C31H    
	call  L383CH    
	mov   A,M       
	CPI   2EH       
	cnz   L3457H    ; Increment HL and return
	shld  0FBA8H     
L3C31H	pop   PSW       
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	jz    L3C3BH    
	add   E         
	sub   B         
	sub   D         
L3C3BH	push  B         
	call  L3AA8H    
	xchg            
	pop   D         
	jmp   L3AEFH    
	
L3C44H	ora   A         
L3C45H	rz              
	dcr   A         
	mvi   M,30H     ; Store a '0'
	inx   H         ; Increment output string pointer
	jmp   L3C45H    
	
L3C4DH	jnz   L3C54H    
L3C50H	rz              
	call  L3C83H    ; Format output with ',' and '.' based on digit count
L3C54H	mvi   M,30H     ; Store a '0'
	inx   H         ; Increment output string pointer
	dcr   A         
	jmp   L3C50H    
	
L3C5BH	mov   A,E       
	add   D         
	inr   A         
	mov   B,A       
	inr   A         
L3C60H	SUI   03H       
	jnc   L3C60H    
	Adi   05H       
	mov   C,A       
L3C68H	lda   0FB8EH     
	ANI   40H       
	rnz             
	mov   C,A       
	ret             
	
L3C70H	dcr   B         
	jp    L3C84H    
	shld  0FBA8H     
	mvi   M,2EH     ; Store a '.'
L3C79H	inx   H         
	mvi   M,30H     ; Store a '0'
	inr   B         
	mov   C,B       
	jnz   L3C79H    
	inx   H         
	ret             
	
L3C83H	dcr   B         ; Decrement count of digits before '.'
L3C84H	jnz   L3C8FH    ; If not time for '.', go test for ','
L3C87H	mvi   M,2EH     ; Store a '.'
	shld  0FBA8H     
	inx   H         ; Increment the output string pointer
	mov   C,B       ; Set comma counter to zero ... no more ','
	ret             
	
L3C8FH	dcr   C         ; Decrement digit counter for ','
	rnz             ; Return if not 3 digits yet
	mvi   M,2CH     ; Store a ','
	inx   H         ; Increment pointer to output string
	mvi   C,03H     ; Reload digit counter for next ','
	ret             
	
L3C97H	push  D         
	push  H         
	push  B         
	call  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
	mov   A,B       
	pop   B         
	pop   H         
	lxi   D,0FC19H   ; Point to BCD portion of FAC1
	stc             
L3CA4H	push  PSW       
	call  L3C83H    ; Format output with ',' and '.' based on digit count
	ldax  D         
	jnc   L3CB3H    
	rar             
	rar             
	rar             
	rar             
	jmp   L3CB4H    
	
L3CB3H	inx   D         
L3CB4H	ANI   0FH       
	Adi   30H       
	mov   M,A       
	inx   H         
	pop   PSW       
	dcr   A         
	cmc             
	jnz   L3CA4H    
	jmp   L3CF4H    
	
L3CC3H	push  D         
	lxi   D,L3CFAH  ; Load pointer to Power of 10 table
	mvi   A,05H     ; Five entries in power of 10 table
L3CC9H	call  L3C83H    ; Format output with ',' and '.' based on digit count
	push  B         
	push  PSW       ; Save power of 10 value counter to stack
	push  H         
	xchg            ; HL has power of 10 table pointer
	mov   C,M       ; Load LSB of next power of 10 value
	inx   H         ; Point to MSB of power of 10 value
	mov   B,M       ; Load MSB of next power of 10 value
	push  B         ; Save power of 10 value on stack
	inx   H         ; Increment power of 10 table pointer
	xthl            ; Extrace power of 10 value from stack
	xchg            ; Put power of 10 value in DE
	lhld  VFAC1I     ; Start of FAC1 for integers
	mvi   B,2FH     ; Start with ASCII '0' minus 1
L3CDCH	inr   B         ; Increment ASCII value
	mov   A,L       ; Prepare to subtract HL - DE
	sub   E         ; Subtract LSB
	mov   L,A       ; Save it in HL
	mov   A,H       ; Get MSB
	sbb   D         ; Subtract with borrow MSB
	mov   H,A       ; Save it back
	jnc   L3CDCH    ; Loop until borrow occurs
	dad   D         ; Add power of 10 back in for last loop
	shld  VFAC1I     ; Start of FAC1 for integers
	pop   D         
	pop   H         ; Get pointer to output
	mov   M,B       ; Save the calculated ASCII value
	inx   H         ; Increment pointer to output string
	pop   PSW       ; Get power of 10 value loop counter from stack
	pop   B         
	dcr   A         ; Decrement power of 10 value counter
	jnz   L3CC9H    ; Jump to process all 5 powe of 10 values
L3CF4H	call  L3C83H    ; Format output with ',' and '.' based on digit count
	mov   M,A       
	pop   D         
	ret             

; ======================================================
; L3CFAH: Power of 10 table
; ======================================================
L3CFAH
   .dw   2710H, 03E8H    ; 10000, 1000
   .dw   0064H, 000AH    ; 100, 10
   .dw   0001H           ; 1

; ======================================================
; 3D04H: Get length and pointer to end of FAC1 based on single/double
; ======================================================
L3D04H rst 5           ; Determine type of last var used
	lxi   H,0FC1FH  ; Point to end of FAC1
	mvi   B,0EH     ; Size of double is 14 bytes
	rnc             ; Return if double precision
	lxi   H,0FC1BH  ; Point to end of single precision
	mvi   B,06H     ; Size of single is 6 bytes
	ret             
	
	
; ======================================================
; Initialize FAC1 with 0.0 if it has no value
; ======================================================
L3D11H	sta   0FB8EH     
	push  PSW       
	push  B         
	push  D         
	call  BFC.dbL    ; C.dbL function
	lxi   H,L327EH  
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	ana   A         
	cz    L31C4H    ; Move floating point number M to FAC1
	pop   D         
	pop   B         
	pop   PSW       
	lxi   H,0FBE8H   
	mvi   M,20H     
	ret             
	
L3D2DH	push  H         
	push  D         
	push  B         
	push  PSW       
	cma             
	inr   A         
	mov   E,A       
	mvi   A,01H     
	jz    L3D4FH    
	call  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
	push  H         
L3D3DH	call  L2CF2H    
	dcr   E         
	jnz   L3D3DH    
	pop   H         
	inx   H         
	mov   A,B       
	Rrc             
	mov   B,A       
	call  L2C2CH    
	call  L3D67H    
L3D4FH	pop   B         
	add   B         
	pop   B         
	pop   D         
	pop   H         
	ret             
	
L3D55H	push  B         
	push  H         
	call  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	SUI   40H       
	sub   B         
	sta   VVC1SD     ; Start of FAC1 for single and double precision
	pop   H         
	pop   B         
	ora   A         
	ret             
	
L3D67H	push  B         
	call  L3D04H    ; Get length and pointer to end of FAC1 based on single/double
L3D6BH	mov   A,M       
	ANI   0FH       
	jnz   L3D7CH    
	dcr   B         
	mov   A,M       
	ora   A         
	jnz   L3D7CH    
	dcx   H         
	dcr   B         
	jnz   L3D6BH    
L3D7CH	mov   A,B       
	pop   B         
	ret             
	
	
; ======================================================
; Single precision exponential function
; ======================================================
	call  L3827H    ; Single precision load (FAC2=BCDE)
	call  L35C2H    ; Convert FAC11 to double precision
	call  L322EH    ; Push FAC2 on stack
	call  L31D2H    ; Swap FAC1 with Floating Point number on stack
	call  L3245H    ; Pop FAC2 from stack
	
; ======================================================
; Double precision exponential function
; ======================================================
	lda   0FC69H     ; Start of FAC2 for single and double precision
	ora   A         
	jz    L3DFCH    
	mov   H,A       
	lda   VVC1SD     ; Start of FAC1 for single and double precision
	ora   A         
	jz    L3E07H    
	call  L3234H    ; Push FAC1 on stack
	call  L3EDCH    
	jc    L3DE2H    
	xchg            
	shld  0FB90H     
	call  L35CFH    ; Set type of last variable to .dbL
	call  L3245H    ; Pop FAC2 from stack
	call  L3EDCH    
	call  L35CFH    ; Set type of last variable to .dbL
	lhld  0FB90H     
	jnc   L3E15H    
	lda   0FC69H     ; Start of FAC2 for single and double precision
	push  PSW       
	push  H         
	call  L31C1H    ; Move FAC2 to FAC1
	lxi   H,0FBE7H   ; Floating Point Temp 1
	call  L31CAH    ; Move FAC1 to M
	lxi   H,L3286H  ; Load pointer to FP 1.000000000
	call  L31C4H    ; Move floating point number M to FAC1
	pop   H         
	mov   A,H       
	ora   A         
	push  PSW       
	jp    L3DDEH    
	xra   A         
	mov   C,A       
	sub   L         
	mov   L,A       
	mov   A,C       
	sbb   H         
	mov   H,A       
L3DDEH	push  H         
	jmp   L3E53H    
	
L3DE2H	call  L35CFH    ; Set type of last variable to .dbL
	call  L31C1H    ; Move FAC2 to FAC1
	call  L31D2H    ; Swap FAC1 with Floating Point number on stack
	call  BFLOG    ; LOG function
	call  L3245H    ; Pop FAC2 from stack
	call  L2CFFH    ; Double precision multiply (FAC1=FAC1*FAC2)
	jmp   BFEXP    ; EXP function
	
	
; ======================================================
; Integer exponential function
; ======================================================
	mov   A,H       ; Prepare to test for zero
	ora   L         ; OR in LSB to test for zero
	jnz   L3E02H    ; Jump if not zero to calc exp
L3DFCH	lxi   H,L0001H  ; Set result .equal to 1
	jmp   L3E12H    ; Jump to set the result
	
L3E02H	mov   A,D       ; Test value for zero
	ora   E         
	jnz   L3E15H    ; Jump if not zero
L3E07H	mov   A,H       ; Get MSB of exponent
	ral             ; Test for negative
	jnc   L3E0FH    ; Jump to set result to zero if not negative
	jmp   L0449H    ; Generate /0 error
	
L3E0FH	lxi   H,0000H   ; Zero ^ some positive value = 0
L3E12H	jmp   L3510H    ; Load signed integer in HL to FAC1
	
L3E15H	shld  0FB90H     
	push  D         
	mov   A,H       
	ora   A         
	push  PSW       
	cm    L37C6H    
	mov   B,H       
	mov   C,L       
	lxi   H,L0001H  
L3E24H	ora   A         
	mov   A,B       
	rar             
	mov   B,A       
	mov   A,C       
	rar             
	mov   C,A       
	jnc   L3E34H    
	call  L3ECFH    
	jnz   L3E85H    
L3E34H	mov   A,B       
	ora   C         
	jz    L3E9EH    
	push  H         
	mov   H,D       
	mov   L,E       
	call  L3ECFH    
	xchg            
	pop   H         
	jz    L3E24H    
	push  B         
	push  H         
	lxi   H,0FBE7H   ; Floating Point Temp 1
	call  L31CAH    ; Move FAC1 to M
	pop   H         
	call  L3543H    ; Convert signed integer HL to single precision FAC1
	call  L35C2H    ; Convert FAC11 to double precision
L3E53H	pop   B         
	mov   A,B       
	ora   A         
	rar             
	mov   B,A       
	mov   A,C       
	rar             
	mov   C,A       
	jnc   L3E66H    
	push  B         
	lxi   H,0FBE7H   ; Floating Point Temp 1
	call  L31A3H    ; Double precision math (FAC1=M * FAC2))
	pop   B         
L3E66H	mov   A,B       
	ora   C         
	jz    L3E9EH    
	push  B         
	call  L3234H    ; Push FAC1 on stack
	lxi   H,0FBE7H   ; Floating Point Temp 1
	push  H         
	call  L31C4H    ; Move floating point number M to FAC1
	pop   H         
	push  H         
	call  L31A3H    ; Double precision math (FAC1=M * FAC2))
	pop   H         
	call  L31CAH    ; Move FAC1 to M
	call  L324BH    ; Pop FAC1 from stack
	jmp   L3E53H    
	
L3E85H	push  B         
	push  D         
	call  L7FF4H    
	pop   H         
	call  L3543H    ; Convert signed integer HL to single precision FAC1
	call  L35C2H    ; Convert FAC11 to double precision
	lxi   H,0FBE7H   ; Floating Point Temp 1
	call  L31CAH    ; Move FAC1 to M
	call  L31C1H    ; Move FAC2 to FAC1
	pop   B         
	jmp   L3E66H    
	
L3E9EH	pop   PSW       
	pop   B         
	rp              
	lda   0FB65H     ; Type of last variable used
	CPI   02H       ; Test if last type was Integer
	jnz   L3EB1H    
	push  B         
	call  L3543H    ; Convert signed integer HL to single precision FAC1
	call  L35C2H    ; Convert FAC11 to double precision
	pop   B         
L3EB1H	lda   VVC1SD     ; Start of FAC1 for single and double precision
	ora   A         
	jnz   L3EC3H    
	lhld  0FB90H     
	ora   H         
	rp              
	mov   A,L       
	Rrc             
	ana   B         
	jmp   L0455H    ; Generate OV error
	
L3EC3H	call  L31B5H    ; Move FAC1 to FAC2
	lxi   H,L3286H  ; Load pointer to FP 1.000000000
	call  L31C4H    ; Move floating point number M to FAC1
	jmp   L2DC7H    ; Double precision divide (FAC1=FAC1/FAC2)
	
L3ECFH	push  B         
	push  D         
	call  L3725H    ; Signed integer muliply (FAC1=HL*DE)
	lda   0FB65H     ; Type of last variable used
	CPI   02H       ; Test if last type was integer
	pop   D         
	pop   B         
	ret             
	
L3EDCH	call  L31C1H    ; Move FAC2 to FAC1
	call  L322EH    ; Push FAC2 on stack
	call  BFINT     ; INT function
	call  L3245H    ; Pop FAC2 from stack
	call  L34D2H    ; Double precision compare FAC1 with FAC2
	stc             
	rnz             
	jmp   L35DEH    
	
L3EF0H	call  L3F08H    ; Test HL against stack space for collision
L3EF3H	push  B         ; \
	xthl            ; > Swap HL and BC
	pop   B         ; /
L3EF6H	rst   3         ; Compare DE and HL
	mov   A,M       ; Get next byte
	stax  B         ; Save next byte
	rz              ; Return if all bytes copied
	dcx   B         ; Decrement dest pointer
	dcx   H         ; Decrement src pointer
	jmp   L3EF6H    ; Jump to copy all bytes
	
L3EFFH	push  H         
	lhld  VPFREM     ; Unused memory pointer
	mvi   B,00H     
	dad   B         
	dad   B         
	mvi   A,0E5H     ; Makes pass-through code look like "MVI A,0E5H"
	mvi   A,88H     
	sub   L         
	mov   L,A       
	mvi   A,0FFH     
	sbb   H         
	mov   H,A       
	jc    L3F17H    ; Reinit BASIC stack and generate OM error
	dad   SP        
	pop   H         
	rc              
L3F17H	call  L05F0H    ; Update line addresses for current BASIC program
	lhld  VTPRAM    ; BASIC string buffer pointer
	dcx   H         
	dcx   H         
	shld  0FB9DH     ; SP used by BASIC to reinitialize the stack
	lxi   D,L0007H  ; Prepare to generate OM Error
	jmp   L045DH    ; Generate error in E
	
	
; ======================================================
; Initialize BASIC Variables for new execution
; ======================================================
L3F28H	lhld  VBASPP    ; Start of BASIC program pointer
	dcx   H         
L3F2CH	shld  0FB99H     ; Address of last variable assigned
L3F2FH	call  L4009H    ; Clear all COM), TIME), and KEY interrupt definitions
	mvi   B,1AH     
	lxi   H,0FBBAH   ; DEF definition table
L3F37H	mvi   M,08H     
	inx   H         
	dcr   B         
	jnz   L3F37H    
	call  L3182H    ; Initialize FP_TEMP3 for new program
	xra   A         
	sta   VBASRF    ; BASIC Program Running Flag
	mov   L,A       
	mov   H,A       
	shld  0FBA5H     ; Address of ON ERROR routine
	shld  0FBACH     ; Address where program stopped on last break), END), or STOP
	lhld  0FB67H     ; File buffer area pointer
	shld  0FB8CH     ; Pointer to current location in BASIC string buffer
	call  BSREST    ; RESTORE statement
	lhld  VPSVAR    ; Start of variable data pointer
	shld  VARRTP     ; Start of array table pointer
	shld  VPFREM    ; Unused memory pointer
	call  L4E22H    
	lda   0FCA7H     
	ANI   01H       
	jnz   L3F6DH    ; Initialize BASIC for new execution
	sta   0FCA7H     
L3F6DH	pop   B         
	lhld  VTPRAM    ; BASIC string buffer pointer
	dcx   H         
	dcx   H         
	shld  0FB9DH     ; SP used by BASIC to reinitialize the stack
	inx   H         
	inx   H         
L3F78H	sphl            ; Re-initialize stack location
	lxi   H,0FB6BH   
	shld  0FB69H     
	call  ROTLCD    ; Reinitialize output back to LCD
	call  L0C39H    ; Call routine to terminate running BASIC?
	xra   A         
	mov   H,A       
	mov   L,A       
	shld  0FBD6H     
	sta   0FBE1H     
	shld  0FBDBH     
	shld  0FBE4H     
	shld  0FBD4H     
	sta   0FB96H     ; FOR/NEXT loop active flag
	push  H         
	push  B         
L3F9CH	lhld  0FB99H     ; Address of last variable assigned
	ret             
	
	
; ======================================================
; TIME$ ON statement
; ======================================================
BSTMON	di              
	mov   A,M       
	ANI   04H       
	ORI   01H       
	cmp   M         
	mov   M,A       
	jz    L3FB0H    
	ANI   04H       
	jnz   L3FE8H    
L3FB0H	ei              
	ret             
	
	
; ======================================================
; TIME$ OFF statement
; ======================================================
BSTMOF	di              
	mov   A,M       
	mvi   M,00H     
	jmp   L3FC0H    
	
	
; ======================================================
; TIME$ STOP statement
; ======================================================
BSTMST	di              
	mov   A,M       
	push  PSW       
	ORI   02H       
	mov   M,A       
	pop   PSW       
L3FC0H	XRI   05H       
	jz    L3FFCH    
	ei              
	ret             
	
L3FC7H	di              
	mov   A,M       
	ANI   05H       
	cmp   M         
	mov   M,A       
	jnz   L3FE1H    
	ei              
	ret             
	
	
; ======================================================
; Trigger interrupt.  HL points to interrupt table
; ======================================================
L3FD2H	di              ; Disable interrupts
	mov   A,M       ; Load trigger control for this interrupt
	ANI   01H       ; Test if interrupt needs to be triggered maybe?
	jz    L3FE6H    ; Jump if source hasn't issued a trigger
	mov   A,M       ; Load trigger control again
	ORI   04H       ; Prepare to test if interrupt already counted
	cmp   M         ; Test if interrupt already reported / counted
	jz    L3FE6H    ; Jump to return if interrupt already reported
	mov   M,A       ; Mark interrupt as counted
L3FE1H	XRI   05H       ; Validate the interrupt should be counted
	jz    L3FE8H    ; Jump to increment the interrupt count
L3FE6H	ei              ; Re-enable interrupts
	ret             
	
L3FE8H	lda   0F654H     ; Load current pending interrupt count
	inr   A         ; Increment
	sta   0F654H     ; Save new pending interrupt count
	ei              ; Re-enable interrupts
	ret             
	
	
; ======================================================
; Clear interrupt.  HL points to interrupt table
; ======================================================
L3FF1H	di              ; Disable interrupts for protection
	mov   A,M       ; Get interrupt control register
	ANI   03H       ; Clear bit indicating interrupt reported as "pending"
	cmp   M         ; Test if interrupt had been reported as "pending"
	mov   M,A       ; Mark interrupt as not pending
	jnz   L3FFCH    ; Jump if interrupt previously marked as pending to decrement count
L3FFAH	ei              ; Re-enable interrupts
	ret             
	
L3FFCH	lda   0F654H     ; Load pending interrupt count
	SUI   01H       ; Decrement the count
	jc    L3FFAH    ; Skip save if count was already zero
	sta   0F654H     ; Save new pending interrupt count
	ei              ; Re-enable interrupts
L4008H	ret             
	
	
; ======================================================
; Clear all COM), TIME), and KEY interrupt definitions
; ======================================================
L4009H	lxi   H,0F944H   ; On Com flag
	mvi   B,0AH     
	xra   A         
L400FH	mov   M,A       
	inx   H         
	mov   M,A       
	inx   H         
	mov   M,A       
	inx   H         
	dcr   B         
	jnz   L400FH    
	lxi   H,0F630H   ; Function key status table (1 = on)
	mvi   B,08H     
L401EH	mov   M,A       
	inx   H         
	dcr   B         
	jnz   L401EH    
	sta   0F654H     
	ret             
	
L4028H	mvi   B,02H     ; Mark entry from ON COM
	lxi   D,L0106H  ; Make "MVI B,01H" look like "LXI D,0106H"
	lda   VBASRF     ; BASIC Program Running Flag
	ora   A         ; Test if BASIC runnin
	rnz             ; Return if BASIC program not running
	push  H         ; Preserve HL on stack
	lhld  VBSCLN     ; Current executing line number
	mov   A,H       ; Get line number MSB
	ana   L         ; and with line number LSB
	inr   A         ; Test if line number = 0xFFFF
	jz    L4052H    ; Jump to exit if line number = 0xFFFF
	dcr   B         ; Test for entry from ON COM
	jnz   L4075H    ; Jump if entered from ON COM
	lxi   H,0F947H   ; On Time flag
	mvi   B,09H     ; Loop for 9 ON-TIME, ON-KEY, etc. interrupts
L4045H	mov   A,M       ; Get the ON-XXX flag
	CPI   05H       ; Test if Interrupt triggered by this event F1, F2, TIME$, etc.
	jz    L4054H    ; Jump to process ON-XXX interrupt
L404BH	inx   H         ; Skip ON-XXX flag
	inx   H         ; Skip ON-XXX line number LSB
	inx   H         ; SKip ON-XXX line number MSB
	dcr   B         ; Decrement number of ON-XXX events checked
	jnz   L4045H    ; Jump to process next ON-XXX interrupt?
L4052H	pop   H         ; Restore HL from stack
	ret             
	
L4054H	push  B         ; Save the ON-XXX index number
	inx   H         ; Skip to the BASIC line number LSB
	mov   E,M       ; Read the BASIC line number LSB
	inx   H         ; Skip to the MSB
	mov   D,M       ; Read the BASIC line number MSB
	dcx   H         ; Restore HL back to ON-XXX flag
	dcx   H         ; "
	mov   A,D       ; Prepare to test if the ON-XXX line = 0
	ora   E         ; OR in the MSB of the line
	pop   B         ; Restore the stack frame
	jz    L404BH    ; SKip processing if line number = 0
	push  D         ; Preserve DE on Stack
	push  H         ; Preserve HL on Stack
	call  L3FF1H    ; Clear interrupt. HL points to interrupt table
	call  BSTMST    ; TIME$ STOP statement
	mvi   C,03H     ; Prepare to validate 6 bytes free in Unused memory
	call  L3EFFH    ; Validate 6 bytes free from stack space
	pop   B         ; POP H from stack. We don't really need to keep this one
	pop   D         ; Restore DE from stack
	pop   H         ; Restore HL from stack
	pop   PSW       
	jmp   L0952H    
	
L4075H	lxi   H,0F944H   ; On Com flag
	mov   A,M       ; Get COM flag
	dcr   A         ; Decrement to test for 1
	jz    L4054H    ; If 1, jump to process interrupt
	pop   H         ; Restore HL from stack
	ret             
	
	
; ======================================================
; RESTORE statement
; ======================================================
BSREST	xchg            
L4080H	lhld  VBASPP    ; Start of BASIC program pointer
	jz    L4094H    
	xchg            
	call  L08EBH    ; Convert ASCII number at M to binary
	push  H         
	call  L0628H    ; Find line number in DE
	mov   H,B       
	mov   L,C       
	pop   D         
	jnc   L094DH    ; Generate UL error
L4094H	dcx   H         
L4095H	shld  VADATS     ; Address where DATA search will begin next
	xchg            
	ret             
	
	
; ======================================================
; STOP statement
; ======================================================
BSSTOP	rnz             
	inr   A         
	jmp   L40A9H    
	
	
; ======================================================
; END statement
; ======================================================
BSEND	rnz             
	xra   A         
	sta   VBASRF    ; BASIC Program Running Flag
	push  PSW       
	cz    L4E22H    
	pop   PSW       
L40A9H	shld  VPCURL    ; Most recent or currenly running line pointer
	lxi   H,0FB6BH   
	shld  0FB69H     
	lxi   H,0FFF6H   
	pop   B         
L40B6H	lhld  VBSCLN     ; Current executing line number
	push  H         
	push  PSW       
	mov   A,L       
	ana   H         
	inr   A         
	jz    L40CAH    
	shld  0FBAAH     ; Line where break, END, or STOP occurred
	lhld  VPCURL    ; Most recent or currenly running line pointer
	shld  0FBACH     ; Address where program stopped on last break), END), or STOP
L40CAH	call  ROTLCD    ; Reinitialize output back to LCD
	call  L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	pop   PSW       
	lxi   H,L03FBH  ; Load pointer to "Break" text
	jnz   L04F6H    
	jmp   L0501H    ; Pop stack and vector to BASIC ready
	
	
; ======================================================
; CONT sttement
; ======================================================
BSCONT	lhld  0FBACH     ; Address where program stopped on last break), END), or STOP
	mov   A,H       
	ora   L         
	lxi   D,L0011H  ; Prepare to generate CN Error (Can't Continue)
	jz    L045DH    ; Generate error in E
	xchg            
	lhld  0FBAAH     ; Line where break, END, or STOP occurred
	shld  VBSCLN    ; Current executing line number
	xchg            
	ret             
	
	jmp   L08DBH    ; Generate FC error
	
	
; ======================================================
; Check if M is alpha character
; ======================================================
L40F1H	mov   A,M       
	
; ======================================================
; Check if A is alpha character
; ======================================================
L40F2H	CPI   41H       
	rc              
	CPI   5BH       
	cmc             
	ret             
	
	
; ======================================================
; CLEAR statement
; ======================================================
BSCLR	push  H         
	call  L2262H    
	pop   H         
	dcx   H         
	rst   2         ; Get next non-white char from M
	jz    L3F2CH    ; Initialize BASIC Variables for new execution
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	00H             
	call  L08D7H    
	dcx   H         
	rst   2         ; Get next non-white char from M
	push  H         
	lhld  VHIMEM    ; HIMEM
	mov   B,H       
	mov   C,L       
	lhld  0FB67H     ; File buffer area pointer
	jz    L4140H    
	pop   H         
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ',' character
	push  D         
	call  L1297H    ; Evaluate expression at M
	dcx   H         
	rst   2         ; Get next non-white char from M
	jnz   ERRSYN    ; Generate Syntax error
	xthl            
	xchg            
	mov   A,H       
	ana   A         
	jp    L08DBH    ; Generate FC error
	push  D         
	lxi   D,0F5F1H   
	rst   3         ; Compare DE and HL
	jnc   L08DBH    ; Generate FC error
	pop   D         
	push  H         
	lxi   B,0FEF5H   
	lda   0FC82H     ; Maxfiles
L4139H	dad   B         
	dcr   A         
	jp    L4139H    
	pop   B         
	dcx   H         
L4140H	mov   A,L       
	sub   E         
L4142H	mov   E,A       
	mov   A,H       
	sbb   D         
	mov   D,A       
	jc    L3F17H    ; Reinit BASIC stack and generate OM error
	push  H         
	lhld  VPSVAR     ; Start of variable data pointer
	push  B         
	lxi   B,L00A0H  
	dad   B         
	pop   B         
	rst   3         ; Compare DE and HL
	jnc   L3F17H    ; Reinit BASIC stack and generate OM error
	xchg            
	shld  VTPRAM    ; BASIC string buffer pointer
	mov   H,B       
	mov   L,C       
	shld  VHIMEM    ; HIMEM
	pop   H         
	shld  0FB67H     ; File buffer area pointer
	pop   H         
	call  L3F2CH    ; Initialize BASIC Variables for new execution
	lda   0FC82H     ; Maxfiles
	call  L7F2BH    ; Adjust SP location based on CLEAR parameters
	lhld  0FB99H     ; Address of last variable assigned
	jmp   BASEXE    ; Execute BASIC program
	
	
; ======================================================
; NEXT statement
; ======================================================
BSNEXT	lxi   D,0000H  
L4177H	cnz   L4790H    ; Find address of variable at M
	shld  0FB99H     ; Address of last variable assigned
	CALL  POPret    ; Pop return address for NEXT or RETURN
	jnz   L044CH    ; Generate NF error
	sphl            
	push  D         
	mov   A,M       
	push  PSW       
	inx   H         
	push  D         
	mov   A,M       
	inx   H         
	ora   A         
	jm    L41BBH    
	dcr   A         
	jnz   L4197H    
	lxi   B,L0008H  
	dad   B         
L4197H	Adi   04H       
	sta   0FB65H     ; Type of last variable used
	call  L347EH    
	xchg            
	xthl            
	push  H         
	rst   5         ; Determine type of last var used
	jnc   L41F6H    
	call  L3447H    ; Load single precision at M to BCDE
	call  L37F4H    ; Single precision addition (FAC1=FAC1+BCDE)
	pop   H         
	call  L3459H    ; Move single precision FAC1 to M
	pop   H         
	call  L3450H    ; Reverse load single precision at M to DEBC
	push  H         
	call  L3498H    ; Compare single precision in BCDE with FAC1
	jmp   L41E4H    
	
L41BBH	lxi   B,L000CH  
	dad   B         
	mov   C,M       
	inx   H         
	mov   B,M       
	inx   H         
	xthl            
	mov   E,M       
	inx   H         
	mov   D,M       
	push  H         
	mov   L,C       
	mov   H,B       
	call  L3704H    ; Signed integer addition (FAC1=HL+DE)
	lda   0FB65H     ; Type of last variable used
	CPI   02H       ; Test if last type was integer
	jnz   L0455H    ; Generate OV error
	xchg            
	pop   H         
	mov   M,D       
	dcx   H         
	mov   M,E       
	pop   H         
	push  D         
	mov   E,M       
	inx   H         
	mov   D,M       
	inx   H         
	xthl            
	call  L34C2H    ; Compare signed integer in DE with that in HL
L41E4H	pop   H         
	pop   B         
	sub   B         
	call  L3450H    ; Reverse load single precision at M to DEBC
	jz    L4208H    
	xchg            
	shld  VBSCLN     ; Current executing line number
	mov   L,C       
	mov   H,B       
	jmp   L0800H    
	
L41F6H	call  L2B75H    
	pop   H         
	call  L3487H    
	pop   H         
	call  L3461H    ; Move M to FAC2 using precision at (0FB65H)
	push  D         
	call  L34D2H    ; Double precision compare FAC1 with FAC2
	jmp   L41E4H    
	
L4208H	sphl            
	shld  0FB9DH     ; SP used by BASIC to reinitialize the stack
	xchg            
	lhld  0FB99H     ; Address of last variable assigned
	mov   A,M       
	CPI   2CH       
	jnz   BASEXE    ; Execute BASIC program
	rst   2         ; Get next non-white char from M
	call  L4177H    
L421AH	push  H         
	lhld  0FC8CH     
	mov   A,H       
	ora   L         
	pop   H         
	ret             
	
	
; ======================================================
; L4222H: Generate a Carriage Return and Line Feed
; ======================================================
CRLF	mvi  A,0DH      ; Send CR to screen or printer
    	rst  4          ; Send character in A to screen/printer
    	mvi  A,0AH      ; Send LF to screen or printer
    	rst  4          ; Send character in A to screen/printer
    	ret
	
	
; ======================================================
; L4229H: BEEP statement
; ======================================================
BSBEEP	mvi  A,07H
    	rst  4          ; Send character in A to screen/printer
    	ret
	
	
; ======================================================
; L422DH: Move cursor to home position (1,1)
; ======================================================
HOME	mvi  A,0BH
    	rst  4          ; Send character in A to screen/printer
    	ret
	
	
; ======================================================
; L4231H: Clears display
; ======================================================
CLS	mvi  A,0CH
    	rst  4          ; Send character in A to screen/printer
    	ret
	
	
; ======================================================
; L4235H: Sets system line (lock line 8, LABEL)
; ======================================================
SETSYS	mvi  A,54H     ; ESC T
    	jmp  ESCA      ; End escape s.equence
	
	
; ======================================================
; L423AH: Reset system line (unlock line 8, LABEL)
; ======================================================
RSTSYS	mvi  A,55H     ; ESC U
    	jmp  ESCA      ; End escape s.equence
	
	
; ======================================================
; L423FH: Lock display (no scrolling)
; ======================================================
LOCK	mvi  A,56H     ; ESC Y
    	jmp  ESCA      ; End escape s.equence
	
	
; ======================================================
; L4244H: Unlock display (scrolling)
; ======================================================
UNLOCK	mvi  A,57H     ; ESC W
    	jmp  ESCA      ; End escape s.equence
	
	
; ======================================================
; L4249H: Turn on cursor
; ======================================================
CURSON	mvi  A,50H     ; ESC P
    	jmp  ESCA      ; End escape s.equence
	
	
; ======================================================
; L424EH: Turn off cursor
; ======================================================
CUROFF mvi  A,51H     ; ESC Q
    	jmp  ESCA      ; End escape s.equence
	
	
; ======================================================
; L4253H: Delete line at current cursor position
; ======================================================
DELLIN	mvi  A,4DH     ; ESC M
    	jmp  ESCA      ; End escape s.equence
	
	
; ======================================================
; L4258H: Insert a blank line at cursor position
; ======================================================
INSLIN	mvi  A,4CH     ; ESC L
    	jmp  ESCA      ; End escape s.equence
	
	
; ======================================================
; L425DH: Erase from cursor to end of line
; ======================================================
ERABOL	mvi  A,4BH     ; ESC K
    	jmp  ESCA      ; End escape s.equence
	
	
; ======================================================
; L4262H: Send ESC X
; Entry conditions: none
; Exit conditions:  none
; ======================================================
SDESCX	mvi  A,58H     ; ESC X
    	jmp  ESCA      ; End escape s.equence
L4267	ora  M
    	rz
	
; ======================================================
; L4269H: Set Reverse character mode
; ======================================================
ENTREV	mvi  A,70H     ; ESC p
    	jmp  ESCA      ; End escape s.equence
	
	
; ======================================================
; L426EH: Turn off Reverse character mode
; ======================================================
EXTREF	mvi  A,71H     ; ESC q
	
; ======================================================
; L4270H: Send specified Escape Code S.equence
; Entry conditions: A = escape code
; Exit conditions:  none
; ======================================================
ESCA	push PSW
    	mvi  A,1BH
    	rst  4          ; Send character in A to screen/printer
    	pop  PSW
    	rst  4          ; Send character in A to screen/printer
    	ret
	
	
; ======================================================
; Send cursor to lower left of CRT
; ======================================================
L4277H	lhld  VACTLC    ; Active rows count (1-8)
	mvi   H,01H     
	
; ======================================================
; L427CH: Set cursor position
; Entry conditions: H = column number (1-40)
;                   L = row number (1-8)
; Exit conditions:  none
; ======================================================
POSIT	mvi  A,59H
    	call ESCA       ; End escape s.equence
    	mov  A,L
    	Adi  1FH
    	rst  4          ; Send character in A to screen/printer
    	mov  A,H
    	Adi  1FH
    	rst  4          ; Send character in A to screen/printer
    	ret
	
	
; ======================================================
; L428AH Erase function key display
; Entry conditions: none
; Exit conditions: none
; ======================================================
ERAFNK	lda  VLABLF     ; Label line protect status
    	ana  A
    	rz
    	call RSTSYS     ; Unprotect line 8.  An ESC U is printed
    	lhld VCURLN     ; Cursor row (1-8)
    	push H
    	call L4277H     ; Send cursor to lower left of CRT
    	call ERABOL     ; Erase from cursor to end of line
    	pop  H
    	call POSIT      ; Set the current cursor position (H=Row),L=Col)
    	call SDESCX     ; Send ESC X
    	xra  A
    	ret
	
	
; ======================================================
; L42A5H: Set and display function keys
; Entry conditions:
;           HL = Start address of function table
; Exit conditions: none
; ======================================================
STDSPF	call STFNK      ; Set new function key table
	
; ======================================================
; L42A8H: Display function keys
; Entry conditions: none
; Exit conditions:  none
; ======================================================
DSPNFK	lhld VCURLN     ; Cursor row (1-8)
    	lda  VACTLC     ; Active rows count (1-8)
    	cmp  L
    	jnz  L42C0
    	push H
    	call L45EDH
    	mvi  L,01H
    	call POSIT      ; Set the current cursor position (H=Row),L=Col)
    	CALL DELLin     ; Delete current line on screen
    	pop  H
    	dcr  L
L42C0	push H
    	call RSTSYS     ; Unprotect line 8.  An ESC U is printed
    	call L4277H     ; Send cursor to lower left of CRT
    	lxi  H,0F789H    ; Function key definition area
    	mvi  E,08H
    	lda  VRVIDF     ; Reverse video switch
    	push PSW
    	call EXTREF     ; Cancel inverse character mode
L42D3	LDA  VACTcc     ; Active columns count (1-40)
    	CPI  28H
    	lxi  B,L040CH
    	jz   L42E1
    	lxi  B,L0907H
L42E1	push H
    	lxi  H,0FAC3H
    	mov  A,E
    	SUI  06H
    	jz   L42ED
    	dcr  A
    	dcx  H
L42ED	cz   L4267
    	pop  H
    	call L1BE0H     ; Send B characters from M to the screen
    	dad  B
    	call EXTREF     ; Cancel inverse character mode
    	dcr  E
    	cnz  L001EH     ; Send a space to screen/printer
    	jnz  L42D3
    	call ERABOL     ; Erase from cursor to end of line
    	call SETSYS     ; Protect line 8.  An ESC T is printed
    	pop  PSW
    	ana  A
    	cnz  ENTREV     ; Start inverse character mode
    	pop  H
    	call POSIT      ; Set the current cursor position (H=Row),L=Col)
    	call SDESCX     ; Send ESC X
    	xra  A
    	ret
	
	
; ======================================================
; Print A to the screen
; ======================================================
L4313H	push  H         ; Preserve registers on stack
	push  D         
	push  B         
	push  PSW       
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	08H             
	call  L431FH    ; RST 7 returned to us. Print to the LCD.
	jmp   L14EDH    ; Pop AF), BC), DE), HL from stack
	
L431FH	mov   C,A       ; Save value to PLOT to LCD to C
	xra   A         ; Clear A to indicate POP of PSW not r.equired
	sta   VXPOPF    ; Indicate POP of PSW not r.equired
	lda   VNCONF     ; New Console device flag
	ana   A         ; Test if new console flag set
	jnz   L434AH    ; Jump if New Console flag set
	call  L4335H    ; Character plotting level 4. Turn off background task & call level 5
	lhld  VCURLN    ; Cursor row (1-8)
	shld  VCLNSA     ; Cursor row (1-8)
	ret             
	
	
; ======================================================
; Character plotting level 4. Turn off background task & call level 5
; ======================================================
L4335H	call  L73C5H    ; Turn off background task, blink & reinitialize cursor blink time
	call  L434CH    ; Character plotting level 5. Handle ESC s.equences & call level 6
L433BH	lhld  VCURLN    ; Cursor row (1-8)
	xchg            
	call  SETCUR    ; Disable Automatic Scrolling
	lda   0F63FH     ; Cursor status (0 = off)
	ana   A         ; Test if cursor is off
	rz              ; Return if cursor off
	jmp   L73D9H    ; Initialize Cursor Blink to start blinking
	
L434AH	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	3CH             
	
; ======================================================
; Character plotting level 5. Handle ESC s.equences & call level 6
; ======================================================
L434CH	lxi   H,0F646H   ; ESC mode flag for RST 20H
L434FH	mov   A,M       
	ana   A         
	jnz   L43FAH    ; ESCape s.equence driver
	mov   A,C       
	lhld  VCURLN    ; Cursor row (1-8)
	CPI   09H       
	jz    L4480H    ; Tab routine
	CPI   7FH       ; Test for DEL
	jz    L451FH    ; Jump to handle DEL
	CPI   20H       
	jc    L4373H    ; LCD output driver
	call  L4560H    ; Character plotting level 6. Save character in C to LCD RAM & call level 7
	call  L4453H    ; ESC C routine (move cursor right)
	rnz             
	mvi   H,01H     
	jmp   L4494H    ; Linefeed routine
	
	
; ======================================================
; LCD output driver
; ======================================================
L4373H	lxi   H,L4388H  ; Point to LCD code handler table
	mvi   C,08H     ; Indicate 8 entries in table
	
; ======================================================
; Key table handler function processing routine
; ======================================================
L4378H	inx   H         ; Skip entry handler address
	inx   H         ; Skip handler address MSB
	dcr   C         ; Decrement entry counter
	rm              ; Return if entry not found in table
	cmp   M         ; Test if this entry matches
	inx   H         ; Skip the key value
	jnz   L4378H    ; If no match, jump to test next entry
	mov   A,M       ; Get LSB of handler address
	inx   H         ; Point to handler address MSB
	mov   H,M       ; Get handler MSB
	mov   L,A       ; Copy handler LSB to L
	push  H         ; Push the key handler address on stack
	lhld  VCURLN    ; Cursor row (1-8)
	ret             ; "RETurn" to the key handler address
	
	
; ======================================================
; RST 20H lookup table
; ======================================================
    .db	07H             
    .dw	7662H          ; BSBeep routine
    .db	08H             
    .dw	4461H          ; Backspace routine
    .db	09H             
    .dw	4480H          ; Tab routine
    .db	0AH             
    .dw	4494H          ; Linefeed routine
    .db	0BH             
    .dw	44A8H          ; Vertical tab and ESC H routine (home cursor)
    .db	0CH             
    .dw	4548H          ; Form Feed (0CH), CLS, ESC E, and ESC J routine
    .db	0DH             
    .dw	44AAH          ; CR routine
    .db	1BH             
    .dw	43B2H          ; LCD output Escape routine
L43A2H	lda   VXPOPF     ; Get value at VXPOPF
	ana   A         ; Test if zero
	rz              ; Return if zero (No POP needed)
	pop   PSW       ; POP PSW from stack
	ret             
	
L43A9H	lda   VLABLF    ; Label line protect status
	Adi   08H       
	ret             
	
	
; ======================================================
; ESC Y routine (Set cursor position)
; ======================================================
L43AFH	mvi   A,02H     
	lxi   B,0AF3EH   
	sta   0F646H     ; ESC mode flag for RST 20H
	ret             
	
	
; ======================================================
; LCD Escape s.equence lookup table
; ======================================================
    .db	'j'             
    .dw	4548H          ; Form Feed (0CH), CLS, ESC E, and ESC J routine
    .db	'E'             
    .dw	4548H          ; Form Feed (0CH), CLS, ESC E, and ESC J routine
    .db	'K'             
    .dw	4537H          
    .db	'J'             
    .dw	454EH          
    .db	'l'             
    .dw	4535H          
    .db	'L'             
    .dw	44EAH          
    .db	'M'             
    .dw	44C4H          
    .db	'Y'             
    .dw	43AFH          
    .db	'A'             
    .dw	4469H          
    .db	'B'             
    .dw	446EH          
    .db	'C'             
    .dw	4453H          
    .db	'D'             
    .dw	445CH          
    .db	'H'             
    .dw	44A8H          ; Vertical tab and ESC H routine (home cursor)
    .db	'p'             
    .dw	4431H          
    .db	'q'             
    .dw	4432H          
    .db	'P'             
    .dw	44AFH          
    .db	'Q'             
    .dw	44BAH          
    .db	'T'             
    .dw	4439H          
    .db	'U'             
    .dw	4437H          
    .db	'V'             
    .dw	443FH          
    .db	'W'             
    .dw	4440H          
    .db	'X'             
    .dw	444AH          
	
; ======================================================
; ESCape s.equence driver
; ======================================================
L43FAH	mov   A,C       
	CPI   1BH       
	mov   A,M       
	jz    L4445H    
	ana   A         
	jp    L4411H    
	call  L43B3H    
	mov   A,C       
	lxi   H,L43B6H  ; Load pointer to key vector table
	mvi   C,16H     ; 16 entries in table
	jmp   L4378H    ; Key Vector table lookup
	
L4411H	dcr   A         
	sta   0F646H     ; ESC mode flag for RST 20H
	LDA   VACTcc    ; Active columns count (1-40)
	lxi   D,VCURCL  ; Cursor column (1-40)
	jz    L4426H    
	lda   VACTLC    ; Active rows count (1-8)
	lxi   H,VLABLF  ; Label line protect status
	add   M         
	dcx   D         
L4426H	mov   B,A       
	mov   A,C       
	SUI   20H       
	cmp   B         
	inr   A         
	stax  D         
	rc              
	mov   A,B       
	stax  D         
	ret             
	
	
; ======================================================
; ESC p routine (start inverse video)
; ======================================================
L4431H	ORI   0AFH       
	sta   VRVIDF    ; Reverse video switch
	ret             
	
	
; ======================================================
; ESC U routine (unprotect line 8)
; ======================================================
L4437H	xra   A         
	jnz   0FF3EH     
	sta   VLABLF    ; Label line protect status
	ret             
	
	
; ======================================================
; ESC V routine (stop automatic scrolling)
; ======================================================
L443FH	ORI   0AFH       
	sta   0F63EH     ; Scroll disable flag
	ret             
	
L4445H	inx   H         
	mov   M,A       
	jmp   L43B2H    ; LCD output Escape routine
	
L444AH	lxi   H,0F647H   
	mov   A,M       
	mvi   M,00H     
	dcx   H         
	mov   M,A       
	ret             
	
	
; ======================================================
; ESC C routine (move cursor right)
; ======================================================
L4453H	LDA   VACTcc    ; Active columns count (1-40)
	cmp   H         
	rz              
	inr   H         
	jmp   L4477H    
	
	
; ======================================================
; ESC D routine (move cursor left)
; ======================================================
L445CH	dcr   H         
	rz              
	jmp   L4477H    
	
	
; ======================================================
; Backspace routine
; ======================================================
L4461H	call  L445CH    ; ESC D routine (move cursor left)
	rnz             
	LDA   VACTcc    ; Active columns count (1-40)
	mov   H,A       
	
; ======================================================
; ESC A routine (move cursor up)
; ======================================================
L4469H	dcr   L         
	rz              
	jmp   L4477H    
	
	
; ======================================================
; ESC B routine (move cursor down)
; ======================================================
L446EH	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	cmp   L         
	rz              
	jc    L447BH    
	inr   L         
L4477H	shld  VCURLN    ; Cursor row (1-8)
	ret             
	
L447BH	dcr   L         
	xra   A         
	jmp   L4477H    
	
	
; ======================================================
; Tab routine
; ======================================================
L4480H	lda   VCURCL    ; Cursor column (1-40)
	push  PSW       
	mvi   A,20H     
	rst   4         ; Send character in A to screen/printer
	pop   B         
	lda   VCURCL    ; Cursor column (1-40)
	cmp   B         
	rz              
	dcr   A         
	ANI   07H       
	jnz   L4480H    ; Tab routine
	ret             
	
	
; ======================================================
; Linefeed routine
; ======================================================
L4494H	call  L446EH    ; ESC B routine (move cursor down)
	rnz             
	lda   0F63EH     ; Scroll disable flag
	ana   A         
	rnz             
	call  L4477H    
	call  L45EDH    
	mvi   L,01H     
	jmp   L44C7H    
	
	
; ======================================================
; Verticle tab and ESC H routine (home cursor)
; ======================================================
L44A8H	mvi   L,01H     ; Set ROW to 1 (TOP)
	
; ======================================================
; CR routine
; ======================================================
L44AAH	mvi   H,01H     ; Set COL to 1 (Left)
	jmp   L4477H    ; Jump to set new ROW,COL
	
	
; ======================================================
; ESC P routine (turn cursor on)
; ======================================================
L44AFH	mvi   A,01H     
	sta   0F63FH     ; Cursor status (0 = off)
	call  L43A2H    ; Conditionally POP PSW from stack based on value at VXPOPF
	jmp   L73D9H    ; Initialize Cursor Blink to start blinking
	
	
; ======================================================
; ESC Q routine (turn cursor off)
; ======================================================
L44BAH	xra   A         
	sta   0F63FH     ; Cursor status (0 = off)
	call  L43A2H    ; Conditionally POP PSW from stack based on value at VXPOPF
	jmp   L73C5H    ; Turn off background task, blink & reinitialize cursor blink time
	
	
; ======================================================
; ESC M routine
; ======================================================
L44C4H	call  L44AAH    ; CR routine
L44C7H	call  L43A2H    ; Conditionally POP PSW from stack based on value at VXPOPF
	call  L43A9H    
	sub   L         
	rc              
	jz    L4535H    ; ESC l routine (erase current line)
	
; ======================================================
; Scroll LCD screen A times at line number in L
; ======================================================
L44D2H	push  PSW       
	mvi   H,28H     
L44D5H	inr   L         
	call  L4512H    ; Get character at (H),L) from LCD RAM)
	dcr   L         
	call  L4566H    
	dcr   H         
	jnz   L44D5H    
	inr   L         
	pop   PSW       
	dcr   A         
	jnz   L44D2H    ; Scroll LCD screen A times at line number in L
	jmp   L4535H    ; ESC l routine (erase current line)
	
	
; ======================================================
; ESC L routine (insert line)
; ======================================================
L44EAH	call  L44AAH    ; CR routine
	call  L43A2H    ; Conditionally POP PSW from stack based on value at VXPOPF
	call  L43A9H    
	mov   H,A       
	sub   L         
	rc              
	jz    L4535H    ; ESC l routine (erase current line)
	mov   L,H       
L44FAH	push  PSW       
	mvi   H,28H     
L44FDH	dcr   L         
	call  L4512H    ; Get character at (H),L) from LCD RAM)
	inr   L         
	call  L4566H    
	dcr   H         
	jnz   L44FDH    
	dcr   L         
	pop   PSW       
	dcr   A         
	jnz   L44FAH    
	jmp   L4535H    ; ESC l routine (erase current line)
	
	
; ======================================================
; Get character at (H),L) from LCD RAM)
; ======================================================
L4512H	push  H         ; Save the H,L position on stack
	push  H         ; Save it again
	call  L4586H    ; Calculate offset within LCD RAM for ROW / COL in HL
	mov   C,M       ; Save the character in C
	pop   H         ; Get (H,L) position to calculate Reverse Video location
	call  L45AAH    ; Calculate address and bit mask of Reverse Video flag for char at (H,L)
	ana   M         ; Get the Reverse Video flag status
	pop   H         ; Restore original (H,L) position from stack
	ret             
	
L451FH	lda   VRVIDF    ; Reverse video switch
	push  PSW       
	call  EXTREF    ; Cancel inverse character mode
	mvi   A,08H     
	rst   4         ; Send character in A to screen/printer
	mvi   A,20H     
	rst   4         ; Send character in A to screen/printer
	mvi   A,08H     
	rst   4         ; Send character in A to screen/printer
	pop   PSW       
	ana   A         
	rz              
	jmp   ENTREV    ; Start inverse character mode
	
	
; ======================================================
; ESC l routine (erase current line)
; ======================================================
L4535H	mvi   H,01H     
	
; ======================================================
; ESC K routine (erase to EOL)
; ======================================================
L4537H	call  L43A2H    ; Conditionally POP PSW from stack based on value at VXPOPF
L453AH	mvi   C,20H     
	xra   A         
	call  L4566H    
	inr   H         
	mov   A,H       
	CPI   29H       
	jc    L453AH    
	ret             
	
	
; ======================================================
; Form Feed (0CH)), CLS), ESC E), and ESC J routine
; ======================================================
L4548H	call  L44A8H    ; Verticle tab and ESC H routine (home cursor)
	call  L45D3H    
	
; ======================================================
; ESC J routine
; ======================================================
L454EH	call  L43A2H    ; Conditionally POP PSW from stack based on value at VXPOPF
L4551H	call  L4537H    ; ESC K routine (erase to EOL)
	call  L43A9H    
	cmp   L         
	rc              
	rz              
	mvi   H,01H     
	inr   L         
	jmp   L4551H    
	
	
; ======================================================
; Character plotting level 6.  Save character in C to LCD RAM & call level 7
; ======================================================
L4560H	call  L43A2H    ; Conditionally POP PSW from stack based on value at VXPOPF
	lda   VRVIDF    ; Reverse video switch
L4566H	push  H         
	push  PSW       
	push  H         
	push  H         
	call  L459AH    
	pop   H         
	call  L4586H    ; Calculate offset within LCD RAM for ROW / COL in HL
	mov   M,C       
	pop   D         
	call  L73EEH    ; Character plotting level 7. Plot character in C on LCD at (H),L)
	pop   PSW       
	ana   A         
	pop   H         
	rz              
	di              
	mvi   A,0DH     
	sim             
	ei              
	call  L73A9H    ; Blink the cursor
	mvi   A,09H     
	sim             
	ret             
	
L4586H	mov   A,L       ; Put ROW number in A
	add   A         ; A = L*2
	add   A         ; A = L*4
	add   L         ; A = L*5
	add   A         ; A = L*10
	add   A         ; A = L*20
	add   A         ; A = L*40
	mov   E,A       ; Save in DE
	sbb   A         ; Calculate MSB of ROW*40
	cma             ; Compiliment the result
	mov   D,A       ; And save in DE
	mov   L,H       ; Get COL into L
	mvi   H,00H     ; Zero out MSB of RAM offset
	dad   D         ; Add ROW RAM offset
	lxi   D,0FED7H   ; Load base address of LCD RAM minus 41
	dad   D         ; Index into LCD RAM (ROW/COl is 1 based, so 41
	ret             ; offset above puts the start at FF00H)
	
L459AH	mov   B,A       ; Save normal/reverse video flag in B
	call  L45AAH    ; Calculate address and bit mask of Reverse Video flag for char at (H,L)
	inr   B         ; Prepare to test for normal video
	dcr   B         ; Test for normal video (zero)
	jz    L45A6H    ; Jump if normal video to clear the bit in the bit-field
	ora   M         ; OR in current byte with the calculated mask
	mov   M,A       ; Save new byte back to the buffer
	ret             
	
L45A6H	cma             ; Compliment the contents of A to clear the bit
	ana   M         ; AND with current byte
	mov   M,A       ; Save the bit field back to the buffer
	ret             
	
L45AAH	mov   A,L       ; Put ROW in A
	add   A         ; A=ROW*2
	add   A         ; A=ROW*4
	add   L         ; A=ROW*5 (5 bit-field bytes per row)
	mov   L,A       ; Put Offset of start of row in L
	mov   A,H       ; Get col number
	dcr   A         ; Decrement col number
	push  PSW       
	Rrc             ; Divide col number by 8 to get byte number
	Rrc             
	Rrc             
	ANI   1FH       ; Keep only lower 5 bits
	add   L         ; Add the row start byte
	mov   L,A       ; Save in L for index into buffer
	mvi   H,00H     ; Zero out MSB
	lxi   D,0FB35H   ; Load pointer to buffer (minus 5 since Row is 1 based)
	dad   D         ; Index into buffer
	pop   PSW       ; Restore col number
	ANI   07H       ; Calculate col % 8
	mov   D,A       ; Save in D
	xra   A         ; Clear A
	stc             ; Prepare to rotate a '1' through a to find bit position
L45C5H	rar             ; Rotate '1' through MSB
	dcr   D         ; Decrement bit count
	jp    L45C5H    ; Jump until zero
	ret             
	
L45CBH	push  H         ; Preserve HL on stack
	call  L45AAH    ; Calculate address and bit mask of Reverse Video flag for char at (H,L)
	xra   M         ; Invert the current position bit
	mov   M,A       ; Save it back
	pop   H         ; Restore HL
	ret             
	
L45D3H	call  L43A2H    ; Conditionally POP PSW from stack based on value at VXPOPF
	LDA   VKYScm     
	add   A         
	rp              
	push  H         
	lxi   H,VAALCD  ; Start of Alt LCD character buffer
	lxi   B,L0140H  ; TODO: figure out where this points
L45E2H	mvi   M,20H     
	inx   H         
	dcx   B         
	mov   A,B       
	ora   C         
	jnz   L45E2H    
	pop   H         
	ret             
	
L45EDH	call  L43A2H    ; Conditionally POP PSW from stack based on value at VXPOPF
	LDA   VKYScm     
	add   A         
	rp              
	lxi   D,VAALCD  ; Start of Alt LCD character buffer
	lxi   H,0FCE8H   
	lxi   B,L0140H  
	jmp   L6BDBH    ; Move BC bytes from M to (DE) with increment
	
L4601H	call  L73C5H    ; Turn off background task, blink & reinitialize cursor blink time
	mvi   L,01H     ; Prepare to point to LCD RAM (1,1)
L4606H	mvi   H,01H     ; "
L4608H	call  L4512H    ; Get character at (H),L) from LCD RAM)
	call  L4566H    ; Call Level 6 Character Draw routine
	inr   H         ; Increment column
	mov   A,H       ; Prepare to test for column 40
	CPI   29H       ; Test if beyond column 40
	jnz   L4608H    ; Jump if more columns on this line
	inr   L         ; Increment line
	mov   A,L       ; Prepare to test if last line refreshed
	CPI   09H       ; Test if beyond line 8
	jnz   L4606H    ; Jump back to refresh next line if not on line 9
	jmp   L433BH    ; Get Cursor ROW,COL in DE and start cursor blinking if cursor on
	
L461FH	lxi   H,VAALCD   ; Start of Alt LCD character buffer
	mvi   E,01H     
L4624H	mvi   D,01H     
L4626H	push  H         
	push  D         
	mov   C,M       
	call  L73EEH    ; Character plotting level 7. Plot character in C on LCD at (H),L)
	pop   D         
	pop   H         
	inx   H         
	inr   D         
	mov   A,D       
	CPI   29H       
	jnz   L4626H    
	inr   E         
	mov   A,E       
	CPI   09H       
	jnz   L4624H    
	ret             
	
	
; ======================================================
; Input and display line and store
; ======================================================
L463EH	mvi   A,3FH     ; Load ASCII value for '?'
	rst   4         ; Send character in A to screen/printer
	mvi   A,20H     ; Load ASCII value for space
	rst   4         ; Send character in A to screen/printer
	
; ======================================================
; L4644H: Get line from keyboard (terminated by <ENTER>)
; Entry conditions: none
; Exit conditions:  data stored at location VKYBBF
; ======================================================
INLIN	call L421AH
    	jnz  L4703
    	lda  VCURCL     ; Cursor column (1-40)
    	sta  0FACAH
    	lxi  D,VKYBBF   ; Keyboard buffer
    	mvi  B,01H
L4655	call CHGET      ; Wait for key from keyboard
    	lxi  H,L4655
    	push H
    	rc
    	CPI  7FH
    	jz   IHBACK     ; Input routine backspace, left arrow, CTRL-H handler
    	CPI  20H
    	JNC  L46cc
    	lxi  H,KYVTAB-2 ; Load pointer to key vector table, it points to two bytes lower, as the lookup routine increments HL twice first.
    	mvi  C,07H      ; Seven entries in table
    	jmp  L4378H     ; Key Vector table lookup
	
; ======================================================
; L466FH: Input routine Key vector table
; ======================================================
KYVTAB
    .db   03H
    .dw   IHCTC          ; CTRL-C Handler
    .db   08H
    .dw   IHBACK         ; Backspace handler
    .db   09H
    .dw   IHTAB          ; TAB handler
    .db   0DH
    .dw   IHENTR         ; ENTER key handler
    .db   15H
    .dw   IHCTUX         ; CTRL-U handler
    .db   18H
    .dw   IHCTUX         ; CTRL-X Handler
    .db   1DH
    .dw   IHBACK         ; Left arrow handler
	
; ======================================================
; L4684H: Input routine Control-C handler
; ======================================================
IHCTC	pop  H
    	mvi  A,5EH
    	rst  4          ; Send character in A to screen/printer
    	mvi  A,43H
    	rst  4          ; Send character in A to screen/printer
    	call CRLF       ; Send CRLF to screen or printer
    	lxi  H,VKYBBF   ; Keyboard buffer
    	mvi  M,00H
    	dcx  H
    	stc
    	ret
	
	
; ======================================================
; L4696H: Input routine ENTER handler
; ======================================================
IHENTR	pop  H
    	call CRLF       ; Send CRLF to screen or printer
    	xra  A
    	stax D
    	jmp  L7FFAH     ; Different from M100
    	ret
	
	
; ======================================================
; L46A0H: Input routine backspace, left arrow, CTRL-H handler
; ======================================================
IHBACK	mov  A,B
    	dcr  A
    	stc 
    	rz 
    	dcr  B
    	dcx  D
    	call l46D8
L46A9	push PSW
	mvi  A,7FH
	rst  4          ; Send character in A to screen/printer
	lhld VCURLN     ; Cursor row (1-8)
	dcr  L
	dcr  H
	mov  A,H
	ora  L
	jz   L46C0
	lxi  H,VCURCL   ; Cursor column (1-40)
	pop  PSW
	cmp  M
	jnz  L46A9
	ret
L46C0	pop  PSW
    	stc
    	ret
	
	
; ======================================================
; L46C3H: Input routine CTRL-U & X handler
; ======================================================
IHCTUX	call IHBACK     ; Input routine backspace, left arrow, CTRL-H handler
    	jnc  IHCTUX     ; Input routine CTRL-U & X handler
    	ret
	
	
; ======================================================
; L46CAH: Input routine Tab handler
; ======================================================
IHTAB	mvi  A,09H      ; Load the code for a TAB
L46CC	inr  B          ; Increment the length
    	jz   L46D4      ; Test if 255 bytes entered
    	rst  4          ; Send character in A to screen/printer
    	stax D
    	inx  D
    	ret
L46D4	dcr  B
    	jmp  BSBEEP       ; BSBEEP statement
l46D8	push B
    	lda  0FACAH
    	dcr  B
    	jz   l4701
    	mov  C,A
    	lxi  H,VKYBBF   ; Keyboard buffer
L46E4	inr  C
	mov  A,M
	CPI  09H
	jnz  l46F2
	mov  A,C
	dcr  A
	ANI  07H
	jnz  L46E4
l46F2	LDA  VACTcc     ; Active columns count (1-40)
    	cmp  C
    	jnc  L46FB
    	mvi  C,01H
L46FB	inx  H
	dcr  B
	jnz  L46E4
	mov  A,C
l4701	pop  B
    	ret
L4703	lhld 0FC8CH      ; Load pointer to File Control Block
	push H          ; Save address on stack
	inx  H          ; \
	inx  H          ;  \  Offset to file device type byte
	inx  H          ;  /
	inx  H          ; /
	mov  A,M        ; Get file device type
	SUI  0F8H        ; Test for RAM device
	jnz  L4728      ; Jump if not RAM device
	mov  L,A        ; Zero out the Address (A=0 from SUI)
	mov  H,A
	shld 0FC8CH      ; Clear out the ASCII / Tokenize FCB address
	lxi  H,0FAC4H
	inr  M
	mov  A,M
	Rrc
	cnc  ENTREV     ; Start inverse character mode
	lxi  H,L5593H   ; Load pointer to 0DH," Wait" text
	call L27B1H     ; Print buffer at M until NULL or '"'
	call EXTREF     ; Cancel inverse character mode
L4728	pop  H          ; Restore ASCII / Tokenize FCB address from stack
    	shld 0FC8CH      ; Save back in ASCII / Tokenize FCB address variable
    	mvi  B,00H
    	lxi  H,VKYBBF   ; Keyboard buffer
L4731	xra  A
	sta  VFDAIO
	sta  0FAA3H
	call L4E7AH
	jc   L4759
	mov  M,A
	CPI  0DH
	jz   L4753
	CPI  09H
	jz   L474E
	CPI  20H
	jc   L4731
L474E	inx  H
   	dcr  B
    	jnz  L4731
L4753	xra  A
	mov  M,A
	lxi  H,0F684H
	ret
L4759	mov  A,B
	ana  A
	jnz  L4753
	lda  0FCA7H
	ANI  80H
	sta  0FCA7H
	call L4F45H
	mvi  A,0DH
	rst  4          ; Send character in A to screen/printer
	call ERABOL     ; Erase from cursor to end of line
	lda  VBASEF      ; Flag to execute BASIC program
	ana  A
	jz   NOBEXE
	call L3F28H     ; Initialize BASIC Variables for new execution
	jmp  BASEXE     ; Execute BASIC program
NOBEXE	lda  0F651H      ; In TEXT because of BASIC EDIT flag
	ana  A
	jnz  L5EBAH
	jmp  L0501H     ; Pop stack and vector to BASIC ready

; ======================================================
; DIM ',' entry separator handler function
; ======================================================
L4786H	dcx   H         ; Decrement BASIC file byte pointer
	rst   2         ; Get next non-white char from M
	rz              ; Return if end of statement
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ',' separator for DIM
	
; ======================================================
; DIM statement
; ======================================================
BSDIM	lxi   B,L4786H  ; Load "RET"urn address of ',' DIM separator routine
	push  B         ; Push retrun address to stack
	ORI   0AFH       ; Makes 0AFH below look like ORI 0AFH
	sta   0FB64H     ; Variable Create/Locate switch
	mov   C,M       
	call  L40F1H    ; Check if M is alpha character
	jc    ERRSYN    ; Generate Syntax error
	xra   A         
	mov   B,A       
	rst   2         ; Get next non-white char from M
	jc    L47A7H    
	call  L40F2H    ; Check if A is alpha character
	jc    L47B2H    
L47A7H	mov   B,A       
L47A8H	rst   2         ; Get next non-white char from M
	jc    L47A8H    
	call  L40F2H    ; Check if A is alpha character
	jnc   L47A8H    
L47B2H	CPI   26H       ; Test for &
	jnc   L47CEH    
	lxi   D,L47DCH  
	push  D         
	mvi   D,02H     
	CPI   25H       ; Test for %
	rz              
	inr   D         
	CPI   24H       ; Test for $
	rz              
	inr   D         
	CPI   21H       ; Test for !
	rz              
	mvi   D,08H     
	CPI   23H       ; Test for #
	rz              
	pop   PSW       
L47CEH	mov   A,C       
	ANI   7FH       
	mov   E,A       
	mvi   D,00H     
	push  H         
	lxi   H,0FB79H   
	dad   D         
	mov   D,M       
	pop   H         
	dcx   H         
L47DCH	mov   A,D       
	sta   0FB65H     ; Type of last variable used
	rst   2         ; Get next non-white char from M
	lda   0FB96H     ; FOR/NEXT loop active flag
	dcr   A         
	jz    L48BCH    
	jp    L47F6H    
	mov   A,M       
	SUI   28H       
	jz    L488DH    
	SUI   33H       
	jz    L488DH    
L47F6H	xra   A         
	sta   0FB96H     ; FOR/NEXT loop active flag
	push  H         
	lhld  VPSVAR     ; Start of variable data pointer
	jmp   L481AH    
	
L4801H	ldax  D         
	mov   L,A       
	inx   D         
	ldax  D         
	inx   D         
	cmp   C         
	jnz   L4816H    
	lda   0FB65H     ; Type of last variable used
	cmp   L         
	jnz   L4816H    
	ldax  D         
	cmp   B         
	jz    L4876H    
L4816H	inx   D         
	mvi   H,00H     
	dad   D         
L481AH	xchg            
	lda   VARRTP     ; Start of array table pointer
	cmp   E         
	jnz   L4801H    
	lda   0FBB5H     
	cmp   D         
	jnz   L4801H    
	jmp   L4835H    
	
L482CH	call  L4790H    ; Find address of variable at M
L482FH	ret             
	
L4830H	mov   D,A       
	mov   E,A       
	pop   B         
	xthl            
	ret             
	
L4835H	pop   H         
	xthl            
	push  D         
	lxi   D,L482FH  
	rst   3         ; Compare DE and HL
	jz    L4830H    
	lxi   D,L0FDDH  
	rst   3         ; Compare DE and HL
	pop   D         
	jz    L4879H    
	xthl            
	push  H         
	push  B         
	lda   0FB65H     ; Type of last variable used
	mov   C,A       
	push  B         
	mvi   B,00H     
	inx   B         
	inx   B         
	inx   B         
	lhld  VPFREM     ; Unused memory pointer
	push  H         
	dad   B         
	pop   B         
	push  H         
	call  L3EF0H    ; Copy bytes from BC to HL with decriment until BC=DE
	pop   H         
	shld  VPFREM     ; Unused memory pointer
	mov   H,B       
	mov   L,C       
	shld  VARRTP     ; Start of array table pointer
L4867H	dcx   H         
	mvi   M,00H     
	rst   3         ; Compare DE and HL
	jnz   L4867H    
	pop   D         
	mov   M,E       
	inx   H         
	pop   D         
	mov   M,E       
	inx   H         
	mov   M,D       
	xchg            
L4876H	inx   D         
	pop   H         
	ret             
	
L4879H	sta   VVC1SD    ; Start of FAC1 for single and double precision
	mov   H,A       
	mov   L,A       
	shld  VFAC1I    ; Start of FAC1 for integers
	rst   5         ; Determine type of last var used
	jnz   L488BH    
	lxi   H,L03F5H  
	shld  VFAC1I    ; Start of FAC1 for integers
L488BH	pop   H         
	ret             
	
L488DH	push  H         
	lhld  0FB64H     ; Variable Create/Locate switch
	xthl            
	mov   D,A       
L4893H	push  D         
	push  B         
	call  L08D6H    
	pop   B         
	pop   PSW       
	xchg            
	xthl            
	push  H         
	xchg            
	inr   A         
	mov   D,A       
	mov   A,M       ; Get next byte from BASIC line
	CPI   2CH       ; Test for ','
	jz    L4893H    
	CPI   29H       ; Test for ')'
	jz    L48B0H    
	CPI   5DH       ; Test for ']'
	jnz   ERRSYN    ; Generate Syntax error
L48B0H	rst   2         ; Get next non-white char from M
	shld  0FBA8H     
	pop   H         
	shld  0FB64H     ; Variable Create/Locate switch
	mvi   E,00H     
	push  D         
	lxi   D,0F5E5H   
	lhld  VARRTP    ; Start of array table pointer
	mvi   A,19H     
	xchg            
	lhld  VPFREM    ; Unused memory pointer
	xchg            
	rst   3         ; Compare DE and HL
	jz    L48FCH    
	mov   E,M       
	inx   H         
	mov   A,M       
	inx   H         
	cmp   C         
	jnz   L48DDH    
	lda   0FB65H     ; Type of last variable used
	cmp   E         
	jnz   L48DDH    
	mov   A,M       
	cmp   B         
L48DDH	inx   H         
	mov   E,M       
	inx   H         
	mov   D,M       
	inx   H         
	jnz   L48C2H    
	lda   0FB64H     ; Variable Create/Locate switch
	ora   A         
	jnz   L044FH    ; Generate DD error
	pop   PSW       
	mov   B,H       
	mov   C,L       
	jz    L383EH    
	sub   M         
	jz    L495AH    
L48F6H	lxi   D,L0009H  ; Prepare to generate BS Error (Bad Subscript)
	jmp   L045DH    ; Generate error in E
	
L48FCH	lda   0FB65H     ; Type of last variable used
	mov   M,A       
	inx   H         
	mov   E,A       
	mvi   D,00H     
	pop   PSW       
	jz    L08DBH    ; Generate FC error
	mov   M,C       
	inx   H         
	mov   M,B       
	inx   H         
	mov   C,A       
	call  L3EFFH    ; Test for C * 2 bytes free space in Stack
	inx   H         
	inx   H         
	shld  0FB8EH     
	mov   M,C       
	inx   H         
	lda   0FB64H     ; Variable Create/Locate switch
	ral             
	mov   A,C       
L491CH	lxi   B,L000BH  
	jnc   L4924H    
	pop   B         
	inx   B         
L4924H	mov   M,C       
	push  PSW       
	inx   H         
	mov   M,B       
	inx   H         
	call  L36D8H    
	pop   PSW       
	dcr   A         
	jnz   L491CH    
	push  PSW       
	mov   B,D       
	mov   C,E       
	xchg            
	dad   D         
	jc    L3F17H    ; Reinit BASIC stack and generate OM error
	call  L3F08H    ; Test HL against stack space for collision
	shld  VPFREM     ; Unused memory pointer
L493FH	dcx   H         
	mvi   M,00H     
	rst   3         ; Compare DE and HL
	jnz   L493FH    
	inx   B         
	mov   D,A       
	lhld  0FB8EH     
	mov   E,M       
	xchg            
	dad   H         
	dad   B         
	xchg            
	dcx   H         
	dcx   H         
	mov   M,E       
	inx   H         
	mov   M,D       
	inx   H         
	pop   PSW       
	jc    L498DH    
L495AH	mov   B,A       
	mov   C,A       
	mov   A,M       
	inx   H         
	mvi   D,0E1H     
	mov   E,M       
	inx   H         
	mov   D,M       
	inx   H         
	xthl            
	push  PSW       
	rst   3         ; Compare DE and HL
	jnc   L48F6H    
	call  L36D8H    
	dad   D         
	pop   PSW       
	dcr   A         
	mov   B,H       
	mov   C,L       
	jnz   L495FH    
	lda   0FB65H     ; Type of last variable used
	mov   B,H       
	mov   C,L       
	dad   H         
	SUI   04H       
	jc    L4985H    
	dad   H         
	jz    L498AH    
	dad   H         
L4985H	ora   A         
	jpo   L498AH    
	dad   B         
L498AH	pop   B         
	dad   B         
	xchg            
L498DH	lhld  0FBA8H     
	ret             
	
	
; ======================================================
; USING function
; ======================================================
BFUSNG	call  L0DACH    ; Main BASIC evaluation routine
	call  L7304H    ; Different from M100
	rst   1         ; Compare next byte with M
    .db	3BH             
	xchg            
	lhld  VFAC1I     ; Start of FAC1 for integers
	jmp   L49A9H    
	
L49A0H	lda   VFB98H     
	ora   A         
	jz    L49B4H    
	pop   D         
	xchg            
L49A9H	push  H         
	xra   A         
	sta   VFB98H     
	inr   A         
	push  PSW       
	push  D         
	mov   B,M       
	inr   B         
	dcr   B         
L49B4H	jz    L08DBH    ; Generate FC error
	inx   H         
	mov   A,M       
	inx   H         
	mov   H,M       
	mov   L,A       
	jmp   L49DCH    
	
L49BFH	mov   E,B       
	push  H         
	mvi   C,02H     
L49C3H	mov   A,M       ; Get next char from BASIC line
	inx   H         
	CPI   5CH       ; Test for '\'
	jz    L4B07H    
	CPI   20H       ; Test for space
	jnz   L49D4H    
	inr   C         
	dcr   B         
	jnz   L49C3H    
L49D4H	pop   H         
	mov   B,E       
	mvi   A,5CH     
L49D8H	call  L4B3AH    
	rst   4         ; Send character in A to screen/printer
L49DCH	xra   A         
	mov   E,A       
	mov   D,A       
L49DFH	call  L4B3AH    
	mov   D,A       
	mov   A,M       
	inx   H         
	CPI   21H       ; Test for !
	jz    L4B04H    
	CPI   23H       ; Test for #
	jz    L4A2EH    
	dcr   B         
	jz    L4AF0H    
	CPI   2BH       ; Test for +
	mvi   A,08H     
	jz    L49DFH    
	dcx   H         
	mov   A,M       
	inx   H         
	CPI   2EH       ; Test for .
	jz    L4A4DH    
	CPI   5CH       ; Test for \
	jz    L49BFH    
	cmp   M         
	jnz   L49D8H    
	CPI   24H       ; Test for $
	jz    L4A27H    
	CPI   2AH       ; Test for *
	jnz   L49D8H    
	inx   H         
	mov   A,B       
	CPI   02H       
	jc    L4A1FH    
	mov   A,M       
	CPI   24H       
L4A1FH	mvi   A,20H     
	jnz   L4A2BH    
	dcr   B         
	inr   E         
	CPI   0AFH       
	Adi   10H       
	inx   H         
L4A2BH	inr   E         
	add   D         
	mov   D,A       
L4A2EH	inr   E         
	mvi   C,00H     
	dcr   B         
	jz    L4A83H    
	mov   A,M       
	inx   H         
	CPI   2EH       ; Test for .
	jz    L4A58H    
	CPI   23H       ; Test for #
	jz    L4A2EH    
	CPI   2CH       ; Test for ,
	jnz   L4A64H    
	mov   A,D       
	ORI   40H       
	mov   D,A       
	jmp   L4A2EH    
	
L4A4DH	mov   A,M       
	CPI   23H       
	mvi   A,2EH     
	jnz   L49D8H    
	mvi   C,01H     
	inx   H         
L4A58H	inr   C         
	dcr   B         
	jz    L4A83H    
	mov   A,M       
	inx   H         
	CPI   23H       
	jz    L4A58H    
L4A64H	push  D         
	lxi   D,L4A81H  
	push  D         
	mov   D,H       
	mov   E,L       
	CPI   5EH       
	rnz             
	cmp   M         
	rnz             
	inx   H         
	cmp   M         
	rnz             
	inx   H         
	cmp   M         
	rnz             
	inx   H         
	mov   A,B       
	SUI   04H       
	rc              
	pop   D         
	pop   D         
	mov   B,A       
	inr   D         
	inx   H         
	jz    0D1EBH     
L4A83H	mov   A,D       
	dcx   H         
	inr   E         
	ANI   08H       
	jnz   L4AA3H    
	dcr   E         
	mov   A,B       
	ora   A         
	jz    L4AA3H    
	mov   A,M       
	SUI   2DH       
	jz    L4A9EH    
	CPI   0FEH       
	jnz   L4AA3H    
	mvi   A,08H     
L4A9EH	Adi   04H       
	add   D         
	mov   D,A       
	dcr   B         
L4AA3H	pop   H         
	pop   PSW       
	jz    L4AF9H    
	push  B         
	push  D         
	call  BMEVAL    ; Main BASIC evaluation routine
	pop   D         
	pop   B         
	push  B         
	push  H         
	mov   B,E       
	mov   A,B       
	add   C         
	CPI   19H       
	jnc   L08DBH    ; Generate FC error
	mov   A,D       
	ORI   80H       
	call  L39E9H    
	call  L27B1H    ; Print buffer at M until NULL or '"'
L4AC2H	pop   H         
	dcx   H         
	rst   2         ; Get next non-white char from M
	stc             
	jz    L4AD7H    
	sta   VFB98H     
	CPI   3BH       
	jz    L4AD6H    
	CPI   2CH       
	jnz   ERRSYN    ; Generate Syntax error
L4AD6H	rst   2         ; Get next non-white char from M
L4AD7H	pop   B         
	xchg            
	pop   H         
	push  H         
	push  PSW       
	push  D         
	mov   A,M       
	sub   B         
	inx   H         
	mvi   D,00H     
	mov   E,A       
	mov   A,M       
	inx   H         
	mov   H,M       
	mov   L,A       
	dad   D         
	mov   A,B       
	ora   A         
	jnz   L49DCH    
	jmp   L4AF4H    
	
L4AF0H	call  L4B3AH    
	rst   4         ; Send character in A to screen/printer
L4AF4H	pop   H         
	pop   PSW       
	jnz   L49A0H    
L4AF9H	cc    L4BCBH    
	xthl            
	call  L291CH    
	pop   H         
	jmp   L0C39H    ; Jump to address of routine to terminate BASIC?
	
L4B04H	mvi   C,01H     
	mvi   A,0F1H     ; Make 0F1H below look like MVI A,0F1H
	dcr   B         
	call  L4B3AH    
	pop   H         
	pop   PSW       
	jz    L4AF9H    
	push  B         
	call  BMEVAL    ; Main BASIC evaluation routine
	call  L35D9H    ; Generate TM error if last variable type not string or RET
	pop   B         
	push  B         
	push  H         
	lhld  VFAC1I     ; Start of FAC1 for integers
	mov   B,C       
	mvi   C,00H     
	mov   A,B       
	push  PSW       
	call  L29B2H    
	call  L27B4H    
	lhld  VFAC1I     ; Start of FAC1 for integers
	pop   PSW       
	sub   M         
	mov   B,A       
	mvi   A,20H     
	inr   B         
L4B32H	dcr   B         
	jz    L4AC2H    
	rst   4         ; Send character in A to screen/printer
	jmp   L4B32H    
	
L4B3AH	push  PSW       
	mov   A,D       
	ora   A         
	mvi   A,2BH     
	cnz   LCD       ; Send A to screen or printer
	pop   PSW       
	ret             
	
	
; ======================================================
; L4B44H: Displays a character on the LCD at current 
;        cursor position. (Also RST 4)
; Entry conditions: A = character to be displayed
; Exit conditions:  none
; ======================================================
LCD	push PSW     	; Preserve character on stack
	push H
	call L421AH     ; Test for output to a file
	jnz  L4E52H     ; Jump to send to file instead if enabled
	pop  H
	lda  VOUTSW     ; Output device for RST 20H (0=screen)
	ora  A          ; Test for output to LCD or LPT
	jz   DCHSTK     ; Jump if output to LCD
	pop  PSW        ; Restore char to be sent to LPT
	
; ======================================================
; L4B55H: Print a character expanding tabs to spaces
; Entry conditions: A = character to be printed
; Exit conditions:  none
; ======================================================
PRTTAB	push PSW        ; Save character on stack
    	CPI  09H        ; Test for TAB char
    	jnz  SNTABC     ; Jump if not TAB to send to LPT
LSNDSP	mvi  A,20H      ; Prepare to send spaces
	call PRTTAB     ; Print A to printer, expanding tabs if necessary
	lda  VLPPCL     ; Line printer head position
	ANI  07H        ; Test if col is factor of 8
	jnz  LSNDSP     ; Jump to send more spaces
	pop  PSW        ; Restore character
	ret
; ======================================================
; L4B6AH: Send non-TAB character to printer
; ======================================================
SNTABC	SUI  0DH        ; Test for CR
	jz   ISCRCH     ; Jump if CR character
	jc   NCRCHA     ; Jump if not LF character
	lda  VLPPCL     ; Line printer head position
	inr  A          ; Increment printer line (LF detected)
ISCRCH	sta  VLPPCL     ; Line printer head position
NCRCHA	pop  PSW        ; Restore character from stack
L4B7A	CPI  0AH        ; Test for LF
	jnz  L4B88      ; Jump to skip CRLF test if not LF
	push B          ; Preserve BC on stack
	mov  B,A        ; Save char in B
	lda  0FAACH      ; Last char sent to printer
	CPI  0DH        ; Test if 0Ah following 0Dh
	mov  A,B        ; Restore character
	pop  B          ; Restore BC
L4B88	sta  0FAACH      ; Last char sent to printer
	rz              ; Don't send 0Ah if last char was 0Dh
	CPI  1AH        ; Test for EOF char
	rz              ; Return if EOF character
	jmp  PNOTAB     ; Output character to printer
	
; ======================================================
; L4B92H: Reinitialize output back to LCD
; ======================================================
ROTLCD	xra  A          ; Zero out A
	sta  VOUTSW     ; Output device for RST 20H (0=screen)
	lda  VLPPCL     ; Line printer head position
	ora  A
	rz
	lda  0FACDH
	ora  A
	rz
L4BA0	mvi  A,0DH
	call L4B7A
	xra  A
	sta  VLPPCL     ; Line printer head position
	ret
	
; ======================================================
; L4BAAH: Restore char to send to LCD from stack and display it
; ======================================================
DCHSTK	pop  PSW        ; Pop char to display from stack
	
; ======================================================
; LCD character output routine
; ======================================================
	push  PSW       ; Preserve character
	call  L4313H    ; Print A to the screen
	lda   VCURCL    ; Cursor column (1-40)
	dcr   A         
	sta   0F788H     ; Horiz. position of cursor (0-39)
	pop   PSW       ; Restore character
	ret             
	
	
; ======================================================
; Move LCD to blank line (send CRLF if needed)
; ======================================================
L4BB8H	lda   VCURCL    ; Cursor column (1-40)
	dcr   A         
	rz              
	jmp   L4BCBH    
	
	mvi   M,00H     
	call  L421AH    
	lxi   H,0F684H   
	jnz   L4BD1H    
L4BCBH	mvi   A,0DH     
	rst   4         ; Send character in A to screen/printer
	mvi   A,0AH     
	rst   4         ; Send character in A to screen/printer
L4BD1H	call  L421AH    
	jz    L4BD9H    
	xra   A         
	ret             
	
L4BD9H	lda   VOUTSW    ; Output device for RST 20H (0=screen)
	ora   A         
	jz    L4BE5H    
	xra   A         
	sta   VLPPCL    ; Line printer head position
	ret             
	
L4BE5H	xra   A         
	sta   0F788H     ; Horiz. position of cursor (0-39)
	ret             
	
	
; ======================================================
; INKEY$ function
; ======================================================
BFINKY	rst   2         ; Get next non-white char from M
	push  H         
	call  CHSNS     ; Check keyboard queue for pending characters
	jz    L4BFEH    
	call  CHGET     ; Wait for key from keyboard
	push  PSW       
	call  L275BH    ; Create a 1-byte transient string (for CHR$ & INKEY$)
	pop   PSW       
	mov   E,A       
	call  L2965H    
L4BFEH	lxi   H,L03F5H  
	shld  VFAC1I     ; Start of FAC1 for integers
	mvi   A,03H     ; Load code for String variable type
	sta   0FB65H     ; Type of last variable used
	pop   H         
	ret             
	
L4C0BH	push  H         
	jmp   L4C21H    
	
L4C0FH	call  BMEVAL    ; Main BASIC evaluation routine
	push  H         ; Save HL on stack
	call  L2916H    ; Get pointer to most recently used string (Len + address)
	mov   A,M       ; Get length of the string
	ora   A         ; Test for zero length string
	jz    L4C55H    ; Generate NM error if zero length string
	inx   H         ; Point to string data pointer
	mov   E,M       ; Get LSB of string data pointer
	inx   H         ; Point to MSB of string data pointer
	mov   H,M       ; Get MSB of string data pointer
	mov   L,E       ; Put LSB of string data pointer in L
	mov   E,A       ; Put length of string in E
L4C21H	call  L5075H    ; DSKI$ function - test for special device name
	push  PSW       ; Push device index to stack
	lxi   B,VFNCBP   ; Filename of current BASIC program
	mvi   D,09H     ; Max filename len, counting '.'
	inr   E         ; Pre-increment string length
L4C2BH	dcr   E         ; Decrement remaining argument string length
	jz    L4C72H    ; Copy D SPACES to (BC)
	call  L0FE8H    ; Get char at M and convert to uppercase
	CPI   20H       ; Test for space
	jc    L4C55H    ; Generate NM error if any chars less than space
	CPI   7FH       ; Test for DEL
	jz    L4C55H    ; Generate NM error if DEL part of filename
	CPI   2EH       ; Test for '.' in filename
	jz    L4C5CH    ; Handle '.' found in RUN/LOAD/SAVE filename
	stax  B         ; Save this byte in current BASIC program filename
	inx   B         ; Increment the pointer to BASIC program filename
	inx   H         ; Increment pointer to the typed argument
	dcr   D         ; Decrement the remaining filename length
	jnz   L4C2BH    ; Jump to process more argument bytes
L4C48H	pop   PSW       ; Restore device name index from stack
	push  PSW       ; ... and push it back
	mov   D,A       ; Put device index in D
	lda   VFNCBP     ; Filename of current BASIC program
	inr   A         ; Test if first filename byte is 0xFF
	jz    L4C55H    ; Generate NM error if first filename byte is 0xFF
	pop   PSW       ; Pop device name index from stack
	pop   H         ; Restore HL
	ret             
	
L4C55H	jmp   L504EH    ; Generate NM error
	
L4C58H	inx   H         ; Increment pointer to argument to skip '.'
	jmp   L4C2BH    ; Continue processing the argument
	
L4C5CH	mov   A,D       ; Get filename length count
	CPI   09H       ; Test for '.' as first byte of filename
	jz    L4C55H    ; Generate NM error if first byte is '.'
	CPI   03H       ; Test for filename base > 6 bytes
	jc    L4C55H    ; Generate NM error if base filename > 6 bytes
	jz    L4C58H    ; Jump to simply skip '.' if base filename = 6 bytes
	mvi   A,20H     ; Prepare to space fill base filename to 6 bytes
	stax  B         ; Space pad a byte in base filename
	inx   B         ; Increment pointer to converted filename
	dcr   D         ; Decrement remaining filename length count
	jmp   L4C5CH    ; Go test if more SPACE padding needed
	
L4C72H	mvi   A,20H     ; Load ASCII value for SPACE
	stax  B         ; Store next SPACE at (BC)
	inx   B         ; Increment pointer
	dcr   D         ; Decrement counter
	jnz   L4C72H    ; Keep looping until counter is zero
	jmp   L4C48H    
	
L4C7DH	mov   A,M       
	inx   H         
	dcr   E         
	ret             
	
L4C81H	call  L1131H    ; Get expression integer < 256 in A or FC Error
	
; ======================================================
; Get file descriptor for file in A
; ======================================================
L4C84H	mov   L,A       
	lda   0FC82H     ; Maxfiles
	cmp   L         
	jc    L505DH    ; Generate BN error
	mvi   H,00H     
	shld  VFDAIO     
	dad   H         
	xchg            
	lhld  0FC83H     ; File number description table pointer
	dad   D         
	mov   A,M       
	inx   H         
	mov   H,M       
	mov   L,A       
	mov   A,M       
	ora   A         
	rz              
	push  H         
	lxi   D,L0004H  
	dad   D         
	mov   A,M       
	CPI   09H       
	jnc   L4CAEH    
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	1EH             
	jmp   L5060H    ; Generate IE error
	
L4CAEH	pop   H         
	mov   A,M       
	ora   A         
	stc             
	ret             
	
L4CB3H	dcx   H         
	rst   2         ; Get next non-white char from M
	CPI   23H       ; Test for '#'
	cz    L0858H    ; RST 10H routine with pre-increment of HL
	call  L112EH    ; Evaluate expression at M-1
	xthl            
	push  H         
L4CBFH	call  L4C84H    ; Get file descriptor for file in A
	jz    L505AH    ; Generate CF error
	shld  0FC8CH     ; Save FCB pointer in ASCII output variable
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	0CH             
	ret             
	
	
; ======================================================
; OPEN statement
; ======================================================
BSOPEN	lxi   B,L0C39H  ; Load address of routine to terminate BASIC?
	push  B         
	call  L4C0FH    ; Evaluate arguments to RUN/OPEN/SAVE commands
	jnz   L4CD7H    ; Test if device name specified ... jump if it was
	mvi   D,0F8H     ; Default to RAM device
L4CD7H	rst   1         ; Compare next byte with M
    .db	81H             ; Test for FOR token ID
	CPI   84H       ; Test for INPUT token ID
	mvi   E,01H     ; Load code for INPUT open mode
	jz    L4CFCH    ; If "INPUT", Jump to test for "AT"
	CPI   96H       ; Test for OUT token ID
	jz    L4CF2H    ; Jump if OUT token ID found to test for "PUT"
	rst   1         ; Compare next byte with M
    .db	41H             ; Test for 'A'
	rst   1         ; Compare next byte with M
    .db	50H             ; Test for 'P'
	rst   1         ; Compare next byte with M
    .db	50H             ; Test for 'P'
	rst   1         ; Compare next byte with M
    .db	80H             ; Test for END token ID ("APPEND")
	mvi   E,08H     ; Load code for APPEND open mode
	jmp   L4CFDH    
	
L4CF2H	rst   2         ; Get next non-white char from M
	rst   1         ; Compare next byte with M
    .db	50H             ; Test for 'P'
	rst   1         ; Compare next byte with M
    .db	55H             ; Test for 'U'
	rst   1         ; Compare next byte with M
    .db	54H             ; Test for 'T'
	mvi   E,02H     ; Load code for OUTPUT open mode
	mvi   A,0D7H     ; Make 0D7H below look like MVI A,0D7H
L4CFDH	rst   1         ; Compare next byte with M
    .db	41H             ; Test for 'A'
	rst   1         ; Compare next byte with M
    .db	53H             ; Test for 'T'
	push  D         ; Save open mode on stack
	mov   A,M       ; Get next char from BASIC line
	CPI   23H       ; Test for '#'
	cz    L0858H    ; RST 10H routine with pre-increment of HL
	call  L112EH    ; Evaluate expression at M-1
	ora   A         
	jz    L505DH    ; Generate BN error
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	18H             
	mvi   E,0D5H     ; Make PUSH D below look like MVI E,0D5H
	dcx   H         ; Rewind BASIC line pointer
	mov   E,A       ; Save file number to open in E
	rst   2         ; Get next non-white char from M
	jnz   ERRSYN    ; Generate Syntax error
	xthl            ; Extract open mode from stack
	mov   A,E       ; Put open mode (INPUT, APPEND, etc.) in A
	push  PSW       ; And save it to the stack
	push  H         ; Preserve open mode on stack
	call  L4C84H    ; Get file descriptor for file in A
	jnz   L5051H    ; Generate AO error
	pop   D         ; Pop device number and open mode from stack
	mov   A,D       ; Put device number in A
	CPI   09H       ; Compare with 09H ?
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	1CH             
	jc    L5060H    ; Generate IE error
	push  H         ; Save pointer to file DCB entry
	lxi   B,L0004H  ; Load offset of device type in DCB
	dad   B         ; Offset into DCB
	mov   M,D       ; Store file device type in DCB
	mvi   A,00H     ; Load ID for OPEN vector
	pop   H         ; Restore pointer to file DCB entry
	jmp   L5123H    ; Call OPEN Hook and DCB Vector identified in A
	
L4D38H	push  H         
	ora   A         
	jnz   L4D45H    
	lda   0FCA7H     
	ANI   01H       
	jnz   L4F08H    
L4D45H	call  L4C84H    ; Get file descriptor for file in A
	jz    L4D5DH    
	shld  0FC8CH     ; Save FCB pointer in ASCII output variable
	push  H         
	mvi   A,02H     
	jc    L5123H    ; Call OPEN Hook and DCB Vector identified in A
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	14H             
	jmp   L5060H    ; Generate IE error
	
	
; ======================================================
; LCD, CRT, and LPT file close routine
; ======================================================
L4D59H	call  L4EFFH    
	pop   H         
L4D5DH	push  H         
	lxi   D,L0007H  
	dad   D         
	mov   M,A       
	mov   H,A       
	mov   L,A       
	shld  0FC8CH     
	pop   H         
	add   M         
	mvi   M,00H     
	pop   H         
	ret             
	
	
; ======================================================
; RUN statement
; ======================================================
BSRUN2	stc             
	lxi   D,0AFF6H   
	push  PSW       
	dcx   H         ; Point to byte in BASIC command before space
	rst   2         ; Get next non-white char from M
	CPI   4DH       ; Test for "M"
	JZ    BSLOrm    ; LOADM and RUNM statement
	call  L4C0FH    ; Evaluate arguments to RUN/OPEN/SAVE commands
	jz    L1E7BH    
	mov   A,D       
	CPI   0F8H       ; Test for RAM device ID
	jz    L1E7BH    
	CPI   0FDH       ; Test for CAS device ID
	jz    L2387H    ; Jump into CLOAD function
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	1AH             
L4D8DH	pop   PSW       
	push  PSW       
	jz    L4D9FH    
	mov   A,M       ; Get next character from BASIC line
	SUI   2CH       ; Test for ','
	ora   A         
	jnz   L4D9FH    ; Skip test for ",R" if not ','
	rst   2         ; Get next non-white char from M
	rst   1         ; Compare next byte with M
    .db	52H             ; Test for 'R'
	pop   PSW       
	stc             
L4D9EH	push  PSW       
L4D9FH	push  PSW       
	xra   A         
	mvi   E,01H     
	call  L4D12H    ; Call into the OPEN file code to open the device in E
L4DA6H	lhld  0FC8CH     
	lxi   B,L0007H  
	dad   B         
	pop   PSW       
	sbb   A         
	ANI   80H       
	ORI   01H       
	sta   0FCA7H     
	pop   PSW       
	push  PSW       
	sbb   A         
	sta   VBASEF     ; Flag to execute BASIC program
	mov   A,M       
	ora   A         
	jm    L4E1DH    
	pop   PSW       
	cnz   L20FFH    ; NEW statement
	call  L4E22H    
	xra   A         
	call  L4CBFH    
	jmp   L0511H    ; Silent vector to BASIC ready
	
	
; ======================================================
; SAVE statement
; ======================================================
BSSAVE	CPI   4DH       ; Test for 'M'
	jz    BSSAVM    ; SAVEM statement
	call  L3F2CH    ; Initialize BASIC Variables for new execution
	call  L4C0FH    ; Evaluate arguments to RUN/OPEN/SAVE commands
	jz    L1ED9H    
	mov   A,D       
	CPI   0F8H       
	jz    L1ED9H    
	CPI   0FDH       
	jz    L2288H    
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	16H             
	dcx   H         
	rst   2         ; Get next non-white char from M
	mvi   E,80H     
	stc             
	jz    L4DF9H    
	rst   1         ; Compare next byte with M
    .db	2CH             ; Test for ','
	rst   1         ; Compare next byte with M
    .db	41H             ; Test for 'A'
	ora   A         
	mvi   E,02H     
L4DF9H	push  PSW       
	mov   A,D       
	CPI   09H       
	jc    L4E0BH    ; Jump to open a device and perform a LIST
	mov   A,E       
	ANI   80H       
	jz    L4E0BH    ; Jump to open a device and perform a LIST
	mvi   E,02H     
	pop   PSW       
	xra   A         
	push  PSW       
L4E0BH	xra   A         ; Set file number to zero to prevent errors
	call  L4D12H    ; Call into the OPEN file code to open the device in E
	pop   PSW       ; Pop "perform LIST" status from stack
	jc    L4E18H    ; Test if a LIST operation r.equested, jump if not
	dcx   H         ; Rewind BASIC line pointer 1 character
	rst   2         ; Get next non-white char from M
	jmp   BSLIST    ; LIST statement
	
L4E18H	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	22H             
	jmp   L504EH    ; Generate NM error
	
L4E1DH	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	24H             
	jmp   L504EH    ; Generate NM error
	
L4E22H	lda   0FCA7H     
	ora   A         
	rm              
	xra   A         
	
; ======================================================
; CLOSE statement
; ======================================================
BSCLOS	lda   0FC82H     ; Maxfiles
	jnz   L4E3BH    
	push  H         
L4E2FH	push  PSW       
	ora   A         
	call  L4D38H    
	pop   PSW       
	dcr   A         
	jp    L4E2FH    
	pop   H         
	ret             
	
L4E3BH	mov   A,M       ; Get next character from BASIC line
	CPI   23H       ; Test for '#'
	cz    L0858H    ; RST 10H routine with pre-increment of HL
	call  L112EH    ; Evaluate expression at M-1
	push  H         
	stc             
	call  L4D38H    
	pop   H         
	mov   A,M       ; Get next character from BASIC line
	CPI   2CH       ; Test for ','
	rnz             
	rst   2         ; Get next non-white char from M
	jmp   L4E3BH    
	
L4E52H	pop   H         
	pop   PSW       
	push  H         
	push  D         
	push  B         
	push  PSW       
	lhld  0FC8CH     
	mvi   A,04H     
	call  L4E65H    
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	20H             
	jmp   L504EH    ; Generate NM error
	
L4E65H	push  PSW       
	push  D         
	xchg            
	lxi   H,L0004H  
	dad   D         
	mov   A,M       
	xchg            
	pop   D         
	CPI   09H       
	jc    L4F1AH    
	pop   PSW       
	xthl            
	pop   H         
	jmp   L5123H    ; Call OPEN Hook and DCB Vector identified in A
	
L4E7AH	push  B         
	push  H         
	push  D         
	lhld  0FC8CH     
	mvi   A,06H     
	call  L4E65H    
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	0EH             
	jmp   L504EH    ; Generate NM error
	
L4E8AH	pop   D         
	pop   H         
	pop   B         
	ret             
	
	
; ======================================================
; INPUT statement
; ======================================================
BSINPT	rst   2         ; Get next non-white char from M
	rst   1         ; Compare next byte with M
    .db	24H             ; Test for '$'
	rst   1         ; Compare next byte with M
    .db	28H             ; Test for '('
	push  H         
	lhld  0FC8CH     
	push  H         
	lxi   H,0000H  
	shld  0FC8CH     
	pop   H         
	xthl            
	call  L112EH    ; Evaluate expression at M-1
	push  D         
	mov   A,M       
	CPI   2CH       
	jnz   L4EBBH    
	rst   2         ; Get next non-white char from M
	call  L4CB3H    
	CPI   01H       
	jz    L4EB8H    
	CPI   04H       
	jnz   L5063H    ; Generate EF error
L4EB8H	pop   H         
	xra   A         
	mov   A,M       
L4EBBH	push  PSW       
	rst   1         ; Compare next byte with M
    .db	29H             ; Test for '('
	pop   PSW       
	xthl            
	push  PSW       
	mov   A,L       
	ora   A         
	jz    L08DBH    ; Generate FC error
	push  H         
	call  L275DH    ; Create a transient string of length A
	xchg            
	pop   B         
L4ECCH	pop   PSW       
	push  PSW       
	jz    L4EF6H    
	call  CHGET     ; Wait for key from keyboard
	CPI   03H       
	jz    L4EEBH    
L4ED9H	mov   M,A       
	inx   H         
	dcr   C         
	jnz   L4ECCH    
	pop   PSW       
	pop   B         
	pop   H         
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	10H             
	shld  0FC8CH     
	push  B         
	jmp   L278DH    ; Add new transient string to string stack
	
L4EEBH	pop   PSW       
	lhld  VBSCLN     ; Current executing line number
	shld  0FB9FH     ; Line number of last error
	pop   H         
	jmp   L0422H    ; Initialize system and go to BASIC ready
	
L4EF6H	call  L4E7AH    
	jc    L5063H    ; Generate EF error
	jmp   L4ED9H    
	
L4EFFH	call  L4F12H    
	push  H         
	mvi   B,00H     
	call  L4F0AH    ; Zero B bytes at M
L4F08H	pop   H         
	ret             
	
	
; ======================================================
; Zero B bytes at M
; ======================================================
L4F0AH	xra   A         
	
; ======================================================
; Load B bytes at M with A
; ======================================================
L4F0BH	mov   M,A       
	inx   H         
	dcr   B         
	jnz   L4F0BH    ; Load B bytes at M with A
	ret             
	
L4F12H	lhld  0FC8CH     
	lxi   D,L0009H  
	dad   D         
	ret             
	
L4F1AH	pop   PSW       
	ret             
	
L4F1CH	call  L421AH    
	jz    L083AH    ; Start executing BASIC program at HL
	xra   A         
	call  L4D38H    
	jmp   L5054H    ; Generate DS error
	
L4F29H	mvi   C,01H     ; Set PRINT # init entry marker
L4F2BH	CPI   23H       ; Test for '#' character
	rnz             
	
; ======================================================
; PRINT # initialization routine
; ======================================================
	push  B         
	call  L112DH    ; Evaluate expression at M
	rst   1         ; Compare next byte with M
    .db	2CH             
	mov   A,E       
	push  H         
	call  L4CBFH    
	mov   A,M       
	pop   H         
	pop   B         
	cmp   C         
	jz    L4F43H    
	jmp   L505DH    ; Generate BN error
	
L4F43H	mov   A,M       
L4F44H	ret             
	
L4F45H	lxi   B,L3F9CH  ; Address of routine to get address of last variable used
	push  B         
	xra   A         
	jmp   L4D38H    
	
L4F4DH	rst   5         ; Determine type of last var used
	lxi   B,L0D31H  
	lxi   D,L2C20H  
	jnz   L4F6FH    
	mov   E,D       
	jmp   L4F6FH    
	
	
; ======================================================
; LINE INPUT # statement
; ======================================================
BSLINP	lxi   B,L0C39H  
	push  B         
	call  L4F29H    ; Test for '#' char and process argument
	call  L4790H    ; Find address of variable at M
	call  L35D9H    ; Generate TM error if last variable type not string or RET
	push  D         
	lxi   B,L09BDH  ; Load address of routine to perform variable assignment
	xra   A         
	mov   D,A       
	mov   E,A       
L4F6FH	push  PSW       
	push  B         ; Push variable assignment "RET"urn address to stack
	push  H         
L4F72H	call  L4E7AH    
	jc    L5063H    ; Generate EF error
	CPI   20H       
	jnz   L4F82H    
	inr   D         
	dcr   D         
	jnz   L4F72H    
L4F82H	CPI   22H       ; Test for quote
	jnz   L4F97H    
	mov   A,E       
	CPI   2CH       ; Test for ,
	mvi   A,22H     
	jnz   L4F97H    
	mov   D,A       
	mov   E,A       
	call  L4E7AH    
	jc    L4FEAH    
L4F97H	lxi   H,VKYBBF  ; Keyboard buffer
	mvi   B,0FFH     
L4F9CH	mov   C,A       
	mov   A,D       
	CPI   22H       ; Test for quote
	mov   A,C       
	jz    L4FD5H    
	CPI   0DH       ; Test for CR
	push  H         
	jz    L500AH    ; Jump if CR found
	pop   H         
	CPI   0AH       ; Test for LF
	jnz   L4FD5H    
L4FB0H	mov   C,A       
	mov   A,E       
	CPI   2CH       ; Test for ,
	mov   A,C       
	cnz   L5044H    ; Call if not comma
	call  L4E7AH    
	jc    L4FEAH    
	CPI   0AH       ; Test for LF
	jz    L4FB0H    ; Jump if LF found
	CPI   0DH       ; Test for CR
	jnz   L4FD5H    
	mov   A,E       
	CPI   20H       ; Test for space
	jz    L4FE4H    
	CPI   2CH       ; Test for ,
	mvi   A,0DH     
	jz    L4FE4H    
L4FD5H	ora   A         
	jz    L4FE4H    
	cmp   D         
	jz    L4FEAH    
	cmp   E         
	jz    L4FEAH    
	call  L5044H    
L4FE4H	call  L4E7AH    
	jnc   L4F9CH    
L4FEAH	push  H         
	CPI   22H       ; Test for quote
	jz    L4FF5H    
	CPI   20H       ; Test for space
	jnz   L5023H    
L4FF5H	call  L4E7AH    
	jc    L5023H    
	CPI   20H       ; Test for space
	jz    L4FF5H    
	CPI   2CH       ; Test for ,
	jz    L5023H    
	CPI   0DH       ; Test for CR
	jnz   L5015H    
L500AH	call  L4E7AH    
	jc    L5023H    
	CPI   0AH       ; Test for LF
	jz    L5023H    
L5015H	lhld  0FC8CH     
	mov   C,A       
	mvi   A,08H     
	call  L4E65H    
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	12H             
	jmp   L504EH    ; Generate NM error
	
L5023H	pop   H         
L5024H	mvi   M,00H     
	lxi   H,0F684H   
	mov   A,E       
	SUI   20H       
	jz    L5036H    
	mvi   B,00H     
	call  L276EH    
	pop   H         
	ret             
	
L5036H	rst   5         ; Determine type of last var used
	push  PSW       
	rst   2         ; Get next non-white char from M
	pop   PSW       
	push  PSW       
	cc    L3840H    ; Convert ASCII number at M to double precision in FAC1
	pop   PSW       
	cnc   L3840H    ; Convert ASCII number at M to double precision in FAC1
	pop   H         
	ret             
	
L5044H	ora   A         
	rz              
	mov   M,A       
	inx   H         
	dcr   B         
	rnz             
	pop   PSW       
	jmp   L5024H    
	
	
; ======================================================
; Generate NM error
;
; The .db 01H embedded between the MVI makes the codes
; after the entry code look like an LXI B,XX1EH opcode.
; This is done to save space in the ROM.
; ======================================================
L504EH mvi E,37H
    .db  01H
L5051H mvi E,35H      ; Load code for AO Error
    .db  01H
L5054H mvi E,38H      ; Load code for DS Error
    .db  01H
L5057H mvi E,34H      ; Load code for FF Error
    .db  01H
L505AH mvi E,3AH      ; Load code for CF Error
    .db  01H
L505DH mvi E,33H      ; Load code for BN Error
    .db  01H
L5060H mvi E,32H      ; Load code for IE Error
    .db  01H
L5063H mvi E,36H      ; Load code for EF Error
    .db  01H
L5066H mvi E,39H      ; Load code for FL Error
	jmp   L045DH   ; Generate error in E
	
; ======================================================
; LOF function
; ======================================================
BFLOF	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	4EH             
	
; ======================================================
; LOC function
; ======================================================
BFLOC	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	50H             
	
; ======================================================
; LFILES function
; ======================================================
BFLFIL	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	52H             
	
; ======================================================
; DSKO$ function
; ======================================================
BFDSKO	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	56H             
	
; ======================================================
; DSKI$ function
; ======================================================
BFDSKI	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	54H             
L5075H	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	28H             
	mov   A,M       ; Get next BASIC line character
	CPI   3AH       ; Test for ':'
	jc    L5096H    ; If less than ':', call RST 7 hook for special processing
	push  H         ; Save pointer to BASIC line on stack
	mov   D,E       ; Save current count in D in case ':' not found
	call  L4C7DH    ; Read next byte and decrement count
	jz    L5090H    ; Jump to exit if count reaches 0 with no ':' found
L5085H	CPI   3AH       ; Test for ':' in filename
	jz    L509BH    ; Jump if ':' found to test length of "DEV:"
	call  L4C7DH    ; Read next byte and decrement count
	jp    L5085H    ; Jump to test for ':' if count > 0
L5090H	mov   E,D       ; No ':' found. Restore current count from D
	pop   H         ; Restore pointer to BASIC line from stack
	xra   A         ; Set DCB index to 0
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	2AH             
	ret             
	
L5096H	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	2EH             
	jmp   L504EH    ; Generate NM error
	
L509BH	mov   A,D       ; Get Saved count value
	sub   E         ; Subtract count prior to ':'
	dcr   A         ; Decrement to account for ':'
	CPI   02H       ; Test if length > 2
	jnc   L50A8H    ; Jump if length > 2 ("CAS", "MDM", etc.)
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	2CH             ; Test for hook to deal with shorter device names
	jmp   L504EH    ; Generate NM error
	
L50A8H	CPI   05H       ; Test if length > 4 ("WAND" is special)
	jnc   L504EH    ; Generate NM error
	pop   B         ; Pop BASIC line pointer from stack
	push  D         ; Push device length info to stack
	push  B         ; Push BASIC line pointer to stack
	mov   C,A       ; Put device lenght in B and C to perform multiple search
	mov   B,A       
	lxi   D,L50F1H  ; Load pointer to known device names table
	xthl            ; Get BASIC line pointer from stack
	push  H         ; And push another copy back to stack
L50B7H	call  L0FE8H    ; Get char at M and convert to uppercase
	push  B         ; Save calculated device length to stack
	mov   B,A       ; Put device name character in B
	ldax  D         ; Get next character from name lookup table
	inx   H         ; Increment BASIC line pointer
	inx   D         ; Increment name lookup pointer
	cmp   B         ; Test for match
	pop   B         ; Restore length from stack
	jnz   L50DCH    ; Jump to advance to next device if no match
	dcr   C         ; Decrement the length count
	jnz   L50B7H    ; Jump to test next byte if not zero
L50C8H	ldax  D         ; Get next byte from name lookup table
	ora   A         ; Prepare to test for full name match
	jm    L50D7H    ; If upper bit set (full match), jump to exit
	CPI   31H       ; Test for ASCII '1'? Why?
	jnz   L50DCH    ; Jump to advance to next device if not '1'?
	inx   D         ; Skip the ASCII '1'. I don't see any in the table
	ldax  D         ; Load next byte
	jmp   L50DCH    ; Jump to advance to next device name entry
	
L50D7H	pop   H         ; Pop calculated length
	pop   H         ; Pop BASIC line pointer
	pop   D         ; Pop device length info
	ora   A         ; Set return flags
	ret             
	
L50DCH	ora   A         ; Test if at end of entry
	jm    L50C8H    ; Jump to start search if at end already
L50E0H	ldax  D         ; Load next byte from name table
	ora   A         ; Test for ASCII / control terminator
	inx   D         ; Increment name table pointer
	jp    L50E0H    ; Jump to skip next byte if not at end
	mov   C,B       ; Restore device length count for next search
	pop   H         ; Restore pointer to BASIC line
	push  H         ; And push it back
	ldax  D         ; Get 1st byte of device name
	ora   A         ; Test for terminating NULL
	jnz   L50B7H    ; Jump if not at end to test next name
	jmp   L504EH    ; Generate NM error
	
	
; ======================================================
; Device name table
; ======================================================
L50F1H
    .db	"LCD",0FFH          
    .db	"CRT",0FEH          
    .db	"CAS",0FDH          
    .db	"COM",0FCH          
    .db	"WAND",0FBH          
    .db	"LPT",0FAH          
    .db	"MDM",0F9H          
    .db	"RAM",0F8H          
    .db	00H             
	
; ======================================================
; Device control block vector addresses table
; ======================================================
L5113H
    .dw	14D2H,14F2H,167FH,1762H; LCD, CRT, CAS, COM
    .dw	1877H,1754H,17D1H,14FCH; WAND, LPT, MDM, RAM
	
L5123H	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	30H             ; OPEN hook
	push  H         ; Save FCB pointer on stack
	push  D         ; Preserve DE
	push  PSW       ; Save vector number to stack
	lxi   D,L0004H  ; Load offset in FCB of device type identifier
	dad   D         ; Point to FCB device type location
	mvi   A,0FFH     ; Prepare to calculate device type offset
	sub   M         ; Calculate device type offset in DCB vector address table
	add   A         ; Multiply x2 since each entry is 2 bytes
	mov   E,A       ; Move to DE to index into table
	mvi   D,00H     ; Clear MSB of index
	lxi   H,L5113H  ; Load pointer to DCB vector address table
	dad   D         ; Index into the DCB vector address table for appropriate device
	mov   E,M       ; Get LSB of pointer to DCB vector address table
	inx   H         ; Point to MSB
	mov   D,M       ; Get MSB of pointer to DCB vector address table
	pop   PSW       ; Restore index of DCB vector to call
	mov   L,A       ; Prepare to point to selected vector in table
	mvi   H,00H     ; Clear MSB to perform index into table
	dad   D         ; Index into DCB vector table
	mov   E,M       ; Get LSB of selected DCB table vector
	inx   H         ; Point to MSB
	mov   D,M       ; Get MSB of selected DCB table vector
	xchg            ; Put vector in HL
	pop   D         ; DE now has pointer to FCB
	xthl            ; Put selected table vector on Stack
	ret             ; And return to it
	
	
; ======================================================
; TELCOM Entry point
; ======================================================
L5146H	call  UNLOCK    ; Resume automatic scrolling
	lxi   H,L51A4H  ; Get pointer to TELCOM FKey labels
	call  STDSPF    ; Set and display function keys (M has key table)
	jmp   L51C7H    ; Print current STAT settings
	
; ======================================================
; TELCOM ON ERROR Handler
; ======================================================
L5152H	call  BSBEEP      ; BSBEEP statement
	lxi   H,L51A4H  ; Load pointer to Main FKeys
	call  STFNK     ; Set new function key table
	
; ======================================================
; Re-entry point for TELCOM commands
; ======================================================
L515BH	call  L5D53H    ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
	lxi   H,L5152H  ; Load pointer to TELCOM ON ERROR handler
	shld  VLJERR     ; Save as active ON ERROR handler vector
	lxi   H,L517CH  ; Load pointer to "Telcom: " prompt
	call  L5791H    ; Print buffer at M until NULL or '"'
	CALL  INLin     ; Input and display (no "?") line and store
	rst   2         ; Get next non-white char from M
	ana   A         ; Test if TELCOM command is NULL
	jz    L515BH    ; Re-entry point for TELCOM commands
	lxi   D,L5185H  ; Load pointer to TELCOM instruction vector table
	call  L6CA7H    
	jz    L5152H    ; Jump to ON ERROR handler if error
	ret             
	
L517CH
    .db	"Telcom: ",00H     
	
	
; ======================================================
; TELCOM instruction vector table
; ======================================================
L5185H
    .db	"STAT"          
    .dw	51C0H          
    .db	"TERM"          
    .dw	5455H          
    .db	"CALL"          
    .dw	522FH          
    .db	"FIND"          
    .dw	524DH          
    .db	"MENU"          
    .dw	5797H          
    .db	0FFH             
	
	
; ======================================================
; TELCOM label line text table
; ======================================================
L51A4H
    .db	"Find",0A0H          
    .db	"Call",0A0H          
    .db	"Stat",0A0H          
    .db	"Term",8DH          
    .db	80H             
    .db	80H             
    .db	80H             
    .db	"Menu",8DH          
	
; ======================================================
; TELCOM STAT instruction routine
; ======================================================
L51C0H	dcx   H         
	rst   2         ; Get next non-white char from M
	inr   A         
	dcr   A         
	jnz   L51EDH    ; Set STAT and return to TELCOM ready
	
; ======================================================
; Print current STAT settings
; ======================================================
L51C7H	lxi   H,VISTAT  ; RS232 parameter setting table
	mvi   B,05H     
L51CCH	mov   A,M       
	rst   4         ; Send character in A to screen/printer
	inx   H         
	dcr   B         
	jnz   L51CCH    
	mvi   A,2CH     
	rst   4         ; Send character in A to screen/printer
	lda   VPPSST    ; Dial speed (1=10pps), 2=20pps
	Rrc             
	mvi   A,32H     
	sbb   B         
	rst   4         ; Send character in A to screen/printer
	lxi   H,L51E7H  ; Load pointer to "0 pps" text
	call  L27B1H    ; Print buffer at M until NULL or '"'
	jmp   L515BH    ; Re-entry point for TELCOM commands
	
L51E7H
    .db	"0 pps",00H  
	
	
; ======================================================
; Set STAT and return to TELCOM ready
; ======================================================
L51EDH	jc    L51FEH    
	CPI   2CH       
	jz    L520AH    
	call  L0FE9H    ; Convert A to uppercase
	CPI   4DH       
	jnz   L5152H    ; Jump to ON ERROR handler if error
	inx   H         
L51FEH	call  L17E6H    ; Set RS232 parameters from string at M
	call  L6ECBH    ; Deactivate RS232 or modem
	dcx   H         
	rst   2         ; Get next non-white char from M
	ana   A         
	jz    L515BH    ; Re-entry point for TELCOM commands
L520AH	rst   1         ; Compare next byte with M
    .db	2CH             
	call  L112EH    ; Evaluate expression at M-1
	CPI   14H       
	jz    L521AH    
	SUI   0AH       
	jnz   L5152H    ; Jump to ON ERROR handler if error
	inr   A         
L521AH	sta   VPPSST    ; Dial speed (1=10pps), 2=20pps
	jmp   L515BH    ; Re-entry point for TELCOM commands
	
L5220H	lxi   H,L5244H  ; Load pointer to "Calling " text
	call  L5A58H    ; Print NULL terminated string at M
	pop   D         
	call  L5284H    ; Display text at (DE) until EOF or EOL
	jz    L5152H    ; Jump to ON ERROR handler if error
	xchg            
	ORI   37H       
	push  H         
	lxi   H,L5244H  ; Load pointer to "Calling " text
	cc    L5A58H    ; Print NULL terminated string at M
	pop   H         
	call  L532DH    ; Execute logon s.equence at M
	jc    L5152H    ; Jump to ON ERROR handler if error
	jnz   L515BH    ; Re-entry point for TELCOM commands
	jmp   L5468H    ; Jump into TELCOM TERM routine
	
L5244H
    .db	"Calling ",00H     
	
	
; ======================================================
; TELCOM FIND instruction routine
; ======================================================
L524DH	sub   A         
	call  L5.db1H    
	push  H         
	call  L5AA6H    ; Search directory for ADRS.DO file
	jz    L5152H    ; Jump to ON ERROR handler if error
	call  L5AE3H    ; Get start address of file at M
	xchg            
	pop   H         
L525DH	call  L5C3FH    ; Find text at M in the file at (DE)
	jnc   L515BH    ; Re-entry point for TELCOM commands
	push  H         
	push  D         
	call  L5DC5H    ; Setup word-wrap / wrap width based on LCD / Printer output
	call  L5284H    ; Display text at (DE) until EOF or EOL
	cnz   L5292H    ; Print byte in A, continuing until ':' found, expanding '<' to '<>'
	call  CRLF      ; Send CRLF to screen or printer
	call  L5C7FH    ; TELCOM FIND display / keyscan routine
	jz    L515BH    ; Re-entry point for TELCOM commands
	CPI   43H       ; Test for 'C'all response
	jz    L5220H    
	pop   D         
	call  L5C6DH    ; Increment DE past next CRLF in text file at (DE)
	pop   H         
	jmp   L525DH    
	
L5284H	call  L52A8H    ; Test for EOL or EOF
	rz              ; Return if EOL
	rst   4         ; Send character in A to screen/printer
	CPI   3AH       ; Test for ':'
	inx   D         ; Increment pointer
	jnz   L5284H    ; Jump to print more if not ':'
	jmp   L52AEH    ; Jump to test for EOF
	
L5292H	call  L52A8H    ; Test for EOL or EOF
	rz              ; Return if EOL
	CPI   3CH       ; Test for '<' character
	jz    L52A3H    ; If it is '<', Print it followed by '>'
	CPI   3AH       ; Test if character is ':'
	rz              ; Return if ':'
	rst   4         ; Send character in A to screen/printer
	inx   D         ; Increment file pointer
	jmp   L5292H    
	
L52A3H	rst   4         ; Send character in A to screen/printer
	mvi   A,3EH     ; Load ASCII '>'
	rst   4         ; Send character in A to screen/printer
	ret             
	
L52A8H	call  L5C74H    ; Check next byte(s) at (DE) for CRLF
	dcx   D         
	ldax  D         
	rz              
L52AEH	CPI   1AH       ; Test for EOF
	jz    L5152H    ; Jump to ON ERROR handler if error
	ret             
	
	
; ======================================================
; Go off-hook
; ======================================================
L52B4H	in    0BAH       ; Get current value of 8155 Port B
	ANI   7FH       ; Clear /RTS bit to connect phone line
	out   0BAH       ; Send new value to I/O port
	ret             
	
	
; ======================================================
; Disconnect phone line and disable modem carrier
; ======================================================
L52BBH	call  L52D8H    ; Disable modem carrier
	call  L5351H    
L52C1H	in    0BAH       ; Get current value of 8155 Port B
	ORI   80H       ; Set /RTS bit to disconnect phone line
	out   0BAH       ; Send new value to I/O port
	ret             
	
L52C8H	lda   0FAAEH     ; Contents of port 0A8H
	ORI   01H       ; Set bit to connect phone line
	jmp   L52DDH    ; Update Modem enable and RS-232 mux settings from A
	
	
; ======================================================
; Connect phone line and enable modem carrier
; ======================================================
L52D0H	call  L52B4H    ; Go off-hook
	mvi   A,03H     ; Set bits to connect phone & enable modem
	jmp   L52DDH    ; Update Modem enable and RS-232 mux settings from A
	
L52D8H	lda   0FAAEH     ; Contents of port 0A8H
	ANI   01H       ; Clear Modem Enable bit
L52DDH	sta   0FAAEH     ; Contents of port 0A8H
	out   0A8H       
	stc             
	ret             
	
	
; ======================================================
; Go off-hook and wait for carrier
; ======================================================
L52E4H	in    0BBH       
	ANI   10H       
	jz    L52F9H    
	call  L52D0H    ; Connect phone line and enable modem carrier
L52EEH	call  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	rc              
	call  L6EEFH    ; Check for carrier detect
	jnz   L52EEH    
	ret             
	
L52F9H	call  L52C8H    ; Connect phone line
	call  L52B4H    ; Go off-hook
	nop             
	nop             
	nop             
	call  L52EEH    
	rc              
	mvi   A,05H     
	call  L5316H    
	call  L52D0H    ; Connect phone line and enable modem carrier
	ana   A         
	ret             
	
	
; ======================================================
; Pause for about 2 seconds
; ======================================================
L5310H	xra   A         
	mvi   A,05H     
L5313H	cnz   L531AH    
L5316H	dcr   A         
	jnz   L5313H    
L531AH	mvi   C,0C8H     
L531CH	call  L5326H    
	call  L5326H    
	dcr   C         
	jnz   L531CH    
L5326H	mvi   B,0ACH     
L5328H	dcr   B         
	jnz   L5328H    
	ret             
	
	
; ======================================================
; Execute logon s.equence at M
; ======================================================
L532DH	in    0BAH       
	push  PSW       
	ORI   08H       
	out   0BAH       
	call  L5359H    ; Dialing routine
	pop   B         
	push  PSW       
	mov   A,B       
	ANI   08H       
	mov   B,A       
	in    0BAH       
	ANI   0F7H       
	ora   B         
	out   0BAH       
	pop   PSW       
	rnc             
	call  L52BBH    ; Disconnect phone line and disable modem carrier
	call  L52C8H    ; Connect phone line??
	mvi   A,03H     
	call  L5316H    
L5351H	lda   0FAAEH     ; Contents of port 0A8H
	ANI   02H       
	jmp   L52DDH    ; Update Modem enable and RS-232 mux settings from A
	
	
; ======================================================
; Dialing routine
; ======================================================
L5359H	xra   A         
	sta   0FAAEH     ; Contents of port 0A8H
	call  L52C1H    
	call  L52C8H    ; Connect phone line
	call  L531AH    
	call  L52D0H    ; Connect phone line and enable modem carrier
	call  L52D8H    ; Disable modem carrier
	call  L5310H    ; Pause for about 2 seconds
	dcx   H         
L5370H	call  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	rc              
	push  H         
	xchg            
	call  L5C74H    ; Check next byte(s) at (DE) for CRLF
	dcx   D         
	ldax  D         
	pop   H         
	jz    L539EH    ; Auto logon s.equence
	CPI   1AH       
	jz    L539EH    ; Auto logon s.equence
	rst   2         ; Get next non-white char from M
	jz    L539EH    ; Auto logon s.equence
	push  PSW       
	cc    L540AH    ; Dial the digit in A & print on LCD
	pop   PSW       
	jc    L5370H    
	CPI   3CH       
	stc             
	jz    L539EH    ; Auto logon s.equence
	CPI   3DH       
	cz    L5310H    ; Pause for about 2 seconds
	jmp   L5370H    
	
	
; ======================================================
; Auto logon s.equence
; ======================================================
L539EH	push  PSW       
	lda   VPPSST    ; Dial speed (1=10pps), 2=20pps
	Rrc             
	cnc   L531AH    
	pop   PSW       
	jnc   L52BBH    ; Disconnect phone line and disable modem carrier
	lda   VISTAT    ; RS232 parameter setting table
	CPI   4DH       
	stc             
	rnz             
	push  H         
	lxi   H,0F65CH   
	ana   A         
	call  L17E6H    ; Set RS232 parameters from string at M
	mvi   A,04H     
	call  L5316H    
	pop   H         
	call  L52E4H    ; Go off-hook and wait for carrier
	rc              
L53C3H	call  L5673H    
	call  L5406H    ; Get next auto logon s.equence byte and test for NULL
	rz              ; Return if s.equence complete
	CPI   3EH       ; Test for '>'
	rz              
	CPI   3DH       ; Test for '='
	jz    L53E7H    
	CPI   5EH       ; Test for '^'
	jz    L53FDH    ; Jump to send CTRL code if '^'
	CPI   3FH       ; Test for '?'
	jz    L53EDH    ; Jump to Display only the next byte if '?'
	CPI   21H       ; Test for '!'
	cz    L5406H    ; Get next auto logon s.equence byte and test for NULL
	rz              ; Return if s.equence complete
L53E2H	call  L6E32H    ; Send character in A to serial port using XON/XOFF
	xra   A         
	inr   A         
L53E7H	cz    L5310H    ; Pause for about 2 seconds
	jmp   L53C3H    ; Jump to process next s.equence byte
	
L53EDH	call  L5406H    ; Get next auto logon s.equence byte and test for NULL
	rz              ; Return if s.equence complete
L53F1H	call  L6D7EH    ; Get a character from RS232 receive queue
	rc              
	rst   4         ; Send character in A to screen/printer
	cmp   M         
	jnz   L53F1H    
	jmp   L53C3H    ; Jump to process next s.equence byte
	
L53FDH	call  L5406H    ; Get next auto logon s.equence byte and test for NULL
	rz              ; Return if s.equence complete
	ANI   1FH       ; Convert next byte ASCII to a control code
	jmp   L53E2H    ; Jump to send the control code
	
L5406H	inx   H         ; Increment s.equence pointer
	mov   A,M       ; Get next byte
	ana   A         ; Test for zero
	ret             
	
	
; ======================================================
; Dial the digit in A & print on LCD
; ======================================================
L540AH	rst   4         ; Send character in A to screen/printer
	di              
	ANI   0FH       
	mov   C,A       
	jnz   L5414H    
	mvi   C,0AH     
L5414H	lda   VPPSST    ; Dial speed (1=10pps), 2=20pps
	Rrc             
	lxi   D,L161CH  
	jnc   L5421H    
	lxi   D,L2440H  
L5421H	call  L52C1H    
L5424H	call  L5326H    
	dcr   E         
	jnz   L5424H    
	call  L52B4H    ; Go off-hook
L542EH	call  L5326H    
	dcr   D         
	jnz   L542EH    
	dcr   C         
	jnz   L5414H    
	ei              
	lda   VPPSST    ; Dial speed (1=10pps), 2=20pps
	ANI   01H       
	inr   A         
	jmp   L5316H    
	
L5443H
    .db	"Pre",0F6H          
    .db	"Dow",0EEH          
    .db	" U",0F0H    
    .db	80H             
    .db	80H             
    .db	80H             
    .db	80H             
    .db	"By",0E5H          
	
; ======================================================
; TELCOM TERM instruction routine
; ======================================================
L5455H	lxi   H,0F65AH   ; RS232 auto linefeed switch
	rst   2         ; Get next non-white char from M
	cnc   L3457H    ; Increment HL and return
	push  PSW       
	call  L17E6H    ; Set RS232 parameters from string at M
	pop   PSW       
	cmc             
	cc    L52E4H    ; Go off-hook and wait for carrier
	jc    L5739H    
L5468H	mvi   A,40H     
	STA   VKYScm     
	sta   0F67BH     
	xra   A         
	sta   0FAC2H     
	sta   0FAC3H     
	call  L45D3H    
	lxi   H,L5443H  ; Load TELCOM TERM FKey table pointer
	call  STFNK     ; Set new function key table
	call  L5544H    
	call  L5556H    
	call  L5562H    
	call  DSPNFK    ; Display function key line
	call  CURSON    ; Turn the cursor on
L548FH	call  L5D5DH    
	lxi   H,L54EFH  ; TELCOM TERM on-error return handler.
	shld  VLJERR     ; Long jump return address on error
	lda   0FF42H     ; XON/XOFF enable flag
	ana   A         
	jz    L54AAH    
	lda   0FF40H     ; XON/XOFF protocol control
	lxi   H,0F7D9H   
	xra   M         
	Rrc             
	cc    L5562H    
L54AAH	call  CHSNS     ; Check keyboard queue for pending characters
	jz    L54C6H    
	call  CHGET     ; Wait for key from keyboard
	jc    L54FCH    ; TELCOM "dispatcher" routine
	mov   B,A       
	lda   0F658H     ; Full/Half duplex switch
	ana   A         
	mov   A,B       
	cz    LCD       ; Send A to screen or printer
	ana   A         
	cnz   L6E32H    ; Send character in A to serial port using XON/XOFF
	jc    L54E2H    
L54C6H	call  L6D6DH    ; Check RS232 queue for pending characters
	jz    L548FH    
	call  L7315H    ; Different from M100: Get a character from RS232 receive queue
	jc    L548FH    
	rst   4         ; Send character in A to screen/printer
	mov   B,A       
	lda   0F659H     
	ana   A         
	mov   A,B       
	cnz   PRTTAB    ; Print A to printer), expanding tabs if necessary
	call  L56C5H    
	jmp   L548FH    
	
L54E2H	xra   A         
	sta   0FF40H     ; XON/XOFF protocol control
L54E6H	call  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	jc    L54E6H    
	jmp   L548FH    
	
L54EFH	call  BSBEEP      ; BSBEEP statement
	xra   A         
	sta   0F659H     
	call  L5556H    
	jmp   L548FH    
	
	
; ======================================================
; TELCOM "dispatcher" routine
; ======================================================
L54FCH	mov   E,A       
	mvi   D,0FFH     
	lxi   H,L551DH  ; TERM Mode function key vector table
	dad   D         
	dad   D         
	mov   A,M       
	inx   H         
	mov   H,M       
	mov   L,A       
	lxi   D,L548FH  
	push  D         
	pchl            
	
	
; ======================================================
; TERM Mode function key vector table
; ======================================================
    .dw	5523H,567EH,559DH,553EH
    .dw	5550H,551DH,5520H,571EH
	
L551DH
    .db	0FFH             ; Jump to RST 38H Vector entry of following byte
	
	sta   0FFC9H     
	inr   M         
	ret             
	
	
; ======================================================
; TELCOM PREV function routine
; ======================================================
L5523H	call  L43A2H    ; Conditionally POP PSW from stack based on value at VXPOPF
	call  CUROFF    ; Turn the cursor off
	call  L461FH    
L552CH	call  CHSNS     ; Check keyboard queue for pending characters
	jz    L552CH    
	call  CHGET     ; Wait for key from keyboard
	call  L4601H    
	call  CURSON    ; Turn the cursor on
	jmp   SDESCX    ; Send ESC X
	
	
; ======================================================
; TELCOM FULL/HALF function routine
; ======================================================
	lxi   H,0F658H   ; Full/Half duplex switch
	mov   A,M       
	cma             
	mov   M,A       
L5544H	lda   0F658H     ; Full/Half duplex switch
	lxi   D,0F7B9H   
	lxi   H,L5583H  ; Load pointer to TELCOM "FullHalfEcho" text
	jmp   L556BH    
	
	
; ======================================================
; TELCOM ECHO function routine
; ======================================================
L5550H	lxi   H,0F659H   
	mov   A,M       
	cma             
	mov   M,A       
L5556H	lda   0F659H     
	lxi   D,0F7C9H   
	lxi   H,L558BH  
	jmp   L556BH    
	
L5562H	lda   0FF40H     ; XON/XOFF protocol control
	lxi   D,0F7D9H   
	lxi   H,L5595H  ; Load pointer to "Wait" text
L556BH	ana   A         
	lxi   B,L0004H  
	jnz   L5573H    
	dad   B         
L5573H	mov   B,C       
	call  L2542H    ; Move B bytes from M to (DE)
	mvi   B,0CH     
	xra   A         
L557AH	stax  D         
	inx   D         
	dcr   B         
	jnz   L557AH    
	jmp   FNKSB     ; Display function keys on 8th line
	
L5583H
    .db	"FullHalfEcho    ",0DH     
    .db	" Wait ",00H 
    .db	20H,20H          
	
	
; ======================================================
; TELCOM UP function routine
; ======================================================
	lxi   H,L56EFH  ; Load TELCOM UP ON ERROR handler address
	shld  VLJERR     ; Save as active ON ERROR handler vector
	push  H         
	lda   0FAC2H     
	ana   A         
	rnz             
	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	lxi   H,L5751H  ; Load pointer to "File to upload" text
	call  L5791H    ; Print buffer at M until NULL or '"'
	call  L463EH    ; Input and display line and store
	rst   2         ; Get next non-white char from M
	ana   A         
	rz              
	sta   0FAC6H     
	call  L21FAH    ; Count length of string at M
	call  L4C0BH    
	rnz             
	call  L208FH    ; Find .DO or ." " file in catalog
	lxi   H,L577CH  ; Load pointer to "No file" text
	jz    L5791H    ; Print buffer at M until NULL or '"'
	xchg            
	xthl            
	push  H         
	lxi   H,L670CH  ; Load pointer to "Width:" text
	call  L5791H    ; Print buffer at M until NULL or '"'
	CALL  INLin     ; Input and display (no "?") line and store
	rc              
	rst   2         ; Get next non-white char from M
	ana   A         
	mvi   A,01H     
	sta   0FAC3H     
	sta   VLCLPS     
	jz    L55FDH    
	call  L112EH    ; Evaluate expression at M-1
	CPI   0AH       
	rc              
	CPI   85H       
	rnc             
	lxi   H,0F894H   
	shld  0F892H     ; Save pointer to current position in line buffer
	sta   VOWIDT    ; Output format width (40 or something else for CTRL-Y)
	sta   0FAC3H     
	pop   PSW       
	pop   D         
	lxi   B,0E1F1H   
	push  D         
	push  H         
	call  FNKSB     ; Display function keys on 8th line
	pop   H         
	pop   D         
L5606H	lda   0FAC3H     
	dcr   A         
	jz    L562DH    
	push  D         
	xchg            
	lhld  0F892H     ; Get pointer to current position in line buffer
	xchg            
	rst   3         ; Compare DE and HL
	pop   D         
	jnz   L562DH    
	call  L67DFH    ; Build next line from .DO file at (DE) into line buffer
	mov   A,D       
	ana   E         
	inr   A         
	jnz   L562AH    
	lhld  0F892H     ; Get pointer to current position in line buffer
	mvi   M,1AH     
	inx   H         
	shld  0F892H     ; Save pointer to current position in line buffer
L562AH	lxi   H,0F894H   
L562DH	mov   A,M       
	CPI   1AH       
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	36H             
	jz    L566CH    
	CPI   0AH       
	jnz   L5646H    
	lda   0F65AH     ; RS232 auto linefeed switch
	ana   A         
	jnz   L5646H    
	lda   0FAC6H     
	CPI   0DH       
L5646H	mov   A,M       
	sta   0FAC6H     
	jz    L5653H    
	call  L6E32H    ; Send character in A to serial port using XON/XOFF
	call  L5673H    
L5653H	inx   H         
	call  CHSNS     ; Check keyboard queue for pending characters
	jz    L5606H    
	call  CHGET     ; Wait for key from keyboard
	CPI   03H       
	jz    L566CH    
	CPI   13H       
	cz    CHGET     ; Wait for key from keyboard
	CPI   03H       
	jnz   L5606H    
L566CH	xra   A         
	sta   0FAC3H     
	jmp   FNKSB     ; Display function keys on 8th line
	
L5673H	call  L6D6DH    ; Check RS232 queue for pending characters
	rz              
	call  L6D7EH    ; Get a character from RS232 receive queue
	rst   4         ; Send character in A to screen/printer
	jmp   L5673H    
	
	
; ======================================================
; TELCOM DOWN function routine
; ======================================================
	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	lda   0FAC2H     
	XRI   0FFH       
	sta   0FAC2H     
	jz    L56BFH    
	lxi   H,L56E2H  ; Load address of TELCOM DOWN ON ERROR handler
	shld  VLJERR     ; Save as active ON ERROR handler vector
	push  H         
	lxi   H,L5760H  ; Load pointer to "File to download" text
	call  L5791H    ; Print buffer at M until NULL or '"'
	call  L463EH    ; Input and display line and store
	rst   2         ; Get next non-white char from M
	ana   A         
	rz              
	sta   0FAC6H     
	pop   PSW       
L56A3H	push  H         
	call  L2206H    ; Get .DO filename and locate in RAM directory
	jc    L56B7H    
	shld  0FAC4H     
	call  L6B2DH    ; Find end of DO file (find the 1Ah) at (HL)
	pop   PSW       
	call  L634AH    ; Expand .DO file so it fills all memory for editing
	jmp   FNKSB     ; Display function keys on 8th line
	
L56B7H	xchg            
	call  L1FBFH    ; Kill a text file
	pop   H         
	jmp   L56A3H    
	
L56BFH	call  FNKSB     ; Display function keys on 8th line
	jmp   L6383H    ; Delete zeros from end of edited DO file and update pointers
	
L56C5H	mov   C,A       
	lda   0FAC2H     
	ana   A         
	mov   A,C       
	rz              
	call  L56FEH    ; Test char in A for EOF,CR,LF,DEL,other
	rz              ; Return if control char (EOF,CR,LF,DEL)
	jnc   L56D8H    
	call  L56D8H    
	mvi   A,0AH     
L56D8H	lhld  0FAC4H     
	call  L6396H    ; Insert byte in A to .DO file at address HL.
	shld  0FAC4H     
	rnc             
L56E2H	xra   A         
	sta   0FAC2H     
	call  FNKSB     ; Display function keys on 8th line
	lxi   H,L5768H  ; Load pointer to "Download" text
	jmp   L56F2H    ; Jump to print M to SCREEN
	
L56EFH	lxi   H,L5759H  ; Load pointer to "Upload" text
L56F2H	call  L5791H    ; Print buffer at M until NULL or '"'
	lxi   H,L5771H  ; Load pointer to "aborted" text
	call  L27B1H    ; Print buffer at M until NULL or '"'
	jmp   L548FH    
	
L56FEH	mov   C,A       ; Save character in C
	ana   A         ; Test if character is zero
	rz              ; Return if zero
	CPI   1AH       ; Test for EOF character
	rz              ; Return if EOF
	CPI   7FH       ; Test for DEL character
	rz              ; Return if DEL
	CPI   0AH       ; Test for newline character
	jnz   L5711H    ; Jump ahead if not newline
	lda   0FAC6H     
	CPI   0DH       ; Test for CR character
L5711H	mov   A,C       ; Restore the byte
	sta   0FAC6H     ; Save the byte in 0FAC6H
	rz              ; Return if CR or LF
	CPI   0DH       ; Test if it was CR
	stc             
	cmc             
	rnz             
	ana   A         
	stc             
	ret             
	
	
; ======================================================
; TELCOM BYE function routine
; ======================================================
	lxi   H,L5786H  ; Load pointer to "Disconnect" text
	call  L5791H    ; Print buffer at M until NULL or '"'
	call  L463EH    ; Input and display line and store
	rst   2         ; Get next non-white char from M
	call  L0FE9H    ; Convert A to uppercase
	CPI   59H       ; Test for "Y" response
	jz    L5739H    ; Jump if "Y" pressed
	lxi   H,L5771H  ; Load pointer to "aborted" text
	call  L5791H    ; Print buffer at M until NULL or '"'
	jmp   L548FH    ; Jump back into TELCOM TERM routine
	
L5739H	xra   A         
	STA   VKYScm     
	mov   L,A       
	mov   H,A       
	shld  0FAC2H     
	call  L6ECBH    ; Deactivate RS232 or modem
	call  CUROFF    ; Turn the cursor off
	call  L52BBH    ; Disconnect phone line and disable modem carrier
	call  L6370H    ; Test for an expanded .DO file and re-collapse if expanded
	jmp   L5146H    ; TELCOM Entry point
	
L5751H
    .db	"File to Upload",00H
L5760H
    .db	"File to Download",00H
L5771H
    .db	" aborted",0DH,0AH,00H
L577CH
    .db	"No file",0DH,0AH,00H
L5786H
    .db	"Disconnect",00H          
	
	
; ======================================================
; Print buffer at M until NULL or '"'
; ======================================================
L5791H	call  L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	jmp   L27B1H    ; Print buffer at M until NULL or '"'
	
	
; ======================================================
; MENU Program
; ======================================================
L5797H	lhld  0FB67H     ; File buffer area pointer
	shld  VTPRAM    ; BASIC string buffer pointer
	call  L3F2CH    ; Initialize BASIC variables for new execution
	call  L6ECBH    ; Deactivate RS232 or modem
	call  L6370H    ; Test for an expanded .DO file and re-collapse if expanded
	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	call  EXTREF    ; Cancel inverse character mode
	call  CUROFF    ; Turn the cursor off
	call  ERAFNK    ; Erase function key display
	call  LOCK      ; Stop automatic scrolling
	lda   VNCONF     ; New Console device flag
	sta   0FDFAH     ; Save SCREEN selection
	mvi   A,0FFH     
	sta   0FAC8H     
	inr   A         ; Increment A to zero
	STA   VKYScm     ; Clear Keyboard Scan modifier
	sta   0FAADH     ; Label line enable flag
	call  L1E3CH    ; Switch to SCREEN 0 (LCD. MENU never on DVI)
	call  L5D4DH    ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
	lxi   H,L5797H  ; Set MENU program as the ON ERROR handler
	shld  VLJERR     ; Save as active ON ERROR handler vector
	call  CLRFLK   ; Clear function key definition table
	call  L5A12H    ; Print time), day and date on first line of screen
	lxi   H,L1C01H  ; Load code for ROW1, COL 28 (Copyright notice location)
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	lxi   H,L5B0DH  ; Load pointer to copyright text
	call  L5A58H    ; Print NULL terminated string at M
	lxi   H,0FDA1H   ; Map of MENU entry positions to RAM directory positions
	shld  0FDD7H     ; Current position in Map of MENU entry positions
	mvi   B,36H     ; Prepare to set all Map entries to 0xFFFF
L57EDH	mvi   M,0FFH     ; Set next byte in map to 0xFF
	inx   H         ; Increment pointer to Map
	dcr   B         ; Decrement counter
	jnz   L57EDH    ; Loop for all 2-byte pointer entries
	mov   L,B       ; Zero out count of entries displayed
	lxi   D,L5B1EH  ; Directory file-type display order table
	
; ======================================================
; Display directory entries
; ======================================================
L57F8H	ldax  D         ; Get the next type of entries to display from table
	ora   A         ; Test for end of file
	jz    L5807H    ; Exit loop if at end of table
	mov   C,A       ; Put display file type in C
	push  D         ; Save table pointer
	call  L5970H    ; Display directory entries of type in register C
	pop   D         ; Restore table pointer
	inx   D         ; Increment to next file type to be displayed
	jmp   L57F8H    ; Display directory entries
	
L5807H	mov   A,L       
	dcr   A         
	sta   0FDEFH     ; Maximum MENU directory location
	CPI   17H       
	jz    L5823H    
L5811H	call  L59C9H    ; Position cursor for next directory entry
	push  H         ; Save cursor position to stack
	lxi   H,L5B1AH  ; Load pointer to "-.-" text
	call  L5A58H    ; Print NULL terminated string at M
	pop   H         ; Restore cursor position
	inr   L         ; Increment MENU entry counter
	mov   A,L       ; Put counter in A
	CPI   18H       ; Test if 24 entries populated
	jnz   L5811H    ; Jump until all 24 entries populated
L5823H	sub   A         ; Set A to zero
	sta   0FDD9H     ; Temp storage for converted filename string
	sta   0FDEEH     ; Current MENU directory location
	mov   L,A       ; Prepare to invert menu entry zero
	call  L59E5H    ; Invert the "BASIC" directory entry
	lxi   H,L1808H  ; Set the cursor on the bottom row
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	call  L7EACH    ; Display number of free bytes on LCD
	
; ======================================================
; Handle CTRL-U key from MENU command loop
; ======================================================
L5837H	call  L5D4DH    ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
	lxi   H,L5906H  ; Load pointer to CTRL-U ON ERROR handler
	shld  VLJERR     ; Save as active ON ERROR handler vector
	lxi   H,L0108H  ; Cursor position is Col1, row 8
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	lxi   H,L5B24H  ; Load poiner to "Select: _" text
	call  L5A58H    ; Print NULL terminated string at M
	lxi   H,L0908H  ; Position the cursor after the "Select: " text
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	sub   A         
	sta   0FDEDH     ; Flag to indicate MENU entry location or command entry
	lxi   H,0FDD9H   ; Temp storage for converted filename string
	inr   A         
	
; ======================================================
; MENU Program command loop
; ======================================================
L585AH	cz    BSBEEP      ; BSBEEP statement
L585DH	call  L5D70H    ; Print time on top line until key pressed
	call  L5D64H    ; Wait for char from keyboard & convert to uppercase
	CPI   0DH       ; Test for enter
	jz    L58F7H    ; Handle ENTER key from MENU command loop
	CPI   08H       ; Test for backspace
	jz    L588EH    ; Handle Backspace key from MENU command loop
	CPI   7FH       ; Test for DEL
	jz    L588EH    ; Handle Backspace key from MENU command loop
	CPI   15H       
	jz    L5837H    ; Handle CTRL-U key from MENU command loop
	CPI   20H       ; Test for SPACE
	jc    L589CH    ; Jump to handle arrow keys
	mov   C,A       
	lda   0FDEDH     ; Flag to indicate MENU entry location or command entry
	cz    L5897H    ; Call to handle SPACE if space pressed
	CPI   09H       ; Test for TAB
	jz    L585AH    ; MENU Program command loop
	call  L5D88H    ; Print the keystroke followed by '_'
	jmp   L585DH    ; Loop in MENU program - no BSBEEP
	
	
; ======================================================
; Handle Backspace key from MENU command loop
; ======================================================
L588EH	call  L5D9EH    ; Delete keystroke from MENU command buffer and erase from LCD
	jz    L585AH    ; MENU Program command loop
	jmp   L585DH    ; MENU Program command loop - no BSBEEP
	
L5897H	ora   A         ; Test if keyboard entry active
	rnz             ; Return if keyboard entry active - space not allowed
	pop   PSW       ; Pop the return address and discard it
	mvi   A,1CH     ; SPACE is same as RIGHT
L589CH	push  PSW       ; Push keystroke to stack
	lda   0FDEEH     ; Current MENU directory location
	mov   E,A       ; Put current MENU directory location in E
	pop   PSW       ; Pop keystroke
	SUI   1CH       ; Subtract value of lowest ARROW (left)
	lxi   B,L585DH  ; Load address of MENU loop re-entry
	push  B         ; And push it to the stack
	rm              ; Return if not arrow key
	lxi   B,L58C3H  ; Load address of routine to update cursor position
	push  B         ; Push it to the stack as the return address
	jz    L58EBH    ; If RIGHT ARROW, jump to Increment MENU entry location and wrap
	dcr   A         ; Test for LEFT arrow
	jz    L58E2H    ; If LEFT ARROW, jump to Decrement MENU entry and wrap to max entries
	dcr   A         ; Decrement to test for UP / DOWN arrow
	pop   B         ; Pop "update routine" return address from stack
	jz    L58DBH    ; If UP arrow, jump to move cursor up 1 line
	mov   A,E       ; Get current MENU directory location
	Adi   04H       ; Add 4 (down 1 row)
	mov   D,A       ; Save in D
	lda   0FDEFH     ; Maximum MENU directory location
	cmp   D         ; Test if beyond last entry
	rm              ; Return if beyond last entry (no update needed)
	mov   A,D       ; Restore value
L58C3H	sta   0FDEEH     ; Current MENU directory location
	push  H         ; Preserve HL
	lhld  VCURLN    ; Cursor row (1-8)
	push  H         ; Save the cursor ROW/COL to the stack
	mov   L,E       ; Put old cursor location in L
	push  D         ; Save old MENU location to stack
	call  L59E5H    ; Invert MENU directory entry in L
	pop   D         ; Pop new MENU location from stack
	mov   L,D       ; Move new location to L
	call  L59E5H    ; Invert MENU directory entry in L
	pop   H         ; Restore the cursor ROW/COL from stack
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	pop   H         ; Restore HL
	ret             
	
L58DBH	mov   A,E       ; Get current MENU directory location
	SUI   04H       ; Subtract 4 (up 1 line)
	mov   D,A       ; Save updated value
	rm              ; Return if at top of LCD (no update)
	push  B         ; Cursor update needed ... push address of routine to stack
	ret             ; And "return" to it
	
L58E2H	mov   A,E       ; Get current entry
	dcr   A         ; Decrement
	mov   D,A       ; Save new value in D
	rp              ; Return if still positive
	lda   0FDEFH     ; Maximum MENU directory location
	mov   D,A       ; Save new entry in D
	ret             ; This returns to the update cursor routine
	
L58EBH	mov   A,E       ; Get current MENU directory location
	inr   A         ; Increment the entry location
	mov   D,A       ; Save it in D
	lda   0FDEFH     ; Maximum MENU directory location
	cmp   D         ; Test if entry > max
	mov   A,D       ; Restore entry
	rp              ; Return if not > max
	sub   A         ; Wrap back to zero
	mov   D,A       ; Put updated entry in D
	ret             ; This returns to the update cursor routine
	
	
; ======================================================
; Handle ENTER key from MENU command loop
; ======================================================
L58F7H	lda   0FDEDH     ; Flag to indicate MENU entry location or command entry
	ora   A         ; Test if keyboard entry made
	jz    L590CH    ; Jump if no keyboard entry to launch selected item
	mvi   M,00H     ; NULL terminate the keyboard entered selection
	call  L5AB1H    ; Search directory for filename
	jnz   L5921H    ; Launch program / file whose catalog address is in HL
L5906H	call  BSBEEP      ; BSBEEP statement
	jmp   L5837H    ; Handle CTRL-U key from MENU command loop
	
L590CH	lda   0FDEEH     ; Current MENU directory location
	lxi   H,0FDA1H   ; Map of MENU entry positions to RAM directory positions
	lxi   D,L0002H  ; Size of each MENU Map entry
L5915H	ora   A         ; Test if this MENU entry was selected
	jz    L591EH    ; Jump if it is this entry
	dad   D         ; Point to next entry in the map
	dcr   A         ; Decrement the entry counter
	jmp   L5915H    ; Loop to find the entry
	
L591EH	call  L5AE4H    ; Load HL = (HL) using DE ... Get address of catalog entry
L5921H	push  H         ; Save Catalog Entry address to stack
	call  CLS       ; CLS statement
	call  UNLOCK    ; Resume automatic scrolling
	lda   0FDFAH     ; Restore SCREEN selection
	call  L1E3CH    ; Process SCREEN number selection (0 or 1)
	mvi   A,0CH     ; Load Clear Screen code
	rst   4         ; Send character in A to screen/printer
	sub   A         ; Set A=0
	sta   0FAC8H     
	mov   L,A       ; Prepare to NULL error long jump return address
	mov   H,L       ; Prepare to NULL error long jump return address
	shld  VLJERR     ; Long jump return address on error
	dcr   A         ; Set A=0xFF
	sta   0FAADH     ; Label line enable flag
	pop   H         ; Pop Catalog entry address from stack
	mov   A,M       ; Get selected entry type byte
	call  L5AE3H    ; Get start address of file at M
	CPI   0A0H       
	jz    L254BH    ; Launch .CO files from MENU
	CPI   0B0H       
	jz    L596FH    ; Launch ROM command file from MENU program
	CPI   0F0H       
	jz    0F624H     ; Call Hook routine copied to RAM to jump to OptROM
	CPI   0C0H       
	jz    L5F65H    ; Edit .DO files
	shld  VBASPP    ; Start of BASIC program pointer
	dcx   D         
	dcx   D         
	xchg            
	shld  0FA8CH     ; Mark BASIC program as active program
	call  L05F0H    ; Update line addresses for current BASIC program
	call  L6C9CH    ; Copy BASIC Function key table to key definition area
	call  L6C7FH    
	call  L3F28H    ; Initialize BASIC Variables for new execution
	jmp   BASEXE    ; Execute BASIC program
	
	
; ======================================================
; Launch ROM command file from MENU program
; ======================================================
L596FH	pchl            
	
	
; ======================================================
; Display directory entries of type in register C
; ======================================================
L5970H	mvi   B,1BH     ; Max 27 entries in catalog
	lxi   D,0F962H   ; Start of RAM directory
L5975H	ldax  D         ; Get file type byte from directory
	inr   A         ; Test for unused 0xFF
	rz              ; Return if no more files
	dcr   A         ; Restore value
	cmp   C         ; Test if type matches C
	jnz   L59A1H    ; If type doesn't match, go advance pointer
	push  B         ; \
	push  D         ; > Save regs
	push  H         ; /
	lhld  0FDD7H     ; Map of MENU entry positions to RAM directory positions
	mov   M,E       ; Save directory entry address of this menu item, LSB
	inx   H         ; Advance pointer to map
	mov   M,D       ; Save directory entry address of this menu item, MSB
	inx   H         ; Advance map pointer
	inx   D         ; Advance to catalog entry filename
	inx   D         ; ...
	inx   D         ; ...
	shld  0FDD7H     ; Map of MENU entry positions to RAM directory positions
	pop   H         ; Get count from stack
	call  L59C9H    ; Position cursor for next directory entry
	push  H         ; Push count back to stack
	lxi   H,0FDD9H   ; Temp storage for converted filename string
	push  H         ; Save start of string on stack
	call  L59ADH    ; Convert filename from space padded to '.ext' format
	pop   H         ; Restore strat of string for printing
	call  L5A58H    ; Print NULL terminated string at M
	pop   H         ; Restore count from stack
	inr   L         ; Increment count of entries displayed
	pop   D         ; Restore DE
	pop   B         ; Restore BC
L59A1H	push  H         ; Preserve count (in L)
	lxi   H,L000BH  ; Each entry is 11 bytes
	dad   D         ; Point to next entry in catalog
	xchg            ; Put new pointer back in DE
	pop   H         ; Restore count
	dcr   B         ; Decrement max entry count
	jnz   L5975H    ; Process next entry if not at end
	ret             
	
	
; ======================================================
; Convert filename from space padded to '.ext' format
; ======================================================
L59ADH	mvi   A,06H     ; Copy 6 filename bytes
	call  L5A62H    ; Copy A bytes from (DE) to M
	mvi   A,20H     ; Get ASCII space
L59B4H	dcx   H         ; Decrement HL to find trailing spaces
	cmp   M         ; Test for padding space
	jz    L59B4H    ; Jump to decrement again if SPACE found
	inx   H         ; Post-loop increment .. last was not SPACE
	mvi   M,00H     ; NULL terminate after filename
	ldax  D         ; Get filename extension byte
	CPI   20H       ; Test for space
	rz              ; Return if extension byte is space
	mvi   M,2EH     ; Add a '.'
	inx   H         ; Increment the string pointer
	call  L5A60H    ; Copy 2 bytes from (DE) to M
	mvi   M,00H     ; NULL terminate the string
	ret             
	
	
; ======================================================
; Position cursor for next directory entry
; ======================================================
L59C9H	push  D         ; Save regs on stack
	push  H         ; ...
	mov   A,L       ; Put entry count in A
	rar             ; A = count / 2
	rar             ; A = count / 4
	ANI   3FH       ; Keep only lower bits (this is the row #)
	mov   E,A       ; Put row number in E
	inr   E         ; Make row number 1 based
	inr   E         ; Skip top row (Time, copyright, etc. goes there)
	mov   A,L       ; Get count in A
	ANI   03H       ; Determine which of the 4 columns to display in
	add   A         ; A = COL * 2
	mov   D,A       ; Save in D
	add   A         ; A = COL * 4
	add   A         ; A = COL * 8
	add   D         ; A = COL * 10 (10 chars per entry)
	mov   D,A       ; Save in D
	inr   D         ; Display the entry 2 COLS indented
	inr   D         ; ...
	xchg            ; Put COL / ROW
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	pop   H         ; Restore regs
	pop   D         ; ...
	ret             
	
L59E5H	call  L73C5H    ; Turn off background task, blink & reinitialize cursor blink time
	call  L59C9H    ; Position cursor for next directory entry
	mvi   B,0AH     ; Invert 10 characters
	push  H         
	lxi   H,VCURCL  ; Cursor column (1-40)
	dcr   M         
L59F2H	push  B         
	push  D         
	lhld  VCURLN    ; Cursor row (1-8)
	call  L45CBH    ; Invert the Reverse Video flag for LCD position at (H,L)
	xchg            
	call  SETCUR    
	di              
	call  L73A9H    ; Blink the cursor
	ei              
	pop   D         
	lxi   H,VCURCL  ; Cursor column (1-40)
	inr   M         
	pop   B         
	dcr   B         ; Decrement character counter
	jnz   L59F2H    ; Loop to invert all 10 LCD characters
	call  L73C5H    ; Turn off background task, blink & reinitialize cursor blink time
	pop   H         
	ret             
	
	
; ======================================================
; Print time), day and date on first line of screen
; ======================================================
L5A12H	call  CLS       ; CLS statement
	
; ======================================================
; Print time),day),date on first line w/o CLS
; ======================================================
L5A15H	call  L5D6AH    ; Home cursor
	lxi   H,0FD8BH   
	call  BFDATS    ; DATE$ function
	mvi   M,20H     
	inx   H         
	call  L1962H    ; Read day and store at M
	xchg            
	mvi   M,20H     
	inx   H         
	call  L190FH    ; Read time and store it at M
	mvi   M,00H     
	lda   0F92CH     ; Month (1-12)
	lxi   H,L5AE6H  ; Load pointer to Month ASCII table (-3)
	lxi   B,L0003H  ; Point to "MENU" Text
L5A36H	dad   B         
	dcr   A         
	jnz   L5A36H    
	lxi   D,0FD88H   
	xchg            
	push  H         
	mov   A,C       
	call  L5A62H    ; Copy A bytes from (DE) to M
	mov   D,H       
	mov   E,L       
	mvi   M,20H     
	inx   D         
	inx   D         
	inx   D         
	inx   H         
	call  L5A60H    ; Copy 2 bytes from (DE) to M
	mvi   M,2CH     ; Load ASCII ':'
	inx   H         
	mvi   M,32H     ; Put Year 10's in string
	inx   H         
	mvi   M,30H     ; Put Year 1's in string
	pop   H         
	
; ======================================================
; Print NULL terminated string at M
; ======================================================
L5A58H	mov   A,M       ; Get next byte from string
	ora   A         ; Test for NULL termination
	rz              ; Return if at end
	rst   4         ; Send character in A to screen/printer
	inx   H         ; Increment string pointer
	jmp   L5A58H    ; Print NULL terminated string at M
	
L5A60H	mvi   A,02H     
	
; ======================================================
; Copy A bytes from (DE) to M
; ======================================================
L5A62H	push  PSW       ; Save count to stack
	ldax  D         ; Get next byte from DE
	mov   M,A       ; Copy byte to (HL)
	inx   D         ; Increment src pointer
	inx   H         ; Increment dest pointer
	pop   PSW       ; Get count from stack
	dcr   A         ; Decrement count
	jnz   L5A62H    ; Copy A bytes from (DE) to M
	ret             
	
	
; ======================================================
; Compare string at DE with that at M (max C bytes)
; ======================================================
L5A6DH	ldax  D         ; Get next byte
	cmp   M         ; Compare with next byte
	rnz             ; Return if no match
	ora   A         ; Test for end of string
	rz              ; Return if end of string
	inx   H         ; Increment pointer
	inx   D         ; Increment pointer
	dcr   C         ; Decrement counter
	jnz   L5A6DH    ; Compare string at DE with that at M (max C bytes)
	ret             
	
	
; ======================================================
; L5A79H: Clear function key definition table (fills
;        with 80's)
; Entry conditions: none
; Exit conditions: none
; ======================================================
CLRFLK	lxi  H,L5B3EH
	
; ======================================================
; L5A7CH: Set function key definitions
; Entry conditions:
;       HL = Address of function table (above)
; Exit conditions: none
; ======================================================
STFNK	lxi  D,0F789H    ; Function key definition area
    	mvi  B,08H
L5A81	mvi  C,10H
L5A83	mov  A,M
	inx  H
	ora  A
	push PSW
	ANI  7FH
	stax D
	pop  PSW
	jm   L5A93
	inx  D
	dcr  C
	jnz  L5A83
L5A93	sub  A
l5A94	inx  D
	dcr  C
	stax D
	jnz  l5A94
	dcr  B
	jnz  L5A81
	
; ======================================================
; L5A9EH Display function table (if enabled)
; Entry conditions: none
; Exit conditions:  none
; ======================================================
FNKSB	lda  VLABLF     ; Label line protect status
	ora  A
	cnz  DSPNFK     ; Display function key line
	ret
	
; ======================================================
; Search directory for ADRS.DO file
; ======================================================
L5AA6H	lxi   D,L5CCEH  ; Load address of "ADRS.DO" text
	
; ======================================================
; Search directory for filename
; ======================================================
L5AA9H	mvi   A,08H     
	lxi   H,0FDD9H   
	call  L5A62H    ; Copy A bytes from (DE) to M
L5AB1H	mvi   B,1BH     
	lxi   D,0F962H   ; Start of RAM directory
L5AB6H	lxi   H,0FDF0H   
	ldax  D         
	inr   A         
	rz              
	ANI   80H       
	jz    L5AD9H    
	push  D         
	inx   D         
	inx   D         
	inx   D         
	push  H         
	call  L59ADH    ; Convert filename from space padded to '.ext' format
	pop   H         
	mvi   C,09H     
	lxi   D,0FDD9H   
	call  L5A6DH    ; Compare string at DE with that at M (max C bytes)
	jnz   L5AD8H    
	pop   H         
	inr   C         
	ret             
	
L5AD8H	pop   D         ; Restore start of current entry
L5AD9H	lxi   H,L000BH  ; 11 bytes per entry
	dad   D         ; Point to next entry
	xchg            ; Put address back in DE
	dcr   B         ; Decrement catalog entry count
	jnz   L5AB6H    ; Jump to continue search if more entries
	ret             
	
	
; ======================================================
; Get start address of file at M
; ======================================================
L5AE3H	inx   H         ; Skip File Type Byte
L5AE4H	mov   E,M       ; Get LSB of start of file
	inx   H         ; Skip to MSB
L5AE6H	mov   D,M       ; Get MSB of start of file
	xchg            ; Put file address in DE
	ret             
	
    .db	"Jan"           
    .db	"Feb"           
    .db	"Mar"           
    .db	"Apr"           
    .db	"May"           
    .db	"Jun"           
    .db	"Jul"           
    .db	"Aug"           
    .db	"Sep"           
    .db	"Oct"           
    .db	"Nov"           
    .db	"Dec"           
L5B0DH
    .db	"(C)Microsoft",00H          
L5B1AH
    .db	"-.-",00H          
	
	
; ======================================================
; Directory file-type display order table
; ======================================================
L5B1EH
    .db	0B0H,0F0H,0C0H,80H,0A0H,00H          
	
L5B24H
    .db	"Select: _         ",00H    
	
L5B37H
    .db	20H,08H,08H,5FH,08H,00H,00H          
L5B3EH
    .db	80H,80H,80H,80H,80H,80H,80H,80H          
	
L5B46H
    .db	"Files",8DH          
    .db	"Load ",0A2H     
    .db	"Save ",0A2H     
    .db	"Run",8DH          
    .db	"List",8DH          
    .db	80H             
    .db	80H             
    .db	"Menu",8DH          
	
; ======================================================
; ADDRSS Entry point
; ======================================================
L5B68H	lxi   D,L5CCEH  ; Load address of "ADRS.DO" text
	
; ======================================================
; ADDRSS entry with (DE) pointing to filename
; ======================================================
	sub   A         
	jmp   L5B74H    
	
	
; ======================================================
; SCHEDL Entry point
; ======================================================
L5B6FH	lxi   D,L5D02H  ; Load pointer to "NOTE.DO" text
	
; ======================================================
; SCHEDL entry with (DE) pointing to filename
; ======================================================
	mvi   A,0FFH     
L5B74H	sta   0FDEDH     ; Flag to indicate MENU entry location or command entry
	call  L5D4DH    ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
	push  D         
	call  L5AA9H    ; Search directory for filename
	call  L5AE3H    ; Get start address of file at M
	jnz   L5BA9H    ; Jump if "NOTE.DO" / "ADRS.DO" found
	pop   H         
	shld  0FDEEH     ; Current MENU directory location
L5B88H lxi H,L5B88H	; Point to self for ON ERROR handler to keep looping
	shld  VLJERR     ; Long jump return address on error
	call  CLS       ; CLS statement
	call  BSBEEP      ; BSBEEP statement
	lhld  0FDEEH     ; Current MENU directory location
	call  L5A58H    ; Print NULL terminated string at M
	lxi   H,L5CD6H  ; Point to " not found" text
	call  L5A58H    ; Print NULL terminated string at M
	lxi   H,L0003H  ; Point to "MENU" Text
	call  L5F24H    ; Display "Press space bar for " (Text at HL)
	jmp   L5797H    ; MENU Program
	
L5BA9H	shld  0FDD7H     ; Save address of NOTE.DO / ADRS.DO file
	call  CLS       ; CLS statement
	lxi   H,L5D0AH  
	call  STDSPF    ; Set and display function keys (M has key table)
	lxi   H,L5BE2H  
	shld  VLJERR     ; Long jump return address on error
L5BBBH	call  L5D5DH    
	sub   A         
	sta   VOUTSW    ; Output device for RST 20H (0=screen)
	lxi   H,L5CE1H  
	lda   0FDEDH     ; Flag to indicate MENU entry location or command entry
	ora   A         
	jz    L5BCFH    
	lxi   H,L5CE8H  
L5BCFH	call  L5A58H    ; Print NULL terminated string at M
	CALL  INLin     ; Input and display (no "?") line and store
	inx   H         
	mov   A,M       
	ora   A         
	jz    L5BBBH    
	lxi   D,L5CEFH  
	call  L6CA7H    
	rnz             
L5BE2H	sub   A         
	sta   VOUTSW    ; Output device for RST 20H (0=screen)
	call  L4BB8H    ; Move LCD to blank line (send CRLF if needed)
	call  BSBEEP      ; BSBEEP statement
	lxi   H,L5D0AH  
	call  STFNK     ; Set new function key table
	jmp   L5BBBH    
	
	
; ======================================================
; FIND instruction for ADDRSS/SCHEDL
; ======================================================
L5BF5H	sub   A         
	lxi   B,0FF3EH   
	call  L5.db1H    
L5BFCH	call  L5C3FH    ; Find text at M in the file at (DE)
	jnc   L5BBBH    
	push  H         
	push  D         
	call  L5DC5H    ; Setup word-wrap / wrap width based on LCD / Printer output
L5C07H	call  L67DFH    ; Build next line from .DO file at (DE) into line buffer
	lda   0FDEEH     ; Current MENU directory location
	sta   VOUTSW    ; Output device for RST 20H (0=screen)
	call  L6A10H    
	sub   A         
	sta   VOUTSW    ; Output device for RST 20H (0=screen)
	lda   0FDEEH     ; Current MENU directory location
	ora   A         
	jnz   L5C24H    
	call  L5DE4H    
	jz    L5BBBH    ; Jump if 'Q'uit selected from keyboard
L5C24H	dcx   D         
	ldax  D         
	inx   D         
	CPI   0AH       ; Test for newline character
	jz    L5C37H    ; Skip ahead to next line of ADRS.DO / NOTE.DO
	push  D         
	inx   D         
	mov   A,E       
	ora   D         
	pop   D         
	jnz   L5C07H    
	jmp   L5BBBH    
	
L5C37H	pop   D         
	call  L5C6DH    ; Increment DE past next CRLF in text file at (DE)
	pop   H         
	jmp   L5BFCH    
	
	
; ======================================================
; Find text at M in the file at (DE)
; ======================================================
L5C3FH	push  D         
L5C40H	push  H         
	push  D         
L5C42H	ldax  D         ; Get next byte from file
	call  L0FE9H    ; Convert A to uppercase
	mov   C,A       ; Put byte from file in C
	call  L0FE8H    ; Get char at M and convert to uppercase
	cmp   C         ; Compare byte at M to byte in file
	jnz   L5C53H    ; Jump if no match
	inx   D         ; Increment file pointer
	inx   H         ; Increment string pointer
	jmp   L5C42H    ; Loop to continue search
	
L5C53H	CPI   00H       ; Test for end of string at M
	mov   A,C       ; Restore file byte to A
	pop   B         
	pop   H         ; Restore pointer to start of search string
	jz    L5C6AH    ; Jump if end of string reached
	CPI   1AH       ; Test for end of file
	jz    L5C96H    ; Jump if end of FILE reached
	call  L5C74H    ; Check next byte(s) at (DE) for CRLF
	jnz   L5C40H    ; Continue search for M at next file position
	pop   PSW       
	jmp   L5C3FH    ; Find text at M in the file at (DE)
	
L5C6AH	pop   D         
	stc             
	ret             
	
	
; ======================================================
; Increment DE past next CRLF in text file at (DE)
; ======================================================
L5C6DH	call  L5C74H    ; Check next byte(s) at (DE) for CRLF
	jnz   L5C6DH    ; Increment DE past next CRLF in text file at (DE)
	ret             
	
	
; ======================================================
; Check next byte(s) at (DE) for CRLF
; ======================================================
L5C74H	ldax  D         
	CPI   0DH       
	inx   D         
	rnz             
	ldax  D         
	CPI   0AH       
	rnz             
	inx   D         
	ret             
	
L5C7FH	push  D         
	lxi   H,L5D2BH  ; TELCOM FIND FKey table
	call  STFNK     ; Set new function key table
	call  L5CAEH    ; FIND - found entry keyscan loop
	push  PSW       
	lxi   H,L51A4H  ; Get pointer to TELCOM FKey labels
L5C8DH	call  STFNK     ; Set new function key table
	call  L5.dbCH    
	pop   PSW       
	CPI   51H       ; Test for 'Q' response
L5C96H	pop   D         
	ret             
	
L5C98H	push  D         
	lxi   H,L5D1EH  
	call  STFNK     ; Set new function key table
L5C9FH	call  L5CAEH    ; FIND - found entry keyscan loop
	CPI   43H       ; Test for 'C'all response
	jz    L5C9FH    ; Jump to re-scan if 'C' pressed ... not supported from NOTE
	push  PSW       
	lxi   H,L5D0AH  
	jmp   L5C8DH    
	
L5CAEH	call  CHGET     ; Wait for key from keyboard
	push  PSW       
	sub   A         
	sta   0F62DH     
	pop   PSW       
	call  L0FE9H    ; Convert A to uppercase
	CPI   51H       ; Test for 'Q'
	rz              
	CPI   20H       ; Test for space
	rz              
	CPI   4DH       ; Test for 'M'
	rz              
	CPI   43H       ; Test for 'C'
	rz              
	CPI   0DH       ; Test for enter
	jnz   L5CAEH    ; None of the above, loop for another key
	Adi   36H       
	ret             
	
L5CCEH
    .db	"ADRS.DO",00H          
L5CD6H
    .db	" not found",00H
L5CE1H
    .db	"Adrs: ",00H     
L5CE8H
    .db	"Schd: ",00H     
	
	
; ======================================================
; ADDRSS/SCHEDL instruction vector table
; ======================================================
L5CEFH
    .db	"FIND"          
    .dw	5BF5H          
    .db	"LFND"          
    .dw	5BF7H          
    .db	"MENU"          
    .dw	5797H          
    .db	0FFH             
	
L5D02H
    .db	"NOTE.DO",00H          
	
L5D0AH
    .db	"Find",0A0H          
    .db	80H             
    .db	80H             
    .db	80H             
    .db	"Lfnd",0A0H          
    .db	80H             
    .db	80H             
    .db	"Menu",8DH          
L5D1EH
    .db	80H             
    .db	80H             
    .db	"Mor",0E5H          
    .db	"Qui",0F4H          
    .db	80H             
    .db	80H             
    .db	80H             
L5D2BH
    .db	80H             
    .db	"Call",0A0H          
    .db	"Mor",0E5H          
    .db	"Qui",0F4H          
    .db	80H             
    .db	80H             
    .db	80H             
    .db	80H             
	jmp   L5797H    ; MENU Program
	
	lxi   D,L0010H  
	dad   D         
	dcr   C         
	ret             
	
L5D46H	mov   A,M       ; Get next byte
	inx   H         ; Increment pointer in case of SPACE
	CPI   20H       ; Test for space
	rz              ; Return if space
	dcx   H         ; Not SPACE. Decrement pointer (don't skip)
	ret             
	
L5D4DH	lxi   H,L5B3CH  ; Point to a NULL key s.equence
	shld  0F88AH     ; Save as key s.equence for SHIFT-PRINT key
L5D53H	lxi   H,0FFFFH   ; Load "BASIC not executing" line number
	shld  VBSCLN     ; Current executing line number
	inx   H         ; Set HL to zero
	shld  0FAC2H     
L5D5DH	pop   B         ; Get return address from stack
	lhld  0FB9DH     ; SP used by BASIC to reinitialize the stack
	sphl            ; Rewind stack to location for BASIC start
	push  B         ; Push return address back to stack
	ret             
	
	
; ======================================================
; Wait for char from keyboard & convert to uppercase
; ======================================================
L5D64H	call  CHGET     ; Wait for key from keyboard
	jmp   L0FE9H    ; Convert A to uppercase
	
	
; ======================================================
; Home cursor
; ======================================================
L5D6AH	lxi   H,L0101H  ; Load code for ROW 1, COL 1
	jmp   POSIT     ; Set the current cursor position (H=Row),L=Col)
	
	
; ======================================================
; Print time on top line until key pressed
; ======================================================
L5D70H	push  H         
	lhld  VCURLN    ; Cursor row (1-8)
	push  H         
	call  CHSNS     ; Check keyboard queue for pending characters
	push  PSW       
	cz    L5A15H    ; Print time),day),date on first line w/o CLS
	pop   PSW       
	pop   H         
	push  PSW       
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	pop   PSW       
	pop   H         
	jz    L5D70H    ; Print time on top line until key pressed
	ret             
	
L5D88H	mov   M,C       ; Save the keystroke in the command buffer
	inx   H         ; Increment the command buffer pointer
	push  H         ; Save it on the stack
	lxi   H,0FDEDH   ; Flag to indicate MENU entry location or command entry
	inr   M         ; Indicate a command was entered (vs. a MENU selection)
	mov   A,C       ; Restore keystroke for display
	rst   4         ; Send character in A to screen/printer
	lxi   H,L5B3AH  ; Load pointer to '_' BKSP text
	call  L5A58H    ; Print NULL terminated string at M
	pop   H         ; Restore the command buffer pointer
	ret             
	
L5D99H	lda   0FDEDH     ; Flag to indicate MENU entry location or command entry
	ora   A         ; Test for non-zero value indicating keyboard cmd entry
	ret             
	
L5D9EH	call  L5D99H    ; Test if command entered from keyboard in MENU program
	rz              ; Return if no keys in command buffer
	dcr   A         ; Decrement key count in command buffer
	sta   0FDEDH     ; Flag to indicate MENU entry location or command entry
	dcx   H         ; Decrement pointer into command buffer
	push  H         ; Save it on the stack
	lxi   H,L5B37H  ; Load string for erasing a character and printing "_"
	call  L5A58H    ; Print NULL terminated string at M
	pop   H         ; Restore pointer to command buffer
	inr   A         
	ret             
	
L5.db1H	sta   0FDEEH     ; Current MENU directory location
	call  L5D46H    ; Skip current byte if it is SPACE
	xchg            
	lhld  0FDD7H     ; Load address of file to search (NOTE.DO / ADRS.DO)
	xchg            
L5.dbCH	lda   VACTLC    ; Active rows count (1-8)
	dcr   A         
	dcr   A         
	sta   0FDEFH     ; Maximum MENU directory location
	ret             
	
L5DC5H	lxi   H,VACTCC  ; Active columns count (1-40)
	mvi   A,0FFH     
	sta   VWWRAP     ; Set word-wrap enable flag
	sta   VLCLPS     ; LCD vs Printer output indication
	lda   0FDEEH     ; Current MENU directory location
	ora   A         
	jz    L5DDFH    ; Jump if printing to LCD
	mvi   A,01H     
	sta   VLCLPS     ; LCD vs Printer output indication
	lxi   H,0F649H   ; Printer output width from CTRL-Y
L5DDFH	mov   A,M       ; Get width of output to printer or screen
	sta   VOWIDT     ; Output format width (40 or something else for CTRL-Y)
	ret             
	
L5DE4H	lxi   H,0FDEFH   ; Maximum MENU directory location
	dcr   M         
	cz    L5C98H    ; ADDRSS/SCHEDL FIND display / keyscan routine
	CPI   51H       ; Test or 'Q'uit response
	ret             
	
	
; ======================================================
; TEXT Entry point
; ======================================================
L5DEEH	lxi   H,L5DFBH  ; Load address of Main TEXT loop ON ERROR Handler
	shld  VLJERR     ; Save as active ON ERROR handler vector
	lxi   H,L5E22H  ; TEXT Function key table - empty
	call  STFNK     ; Set new function key table
	xra   A         
L5DFBH	cnz   BSBEEP    ; BSBEEP statement
	call  L5D53H    ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
	lxi   H,L5E15H  ; Point to "File to edit" text
	call  L27B1H    ; Print buffer at M until NULL or '"'
	call  L463EH    ; Input and display line and store
	rst   2         ; Get next non-white char from M
	ana   A         
	jz    L5797H    ; MENU Program
	call  L2206H    ; Get .DO filename and locate in RAM directory
	jmp   L5F65H    ; Edit .DO files
	
L5E15H
    .db	"File to edit",00H
	
	
; ======================================================
; TEXT Function key table - empty
; ======================================================
L5E22H
    .db	80H,80H,80H,80H,80H,80H,80H,83H          
	
L5E2AH
    .db	"Find",8EH          
    .db	"Load",96H          
    .db	"Save",87H          
    .db	80H             
    .db	"Copy",8FH          
    .db	"Cut ",95H     
    .db	"Sel ",8CH     
    .db	"Menu",1BH          
	sbb   E         
L5E4FH	dad   D         
	nop             
	
; ======================================================
; EDIT statement
; ======================================================
BSEDIT	push  H         
	push  PSW       
	mvi   A,01H     
	jz    L5E5AH    
	mvi   A,0FFH     
L5E5AH	sta   0F651H     ; In TEXT because of BASIC EDIT flag
	xra   A         
	sta   0FC95H     
	lxi   H,L2020H  ; Get ASCII " " in HL
	shld  VFNCBE    ; Save " " as current BASIC filename extension
	lxi   H,L5EDAH  ; Load address of EDIT statement ON ERROR handler
	shld  VLJERR    ; Long jump return address on error
	lxi   D,0F802H   
	lxi   H,L5F48H  
	call  L4D12H    
	lxi   H,L5ED5H  ; Load address of EDIT command ON ERROR handler
	shld  VLJERR    ; Long jump return address on error
	pop   PSW       
	pop   H         
	push  H         
	jmp   BSLIST    ; LIST statement
	
L5E82H	call  L4F45H    
	call  L212DH    
	lda   VLABLF    ; Label line protect status
	sta   0FACCH     
	lxi   H,0000H  
	shld  VTMPHL     
L5E94H	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	call  L4009H    ; Clear all COM), TIME), and KEY interrupt definitions
	lhld  0F9B0H     
	mov   A,M       
	CPI   1AH       
	jz    L5EBDH    
	push  H         
	xra   A         
	lxi   H,L5EABH  
	jmp   L5F71H    
	
L5EABH	xra   A         
	lxi   H,L5EEBH  ; Load ON ERROR handler for LIST Command???
	shld  VLJERR     ; Long jump return address on error
	lxi   H,L5F48H  
	mvi   D,0F8H     
	jmp   L4D9EH    
	
L5EBAH	call  CLS       ; CLS statement
L5EBDH	xra   A         
	sta   0F651H     ; In TEXT because of BASIC EDIT flag
	mov   L,A       ; Prepare to clear the ON ERROR handler
	mov   H,A       ; Clear the MSB too
	shld  VLJERR     ; Save as active ON ERROR handler vector
	call  L1FF8H    
	call  L3F6DH    
	lda   0FACCH     
	sta   VLABLF    ; Label line protect status
	jmp   L6C5BH    
	
L5ED5H	push  D         
	call  L1FF8H    
	pop   D         
L5EDAH	push  D         
	xra   A         ; Prepare to zero out BASIC EDIT flag and ON ERROR vector
	sta   0F651H     ; In TEXT because of BASIC EDIT flag
	mov   L,A       ; Prepare to zero out the ON ERROR handler
	mov   H,A       ; Zero out MSB too
	shld  VLJERR     ; Save as active ON ERROR handler vector
	call  L4F45H    
	pop   D         
	jmp   L045DH    ; Generate error in E
	
L5EEBH	mov   A,E       
	push  PSW       
	lhld  0FC87H     
	dcx   H         
	mov   B,M       
	dcr   B         
	dcx   H         
	mov   C,M       
	dcx   H         
	mov   L,M       
	xra   A         
	mov   H,A       
	dad   B         
	lxi   B,0FFFFH   
	dad   B         
	jc    L5F03H    
	mov   L,A       
	mov   H,A       
L5F03H	shld  VTMPHL     
	call  L4F45H    
	pop   PSW       
	CPI   07H       
	lxi   H,L60B1H  ; Load pointer to "Memory full" text
	jz    L5F15H    
	lxi   H,L5F38H  ; Load pointer to "Text ill-formed" text
L5F15H	call  CLS       ; CLS statement
	call  L27B1H    ; Print buffer at M until NULL or '"'
	lxi   H,L5F60H  ; Load pointer to "TEXT" text
	call  L5F24H    ; Display "Press space bar for " (Text at HL)
	jmp   L5E94H    
	
L5F24H	push  H         ; Push pointer to "MENU" or "TEXT"
	lxi   H,L5F49H  ; Load pointer to "Press space bar for" text
	call  L27B1H    ; Print buffer at M until NULL or '"'
	pop   H         ; Pop pointer to "MENU" or "TEXT"
	call  L27B1H    ; Print buffer at M until NULL or '"'
	
; ======================================================
; Wait for a space to be entered on keyboard
; ======================================================
L5F2FH	call  CHGET     ; Wait for key from keyboard
	CPI   20H       ; Test if SPACE pressed
	jnz   L5F2FH    ; Wait for a space to be entered on keyboard
	ret             
	
L5F38H
    .db	"Text ill-formed",07H,00H
	
L5F49H
    .db	0DH,0AH          
	
    .db	"Press space bar for ",00H
	
L5F60H
    .db	"TEXT",00H          
	
	
; ======================================================
; Edit .DO files
; ======================================================
L5F65H	push  H         ; Push address of .DO file
	lxi   H,0000H  
	shld  VTMPHL     
	mvi   A,01H     
	lxi   H,L5797H  ; Load pointer to MENU routine
L5F71H	sta   VWWRAP    ; Set word-wrap enable flag
	shld  0F765H     ; Save pointer to MENU as return for ESC
	call  EXTREF    ; Cancel inverse character mode
	call  ERAFNK    ; Erase function key display
	call  LOCK      ; Stop automatic scrolling
	call  CUROFF    ; Turn the cursor off
	call  L65B9H    
	lxi   H,L5E2AH  ; Load pointer to TEXT function key table
	call  STFNK     ; Set new function key table
	lda   0F651H     ; Load flag if launched from EDIT command or MENU
	ana   A         ; Test if loaded by EDIT command
	jz    L5F9FH    ; Skip ahead if loaded from MENU
	lxi   H,L7845H  ; Load 1st two bytes of "Exit" text
	shld  0F7F9H     ; Replace Function Key Table text with "Ex"
	lxi   H,L7469H  ; Load last two bytes if "Exit" text
	shld  0F7FBH     ; Replace function key table text with "it"
L5F9FH	lxi   H,L5E4FH  ; CTRL-Y (Print) Keystroke emulation
	shld  0F88AH     
	LDA   VACTcc    ; Active columns count (1-40)
	sta   VOWIDT     ; Output format width (40 or something else for CTRL-Y)
	mvi   A,80H     
	STA   VKYScm    ; Set Keyboard Scan modifier
	xra   A         ; Zero A
	mov   L,A       ; Zero HL
	mov   H,A       
	sta   0F6DFH     ; Clear storage for key read from keyboard to test for ESC ESC
	sta   VLCLPS     ; LCD vs Printer output indication - output to LCD
	sta   0F6E1H     ; Set "Redraw Bottom Line" flag to zero
	sta   VTCTR3     
	shld  VSASEL    ; Start address in .DO file of SELection for copy/cut
	pop   H         ; Pop address of .DO file
	SHLD  VDOEdi    ; Save as address of .DO file being edited
	push  H         
	call  L6B2AH    ; Find end of DO file (find the 1Ah)
	call  L634AH    ; Expand .DO file so it fills all memory for editing
	pop   D         
	lhld  VTMPHL     
	dad   D         
	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	push  H         
	call  L6986H    ; Display 'A' lines of the .DO file for editing
	pop   H         
	call  L630BH    ; Reposition TEXT LCD cursor to file pos in HL
	
; ======================================================
; Main TEXT edit loop
; ======================================================
L5FDDH	call  L5D53H    ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
	lxi   H,L5FDDH  ; Make the ON ERROR handler the Main TEXT loop
	shld  VLJERR     ; Long jump return address on error
	push  H         ; Push "RET"urn address back to TEXT loop
	lda   0F6DFH     ; Load value of last key processed
	sta   0F6E0H     ; Save as previous key value to test for ESC ESC
	call  L63E5H    ; Get next byte for TEXT Program entry
	sta   0F6DFH     ; Save as last key press (for ESC ESC detection)
	push  PSW       ; Preserve PSW
	call  L65ECH    ; Test for and redraw of bottom TEXT line after error prompt
	pop   PSW       ; Restore PSW
	jc    L6501H    ; Paste routine. Insert PASTE buffer into .DO file
	CPI   7FH       ; Test for DEL key
	jz    L6118H    ; Jump to Handler for DEL key
	CPI   20H       ; Test for SPACE
	jnc   TEXTCI    ; TEXT control I routine
	mov   C,A       ; Load control code to BC to offset into table
	mvi   B,00H     
	lxi   H,TXCCVT  ; TEXT control character vector table
	dad   B         ; Offset into table
	dad   B         ; Offset into table (each entry 2 bytes)
	mov   C,M       ; Get the LSB of the handler function pointer
	inx   H         ; Increment to MSB of handler function pointer
	mov   H,M       ; Get MSB of handler function pointer
	mov   L,C       ; Put LSB of handler function pointer to HL
	push  H         ; Push handler function to stack
	lhld  VCURLN    ; Cursor row (1-8)
L6015H	ret             ; "RET"urn to handler function
	
	
; ======================================================
; TEXT control character vector table
; ======================================================
TXCCVT
    .dw	L6015H,TEXTCA,TEXTCB,TEXTCC
    .dw	TEXTRA,TEXTUA,TEXTCF,TEXTCG
    .dw	TEXTCH,TEXTCI,L6015H,L6015H
    .dw	TEXTCL,TEXTCM,TEXTCN,TEXTCO
    .dw	TEXTCP,L620BH,TEXTCR,TEXTLA	; TODO: come up with good name for L620BH
    .dw	TEXTCT,TEXTCU,TEXTCV,TEXTCW
    .dw	TEXTDA,TEXTCY,TEXTCZ,TXTESC
    .dw	TEXTRA,TEXTLA,TEXTUA,TEXTDA
	
	
; ======================================================
; 6056H: TEXT ESCape routine
; ======================================================
TXTESC	lda   0F6E0H     ; Load value of previous key (testing for ESC ESC)
	SUI   1BH       ; Test if previous key was also ESC
	rnz             ; Return if previous key wasn't ESC ... only exit if ESC ESC
	mov   L,A       ; Prepare to NULL out long jump return address
	mov   H,A       ; Prepare to NULL out long jump return address
	shld  VLJERR     ; Long jump return address on error
	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	38H             
	call  L65B9H    
	call  UNLOCK    ; Resume automatic scrolling
	call  ERAFNK    ; Erase function key display
	call  L63DBH    ; Get number of LCD rows based on label protect + cols in HL
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	call  CRLF      ; Send CRLF to screen or printer
	call  L6383H    ; Delete zeros from end of edited DO file and update pointers
	lhld  0F765H     ; Load return address (MENU or BASIC) for ESC
	pchl            ; Jump to TEXT ESC (exit) routine. This could be MENU or BASIC
	
	
; ======================================================
; 607CH: TEXT control P routine
; ======================================================
TEXTCP	call  L63E5H    ; Get next byte for TEXT Program entry
	jc    L6501H    ; Paste routine. Insert PASTE buffer into .DO file
	ana   A         
	rz              
	CPI   1AH       
	rz              
	CPI   7FH       
	rz              
	
; ======================================================
; 608AH: TEXT control I routine
; ======================================================
TEXTCI	push  PSW       ; Save byte (TAB) on stack
	CALL  TEXTcc    ; TEXT control C routine
	call  L6A9BH    
	call  L6AF9H    ; Get address in .DO file of current cursor position
	pop   PSW       ; Restore byte from stack
L6095H	call  L6396H    ; Insert byte in A to .DO file at address HL.
	jc    L60A3H    ; Jump if Memory full
	push  H         
	call  L6253H    ; Update Line Starts array after insert
	pop   H         
	jmp   L6146H    ; Jump to redraw text on LCD after insert
	
L60A3H	call  L659BH    
	push  H         
	lxi   H,L60B1H  ; Load pointer to "Memory full" text
	call  L65AEH    ; Draw "Memory full" text and set "Redraw last line" flag
L60ADH	pop   H         
	jmp   POSIT     ; Set the current cursor position (H=Row),L=Col)
	
L60B1H
    .db	"Memory full",07H,00H
	
	
; ======================================================
; 60BEH: TEXT control M routine
; ======================================================
TEXTCM	CALL  TEXTcc    ; TEXT control C routine
	call  L6A9BH    
	lhld  0FB62H     ; Pointer to end of .DO file
	inx   H         
	mov   A,M       
	inx   H         
	ora   M         
	jnz   L60A3H    ; Display "Memory Full"
	call  L6253H    ; Update Line Starts array after insert
	call  L6AF9H    ; Get address in .DO file of current cursor position
	mvi   A,0DH     
	call  L6396H    ; Insert byte in A to .DO file at address HL.
	mvi   A,0AH     
	jmp   L6095H    
	
	
; ======================================================
; 60DEH: TEXT right arrow and control D routine
; ======================================================
TEXTRA	call  L60E8H    ; Call right arrow processing
	stc             ; Set Carry to prevent call below
	
; ======================================================
; 60E2H: TEXT down arrow and control X routine
; ======================================================
TEXTDA	cnc   L60F5H    ; Call Down arrow processing if no fall-through
	jmp   L62A0H    
	
L60E8H	lhld  VCURLN    ; Cursor row (1-8)
	LDA   VACTcc    ; Active columns count (1-40)
	inr   H         ; Increment the col number
	cmp   H         ; Test for wrap to next line
	jnc   L6175H    ; Update the current cursor position if no wrap
	mvi   H,01H     ; Wrap to col 1 and fall through to DOWN arrow logic
L60F5H	inr   L         ; Increment the ROW number
	mov   A,L       ; Put ROW number in A for line starts array lookup
	push  H         ; Preserve HL
	call  L6A48H    ; Get address in .DO file of start of row in 'A' using Line Starts array
	mov   A,E       ; Get LSB of address from line starts array
	ana   D         ; And with MSB to test for 0xFFFF
	inr   A         ; Test for 0xFFFF address (no more lines in .DO file)
	pop   H         ; Restore HL
	stc             
	rz              ; Return if no more lines in .DO file
	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	cmp   L         ; Test if scroll occurred (beyond last LCD row)
	cc    L6311H    ; Scroll TEXT .DO file up by one line, displaying new line
	jmp   L6175H    ; Update the current cursor position
	
	
; ======================================================
; 610BH: TEXT control H routine
; ======================================================
TEXTCH	CALL  TEXTcc    ; TEXT control C routine
	call  L6AF9H    ; Get address in .DO file of current cursor position
	call  L630BH    ; Reposition TEXT LCD cursor to file pos in HL
	call  L615BH    ; Call left arrow processing routine
	rc              
L6118H	CALL  TEXTcc    ; TEXT control C routine
	call  L6AF9H    ; Get address in .DO file of current cursor position
	push  H         
	call  L630BH    ; Reposition TEXT LCD cursor to file pos in HL
	pop   H         
	mov   A,M       
	CPI   1AH       
	rz              
	push  PSW       
	push  H         
	push  H         
	call  L6A9BH    
	pop   H         
L612EH	call  L63B6H    
	call  L6256H    ; Update Line Starts array after insert/DEL ("Hidden" entry)
	pop   H         
	pop   PSW       
	CPI   0DH       
	jnz   L6146H    ; Jump to redraw text on LCD after insert
	mov   A,M       
	CPI   0AH       
	jnz   L6146H    ; Jump to redraw text on LCD after insert
	push  PSW       
	push  H         
	jmp   L612EH    
	
L6146H	push  H         ; Preserve HL
	lda   VCURLN    ; Cursor row (1-8)
	call  L699EH    ; Display TEXT lines on LCD starting at current row.
	pop   H         ; Restore HL
	jmp   L62F6H    
	
	
; ======================================================
; 6151H: TEXT left arrow and control S routine
; ======================================================
TEXTLA	call  L615BH    ; Call left arrow processing routine
	stc             ; Set carry and fall through
	
; ======================================================
; 6155H: TEXT up arrow and control E routine
; ======================================================
TEXTUA	cnc   L6166H    ; Handle UP key if not fall-through
	jmp   L62A0H

; ======================================================
; Handle left arrow processing during TEXT
; ======================================================
L615BH	lhld  VCURLN    ; Cursor row (1-8)
	dcr   H         ; Decrement COL
	jnz   L6175H    ; Jump to simply update the cursor position if not zero
	LDA   VACTcc    ; Active columns count (1-40)
	mov   H,A       ; Place column on right edge of screen

; ======================================================
; Handle left and up arrow processing during TEXT
; ======================================================
L6166H	push  H         ; Save new COL on stack
	call  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	LHLD  VDOEdi     ; Load start address of .DO file being edited
	rst   3         ; Compare DE and HL
	pop   H         ; Pop current COL from stack
	cmc             ; Compliment the sign of the comparison
	rc              ; Return if at top of text ... no update
	dcr   L         ; Decrement the LCD row
	cz    L631DH    ; If decremented off-screen, call to update the LCD

; Update the current cursor position
L6175H	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	ana   A         ; Clear the Carry flag for return processing
	ret             
	
	
; ======================================================
; 617AH: TEXT control F routine
; ======================================================
TEXTCF	call  L6AF9H    ; Get address in .DO file of current cursor position
L617DH	call  L61A4H    ; Test for EOF. If not EOF, test for word-wrap char
	jnz   L617DH    
L6183H	call  L61A4H    ; Test for EOF. If not EOF, test for word-wrap char
	jz    L6183H    
	jmp   L619EH    
	
	
; ======================================================
; 618CH: TEXT control A routine
; ======================================================
TEXTCA	call  L6AF9H    ; Get address in .DO file of current cursor position
L618FH	call  L61AFH    ; Test for start of .DO file and word-wrap
	jz    L618FH    
L6195H	call  L61AFH    ; Test for start of .DO file and word-wrap
	jnz   L6195H    
	call  L61A4H    ; Test for EOF. If not EOF, test for word-wrap char
L619EH	call  L62F6H    
	jmp   L62A0H    
	
L61A4H	mov   A,M       ; Get next byte from file
	CPI   1AH       ; Test for end of file
	pop   B         ; Pop return address
	jz    L619EH    ; If EOF, jump to complete processing
	inx   H         ; Increment file pointer
	jmp   L61BAH    ; Get next byte from file and test for word-wrap character
	
L61AFH	xchg            
	LHLD  VDOEdi     ; Load start address of .DO file being edited
	xchg            
	rst   3         ; Compare DE and HL
	pop   B         ; Pop return address
	jz    L619EH    ; If at start of file, jump to complete processing
	dcx   H         ; Decrement to previous byte in file
L61BAH	push  B         ; Push return address back to stack
	push  H         ; Save pointer to file on stack
	mov   A,M       ; Get next byte from file in A
	call  L6965H    ; Test byte in A for word-wrap characters like '-', '(', ')', etc.
	pop   H         ; Restore pointer to file
	ret             
	
	
; ======================================================
; 61C2H: TEXT control T routine
; ======================================================
TEXTCT	dcr   L         
	mvi   L,01H     
	jnz   L61D1H    
	push  H         
	call  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	xchg            
	call  L6230H    
	pop   H         
L61D1H	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	jmp   L62A0H    
	
	
; ======================================================
; 61D7H: TEXT control B routine
; ======================================================
TEXTCB	push  H         
	inr   L         
	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	inr   A         
	cmp   L         
	jnz   L61ECH    
	push  PSW       
	call  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	xchg            
	mvi   A,01H     
	call  L6233H    
	pop   PSW       
L61ECH	dcr   A         
	call  L6A48H    ; Get address in .DO file of start of row in 'A' using Line Starts array
	mov   B,A       
	inx   D         
	mov   A,D       
	ora   E         
	mov   A,B       
	jz    L61ECH    
	pop   H         
	mov   L,A       
	jmp   L61D1H    
	
	
; ======================================================
; 61FDH: TEXT control R routine
; ======================================================
TEXTCR	LDA   VACTcc    ; Active columns count (1-40)
	mov   H,A       
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	call  L6AF9H    ; Get address in .DO file of current cursor position
	call  L6AA3H    ; Find address of 1st char on LCD line for ROW containing file pos in HL
    .db  01H		; LXI   B,L0126H   
L620BH mvi   H,01H	; second 'half' (26h) of instruction on 620AH
	jmp   L61D1H    
	
	
; ======================================================
; 6210H: TEXT control W routine
; ======================================================
TEXTCW	LHLD  VDOEdi     ; Load start address of .DO file being edited
	call  L6236H    
	call  HOME      ; Home cursor
	jmp   L62A0H    
	
	
; ======================================================
; 621CH: TEXT control Z routine
; ======================================================
TEXTCZ	lhld  0FB62H     ; Pointer to end of .DO file
	push  H         
	call  L6A3EH    ; Get address in .DO file of start of row just below visible LCD
	pop   H         
	rst   3         ; Compare DE and HL
	push  H         
	cnc   L6230H    
L6229H	pop   H         
	call  L630BH    ; Reposition TEXT LCD cursor to file pos in HL
	jmp   L62A0H    
	
L6230H	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
L6233H	call  L6B39H    
L6236H	call  L0013H    ; Load pointer to Storage of TEXT Line Starts in DE
	rz              
	shld  VTXTLS    ; Storage of TEXT Line Starts
	mvi   A,01H     
	jmp   L69CBH    ; Display line 'A' of the .DO file at HL for editing base on line starts array
	
	
; ======================================================
; 6242H: TEXT control L routine
; ======================================================
TEXTCL	CALL  TEXTcc    ; TEXT control C routine
	call  L6AF9H    ; Get address in .DO file of current cursor position
	shld  VSASEL    ; Start address in .DO file of SELection for copy/cut
	shld  VEASEL    ; End address in .DO file of SELection for copy/cut
	mov   E,L       
	mov   D,H       
	jmp   L62B3H    
	
L6253H	mvi   C,00H     ; Indicate insert operation
	lxi   H,800EH   ; Hidden entry. Makes 0EH,80H below look like LXI H,800EH
	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	lxi   H,VCURLN  ; Cursor row (1-8)
	sub   M         ; Subtract the #rows - current row = #rows to update
	mov   B,A       ; Move # of Line Start pointers to be updated in B
	call  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	inx   H         ; Increment Line Start pointer pointer
L6264H	inx   H         
	mov   E,M       ; Get address of start of NEXT row of text
	inx   H         ; Increment pointer
	mov   D,M       ; Get MSB of start address of NEXT row of text
	inx   D         ; Increment address of start of next row
	mov   A,D       ; Prepare to test for 0xFFFF (They didn't know about K flag ... too bad)
	ora   E         ; OR in LSB to test for zero
	rz              ; Return if at end of line starts array
	dcr   C         ; Test routine entry method (C=00H or 80H)
	jm    L6272H    ; Skip Decrements if C=00H
	dcx   D         ; If DEL, then decrement instead of increment
	dcx   D         ; We need 2 decrements
L6272H	dcx   H         ; Decrement back to LSB of Line Starts pointer
	mov   M,E       ; Save updated LSB of NEXT row pointer
	inx   H         ; Advance to MSB of Line Starts pointer
	mov   M,D       ; Save updated MSB of NEXT row pointer
	dcr   B         ; Decrement count of Line Start pointers to update
	jp    L6264H    ; Jump to process next Line Start pointer
	ret             
	
L627BH	call  HOME      ; Home cursor
	CALL  DELLin    ; Delete current line on screen
	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
L6284H	add   A         
	mov   B,A       
	lxi   D,VTXTLS   ; Storage of TEXT Line Starts
	lxi   H,0F6EDH   
	jmp   L2542H    ; Move B bytes from M to (DE)
	
	
; ======================================================
; 628FH: TEXT control C routine
; ======================================================
TEXTCC	call  L62EEH    ; Test for a valid SEL region. If none, return to caller to skip the copy/cut
	push  H         
	lxi   H,0000H  
	shld  VSASEL     ; Start address in .DO file of SELection for copy/cut
	call  L6AF9H    ; Get address in .DO file of current cursor position
	pop   D         
	jmp   L62B0H    
	
L62A0H	call  L62EEH    ; Test for a valid SEL region. If none, return to caller to skip the copy/cut
	call  L6AF9H    ; Get address in .DO file of current cursor position
	xchg            
	lhld  VEASEL     ; End address in .DO file of SELection for copy/cut
	rst   3         ; Compare DE and HL
	rz              
	xchg            
	shld  VEASEL     ; End address in .DO file of SELection for copy/cut
L62B0H	call  L64B2H    
L62B3H	push  H         
	push  D         
	call  L6A3EH    ; Get address in .DO file of start of row just below visible LCD
	pop   H         
	rst   3         ; Compare DE and HL
	jc    L62C0H    
	call  L63DBH    ; Get number of LCD rows based on label protect + cols in HL
L62C0H	cc    L6AA3H    ; Find address of 1st char on LCD line for ROW containing file pos in HL
	mov   H,L       
	xthl            
	call  L0013H    ; Load pointer to Storage of TEXT Line Starts in DE
	jnc   L62CDH    
	mvi   L,01H     
L62CDH	cnc   L6AA3H    ; Find address of 1st char on LCD line for ROW containing file pos in HL
	pop   PSW       
	sub   L         
	mov   C,A       
	xchg            
	lhld  VCURLN    ; Cursor row (1-8)
	xchg            
	push  D         
	mvi   H,01H     
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	call  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	mov   A,C       
L62E2H	push  PSW       
	call  L6A0DH    ; Build and display next line from .DO file at (DE)
	pop   PSW       
	dcr   A         
	jp    L62E2H    
	jmp   L60ADH    ; Pop H and set current cursor position
	
L62EEH	lhld  VSASEL     ; Start address in .DO file of SELection for copy/cut
	mov   A,H       ; Prepare to test if address is NULL
	ora   L         ; Test if address is NULL
	rnz             ; Return if not NULL (valid SELection exists)
	pop   H         ; No SELection exists, pop return address to RET to parent's caller
	ret             ; Return, but not to copy/cut but rather to it's caller
	
L62F6H	call  L0013H    ; Load pointer to Storage of TEXT Line Starts in DE
	cc    L631EH    
	jc    L62F6H    
L62FFH	push  H         
	call  L6A3EH    ; Get address in .DO file of start of row just below visible LCD
	pop   H         
	rst   3         ; Compare DE and HL
	cnc   L6312H    
	jnc   L62FFH    
L630BH	call  L6AA3H    ; Find address of 1st char on LCD line for ROW containing file pos in HL
	jmp   POSIT     ; Set the current cursor position (H=Row),L=Col)
	
L6311H	dcr   L         ; Decrement the current ROW number
L6312H	push  PSW       
	push  H         
	call  L627BH    ; Clear current line and update line starts array after scroll
	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	jmp   L6344H    ; Display line 'A' of the .DO file at HL for editing base on line starts array
	
L631DH	inr   L         ; Increment the ROW back to 1
L631EH	push  PSW       ; Preserve PSW on stack
	push  H         ; Save ROW and COL
	call  L65DFH    ; Position cursor at left of bottom row and erase to EOL
	call  HOME      ; Home cursor
	CALL  INSLin    ; Insert line a current line
	call  L6A55H    ; Get address in .DO file of start of line for the previous row
	push  D         
	call  L6A3EH    ; Get address in .DO file of start of row just below visible LCD
	inx   H         
	mov   E,L       
	mov   D,H       
	dcx   H         
	dcx   H         
	dcr   A         
	add   A         
	mov   C,A       
	mvi   B,00H     
	call  L6BE6H    ; Move BC bytes from M to (DE) with decrement
	xchg            
	pop   D         
	mov   M,D       
	dcx   H         
	mov   M,E       
	mvi   A,01H     
L6344H	call  L69CBH    ; Display line 'A' of the .DO file at HL for editing base on line starts array
	pop   H         ; Pop ROW and COL from stack
	pop   PSW       ; Restore PSW
	ret             
	
L634AH	lhld  VPFREM     ; Unused memory pointer
	lxi   B,L00C8H  ; Reserve 200 bytes for stack
	dad   B         ; Calculate unused memory pointer + 200
	xra   A         ; Calculate 65536 - calculated pointer
	sub   L         
	mov   L,A       
	sbb   A         
	sub   H         
	mov   H,A       ; HL now has count of free memory - 200
	dad   SP        ; Add current SP to free memory count
	rnc             
	mov   A,H       
	ora   L         
	rz              
	mov   B,H       
	mov   C,L       
	lhld  0FB62H     ; Pointer to end of .DO file
	xchg            
	inx   D         
	call  L6B7FH    ; Move all files / variables after this file
L6366H	mvi   M,00H     ; Fill next byte in DO file with zero
	inx   H         
	dcx   B         
	mov   A,B       
	ora   C         
	jnz   L6366H    
	ret             
	
L6370H	lhld  VPSDOF    ; Start of DO files pointer
L6373H	call  L6B2DH    ; Find end of DO file (find the 1Ah at (HL))
	inx   H         ; Get address beyond end of file
	xchg            ; Put it in DE
	lhld  VPSCOF    ; Start of CO files pointer
	xchg            ; Swap DE / HL
	rst   3         ; Compare DE and HL
	rnc             ; Return with no action if everything in place
	mov   A,M       ; Get byte from file
	ana   A         ; Test for zero (check if it's this .DO file that is expanded)
	jnz   L6373H    ; Jump to test if next file is the one expanded
L6383H	lhld  0FB62H     ; Pointer to end of .DO file
	push  H         
	lxi   B,0FFFFH   ; Initialize zero count to -1
	xra   A         ; Prepare to test for zero in file
L638BH	inx   H         ; Increment file pointer
	inx   B         ; Increment zero byte count
	cmp   M         ; Test if next byte is zero
	jz    L638BH    ; Keep incrementing while zero
	pop   H         ; Restore pointer to end of edit file
	inx   H         ; Increment to 1st zero in file
	jmp   L6B9FH    ; Delete BC characters at M
	
L6396H	xchg            ; Save address of current file pointer eo DE
	lhld  0FB62H     ; Pointer to end of .DO file
	inx   H         ; Prepare to test if room in .DO file
	inr   M         ; Increment byte at end of .DO file
	dcr   M         ; Decrement back to test for zero
	stc             ; Set Carry to indicate full just in case
	rnz             ; Return if no room left in .DO file
	push  PSW       ; Save byte to insert to stack
	shld  0FB62H     ; Pointer to end of .DO file
	xchg            
	mov   A,E       ; Calculate number of bytes to move from
	sub   L         ; ... current file position to the end
	mov   C,A       ; ... of the file,
	mov   A,D       ; ... save LSB of copy to address
	sbb   H         ; Subtract end of .DO location MSB
	mov   B,A       ; Save as copy length MSB
	mov   L,E       ; Restore copy from LSB
	mov   H,D       ; Restore copy from MSB
	dcx   H         ; Decrement H to insert one byte
	call  L6BE6H    ; Move BC bytes from M to (DE) with decrement
	inx   H         ; Increment back to insertion point after move above
	pop   PSW       ; Retrieve byte to be inserted from stack
	mov   M,A       ; Insert the byte into the .DO file
	inx   H         ; Increment current file pointer
	ana   A         ; Clear carry to indicate not full
	ret             
	
L63B6H	xchg            
	lhld  0FB62H     ; Pointer to end of .DO file
	mov   A,L       
	sub   E         
	mov   C,A       
	mov   A,H       
	sbb   D         
	mov   B,A       
	dcx   H         
	shld  0FB62H     ; Pointer to end of .DO file
	mov   L,E       
	mov   H,D       
	inx   H         
	call  L6BDBH    ; Move BC bytes from M to (DE) with increment
	xra   A         
	stax  D         
	ret             
	
L63CDH	push  H         ; Preserve HL on stack
	push  PSW       ; Preserve flags on stack
	lxi   H,VLABLF  ; Label line protect status
	lda   VACTLC    ; Active rows count (1-8)
	add   M         ; Add label protection indication to get actual ROW count
	mov   L,A       ; Save actual ROW count to L
	pop   PSW       ; Restore FLAGS
	mov   A,L       ; Copy actual ROW count to A
	pop   H         ; Restore HL from stack
	ret             
	
L63DBH	push  PSW       ; Preserve A on stack
	lhld  VACTLC    ; Active rows count (1-8)
	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	mov   L,A       ; Update L with actual rows based on label protect
	pop   PSW       ; Restore A from stack
	ret             
	
	
; ======================================================
; Get next byte for TEXT Program entry
; ======================================================
L63E5H	lhld  VCURLN    ; Cursor row (1-8)
	push  H         
	mov   A,L       
	sta   0FAADH     ; Label line enable flag
	lda   VLABLF    ; Label line protect status
	push  PSW       
	call  CHGET     ; Wait for key from keyboard
	pop   B         
	pop   H         
	push  PSW       
	xra   A         
	sta   0FAADH     ; Label line enable flag
	lda   VLABLF    ; Label line protect status
	cmp   B         
	jnz   L6404H    
	pop   PSW       
	ret             
	
L6404H	ana   A         
L6405H	jz    L6414H    
	lda   VCURLN    ; Cursor row (1-8)
	cmp   L         
	lda   VACTLC    ; Active rows count (1-8)
	cnz   L6284H    
	pop   PSW       
	ret             
	
L6414H	push  H         
	lda   VACTLC    ; Active rows count (1-8)
	dcr   A         
	call  L6A48H    ; Get address in .DO file of start of row in 'A' using Line Starts array
	inx   H         
	mvi   M,0FEH     
	inx   H         
	inx   H         
	mvi   M,0FEH     
	dcr   A         
	call  L69CBH    ; Display line 'A' of the .DO file at HL for editing base on line starts array
	xra   A         
	sta   0F6E1H     ; Set "Redraw Bottom Line" flag to zero
	pop   H         
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	pop   PSW       
	ret             
	
	
; ======================================================
; 6431H: TEXT control O routine
; ======================================================
TEXTCO	call  L62EEH    ; Test for a valid SEL region. If none, return to caller to skip the copy/cut
	call  L6383H    ; Delete zeros from end of edited DO file and update pointers
	call  L64B6H    
	push  PSW       
	call  L634AH    ; Expand .DO file so it fills all memory for editing
	pop   PSW       
	JNC   TEXTcc    ; TEXT control C routine
	jmp   L60A3H    ; Display "Memory Full"
	
	
; ======================================================
; 6445H: TEXT control U routine
; ======================================================
TEXTCU	call  L62EEH    ; Test for a valid SEL region. If none, return to caller to skip the copy/cut
	call  L6383H    ; Delete zeros from end of edited DO file and update pointers
	call  L64B6H    
	push  PSW       
	cnc   L6B9FH    ; Delete BC characters at M
	pop   PSW       
	jnc   L646FH    
	mov   A,B       
	ana   A         
	jz    L646AH    
L645BH	call  L1BB1H    ; Renew automatic power-off counter
	push  B         
	lxi   B,L0100H  
	call  L6488H    
	pop   B         
	dcr   B         
	jnz   L645BH    
L646AH	mov   A,C       
	ana   A         
	cnz   L6488H    
L646FH	lxi   D,0000H  
	xchg            
	shld  VSASEL     ; Start address in .DO file of SELection for copy/cut
	xchg            
	push  H         
	lda   VCURLN    ; Cursor row (1-8)
	call  L6986H    ; Display 'A' lines of the .DO file for editing
	pop   H         
	call  L630BH    ; Reposition TEXT LCD cursor to file pos in HL
	call  L6B2AH    ; Find end of DO file (find the 1Ah)
	jmp   L634AH    ; Expand .DO file so it fills all memory for editing
	
L6488H	push  H         
	push  B         
	xchg            
	lhld  0FC87H     
	xchg            
	call  L6BDBH    ; Move BC bytes from M to (DE) with increment
	pop   B         
	pop   H         
	push  H         
	push  B         
	call  L6B9FH    ; Delete BC characters at M
	lhld  VPSTBP     ; Start of Paste Buffer
	dad   B         
	xchg            
	pop   B         
	call  L6B7FH    
	xchg            
	lhld  0FC87H     
	call  L6BDBH    ; Move BC bytes from M to (DE) with increment
	pop   H         
	ret             
	
L64ABH	lhld  VSASEL     ; Start address in .DO file of SELection for copy/cut
	xchg            
	lhld  VEASEL     ; End address in .DO file of SELection for copy/cut
L64B2H	rst   3         ; Compare DE and HL
	rc              
	xchg            
	ret             
	
L64B6H	call  L2262H    
	lhld  VPSTBP     ; Start of Paste Buffer
	shld  VPSTBF    ; End of RAM for file storage
	xra   A         
	sta   0F6E6H     
	call  L64ABH    ; Return Start / end of copy SEL in HL,DE ensuring HL < DE
	dcx   D         
L64C7H	mov   A,E       ; Calculate length of SELection
	sub   L         ; Calculate LSB of SEL length
	mov   C,A       ; Save LSB of SEL length in BC
	mov   A,D       
	sbb   H         ; Calculate MSB of SEL length
	mov   B,A       ; Save MSB of SEL length in BC
	jc    L64E3H    
	ldax  D         
	CPI   1AH       
	jz    L64E4H    
	CPI   0DH       
	jnz   L64E3H    
	inx   D         
	ldax  D         
	CPI   0AH       
	jnz   L64E3H    
	inx   B         
L64E3H	inx   B         
L64E4H	mov   A,B       
	ora   C         
	rz              
	push  H         
	lhld  VPSTBF    ; End of RAM for file storage
	call  L6B6DH    ; Insert BC spaces at M
	xchg            
	pop   H         
	rc              
	lda   0F6E6H     
	ana   A         
	jz    L64F9H    
	dad   B         
L64F9H	push  H         
	push  B         
	call  L6BDBH    ; Move BC bytes from M to (DE) with increment
	pop   B         
	pop   H         
	ret             
	
L6501H	CALL  TEXTcc    ; TEXT control C routine
	call  L6383H    ; Delete zeros from end of edited DO file and update pointers
	call  L2146H    ; Update system pointers for .DO), .CO), vars), etc.
	call  L6AF9H    ; Get address in .DO file of current cursor position
	shld  VPSTBF    ; End of RAM for file storage
	mov   A,H       
	sta   0F6E6H     
	lhld  VPSTBP     ; Start of Paste Buffer
	mov   A,M       
	CPI   1AH       
	jz    L634AH    ; Expand .DO file so it fills all memory for editing
	mov   E,L       
	mov   D,H       
	dcx   D         
L6520H	inx   D         
	ldax  D         
	CPI   1AH       
	jnz   L6520H    
	call  L64C7H    ; Copy paste buffer to .DO file
	push  PSW       
	push  D         
	call  L6B2AH    ; Find end of DO file (find the 1Ah)
	call  L634AH    ; Expand .DO file so it fills all memory for editing
	pop   D         
	pop   PSW       
	jc    L60A3H    ; Jump to print "Memory Full" if paste not successful
	push  D         
	lhld  VPSTBF    ; End of RAM for file storage
	lda   VCURLN    ; Cursor row (1-8)
	call  L6986H    ; Display 'A' lines of the .DO file for editing
	call  L6A3EH    ; Get address in .DO file of start of row just below visible LCD
	pop   H         
L6545H	rst   3         ; Compare DE and HL
	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	push  H         
	cnc   L6986H    ; Display 'A' lines of the .DO file for editing
	pop   H         
	jmp   L630BH    ; Reposition TEXT LCD cursor to file pos in HL
	
	
; ======================================================
; 6551H: TEXT control N routine
; ======================================================
TEXTCN	call  L1B98H    ; Different from M100
	call  L6AF9H    ; Get address in .DO file of current cursor position
	push  H         
	lxi   H,L65D7H  ; Load pointer to "String:" text
	lxi   D,VTCTR3   
	push  D         
	call  L6603H    
	pop   D         
	inx   H         
	mov   A,M       
	ana   A         
	stc             
	jz    L658BH    
	call  L65C3H    ; Copy NULL terminated string at M to (DE)
	pop   D         
	push  D         
	ldax  D         
	CPI   1AH       
	jz    L658FH    
	inx   D         
	call  L5C3FH    ; Find text at M in the file at (DE)
	jnc   L658FH    
	pop   D         
	push  B         
	push  B         
	call  L6A3EH    ; Get address in .DO file of start of row just below visible LCD
	pop   H         
	rst   3         ; Compare DE and HL
	jc    L658BH    
	call  L6981H    ; Display entire screen of lines of the .DO file at HL for editing
	ana   A         
L658BH	cc    L65F3H    
	stc             
L658FH	lxi   H,L65CEH  ; Load pointer to "No match" text
	cnc   L65AEH    ; Draw "No match" text and set "Redraw last line" flag
	jmp   L6229H    
	
L6598H	CALL  TEXTcc    ; TEXT control C routine
L659BH	lhld  VCURLN    ; Cursor row (1-8)
	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	cmp   L         
	rnz             
	dcr   L         
	push  H         
	call  L627BH    ; Clear current line and update line starts array after scroll
	jmp   L60ADH    ; Pop H and set current cursor position
	
L65ABH	lxi   H,L5771H  ; Load pointer to "aborted" text
L65AEH	mvi   A,01H     
	sta   0F6E1H     ; Set "Redraw Bottom Line" flag to 1
L65B3H	call  L65DFH    ; Position cursor at left of bottom row and erase to EOL
	call  L27B1H    ; Print buffer at M until NULL or '"'
L65B9H	call  CHSNS     ; Check keyboard queue for pending characters
	rz              ; Return if a key was pressed
	call  CHGET     ; Wait for key from keyboard
	jmp   L65B9H    ; Loop until a key pressed
	
	
; ======================================================
; Copy NULL terminated string at M to (DE)
; ======================================================
L65C3H	push  H         
L65C4H	mov   A,M       
L65C5H	stax  D         
	inx   H         
	inx   D         
	ana   A         
	jnz   L65C4H    
	pop   H         
	ret             
	
L65CEH
    .db	"No match",00H
L65D7H
    .db	"String:",00H          
	
L65DFH	push  H         ; Preserve HL
	call  L63DBH    ; Get number of LCD rows based on label protect + cols in HL
	mvi   H,01H     ; Go to Left of bottom row
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	pop   H         ; Restore HL
	jmp   ERABOL    ; Erase from cursor to end of line
	
L65ECH	lxi   H,0F6E1H   ; Point to "Redraw bottom line" flag
	xra   A         ; Clear A
	cmp   M         ; Test if bottom line needs to be redrawn (error was displayed)
	rz              ; Return if no re-draw needed
	mov   M,A       
L65F3H	lhld  VCURLN    ; Cursor row (1-8)
	push  H         
	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	call  L69CBH    ; Display line 'A' of the .DO file at HL for editing base on line starts array
	jmp   L60ADH    ; Pop H and set current cursor position
	
L6600H	lxi   D,L5F48H  ; Load pointer just before "Press space bar for" text
L6603H	push  D         
	call  L65B3H    ; Display prompt at bottom row of LCD and wait for keystroke
	lda   VCURCL    ; Cursor column (1-40)
	sta   0FACAH     
	pop   H         
	push  H         
	call  L27B1H    ; Print buffer at M until NULL or '"'
L6612H	call  CHGET     ; Wait for key from keyboard
	jc    L6612H    
	ana   A         
	jz    L6612H    
	pop   H         
	CPI   0DH       
	jz    L6654H    
	push  PSW       
	call  L63DBH    ; Get number of LCD rows based on label protect + cols in HL
	lda   0FACAH     
	mov   H,A       
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	call  ERABOL    ; Erase from cursor to end of line
	pop   PSW       
	lxi   D,VKYBBF  ; Keyboard buffer
	mvi   B,01H     
	ana   A         
	jmp   L663DH    
	
L663AH	call  CHGET     ; Wait for key from keyboard
L663DH	lxi   H,L663AH  
	push  H         
	rc              
	CPI   7FH       
	jz    IHBACK    ; Input routine backspace), left arrow), CTRL-H handler
	CPI   20H       ; Test for SPACE
	jnc   L667EH    
	lxi   H,L665BH  ; Load pointer to Key vector mapping table
	mvi   C,07H     ; Indicate 7 entries in table
	jmp   L4378H    ; Key Vector table lookup
	
L6654H	lxi   D,VKYBBF  ; Keyboard buffer
	call  L65C3H    ; Copy NULL terminated string at M to (DE)
	jmp   L6678H    
	
    .db	03H             
    .dw	6672H          
    .db	08H             ; Backspace Key
    .dw	IHBACK          ; Backspace key handler
    .db	09H             ; TAB Key
    .dw	667CH           ; TAB Key handler
    .db	0DH             
    .dw	6675H          
    .db	15H             
    .dw	IHCTUX          ; CTRL-U handler
    .db	18H             
    .dw	IHCTUX          ; CTRL-X handler
    .db	1DH             
    .dw	IHBACK          ; Input routine backspace, left arrow, CTRL-H handler
L6672H	lxi   D,VKYBBF  ; Keyboard buffer
L6675H	pop   H         
	xra   A         
	stax  D         
L6678H	lxi   H,0F684H   
	ret             
	
L667CH	mvi   A,09H     ; Load A with TAB character
L667EH	mov   C,A       ; Save in C
	LDA   VACTcc    ; Active columns count (1-40)
	SUI   09H       ; Tab stops are 8 characters
	lxi   H,VCURCL  ; Cursor column (1-40)
	cmp   M         ; Test if column < 9
	jc    BSBEEP      ; BSBEEP statement
	mov   A,C       ; Restore TAB character to A
	inr   B         
	rst   4         ; Send character in A to screen/printer
	stax  D         
	inx   D         
	ret             
	
	
; ======================================================
; 6691H: TEXT control Y routine
; ======================================================
TEXTCY	call  L6598H    
	lxi   H,L66F2H  
	shld  VLJERR     ; Save as active ON ERROR handler vector
	push  H         
	lhld  VCURLN    ; Cursor row (1-8)
	shld  VTMPHL     ; Save current cursor col/row in temp HL store
	lxi   H,L670CH  ; Load pointer to "Width:" text
	lxi   D,0F64AH   
	call  L6603H    
	rst   2         ; Get next non-white char from M
	xra   A         
	cmp   M         
	jz    L66E6H    
	sta   VCRPOS    
	call  L112EH    ; Evaluate expression at M-1
	CPI   0AH       
	rc              
	CPI   85H       
	rnc             
	pop   D         
	sta   0F649H     ; Printer output width from CTRL-Y
	sta   VOWIDT     ; Output format width (40 or something else for CTRL-Y)
	sta   VOUTSW    ; Output device for RST 20H (0=screen)
	lxi   D,0F64AH   
	lxi   H,VKYBBF  ; Keyboard buffer
	call  L65C3H    ; Copy NULL terminated string at M to (DE)
	inr   A         
	sta   VLCLPS    ; LCD vs Printer output indication
	call  CRLF      ; Send CRLF to screen or printer
	LHLD  VDOEdi    ; Load start address of .DO file being edited
	xchg            
L66DAH	call  L6A0DH    ; Build and display next line from .DO file at (DE)
	mov   A,D       
	ana   E         
	inr   A         
	jnz   L66DAH    
	call  L66FEH    
L66E6H	call  L65F3H    
L66E9H	lhld  VTMPHL    ; Restore col/row from temp HL storage
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	jmp   L5FDDH    ; Main TEXT edit loop
	
L66F2H	call  L66FEH    
	call  L4F45H    
	call  L65ABH    ; Draw "aborted" on bottom line of LCD
	jmp   L66E9H    
	
L66FEH	LDA   VACTcc    ; Active columns count (1-40)
	sta   VOWIDT     ; Output format width (40 or something else for CTRL-Y)
	xra   A         
	sta   VOUTSW    ; Output device for RST 20H (0=screen)
	sta   VLCLPS     ; LCD vs Printer output indication - LCD
	ret             
	
L670CH
    .db	"Width:",00H          
	
	
; ======================================================
; 6713H: TEXT control G routine
; ======================================================
TEXTCG	lxi   D,L6735H  ; Load pointer to "Save to:" prompt
	call  L673EH    
	jc    L66F2H    
	jz    L66E6H    
	mvi   E,02H     
	call  L4D12H    
	LHLD  VDOEdi     ; Load start address of .DO file being edited
L6727H	mov   A,M       ; Get next byte from .DO file
	rst   4         ; Send character in A to screen/printer
	inx   H         ; Increment to next byte in .DO file
	CPI   1AH       ; Test for end of file
	jnz   L6727H    ; Jump to send next character from file if not end
	call  L4F45H    
	jmp   L66E6H    
	
L6735H
    .db	"Save to:",00H  
	
L673EH	push  D         ; Push pointer to prompt to stack
	call  L6598H    
	lxi   H,L66F2H  ; Get pointer to our Long Jump handler
	shld  VLJERR     ; Long jump return address on error
	lhld  VCURLN    ; Cursor row (1-8)
	shld  VTMPHL     
	pop   H         ; Pop pointer to text prompt into HL
	call  L6600H    
	rst   2         ; Get next non-white char from M
	ana   A         
	rz              
	call  L21FAH    ; Count length of string at M
	call  L4C0BH    
	jnz   L6760H    
	mvi   D,0FDH     
L6760H	mov   A,D       
	CPI   0F8H       
	stc             
	rz              
	CPI   0FEH       
	stc             
	rz              
	CPI   0FFH       
	stc             
	rz              
	lxi   H,L5F48H  
	cmc             
	mvi   A,00H     
	ret             
	
	
; ======================================================
; 6774H: TEXT control V routine
; ======================================================
TEXTCV	lxi   D,L67D4H  ; Pointer to "Load from:" text
	call  L673EH    
	jc    L66F2H    
	jz    L66E6H    
	push  H         
	lxi   H,L67CBH  
	shld  VLJERR     ; Long jump return address on error
	lhld  0FB62H     ; Pointer to end of .DO file
	shld  VTMPHL     ; Save col/row to temp HL storage
	sta   0FAC6H     
	xthl            
	mvi   E,01H     
	call  L4D12H    
	pop   H         
L6797H	call  L4E7AH    
	jc    L67B7H    
	call  L56FEH    ; Test char in A for EOF,CR,LF,DEL,other
	jz    L6797H    ; Jump if control char (EOF,CR,LF,DEL)
	jnc   L67ABH    
	call  L6396H    ; Insert byte in A to .DO file at address HL.
	mvi   A,0AH     
L67ABH	cnc   L6396H    ; Insert byte in A to .DO file at address HL.
	jnc   L6797H    
	call  L4F45H    
	call  L60A3H    ; Display "Memory Full"
L67B7H	call  L4F45H    
L67BAH	call  L6B2AH    ; Find end of DO file (find the 1Ah)
	lhld  VTMPHL     ; Restore col/row from temp HL storage
	push  H         
	call  L6981H    ; Display entire screen of lines of the .DO file at HL for editing
	pop   H         
	call  L630BH    ; Reposition TEXT LCD cursor to file pos in HL
	jmp   L5FDDH    ; Main TEXT edit loop
	
L67CBH	call  L4F45H    
	call  L65ABH    ; Draw "aborted" on bottom line of LCD
	jmp   L67BAH    
	
L67D4H
    .db	"Load from:",00H
	
L67DFH	xra   A         
	sta   0F890H     ; Current column offset within display line buffer
	sta   0F6E6H     
	lxi   H,0F894H   ; Prepare to point to beginning of line buffer
	shld  0F892H     ; Save pointer to current position in line buffer
L67ECH	push  D         ; Save pointer into .DO file
	call  L6912H    ; Manage copy/cut SEL highlighting added to line buffer???
	pop   D         ; Restore pointer into .DO file
	ldax  D         ; Load next character from the .DO file
	inx   D         ; Increment to next byte in .DO file
	CPI   1AH       ; Test for CTRL-Z EOF marker
	jz    L6887H    ; If EOF, jump to add Left Arrow character to line buffer
	CPI   0DH       ; Test for CR
	jz    L6897H    ; Add CR character to line buffer
	CPI   09H       ; Test for TAB
	jz    L6807H    ; Jump it TAB to insert into line buffer
	CPI   20H       ; Test for SPACE
	jc    L685DH    ; Insert control character into line buffer
L6807H	call  L68B2H    ; Add character in A to line buffer with TAB expansion
	jnc   L67ECH    ; Jump to add next character if not at end of line buffer
	ldax  D         ; Get next byte from .DO file
	call  L695EH    ; Test byte in A for word-wrap characters like '-', '(', ')', etc.
	jnz   L6827H    ; Jump if no word-wrap
	call  L6855H    
	ldax  D         ; Get the next character
	CPI   20H       ; Test if it's a SPACE
	rnz             ; Return if not a SPACE
	lda   VLCLPS     ; LCD vs Printer output indication
	ana   A         ; Test the output location
	rz              ; Return if output to LCD
	inx   D         ; Increment to next character to test for SPACE
	ldax  D         ; Get the next character
	CPI   20H       ; Test if next character is SPACE
	rnz             ; Return if not space
	dcx   D         ; Rewind pointer to character before SPACE
	ret             
	
L6827H	xchg            ; HL has .DO pointer
	shld  VPSTBF    ; End of RAM for file storage
	xchg            ; DE has .DO pointer
	lhld  0F892H     ; Get pointer to current position in line buffer
	shld  0F88EH     ; Save current line buffer position
	dcx   D         ; Decrement to previous byte to test it for word-wrap
	ldax  D         ; Get the previous byte
	inx   D         ; Back to this byte
	call  L695EH    ; Test byte in A for word-wrap characters like '-', '(', ')', etc.
	jz    L6855H    ; Jump if word-wrap
L683BH	dcx   D         ; Decrement to previous byte to test it for word-wrap
	ldax  D         ; Get the previous byte
	inx   D         ; Back to this byte
	call  L695EH    ; Test byte in A for word-wrap characters like '-', '(', ')', etc.
	jz    L68EFH    ; Test for end of format line, add ESC-K + CRLF to line buffer if at end if word-wrap
	dcx   D         
	call  L68D9H    
	jnz   L683BH    
	lhld  0F88EH     ; Restore line buffer position pointer
	shld  0F892H     ; Save pointer to current position in line buffer
	lhld  VPSTBF    ; End of RAM for file storage
	xchg            
L6855H	lda   VLCLPS     ; LCD vs Printer output indication
	dcr   A         ; Test if output to printer
	jz    L6908H    ; Jump if output to printer to add CRLF to line buffer
	ret             
	
L685DH	push  PSW       ; Preserve character to insert
	mvi   A,5EH     ; Load code for CARET
	call  L68B2H    ; Add to line buffer with tab expansion
	jc    L6877H    ; Jump if no room in line buffer for actual code
	pop   PSW       ; Restore character to be inserted
	ORI   40H       ; Convert to lowercase
	call  L68B2H    ; Add to line buffer with tab expansion
	jnc   L67ECH    ; If not at end of line, jump to add next character to line buffer
	lda   VLCLPS     ; LCD vs Printer output indication
	ana   A         ; Test if output to LCD
	jnz   L6908H    ; Jump if not output to LCD to add CRLF to line buffer
	ret             
	
L6877H	pop   PSW       ; Restore stack pointer
	dcx   D         ; Decrement .DO pointer
	lhld  0F892H     ; Get pointer to current position in line buffer
	dcx   H         ; Decrement position in line buffer
	shld  0F892H     ; Save pointer to current position in line buffer
	lxi   H,0F890H   ; Current column offset within display line buffer
	dcr   M         ; Decrement line buffer column counter
	jmp   L68EFH    ; Test for end of format line, add ESC-K + CRLF to line buffer if at end
	
L6887H	lda   VLCLPS     ; LCD vs Printer output indication
	ana   A         ; Test if output to LCD
	mvi   A,9BH     ; Load ASCII code for left arrow
	cz    L68B2H    ; If output to LCD, add left arrow to line buffer
	call  L68EFH    ; Test for end of format line, add ESC-K + CRLF to line buffer if at end
	lxi   D,0FFFFH   ; Indicate at EOF
	ret             
	
L6897H	ldax  D         ; Get next character to test for CRLF combo
	CPI   0AH       ; Test for LF
	mvi   A,0DH     ; Restore the CR in case we will print it as a control code
	jnz   L685DH    ; If not CRLF combo, then print CR as control code
	push  D         ; Save pointer into .DO file to stack
	call  L6912H    ; Manage copy/cut SEL highlighting added to line buffer???
	pop   D         ; Restore pointer into .DO file
	lda   VLCLPS     ; LCD vs Printer output indication
	ana   A         ; Test if output is to LCD
	mvi   A,8FH     ; Load ASCII code for CR mark on LCD
	cz    L68B2H    ; If output to LCD, add CR mark to line buffer
	call  L68EFH    ; Test for end of format line, add ESC-K + CRLF to line buffer if at end
	inx   D         ; Increment to next character to output
	ret             
	
L68B2H	push  H         ; Save current .DO file pointer
	call  L68D0H    ; Add character in A to TEXT display line buffer
	lxi   H,0F890H   ; Current column offset within display line buffer
	CPI   09H       ; Test for TAB character
	jz    L68C2H    ; Jump to process TAB if it's a tab
	inr   M         ; Increment the line buffer column count
	jmp   L68C9H    ; Skip TAB processing and test if at end of line
	
L68C2H	inr   M         ; Increment the line buffer column
	mov   A,M       ; Get the line buffer column
	ANI   07H       ; Test if on an 8-column boundry
	jnz   L68C2H    ; Keep increment column until 8-column tab stop found
L68C9H	lda   VOWIDT     ; Output format width (40 or something else for CTRL-Y)
	dcr   A         ; Decrement format width for comparison
	cmp   M         ; Compare format width with current line buffer width
	pop   H         ; Restore pointer to .DO file location
	ret             
	
L68D0H	lhld  0F892H     ; Get pointer into current column in line buffer
	mov   M,A       ; Add the character to the line buffer
	inx   H         ; Increment to the next position in line buffer
	shld  0F892H     ; Save pointer to current position in line buffer
	ret             
	
L68D9H	lhld  0F892H     ; Get pointer to current position in line buffer
	dcx   H         
	dcx   H         
	dcx   H         
	mov   A,M       
	CPI   1BH       
	jz    L68E7H    
	inx   H         
	inx   H         
L68E7H	shld  0F892H     ; Save pointer to current position in line buffer
	lxi   H,0F890H   ; Current column offset within display line buffer
	dcr   M         
	ret             
	
L68EFH	lda   0F890H     ; Current column offset within display line buffer
	lxi   H,VOWIDT   ; Output format width (40 or something else for CTRL-Y)
	cmp   M         ; Test if we have reached the output format width
	rnc             ; Return if not at end of format line
	lda   VLCLPS     ; LCD vs Printer output indication
	ana   A         ; Test if output to LCD
	jnz   L6908H    ; Skip adding of ESCape s.equence if not LCD
	mvi   A,1BH     ; Load code for ESCape
	call  L68D0H    ; Add character in A to TEXT display line buffer??
	mvi   A,4BH     ; Load code for ESC-K
	call  L68D0H    ; Add character in A to TEXT display line buffer??
L6908H	mvi   A,0DH     ; Load code for CR
	call  L68D0H    ; Add character in A to TEXT display line buffer??
	mvi   A,0AH     ; Load code for LF
	jmp   L68D0H    ; Add character in A to TEXT display line buffer??
	
L6912H	call  L62EEH    ; Test for a valid SEL region. If none, return to caller to skip the copy/cut
	lda   VLCLPS     ; LCD vs Printer output indication
	ana   A         ; Test if output to LCD
	rnz             ; Return if not output to LCD - no SEL highlighting to printer
	lxi   B,0F6E6H   
	push  D         
	xchg            
	lhld  VEASEL     ; End address in .DO file of SELection for copy/cut
	xchg            
	rst   3         ; Compare DE and HL
	pop   D         
	jnc   L693FH    
	xchg            
	rst   3         ; Compare DE and HL
	jc    L694DH    
	xchg            
	lhld  VEASEL     ; End address in .DO file of SELection for copy/cut
	xchg            
	rst   3         ; Compare DE and HL
	jnc   L694DH    
L6936H	ldax  B         
	ana   A         
	rnz             
	inr   A         
	mvi   H,70H     
	jmp   L6953H    
	
L693FH	xchg            
	rst   3         ; Compare DE and HL
	jnc   L694DH    
	xchg            
	lhld  VEASEL     ; End address in .DO file of SELection for copy/cut
	xchg            
	rst   3         ; Compare DE and HL
	jnc   L6936H    
L694DH	ldax  B         
	ana   A         
	rz              
	xra   A         
	mvi   H,71H     
L6953H	push  H         
	stax  B         
	mvi   A,1BH     
	call  L68D0H    ; Add character in A to TEXT display line buffer??
	pop   PSW       
	jmp   L68D0H    ; Add character in A to TEXT display line buffer??
	
L695EH	mov   B,A       ; Save character to B
	lda   VWWRAP     ; Get word-wrap enable flag
	ana   A         ; Test for word-wrap enable
	mov   A,B       ; Restore character from .DO file
	rz              ; Return if word-wrap disabled?
L6965H	lxi   H,L6977H  ; Load pointer to wrap character table
	mvi   B,0AH     ; Prapare to test 10 characters from table
L696AH	cmp   M         ; Test for match with next character from table
	rz              ; Return if match found
	inx   H         ; Increment to next entry in table
	dcr   B         ; Decrement table count
	jnz   L696AH    ; Jump to test next entry from table
	CPI   21H       ; Test if character > '!'
	inr   B         ; Clear zero flag to indicate no-wrap
	rnc             ; Return if character is not control code
	dcr   B         ; Set zero flag to indicate wrap
	ret             
	
L6977H
    .db	"()<>[]+-*/"          
L6981H	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	ana   A         
	rar             ; Multiply row count x 2
L6986H	call  L6B39H    
	shld  VTXTLS     ; Storage of TEXT Line Starts
	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	add   A         
	lxi   H,0F6EDH   
L6993H	mvi   M,0FEH     
	inx   H         
	dcr   A         
	jnz   L6993H    
	inr   A         
	jmp   L69CBH    ; Display line 'A' of the .DO file at HL for editing base on line starts array
	
L699EH	push  PSW       ; Save Current cursor row on stack
	lhld  0F6E9H     ; Address of 1st byte on last line of TEXT
	mov   A,H       ; Get MSB of address
	ora   L         ; Or in LSB to test for NULL address
	jz    L69CAH    ; Jump if no line currenty displayed on LCD
	xchg            ; Put Address of last displayed line of TEXT into DE
	call  L67DFH    ; Build next line from .DO file at (DE) into line buffer
	pop   PSW       ; Restore current cursor row from stack
	mov   B,A       ; Put current cursor row into B
	call  L6A27H    ; Update line starts array entry for row specified in A
	mov   A,B       ; Restore current cursor row
	push  PSW       ; Save current cursor row to stack
	jz    L69CAH    ; If current row is the selected row, skip ahead
	dcr   A         ; Test if on top row
	jz    L69CAH    ; If on top row, skip ahead
	mov   L,A       ; Put row number in L
	mvi   H,01H     ; Go to COL 1
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	call  L6A10H    
	mov   A,D       
	ana   E         
	inr   A         
	pop   B         
	jz    ERABOL    ; Erase from cursor to end of line
	push  B         
L69CAH	pop   PSW       ; Restore PSW from stack
L69CBH	mov   L,A       
	mvi   H,01H     
	call  POSIT     ; Set the current cursor position (H=Row),L=Col)
	call  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	mov   A,E       
	ana   D         
	inr   A         
	jz    L6A04H    
	call  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
L69DDH	call  L63DBH    ; Get number of LCD rows based on label protect + cols in HL
	cmp   L         
	jz    L69F4H    
	call  L6A0DH    ; Build and display next line from .DO file at (DE)
	mov   A,D       
	ana   E         
	inr   A         
	jz    L69FEH    
	call  L6A2EH    ; Update line starts array entry for current Cursor row
	jnz   L69DDH    
	ret             
	
L69F4H	call  L6A0DH    ; Build and display next line from .DO file at (DE)
L69F7H	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	inr   A         
	jmp   L6A27H    ; Update line starts array entry for row specified in A
	
L69FEH	call  L6A2EH    ; Update line starts array entry for current Cursor row
	jz    L69F7H    
L6A04H	call  ERABOL    ; Erase from cursor to end of line
	call  CRLF      ; Send CRLF to screen or printer
	jmp   L69FEH    
	
L6A0DH	call  L67DFH    ; Build next line from .DO file at (DE) into line buffer
L6A10H	push  D         ; Save .DO file pointer on stack
	lhld  0F892H     ; Get pointer to current position in line buffer
	lxi   D,0F894H   ; Point to line buffer where current line is built (tab expansion, word wrap)
L6A17H	ldax  D         ; Get next byte to be displayed
	rst   4         ; Send character in A to screen/printer
	inx   D         ; Increment to next byte in line buffer
	rst   3         ; Compare DE and HL
	jnz   L6A17H    ; Loop to display all bytes in line buffer
	lda   VLCLPS     ; LCD vs Printer output indication
	ana   A         ; Test if printing to LCD
	cz    EXTREF    ; Cancel inverse character mode
	pop   D         ; Restore .DO file pointer
	ret             
	
L6A27H	push  D         ; Push address in .DO file of end of current line
	call  L6A48H    ; Get address in .DO file of start of row in 'A' using Line Starts array
	jmp   L6A32H    
	
L6A2EH	push  D         
	call  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
L6A32H	mov   C,A       ; Save row number in C
	xthl            ; Get address of end of current line from stack
	rst   3         ; Compare DE and HL
	mov   A,C       ; Restore row number
	xchg            ; Put address of end of current line in DE
	pop   H         ; Pop the address to entry in Line Starts array for current row
	rz              ; Return if the address match (current row is the selected row maybe?)
	mov   M,E       ; Update the start address in line starts array for current row
	inx   H         ; Increment to MSB in line starts array
	mov   M,D       ; Update the start address in line starts array for current row
	mov   A,C       ; Restore row number
	ret             
	
L6A3EH	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	inr   A         ; Increment to the line below bottom of LCD
	jmp   L6A48H    ; Get address in .DO file of start of row in 'A' using Line Starts array
	
L6A45H	lda   VCURLN    ; Cursor row (1-8)
L6A48H	mov   E,A       ; Prepare to index into Line Start Array
	mvi   D,00H     
	lxi   H,0F6E9H   ; Pointer to Line Start Addresses
	dad   D         ; Index into Line Start array
	dad   D         ; Each entry is 2 bytes
	mov   E,M       ; Get LSB of address for current row
	inx   H         ; Increment to MSB
	mov   D,M       ; Get MSB of address for current row
	dcx   H         ; Decrement back to LSB
	ret             
	
L6A55H	call  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	dcr   A         ; Decrement the row nubmer
	jz    L6A61H    ; Jump if on top row
	dcx   H         ; Decrement pointer into Line Starts array
	mov   D,M       ; Get MSB of address of start of line for previous row
	dcx   H         ; Decrement address into Line Starts array
	mov   E,M       ; Get LSB of address of start of line for previous row
	ret             
	
L6A61H	LHLD  VDOEdi     ; Load start address of .DO file being edited
	rst   3         ; Compare DE and HL
	jc    L6A6CH    
	lxi   D,0000H  
	ret             
	
L6A6CH	push  D         
	dcx   D         
	rst   3         ; Compare DE and HL
	jnc   L6A8AH    
L6A72H	dcx   D         
	rst   3         ; Compare DE and HL
	jnc   L6A8AH    
	ldax  D         
	CPI   0AH       
	jnz   L6A72H    
	dcx   D         
	rst   3         ; Compare DE and HL
	jnc   L6A8AH    
	ldax  D         
	inx   D         
	CPI   0DH       
	jnz   L6A72H    
	inx   D         
L6A8AH	push  D         
	call  L67DFH    ; Build next line from .DO file at (DE) into line buffer
	pop   B         
	xchg            
	pop   D         
	push  D         
	rst   3         ; Compare DE and HL
	xchg            
	jc    L6A8AH    
	pop   D         
	mov   E,C       
	mov   D,B       
	ret             
	
L6A9BH	call  L6A55H    ; Get address in .DO file of start of line for the previous row
	xchg            
	shld  0F6E9H     ; Address of 1st byte on last line of TEXT
	ret             
	
L6AA3H	shld  VTMPHL     ; Temp storage for HL
	push  H         
	lxi   H,VTXTLS   ; Load pointer to TEXT line start addresses
	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	mov   B,A       ; Save number of rows to B
L6AAEH	mov   E,M       ; Get LSB of address in .DO for 1st byte at next line
	inx   H         ; Increment to MSB
	mov   D,M       ; Get MSB of address in .DO for 1st byte at next line
	inx   H         ; Increment to pointer for next line
	push  H         
	lhld  VTMPHL     ; Restore HL from temp storage
	rst   3         ; Compare DE and HL
	jc    L6AC4H    
	pop   H         
	xchg            
	xthl            
	xchg            
	dcr   B         
	jp    L6AAEH    
	di              
	hlt             
L6AC4H	xchg            
	pop   H         
	pop   H         
L6AC7H	push  H         ; Push address of start of current line in .DO
	lxi   H,0F894H   ; Point to beginning of line buffer
	shld  0F892H     ; Save pointer to current position in line buffer
	xra   A         ; Zero out A to reset column offset
	sta   0F890H     ; Current column offset within display line buffer
	pop   H         ; Pop address of start of current line in .DO file
	dcx   H         ; Pre-decrement address because of INX H below
L6AD4H	inx   H         ; Increment to next character on line
	rst   3         ; Compare DE and HL
	jnc   L6AEEH    ; Jump if at end of row
	mov   A,M       ; Get next byte from current row
	call  L68B2H    ; Add character in A to line buffer with TAB expansion
	mov   A,M       ; Get the byte again
	CPI   20H       ; Test if it's less than space
	jnc   L6AD4H    ; If not less than space, jump to process next character
	CPI   09H       ; Test if it's a TAB
	jz    L6AD4H    ; If it's TAB, jump to process next (TAB already correct)
	call  L68B2H    ; Add character in A to line buffer again to count the CARET for control codes
	jmp   L6AD4H    ; Jump to process next character in line
	
L6AEEH	lda   0F890H     ; Current column offset within display line buffer
	inr   A         ; Make column 1-based
	mov   H,A       ; Move column to H
	call  L63CDH    ; Get number of LCD rows based on label protect, preserve flags
	sub   B         ; Calculate number of empty rows (maybe?)
	mov   L,A       ; Put empty row count in L
	ret             
	
L6AF9H	call  L6A45H    ; Get address in .DO file of start of current row using Line Starts array
	push  D         ; Push address to stack
	inr   A         ; Increment the row number
	call  L6A48H    ; Get address in .DO file of start of next row
	mov   A,D       ; Prepare to test for -1
	ana   E         ; AND LSB
	inr   A         ; Test for -1
	jnz   L6B0CH    ; Jump if not -1
	lhld  0FB62H     ; Load pointer to end of .DO file
	xchg            ; Put pointer to end of .DO into DE
	inx   D         ; Pre-Increment pointer because of DCX below
L6B0CH	dcx   D         ; Decrement to byte prior to this line
	ldax  D         ; Load the last byte from the previous line
	CPI   0AH       ; Test if it was LF
	jnz   L6B1BH    ; Jump if not LF
	dcx   D         ; Decrement to next previous byte to test for CR
	ldax  D         ; Load next previous byte
	CPI   0DH       ; Test for CR
	jz    L6B1BH    ; If it's CR, skip increment below
	inx   D         ; Not CR, increment back to LF
L6B1BH	pop   H         ; Pop address of start of current line in .DO file
	push  H         ; Push it back on the stack
	call  L6AC7H    ; Get column/row of character in .DO file at (DE)
	lda   VCURCL    ; Cursor column (1-40)
	cmp   H         ; Test if DE points to current Cursor column
	jc    L6B0CH    ; Jump to decrement DE if location not found yet
	pop   H         ; Pop address of start of current line in .DO file
	xchg            ; Put the address in DE, HL has COL/ROW
	ret             
	
L6B2AH	LHLD  VDOEdi     ; Load start address of .DO file being edited
L6B2DH	mvi   A,1AH     ; Prepare to compare with 1Ah
L6B2FH	cmp   M         ; Test next byte of file for 1Ah
	inx   H         ; Increment pointer
	jnz   L6B2FH    ; If not 1Ah, jump to test next byte
	dcx   H         ; Decrement back to 1Ah location
	shld  0FB62H     ; Save location of end of .DO file
	ret             
	
L6B39H	push  PSW       ; Push line count to display to stack
	xchg            ; Put address of .DO file in DE
	LHLD  VDOEdi     ; Load start address of .DO file being edited
	xchg            ; HL has address in .DO file to display, DE has start of .DO file
L6B3FH	push  H         ; Push address in .DO file for display to stack
	push  D         ; Push beginning of .DO file address to stack
	call  L67DFH    ; Build next line from .DO file at (DE) into line buffer
	pop   B         ; Restore beginning of .DO file address to BC
	pop   H         ; Restore address in .DO file to display
	rst   3         ; Compare DE and HL
	jnc   L6B3FH    
	mov   H,B       
	mov   L,C       
	pop   B         ; Pop line count to display from stack
	dcr   B         ; Decrement line count to display
	rz              ; Return if done
	xchg            
L6B50H	push  B         
	call  L6A61H    
	pop   B         
	mov   A,D       
	ora   E         
	LHLD  VDOEdi     ; Load start address of .DO file being edited
	rz              
	dcr   B         
	jnz   L6B50H    
	xchg            
	ret             
	
	
; ======================================================
; Insert A into text file at M
; ======================================================
L6B61H	lxi   B,L0001H  ; Prepare to insert 1 space in .DO file to make room
	push  PSW       ; Save character to be inserted to stack
	call  L6B6DH    ; Insert BC spaces at M
	pop   B         ; Pop insert character from stack
	rc              ; If out of memory, return
	mov   M,B       ; Insert the character into .DO file
	inx   H         ; Increment the current file pointer
	ret             
	
	
; ======================================================
; Insert BC spaces at M
; ======================================================
L6B6DH	xchg            
	lhld  VPFREM     ; Unused memory pointer
	dad   B         
	rc              
	mvi   A,88H     
	sub   L         
	mov   L,A       
	mvi   A,0FFH     
	sbb   H         
	mov   H,A       
	rc              
	dad   SP        
	cmc             
	rc              
L6B7FH	push  B         
	call  L6BC3H    ; Update file pointers using BC (add)
	lhld  VPFREM     ; Unused memory pointer
	mov   A,L       
	sub   E         
	mov   E,A       
	mov   A,H       
	sbb   D         
	mov   D,A       
	push  D         
	mov   E,L       
	mov   D,H       
	dad   B         
	shld  VPFREM     ; Unused memory pointer
	xchg            
	dcx   D         
	dcx   H         
	pop   B         
	mov   A,B       
	ora   C         
	cnz   L6BE6H    ; Move BC bytes from M to (DE) with decrement
	inx   H         
	pop   B         
	ret             
	
	
; ======================================================
; Delete BC characters at M
; ======================================================
L6B9FH	mov   A,B       
	ora   C         
	rz              
	push  H         
	push  B         
	push  H         
	dad   B         
	xchg            
	lhld  VPFREM     ; Unused memory pointer
	xchg            
	mov   A,E       
	sub   L         
	mov   C,A       
	mov   A,D       
	sbb   H         
	mov   B,A       
	pop   D         
	mov   A,B       
	ora   C         
	cnz   L6BDBH    ; Move BC bytes from M to (DE) with increment
	xchg            
	shld  VPFREM     ; Unused memory pointer
	pop   B         
	xra   A         
	sub   C         
	mov   C,A       
	sbb   A         
	sub   B         
	mov   B,A       
	pop   H         
L6BC3H	push  H         
	lhld  VPSCOF    ; Start of CO files pointer
	dad   B         
	shld  VPSCOF    ; Start of CO files pointer
	lhld  VPSVAR    ; Start of variable data pointer
	dad   B         
	shld  VPSVAR    ; Start of variable data pointer
	lhld  VARRTP     ; Start of array table pointer
	dad   B         
	shld  VARRTP     ; Start of array table pointer
	pop   H         
	ret             
	
	
; ======================================================
; Move BC bytes from M to (DE) with increment
; ======================================================
L6BDBH	mov   A,M       
	stax  D         
	inx   H         
	inx   D         
	dcx   B         
	mov   A,B       
	ora   C         
	jnz   L6BDBH    ; Move BC bytes from M to (DE) with increment
	ret             
	
	
; ======================================================
; Move BC bytes from M to (DE) with decrement
; ======================================================
L6BE6H	mov   A,M       
	stax  D         
	dcx   H         
	dcx   D         
	dcx   B         
	mov   A,B       
	ora   C         
	jnz   L6BE6H    ; Move BC bytes from M to (DE) with decrement
	ret             
	
	
; ======================================================
; ROM programs catalog entries
; ======================================================
L6BF1H
    .db	0B0H             
    .dw	6C49H          
    .db	"BASIC  ",00H     
    .db	0B0H             
    .dw	5DEEH          
    .db	"TEXT   ",00H     
    .db	0B0H             
    .dw	5146H          
    .db	"TELCOM ",00H     
    .db	0B0H             
    .dw	5B68H          
    .db	"ADDRSS ",00H     
    .db	0B0H             
    .dw	5B6FH          
    .db	"SCHEDL ",00H     
    .db	88H             
    .dw	0000H          
    .db	00H,32H,0FBH,0FFH,0C3H,82H,76H,20H          ; Different from M100
    .db	0C8H             
    .dw	0000H          
L6C37H
    .db	00H,0C5H,0CDH,0DDH,26H,0C1H,0C9H,69H          ; Different from M100
    .db	48H             
    .dw	0000H          
L6C42H
    .db	00H,32H,09H,0F8H,0C3H,8DH,21H,20H          ; Different from M100
	
; ======================================================
; BASIC Entry point
; ======================================================
BENTRY	call  L6C7FH
	call  L7EA6H    ; Display TRS-80 Model number & Free bytes on LCD
	lxi   H,0F999H   
	shld  0FA8CH     ; Mark Unsaved BASIC program as active program
	lhld  VBASNS     ; BASIC program not saved pointer
	shld  VBASPP    ; Start of BASIC program pointer
L6C5BH	call  L6C9CH    ; Copy BASIC Function key table to key definition area
	call  FNKSB     ; Display function keys on 8th line
	xra   A         
	STA   VKYScm     
	inr   A         
	sta   0FAADH     ; Label line enable flag
	lxi   H,L6C78H  ; Load pointer to "llist" text
	shld  0F88AH     ; Save as key s.equence for SHIFT-PRINT key
	call  L05F0H    ; Update line addresses for current BASIC program
	call  L3F28H    ; Initialize BASIC Variables for new execution
	jmp   L0502H    ; Vector to BASIC ready - print Ok
	
L6C78H
    .db	"llist",0DH,00H          
	
L6C7FH	lhld  VPSVAR     ; Start of variable data pointer
	lxi   B,L0178H  
	dad   B         
	xchg            
	lhld  0FB67H     ; File buffer area pointer
	rst   3         ; Compare DE and HL
	jc    L6C8FH    
	dcr   H         
L6C8FH	shld  VTPRAM    ; BASIC string buffer pointer
	ret             
	
	
; ======================================================
; Copy BASIC Function key table to key definition area
; ======================================================
L6C93H	lxi   H,0F789H   ; Function key definition area
	lxi   D,0F80AH   ; Function key definition area (BASIC)
	jmp   L6CA2H    
	
	
; ======================================================
; Copy BASIC Function key table to key definition area
; ======================================================
L6C9CH	lxi   H,0F80AH   ; Function key definition area (BASIC)
	lxi   D,0F789H   ; Function key definition area
L6CA2H	mvi   B,80H     
	jmp   L2542H    ; Move B bytes from M to (DE)
	
L6CA7H	dcx   H         
	rst   2         ; Get next non-white char from M
L6CA9H	ldax  D         
	inr   A         
	rz              
	push  H         
	mvi   B,04H     
L6CAFH	ldax  D         
	mov   C,A       
	call  L0FE8H    ; Get char at M and convert to uppercase
	cmp   C         
	inx   D         
	inx   H         
	jnz   L6CCCH    
	dcr   B         
	jnz   L6CAFH    
	pop   PSW       
	push  H         
	xchg            
	mov   E,M       
	inx   H         
	mov   D,M       
	xchg            
	pop   D         
	xthl            
	push  H         
	xchg            
	inr   H         
	dcr   H         
	ret             
	
L6CCCH	inx   D         
	dcr   B         
	jnz   L6CCCH    
	inx   D         
	pop   H         
	jmp   L6CA9H    
	
	
; ======================================================
; Re-initialize system without destroying files
; ======================================================
L6CD6H	di              
	lxi   H,0FF40H   ; XON/XOFF protocol control
	mvi   B,0BDH     
	call  L4F0AH    ; Zero B bytes at M
	inr   A         
	
; ======================================================
; Warm start reset entry
; ======================================================
L6CE0H	push  PSW       
	di              
	mvi   A,19H     
	sim             
	in    0C8H       ; Read UART byte to flush any garbage
	mvi   A,43H     ; Load output code for 8155 mode
	out   0B8H       ; Set 8155 Mode
	mvi   A,05H     
	call  L7383H    ; Set clock chip mode
	mvi   A,0EDH     ; Initialize value for 8155 Port B
	out   0BAH       ; Configure 8155 Port B output
	xra   A         
	sta   VPRTE8    ; Contents of port 0E8H
	out   0E8H       ; Clear OptROM select, STROBE, etc.
	out   0A8H       
	call  L6C2CH    ; Differen from M100: Check for optional external controller
	call  L7533H    ; Enable LCD drivers after short delay
	xra   A         
	out   0FEH       
	call  L7533H    ; Enable LCD drivers after short delay
	mvi   A,3BH     ; Load code to enable LCD drivers
	out   0FEH       ; Output LCD Enable command to LCD drivers
	call  L752BH    ; Set the display top line to zero for all LCD controllers
	call  L7533H    ; Enable LCD drivers after short delay
	mvi   A,39H     
	out   0FEH       
	ei              
	call  L76A0H    ; Call routine to test if DVI data available
	jnc   L6D1EH    ; Jump if data available from DVI
L6D1DH	xra   A         ; Indicate no DVI present
L6D1EH	sta   0FC81H     ; Store flag indicating DVI present??
	ora   A         ; Test if DVI present?
	jz    L6D3DH    ; Branch to exit Warm Start if no DVI
	lda   0FFFCH     ; Load DVI Disk BASIC code initializer value
	ora   A         ; Test if DVI Disk BASIC already loaded
	jnz   L6D3DH    ; Jump if already loaded
	pop   PSW       
	rz              
	lhld  VPSVAR     ; Start of variable data pointer
	lxi   D,0E000H   ; Location of init code to be copied from DVI
	rst   3         ; Compare DE and HL
	rnc             ; Return if not enough space to copy DVI init code
	call  L76B6H    ; Copy initialization code from DVI to 0E000H and execute
	push  PSW       
	jc    L6D1DH    
L6D3DH	pop   PSW       
	ret             
	
	
; ======================================================
; L6D3FH: Send a character to the line printer
; Entry conditions: A = character to be printed
; Exit conditions:
;       Carry -- set if cancelled
;             -- reset if normal return
; ======================================================
PRINTR	push B
	mov   C,A       
L6D41	call CHSHBR     ; Check if SHIFT-BREAK is being pressed
	jc   L6D6A     
	in   0BBH       
	ANI  06H       
	XRI  02H       
	jnz  L6D41     
	call L765CH    ; Set interrupt to 1DH
	mov  A,C       
	out  0B9H       
	lda  VPRTE8     ; Contents of port 0E8H
	mov  B,A       
	ORI  02H       
	out  0E8H       
	mov  A,B       
	out  0E8H       
	mvi  B,24H     
L6D63	dcr  B
	jnz  L6D63     
	mvi  A,09H     
	sim            
L6D6A	mov  A,C
	pop  B         
	ret             
	
	
; ======================================================
; Check RS232 queue for pending characters
; ======================================================
L6D6DH	lda  0FF42H      ; XON/XOFF enable flag
	ora  A         
	jz   L6D79H    
	lda  0FF41H      ; XON/XOFF protocol control
	inr  A         
	rz             
L6D79H	lda  VNB232     ; RS232 buffer count
	ora  A         
	ret             
	
	
; ======================================================
; Get a character from RS232 receive queue
; ======================================================
L6D7EH	push H         
	push D         
	push B         
	lxi  H,L71F8H   ; Interrupt exit routine (pop all regs & RET)
	push H         
	lxi  H,VNB232   ; RS232 buffer count
L6D88H	call CHSHBR     ; Check if SHIFT-BREAK is being pressed
	rc             
	call L6D6DH     ; Check RS232 queue for pending characters
	jz   L6D88H    
	CPI  03H       
	cc   L6E0BH     ; Send XON (CTRL-Q) out RS232
	di             
	dcr  M         
	call L6DFCH     ; Calculate address to save next RS232 character
	mov  A,M       
	xchg           
	inx  H         
	inx  H         
	inr  M         
	dcr  M         
	rz             
	dcr  M         
	jz   L6DA9H    
	cmp  A         
	ret            
	
L6DA9H	ORI  0FFH       
	ret             
	
	
; ======================================================
; RST 6.5 routine (RS232 receive interrupt)
; ======================================================
L6DACH	call  VUARTH    ; RST 6.5 RAM Vector
	push  H         
	push  D         
	push  B         
	push  PSW       
	lxi   H,L71F7H  ; Interrupt exit routine (pop all regs & RET)
	push  H         
	in    0C8H       
	lxi   H,0FF8DH   ; RS232 Parity Control byte
	ana   M         
	mov   C,A       
	in    0D8H       
	ANI   0EH       
	mov   B,A       
	jnz   L6DDBH    
	mov   A,C       
	CPI   11H       
	jz    L6DD2H    
	CPI   13H       
	jnz   L6DDBH    
	mvi   A,0AFH     
	sta   0FF40H     ; XON/XOFF protocol control
	lda   0FF42H     ; XON/XOFF enable flag
	ora   A         
	rnz             
L6DDBH	lxi   H,VNB232   ; RS232 buffer count
	mov   A,M       
	CPI   40H       
	rz              
	CPI   28H       
	cnc   L6E1EH    ; Turn off XON/XOFF protocol
	push  B         
	inr   M         
	inx   H         
	call  L6DFCH    ; Calculate address to save next RS232 character
	pop   B         
	mov   M,C       
	mov   A,B       
	ora   A         
	rz              
	xchg            
	inx   H         
	dcr   M         
	inr   M         
	rnz             
	lda   VNB232     ; RS232 buffer count
	mov   M,A       
	ret             
	
	
; ======================================================
; Calculate address to save next RS232 character
; ======================================================
L6DFCH	inx   H         
	mov   C,M       
	mov   A,C       
	inr   A         
	ANI   3FH       
	mov   M,A       
	xchg            
	lxi   H,0FF46H   ; RS232 Character buffer
	mvi   B,00H     
	dad   B         
	ret             
	
	
; ======================================================
; Send XON (CTRL-Q) out RS232
; ======================================================
L6E0BH	lda   0FF42H     ; XON/XOFF enable flag
	ana   A         
	rz              
	lda   0FF8AH     ; Control-S status
	dcr   A         
	rnz             
	sta   0FF8AH     ; Control-S status
	push  B         
	mvi   C,11H     
	jmp   L6E3AH    ; Send character in C to serial port
	
	
; ======================================================
; Turn off XON/XOFF protocol
; ======================================================
L6E1EH	lda   0FF42H     ; XON/XOFF enable flag
	ana   A         
	rz              
	lda   0FF8AH     ; Control-S status
	ora   A         
	rnz             
	inr   A         
	sta   0FF8AH     ; Control-S status
	push  B         
	mvi   C,13H     
	jmp   L6E3AH    ; Send character in C to serial port
	
	
; ======================================================
; Send character in A to serial port using XON/XOFF
; ======================================================
L6E32H	push  B         
	mov   C,A       
	call  L6E4DH    ; Handle XON/XOFF protocol
	jc    L6E4AH    
	
; ======================================================
; Send character in C to serial port
; ======================================================
L6E3AH	call  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	jc    L6E4AH    
	in    0D8H       
	ANI   10H       
	jz    L6E3AH    ; Send character in C to serial port
	mov   A,C       
	out   0C8H       
L6E4AH	mov   A,C       
	pop   B         
	ret             
	
	
; ======================================================
; Handle XON/XOFF protocol
; ======================================================
L6E4DH	lda   0FF42H     ; XON/XOFF enable flag
	ora   A         
	rz              
	mov   A,C       
	CPI   11H       
	jnz   L6E5FH    
	xra   A         
	sta   0FF8AH     ; Control-S status
	jmp   L6E65H    
	
L6E5FH	SUI   13H       
	jnz   L6E69H    
	dcr   A         
L6E65H	sta   0FF41H     ; XON/XOFF protocol control
	ret             
	
L6E69H	call  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	rc              
	lda   0FF40H     ; XON/XOFF protocol control
	ora   A         
	jnz   L6E69H    
	ret             
	
	
; ======================================================
; Set RS232 baud rate stored in H
; ======================================================
L6E75H	push  H         
	mov   A,H       
	rlc             
	lxi   H,L6E92H  
	mvi   D,00H     
	mov   E,A       
	dad   D         
	shld  0FF8BH     ; UART baud rate timer value
	pop   H         
L6E83H	push  H         
	lhld  0FF8BH     ; UART baud rate timer value
	mov   A,M       
	out   0BCH       
	inx   H         
	mov   A,M       
	out   0BDH       
	mvi   A,0C3H     
	out   0B8H       
L6E92H	pop   H         
	ret             
	
	
; ======================================================
; RS232 baud rate timer values
; ======================================================
    .dw	4800H,456BH,4200H,4100H
    .dw	4080H,4040H,4020H,4010H
    .dw	4008H          
	
	
; ======================================================
; Initialize RS232 or modem
; ======================================================
L6EA6H	push  H         
	push  D         
	push  B         
	push  PSW       
	mvi   B,25H     
	jc    L6EB3H    
	mvi   H,03H     
	mvi   B,2DH     
L6EB3H	di              
	call  L6E75H    ; Set RS232 baud rate stored in H
	mov   A,B       
	out   0BAH       
	in    0D8H       
	mov   A,L       
	ANI   1FH       
	out   0D8H       
	call  L6F39H    ; Initialize serial buffer parameters
	dcr   A         
	sta   0FF43H     ; RS232 initialization status
	jmp   L71F7H    ; Interrupt exit routine (pop all regs & RET)
	
	
; ======================================================
; Deactivate RS232 or modem
; ======================================================
L6ECBH	in    0BAH       
	ORI   0C0H       
	out   0BAH       
	xra   A         
	sta   0FF43H     ; RS232 initialization status
	ret             
	
L6ED6H	mvi   E,00H     
L6ED8H	in    0D8H       
	ANI   01H       
	xra   D         
	jnz   L6EE5H    ; Click sound port if sound enabled
	inr   E         
	jp    L6ED8H    
	ret             
	
	
; ======================================================
; Click sound port if sound enabled
; ======================================================
L6EE5H	push  PSW       ; Preserve PSW
	lda   0FF44H     ; Sound flag
	ora   A         ; Test if sound enabled
	cz    L7676H    ; Click sound port
	pop   PSW       ; Restore PSW
	ret             
	
	
; ======================================================
; Check for carrier detect
; ======================================================
L6EEFH	push  H         
	push  D         
	push  B         
	lxi   H,L6F2CH  
	push  H         
	in    0BBH       
	ANI   10H       
	lxi   H,L0249H  
	lxi   B,L1A0EH  
	jnz   L6F09H    
	lxi   H,L0427H  
	lxi   B,L0C07H  
L6F09H	di              
	in    0D8H       
	ANI   01H       
	mov   D,A       
	call  L6ED6H    
	jm    L6F1AH    
	xra   D         
	mov   D,A       
	call  L6ED6H    
L6F1AH	ei              
	rm              
	mov   A,E       
	cmp   B         
	rnc             
	cmp   C         
	rc              
	dcx   H         
	mov   A,H       
	ora   L         
	jnz   L6F09H    
	call  L6F39H    ; Initialize serial buffer parameters
	pop   H         
	jnz   0FFF6H     
	jmp   L14EEH    ; POP BC, DE, HL from stack
	
	
; ======================================================
; Enable XON/OFF when CTRL-S / CTRL-Q sent
; ======================================================
L6F31H	mvi   A,0AFH     
	di              
	sta   0FF42H     ; XON/XOFF enable flag
	ei              
	ret             
	
	
; ======================================================
; Initialize serial buffer parameters
; ======================================================
L6F39H	xra   A         
	mov   L,A       
	mov   H,A       
	shld  0FF40H     ; XON/XOFF protocol control
	shld  VNB232     ; RS232 buffer count
	shld  0FF88H     ; RS232 buffer input pointer
	ret             
	
	
; ======================================================
; Write cassette header and sync byte
; ======================================================
L6F46H	lxi   B,L0200H  ; SYNC header is 512 bytes of 55h
L6F49H	mvi   A,55H     ; Load 55h byte
	push  B         ; Save remaining count
	call  L6F5EH    ; Send next 55h byte to CAS
	pop   B         ; Pop count
	dcx   B         ; Decrement count
	mov   A,B       ; Prepare to test for zero
	ora   C         ; OR in LSB to test for zero
	jnz   L6F49H    ; Loop until 512 bytes sent
	mvi   A,7FH     ; After 512 bytes of 55h, send one 7Fh byte
	jmp   L6F5EH    ; Send final 7FH byte to CAS
	
	
; ======================================================
; Write char in A to cassette w/o checksum or sync bit
; ======================================================
L6F5BH	call  L6F71H    ; Call routine to send a single 0 bit before the byte
L6F5EH	mvi   B,08H     ; Prepare to send 8 bits of data
L6F60H	call  L6F6AH    ; Write bit 0 of A to cassette
	dcr   B         ; Decrement bit counter
	jnz   L6F60H    ; Loop for all 8 bits
	jmp   CHSHBR    ; Check if SHIFT-BREAK is being pressed
	
	
; ======================================================
; Write bit 0 of A to cassette
; ======================================================
L6F6AH	rlc             ; Rotate MSB into Carry
	lxi   D,L1F24H  ; Cassette fr.equency cycle count
	jc    L6F74H    ; Jump if MSB is a 1
L6F71H	lxi   D,L4349H  ; Cassette fr.equency cycle count
L6F74H	dcr   D         ; Decrement the counter
	jnz   L6F74H    ; Loop until D is zero
	mov   D,A       ; Save byte being sent in D
	mvi   A,0D0H     ; Prepare to set Serial Output data to 1
	sim             ; Set SOD to 1
L6F7CH	dcr   E         ; Decrement E
	jnz   L6F7CH    ; Loop until E is zero
	mvi   A,50H     ; Prepare to set Serial Output Data to 0
	sim             ; Set SOD to 0
	mov   A,D       ; Restore byte being sent
	ret             
	
	
; ======================================================
; Read cassette header and sync byte
; ======================================================
L6F85H	mvi   B,80H     ; Set sync bit counter to 128 (16 bytes)
L6F87H	call  L6FDBH    ; Read Cassette port data bit
	rc              ; Return if CTRL-BREAK pressed
	mov   A,C       ; Get count of square wave period
	CPI   08H       ; Test if period less than 8
	jc    L6F85H    ; Read cassette header and sync byte
	CPI   40H       ; Test if period greater than 64
	jnc   L6F85H    ; Read cassette header and sync byte
	dcr   B         ; Decrement sync bit count
	jnz   L6F87H    ; Loop for 128 bits (16 bytes)
L6F9AH	call  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	rc              ; Return if SHIFT-BREAK pressed
	lxi   H,0000H   ; Set count of 0->1 and 0->0 transitions to zero
	mvi   B,40H     ; Load bit count to 64 (8 bytes)
L6FA3H	call  L7016H    ; Read a bit (period in C)
	rc              ; Return if SHIFT-BREAK pressed
	mov   D,C       ; Save bit period in D
	call  L7016H    ; Read next bit (period in C)
	rc              ; Return if SHIFT-BREAK pressed
	mov   A,D       ; Get period of first bit
	sub   C         ; Subtract period of 2nd bit
	jnc   L6FB3H    ; \
	cma             ; > Create ABS(D-C)
	inr   A         ; /
L6FB3H	CPI   0BH       ; Test for 0->1 or 1->0 bit transition
	jc    L6FBAH    ; Jump to increment 0->0 or 1->1 bit detection
	inr   H         ; Increment 0->1 or 1->0 bit transition count
	mvi   A,2CH     ; Make INR L below look like MVI A,2CH
	dcr   B         ; Decrement bit counter
	jnz   L6FA3H    ; Jump to test next 2 bits
	mvi   A,40H     ; Prepare to test for 8 bytes of all zero or all 0FFH
	cmp   L         ; Do the compare
	jz    L6FC9H    ; If 8 bytes of zeros found, jump to skip test for 55H
	sub   H         ; Subtract count of 0->1 or 1->0 transition (55H bytes)
	jnz   L6F9AH    ; If not .equal number of zeros and 55H, go read more bits
L6FC9H	sta   0FF8EH     ; Cassette port pulse control
	mvi   D,00H     ; Clear out the packed byte
L6FCEH	call  L6FDBH    ; Read Cassette port data bit
	rc              ; Return if SHIFT-BREAK pressed
	call  L7023H    ; Count and pack cassette input bits
	CPI   7FH       ; Test for 7FH sync trailer byte
	jnz   L6FCEH    ; Jump to read next bit until 7FH found or SHIFT-BREAK
	ret             
	
	
; ======================================================
; Read Cassette port data bit
; ======================================================
L6FDBH	mvi   C,00H     ; Set raw bit length to 0
	lda   0FF8EH     ; Cassette port pulse control
	ana   A         ; Test pulse control for zero
	jz    L6FFAH    
L6FE4H	call  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	rc              ; Return if SHIFT-BREAK
	rim             ; Read the cassette 0/1 raw bit
	rlc             ; Rotate bit into carry
	jnc   L6FE4H    ; Jump if SID is low to skip increment
L6FEDH	inr   C         ; Increment SID high length
L6FEEH	inr   C         ; Increment SID high length
	jz    L6FE4H    ; Jump if C rolls over the test for CTRL-BREAK
	rim             ; Read the cassette 0/1 raw bit
	rlc             ; Rotate SID bit into carry
	jc    L6FEEH    ; If SID still high, go increment C again
	jmp   L700DH    ; Jump to screech the speaker
	
L6FFAH	call  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	rc              ; Return if SHIFT-BREAK
	rim             ; Read the cassette 0/1 raw bit
	rlc             ; Rotate the SID bit into carry
	jc    L6FFAH    ; Jump if SID is high
L7003H	inr   C         ; Increment SID low length
L7004H	inr   C         ; Increment SID low length
	jz    L6FFAH    ; Jump if C rolls over to check for CTRL-BREAK
	rim             ; Read the cassette 0/1 raw bit
	rlc             ; Rotate SID into carry
	jnc   L7004H    ; Jump if SID still LOW to increment
L700DH	lda   0FF44H     ; Sound flag
	ana   A         ; Test if sound enabled
	cz    L7676H    ; Click sound port
	xra   A         ; Clear carry flag (no CTRL-BREAK pressed)
	ret             
	
L7016H	call  L7003H    ; Jump to loop to wait for SID high crossing
	rc              ; Return if SHIFT-BREAK pressed
	mvi   C,00H     ; Set SID high count to zero
	call  L6FEDH    ; Jump to loop to measure SID high count
	rc              ; Return if SHIFT-BREAK pressed
	jmp   L7003H    ; Now measure the low period
	
	
; ======================================================
; Count and pack cassette input bits
; ======================================================
L7023H	mov   A,C       ; Get SID high period count
	CPI   15H       ; Test if 21 or more ('0' bit) to set carry
	mov   A,D       ; Get current byte packing
	ral             ; Rotate next bit from carry into the byte
	mov   D,A       ; Save the byte being built back to D
	ret             
	
	
; ======================================================
; Read character from cassette w/o checksum
; ======================================================
L702AH	call  L6FDBH    ; Read Cassette port data bit
	rc              ; Return if CTRL-BREAK pressed
	mov   A,C       ; Get length of SID high period
	CPI   15H       ; Test if SID high 21 or more counts ('0' bit)
	jc    L702AH    ; Read character from cassette w/o checksum
	mvi   B,08H     ; Prepare to read 8 bits
L7036H	call  L6FDBH    ; Read Cassette port data bit
	rc              ; Return if CTRL-BREAK pressed
	call  L7023H    ; Count and pack cassette input bits
	dcr   B         ; Decrement the bit count
	jnz   L7036H    ; Jump to loop for all bits
	xra   A         ; Clear carry (no CTRL-SHIFT pressed)
	ret             
	
	
; ======================================================
; Cassette REMOTE routine - turn motor on or off
; ======================================================
L7043H	lda   VPRTE8     ; Contents of port 0E8H
	ANI   0F1H       
	inr   E         
	dcr   E         
	jz    L704FH    
	ORI   08H       
L704FH	out   0E8H       
	sta   VPRTE8     ; Contents of port 0E8H
	ret             
	
	
; ======================================================
; Keyboard scanning management routine
; ======================================================
L7055H	lxi   H,L71F4H  
	push  H         
	lxi   H,0FF8FH   
	dcr   M         
	rnz             
	mvi   M,03H     
	
; ======================================================
; Key detection -- Determine which keys are pressed
; ======================================================
	lxi   H,0FF99H   ; Keyboard scan column storage #1
	lxi   D,0FFA2H   ; Keyboard scan column storage @2
	call  SCMODK    ; Scan BREAK),CAPS),NUM),CODE),GRAPH),CTRL),SHIFT & set bits in A
	cma             
	cmp   M         
	mov   M,A       
	cz    L7101H    
	xra   A         
	out   0B9H       
	in    0E8H       
	inr   A         
	mvi   A,0FFH     
	out   0B9H       
	jz    L71FDH    
	mvi   A,7FH     
	mvi   C,07H     
L7080H	dcx   H         
	dcx   D         
	mov   B,A       
	out   0B9H       
	in    0E8H       
	cma             
	cmp   M         
	mov   M,A       
	jnz   L7092H    
	ldax  D         
	cmp   M         
	cnz   L70C5H    
L7092H	mvi   A,0FFH     
	out   0B9H       
	mov   A,B       
	Rrc             
	dcr   C         
	jp    L7080H    
	dcx   H         
	mvi   M,02H     
	lxi   H,0FFA5H   
	dcr   M         
	jz    L711AH    
	inr   M         
	rm              
	lda   0FFA7H     
	lhld  0FFA8H     ; Pointer to entry in 2nd Storage Buffer for key
	ana   M         
	rz              
	
; ======================================================
; Key repeat detection
; ======================================================
	lda   0FFAAH     ; Keyboard buffer count
	CPI   02H       
	rnc             
	lxi   H,0FFA4H   ; Key repeat start delay counter
	dcr   M         
	rnz             
	mvi   M,06H     
	mvi   A,01H     
	sta   VPCRBC     
	jmp   L7122H    ; Key decoding
	
L70C5H	push  B         
	push  H         
	push  D         
	mov   B,A       
	mvi   A,80H     
	mvi   E,07H     
L70CDH	mov   D,A       
	ana   M         
	jz    L70D6H    
	ana   B         
	jz    L70E2H    
L70D6H	mov   A,D       
	Rrc             
	dcr   E         
	jp    L70CDH    
	pop   D         
L70DDH	pop   H         
	mov   A,M       
	stax  D         
	pop   B         
	ret             
	
L70E2H	lxi   H,0FFA5H   
	inr   A         
	cmp   M         
	jnz   L70EEH    
	pop   D         
	pop   H         
	pop   B         
	ret             
	
L70EEH	mov   M,A       
	mov   A,C       
	rlc             
	rlc             
	rlc             
	ora   E         
	inx   H         
	mov   M,A       
	inx   H         
	mov   M,D       
	pop   D         
	xchg            
	shld  0FFA8H     ; Pointer to entry in 2nd Storage Buffer for key
	xchg            
	jmp   L70DDH    
	
L7101H	ldax  D         
	mov   B,A       
	mov   A,M       
	stax  D         
	rlc             
	rnc             
	mov   A,B       
	rlc             
	rc              
	xthl            
	lxi   H,L71C4H  
	xthl            
	mvi   B,00H     
	mov   D,B       
	mov   A,M       
	Rrc             
	mvi   A,03H     
	rc              
	mvi   A,13H     
	ret             
	
L711AH	dcx   H         
	mvi   M,54H     
	dcx   H         
	lda   0FFA2H     ; Keyboard scan column storage @2
	mov   M,A       
	
; ======================================================
; Key decoding
; ======================================================
L7122H	lda   0FFA6H     ; Key position storage
	mov   C,A       
	lxi   D,L002CH  
	mov   B,D       
	CPI   33H       
	jc    L7133H    
	lxi   H,0FFA7H   
	mov   M,B       
L7133H	lda   0FFA3H     ; Shift key status storage
	Rrc             
	push  PSW       
	mov   A,C       
	cmp   E         
	jc    L7184H    
	CPI   30H       
	jnc   L7148H    
	pop   PSW       
	push  PSW       
	Rrc             
	jc    L7184H    
L7148H	lxi   H,L7CEFH  
	pop   PSW       
	jnc   L7152H    
	lxi   H,L7CDBH  
L7152H	dad   B         
	mov   A,M       
	rlc             
	ora   A         
	rar             
	mov   C,A       
	jnc   L71E4H    ; Keyboard buffer management - place subs.equent key in buffer
	CPI   08H       
	jnc   L7180H    
	LDA   VKYScm     
	ANI   0E0H       
	jnz   L7180H    
	lhld  VBSCLN     ; Current executing line number
	mov   A,H       
	ana   L         
	inr   A         
	jz    L7180H    
	lxi   H,0F630H   ; Function key status table (1 = on)
	dad   B         
	mov   A,M       
	ora   A         
	jz    L7180H    
	mov   A,C       
	ORI   80H       
	jmp   L71D5H    ; Keyboard buffer management - place key in new buffer
	
L7180H	dcr   B         
	jmp   L71E4H    ; Keyboard buffer management - place subs.equent key in buffer
	
L7184H	pop   PSW       
	jc    L7189H    
	mov   E,B       
L7189H	Rrc             
	push  PSW       
	jc    L720AH    ; Handle unshifted & non-CTRL key during key decoding
L718EH	lxi   H,L7C49H  
	Rrc             
	jc    L71B5H    
	lxi   H,L7CA1H  
	Rrc             
	jc    L71B5H    
	Rrc             
	jnc   L71AEH    
	lxi   H,L7BF1H  
	dad   B         
	push  D         
	mov   D,A       
	call  L7233H    ; Handle NUM key during key decoding
	mov   A,D       
	pop   D         
	jz    L71B7H    
L71AEH	Rrc             
	cc    L722CH    ; Handle CAPS LOCK key during key decoding
	lxi   H,L7BF1H  
L71B5H	dad   D         
L71B6H	dad   B         
L71B7H	pop   PSW       
	mov   A,M       
	jnc   L71C2H    
	CPI   60H       
	rnc             
	ANI   3FH       
	jc    0C8B7H     
L71C4H	mov   C,A       
	ANI   0EFH       
	CPI   03H       
	jnz   L71E4H    ; Keyboard buffer management - place subs.equent key in buffer
	LDA   VKYScm     
	ANI   0C0H       
	jnz   L71E4H    ; Keyboard buffer management - place subs.equent key in buffer
	mov   A,C       
	
; ======================================================
; Keyboard buffer management - place key in new buffer
; ======================================================
L71D5H	sta   0FFEBH     ; Holds CTRL-C or CTRL-S until it is processed
	CPI   03H       
	rnz             
	lxi   H,0FFAAH   ; Keyboard buffer count
	mvi   M,01H     
	inx   H         
	jmp   L71F0H    
	
	
; ======================================================
; Keyboard buffer management - place subs.equent key in buffer
; ======================================================
L71E4H	lxi   H,0FFAAH   ; Keyboard buffer count
	mov   A,M       
	CPI   20H       
	rz              
	inr   M         
	rlc             
	inx   H         
	mov   E,A       
	dad   D         
L71F0H	mov   M,C       
	inx   H         
	mov   M,B       
	pop   PSW       
L71F4H	mvi   A,09H     
	sim             
	
; ======================================================
; Interrupt exit routine (pop all regs & RET)
; ======================================================
L71F7H	pop   PSW       
L71F8H	pop   B         
	pop   D         
	pop   H         
	ei              
	ret             
	
L71FDH	lxi   H,0FF90H   
	dcr   M         
	rnz             
	lxi   H,0FF91H   
	mvi   B,11H     
	jmp   L4F0AH    ; Zero B bytes at M
	
	
; ======================================================
; Handle unshifted & non-CTRL key during key decoding
; ======================================================
L720AH	mov   A,C       
	CPI   1AH       
	lxi   H,L7C1DH  
	jc    L71B6H    
	CPI   2CH       
	jc    L721DH    
	CPI   30H       
	jc    L7222H    ; Handle Arrow keys during key decoding
L721DH	pop   PSW       
	push  PSW       
	jmp   L718EH    
	
	
; ======================================================
; Handle Arrow keys during key decoding
; ======================================================
L7222H	SUI   2CH       
	lxi   H,L7D2FH  
	mov   C,A       
	dad   B         
	jmp   L71B7H    
	
	
; ======================================================
; Handle CAPS LOCK key during key decoding
; ======================================================
L722CH	mov   A,C       
	CPI   1AH       
	rnc             
	mvi   E,2CH     
	ret             
	
	
; ======================================================
; Handle NUM key during key decoding
; ======================================================
L7233H	mov   A,M       
	mvi   E,06H     
	lxi   H,L7CF9H  
L7239H	cmp   M         
	inx   H         
	rz              
	inx   H         
	dcr   E         
	jp    L7239H    
	ret             
	
	
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
KYREAD	call L765CH     ; Set interrupt to 1DH
	lda  0FFAAH      ; Keyboard buffer count
	ora  A
	jz   L726AH     ; Enable interrupts as normal
	lxi  H,0FFACH
	mov  A,M
	Adi  02H
	dcx  H
	mov  A,M
	push PSW
	dcx  H
	dcr  M
	mov  A,M
	rlc
	mov  C,A
	inx  H
	lxi  D,0FFADH
L725E	dcr  C
	jm   L7269
	ldax D
	mov  M,A
	inx  H
	inx  D
	jmp  L725E
L7269	pop  PSW
	
; ======================================================
; Enable interrupts as normal
; ======================================================
L726AH	push  PSW       
	mvi   A,09H     
	sim             
	pop   PSW       
	ret             
	
	
; ======================================================
; L7270H: Check keyboard queue for characters or BREAK
; Entry conditions: none
; Exit conditions:  Z flag set if queue empty,
;                   reset if keys pending
;       Carry -- Set when BREAK entered
;             -- Reset with any other key
; ======================================================
KEYX	call BRKCHK     ; Check for break or wait (CTRL-S)
	jz   L727E
	CPI  03H
	jnz  L727E
	ora  A
	stc
	ret
L727E	lda  0FFAAH      ; Keyboard buffer count
	    ora  A
    	ret
	
; ======================================================
; L7283H: Check for BREAK characters only (CTRL-C or -S)
; Entry conditions: none
; Exit conditions:  
;       Carry -- Set when BREAK or PAUSE entered
;             -- Reset if no BREAK characters
; ======================================================
; Check for break or wait (CTRL-S)
BRKCHK	push H
	lxi  H,0FFEBH    ; Holds CTRL-C or CTRL-S until it is processed
	mov  A,M        ; Test for pending CTRL-C or CTRL-S
	mvi  M,00H      ; Clear pending CTRL-C or CTRL-S
	pop  H
	ora  A          ; Test if either was pending
	rp              ; Return if CTRL-C or CTRL-S pending
	push H
	push B
	lxi  H,0F7CAH
	mov  C,A
	mvi  B,00H
	dad  B
	dad  B
	dad  B
	call L3FD2H     ; Trigger interrupt.  HL points to interrupt table
	pop  B
	pop  H
	xra  A
	ret
	
; ======================================================
; L729FH: Check if SHIFT-BREAK is being pressed
; ======================================================
CHSHBR	push B
	in   0B9H
	mov  C,A
	call SCMODK     ; Scan BREAK,CAPS,NUM,CODE,GRAPH,CTRL,SHIFT & set bits in A
	push PSW
	mov  A,C
	out  0B9H
	pop  PSW
	pop  B
	ANI  81H
	rnz
	stc
	ret
; Scan BREAK,CAPS,NUM,CODE,GRAPH,CTRL,SHIFT & set bits in A
SCMODK	mvi  A,0FFH
	out  0B9H
	in   0BAH
	ANI  0FEH
	mov  B,A
	out  0BAH
	in   0E8H
	push PSW
	mov  A,B
	inr  A
	out  0BAH
	pop  PSW
	ret
	
	
; ======================================================
; Produce a tone of DE freq and B duration
; ======================================================
L72C5H	di              
	mov   A,E       
	out   0BCH       
	mov   A,D       
	ORI   40H       
	out   0BDH       
	mvi   A,0C3H     
	out   0B8H       
	in    0BAH       
	ANI   0F8H       
	ORI   20H       
	out   0BAH       
L72DAH	call  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	jnc   L72E8H    
	mvi   A,03H     
	sta   0FFEBH     ; Holds CTRL-C or CTRL-S until it is processed
	jmp   L72F9H    
	
L72E8H	mvi   C,64H     
L72EAH	push  B         
	mvi   C,1EH     
	call  L7657H    ; Delay routine - decrement C until zero
	pop   B         
	dcr   C         
	jnz   L72EAH    
	dcr   B         
	jnz   L72DAH    
L72F9H	in    0BAH       
	ORI   04H       
	out   0BAH       
	call  L6E83H    
	ei              
	ret             
	
; ======================================================
; In the M100 this address is not called. It is used 
; however in the T102 rom.
; TODO: compare logic to that of the M100, it is
; a different routine all together.
; ======================================================
L7304H	call  L35D9H    ; different from m100 to: 7328H
	push  H         ; /
	lhld  VFAC1I     ; Start of FAC1 for integers
	lxi   D,VSSYS   ; Active system signature -- Warm vs Cold boot
	rst   3         ; Compare DE and HL
	xchg            
	cc    L2791H    ; Get command byte to send to external I/O
	pop   H         
	ret             ; Point to next command byte
	
L7315H	call  L6D7EH    ; Get a character from RS232 receive queue
	rc              ; Point to 3rd command byte
	CPI   7FH       ; Get 3rd command byte
	stc             
	cmc             ; Get MSB of RX data count
	rnz             ; OR in LSB of RX data count
	mov   B,A       ; Jump to pop all regs & EI if count=0
	lda   VISTAT    ; RS232 parameter setting table
	CPI   3AH       
	mov   A,B       ; Increment buffer pointer
	cmc             ; Decrement RX count
	ret             ; Jump to receive all data from external device
	
	inr   A         
	ret             
	
; ======================================================
; Copy clock chip regs to M
; ======================================================
L7329H	ORI   0AFH       
	push  PSW       
	call  L765CH    ; Disable Background task & barcode interrupts
	mvi   A,03H     
	cnz   L7383H    ; Set clock chip mode
	mvi   A,01H     
	call  L7383H    ; Set clock chip mode
	mvi   C,07H     
	call  L7657H    ; Delay routine - decrement C until zero
	mvi   B,0AH     
L7340H	mvi   C,04H     
	mov   D,M       
L7343H	pop   PSW       
	push  PSW       
	jz    L7352H    ; Read next bit from Clock Chip
	in    0BBH       
	rar             
	mov   A,D       
	rar             
	mov   D,A       
	xra   A         
	jmp   L735DH    
	
; ======================================================
; Read next bit from Clock Chip
; ======================================================
L7352H	mov   A,D       
	Rrc             
	mov   D,A       
	mvi   A,10H     
	rar             
	rar             
	rar             
	rar             
	out   0B9H       
L735DH	ORI   09H       
	out   0B9H       
	ANI   0F7H       
	out   0B9H       
	dcr   C         
	jnz   L7343H    
	mov   A,D       
	Rrc             
	Rrc             
	Rrc             
	Rrc             
	ANI   0FH       
	mov   M,A       
	inx   H         
	dcr   B         
	jnz   L7340H    
	pop   PSW       
	mvi   A,02H     
	cz    L7383H    ; Set clock chip mode
	xra   A         
	call  L7383H    ; Set clock chip mode
	jmp   L743CH    
	
; ======================================================
; Set clock chip mode
; ======================================================
L7383H	out   0B9H       ; Write mode to clock chip (lower 3 bits)
	lda   VPRTE8    ; Contents of port 0E8H
	ORI   04H       ; Set CLOCK bit
	out   0E8H       ; Write CLOCK strobe high
	ANI   0FBH       ; Clear CLOCK bit
	out   0E8H       ; Write CLOCK strobe low
	ret             
	
; ======================================================
; Cursor BLINK - Continuation of RST 7.5 Background hook
; ======================================================
L7391H	call  L765CH    ; Disable Background task & barcode interrupts
	lxi   H,L7055H  ; Load address of Keyboard scanning management routine
	push  H         ; Push return address to stack
	lxi   H,VPCRBC  ; Load pointer to cursor blink count-down
	dcr   M         ; Decrement the cursor blink count-down
	rnz             ; Return (to Keyboard scanning) if not time to blink
	mvi   M,7DH     ; Re-initialize cursor blink counter
	dcx   H         ; Decrement to address of cursor blink on-off status
	mov   A,M       ; Get current cursor blink blink on-off status
	ora   A         ; Test if blink disabled
	jp    L73A6H    ; Jump to change blink state if not disabled
	rpo             ; Return if blink on-off status Parity is odd (0x80)
L73A6H	XRI   01H       ; Toggle the cursor blink on-of state
	mov   M,A       ; Update the new cursor blink state
	
; ======================================================
; Blink the cursor
; ======================================================
L73A9H	push  H         ; Save HL on stack
	lxi   H,VACRBP  ; Cursor bit pattern storage
	mvi   D,00H     
	call  L74A2H    ; Byte Plot - Send bit pattern to LCD for character
	mvi   B,06H     ; Prepare to compliment 6 bytes of Cursor pixels
	dcx   H         ; HL now points to end of cursor bit pattern
L73B5H	mov   A,M       ; Get next byte of cursor pattern
	cma             ; Compliment all bits in Cursor pattern
	mov   M,A       ; Save it back
	dcx   H         ; Decrement to next col of cursor bits
	dcr   B         ; Decrement loop counter
	jnz   L73B5H    ; Jump until count = 0
	inx   H         ; Increment to cursor bit storage again
	mvi   D,01H     
	call  L74A2H    ; Byte Plot - Send bit pattern to LCD for character
	pop   H         ; Restore HL
	ret             ; This will return to Keyscan routine for RST 7.5 hook from above
	
; ======================================================
; Turn off background task, blink & reinitialize cursor blink time
; ======================================================
L73C5H	push  H         ; Push registers to stack to preserve
	push  D         
	push  B         
	push  PSW       
	call  L765CH    ; Disable Background task & barcode interrupts
	lxi   H,VCBLKC  ; Load address of Cursor blink counter
	mov   A,M       ; Load Cursor blink counter
	Rrc             ; Test if time to blink
	cc    L73A9H    ; Blink the cursor
	mvi   M,80H     ; Initialize Cursor blink counter
	jmp   L71F4H    ; Set new interrupt mask and pop all regs & RET
	
; ======================================================
; Initialize Cursor Blink to start blinking
; ======================================================
L73D9H	push  PSW       ; Preserve PSW on stack
	push  H         ; Preserve HL on stack
	call  L765CH    ; Disable Background task & barcode interrupts
	lxi   H,VCBLKC  ; Load address of Cursor blink counter
	mov   A,M       ; Get current Cursor blink flag
	ANI   7FH       ; Mask off upper bit
	mov   M,A       ; Save new cursor blink flag
	inx   H         ; Point to LSB of cursor blink counter
	mvi   M,01H     ; Set blink count to 1 maybe
	mvi   A,09H     ; Load new interrupt mask value
	sim             ; Set new interrupt mask
	pop   H         ; Restore HL
	pop   PSW       ; Restore PSW
	ret             
	
; ======================================================
; Character plotting level 7.  Plot character in C on LCD at (H,L)
; ======================================================
L73EEH	call  L765CH    ; Disable Background task & barcode interrupts
	lxi   H,0000H  
	dad   SP        
	shld  0FFF8H     
	dcr   D         
	dcr   E         
	xchg            
	shld  VFFF4H     
	mov   A,C       
	lxi   D,L7710H  
	SUI   20H       
	jz    L7410H    
	inx   D         
	CPI   60H       
	jc    L7410H    
	lxi   D,L76B1H  
L7410H	push  PSW       
	mov   L,A       
	mvi   H,00H     
	mov   B,H       
	mov   C,L       
	dad   H         
	dad   H         
	dad   B         
	pop   PSW       
	push  PSW       
	jc    L741FH    
	dad   B         
L741FH	dad   D         
	pop   PSW       
	jnc   L7430H    
	lxi   D,VACRBP   ; Cursor bit pattern storage
	push  D         
	mvi   B,05H     
	call  L2542H    ; Move B bytes from M to (DE)
	xra   A         
	stax  D         
	pop   H         
L7430H	mvi   D,01H     
	call  L74A2H    ; Byte Plot - Send bit pattern to LCD for character
L7435H	xra   A         
	sta   0FFF9H     
	call  L752BH    ; Set the display top line to zero for all LCD controllers
L743CH	mvi   A,09H     
	sim             
	ret             
	
; ======================================================
; L7440H: Move Cursor to specified location.
; Entry conditions: D = column number (1-40)
;                   E = row number (1-8)
; Exit conditions:  None
; ======================================================
SETCUR	call L765CH     ; Disable Background task & barcode interrupts
	dcr  D
	dcr  E
	xchg
	shld VFFF4H
	jmp  L743CH
	
	
; ======================================================
; L744CH: Turn on pixel at specified location.
; Entry conditions: D = x coordinate (0-239)
;                   E = y coordinate (0-63)
; Exit conditions:  None
; ======================================================
PLOT
    .db  0F6H         	; Opcode for ORI, together with the next byte (at 744Dh) forms 'ORI AF', which is the first instruction of PLOT.  
; ======================================================
; L744DH: Turn off pixel at specified location.
; Entry conditions: D = x coordinate (0-239)
;                   E = y coordinate (0-63)
; Exit conditions:  None
; ======================================================
UNPLOT	xra  A          ; first instruction of UNPLOT, called at 744Dh. When PLOT is called at 744Ch, this is the 'AF' operand for ORI AF
	push PSW        ; Save PSET / PRESET entry marker
	call L765CH     ; Disable Background task & barcode interrupts
	push D
	mvi  C,0FEH
	mov  A,D
L7456	inr  C
	inr  C
	mov  D,A
	SUI  32H
	jnc  L7456
	mvi  B,00H
	lxi  H,L7643H   ; 8155 PIO chip bit patterns for Lower LCD drivers
	mov  A,E
	ral
	ral
	ral
	jnc  L746D
	lxi  H,L764DH
L746D	dad  B
	mov  B,A
	call L753BH
	mov  A,B
	ANI  0C0H
	ora  D
	mov  B,A
	mvi  E,01H
	lxi  H,VACRBP   ; Cursor bit pattern storage
	call L74F5H
	pop  D
	mov  D,B
	mov  A,E
	ANI  07H
	add  A
	mov  C,A
	mvi  B,00H
	lxi  H,L7643H   ; 8155 PIO chip bit patterns for Lower LCD drivers
	dad  B
	pop  PSW
	mov  A,M
	lxi  H,VACRBP   ; Cursor bit pattern storage
	jnz  L7497
	cma
	ana  M
    .db  06H         	; Opcode for MVI, together with the next byte (at 7497h) forms 'MVI B,B6H', which is the instruction at 7496h.  
L7497	ora  M          ; first instruction of L7497, called at 7497h. When execution reaches 7496h, this is the 'B6h' operand for MVI B,B6H
	mov  M,A
	mov  B,D
	mvi  E,01H
	call L74F6H
	jmp  L743CH
	
	
; ======================================================
; Byte Plot - Send bit pattern to LCD for character
; ======================================================
L74A2H	push  H         
	mvi   E,06H     
	lda   0FFF5H     
	CPI   08H       
	jz    L74B7H    
	CPI   10H       
	jz    L74B9H    
	CPI   21H       
	jnz   L74BBH    
L74B7H	dcr   E         
	dcr   E         
L74B9H	dcr   E         
	dcr   E         
L74BBH	mov   C,A       
	add   C         
	add   C         
	mov   C,A       
	mvi   B,00H     
	lda   VFFF4H     
	rar             
	rar             
	rar             
	lxi   H,L75C9H  
	jc    L74D0H    
	lxi   H,L7551H  ; 8155 PIO chip bit patterns for Upper LCD drivers
L74D0H	dad   B         
	mov   B,A       
	call  L753BH    ; Enable LCD driver(s) specified by (HL)
	shld  0FFF6H     
	mov   A,B       
	ora   M         
	mov   B,A       
	pop   H         
	dcr   D         
	call  L74F7H    
	inr   D         
	mvi   A,06H     
	sub   E         
	rz              
	mov   E,A       
	push  H         
	lhld  0FFF6H     
	inx   H         
	call  L753BH    ; Enable LCD driver(s) specified by (HL)
	pop   H         
	mov   A,B       
	ANI   0C0H       
	mov   B,A       
	dcr   D         
    .db	0DAH             ; Make "ORI 0AFH" below look like "JC 0AFF6H" for pass-thru
	
L74F5H	ORI   0AFH       
L74F7H	push  D         
	push  PSW       
	mov   A,B       
	call  L7548H    ; Wait for LCD driver to be available
	out   0FEH       
	jz    L7507H    
	call  L7548H    ; Wait for LCD driver to be available
	in    0FFH       
L7507H	pop   PSW       
	jnz   L751BH    ; Read E bytes to HL from LCD controller, managing LCD busy
L750BH	in    0FEH       
	ral             
	jc    L750BH    
	mov   A,M       
	out   0FFH       
	inx   H         
	dcr   E         
	jnz   L750BH    
	pop   D         
	ret             
	
L751BH	in    0FEH       ; Read LCD status
	ral             ; Rotate busy bit into carry
	jc    L751BH    ; Loop until not busy
	in    0FFH       ; Read next byte from LCD controller
	mov   M,A       ; Save byte at (HL)
	inx   H         ; Increment pointer
	dcr   E         ; Decrement counter
	jnz   L751BH    ; Loop until count is zero
	pop   D         
	ret             
	
L752BH	call  L7533H    ; Enable LCD drivers after short delay
	mvi   A,3EH     ; Load command to set top line = 0
	out   0FEH       ; Send the command
	ret             
	
	
; ======================================================
; Enable LCD drivers after short delay
; ======================================================
L7533H	mvi   C,03H     ; Prepare for a short delay
	call  L7657H    ; Delay routine - decrement C until zero
	lxi   H,L7641H  ; Point to LCD enable bits to enable all
L753BH	mov   A,M       ; Get Bit pattern for 8 drivers
	out   0B9H       ; OUTput the bit pattern for 8 drivers
	inx   H         ; Increment to bit pattern for next 2 LCD drivers
	in    0BAH       ; Get current value of I/O port with 2 LCD drivers
	ANI   0FCH       ; Mask off LCD driver bit positions
	ora   M         ; OR in selected LCD driver enable bits
	out   0BAH       ; OUTput selected LCD driver bits
	inx   H         ; Increment to next set of LCD driver enable bits
	ret             
	
	
; ======================================================
; Wait for LCD driver to be available
; ======================================================
L7548H	push  PSW       ; Save A on stack
L7549H	in    0FEH       ; Read the LCD driver input port
	ral             ; Rotate the busy bit into the C flag
	jc    L7549H    ; Jump to keep waiting until not busy
	pop   PSW       ; Restore A
	ret             
	
	
; ======================================================
; 8155 PIO chip bit patterns for LCD drivers
; ======================================================
L7551H
    .db	01H,00H,00H,01H,00H,06H,01H,00H          
    .db	0CH,01H,00H,12H,01H,00H,18H,01H          
    .db	00H,1EH,01H,00H,24H,01H,00H,2AH          
    .db	01H,00H,30H,02H,00H,04H,02H,00H          
    .db	0AH,02H,00H,10H,02H,00H,16H,02H          
    .db	00H,1CH,02H,00H,22H,02H,00H,28H          
    .db	02H,00H,2EH,04H,00H,02H,04H,00H          
    .db	08H,04H,00H,0EH,04H,00H,14H,04H          
    .db	00H,1AH,04H,00H,20H,04H,00H,26H          
    .db	04H,00H,2CH,08H,00H,00H,08H,00H          
    .db	06H,08H,00H,0CH,08H,00H,12H,08H          
    .db	00H,18H,08H,00H,1EH,08H,00H,24H          
    .db	08H,00H,2AH,08H,00H,30H,10H,00H          
    .db	04H,10H,00H,0AH,10H,00H,10H,10H          
    .db	00H,16H,10H,00H,1CH,10H,00H,22H          
L75C9H
    .db	20H,00H,00H,20H,00H,06H,20H,00H          
    .db	0CH,20H,00H,12H,20H,00H,18H,20H          
    .db	00H,1EH,20H,00H,24H,20H,00H,2AH          
    .db	20H,00H,30H,40H,00H,04H,40H,00H          
    .db	0AH,40H,00H,10H,40H,00H,16H,40H          
    .db	00H,1CH,40H,00H,22H,40H,00H,28H          
    .db	40H,00H,2EH,80H,00H,02H,80H,00H          
    .db	08H,80H,00H,0EH,80H,00H,14H,80H          
    .db	00H,1AH,80H,00H,20H,80H,00H,26H          
    .db	80H,00H,2CH,00H,01H,00H,00H,01H          
    .db	06H,00H,01H,0CH,00H,01H,12H,00H          
    .db	01H,18H,00H,01H,1EH,00H,01H,24H          
    .db	00H,01H,2AH,00H,01H,30H,00H,02H          
    .db	04H,00H,02H,0AH,00H,02H,10H,00H          
    .db	02H,16H,00H,02H,1CH,00H,02H,22H          
	
L7641H	rst   7         ; Jump to RST 38H Vector entry of following byte
    .db	03H             
	
; ======================================================
; 8155 PIO chip bit patterns for LCD drivers
; ======================================================
L7643H
    .db	01H,00H,02H,00H,04H,00H,08H,00H          
    .db	10H,00H,20H,00H,40H,00H,80H,00H          
    .db	00H,01H,00H,02H          
	
	
; ======================================================
; Delay routine - decrement C until zero
; ======================================================
L7657H	dcr   C         ; Decrement C
	jnz   L7657H    ; Delay routine - decrement C until zero
	ret             
	
	
; ======================================================
; Set interrupt to 1DH
; ======================================================
L765CH	di              ; Disalbe interrupts
	mvi   A,1DH     ; Load SIM mask to disable RST 5.5 & 7.5
	sim             ; Set new interrupt mask (disable Background & barcode)
	ei              ; Re-enable interrupts
	ret             
	
	
; ======================================================
; BSBeep routine
; ======================================================
L7662H	call  L765CH    ; Set interrupt to 1DH
	mvi   B,00H     
L7667H	call  L7676H    ; Click sound port
	mvi   C,50H     
	call  L7657H    ; Delay routine - decrement C until zero
	dcr   B         
	jnz   L7667H    
	jmp   L743CH    
	
	
; ======================================================
; Click sound port
; ======================================================
L7676H	in    0BAH       ; Load current value of I/O port 0BAH
	XRI   20H       ; Toggle the speaker I/O bit
	out   0BAH       ; Write new value to speaker to cause a "click"
	ret             
	
L767DH	lda   0FFFBH     ; Flag if external DVI is present
	inr   A         ; Increment flag to test if present
	ret             
	
	
; ======================================================
; Check for optional external controller
; ======================================================
L7682H	lxi   H,0FFFBH   ; Pointer to bytes count received???
	in    82H       ; Read DVI STATUS byte
	ANI   07H       ; Mask all but byte count???
	jz    L768FH    ; Optional external controller driver
	mvi   M,00H     ; No bytes to read � indicate Zero bytes transferred???
	ret             
	
	
; ======================================================
; Optional external controller driver
; ======================================================
L768FH	ora   M         ; Test if we already initialized DVI
	rnz             ; Return if already initialized
	mvi   M,0FFH     ; Indicate DVI detected & initialized
L7693H	mvi   A,0C1H     ; Prepare to send 0xC1 to DVI port 83H
	out   83H       ; Send 0xC1 to DVI ort 83H
	in    80H       ; Get response from DVI
	mvi   A,04H     ; Prepare to send 04H to DVI port 81H
	out   81H       ; Send 04H to DVI port 81H
	out   80H       ; Send 04H to DVI port 80H
	ret             
	
L76A0H	call  L767DH    ; Get count of bytes received from DVI?
	stc             ; Indicate more bytes to process
	rnz             ; Return if in the middle of a transfer to/from DVI
	mvi   A,03H     ; Load value of DVI CONTROl MAILBOX maybe??
	sta   0FFFAH     ; Save in DVI MAILBOX SELECT area
	xra   A         ; Zero A
	call  L76DEH    ; Send Zero to DVI CONTROL MAILBOX
	call  L76FBH    ; Read response byte from DVI
L76B1H	rlc             ; Move upper 2 bits to lower
	rlc             
	ANI   03H       ; Keep only the upper 2 bits
	ret             
	
L76B6H	mvi   A,03H     ; Load A with value to send to DVI Control port 81H
	sta   0FFFAH     ; Save 03H as value to send to DVI Control port 81H
	lxi   H,L770BH  ; Load address of Byte s.equence to sent to DVI (2, 1, 0, 0, 1)
	mvi   B,05H     ; Prepare to send 5 bytes
L76C0H	mov   A,M       ; Load next byte to send to DVI
	call  L76DEH    ; Send byte to DVI
	inx   H         ; Increment to next byte in ROM table to send to DVI
	dcr   B         ; Decrement byte counter
	jnz   L76C0H    ; Loop until all bytes sent
	call  L76FBH    ; Get response from DVI
	ora   A         ; Test if response is Zero
	stc             
	rnz             ; Return if the response is not zero
	lxi   H,0E000H   ; Point to RAM address to receive hook routine from DVI
L76D2H	call  L76FBH    ; Read next byte from DVI
	mov   M,A       ; Save next byte to RAM hook location
	inx   H         ; Increment to next RAM hook location
	dcr   B         ; Decrement byte counter
	jnz   L76D2H    ; Jump to read next byte if until all bytes read
	jmp   0E000H     
	
L76DEH	push  PSW       ; Save the PSW
L76DFH	call  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	jc    L76F4H    ; Jump to exit loop if SHIFT-BREAK pressed
	in    82H       ; Get DVI status byte
	rlc             ; Rotate DVI TX EMPTY bit (MSB) into C flag
	jnc   L76DFH    ; Jump if not ready to keep waiting
	lda   0FFFAH     ; Retrieve value to send to DVI port 81H
	out   81H       ; Send value in 0FFFAH (03H) to DVI port 81H
	pop   PSW       ; Pop byte to be sent to DVI from stack
	out   80H       ; Send next byte to DVI
	ret             
	
L76F4H	pop   PSW       ; POP Write data from stack
L76F5H	pop   PSW       
	call  L7693H    ; Re-initialize the DVI
	stc             ; Indicate SHIFT-BREAK pressed
	ret             
	
L76FBH	call  CHSHBR    ; Check if SHIFT-BREAK is being pressed
	jc    L76F5H    ; Jump to exit if SHIFT-BREAK being pressed
	in    82H       ; Get DVI STATUS byte
	ANI   20H       ; Test if RX_FULL bit is set
	jz    L76FBH    ; Jump to keep waiting for RX_FULL to be set
	in    80H       ; Read data from DVI
	ret             ; Return
	
L770BH
    .db	02H,01H,00H,00H,01H,00H          
	
	
; ======================================================
; LCD char generator shape table (20H-7FH
; ======================================================
    .db	000H,000H,000H,000H,000H,000H,000H,04FH          
    .db	000H,000H,000H,007H,000H,007H,000H,014H          
    .db	07FH,014H,07FH,014H,024H,02AH,07FH,02AH          
    .db	012H,023H,013H,008H,064H,062H,03AH,045H          
    .db	04AH,030H,028H,000H,004H,002H,001H,000H          
    .db	000H,01CH,022H,041H,000H,000H,041H,022H          
    .db	01CH,000H,022H,014H,07FH,014H,022H,008H          
    .db	008H,03EH,008H,008H,000H,080H,060H,000H          
    .db	000H,008H,008H,008H,008H,008H,000H,060H          
    .db	060H,000H,000H,040H,020H,010H,008H,004H          
    .db	03EH,051H,049H,045H,03EH,044H,042H,07FH          
    .db	040H,040H,062H,051H,051H,049H,046H,022H          
    .db	041H,049H,049H,036H,018H,014H,012H,07FH          
    .db	010H,047H,045H,045H,029H,011H,03CH,04AH          
    .db	049H,049H,030H,003H,001H,079H,005H,003H          
    .db	036H,049H,049H,049H,036H,006H,049H,049H          
    .db	029H,01EH,000H,000H,024H,000H,000H,000H          
    .db	080H,064H,000H,000H,008H,01CH,036H,063H          
    .db	041H,014H,014H,014H,014H,014H,041H,063H          
    .db	036H,01CH,008H,002H,001H,051H,009H,006H          
    .db	032H,049H,079H,041H,03EH,07CH,012H,011H          
    .db	012H,07CH,07FH,049H,049H,049H,036H,03EH          ; Different from M100
    .db	041H,041H,041H,022H,07FH,041H,041H,041H          ; Different from M100
    .db	03EH,07FH,049H,049H,049H,041H,07FH,009H          ; Different from M100
    .db	009H,009H,001H,03EH,041H,049H,049H,03AH          
    .db	07FH,008H,008H,008H,07FH,000H,041H,07FH          
    .db	041H,000H,030H,040H,041H,03FH,001H,07FH          
    .db	008H,014H,022H,041H,07FH,040H,040H,040H          
    .db	040H,07FH,002H,00CH,002H,07FH,07FH,006H          
    .db	008H,030H,07FH,03EH,041H,041H,041H,03EH          
    .db	07FH,009H,009H,009H,006H,03EH,041H,051H          
    .db	021H,05EH,07FH,009H,019H,029H,046H,026H          
    .db	049H,049H,049H,032H,001H,001H,07FH,001H          
    .db	001H,03FH,040H,040H,040H,03FH,00FH,030H          
    .db	040H,030H,00FH,07FH,020H,018H,020H,07FH          
    .db	063H,014H,008H,014H,063H,007H,008H,078H          
    .db	008H,007H,061H,051H,049H,045H,043H,000H          
    .db	07FH,041H,041H,000H,004H,008H,010H,020H          
    .db	040H,000H,041H,041H,07FH,000H,004H,002H          
    .db	001H,002H,004H,040H,040H,040H,040H,040H          
    .db	000H,001H,002H,004H,000H,020H,054H,054H          
    .db	054H,078H,07FH,028H,044H,044H,038H,038H          
    .db	044H,044H,044H,028H,038H,044H,044H,028H          
    .db	07FH,038H,054H,054H,054H,018H,008H,008H          
    .db	07EH,009H,00AH,018H,0A4H,0A4H,098H,07CH          
    .db	07FH,004H,004H,004H,078H,000H,044H,07DH          
    .db	040H,000H,040H,080H,084H,07DH,000H,000H          
    .db	07FH,010H,028H,044H,000H,041H,07FH,040H          
    .db	000H,07CH,004H,078H,004H,078H,07CH,008H          
    .db	004H,004H,078H,038H,044H,044H,044H,038H          
    .db	0FCH,028H,044H,044H,038H,038H,044H,044H          ; Different from M100
    .db	028H,0FCH,07CH,008H,004H,004H,008H,048H          ; Different from M100
    .db	054H,054H,054H,024H,004H,03FH,044H,044H          
    .db	020H,03CH,040H,040H,020H,07CH,01CH,020H          ; Different from M100
    .db	040H,020H,01CH,03CH,040H,038H,040H,03CH          
    .db	044H,028H,010H,028H,044H,01CH,0A0H,0A0H          
    .db	090H,07CH,044H,064H,054H,04CH,044H,000H          
    .db	008H,036H,041H,041H,000H,000H,077H,000H          
    .db	000H,041H,041H,036H,008H,000H,002H,001H          
    .db	002H,004H,002H,000H,000H,000H,000H,000H          
	
	
; ======================================================
; LCD char generator shape table (80H-0FFH)
; ======================================================
    .db	066H,077H,049H,049H,077H,066H,0FCH,086H          
    .db	0D7H,0EEH,0FCH,000H,07FH,063H,014H,008H          
    .db	014H,000H,078H,076H,062H,04AH,00EH,000H          
    .db	0EEH,044H,0FFH,0FFH,044H,0EEH,00CH,04CH          
    .db	07FH,04CH,00CH,000H,07CH,056H,07FH,056H          
    .db	07CH,000H,07DH,077H,047H,077H,07FH,000H          
    .db	002H,07EH,002H,03EH,042H,000H,010H,020H          ; Different from M100
    .db	01CH,002H,002H,002H,054H,034H,01CH,016H          
    .db	015H,000H,041H,063H,055H,049H,063H,000H          
    .db	024H,012H,012H,024H,012H,000H,044H,044H          
    .db	05FH,044H,044H,000H,000H,040H,03EH,001H          
    .db	000H,000H,000H,008H,01CH,03EH,000H,000H          
    .db	098H,0F4H,012H,012H,0F4H,098H,0F8H,094H          
    .db	012H,012H,094H,0F8H,014H,022H,07FH,022H          
    .db	014H,000H,0A0H,056H,03DH,056H,0A0H,000H          
    .db	04CH,02AH,01DH,02AH,048H,000H,038H,028H          
    .db	039H,005H,003H,00FH,000H,016H,03DH,016H          
    .db	000H,000H,042H,025H,015H,028H,054H,022H          
    .db	004H,002H,03FH,002H,004H,000H,010H,020H          
    .db	07EH,020H,010H,000H,008H,008H,02AH,01CH          
    .db	008H,000H,008H,01CH,02AH,008H,008H,000H          
    .db	01CH,057H,061H,057H,01CH,000H,008H,014H          
    .db	022H,014H,008H,000H,01EH,022H,044H,022H          
    .db	01EH,000H,01CH,012H,071H,012H,01CH,000H          
    .db	000H,000H,002H,001H,000H,000H,020H,055H          ; Different from M100
    .db	056H,054H,078H,000H,038H,044H,0C4H,044H          ; Different from M100
    .db	028H,000H,064H,07FH,045H,045H,020H,000H          ; Different from M100
    .db	000H,000H,001H,002H,000H,000H,0FCH,040H          ; Different from M100
    .db	040H,03CH,040H,000H,000H,002H,005H,002H          ; Different from M100
    .db	000H,000H,004H,00CH,01CH,00CH,004H,000H          
    .db	000H,004H,07FH,004H,000H,000H,01AH,0A5H          ; Different from M100
    .db	0A5H,0A5H,058H,000H,07FH,041H,065H,051H          ; Different from M100
    .db	07FH,000H,07FH,041H,05DH,049H,07FH,000H          
    .db	040H,02FH,010H,068H,044H,0E2H,015H,03FH          ; Different from M100
    .db	010H,068H,044H,0E2H,040H,02FH,010H,008H          ; Different from M100
    .db	0D4H,0B2H,006H,009H,07FH,001H,07FH,000H          ; Different from M100
    .db	029H,02AH,07CH,02AH,029H,000H,078H,015H          ; Different from M100
    .db	012H,015H,078H,000H,03CH,043H,042H,043H          ; Different from M100
    .db	03CH,000H,03EH,041H,040H,041H,03EH,000H          ; Different from M100
    .db	01CH,022H,07FH,022H,014H,000H,002H,001H          ; Different from M100
    .db	001H,002H,001H,000H,020H,055H,054H,055H          ; Different from M100
    .db	078H,000H,038H,045H,044H,045H,038H,000H          ; Different from M100
    .db	03CH,041H,040H,021H,07CH,000H,080H,07CH          ; Different from M100
    .db	04AH,04AH,034H,000H,071H,011H,067H,011H          ; Different from M100
    .db	071H,000H,038H,054H,056H,055H,018H,000H          
    .db	03CH,041H,042H,020H,07CH,000H,038H,055H          
    .db	056H,054H,018H,000H,000H,001H,000H,001H          ; Different from M100
    .db	000H,000H,088H,07EH,009H,009H,002H,000H          ; Different from M100
    .db	020H,056H,055H,056H,078H,000H,038H,056H          ; Different from M100
    .db	055H,056H,018H,000H,000H,04AH,079H,042H          ; Different from M100
    .db	000H,000H,038H,046H,045H,046H,038H,000H          ; Different from M100
    .db	038H,042H,041H,022H,078H,000H,000H,002H          ; Different from M100
    .db	001H,002H,000H,000H,038H,055H,054H,055H          ; Different from M100
    .db	018H,000H,000H,045H,07CH,041H,000H,000H          ; Different from M100
    .db	020H,054H,056H,055H,078H,000H,000H,048H          ; Different from M100
    .db	07AH,041H,000H,000H,030H,048H,04AH,049H          ; Different from M100
    .db	030H,000H,03CH,040H,042H,021H,07CH,000H          
    .db	000H,000H,07DH,000H,000H,000H,07AH,011H          ; Different from M100
    .db	009H,00AH,071H,000H,022H,055H,055H,056H          ; Different from M100
    .db	079H,000H,03AH,045H,045H,046H,039H,000H          ; Different from M100
    .db	07CH,012H,011H,07FH,049H,000H,024H,054H          ; Different from M100
    .db	078H,054H,058H,000H,078H,014H,013H,014H          ; Different from M100
    .db	078H,000H,020H,054H,055H,054H,078H,000H          ; Different from M100
    .db	03EH,051H,049H,045H,03EH,000H,038H,064H          ; Different from M100
    .db	054H,04CH,038H,000H,07EH,009H,011H,022H          ; Different from M100
    .db	07DH,000H,07CH,054H,056H,055H,044H,000H          ; Different from M100
    .db	070H,028H,026H,029H,070H,000H,000H,044H          ; Different from M100
    .db	07EH,045H,000H,000H,038H,044H,046H,045H          ; Different from M100
    .db	038H,000H,03CH,040H,042H,041H,03CH,000H          ; Different from M100
    .db	030H,048H,045H,040H,020H,000H,03CH,041H          ; Different from M100
    .db	042H,040H,03CH,000H,07CH,055H,056H,054H          
    .db	044H,000H,070H,029H,026H,028H,070H,000H          ; Different from M100
    .db	000H,000H,000H,000H,000H,000H,00FH,00FH          
    .db	00FH,000H,000H,000H,000H,000H,000H,00FH          
    .db	00FH,00FH,0F0H,0F0H,0F0H,000H,000H,000H          
    .db	000H,000H,000H,0F0H,0F0H,0F0H,00FH,00FH          
    .db	00FH,0F0H,0F0H,0F0H,0F0H,0F0H,0F0H,00FH          
    .db	00FH,00FH,00FH,00FH,00FH,00FH,00FH,00FH          
    .db	0F0H,0F0H,0F0H,0F0H,0F0H,0F0H,0FFH,0FFH          
    .db	0FFH,000H,000H,000H,000H,000H,000H,0FFH          
    .db	0FFH,0FFH,0FFH,0FFH,0FFH,00FH,00FH,00FH          
    .db	00FH,00FH,00FH,0FFH,0FFH,0FFH,0FFH,0FFH          
    .db	0FFH,0F0H,0F0H,0F0H,0F0H,0F0H,0F0H,0FFH          
    .db	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH          
    .db	000H,000H,0F8H,008H,008H,008H,008H,008H          
    .db	008H,008H,008H,008H,008H,008H,0F8H,000H          
    .db	000H,000H,008H,008H,0F8H,008H,008H,008H          
    .db	000H,000H,0FFH,008H,008H,008H,000H,000H          
    .db	0FFH,000H,000H,000H,000H,000H,00FH,008H          
    .db	008H,008H,008H,008H,00FH,000H,000H,000H          
    .db	008H,008H,00FH,008H,008H,008H,008H,008H          
    .db	0FFH,000H,000H,000H,008H,008H,0FFH,008H          
    .db	008H,008H,03FH,01FH,00FH,007H,003H,001H          
    .db	080H,0C0H,0E0H,0F0H,0F8H,0FCH,001H,003H          
    .db	007H,00FH,01FH,03FH,0FCH,0F8H,0F0H,0E0H          
    .db	0C0H,080H,055H,0AAH,055H,0AAH,055H,0AAH          
	
	
; ======================================================
; Keyboard conversion matrix
; ======================================================
L7BF1H
    .db	07AH,078H,063H,076H,062H,06EH,06DH,06CH          
    .db	061H,073H,064H,066H,067H,068H,06AH,06BH          
    .db	071H,077H,065H,072H,074H,079H,075H,069H          
    .db	06FH,070H,05BH,03BH,027H,02CH,02EH,02FH          
    .db	031H,032H,033H,034H,035H,036H,037H,038H          
    .db	039H,030H,02DH,03DH,05AH,058H,043H,056H          
    .db	042H,04EH,04DH,04CH,041H,053H,044H,046H          
    .db	047H,048H,04AH,04BH,051H,057H,045H,052H          
    .db	054H,059H,055H,049H,04FH,050H,05DH,03AH          
    .db	022H,03CH,03EH,03FH,021H,040H,023H,024H          
    .db	025H,05EH,026H,02AH,028H,029H,05FH,02BH          
L7C49H
    .db	000H,083H,084H,000H,095H,096H,081H,09AH          
    .db	085H,08BH,000H,082H,000H,086H,000H,09BH          
    .db	093H,094H,08FH,089H,087H,090H,091H,08EH          
    .db	098H,080H,060H,092H,08CH,099H,097H,08AH          
    .db	088H,09CH,09DH,09EH,09FH,0B4H,0B0H,0A3H          
    .db	07BH,07DH,05CH,08DH,0E0H,0EFH,0FFH,000H          
    .db	000H,000H,0F6H,0F9H,0EBH,0ECH,0EDH,0EEH          
    .db	0FDH,0FBH,0F4H,0FAH,0E7H,0E8H,0E9H,0EAH          
    .db	0FCH,0FEH,0F0H,0F3H,0F2H,0F1H,07EH,0F5H          
    .db	000H,0F8H,0F7H,000H,0E1H,0E2H,0E3H,0E4H          
    .db	0E5H,0E6H,000H,000H,000H,000H,07CH,000H          
L7CA1H
    .db	0A1H,0D1H,0BDH,0CEH,0CFH,0CDH,0BCH,0CAH          ; Different from M100
    .db	0C8H,0A9H,0BBH,0A2H,000H,000H,0CBH,0C9H          ; Different from M100
    .db	0B6H,0D3H,0C6H,000H,000H,000H,0B8H,0C7H          ; Different from M100
    .db	0B7H,0ACH,0B5H,0ADH,0A0H,000H,0D5H,0AEH          ; Different from M100
    .db	0C0H,000H,0C1H,000H,000H,000H,0C4H,0C2H          
    .db	0C3H,0AFH,0C5H,0BEH,0DFH,0D0H,0DEH,000H          ; Different from M100
    .db	000H,0D6H,0DDH,0DAH,0D8H,0B9H,0D7H,0BFH          ; Different from M100
    .db	000H,000H,0DBH,0D9H,0B1H,0D2H,000H,0AAH          ; Different from M100
    .db	0BAH,0ABH,0B3H,000H,0B2H,000H,0A5H,000H          ; Different from M100
    .db	0A4H,000H,0D4H,0DCH,0CCH,000H,000H,000H          ; Different from M100
    .db	000H,000H,000H,000H,000H,0A6H,0A7H,0A8H          ; Different from M100
L7CF9H
    .db	06DH,030H,06AH,031H,06BH,032H,06CH,033H          
    .db	075H,034H,069H,035H,06FH,036H,001H,006H          
    .db	014H,002H,020H,07FH,009H,01BH,08BH,088H          
    .db	08AH,00DH,080H,081H,082H,083H,084H,085H          
    .db	086H,087H,01DH,01CH,01EH,01FH,020H,008H          
    .db	009H,01BH,08BH,088H,089H,00DH,080H,081H          
    .db	082H,083H,084H,085H,086H,087H,051H,052H          
    .db	057H,05AH          
	
	
; ======================================================
; Boot routine
; ======================================================
BOOT	lxi   SP,VAALCD  ; Different from M100: Start of Alt LCD character buffer
	dcr   A         ; Different from M100
	jnz   L1BA8H    ; Different from M100
L7D3AH	in    0D8H       ; Different from M100
	ana   A         ; Different from M100
	jp    L7D3AH    ; Different from M100
	mvi   A,43H     ; Load configuration for PIO (A=OUT, B=OUT, C=IN, Stop Timer counter)
	out   0B8H       ; Set PIO chip configuration
	mvi   A,0ECH     ; PIO B configuration (RTS low, DTR low, SPKR=1, Serial=Modem, Keyscan col 9 enable)
	out   0BAH       ; Set PIO chip port B configuration
	mvi   A,0FFH     ; PIO A configuration (Used for Key scan, LCD data, etc.)
	out   0B9H       ; Initialize PIO chip port A
	in    0E8H       ; Scan Keyboard to test for CTRL-BREAK (cold boot indicator)
	ANI   82H       ; Mask all but CTRL-BREAK keys
	mvi   A,0EDH     ; Load code to disable key-scan col 9 (for CTRL-BREAK)
	out   0BAH       ; Disable key-scan col 9
	jz    CBOOT     ; Cold boot routine
	lhld  VSSYS     ; Active system signature -- Warm vs Cold boot
	lxi   D,8A4DH   ; Compare value to test if cold boot needed
	rst   3         ; Compare DE and HL
	jnz   CBOOT     ; Cold boot routine
	lda   0FAC1H     ; Load MSB of lowest known RAM address
	mov   D,A       ; Save value of last physical RAM
	call  L7EE1H    ; Calculate physical RAM available
	cmp   D         ; Test if more or less RAM than last boot-up
	jnz   CBOOT     ; Cold boot routine
	call  VOPTRD    ; Call RAM routine to Detect Option ROM (copied to RAM by cold-boot)
	mvi   A,00H     ; Indicate no Option ROM detected
	jnz   L7D75H    ; Jump if it's really true to skip DEC
	dcr   A         ; Indicate OptROM detected
L7D75H	lxi   H,VOPTRF  ; Option ROM flag
	cmp   M         ; Test if option ROM added or removed
	jnz   CBOOT     ; Cold boot routine
	lhld  VSPOPD    ; Load signature for Auto Poweroff
	xchg            ; Put signature in DE
	lxi   H,0000H   ; Prepare to clear signature for Auto Poweroff
	shld  VSPOPD    ; Clear signature for Auto Poweroff
	lxi   H,9C0BH   ; Load comparison signature saved by Auto Poweroff
	rst   3         ; Compare DE and HL
	jnz   L7DA8H    ; Jump if last power-off wasn't an auto power-off
	lhld  0FABEH     ; SP save area for power up/down
	sphl            ; Restore the stack pointer from auto-power off location
	call  VPWONH    ; Call Boot-up Hook
	call  L7DD0H    ; Call to a "hidden" XRA in the boot routine
	lhld  0FFF8H     
	push  H         
	call  L4601H    
	pop   H         
	mov   A,H       
	ana   A         
	jz    L14EDH    ; Pop AF), BC), DE), HL from stack
	sphl            
	jmp   L7435H    
	
L7DA8H	lda   0F651H     ; In TEXT because of BASIC EDIT flag
	ana   A         ; Test if power off during a BASIC edit session
	jz    L7.dbBH    ; Jump if we weren't in a BASIC edit session at power off
	call  L7DD0H    ; Call Boot-up s.equence below, skipping IPL, BASIC NEW, etc.
	call  L5D53H    ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
	call  L4601H    
	jmp   L5FDDH    ; Main TEXT edit loop
	
L7.dbBH	lxi   H,0FAAFH   ; Start of IPL filename
	shld  0F62CH     ; Save as simulated "FKey text" to be entered
	lhld  VTPRAM    ; BASIC string buffer pointer
	sphl            ; Restore the SP
	call  VPWONH    ; Call Boot-up Hook
	call  L3F6DH    ; Initialize BASIC for new execution
	lxi   H,L5797H  ; Load address of the MENU program
	push  H         ; And push it to the stack as a RET address
	ORI   0AFH       ; Hidden entry .. make 0AFH below look like ORI 0AFH
	call  L6CE0H    ; Warm start reset entry
	xra   A         
	sta   VPROFS    ; Power off exit condition switch
	lda   0FF43H     ; RS232 initialization status
	ana   A         ; Test if RS232 was active at power-off
	rz              ; Return if RS-232 was not active
	lxi   H,0F65AH   ; RS232 auto linefeed switch
	rst   2         ; Get next non-white char from M
	cnc   L3457H    ; Increment HL and return
	jmp   L17E6H    ; Set RS232 parameters from string at M
	
	
; ======================================================
; Cold boot routine
; ======================================================
CBOOT	lxi   SP,0F5E6H  ; Load the SP with Cold Boot location
	call  L7EE1H    ; Calculate physical RAM available
	mvi   B,90H     ; Prepare to copy 90H bytes of code to RAM
	lxi   D,VSSYS   ; Active system signature -- Warm vs Cold boot
	lxi   H,L035AH  ; Initialization image loaded to VSSYS
	call  L2542H    ; Move B bytes from M to (DE)
	call  L7EC6H    ; Initialize RST 38H RAM vector table
	mvi   A,0CH     ; Count value for 6-second background timer
	sta   0F930H     ; Initialize 6-second background timer
	mvi   A,64H     ; Count value for 10 minute auto power-off timer
	sta   0F931H     ; Initizliae auto power-down counter
	lxi   H,L5B46H  ; Point to Function key labels for BASIC
	call  STFNK     ; Set new function key table
	call  L6C93H    ; Copy BASIC Function key table to key definition area
	mvi   B,58H     
	lxi   D,L6BF1H  ; ROM programs catalog entries
	lxi   H,0F962H   ; Start of RAM directory
	call  L3469H    ; Move B bytes from (DE) to M with increment
	mvi   B,0D1H     ; Length of RAM directory (19 entries x 11 bytes)
	xra   A         ; Prepare to zero out RAM directory
LZEROB	mov   M,A       ; Zero out next byte of RAM directory
	inx   H         ; Increment to next RAM directory location
	dcr   B         ; Decrement counter
	jnz   LZEROB    ; Loop until all bytes zeroed
	mvi   M,0FFH     
	call  VOPTRD    ; Detect Option ROM
	jnz   L7E43H    
	dcr   A         
	sta   VOPTRF    ; Option ROM flag
	lxi   H,VCATFS   
	mvi   M,0F0H     
	inx   H         
	inx   H         
	inx   H         
	lxi   D,0FAA6H   
	mvi   B,06H     
	call  L3469H    ; Move B bytes from (DE) to M with increment
	mvi   M,20H     
	inx   H         
	mvi   M,00H     
L7E43H	xra   A         
	sta   0F787H     
	sta   0FCA7H     
	call  L1A96H    ; Erase current IPL program
	sta   VPWROF     
	mvi   A,3AH     ; Load ASCII ':'
	sta   0F680H     ; End of statement marker
	lxi   H,0FBD4H   
	shld  0FBD9H     
	shld  VTPRAM    ; BASIC string buffer pointer
	shld  0FB67H     ; File buffer area pointer
	mvi   A,01H     
	sta   0FBB3H     
	call  L7F2BH    ; Adjust SP location based on CLEAR parameters
	call  L3F6DH    ; Initialize BASIC for new execution
	lhld  0FAC0H     ; Lowest RAM address used by system
	xra   A         
	mov   M,A       
	inx   H         
	shld  VBASPP    ; Start of BASIC program pointer
	shld  VBASNS     ; BASIC program not saved pointer
	mov   M,A       ; Initialize BASIC Program ... no program
	inx   H         
	mov   M,A       ; Set MSB of BASIC program to NULL
	inx   H         
	shld  VPSDOF     ; Start of DO files pointer
	shld  VPSTBP     ; Start of Paste Buffer
	mvi   M,1AH     ; Initialize DO file area with EOF marker ... no files
	inx   H         
	shld  VPSCOF     ; Start of CO files pointer
	shld  VPSVAR     ; Start of variable data pointer
	lxi   H,0F999H   
	shld  0FA8CH     ; Mark Unsaved BASIC program as active program
	call  L20FFH    ; NEW statement
	call  L6CD6H    ; Re-initialize system without destroying files
	lxi   H,0000H  
	shld  0F92DH     ; Year (ones)
	lxi   H,L7F01H  ; Initial clock chip register values
	call  L732AH    ; Update clock chip regs from M
	jmp   L5797H    ; MENU Program
	
	
; ======================================================
; Display TRS-80 Model number & Free bytes on LCD
; ======================================================
L7EA6H	lxi   H,L7FA4H  ; TRS-80 model number string
	call  L27B1H    ; Print buffer at M until NULL or '"'
	
; ======================================================
; Display number of free bytes on LCD
; ======================================================
L7EACH	lhld  VPSVAR     ; Start of variable data pointer
	xchg            
	lhld  VTPRAM    ; BASIC string buffer pointer
	mov   A,L       ;
	sub   E         ;
	mov   L,A       ; Calculate difference between BASIC String
	mov   A,H       ; buffer area and Start of Variable data
	sbb   D         ; area. This is the free space.
	mov   H,A       ;
	lxi   B,VCBLKC   ; Load value for (-14)
	dad   B         ; Subtract 14 from reported Free space
	call  L39D4H    ; Print binary number in HL at current position
	lxi   H,L7F98H  ; MENU Text Strings
	jmp   L27B1H    ; Print buffer at M until NULL or '"'
	
	
; ======================================================
; Initialize RST 38H RAM vector table
; ======================================================
L7EC6H	lxi   H,VRST7T  ; Start of RST 38H vector table
	lxi   B,L1D02H  
	lxi   D,L7FF3H  
L7ECFH	mov   M,E       
	inx   H         
	mov   M,D       
	inx   H         
	dcr   B         
	jnz   L7ECFH    
	mvi   B,13H     
	lxi   D,L08DBH  ; Generate FC error
	dcr   C         
	jnz   L7ECFH    
	ret             
	
	
; ======================================================
; Calculate physical RAM available
; ======================================================
L7EE1H	lxi   H,0C000H   ; Ram modules start at High memory (8K chunks)
L7EE4H	mov   A,M       ; Load current value at this address
	cma             ; Compliment the value
	mov   M,A       ; And write it back (non-destructive test)
	cmp   M         ; Compare if the value "took" (i.e. there's RAM there)
	cma             ; Compliment data back to original value
	mov   M,A       ; Save original value (in case there IS RAM there)
	mov   A,H       ; Load MSB of current RAM bank to A
	jnz   L7EF8H    ; Jump if no RAM present in this bank
	inr   L         ; Increment LSB of RAM (test 256 bytes per 8K)
	jnz   L7EE4H    ; Jump to test next byte of this RAM
	SUI   20H       ; Decrement to next lower 8K memory range
	mov   H,A       ; Save the new MSB of this 8K range
	jm    L7EE4H    ; Jump back to test if RAM in this memory range
L7EF8H	mvi   L,00H     ; Clear LSB of lowest RAM address
	Adi   20H       ; Add 8K back to address (we over shot)
	mov   H,A       ; Save MSB of lowest RAM address with RAM in it
	shld  0FAC0H     ; Lowest RAM address used by system
	ret             
	
	
; ======================================================
; Initial clock chip register values
; ======================================================
L7F01H
    .db	00H,00H,00H,00H,00H,00H,01H,00H          
    .db	00H,01H,0CFH,9DH,0CFH,0DDH          
	
	call  L112EH    ; Evaluate expression at M-1
	jnz   ERRSYN    ; Generate Syntax error
	CPI   10H       ; Test if setting MAXFILES to 16 or more
	jnc   L08DBH    ; Generate FC error
	shld  0FB99H     ; Address of last variable assigned
	push  PSW       
	call  L4E22H    ; CLOSE file if it is opened?
	pop   PSW       
	call  L7F2BH    ; Adjust SP location based on CLEAR parameters
	call  L3F2FH    ; Initialize BASIC Variables for new execution
	jmp   BASEXE    ; Execute BASIC program
	
L7F2BH	push  PSW       
	lhld  VHIMEM    ; HIMEM
	lxi   D,0FEF5H   ; Load DE with -267
L7F32H	dad   D         
	dcr   A         
	jp    L7F32H    
	xchg            
	lhld  VTPRAM    ; BASIC string buffer pointer
	mov   B,H       
	mov   C,L       
	lhld  0FB67H     ; File buffer area pointer
	mov   A,L       
	sub   C         
	mov   L,A       
	mov   A,H       
	sbb   B         
	mov   H,A       
	pop   PSW       
	push  H         
	push  PSW       
	lxi   B,L008CH  
	dad   B         
	mov   B,H       
	mov   C,L       
	lhld  VPSVAR     ; Start of variable data pointer
	dad   B         
	rst   3         ; Compare DE and HL
	jnc   L3F17H    ; Reinit BASIC stack and generate OM error
	pop   PSW       
	sta   0FC82H     ; Maxfiles
	mov   L,E       
	mov   H,D       
	shld  0FC83H     ; File number description table pointer
	dcx   H         
	dcx   H         
	shld  0FB67H     ; File buffer area pointer
	pop   B         
	mov   A,L       
	sub   C         
	mov   L,A       
	mov   A,H       
	sbb   B         
	mov   H,A       
	shld  VTPRAM    ; BASIC string buffer pointer
	dcx   H         
	dcx   H         
	pop   B         
	sphl            
	push  B         
	lda   0FC82H     ; Maxfiles
	mov   L,A       
	inr   L         
	mvi   H,00H     
	dad   H         
	dad   D         
	xchg            
	push  D         
	lxi   B,L0109H  
L7F82H	mov   M,E       
	inx   H         
	mov   M,D       
	inx   H         
	xchg            
	mvi   M,00H     
	dad   B         
	xchg            
	dcr   A         
	jp    L7F82H    
	pop   H         
	lxi   B,L0009H  
	dad   B         
	shld  0FC87H     
	ret             
	
	
; ======================================================
; MENU Text Strings
; ======================================================
L7F98H
    .db	" Bytes free",00H
L7FA4H
    .db	"TRS-80 Model 102 Software",0DH,0AH
    .db	"Copr. 1983 Microsoft",0DH,0AH,00H
	
	
; ======================================================
; RST 38H RAM vector driver routine
; ======================================================
L7FD6H	xthl            ; Get PC from stack to read vector byte
	push  PSW       ; Save PSW
	mov   A,M       ; Get the vector number
	sta   VRST7A    ; Offset of last RST 38H call
	pop   PSW       ; Restore PSW
	inx   H         ; Increment PC past vector byte
	xthl            ; Save updated PC (on the stack)
	push  H         ; Save HL
	push  B         ; Save BC
	push  PSW       ; Save PSW
	lxi   H,VRST7T   ; Start of RST 38H vector table
	lda   VRST7A    ; Offset of last RST 38H call
	mov   C,A       ; Copy vector number to C
	mvi   B,00H     ; Zero out B to prepare for DAD
	dad   B         ; Multiply vector * 2 to index into table
	mov   A,M       ; Get LSB of vector address
	inx   H         ; Increment to MSB of vector address
	mov   H,M       ; Get MSB of vector address
	mov   L,A       ; Copy LSB of address to L
	pop   PSW       ; Restore PSW
	pop   B         ; Restore BC
	xthl            ; Restore HL & "PUSH" return address of the RST vector
L7FF3H	ret             ; Return (to the vector address from the table)
	
L7FF4H	call  BFC.dbL    ; C.dbL function
	jmp   L31B5H    ; Move FAC1 to FAC2
	
L7FFAH	lxi   H,0F684H   ; Different from M100
	mvi   M,2CH     ; Different from M100
	ret             ; Different from M100
