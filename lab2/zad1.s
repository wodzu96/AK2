# x /256bx & liczba_a
.data
SYSEXIT = 0
NR_FIB = 199

.section .bss
.comm liczba_a, 256
.comm liczba_b, 256
.text
.global main
main:
    
    movb $1, %al
    movl $255, %ecx
    movb %al, liczba_b(%ecx)


    #w pojedynczej iteracji dodaje do siebie a do b i b do a jeżeli nr_fib jest parzysty wyświetlam jako wynik a jeżeli nr jest nieparzysty wyświetlam b. 
    movl $NR_FIB, %eax  
    xor %edx, %edx #czyszcze edx przed dzieleniem   
    incl %eax 
    movl $2, %ebx
    divl %ebx
    pushl %edx   #wkładam na stos resztę z dzielenia PAMIETAJ ZE WCZESNIEJ ZWIEKSZYLES EAX WIEC PARZYSTOSC JEST ODWROTNA
    pushl %eax

    poczatek_fib:
         
        movl $liczba_a, %eax    #dodaje a do b
        movl $liczba_b, %ebx
        call dodawanie_eax_do_ebx

        movl $liczba_a, %ebx        #dodaje b do a
        movl $liczba_b, %eax
        call dodawanie_eax_do_ebx 

        popl %edx
        decl %edx
        pushl %edx
        cmp $0, %edx
        jg poczatek_fib

        popl %edx
        popl %edx       #sprawdzam parzystość w celu skopiowania
        xor %eax, %eax
        cmp %eax, %edx
        jne koniec_ifa
            movl $liczba_a, %ebx        #kopiuje b do a
            movl $liczba_b, %eax
            call kopiowanie_eax_do_ebx 
        koniec_ifa:
      

    movl $SYSEXIT, %eax # exit(0)
    movl $0, %ebx
    int $0x80
ret


.type dodawanie_eax_do_ebx, @function
dodawanie_eax_do_ebx:
    movl $255, %edx
    addl $255, %eax     #przesuwam wskazniki na koniec pamiec
    addl $255, %ebx
    movb (%eax), %cl
    movb (%ebx), %ch
    addb %cl, %ch
    pushf
    movb %ch, (%ebx)
    poczatek_petli:
        decl %edx
        decl %eax
        decl %ebx
        movb (%eax), %cl
        movb (%ebx), %ch
        popf
        adcb %cl, %ch
        pushf
        movb %ch, (%ebx)
        cmp $0, %edx
        jg poczatek_petli
    popf
    
ret
.type kopiowanie_eax_do_ebx, @function
kopiowanie_eax_do_ebx:
    movl $255, %edx
    addl $255, %eax     #przesuwam wskazniki na koniec pamiec
    addl $255, %ebx
    poczatek_petli1:       
        movb (%eax), %cl
        movb %cl, (%ebx)
        decl %edx
        decl %eax
        decl %ebx
        cmp $0, %edx
        jge poczatek_petli1
    
ret
