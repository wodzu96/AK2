#include <inttypes.h>
#include <math.h>
#include <stdio.h>
#include <sys/time.h>



int const ARG = 0;
 
// Deklaracja funkcji które dołączone zostaną
// do programu dopiero na etapie linkowania kodu
extern float calka_sse(float a, float b, int n);
extern float calka_classic(float a, float b, int n);

long long current_timestamp() {
    struct timeval te; 
    gettimeofday(&te, NULL); // get current time
    long long milliseconds =  te.tv_usec; // calculate milliseconds
    // printf("milliseconds: %lld\n", milliseconds);
    return milliseconds;
}
 
int main(void)
{
    long long start = current_timestamp();
// Wywołanie funkcji Asemblerowej
    float t1 = calka_sse(1,2,20000);
    long long stop = current_timestamp();
    long long diff_sse = stop - start;
    start = current_timestamp();
    // Wywołanie funkcji Asemblerowej
    float t = calka_classic(1,2,20000);
    stop = current_timestamp();
    long long diff_classic = stop - start;
    // Wyświetlenie wyniku
    printf("Diff classic: %llu, wynik: %f\n", diff_classic, t);
     printf("Diff sse: %llu wynik: %f\n", diff_sse, t1);
    // Zwrot wartości EXIT_SUCCESS na wyjściu programu
    return 0;
}
