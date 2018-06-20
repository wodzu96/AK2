<center><h1>Wywołanie kodu ASM z funkcji napisanej w C</h1></center>

### **1. Polecenie** ###
Uruchom kod assemblerowy z poziom języka C. Napisz w ASM odpowiednik pseudokodu: 
```c
if(arg == 0){ 
    for(int i = 0; i<10; i++){    
    rdtsc
    }
}
if(arg == 1){
    xor %eax, %eax
    cpuid
    rdtsc
}
else
    rdtscp
````

### **2. Parametry wejściowe** ##
Aby ustawić argument funkcji należy edytować stałą ARG w pliku `zad1.c`.

### **3. Uruchomienie** ##
Aby uruchomić program należy wykonać polecenie `make` , a następnie `./zad1`.

### **4. Dodatkowe informacje** ##
Zadanie zostało wykonane i ocenione na zajęciach.
