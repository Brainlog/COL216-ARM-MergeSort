.global compare,compareIn,comp1,comp2
.text
@ r3,r4 will are two temporary iterators
comp1:
mov r2,lr
ldr r3,[r9]
ldr r4,[r11]

mov r0,#0
cmp r3,r0
bleq chk1
cmp r4,r0
bleq chk2
b compare

comp2:
mov r2,lr
ldr r3,[r9]
ldr r4,[r11]

mov r0,#0
cmp r3,r0
bleq chk1
cmp r4,r0
bleq chk2
b compstar

compare :
ldrb r5,[r3]
ldrb r6,[r4]
cmp r5,r0
bleq chkab1
cmp r6,r0
bleq chkab2
cmp r5,r6
blgt reto
bllt reti
add r3,r3,#1
add r4,r4,#1
bal compare

eql :
mov r0,#0
mov pc,r2

reto:
mov r0,#1
mov pc,r2

reti:
mov r0,#2
mov pc,r2

chk1 :
cmp r4,r0
bleq empty
bl oneempty

chk2 :
cmp r3,r0
bleq empty
bl twoempty

oneempty :
mov r0,#3
mov pc,r2

twoempty :
mov r0,#4
mov pc,r2

empty :
mov r0,#5
mov pc,r2

chkab1 :
cmp r6,r0
bleq eql
mov pc,lr

chkab2 :
cmp r5,r0
bleq eql
mov pc,lr


@ Insensitive

compstar:
mov r0,#0
cmp r3,r0
bleq chk1
cmp r4,r0
bleq chk2
mov r1,#97
compareIn :
ldrb r5,[r3]
ldrb r6,[r4]

cmp r5,r1
blge change1
cmp r6,r1
blge change2

cmp r5,r0
bleq chkab1
cmp r6,r0
bleq chkab2
cmp r5,r6
blgt reto
bllt reti
add r3,r3,#1
add r4,r4,#1
bal compareIn



change1 :
sub r5,r5,#32
mov pc,lr

change2 :
sub r6,r6,#32
mov pc,lr




