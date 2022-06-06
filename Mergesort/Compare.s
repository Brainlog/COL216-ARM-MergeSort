.align 4
.global compare,comparein
.text

@r4,r6 --> iterators, r5 --> list, r7,r8 --> pointers

compare:
    mov r1,lr    @r3,r9 are empty  r3 -- > address of list2 , r9 --> address of list1
    ldr r3,[r7]
    ldr r9,[r8]
    @ r10, r11 are also empty
    ldr r10,[r5,#4]
    cmp r4,r10
    bleq secempchkfir
    ldr r10,[r5,#12]
    cmp r6,r10
    bleq firempchksec
    b compstar

compstar:  @r10,r11 use for chking characters
    ldrb r10,[r3]
    ldrb r11,[r9]
    cmp r10,#0
    bleq seccharempchkfir
    cmp r11,#0
    bleq fircharempchksec   
    cmp r10,r11
    blgt seccharbig
    bllt fircharbig
    add r3,r3,#1
    add r9,r9,#1
    bal compstar
firempchksec:
    ldr r10,[r5,#4]
    cmp r4,r10
    bleq empty
    bl oneempty
secempchkfir:
    ldr r10,[r5,#12]
    cmp r6,r10
    bleq empty
    bl secondempty

fircharbig:
mov r0,#1
mov pc,r1

seccharbig:
mov r0,#2
mov pc,r1

oneempty :
mov r0,#3
mov pc,r1

secondempty :
mov r0,#4
mov pc,r1

empty :
mov r0,#5
mov pc,r1

fircharempchksec:
cmp r10,#0
bleq eql
mov r0,#2
mov pc,r1

seccharempchkfir:
cmp r11,#0
bleq eql
mov r0,#1
mov pc,r1

eql:
mov r0,#0
mov pc,r1


comparein:
    mov r1,lr    @r3,r9 are empty  r3 -- > address of list2 , r9 --> address of list1
    ldr r3,[r7]
    ldr r9,[r8]
    @ r10, r11 are also empty
    ldr r10,[r5,#4]
    cmp r4,r10
    bleq secempchkfir
    ldr r10,[r5,#12]
    cmp r6,r10
    bleq firempchksec
    b compstarin

compstarin:  @r10,r11 use for chking characters
    ldrb r10,[r3]
    ldrb r11,[r9]
    cmp r10,#97
    blge sub1
    cmp r11,#97
    blge sub2
    cmp r10,#0
    bleq seccharempchkfir
    cmp r11,#0
    bleq fircharempchksec   
    cmp r10,r11
    blgt seccharbig
    bllt fircharbig
    add r3,r3,#1
    add r9,r9,#1
    bal compstarin

 sub1: 
    sub r10,r10,#32
    mov pc,lr
    

 sub2:    
    sub r11,r11,#32
    mov pc,lr