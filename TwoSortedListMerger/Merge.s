.global merge,compare,compareIn,output,comp1,comp2
.text


merge:
ldr r0,=listout
str r0,[r10,#24]
ldr r0,=listconstant
mov r1,#0
str r1,[r0]
mov r1,#1
str r1,[r0,#4]
mov r1,#2
str r1,[r0,#8]
mov r1,#3
str r1,[r0,#12]
mov r1,#4
str r1,[r0,#16]
mov r1,#5
str r1,[r0,#20]


str r0,[r10,#28]
ldr r9,[r10,#16]
ldr r11,[r10,#20]
ldr r12,[r10,#24]
ldr r8,[r10,#0]
cmp r8,#0
beq mergeSens
cmp r8,#1
beq mergeInsens

mergeSens:
ldr r8,[r10,#4]
cmp r8,#0
beq mergeSensNo
cmp r8,#1
beq mergeSensYes

mergeInsens:
ldr r8,[r10,#4]
cmp r8,#0
beq mergeInsensNo
cmp r8,#1
beq mergeInsensYes





mergeSensYes:
bl comp1
ldr r1,[r10,#28]
ldr r1,[r1]
cmp r0,r1
bleq equalstr
ldr r1,[r10,#28]
ldr r1,[r1,#4]
cmp r0,r1
bleq firststrbig
ldr r1,[r10,#28]
ldr r1,[r1,#8]
cmp r0,r1
bleq secondstrbig
ldr r1,[r10,#28]
ldr r1,[r1,#12]
cmp r0,r1
bleq firstempty
ldr r1,[r10,#28]
ldr r1,[r1,#16]
cmp r0,r1
bleq secondempty
ldr r1,[r10,#28]
ldr r1,[r1,#20]
cmp r0,r1
bleq bothempty
b mergeSensYes

equalstr:
str r9,[r12]
add r9,r9,#4
add r11,r11,#4
add r12,r12,#4
mov pc,lr

firststrbig:
str r11,[r12]
add r12,r12,#4
add r11,r11,#4
mov pc,lr

secondstrbig:
str r9,[r12]
add r12,r12,#4
add r9,r9,#4
mov pc,lr

firstempty:
str r11,[r12]
add r12,r12,#4
add r11,r11,#4
mov pc,lr

secondempty:
str r9,[r12]
add r12,r12,#4
add r9,r9,#4
mov pc,lr

bothempty:
bl output


mergeSensNo:
bl comp1
ldr r1,[r10,#28]
ldr r1,[r1]
cmp r0,r1
bleq equalstrNo
ldr r1,[r10,#28]
ldr r1,[r1,#4]
cmp r0,r1
bleq firststrbig
ldr r1,[r10,#28]
ldr r1,[r1,#8]
cmp r0,r1
bleq secondstrbig
ldr r1,[r10,#28]
ldr r1,[r1,#12]
cmp r0,r1
bleq firstempty
ldr r1,[r10,#28]
ldr r1,[r1,#16]
cmp r0,r1
bleq secondempty
ldr r1,[r10,#28]
ldr r1,[r1,#20]
cmp r0,r1
bleq bothempty
b mergeSensNo

equalstrNo:
str r9,[r12]
add r12,r12,#4
str r11,[r12]
add r9,r9,#4
add r11,r11,#4
add r12,r12,#4
mov pc,lr



mergeInsensYes:
bl comp2
ldr r1,[r10,#28]
ldr r1,[r1]
cmp r0,r1
bleq equalstr
ldr r1,[r10,#28]
ldr r1,[r1,#4]
cmp r0,r1
bleq firststrbig
ldr r1,[r10,#28]
ldr r1,[r1,#8]
cmp r0,r1
bleq secondstrbig
ldr r1,[r10,#28]
ldr r1,[r1,#12]
cmp r0,r1
bleq firstempty
ldr r1,[r10,#28]
ldr r1,[r1,#16]
cmp r0,r1
bleq secondempty
ldr r1,[r10,#28]
ldr r1,[r1,#20]
cmp r0,r1
bleq bothempty
b mergeInsensYes



mergeInsensNo:
bl comp2
ldr r1,[r10,#28]
ldr r1,[r1]
cmp r0,r1
bleq equalstrNo
ldr r1,[r10,#28]
ldr r1,[r1,#4]
cmp r0,r1
bleq firststrbig
ldr r1,[r10,#28]
ldr r1,[r1,#8]
cmp r0,r1
bleq secondstrbig
ldr r1,[r10,#28]
ldr r1,[r1,#12]
cmp r0,r1
bleq firstempty
ldr r1,[r10,#28]
ldr r1,[r1,#16]
cmp r0,r1
bleq secondempty
ldr r1,[r10,#28]
ldr r1,[r1,#20]
cmp r0,r1
bleq bothempty
b mergeInsensNo




.data
listconstant : .space 100
listout : .space 3000



