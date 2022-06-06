.global fgets,prints,in,inask,printin,print,inin
.equ SWI_PrChr, 0x00
.equ Stdout, 1
.text

inask: 

ldr r0,=messagein
mov r2,lr
bl prints
mov lr,r2
cmn r0,r1
ldr r0,=m3
mov r1,#2
mov r2,#0
mov r3,lr
bl fgets
mov lr,r3
cmn r1,r1
mov pc,lr


inin:
ldr r0, = message5
mov r2,lr
bl prints
mov lr,r2
cmn r1,r1
ldr r0,=m1
mov r1,#100
mov r2,#0
mov r3,lr
bl fgets
mov lr,r3
cmn r1,r1
mov r6,r0
ldr r0,=m2
mov r2,#100
mov r2,#0
mov r3,lr
bl fgets
mov lr,r3
cmn r1,r1
mov r7,r0
mov r0,r6
mov r2,r7
mov r8,#0
mov r9,#13
mov r1,#97
mov pc,lr

printin:

cmp r5,r6
bgt print2
blt print3

cmp r5,r8
beq print1
mov pc,lr


      



in:
ldr r0, =message5
mov r2,lr
bl prints
mov lr,r2
cmn r1,r1
ldr r0,=m1
mov r1,#100
mov r2,#0
mov r3,lr
bl fgets
mov lr,r3
cmn r1,r1
mov r6,r0
ldr r0,=m2
mov r1,#100
mov r2,#0
mov r3,lr
bl fgets
mov lr,r3
cmn r1,r1
mov r7,r0
mov r0,r6
mov r2,r7
mov r8,#0
mov r9,#13
mov pc,lr

     
print:
       cmp r5,r6
	  bgt print2
	  cmp r5,r6
	  blt print3
      cmp r5,r8
      beq print1
	  cmp r5,r9
	  beq print1
      mov pc,lr
      
	 
   
		  
print1: 
   ldr r0,=message1
   
   bl prints
   cmn r1,r1
   bal close
   
print2:
   ldr r0,=message2
   bl prints
   cmn r1,r1
   
   bal close
   
print3:
   ldr r0,=message3

   
   bl prints
   cmn r1,r1
   bal close
   
close:
 ldr r0,=my2word
 bl prints
 cmn r1,r1
 mov r0,#0x18
 swi 0x123456

 
   
   
      


.data

my2word: .asciz "Thanks\n"
outu: .skip 4
message1: .asciz "They are Equal\n"
outski1: .skip 4
message2: .asciz "1st word is larger\n"
outski2: .skip 4
message3: .asciz "2nd word is larger\n"
outski3: .skip 4
messagein: .asciz "For Case-Sensitive type 0, For Case Insensitive type 1:--\n"
outski4: .skip 4
message5:  .asciz "Give the two strings you want to compare--\n"
outski5: .skip 4
m1: .space 400
outski6: .skip 4
m2: .space 400
outski7: .skip 4
m3: .space 4
outski8: .skip 4

.end
	
	