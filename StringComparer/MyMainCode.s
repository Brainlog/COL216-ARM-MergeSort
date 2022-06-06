.global fgets,prints,compare
.equ SWI_PrChr, 0x00
.equ Stdout, 1
.text

_Start: 

bl inask
bl compare


.end
	
	