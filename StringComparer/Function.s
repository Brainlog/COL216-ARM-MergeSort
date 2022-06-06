.global fgets,prints,print,in,inin,printin
.global Case1,Case2,compare
.equ SWI_PrChr, 0x00
.equ Stdout, 1
.text


compare:
ldrb r7,[r0]
cmp r7,#0x30
beq Case2
cmp r7,#0x31
beq Case1
mov pc,lr

Case1:
bl inin
load:
ldrb r5,[r0]
ldrb r6,[r2]

loop2:

cmp r5,r1
bge subt1
cmp r6,r1
bge subt2
bl printin
add r0,r0,#1
add r2,r2,#1
b load





subt1: sub r5,r5,#32
      b loop2
subt2: sub r6,r6,#32
      b loop2      



Case2:
bl in
loop:
      ldrb r5,[r0]
      ldrb r6,[r2]
     bl print
	 
      add r0,r0,#1
	  add r2,r2,#1
      bal loop
		  


 
   
   
      


	
	