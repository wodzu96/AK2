<center><h1>Ciąg Fibonnaciego w konwencji Big Endian</h1></center>

### **1. Polecenie** ###
Oblicz n-ty wyraz ciągu Fibonnaciego w konwencji BIG ENDIAN. Maksymalnie liczba ma się mieścić na 256 bajtach.

### **2. Parametry wejściowe** ##
Aby ustawić nr ciągu fibbonaciego należy edytować parametr NR_FIB w 4 linijce kodu w pliku `zad1.s`.

### **3. Uruchomienie** ##
Aby uruchomić program należy wykonać polecenie `make` w konsoli będąc w ścieżce programu. Następnie należy wykonać polecenie `gdb zad1` i ustawić brake point w linii 54 poleceniem `b 54`. Kolejnym krokiem jest uruchomienie programu za pomocą polecenia `run`. Po wejściu w ustawiony brake point należy wyświetlić wynik korzystając z polecenia `x /256bx & liczba_a`.

### **4. Dodatkowe informacje** ##
Zadanie zostało wykonan. Przyjmuje [takie](https://www.miniwebtool.com/list-of-fibonacci-numbers/?number=100) indeksowanie liczb w ciągu fibonnaciego.
Sposób wykonania został opisany w komentarzach kodu.
