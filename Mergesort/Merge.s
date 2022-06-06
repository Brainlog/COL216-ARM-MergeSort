.global merge,compare,comparein
.text


merge:
    str lr,[r5]
    @ ldr r2,=outdata            @ out in r2: [_,_,_,_,_,#16,_,_,_,_] 
    ldr r2,[r10,#60]
    mov r12,r2
    ldr r11,[r10]
    cmp r11,#0
    beq mergeSens
    cmp r11,#1
     beq mergeInsens
     cmp r11,#1
     bgt errorCase
    
mergeSens:
    ldr r11,[r10,#4]
    cmp r11,#0
    beq mergeSensYes
    cmp r11,#1
    beq mergeSensNo
    cmp r11,#1
    bgt errordup
 mergeInsens:
    ldr r11,[r10,#4]!
   cmp r11,#0
   beq mergeInsensYes
    cmp r11,#1
    beq mergeInsensNo
    cmp r11,#1
    bgt errordup

mergeSensYes:
    mov r4,#0 @iterator1   ->r5[linker,size2,pointer2,size,pointer,tempStack,MainList]
    mov r6,#0 @iterator2
    ldr r7,[r5,#8] @pointers to the list1
    ldr r8,[r5,#16] @pointers to the list2
    @store result in r2
    @temp stack store ->pointer[address1,address2...]
loop1:   @r4,r6,r5 used, also r7,r8,r2 used
    bl compare 
    @give result in r0
    cmp r0,#0
    bleq equalstr
    cmp r0,#1
    bleq long1
    cmp r0,#2
    bleq long2   
    cmp r0,#3
    bleq empfir
    cmp r0,#4
    bleq empsec
    cmp r0,#5
    bleq end                                                                     
    b loop1


mergeSensNo:
    mov r4,#0 @iterator1   ->r5[linker,size2,pointer2,size,pointer,tempStack,MainList]
    mov r6,#0 @iterator2
    ldr r7,[r5,#8] @pointers to the list1
    ldr r8,[r5,#16] @pointers to the list2
    @store result in r2
    @temp stack store ->pointer[address1,address2...]
loop2:   @r4,r6,r5 used, also r7,r8,r2 used
    bl compare 
    @give result in r0
    cmp r0,#0
    bleq equalstrdup
    cmp r0,#1
    bleq long1
    cmp r0,#2
    bleq long2   
    cmp r0,#3
    bleq empfir
    cmp r0,#4
    bleq empsec
    cmp r0,#5
    bleq end                                                                     
    b loop2

equalstrdup:
    ldr r1,[r7]
    str r1,[r2]
    add r2,r2,#4
    str r1,[r2]
    add r7,r7,#4
    add r8,r8,#4
    add r2,r2,#4
    add r4,r4,#1
    add r6,r6,#1
    mov pc,lr

equalstr:
    ldr r1,[r7]
    str r1,[r2]
    add r7,r7,#4
    add r8,r8,#4
    add r2,r2,#4
    add r4,r4,#1
    add r6,r6,#1
    mov pc,lr
long1:
    ldr r1,[r7]
    str r1,[r2]
    add r2,r2,#4
    add r7,r7,#4
    add r4,r4,#1
    mov pc,lr 
long2:
    ldr r1,[r8]
    str r1,[r2]
    add r2,r2,#4
    add r8,r8,#4
    add r6,r6,#1
    mov pc,lr       
empfir:
    ldr r1,[r7]
    str r1,[r2]
    add r2,r2,#4
    add r7,r7,#4
    add r4,r4,#1
    ldr r1,[r5,#4]
    cmp r4,r1
    beq end
    b empfir
empsec:
    ldr r1,[r8]
    str r1,[r2]
    add r2,r2,#4
    add r8,r8,#4
    add r6,r6,#1
    ldr r1,[r5,#12]
    cmp r6,r1
    beq end
    b empsec 
end:
    add r2,r2,#16
    ldr r10,[r5,#24]
    str r2,[r10,#60]
    ldr r4,[r5]
    mov pc,r4

    

mergeInsensYes:
    mov r4,#0 @iterator1   ->r5[linker,size2,pointer2,size,pointer,tempStack,MainList]
    mov r6,#0 @iterator2
    ldr r7,[r5,#8] @pointers to the list1
    ldr r8,[r5,#16] @pointers to the list2
    @store result in r2
    @temp stack store ->pointer[address1,address2...]
loop3:   @r4,r6,r5 used, also r7,r8,r2 used
    bl comparein
    @give result in r0
    cmp r0,#0
    bleq equalstr
    cmp r0,#1
    bleq long1
    cmp r0,#2
    bleq long2   
    cmp r0,#3
    bleq empfir
    cmp r0,#4
    bleq empsec
    cmp r0,#5
    bleq end                                                                     
    b loop3


mergeInsensNo:
mov r4,#0 @iterator1   ->r5[linker,size2,pointer2,size,pointer,tempStack,MainList]
    mov r6,#0 @iterator2
    ldr r7,[r5,#8] @pointers to the list1
    ldr r8,[r5,#16] @pointers to the list2
    @store result in r2
    @temp stack store ->pointer[address1,address2...]
loop4:   @r4,r6,r5 used, also r7,r8,r2 used
    bl comparein
    @give result in r0
    cmp r0,#0
    bleq equalstrdup
    cmp r0,#1
    bleq long1
    cmp r0,#2
    bleq long2   
    cmp r0,#3
    bleq empfir
    cmp r0,#4
    bleq empsec
    cmp r0,#5
    bleq end                                                                     
    b loop4 


errorCase:
 mov r0,#1
 ldr r1,=cas
 swi 0x69
 swi 0x11

errordup:
 mov r0,#1
 ldr r1,=dup
 swi 0x69
 swi 0x11
            
.data

dup : .asciz "Duplicate Option should only be 0 or 1"
cas : .asciz "Case Option should only be 0 or 1"
