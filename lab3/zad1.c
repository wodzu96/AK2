#include <stdio.h>

int const ARG = 0;
 
// Deklaracja funkcji które dołączone zostaną
// do programu dopiero na etapie linkowania kodu
extern long long unsigned my_cpuid(int arg);
 
 
int main(void)
{
    // Wywołanie funkcji Asemblerowej
    long long unsigned  t = my_cpuid(ARG);
    int x = 0;
    t = my_cpuid(ARG)-t;
 
    // Wyświetlenie wyniku
    printf("Wynik: %llu\n", t);
 
    // Zwrot wartości EXIT_SUCCESS na wyjściu programu
    return 0;
}
