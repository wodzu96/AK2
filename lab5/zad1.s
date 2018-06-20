.bss
.comm begin, 4
.comm end, 4
.comm dx, 14
.comm begins 16
.comm result 16

.data
init_x: .float 1,2,3,4
zeros: .float 0,0,0,0 #wektor [0,0,0,0]
twos: .float 2, 2, 2, 2 #wektor [2,2,2,2]
fours: .float 4,4,4,4 # wektor [4,4,4,4]
four: .float 4

.text
.global calka_sse
.type calka_sse, @function
.type f, @function

calka_sse:

pushq %rbp              #ramka stosu
movq %rsp, %rbp


movss %xmm0, begin # pobranie 1 argumentu
movss %xmm1, end   # pobranie 2 argumentu
cvtsi2ss %rdi, %xmm0  # pobranie 3 argumentu

# najpierw obliczamy szerokosc prostokotów

subss begin, %xmm1 # wyznaczenie dlugosci obszaru calkowania
divss %xmm0, %xmm1 # wyliczam szerokosc prostokatu  wynik zachowuje w %xmm1

#rozszerzamy pojedynczą wartosc dx na cztery pozycje
# w celu przyspieszenia obliczen

movq $0, %rsi
INIT_DX:
        movss %xmm1, dx(,%rsi,4) #kopiowanie na kolejna pozycje
        inc %rsi
        cmp $4, %rsi
        je STEP_2 #skocz jesli wartosci sa rowne
        jmp INIT_DX
STEP_2:
        movups dx, %xmm1        #wektor w rejestrze

#tworze wektory begins i iters w celu wyznaczenia punktów w
# których bede mógłwyliczyć wysokość

mov $0, %rsi
movss begin, %xmm2
INIT_VECTORS:
                movss %xmm2, begins(,%rsi,4) # kopiujemy begin na kolejne pozycje

                inc %rsi
                cmp $4, %rsi
                je STEP_3
                jmp INIT_VECTORS

STEP_3: # wrzucam wektory od razu do rejestrów do obliczen

        movups begins, %xmm2
        movups init_x, %xmm3

shrq $2, %rdi
movups zeros, %xmm0
MAIN_LOOP:
        call make_x #wyznacza wektor punktow

        movups fours, %xmm6 #wczytanie wektora czworek
        addps %xmm6, %xmm3   #kolejne iteratory

        addps %xmm4, %xmm0 #dodanie  wynic f(vec) do sum

        dec %rdi
        cmp $0, %rdi
        je END
        jmp MAIN_LOOP

        END:


        movq $0, %rsi
        mulps %xmm1, %xmm0 # n*dx
        movups twos, %xmm6
        mulps %xmm6, %xmm0 # 2*n*dx
        movups %xmm0, result
        movups zeros, %xmm0 #wyzerowanie
        GET_SUM:

        addss result(,%rsi,4), %xmm0
        inc %rsi
     cmp $4, %rsi
        je FINAL_RESULT
        jmp GET_SUM
#97
        FINAL_RESULT:
        movss four, %xmm6 #2*n*dx 
        addss %xmm6, %xmm0
        # w tym miejscu w xmm0 znajduje sie wynik calki
        # koncze dzialanie funkcji
        leave
        ret

        make_x:
        pushq %rbp
        movq %rsp, %rbp

        movups zeros, %xmm4
        addps %xmm3,  % xmm4 #n
        mulps %xmm1, %xmm4 # n*dx
        addps %xmm2, %xmm4 #n*dx + xp


        leave
        ret

