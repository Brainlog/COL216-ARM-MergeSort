.global merge
.equ Stdout,1
.equ Stdin,0

.text
_Start:
@Creating a main list to store (Case)(Duplicate-Option)(Length1)(Length2)(AddressPointer1)(AddressPointer2)
ldr r10,=maina
@ Asking for Case Sensitive or Insensitive
mov r0,#Stdout @For Printing
ldr r1,=print1 @For Printing
swi 0x69
mov r0,#Stdin @For Asking Input
swi 0x6c
str r0,[r10,#0] @Storing the value at r0(0 or 1) at the address stored by r10

@ Asking for Duplicate Option
mov r0,#1 @For Printing
ldr r1,=print2 @For Printing
swi 0x69
mov r0,#0
swi 0x6c
str r0,[r10,#4] @Storing the value at r0(0 or 1) at the address stored by r10 + (8bytes)


@ Asking for Length of First String List
mov r0,#1 @For Printing
ldr r1,=print3 @For Printing
swi 0x69
mov r0,#0
swi 0x6c
str r0,[r10,#8] @Storing the value at r0(length of First String List) at the address stored by r10 + (16 bytes)

@Asking for length of Second String List 
mov r0,#1 @For Printing
ldr r1,=print4 @For Printing
swi 0x69
mov r0,#0
swi 0x6c
str r0,[r10,#12] @Storing the value at r0(length of Second String List) at the address stores by r10 + (24 bytes)


@Moving the List of Address Pointers to Main List at 5th and 6th position
ldr r1,=listadd01 @Storing Address in r1
str r1,[r10,#16] @Storing the Address to Main List at 5th position
ldr r1,=listadd02 @Storing Address in r1
str r1,[r10,#20] @Storing thr Address to Main List at 6th position

@ Status :[Case Opt, Duplicate Opt, Length 1, Length 2, St Pointer 1, St Pointer 2] <-- Main

@Taking First List as Input
mov r0,#1 @For Printing
ldr r1,=print5 @For Printing
swi 0x69

@Needed Address List Pointers
@r5 will take first Pointer
ldr r5,[r10,#16] @r5 will have address of Address List (and will iterate over it)
@Load Address for String
ldr r1,=liststr01

list01 :
mov r4,#0
ldr r6,[r10,#8]

takestring01 : 
add r1,r1,#1
str r1,[r5]  @ Store the address of String at address stored in r5
mov r0,#0
mov r2,#100 
swi 0x6a 
add r4,r4,#1
add r5,r5,#4

chkstring01 :
cmp r4,r6 @r4 = Counter when equal to value of r6 i.e is length then stop
beq list2
ldrb r3,[r1]
cmp r3,#0
beq takestring01
add r1,r1,#1
bal chkstring01

list2:
mov r0,#1
ldr r1,=print6
swi 0x69

@Needed Address List Pointers
@r5 will take first Pointer
ldr r5,[r10,#20] @r5 will have address of Address List (and will iterate over it)
@Load Address for String
ldr r1,=liststr02

mov r4,#0
ldr r6,[r10,#12]

takestring02 : 
add r1,r1,#4
str r1,[r5]  @ Store the address of String at address stored in r5
mov r0,#0
mov r2,#100 
swi 0x6a 
add r4,r4,#1
add r5,r5,#4

chkstring02 :
cmp r4,r6 @r4 = Counter when equal to value of r6 i.e is length then stop
bleq merge 
ldrb r3,[r1]
cmp r3,#0
beq takestring02
add r1,r1,#1
bal chkstring02











.data 
print1 : .asciz "Press 0 for Case Sensitive Merging and 1 for Insensitive Merging : "
print2 : .asciz "Press 0 for Keeping Duplicate Option and 1 for Not Keeping Duplicate Option : "
print3 : .asciz "Enter the length of String of List 1 : "
print4 : .asciz "Enter the length of String of List 2 : "
print5 : .asciz "Enter the First List of String :\n"
print6 : .asciz "Enter the Second List of String :\n"
maina : .space 100
liststr01 : .space 102400 @ For First String
liststr02 : .space 102400 @ For Second String
listadd01 : .space 1000   @ For First String Address
listadd02 : .space 1000   @ For Second String Address


