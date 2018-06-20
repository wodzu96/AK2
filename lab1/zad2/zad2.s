.data
SYSEXIT = 1
SYSWRITE = 4
SYSREAD = 3
STDOUT = 1
BUFFLEN = 512
slowo:
    .ascii "Ala mA kOtA \n"
slowo_len = .-slowo
slowo_ascii:

.text
.global main
main:
    
    xor %ebx, %ebx
    start_loop:   
        movl %ebx, %edx #wyliczam adresy liter
        add $slowo, %edx
        movb (%edx), %ah #w rejestrze ah mam kod litery
        cmp $91, %ah
        jg koniec_ifa   #sprawdzam czy jest w przedziale dużych liter jak nie to przeskakuje do konca ifa
        cmp $64, %ah
        jle koniec_ifa
        addb $32, %ah   #dodaje róznice miedzy dużą a małą literą
        movb %ah, (%edx)
        koniec_ifa:
        incl %ebx
        movl $slowo_len, %eax   
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
