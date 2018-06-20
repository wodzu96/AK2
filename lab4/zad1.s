.bss
# zmienne funkcji calka
.comm suma, 4
.comm dx1, 4


# zmienne funkcji f
.comm x, 4

# zmienne funkcji make_x
.comm xp, 4
.comm n, 4
.comm dx, 4

#zmienna do przetransportowania wyniku
.comm result, 4
.comm temp, 4
.comm myresult, 4
.comm sumresult, 4


.data
two: .long 2
four: .long 4
pocz: .float 1.0   ##początek przedziału
kon: .float 2.0     #koniec przedzialu 
prec1 = 2000       #ilosc petli - precyzja
prec: .int prec1

SYSEXIT = 0
format_f: .asciz "%f",  # wywoływania funkcji scanf i printf

.text

.global main

.type calka, @function
.type f, @function
.type make_x, @function

main:
      


#liczenie dx = (kon-pocz)/prec

        flds kon        
        fsub pocz      #(kon - pocz)
        fidiv prec      #((kon - pocz)/prec
        fstps dx1       #pobranie wyliczonego przedzialu




        fldz    #zero do st(0) tutaj przechowuje sume wszystkich wysokosci
        fstps sumresult

        mov $prec1, %rdi  #przesuwam precyzje do rdi, którą będę dekrementował
        
        PETLA:
                movss pocz, %xmm0      #pierwszy argument dla make_x
                    #drugi argument jest w %rdi
                movss dx1, %xmm1        #trzeci argument

                call make_x

                # w %xmm0 jest wynik make_x i jest od razu pierwszym
                # argumentem f(x)

                call f

                # w %xmm0 jest teraz wysokosc jednego z prostokatow
                # teraz wystarczy dodac %xmm0 do sumy wszystkiego co jest w st(0)

                movss %xmm0, myresult
                flds sumresult

                fadd myresult     #dodanie na szczyt stosu wysokosci prostokata
                fstps sumresult
        

                dec %rdi        #dekrementuje licznik
                cmp $0, %rdi    #jesli 0 to konczymy prace
                jle END
                jmp PETLA

        END:    
                
                flds sumresult #w st(0) jest wysokosc wszystkich prostokatow
                #pomnoze teraz to wszystko przez szerokosc
                fmul dx1
                fstps myresult    #wynik calkowania
                movss myresult, %xmm0

     cvtps2pd %xmm0, %xmm0
    #
    # Wyświetlenie wyniku z użyciem funkcji printf
    #
    mov $1, %rax # Przesyłamy jeden parametr zmiennoprzecinkowy
                 # - liczbę do wyświetlenia (w rejestrze XMM0)
    mov $format_f, %rdi # Pierwszy parametr typu całkowitego
                        # - format w jakim wyświetlona ma zostać liczba
    sub $8, %rsp # Workaround, aby printf nie zmienił wartości
                 # ostatniej komórki na stosie. Jest to potrzebne tylko
                 # przy wyświetlaniu liczb zmiennoprzecinkowych.
                 # Wskaźnik na stos należy przesunąć o wielokrotność
                 # liczby 8 równą ilości parametrów ZP (8*RAX).
    call printf  # Wywołanie funkcji printf
    add $8, %rsp # Workaround -||-

               
     movl $SYSEXIT, %eax # exit(0)
     movl $0, %ebx
     int $0x80
               
     ret




#oblicza x który będzie słóżyć do obliczenia wartości funkcji
# %xmm0 - dolna granica calkowania      
# %rdi  - numer prostokata              
# %xmm1 - szerokosc prostokata          
# wynik zwraca w %xmm0                  



make_x:
        xor %rsi, %rsi
        pushq %rbp      #ramka stosu
        movq %rsp, %rbp

        # pobranie argumentow
        movq %rdi, n(,%rsi,4)
        movss %xmm0, xp
        movss %xmm1, dx

        fild n       # n
        fmul dx # n*dx
        fadd xp # xp + i*dx

        fstps result
        movss result, %xmm0     #pobranie wyniku

        movq %rbp, %rsp         #porzadkowanie stosu
        popq %rbp
        ret




# wylicza wartosc funkcji w danym punkcie       
# wynik zwraca w %xmm0                          
# argument przyjmuje z %xmm0                    

f:
        pushq %rbp
        movq %rsp, %rbp

        movss %xmm0, x  # pobranie argumentu


        flds x
        fimul two

        # w st(0) mam 2*x
        #od st(0) odejmuje st(1)

        fiadd four       #dodaje czworke
        fstps result    #pobranie wyniku
        fstps temp      #czyszcze stos ze smieci pozostawionych przez funkcje

        movss result, %xmm0     #wynik do %xmm0

        movq %rbp, %rsp
        popq %rbp
        ret
