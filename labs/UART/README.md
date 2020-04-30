# UART projekt
## Popis problematiky
### Informace o UART
UART (Universal Asynchronous Receiver Transmitter) je sériové rozhraní pro half-duplexní či fullduplexní komunikaci. Informace se přenáší tzv. datovým paketem(=rámcem), který obsahuje:
* Jeden start bit v log. 0
* 5 až 9 datových bitů pro přenos informace (od LSB k MSB)
* Jeden paritní bit pro detekci chybného bitu 
* Jeden nebo dva STOP bity v log. 1

Defaultně je linka ve vysoké úrovni. Zahájení komunikace je přechod z log. 1 na log. 0 (START bit). Následuje zvolený počet datových bitů, které jsou vysílány od LSB (Least Significant Bit) k MSB (Most Sig. Bit). Poté následuje paritní bit, který je zřízen logickou funkcí XOR na všechny datové bity a může být nastavený na sudou či lichou paritu (logika spočítá počet 1 v datových bitech a porovná, jestli bit parity odpovídá nastavenému druhu parity). Komunikace se ukončuje přechodem na vysokou úroveň. Receiver a transmitter mají "dohodnutý" formát rámce například na 8E1 (8 datových b.; E = even parity (sudá); 1 stop bit). Po příchodu stop bitů může okamžitě znovu následovat další přenos. Rychlost přenosu je dána symbolovou rychlostí (Baud Rate).

### Rozhodnutí k řešení a popis funkce
Aplikace má být schopna měnit paramtry rámce. Bude k dispozici:
* SW15_CPLD - SW8_CPLD : 8 datových bitů
* SW7_CPLD : Log. 0 = 9600 Bd ; Log. 1 = 19200 Bd
* SW1_CPLD : Log. 0 = lichá parita; Log. 1 = sudá parita
* SW0_CPLD : Log. 0 = 1 stop bit; Log. 1 = 2 stop bity
* BTN0     : Log. 0 = reset; log. 1 = neaktivní poloha
* BTN1     : Log. 0 = spuštění procesu; log. 1 = neakt.

Stavový automat bude začínat v IDLE state, kde na lince bude úroveň H. Proces se odstartuje při příchodu kladného pulzu na msg_ce_i po stisknutí tlačítka BTN1 (a ověření stisknutí pomocí Debounce.vhd) a poté se automat "synchronizuje" s jednou ze symbolových rychlostí v závislosti na poloze SW7_CPLD. Dále bude procházet přes stavy viz. OBR.XXX. Aplikace bude mít dva výstupy. Výstup data_o vysílá přímo datový rámec a výstup busy_o indikuje, že stavový automat právě zpracovává datový rámec. 

### Použité moduly
Pro tuto aplikaci byl vytvořen modul debounce.vhd ošetřující případné zákmity fyzického tlačítka (viz. DE2 3.přednáška). Modul kontroluje logickou hodnotu z BTN1 každou 1ms (změněno z 4ms z přednášky, kvůli simulacím). Dále byl vytvořen modul TX_FSM, který funguje jako konečný stavový automat zajišťující formát rámce. Pro modul debounce.vhd byl pro vzorkování použit clock_enable.vhd ze cvičení. Pro každou ze symbolových rychlostí byl použit jeden další clock_enable.vhd, dohromady tedy projekt používá 3x clock_enable.vhd. Použitá HW tlačítka jsou připojena z coolrunner.ucf a cpld_board.ucf.

## Screenshoty 
### Změna druhu parity
Zde je vidět změna ze sudé na lichou paritu pomocí switche. Datové bity zůstávají zachované.
![logic](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/UART/Screenshots/parity_change.PNG)

### Změna log úrovně parity
Při změně jednoho datového bitu se změní hodnota při sudé paritě z 1 na 0
![logic](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/UART/Screenshots/bit_change_parity.PNG)

### Změna Bd rate
Na výběr jsem zvolil rychlost 9600 Bd a 19200 Bd, tedy dvojnásobek. Čas trvání, kdy byl přenos aktivní (busy_o = '1') byl u 9600 Bd roven 1,144 ms a u 19200 Bd trvala aktivita 0,572 ms. 
![logic](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/UART/Screenshots/Bd_rate.PNG)

### 1 nebo 2 stop bity
Pomocí SW0_CPLD lze zvolit mezi jedním nebo dvěma stop bity, délka rámce se automaticky prodlouží. Na obrázku jsou identické datové bity a zapnutá lichá parita (pro lepší rozpoznání stop bitů jsem chtěl paritu v 0), mění se pouze počet stop bitů.
![logic](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/UART/Screenshots/stopbity.PNG)

### Reset button
V případě vlevo je zřejmé, že reset zastaví funkci debounce.vhd, přenos tedy neproběhne vůbec. Vpravo pak reset přijde chvíli po začátku odesílání rámce, přičemž se přenos zastaví a na výstupu je defaultní hodnota ve vysoké úrovni.
![logic](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/UART/Screenshots/reset.PNG)

### Funkce debounceru
Na tomto obrázku je vidět funkce debounceru. S určitou samplovací periodou (zde 10ms) snímá modul hladinu na btn_i. Pokud rozpozná, že hodnota je dostatečně dlouho v log.0 (=tlačítko je stisknuté), odešle kladný pulz. Nastaven je výraz ve 4bitovém vektoru na hodnotu "1000"
![logic](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/UART/Screenshots/debounce_pulse.PNG)

## Nákres stavového automatu

## Odkazy na zdrojové soubory
* [TX_FSM.vhd](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/UART/files/TX_FSM.vhd)
* [top.vhd](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/UART/files/top.vhd)
* [Debounce.vhd](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/UART/files/Debounce.vhd)
* [clock_enable.vhd](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/UART/files/clock_enable.vhd)
* [tb_top00.vhd](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/UART/files/tb_top00.vhd)
* [tb_debounce1.vhd](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/UART/files/tb_debounce1.vhd)

## Zdroje
* [*VHDL state machine*](https://www.allaboutcircuits.com/technical-articles/implementing-a-finite-state-machine-in-vhdl/)
* [*FSM design*](https://www.youtube.com/watch?v=SwilSD9JdiQ&list=PLZv8x7uxq5XY-IQfQFb6mC6OXzz0h8ceF&index=19)
* [*Buffer filling*](https://stackoverflow.com/questions/33130066/vhdl-multiple-std-logic-vector-to-one-large-std-logic-vector)
* Přednášky DE2 (zejména 3. a 7.)
