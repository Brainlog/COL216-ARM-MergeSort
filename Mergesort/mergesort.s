.global mergesort,mainspace,tempStack,manage,merge

.text
mergesort:
# r10 contains [0,0,length,[4,1,2,3]]
# r13 is stack
str lr,[r10,#100]
mov r0,#0
stmfd sp!,{r0}
ldr r9,=tempStack
add r9,r9,#1000
ldr r2,[r10,#8] @length
mov r1,#0 @ initial index
mov r0,r2 @final index
stmfd sp!,{r0,r1,r2}
ldr r4,[sp,#8]
cmp r4,#1
bleq merge1
bl mergesort1


mergesort1:
 
    @ ldr r3,[sp,#4]
    @ ldr r4,[sp,#12]
    @ cmp r3,r4
    @ bleq reto

    @ ldr r0,[sp,#4]
    @ ldr r1,[sp,#20]
    @ cmp r0,r1
    @ blgt mergeSortshift1


    stmfd sp!,{lr}

    ldr r0,[sp,#4]
    ldr r1,[sp,#8]
    ldr r2,[sp,#12]


    mov r2,r2,asr #1
    mov r1,r1
    add r0,r1,r2
    stmfd sp!,{r0,r1,r2}

    str r2,[r10,#36]
    cmp r2,#1
    bleq merge1
    ldr r2,[r10,#36]
    cmp r2,#1
    blgt mergesort1
  
    ldr r4,[sp,#12]

    @ cmp r4,#1
    @ bleq merge1 

  
    ldr r0,[sp,#4] @#final index
    ldr r1,[sp,#8] @#initial index
    mov r1,r0 @#shift initial index
    ldr r0,[sp,#20] @#final index 2
    str r1,[sp,#8]
    str r0,[sp,#4]
    sub r5,r0,r1
    str r5,[sp,#12]
    cmp r5,#0
    bllt end2
    cmp r5,#1
    blgt mergeSortshift1
    cmp r5,#1
    bleq merge1shift
    cmp r5,#0  
    bleq pop1andmerge  
    ldmfd sp!,{r0}
    ldmfd sp!,{r1}
    ldmfd sp!,{r1}
    ldmfd sp!,{r1}
    cmp r0,#0
    bleq end2
    mov pc,r0
end2:
    ldr r0,[r10,#100]
    bl output   


mergeSortshift1:
    ldr r2,[sp,#12]
    mov r2,r2,asr #1
    ldr r1,[sp,#8]
    add r0,r1,r2
    stmfd sp!,{r0,r1,r2}
    str r2,[r10,#36]
    cmp r2,#1
    bleq merge1
    ldr r2,[r10,#36]
    cmp r2,#1
    blgt mergesort1
    ldr r4,[sp,#12]
  
    ldr r0,[sp,#4] @#final index
    ldr r1,[sp,#8] @#initial index
    mov r1,r0 @#shift initial index
    ldr r0,[sp,#20] @#final index 2
    str r1,[sp,#8]  
    str r0,[sp,#4]
    sub r5,r0,r1
    str r5,[sp,#12]
    cmp r5,#1
    blgt mergeSortshift1
    cmp r5,#1
    bleq merge1shift
    cmp r5,#0  
    bleq pop1andmerge  
    ldmfd sp!,{r0}
    ldmfd sp!,{r1}
    ldmfd sp!,{r1}
    ldmfd sp!,{r1}
    cmp r0,#0
    bleq end2
    mov pc,r0   

merge1:
    ldr r3,[sp,#8]
    ldr r4,[sp,#16]
    cmp r3,r4
    bleq reto
    
    @ blge merge1shift
    stmfd sp!,{lr}
   
    bl takeAddress
    ldr r0,[sp,#4] @#final index
    ldr r1,[sp,#8] @#initial index
    mov r1,r0 @#shift initial index
    ldr r0,[sp,#20] @#final index 2
    str r1,[sp,#8]
    str r0,[sp,#4]
    sub r5,r0,r1
    str r5,[sp,#12]
    cmp r5,#1
    blgt mergeSortshift1
    cmp r5,#1
    bleq merge1shift
    cmp r5,#0  
    bleq pop1andmerge  
    ldmfd sp!,{r0}
    ldmfd sp!,{r1}
    ldmfd sp!,{r1}
    ldmfd sp!,{r1}
    cmp r0,#0
    bleq end2
    mov pc,r0


merge1shift:
    @ ldr r0,[sp,#8]
    @ ldr r1,[sp,#24]
    @ cmp r0,r1
    @ blge chk
    bl takeAddress
    ldr r0,[sp,#4] @#final index
    ldr r1,[sp,#8] @#initial index
    mov r1,r0 @#shift initial index
    ldr r0,[sp,#20] @#final index 2
    str r1,[sp,#8]
    str r0,[sp,#4]
    sub r5,r0,r1
    str r5,[sp,#12]
    cmp r5,#1
    bleq mergeSortshift1
    cmp r5,#1
    bleq merge1shift
    cmp r5,#0  
    bleq pop1andmerge  

    ldmfd sp!,{r0}
    ldmfd sp!,{r1}
    ldmfd sp!,{r1}
    ldmfd sp!,{r1}
    cmp r0,#0
    bleq end2
    mov pc,r0
    



takeAddress:
    mov r4,lr
    mov r3,#0
    ldr r1,[sp,#8]
    ldr r2,[r10,#12]
loop:
    cmp r3,r1
    bleq fit    
    add r2,r2,#4
    add r3,r3,#1
    b loop
fit:
    sub r9,r9,#4
    str r2,[r9]
    sub r9,r9,#4
    mov r1,#1  
    str r1,[r9]
    mov pc,r4

reto: 
    ldr r0,[r9]
    bl end

pop1andmerge:
    @ ldr r3,[sp,#16]
    @ cmp r3,#0
    mov r4,lr                   @ used
    ldr r0,[r9] @#size           @ used  @ r10,r9,r0,r1,r2,r3,r4 used
    ldr r1,[r9,#4] @#pointer    @ used
    ldr r2,[r9,#8] @#size2      @ used
    ldr r3,[r9,#12] @#pointer2 @ used
    ldr r5,=manage
    str r4,[r5,#28]    @linker
    ldr r12,[sp,#16]
    cmp r12,#0
    bleq end1
    str r0,[r5,#4] @size2
    str r1,[r5,#8] @pointer2
    str r2,[r5,#12] @size
    str r3,[r5,#16] @pointer
    str r9,[r5,#20] @tempStack
    str r10,[r5,#24] @mainList
    bl merge
    ldr r4,[r5,#28]    @linker
    ldr r0,[r5,#4] @size
    ldr r1,[r5,#8] @pointer
    ldr r6,[r5,#12] @size2
    ldr r3,[r5,#16] @pointer2
    ldr r9,[r5,#20] @tempStack
    ldr r10,[r5,#24] @mainList
    add r0,r0,r6
    @store result in r2
    mov r1,#0
    str r1,[r9]
    str r1,[r9,#4]
    str r1,[r9,#8]
    str r1,[r9,#12]
    add r9,r9,#12
    str r12,[r9]
    sub r9,r9,#4
    str r0,[r9]
    mov pc,r4
@ chk:
@     ldr r1,[sp,#8]
@     cmp r1,#1
@     bleq merge1shift
@     bl mergesort1

linkremo:
    ldmfd sp!,{r0}
    mov pc,lr

end1:
    ldr r4,[r5,#28]
    mov pc,r4    

end: 
 swi 0x11


    
    
.data 
mainspace : .space 30000
tempStack : .space 2000
manage: .space 10000

