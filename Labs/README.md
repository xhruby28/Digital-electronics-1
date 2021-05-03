# Projekt-DE1-3

**Co to mus¡ umØt?**

*- Alespoå 2 tlaŸ¡tka (jedno, kter‚ bude potýeba, druh‚ jako rezerva pro dalç¡ funkce)*

*- Rychlost, ujet  vzd lenost (pr…mØrnou a maxim ln¡ rychlost)*

*- Pr…mØr kola (Z preset…)*

# Projekt-DE1 - 3. zad n¡
## Konzole pro rotoped/kolo s LCD displejem

### ¬lenov‚ tìmu

- Hrubeçov  Diana
- Hrubì Jan
- Hykç MatØj
- Hynçt Boris

[Link na n ç Github](https://github.com/mrhyks/Projekt-DE1-3)

### C¡le projektu

C¡lem projektu je vytvoýit konzoli pro rotoped Ÿi kolo s hallovou sondou. Pro zobrazov n¡ vìstupu jako je 
rychlost, pr…mØrn  rychlost a ujet  vzd lenost jsme zvolili LCD displej.

**Jednotliv‚ body projektu:**
*- DvØ tlaŸ¡tka: - Prvn¡m tlaŸ¡tkem (btn0) se d  vybrat nastaven¡ polomØru kola a m¢d zobrazen¡ displeje*
*                  M¢d 0 - Nastaven¡ velikosti kola; M¢d 1 - Zobrazen¡ rychlosti;     -
*                  M¢d 2 - Zobrazen¡ pr…mØrn‚ rychlosti; M¢d 3 - Zobrazen¡ ujet‚ vzd lenosti*
*                - Druhìm tlaŸ¡tkem (btn1) se d  vybrat polomØr kola, kdy kolo se d  vybrat jen v pý¡padØ, §e je vybranì m¢d 0*
                
*- V pý¡padØ, §e u§ivatel chce resetovat data a zaŸ¡t znovu (neresetuje se nastavenì m¢d a kola) staŸ¡ dr§et obØ tlaŸ¡tka*
*  po dobu dvou a v¡ce sekund, resetuje se ujet  vzd lenost a pr…mØrn  rychlost.*
               
*- Vìstup zmØýen‚ a vypoŸ¡tan‚ rychlosti, pr…mØrn‚ rychlosti a vzd lenosti z¡skan‚ pomoc¡ hallovy sondy do LCD displeje. Pro pýeklad binarn¡ho* 
*  vìstupu by byl zapotýeb¡ extern¡ vìpoŸetn¡ modul, jako je napý. arduino. Funkce tohoto modulu je pops na v sekci **Popis Hardwaru***  

*- Mo§nost volby pr…mØru kola


## Popis Hardwaru

Jako vìvojovou desku jsme vybrali Arty A7 35. 

Pro zobrazov n¡ vìstupu by jsme pou§ili Pmod CLP (Revision B) module. Funkci modulu jsme popsali pouze teoreticky, proto§e se n m nepodaýilo
vytvoýit pýeklad bin rn¡ho vìstupu do ASCII, kterì je potýeba pro zobrazov n¡.  

**Funkce Pmod CLP (Revision B) module**

V top vrstvØ bude napojen modul s rozhran¡mi: 3x 32 bit binary a 2x 2 bit binary. Ty n slednØ budou napojeny na vìpoŸetn¡ modul (napý¡klad Arduino) je§ bude obsahovat program psanì napý¡klad v C# a ten bude m¡t za £kol dosazen¡ hodnot pýijatìch jednotlivìmi interfacy do danìch struktur pro m¢dy 1 - 4, n slednØ je pýelo§it do bin rn¡ abecedy pro jednotliv‚ znaky dle tabulky, kter  je pýilo§ena v dokumentaci tohoto LCD char displaye, n slednØ je podle vlastn¡ho ŸasovaŸe bude dle n mi nastaven‚ho Ÿasu odes¡lat na display spolu s pýedch zej¡c¡m pý¡kazem clear na jednotliv‚ porty, jejich§ pops n¡ a zapojen¡ je tak‚ ps no v dokumentaci a t¡m dojde k vyps n¡ zpr vy na obrazovku.

Dejme tomu, §e jedeme na kole a pr vØ jsme ujeli 12.5 km:
V takov‚ situaci modul pro ý¡zen¡ char LCD displaye pý¡jme z z portu mode dvoubitovou zpr vu urŸuj¡c¡ aktu lnØ zvolenì mode, z toho v¡, §e jej zaj¡maj¡ informace, pýich zej¡c¡ na rozhran¡, do nØho§ je zapojen modul "calculations.distance" a z¡sk  32 bitovou bin rn¡ informaci, kter  vyjadýuje 1250 (ujet  vzd lenost je poŸ¡t na v des¡tk ch metr… => 1250 * 10 = 12500 metr… = 12.5 km). Tak§e v¡, §e pou§ije preset pro mode 3 => dosad¡ do modu: 
ý dek 1: mode => Distance + (pr zdn‚ znaky)
ý dek 2: No.mode => 3. + (pr zdnì znak) + pýijat‚ hodnoty pýepoŸ¡tan‚ na kilometry => 12.5 + (pr zdnì znak) + jednotka (km) + (pr zdn‚ znaky)
Ty n slednØ pýevede dle tabulky z dokumentace na bin rn¡ k¢d, kterì zaçle na jednotliv‚ porty char LCD displaye spolu s pýedch zen¡c¡m clear display pý¡kazem, podle n mi nastaven‚ho Ÿasu pro refresh rate.
Pý¡klad takov‚ zpr vy zas¡lan‚ na display pro ujetou vzd lenost 12,5 km
clear: RS --> 0 RW --> 0 + D0 - D7 --> 1000 0000
first line: 0010 0010(D)|1001 0110(i)|1100 1110(s)|0010 1110(t)|1000 0110(a)|0111 0110(n)|1100 0110(c)|1010 0110(e)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|
second line: 1100 1100(3)|0111 0100(.)|0000 0100(blank)|1000 1100(1)|0100 1100(2)|0111 0100(.)|1010 1100(5)|0000 0100(blank)|0000 0100(blank)|1101 0010(K)|1011 1010(m)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|
tabulka pro n ç LCD modul:

## VHDL modules description and simulations

Write your text here.


## TOP module description and simulations

Write your text here.


## Video

*Write your text here*


## References

   1. Write your text here.