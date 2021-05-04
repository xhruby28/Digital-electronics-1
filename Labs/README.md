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
Tabulka pro náš LCD modul:
![ASCII table](Images/pmodclp_predefinedcharacters.png)

## Popis a simulace modulů VHDL

### Blokové schéma finální aplikace
![Block diagram](Images/Diagram.jpg)

### Modul `buttons.vhd`

Modul slouží jako sjednocení bloků `mode.vhd`, `wheel.vhd` a `reset.vhd`. Do modulu jsou přivedeny signáli z tlačítek (btn0 a btn1) a signál z hodin (clk).

Z obrázku simulace lze vidět, že při módu (s_MODE) jiným než 0 se nedá měnit velikost kola. Dále je tam vidět reset, pokud se obě tlačítka drží po dobu 2 a více sekund. 

**Simulace modulu**
![Simulation of buttons.vhd](Images/btn_sim.png)

**Odkazy:**
 
- [Design](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sources_1/new/buttons.vhd)
- [Testbench](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sim_1/new/tb_buttons.vhd)
        
#### Modul `mode.vhd` 

Modul `mode.vhd` je modul, ve kterým se volí mód zobrazení výstupu na displej a mód na volbu kola. Tento modul využívá hlavně tlačítko btn0, ale je zde řešen jeden ze dvou reset signálů do modulu `reset.vhd`, který se vyšle jen tehdy, pokud je tlačítko btn0 a btn1 stisknuté po dobu 2 a více sekund.
To je řešeno pomocí časovače, který je spuštěný clk každých 10 ms po dobu 2 sekund a poté je vyslán signál resetu. 

**Simulace modulu**
![Simulation of mode.vhd](Images/mode_sim.png)

**Odkazy:**
 
- [Design](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sources_1/new/mode.vhd)
- [Testbench](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sim_1/new/tb_mode.vhd)

#### Modul `wheel.vhd` 

Do modulu `wheel.vhd` je přiveden signál zvoleného módu z `mode.vhd`. Pokud je mód 0, tak se dá volit rozměr kola. Pokud není mód 0, nelze volit rozměr kola, ale je možné provést reset, pokud je tlačítko btn0 a btn1 stisknuté po dobu 2 a více sekund. 

**Simulace modulu**
![Simulation of wheel.vhd](Images/wheel_sim.png)

**Odkazy:**

- [Design](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sources_1/new/wheel.vhd)
- [Testbench](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sim_1/new/tb_wheel.vhd)

#### Modul `reset.vhd` 

Pokud je do modulu `reset.vhd` přiveden zároveň signál pro reset z `mode.vhd` a `wheel.vhd`, modul vyšle signál resetu do modulu `calculations.vhd`   

**Simulace modulu**
![Simulation of reset.vhd](Images/reset_sim.png)

**Odkazy:**
 
- [Design](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sources_1/new/reset.vhd)
- [Testbench](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sim_1/new/tb_reset.vhd)

### Modul `calculations.vhd`

Modul slouží jako sjednocení bloků `speed.vhd`, `average.vhd` a `distance.vhd`. Do modulu je přiveden signál z hallovi, z hodin (clk), signály z modulu `buttons.vhd` mode a wheel.

Z obrázku simulace lze vidět, že hodnoty průměrné rychlosti (s_AVGS), aktuální rychlosti (s_SPD) a vzdálenosti (s_DIST) se zobrazují jen tehdy, pokud je zvolen jejich mód, jinak ukazují hodnotu 0. Dále lze vidět, když nastal restart (3,5 s), tak se hodnoty vynulovaly. 

**Simulace modulu**
![Simulation of calculations.vhd](Images/calc_sim.png)

**Odkazy:**
 
- [Design](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sources_1/new/calculations.vhd)
- [Testbench](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sim_1/new/tb_calculations.vhd)

#### Modul `speed.vhd`   

Modul `speed.vhd` není ovlivněn signálem z resetu, protože ukazuje aktuální rychlost, která se aktualizuje každých 10 ms. Rychlost je zobrazena v Módu 1. I když je rychlost v simulaci zobrazena v jednotkách tisíců např. 1424, tak vyjadřuje hodnotu 14,24 km/h. 

**Simulace modulu**
![Simulation of speed.vhd](Images/speed_sim.png)

**Odkazy:**
 
- [Design](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sources_1/new/speed.vhd)
- [Testbench](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sim_1/new/tb_speed.vhd)

#### Modul `average.vhd` 

Modul `average.vhd` zobrazuje průměrnou rychlost uživatele za celou dobu, která je ovlivněná frekvencí šlapání, ujetou vzdáleností a zvoleným mód kola. Průměrná rychlost je zobrazena v Módu 2. Průměrná rychlost v simulaci je zobrazena v jednotkách tisíců např. 1424, ale reálně vyjadřuje hodnotu 14,24 km/h.

**Simulace modulu**
![Simulation of average.vhd](Images/avr_sim.png)

**Odkazy:**
 
- [Design](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sources_1/new/average.vhd)
- [Testbench](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sim_1/new/tb_average.vhd)

#### Modul `distance.vhd` 

V modulu `distance.vhd` se řeší ujetá vzdálenost, která je závyslá na zvolené velikosti kola. Zobrazená vzdálenost v simulaci je nastavena v jednotkách metrů (1 m) pro lepší přehlednost, mimo simulace je nastavena v řádu desítek metrů (10 m). 

**Simulace modulu**
![Simulation of distance.vhd](Images/dist_sim.png)

**Odkazy:** 

- [Design](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sources_1/new/distance.vhd)
- [Testbench](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sim_1/new/tb_distance.vhd)

## Popis a simulace TOP modulu

Modul `top.vhd` spojuje moduly `buttons.vhd` a `calculations.vhd`. Do modulu `buttons.vhd` přivádí signál z tlačítek a clk, do `calculations.vhd` mode, reset a wheel z modulu `buttons.vhd`. Dále je přiveden signál ze Hallovi sondy a clk. Z celého modulu pak jdou pryč signály z modulů distance, average a speed. Tyto signály jsou přivedeneny na piny, které by vedly do arduina, které by signál přeložilo z binárního kódu do ASCII a poslalo zpět do desky, kde by to bylo propojeno s piny JA a JB (Pmod piny) do LCD displeje.

Na obrázcích simulace lze vidět, že 

**Simulace modulu**
- 0 - 10s
![Simulation of top.vhd part 1](Images/top1_sim.png)

- 10 - 20s
![Simulation of top.vhd part 2](Images/top2_sim.png)

- 20 - 30s
![Simulation of top.vhd part 3](Images/top3_sim.png)

**Odkazy:** 

- [Design](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sources_1/new/top.vhd)
- [Testbench](https://github.com/mrhyks/Projekt-DE1-3/blob/main/DE1-3/console/console.srcs/sim_1/new/tb_top.vhd)

## Video

*Write your text here*


## References

   1. [Arty A7 reference manual](https://reference.digilentinc.com/reference/programmable-logic/arty-a7/reference-manual)
   2. [Digilent Pmod Interface Specification](https://www.digilentinc.com/Pmods/Digilent-Pmod_%20Interface_Specification.pdf)
   3. [Pmod CLP Reference Manual](https://reference.digilentinc.com/reference/pmod/pmodclp/reference-manual)