#define	MEMVARS

VSSYS   equ 0F5F0H            ; Start of system
VSPOPD  equ 0F5F2H            ; SP on power-down
VHIMEM  equ 0F5F4H            ; HIMEM value
VPWONH  equ 0F5F6H            ; Power on hook
VBCRIH  equ 0F5F9H	      ; BCR interrupt hook
VUARTH  equ 0F5FCH            ; UART DR hook
VTLINH  equ 0F5FFH            ; TL interupt hook
VLPSIH  equ 0F602H            ; LPS interupt hook
VOPTRD  equ 0F605H            ; RAM routine to detect OptROM (Set by SysROM)
VOPTRF  equ 0F62AH            ; Option rom installed
VPPSST  equ 0F62BH            ; 20 or 10 PPS
VCURLN  equ 0F639H            ; LCD Cursor row
VCURCL  equ 0F63AH            ; LCD cursor column
VACTLC  equ 0F63BH            ; LCD active lines
VACTCC  equ 0F63CH            ; LCD active columns
VLABLF  equ 0F63DH            ; Label line flags
VCLNSA  equ 0F640H            ; Cursor row save area
VRVIDF  equ 0F648H            ; Reverse video if 1
VXPIXS  equ 0F64EH            ; X-pixel set
VYPIXS  equ 0F64FH            ; Y-pixel set
VKYSCM  equ 0F650H            ; Keyboard scan modifier
VLJERR  equ 0F652H            ; Long jump address to return to on error
VPROFS  equ 0F656H            ; Power off switch
VPROFT  equ 0F657H            ; Power off time
VISTAT  equ 0F65BH            ; Initial stat setting
VLPPCL  equ 0F674H            ; LPOS printer column
VOUTSW  equ 0F675H            ; Output 0 = LCD, 1 = LP
VTPRAM  equ 0F678H            ; Top of available ram
VBASPP  equ 0F67CH            ; Start of BASIC program pointer
VBSCLN  equ 0F67AH            ; Current executing line number
VKYBBF  equ 0F685H            ; Keyboard Buffer - temp storage
VCRPOS  equ 0F688H            ; POS - Cursor position
VKYLAB  equ 0F689H            ; Key labels
VSASEL  equ 0F6E2H            ; Starting address of SEL
VEASEL  equ 0F6E4H            ; End address of SEL
VTMPHL  equ 0F6E7H            ; Temp HL Storage
VTXTLS  equ 0F6EBH            ; Line starts array
VTCTR3  equ 0F71FH            ; Unknown Control location - set to zero
VDOEDI  equ 0F767H            ; Address of beginning of .DO file being edited
VPSTBF  equ 0F88CH            ; Location of PASTE buffer
VLCLPS  equ 0F920H            ; LCD vs LPT output
VWWRAP  equ 0F921H            ; Word wrap enable flag
VOWIDT  equ 0F922H            ; Output width
VCLKTK  equ 0F92FH            ; The background tick
VPWROF  equ 0F932H            ; Automatic poweroff renew flag
VONTMT  equ 0F93DH            ; Used for RST7 Hook helper routine
VBASNS  equ 0F99AH            ; Pointer to BASIC program not saved
VPSTBF  equ 0F9A5H            ; Paste buffer pointer storage
VPRVBR  equ 0F9A8H            ; Storage for previous baud rate settings (in Hayashi in Cat) !NOT USED
VCATFS  equ 0F9BAH            ; Address of 1st available slot in catalog
VFDARR  equ 0FA91H            ; Address of FD array
VFDAIO  equ 0FAA2H            ; FD number of active BASIC File I/O operation
VXPOPF  equ 0FAC7H            ; Indicates if extra POP needed after character plotting

VRST7A  equ 0FAC9H            ; Argument of last RST7 operation
VADCOH  equ 0FACEH            ; Address of CO header info
VTPLEN  equ 0FAD0H            ; Length of last program loaded from tape
VPRINP  equ 0FAD8H            ; Pointer for RAM input processing ???
VAPWRU  equ 0FAE0H            ; Magic powerup helper address !NOT USED
VALFIL  equ 0FB2CH            ; Address of LFILES Hook address !NOT USED
VPSDOF  equ 0FBAEH            ; Pointer to start of DO files
VPSCOF  equ 0FBB0H            ; Start of CO files
VPSVAR  equ 0FBB2H            ; Start of Variables pointer
VPFREM  equ 0FBB6H            ; Pointer to free memory
VBASEF  equ 0FC92H            ; Flag to execute BASIC program
VFNCBP  equ 0FC93H            ; Filename for current BASIC program
VFNCBE  equ 0FC99H            ; Extension location of BASIC filename
VFNLFT  equ 0FC9CH            ; Filename of last file loaded from tape
VAALCD  equ 0FCC0H            ; ALTLCD address for M100
VL1LCD  equ 0FE00H            ; First line of LCD buffer
VL2LCD  equ 0FE28H            ; Line 2 of the LCD buffer (Files page) !NOT USED
VNB232  equ 0FF86H            ; Number of bytes in RS-232 buffer
VNCONF  equ 0F638H            ; New console device flag
VPRTE8  equ 0FF45H            ; Contents of PORT E8h
VSRCKY  equ 0F9AFH            ; First address of RICKY for Catalog searches
VARETH  equ 0FAA4H            ; RAM Address of our TS-DOS ROM RETurn Helper
VRST7T  equ 0FADAH            ; Base of RST7 vector table

VFB98H  equ 0FB98H            ; !unknown var
VPCURL  equ 0FB9BH            ; Most recent or currenly running line pointer
VBASRF  equ 0FBA7H            ; BASIC Program Running Flag
VARRTP  equ 0FBB4H            ; Start of array table pointer
VADATS  equ 0FBB8H            ; Address where DATA search will begin next

VVC1SD  equ 0FC18H            ; Start of FAC1 for single and double precision
VFAC1I  equ 0FC1AH            ; Start of FAC1 for integers

VACRBP  equ 0FFECH            ; Cursor bit pattern storage
VCBLKC  equ 0FFF2H            ; Address of Cursor blink counter
VPCRBC  equ 0FFF3H            ; pointer to cursor blink count-down
VFFF4H  equ 0FFF4H            ; !unknown var