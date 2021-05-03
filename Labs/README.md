# Projekt-DE1-3

**Co to mus� um�t?**

*- Alespo� 2 tla��tka (jedno, kter� bude pot�eba, druh� jako rezerva pro dal� funkce)*

*- Rychlost, ujet� vzd�lenost (pr�m�rnou a maxim�ln� rychlost)*

*- Pr�m�r kola (Z preset�)*

# Projekt-DE1 - 3. zad�n�
## Konzole pro rotoped/kolo s LCD displejem

### �lenov� t�mu

- Hrube�ov� Diana
- Hrub� Jan
- Hyk� Mat�j
- Hyn�t Boris

[Link na n�� Github](https://github.com/mrhyks/Projekt-DE1-3)

### C�le projektu

C�lem projektu je vytvo�it konzoli pro rotoped �i kolo s hallovou sondou. Pro zobrazov�n� v�stupu jako je 
rychlost, pr�m�rn� rychlost a ujet� vzd�lenost jsme zvolili LCD displej.

**Jednotliv� body projektu:**
*- Dv� tla��tka: - Prvn�m tla��tkem (btn0) se d� vybrat nastaven� polom�ru kola a m�d zobrazen� displeje*
*                  M�d 0 - Nastaven� velikosti kola; M�d 1 - Zobrazen� rychlosti;     -
*                  M�d 2 - Zobrazen� pr�m�rn� rychlosti; M�d 3 - Zobrazen� ujet� vzd�lenosti*
*                - Druh�m tla��tkem (btn1) se d� vybrat polom�r kola, kdy kolo se d� vybrat jen v p��pad�, �e je vybran� m�d 0*
                
*- V p��pad�, �e u�ivatel chce resetovat data a za��t znovu (neresetuje se nastaven� m�d a kola) sta�� dr�et ob� tla��tka*
*  po dobu dvou a v�ce sekund, resetuje se ujet� vzd�lenost a pr�m�rn� rychlost.*
               
*- V�stup zm��en� a vypo��tan� rychlosti, pr�m�rn� rychlosti a vzd�lenosti z�skan� pomoc� hallovy sondy do LCD displeje. Pro p�eklad binarn�ho* 
*  v�stupu by byl zapot�eb� extern� v�po�etn� modul, jako je nap�. arduino. Funkce tohoto modulu je pops�na v sekci **Popis Hardwaru***  

*- Mo�nost volby pr�m�ru kola


## Popis Hardwaru

Jako v�vojovou desku jsme vybrali Arty A7 35. 

Pro zobrazov�n� v�stupu by jsme pou�ili Pmod CLP (Revision B) module. Funkci modulu jsme popsali pouze teoreticky, proto�e se n�m nepoda�ilo
vytvo�it p�eklad bin�rn�ho v�stupu do ASCII, kter� je pot�eba pro zobrazov�n�.  

**Funkce Pmod CLP (Revision B) module**

V top vrstv� bude napojen modul s rozhran�mi: 3x 32 bit binary a 2x 2 bit binary. Ty n�sledn� budou napojeny na v�po�etn� modul (nap��klad Arduino) je� bude obsahovat program psan� nap��klad v C# a ten bude m�t za �kol dosazen� hodnot p�ijat�ch jednotliv�mi interfacy do dan�ch struktur pro m�dy 1 - 4, n�sledn� je p�elo�it do bin�rn� abecedy pro jednotliv� znaky dle tabulky, kter� je p�ilo�ena v dokumentaci tohoto LCD char displaye, n�sledn� je podle vlastn�ho �asova�e bude dle n�mi nastaven�ho �asu odes�lat na display spolu s p�edch�zej�c�m p��kazem clear na jednotliv� porty, jejich� pops�n� a zapojen� je tak� ps�no v dokumentaci a t�m dojde k vyps�n� zpr�vy na obrazovku.

Dejme tomu, �e jedeme na kole a pr�v� jsme ujeli 12.5 km:
V takov� situaci modul pro ��zen� char LCD displaye p��jme z z portu mode dvoubitovou zpr�vu ur�uj�c� aktu�ln� zvolen� mode, z toho v�, �e jej zaj�maj� informace, p�ich�zej�c� na rozhran�, do n�ho� je zapojen modul "calculations.distance" a z�sk� 32 bitovou bin�rn� informaci, kter� vyjad�uje 1250 (ujet� vzd�lenost je po��t�na v des�tk�ch metr� => 1250 * 10 = 12500 metr� = 12.5 km). Tak�e v�, �e pou�ije preset pro mode 3 => dosad� do modu: 
��dek 1: mode => Distance + (pr�zdn� znaky)
��dek 2: No.mode => 3. + (pr�zdn� znak) + p�ijat� hodnoty p�epo��tan� na kilometry => 12.5 + (pr�zdn� znak) + jednotka (km) + (pr�zdn� znaky)
Ty n�sledn� p�evede dle tabulky z dokumentace na bin�rn� k�d, kter� za�le na jednotliv� porty char LCD displaye spolu s p�edch�zen�c�m clear display p��kazem, podle n�mi nastaven�ho �asu pro refresh rate.
P��klad takov� zpr�vy zas�lan� na display pro ujetou vzd�lenost 12,5 km
clear: RS --> 0 RW --> 0 + D0 - D7 --> 1000 0000
first line: 0010 0010(D)|1001 0110(i)|1100 1110(s)|0010 1110(t)|1000 0110(a)|0111 0110(n)|1100 0110(c)|1010 0110(e)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|
second line: 1100 1100(3)|0111 0100(.)|0000 0100(blank)|1000 1100(1)|0100 1100(2)|0111 0100(.)|1010 1100(5)|0000 0100(blank)|0000 0100(blank)|1101 0010(K)|1011 1010(m)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|0000 0100(blank)|
tabulka pro n�� LCD modul:

## VHDL modules description and simulations

Write your text here.


## TOP module description and simulations

Write your text here.


## Video

*Write your text here*


## References

   1. Write your text here.