.data
SYSEXIT = 1
SYSWRITE = 4
SYSREAD = 3
STDOUT = 1
BUFFLEN = 512
slowo:
    .ascii "Ala ma kota"
slowo_len = .-slowo
slowo_ascii:

.text
.global main
main:
    
    xor %ebx, %ebx
    start_loop:   
        movl %ebx, %edx #wyliczam adresy liter
        add $slowo, %edx
        movl $slowo, %ecx
        add $slowo_len, %ecx
        decl %ecx   #zmniejszam długość o jeden żeby nie brać znaku końca
        subl %ebx, %ecx
        movb (%ecx), %ah #w ecx i edx mam adresy następnie biorę te miejsca w pamięci i je zamieniam
        pushl %eax
        movb (%edx), %ah
        movb %ah, (%ecx)
        popl %eax
        movb %ah, (%edx)
        incl %ebx
        movl $slowo_len, %eax   
        decl %eax #zmniejszam długość o jeden żeby nie brać znaku końca
        movl $2, %ecx
        xor %edx, %edx  #dziele na dwa przy czym muszę mieć puste rejestry edx bo div tak działa
        divl %ecx
        cmp  %ebx, %eax
    jg  start_loop


    movl $slowo_len, %edx   
    movl $SYSWRITE, %eax
    movl $STDOUT, %ebx
    movl $slowo, %ecx
    int $0x80

    movl $SYSEXIT, %eax # exit(0)
    movl $0, %ebx
    int $0x80

ret
