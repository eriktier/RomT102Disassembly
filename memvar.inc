
VSSYS  .const 0F5F0H            ; Start of system
VSPOPD .const 0F5F2H            ; SP on power-down
VHIMEM .const 0F5F4H            ; HIMEM value
VPWONH .const 0F5F6H            ; Power on hook
VBCRIH .const 0F5F9H	          ; BCR interrupt hook
VUARTH .const 0F5FCH            ; UART DR hook
VTLINH .const 0F5FFH            ; TL interupt hook
VLPSIH .const 0F602H            ; LPS interupt hook
VOPTRD .const 0F605H            ; RAM routine to detect OptROM (Set by SysROM)
VOPTRF .const 0F62AH            ; Option rom installed
VPPSST .const 0F62BH            ; 20 or 10 PPS
VCURLN .const 0F639H            ; LCD Cursor row
VCURCL .const 0F63AH            ; LCD cursor column
VACTLC .const 0F63BH            ; LCD active lines
VACTCC .const 0F63CH            ; LCD active columns
VLABLF .const 0F63DH            ; Label line flags
VCLNSA .const 0F640H            ; Cursor row save area
VRVIDF .const 0F648H            ; Reverse video if 1
VXPIXS .const 0F64EH            ; X-pixel set
VYPIXS .const 0F64FH            ; Y-pixel set
VKYSCM .const 0F650H            ; Keyboard scan modifier
VLJERR .const 0F652H            ; Long jump address to return to on error
VPROFS .const 0F656H            ; Power off switch
VPROFT .const 0F657H            ; Power off time
VISTAT .const 0F65BH            ; Initial stat setting
VLPPCL .const 0F674H            ; LPOS printer column
VOUTSW .const 0F675H            ; Output 0 .const LCD, 1 .const LP
VTPRAM .const 0F678H            ; Top of available ram
VBASPP .const 0F67CH            ; Start of BASIC program pointer
VBSCLN .const 0F67AH            ; Current executing line number
VKYBBF .const 0F685H            ; Keyboard Buffer - temp storage
VCRPOS .const 0F688H            ; POS - Cursor position
VKYLAB .const 0F689H            ; Key labels
VSASEL .const 0F6E2H            ; Starting address of SEL
VEASEL .const 0F6E4H            ; End address of SEL
VTMPHL .const 0F6E7H            ; Temp HL Storage
VTXTLS .const 0F6EBH            ; Line starts array
VTCTR3 .const 0F71FH            ; Unknown Control location - set to zero
VDOEDI .const 0F767H            ; Address of beginning of .DO file being edited
VPSTBF .const 0F88CH            ; End of RAM for file storage
VLCLPS .const 0F920H            ; LCD vs LPT output
VWWRAP .const 0F921H            ; Word wrap enable flag
VOWIDT .const 0F922H            ; Output width
VCLKTK .const 0F92FH            ; The background tick
VPWROF .const 0F932H            ; Automatic poweroff renew flag
VONTMT .const 0F93DH            ; Used for RST7 Hook helper routine
VBASNS .const 0F99AH            ; Pointer to BASIC program not saved
VPSTBP .const 0F9A5H            ; Paste buffer pointer storage
VPRVBR .const 0F9A8H            ; Storage for previous baud rate settings (in Hayashi in Cat) !NOT USED
VCATFS .const 0F9BAH            ; Address of 1st available slot in catalog
VFDARR .const 0FA91H            ; Address of FD array
VFDAIO .const 0FAA2H            ; FD number of active BASIC File I/O operation
VXPOPF .const 0FAC7H            ; Indicates if extra POP needed after character plotting

VRST7A .const 0FAC9H            ; Argument of last RST7 operation
VADCOH .const 0FACEH            ; Address of CO header info
VTPLEN .const 0FAD0H            ; Length of last program loaded from tape
VPRINP .const 0FAD8H            ; Pointer for RAM input processing ???
VAPWRU .const 0FAE0H            ; Magic powerup helper address !NOT USED
VALFIL .const 0FB2CH            ; Address of LFILES Hook address !NOT USED
VPSDOF .const 0FBAEH            ; Pointer to start of DO files
VPSCOF .const 0FBB0H            ; Start of CO files
VPSVAR .const 0FBB2H            ; Start of Variables pointer
VPFREM .const 0FBB6H            ; Pointer to free memory
VBASEF .const 0FC92H            ; Flag to execute BASIC program
VFNCBP .const 0FC93H            ; Filename for current BASIC program
VFNCBE .const 0FC99H            ; Extension location of BASIC filename
VFNLFT .const 0FC9CH            ; Filename of last file loaded from tape
VAALCD .const 0FCC0H            ; ALTLCD address for M100
VL1LCD .const 0FE00H            ; First line of LCD buffer
VL2LCD .const 0FE28H            ; Line 2 of the LCD buffer (Files page) !NOT USED
VNB232 .const 0FF86H            ; Number of bytes in RS-232 buffer
VNCONF .const 0F638H            ; New console device flag
VPRTE8 .const 0FF45H            ; Contents of PORT E8h
VSRCKY .const 0F9AFH            ; First address of RICKY for Catalog searches
VARETH .const 0FAA4H            ; RAM Address of our TS-DOS ROM RETurn Helper
VRST7T .const 0FADAH            ; Base of RST7 vector table

VFB98H .const 0FB98H            ; !unknown var
VPCURL .const 0FB9BH            ; Most recent or currenly running line pointer
VBASRF .const 0FBA7H            ; BASIC Program Running Flag
VARRTP .const 0FBB4H            ; Start of array table pointer
VADATS .const 0FBB8H            ; Address where DATA search will begin next

VVC1SD .const 0FC18H            ; Start of FAC1 for single and double precision
VFAC1I .const 0FC1AH            ; Start of FAC1 for integers

VACRBP .const 0FFECH            ; Cursor bit pattern storage
VCBLKC .const 0FFF2H            ; Address of Cursor blink counter
VPCRBC .const 0FFF3H            ; pointer to cursor blink count-down
VFFF4H .const 0FFF4H            ; !unknown var