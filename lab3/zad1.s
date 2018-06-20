.data
 
.text
# Zadeklarowane tutaj funkcje będą możliwe do wykorzystania
# w języku C po zlinkowaniu plików wynikowych kompilacji obu kodów
.global my_cpuid
.type my_cpuid, @function
 

my_cpuid:
    # Odłożenie rejestru bazowego na stos i skopiwanie obecnej
    # wartości wskaźnika stosu do rejestru bazowego
    push %rbp
    mov %rsp, %rbp
    
    sub $4, %rsp   #rezerwowanie miejsa w pamięci dla zmiennej lokalnej
    xor %eax, %eax
    movl %eax, -4(%rbp)     # zerowanie zmiennej lokalnej
 
    # Parametry wywołania funkcji umieszczone zostaną
    # w rejestach RDI

    mov %rdi, %rax
    cmp $0, %rdi
    je jeden
    jmp else
    zero:
        rdtsc      
        movl -4(%rbp), %ecx     
        incl %ecx
        movl %ecx, -4(%rbp)
        cmp $10, %ecx
        jl zero
        jmp koniec
    jeden:
        xor %eax, %eax
        cpuid
        rdtsc
     jmp koniec
    
    else:
        rdtscp
    

    koniec:
     shl $32, %rdx
     or %rdx, %rax

    # Przywrócenie poprzedniej wartości rejestru bazowego
    # i wskaźnika stosu
    mov %rbp, %rsp
    pop %rbp
ret # Powrót do miejsca wywołania funkcji
