.global output

.text

output:
ldr r9,[r10,#24]
mov r2,#0
loop:
ldr r6,[r9]
cmp r2,r6
beq close
ldr r3,[r9]
ldr r1,[r3]
mov r0,#1
swi 0x69
add r9,r9,#4
ldr r6,[r9]
cmp r2,r6
bleq noncomma
mov r0,#1
ldr r1,=com
swi 0x69
b loop



noncomma:
b loop

close :
swi 0x11

.data 
com : .asciz ","





