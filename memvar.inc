#define		MEMVARS

VSSYS              equ 0F5F0H            ; Start of system
VSPOPD             equ 0F5F2H            ; SP on power-down
VHIMEM             equ 0F5F4H            ; HIMEM value
VPWONH             equ 0F5F6H            ; Power on hook
VBCRIH             equ 0F5F9H			 ; BCR interrupt hook
VUARTH             equ 0F5FCH            ; UART DR hook
VTLINH             equ 0F5FFH            ; TL interupt hook
VLPSIH             equ 0F602H            ; LPS interupt hook
VOPTRD             equ 0F605H            ; RAM routine to detect OptROM (Set by SysROM)
VOPTRF             equ 0F62AH            ; Option rom installed
VPPSST             equ 0F62BH            ; 20 or 10 PPS
VCURLN             equ 0F639H            ; LCD Cursor row
VCURCL             equ 0F63AH            ; LCD cursor column
VACTLC             equ 0F63BH            ; LCD active lines
VACTCC             equ 0F63CH            ; LCD active columns
VLABLF             equ 0F63DH            ; Label line flags
VRVIDF             equ 0F648H            ; Reverse video if 1
VXPIXS             equ 0F64EH            ; X-pixel set
VYPIXS             equ 0F64FH            ; Y-pixel set
VPROFS             equ 0F656H            ; Power off switch
VPROFT             equ 0F657H            ; Power off time
VISTAT             equ 0F65BH            ; Initial stat setting
VLPPCL             equ 0F674H            ; LPOS printer column
VOUTSW             equ 0F675H            ; Output 0 = LCD, 1 = LP
VTPRAM             equ 0F678H            ; Top of available ram
VBASPP             equ 0F67CH            ; Start of BASIC program pointer
VKYBBF             equ 0F685H            ; Keyboard Buffer - temp storage
VCRPOS             equ 0F688H            ; POS - Cursor position
VKYLAB             equ 0F689H            ; Key labels
VPSTBF             equ 0F88CH            ; Location of PASTE buffer

M_CLK_TICK         equ 0F92FH            ; The background tick
M_PWROFF_RENEW     equ 0F932H            ; Automatic poweroff renew flag
M_ONTIME_TIME      equ 0F93DH            ; Used for RST7 Hook helper routine
M_BAS_NOTSAVE      equ 0F99AH            ; Pointer to BASIC program not saved
M_PREV_BAUD_S      equ 0F9A8H            ; Storage for previous baud rate settings (in Hayashi in Cat)
M_CAT_1ST_NTRY     equ 0F9BAH            ; Address of 1st available slot in catalog
M_FD_ARRAY         equ 0FA91H            ; Address of FD array
M_ACTIVE_FD        equ 0FAA2H            ; FD number of active BASIC File I/O operation
M_RST7_ARG         equ 0FAC9H            ; Argument of last RST7 operation
M_CO_INFO_ADDR     equ 0FACEH            ; Address of CO header info
M_TAPE_LEN         equ 0FAD0H            ; Length of last program loaded from tape
M_INPUT_PROC       equ 0FAD8H            ; Pointer for RAM input processing ???
M_MAJ_HLP_ADDR     equ 0FAE0H            ; Magic powerup helper address
M_MAJ_HLP_VAL      equ 111DH             ; Magic powerup helper value
M_LFILES_HOOK      equ 0FB2CH            ; Address of LFILES Hook address
M_DO_START         equ 0FBAEH            ; Pointer to start of DO files
M_CO_START         equ 0FBB0H            ; Start of CO files
M_VARS_START       equ 0FBB2H            ; Start of Variables pointer
M_FREE_MEM_PTR     equ 0FBB6H            ; Pointer to free memory
M_BAS_EXEC_FLG     equ 0FC92H            ; Flag to execute BASIC program
M_BASIC_FNAME      equ 0FC93H            ; Filename for current BASIC program
M_BAS_FNAM_EXT     equ 0FC99H            ; Extension location of BASIC filename
M_TAPE_NAME        equ 0FC9CH            ; Filename of last file loaded from tape
M_ALTLCD           equ 0FCC0H            ; ALTLCD address for M100
M_LCDBUF           equ 0FE00H            ; First line of LCD buffer
M_LCDBUF_LINE2     equ 0FE28H            ; Line 2 of the LCD buffer (Files page)
M_SER_BUF_CNT      equ 0FF86H            ; Number of bytes in RS-232 buffer
M_NEW_CONSOLE      equ 0F638H            ; New console device flag

M_CURS_ROW         equ 0F639H            ; Current Cursor ROW
M_CURS_COL         equ 0F63AH            ; Current Cursor COL
M_ACTIVE_ROWS      equ 0F63BH            ; Number of active ROWs
M_CURS_ACTV_ROWS   equ 0F63BH            ; Active ROWS count
M_COLS_COUNT       equ 0F63CH            ; Active columns count
M_LABEL_PROT       equ 0F63DH            ; Label protect line
M_SAVE_ROW         equ 0F640H            ; Cursor row save area
M_ACTIVE_ROW       equ 0F642H
M_DISP_HEIGHT      equ 0F644H            ; Height of display (8, 16 or 25)
M_DISP_WIDTH       equ 0F645H            ; Width of display (40 or 80)
M_KEYSCAN_MOD      equ 0F650H            ; Keyboard scan modifier
M_LONG_JUMP        equ 0F652H            ; Long jump address to return to on error
M_TEXT_CTRL2       equ 0F6E1H            ; Unknown Control location - set to zero
M_SEL_START        equ 0F6E2H            ; Starting address of SEL
M_SEL_END          equ 0F6E4H            ; End address of SEL
M_TEXT_CTRL1       equ 0F6E7H            ; Unknown Control location - 2 bytes
M_TEXT_LINE_START  equ 0F6EBH            ; Line starts array
M_TEXT_CTRL3       equ 0F71FH            ; Unknown Control location - set to zero
M_EDIT_DO          equ 0F767H            ; Address of beginning of .DO file being edited
M_TMP_CURS_SAVE    equ 0F88CH
M_LCD_LPT          equ 0F920H            ; LCD vs LPT output
M_WORD_WRAP        equ 0F921H            ; Word wrap enable flag
M_OUTPUT_WIDTH     equ 0F922H            ; Output width
M_PASTE_BUFFER     equ 0F9A5H            ; Paste buffer pointer storage
M_EXTRA_POP        equ 0FAC7H            ; Indicates if extra POP needed after character plotting

PORT_E8_VAL        equ 0FF45H            ; Contents of PORT E8h
BASIC_HIDEY        equ 0xF96C
RICKY_START        equ 0F9AFH            ; First address of RICKY for Catalog searches
RICKY_STORE        equ 0F9B4H            ; Temporary storage
RICKY_STORE2       equ 0F9B2H            ; Temporary storage
RET_HLPR_ADR       equ 0FAA4H            ; RAM Address of our TS-DOS ROM RETurn Helper

M_RST7_HOOK_BASE   equ 0FADAH            ; Base of RST7 vector table
