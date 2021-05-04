# Projekt-DE1-3

**Co to musí umět?**

*- Alespoň 2 tlačítka (jedno, které bude potřeba, druhé jako rezerva pro další funkce)*

*- Rychlost, ujetá vzdálenost (průměrnou a maximální rychlost)*

*- Průměr kola (Z presetů)*

# Projekt-DE1 - 3. zadání
## Konzole pro rotoped/kolo s LCD displejem

### Členové týmu

- Hrubešová Diana
- Hrubý Jan
- Hykš Matěj
- Hynšt Boris

[Link na náš Github](https://github.com/mrhyks/Projekt-DE1-3)

### Cíle projektu

Cílem projektu je vytvořit konzoli pro rotoped či kolo s hallovou sondou. Pro zobrazování výstupu jako je 
rychlost, průměrná rychlost a ujetá vzdálenost jsme zvolili LCD displej.

**Jednotlivé body projektu:**

**- Dvě tlačítka:**
*   Prvním tlačítkem (btn0) se dá vybrat nastavení poloměru kola a mód zobrazení displeje. Mód 0 - Nastavení velikosti kola; Mód 1 - Zobrazení rychlosti; Mód 2 - Zobrazení průměrné rychlosti; Mód 3 - Zobrazení ujeté vzdálenosti
*   Druhým tlačítkem (btn1) se dá vybrat poloměr kola, kdy kolo se dá vybrat jen v případě, že je vybraný mód 0
                
**- "Reset tlačítko"**
*   V případě, že uživatel chce resetovat data a začít znovu (neresetuje se nastavený mód a kola) stačí držet obě tlačítka po dobu dvou a více sekund, resetuje se ujetá vzdálenost a průměrná rychlost.
               
**- Výstup** 
*   Výstup změřené a vypočítané rychlosti, průměrné rychlosti a vzdálenosti získané pomocí hallovy sondy do LCD displeje. Pro překlad binarního výstupu by byl zapotřebí externí výpočetní modul, jako je např. arduino. Funkce tohoto modulu je popsána v sekci **Popis Hardwaru**  

**- Možnost volby průměru kola**


## Popis Hardwaru

Jako vývojovou desku jsme vybrali Arty A7 35. 

Pro zobrazování výstupu by jsme použili Pmod CLP (Revision B) module. Funkci modulu jsme popsali pouze teoreticky, protože se nám nepodařilo
vytvořit překlad binárního výstupu do ASCII ve VHDL, který je potřeba pro zobrazování.  

**Funkce Pmod CLP (Revision B) module**

V top vrstvě bude napojen modul s rozhraními: 3x 32 bit binary a 2x 2 bit binary. Ty následně budou napojeny na výpočetní modul (například Arduino) jež bude obsahovat program psaný například v C# a ten bude mít za úkol dosazení hodnot přijatých jednotlivými interfacy do daných struktur pro módy 1 - 4, následně je přeložit do binární abecedy pro jednotlivé znaky dle tabulky, která je přiložena v dokumentaci tohoto LCD char displaye, následně je podle vlastního časovače bude dle námi nastaveného času odesílat na display spolu s předcházejícím příkazem clear na jednotlivé porty, jejichž popsání a zapojení je také psáno v dokumentaci a tím dojde k vypsání zprávy na obrazovku.

Dejme tomu, že jedeme na kole a právě jsme ujeli 12.5 km:

V takové situaci modul pro řízení char LCD displaye příjme z z portu mode dvoubitovou zprávu určující aktuálně zvolený mode, z toho ví, že jej zajímají informace, přicházející na rozhraní, do něhož je zapojen modul "calculations.distance" a získá 32 bitovou binární informaci, která vyjadřuje 1250 (ujetá vzdálenost je počítána v desítkách metrů => 1250 * 10 = 12500 metrů = 12.5 km). Takže ví, že použije preset pro mode 3 => dosadí do modu: 

řádek 1: mode => Distance + (prázdné znaky)

řádek 2: No.mode => 3. + (prázdný znak) + přijaté hodnoty přepočítané na kilometry => 12.5 + (prázdný znak) + jednotka (km) + (prázdné znaky)

Ty následně převede dle tabulky z dokumentace na binární kód, který zašle na jednotlivé porty char LCD displaye spolu s předcházenícím clear display příkazem, podle námi nastaveného času pro refresh rate.
Příklad takové zprávy zasílané na display pro ujetou vzdálenost 12,5 km

```
clear: RS --> 0 RW --> 0 + D0 - D7 --> 1000 0000
first line:  0010 0010(D)|1001 0110(i)|1100 1110(s)|0010 1110(t)|1000 0110(a)|0111 0110(n)|
             1100 0110(c)|1010 0110(e)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|
             0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|
second line: 1100 1100(3)|0111 0100(.)|0000 0100(blank)|1000 1100(1)|0100 1100(2)|0111 0100(.)|
             1010 1100(5)|0000 0100(blank)|0000 0100(blank)|1101 0010(K)|1011 1010(m)|0000 0100(blank)|
             0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)| 
```
tabulka pro náš LCD modul:

## Popis a simulace modulů VHDL

### buttons.vhd

#### 

####

####

### calculations.vhd 

#### 

####

####


## TOP module description and simulations

Write your text here.


## Video

*Write your text here*


## References

   1. Write your text here.