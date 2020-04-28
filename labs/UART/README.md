# UART projekt
## Popis problematiky
### Informace o UART
UART (Universal Asynchronous Receiver Transmitter) je sériové rozhraní pro half-duplexní či fullduplexní komunikaci. Informace se přenáší tzv. datovým paketem(=rámcem), který obsahuje:
* Jeden start bit v log. 0
* 5 až 9 datových bitů pro přenos informace (od LSB k MSB)
* Jeden paritní bit pro detekci chybného bitu 
* Jeden nebo dva STOP bity v log. 1

Defaultně je linka ve vysoké úrovni. Zahájení komunikace je přechod z log. 1 na log. 0 (START bit). Následuje zvolený počet datových bitů, které jsou vysílány od LSB (Least Significant Bit) k MSB (Most Sig. Bit). Poté následuje paritní bit, který je zřízen logickou funkcí XOR na všechny datové bity a může být nastavený na sudou či lichou paritu (logika spočítá počet 1 v datových bitech a porovná, jestli bit parity odpovídá nastavenému druhu parity). Komunikace se ukončuje přechodem na vysokou úroveň. Receiver a transmitter mají "dohodnutý" formát rámce například na 8E1 (8 datových b.; E = even parity (sudá); 1 stop bit). Po příchodu stop bitů může okamžitě znovu následovat další přenos. Rychlost přenosu je dána symbolovou rychlostí (Baud Rate).

### Zadání a rozhodnutí k řešení 
Aplikace má být schopna měnit paramtry rámce. Bude k dispozici:
* SW15_CPLD - SW8_CPLD : 8 datových bitů
* SW7_CPLD : Log. 0 = 9600 Bd ; Log. 1 = 19200 Bd
* SW1_CPLD : Log. 0 = lichá parita; Log. 1 = sudá parita
* SW0_CPLD : Log. 0 = 1 stop bit; Log. 1 = 2 stop bity

Stavový automat bude začínat v IDLE state, kde na lince bude úroveň H. Proces se odstartuje při příchodu kladného pulzu na msg_ce_i a poté se automat "synchronizuje" s jednou ze symbolových rychlostí v závislosti na poloze SW7_CPLD. Dále bude procházet přes stavy viz. OBR.XXX. Aplikace bude mít dva výstupy. Výstup data_o vysílá přímo datový rámec a výstup busy_o indikuje, že stavový automat právě zpracovává datový rámec. 
