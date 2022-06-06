.global output

.text

output:
mov r0,#1
ldr r1,=printii
swi 0x69
ldr r6,[r9,#4]
mov r2,#0
mov r4,#0
mov r12,#0
loop:
ldr r11,[r6]
cmp r2,r11
beq printu
ldr r3,[r6]
mov r1,r3
mov r0,#1
swi 0x69
add r6,r6,#4
ldr r11,[r6]
cmp r2,r11
bleq noncomma
add r4,r4,#1
mov r0,#1
ldr r1,=com
swi 0x69
b loop

noncomma:

 b loop

printu:
 mov r0,#1
 ldr r1,=msg
 swi 0x69
 mov r0,#1
 add r4,r4,#1
 mov r1,r4
 swi 0x6b
 

close :
 swi 0x11

.data 
 com : .asciz ","
 msg : .asciz "\nThe length of sorted list is : "
 printii : .asciz "The Sorted List is : "





