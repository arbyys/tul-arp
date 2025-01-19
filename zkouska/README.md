# Teoretická část - poznatky
- **výkonnost systému** $P_t$
	- $P_t = \frac{1}{T}; \quad T=\text{doba provedení jednoho úkonu}\quad [MIPS]$
- **propustnost systému** $P_r$
	- $P_r = \frac{n}{t}; \quad \text{počet úkonů n za čas t}\quad [MIPS]$
- **doba provádění programu** $T_{CPU}$
	- $T_{CPU} = IC * CPI * T_{CLK}$
	- $\text{IC = instruction count; CPI = cycles per instruction; Tclk = perioda hod. signálu}$
- **zrychlení systému** $S_{OVERALL}$
	- $S_{OVERALL} = \frac{T_{OLD}}{T_{NEW}} \quad \text{Told/new = výkonnost bez/s vylepšení/m}$
- vzorce na kódování (záporných) čísel z decimální do binární:
	- **doplňkový kód** (dvojkový doplněk)
		- = inverze všech bitů a přičíst 1
	- **aditivní kód**
		- lichý = $X +2^{n-1}-1$
		- sudý = $X +2^{n-1}$
		- kde $n = \text{počet bitů vstupu}$
	- **přímý kód**
		- absolutní hodnota čísla, MSB je znaménkový bit
		- `MSB = 1`: záporné číslo
		- `MSB = 0`: kladné číslo
	- **IEEE 754** (reálné číslo, 32bit mód)
		- big endian (MSB je první) / little endian (LSB je první)
		- znaménkový bit funguje stejně jako u přímého (1 záporné, 0 kladné)
		- nejdříve převést na binární formát, poté (od bitu nejvíce vlevo) rozdělit na části následujícím způsobem:
			- **1bit znaménko mantisy $S$, 8bit exponent $E$, 23bit mantisa $M$**
		- mantisa $M$ se ještě musí převést na desetinné číslo: $\overline{M} = \sum_{i=1}(M_i * 2^{-i})$
		- DEC hodnota je poté: $X = (-1)^S * 2^{E-127} * (\overline{M})$
- opačné vzorce (do decimální)
	- aditivní kód
		- lichý = odečíst ($X^{n-1}$ - 1)
		- sudý = odečíst $X^{n-1}$ 
- z `HEX` do `BIN` (nebo obráceně)
	- skupinky po 4 bitech
___

# Písemná část - možné otázky

## 1. – char. vlastnosti
- **Uveďte char. vlastnosti von Neumanovy architektury počítačů**
	- struktura počítače nezávislá na typu úlohy
	- společná paměť pro program (instrukce) + data (operandy)
		- paměť rozdělená do buněk stejné velikosti
	- program tvořen posloupností instrukcí (s daným pořadím)
		- změna pořadí pomocí (ne)podmíněného skoku
	- dvojková soustava pro reprezentaci čísel
	- tok dat v programu řídí řadič
	- – porovnání
		- jednodušší návrh, horší paralelizace, procesor řeká na dokončení I/O operací (sdílená sběrnice)
- (2024) Uveďte char. vlastnosti Harvardské architektury počítačů
	- oddělená paměť programu a dat
	- oddělená sběrnice
	- řízení procesoru odděleno od řízení IO jednotek
	- – porovnání
		- dražší a složitější implementace, vyšší bezpečnost, možnost paralelizace 
- **Uveďte char. vlastnosti procesurů typu CISC**
	- Complex Instruction Set Computer
	- dříve byly RAM pomalejší než CPU
		- aby se zabránilo bottlenecku, byla snaha rozšiřovat instrukční soubor aby se tolik instrukcí nemuselo načítat z RAM
		- výsledkem je hodně složitých instrukcí, které se využijí zřídkakdy
	- proměnná délka instrukcí, hodně adresovacích módů
	- paměť s mikroprogramy (ROM)
	- zpracování instrukcí ve více stroj. cyklech (CPI ~ 5 – 10)
	- pro překlad programu jednodušší překladač
- **Uveďte char. vlastnosti procesurů typu RISC**
	- Reduced Instruction Set Computer
	- snaha o přesun některých méně používaných instrukcí do programu (snížení CPI)
	- relativně malý počet jednoduchých instrukcí, malý počet adresovacích módů
	- místo mikroprogramování je tam řadič s pevnou logikou (rychlé)
	- víceúčelové registry = jednodušší překladače
	- proudové zprac. instrukcí (CPI < 1.5)
	- nejčastěji se vážou k Harvardské arch.
- **Uveďte char. vlastnosti procesurů typu post-RISC**
	- většina současných CPU
	- kombinace RISC a CISC (navenek CISC, vnitřně RISC)
	- různě dlouhá doba trvání instrukcí, rozklad na jednoduché mikroinstrukce
	- proudové zpracování, paralelizace
	- spekulativní provádění instrukcí
- **Jaký je rozdíl mezi subskalárními, sklárními a superskalárními procesory?**
	- rozdělení vývoje procesorů do tří částí
	- subskalární (sekvenční):
		- tradiční, synchronní
	- skalární:
		- synchronní zpracování nahrazeno paralelním
		- vykonávání instrukcí může probíhat skrytě
		- IPC (Instruction Per Cycle) = 1
	- superskalární:
		- paralelní vydávání i zpracování instrukcí
		- buď statické plánování paralelismu (např. VLIW) nebo dynamické za běhu (složitější)
		- IPC > 1
- **Uveďte char. vlastnosti architektury VLIW procesorů + kde se v souč. používá?**
	- Very Long Instruction Word
	- architektura se čtením s více přístupy, superskalární, lze dělat paralelizaci na úrovni instrukcí
	- delší instrukce které mají dílčí části
	- o paralelizaci rozhoduje překladač (HW nekontroluje hazardy)
	- větší náročnost na program. paměť
	- použití: GPU, DSP (Digital Signal Processors)

## 2. – vylepšení procesoru – (příklad)
- **(!) Předpokládejme vylepšení procesoru pro databázové výpočty. Nový procesor je 5x rychlejší než nynější. Dále víme, že nyní je procesor zaměstnán z 65% výpočty a 35% času čeká na vstupně – výstupní operace. Jaké bude celkové zrychlení po plánovaném vylepšení?**
	- $F_E = 0.65; \quad \text{...část, kterou lze zlepšit (výpočty)}$
	- $S_E = 5; \quad \text{...kolikrát se zrychlí výpočet}$
	- $S_{OVERALL} = \frac{1}{(1 - F_E) + \frac{F_E}{S_E}}$
	- $S_{OVERALL} = \frac{1}{(1 - 0.65) + \frac{0.65}{5}}$
	- $= 2.08x$
- **Předpokládejme vylepšení procesoru pro web. Nový CPU je 10× rychlejší pro webové aplikace než nynější. Dále víme, že nyní je CPU zaměstnán ze 40% výpočty a 60% času čeká na I/O operace. Jaké bude celkové zrychlení po plánovaném vylepšení?**
	- VYPOČÍTAT dle 1 (důležitý příklad)
- (2024) Počítač zpracovává program s 40mil dvoutaktovými instrukcemi. Kmitočet hodinových taktů procesoru je 2 GHz. Jaká je výkonnost procesoru v MIPS?
	- todo
- Počítač zpracovává program, který má 5 milionů 1-CPI (jednotaktových instrukcí), 1 milion 2-CPI a 1 milion 3-CPI. Kmitočet hodinových taktů je 100 MHz. Jaká je jeho výkonnost v MIPS?
	- $F_{CLK} = 100MHz$
	- $IC = 5 * 10^6 + 1 * 10^6 + 1 * 10^6 = 7 * 10^6$
	- $N_{CLK} = 5 * 10^6 + 2 * 10^6 + 3 * 10^6 = 10 * 10^6$
	- $T_{CPU} = \frac{N_{CLK}}{f_{CLK}} = \frac{10*10^6}{100*10^6} = 0.1s$
	- $P_{MIPS} = \frac{IC}{T_{CPU}} = 70 \, MIPS$
- **Mikrořadič pracuje s frekvencí 4 MHz. K provedení jednoho instrukčního cyklu vyžaduje 4 hodinové takty. Program má 90% jednocyklových a 10% dvoucyklových instrukcí. Jaký je výkon mikrořadiče v MIPS?**
	- $P_{MIPS} = \frac{f_{CLK}}{CPI}*10^{-6}$
	- $= \frac{4*10^6}{0.9 * 4 + 0.1 * 2 * 4}*10^{-6}$
	- $= 0.9\,MIPS$
- **Výpočetní úloha je rozdělena na 3 části, z nichž každá trvá daný čas (P1 = 20%, P2 = 30% a P3 = 50%). Jaké je celkové zrychlení, jestliže část P1 zrychlíme 5x, část P2 nezrychlíme a část P3 zrychlíme 10x?**
	- $S_{OVERALL} = \frac{T_{OLD}}{T_{NEW}}$
	- $= \frac{1}{\frac{0.2}{5} + \frac{0.3}{1} + \frac{0.5}{10}}$
	- $= 2.56x$
	- další: ![obrázek úlohy](img1.png)
- **Vypočítejte průměrnou dobu přístupu do paměti (systém složený z cache a operační paměti), je-li vybavovací doba cache 12 ns, čas získání dat z operační paměti 160 ns a pravděpodobnost neúspěchu je 10%.**
	- $t = cache * úspěch + ram * neúspěch$
		- pokud se to nepovede z cache, čte se z RAM
	- $t = 12 * (1 - 0.1) + 160 * 0.1$
	- $t = 27ns$
- **(!) Máme 5 stupňovou zřetězenou linku. Jaké bude zrychlení linky, když 20% instrukcí bude mít 4 ztrátové (čekací) cykly, 15% instrukcí bude mít 1 ztrátový cyklus a zbývající počet instrukcí bude bez ztrátových cyklů?**
	- todo
- **(!) Jaká je dosažitelná účinnost zřetězené 4stupňové linky při zpracování 5 instrukcí? Spočtěte dále průměrnou hodnotu CPI. (obrázek, `2010_19_1`, `2019_11_1`)**

	- `x` = čekání na mezivýsledek; `-` = nevyužito

	| Čas | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |
	|--|--|--|--|--|--|--|--|--|--|
	| S1 | 11 | 12 | 13 | 14 | x | 15 |  | | | 
	| S1 | | 11 | 12 | 13 | x | 14| 15 | | |
	| S1 | | | 11 | 12 | x | 13 | 14 | 15 | |
	| S1 | | | | 11 | 12 | - | 14 | 14 | 15 |
	- $CPI = \frac{9}{5} = 1.8\quad\text{[taktů na 1 instrukci]}$
	- zrychlení $S_{K} = \frac{T_{OLD}}{T_{NEW}}$
		- $= \frac{4*5}{9} = 2.2$
	- účinnost $E_K = \frac{S_K}{\text{počet stupňů linky}} = \frac{2.2}{4} = 0.55$
- další sus příklad - vypočítat `MIPS` pro jednu instrukci a pak jen vynásobit počtem instrukcí
	- ![img2](img2.png)

## 3. – simulace registrů – (příklad)
- Uveďte nový stav registrů mikrořadiče rodiny PIC16 po provedení dané posloupnosti čtyř instrukcí:

| (2024) Adresa   |      Hodnota      |  Instrukce |
|----------|-------------|------|
| 0x09 (WREG) | 0xCC | `MOVLW  .113` |
| 0x04 (FSR0L) | 0xCC | `MOVWF  0x04` |
| 0x70 | 0xCC | `BTFSS  0x70,4` |
| 0x71 | 0xCC | `DECF  0x71,W` |

| Stav po instrukcích |  Hodnota |  
|----------|-----------|
| 0x09 (WREG) | 0xCB |
| 0x04 (FSR0L) | 0x71 |
| 0x70 | 0xCC |
| 0x71 | 0xCC |

___
<br>

| Adresa (DEC)   |      Hodnota (HEX)      |  Instrukce |
|----------|:-------------|------|
| 0x09 (WREG) | 0xAB | `MOVLW  .113` |
| 0x04 (FSR0L) | 0xCD | `MOVWF  0x04` |
| 0x70 | 0xEF | `BTFSC  0x70,4` |
| 0x71 | 0x64 | `DECF  0x71,W` |

| Stav po instrukcích |  Hodnota |  
|----------|-----------|
| 0x09 (WREG) | 0x71 |
| 0x04 (FSR0L) | 0x71 |
| 0x70 | 0xEF |
| 0x71 | 0x64 |

___
<br>

| Adresa (DEC)   |      Hodnota (HEX)      |  Instrukce |
|----------|-------------|------|
| 0x09 (WREG) | 0xAA | `ADDWF  0x71,F` |
| 0x04 (FSR0L) | 0xAA | `RRF  0x71,W` |
| 0x70 | 0xAA | `BCF  0x70,1` |
| 0x71 | 0xAA | `XORWF  0x71,W` |

| Stav po instrukcích |  Hodnota |  
|----------|-----------|
| 0x09 (WREG) | 0x?? |
| 0x04 (FSR0L) | 0x?? |
| 0x70 | 0x?? |
| 0x71 | 0x?? |

___
<br>

| Adresa (DEC)   |      Hodnota (HEX)      |  Instrukce |
|----------|-------------|------|
| W | F2 | `ANDLW  F4h` |
| 04 (FSR) | 00 | `MOVF  14,1` |
| 14 | FF | `INCF  14,1` |
| 15 | 00 | `BCF  14,7` |

| Stav po instrukcích |  Hodnota |  
|----------|-----------|
| W | F0 |
| 04 (FSR) | 00 |
| 14 | 00 |
| 15 | 00 |

___
<br>

| Adresa (DEC)   |      Hodnota (HEX)      |  Instrukce |
|----------|-------------|------|
| W | AA | `ADDWF  15,1` |
| 04 (FSR) | 20 | `BTFSC  14,6` |
| 14 | A0 | `INCF  15,1` |
| 15 | FF | `MOVLW  15` |

| Stav po instrukcích |  Hodnota |  
|----------|-----------|
| W | 15 |
| 04 (FSR) | 20 |
| 14 | A0 |
| 15 | AA |

___
<br>

| Adresa (DEC)   |      Hodnota (HEX)      |  Instrukce |
|----------|-------------|------|
| W | F3 | `ANDLW  F4h` |
| 04 (FSR) | 14 | `MOVF  14,1` |
| 14 | FF | `INCF  14,1` |
| 15 | 00 | `BSF  14,7` |

| Adresa (DEC)   |      Hodnota (HEX)      |  Instrukce |
|----------|-------------|------|
| W | BB | `ADDWF  15,1` |
| 04 (FSR) | DD | `BTFSC  14,6` |
| 14 | AA | `INCF  4,1` |
| 15 | CC | `MOVLW  15` |

| Adresa (DEC)   |      Hodnota (HEX)      |  Instrukce |
|----------|-------------|------|
| W | F5 | `MOVLW  14` |
| 04 (FSR) | 10 | `MOVWF  4` |
| 14 | BB | `DECF  14,1` |
| 15 | 0F | `BSF  14,1` |

- seznam instrukcí (`l` = literál, `f` = registr, `d` = destination [d=0 -> `W`; d=1 -> zpět do `f`]):
	- obecné:
		- `MOVWF  f` - přesun `W` do `f`
		- `MOVF  f,d` - přesun `f` do `d` 
		- `DECF  f,d` - dekrement `f`
		- `INCF  f,d` - inkrement `f` 
		- `ADDWF  f,d` - součet `W` a `f`
		- `XORWF  f,d` - XOR `W` a `f`
		- `RRF  f,d` - rotace vpravo přes C
	- s literálem `l`:
		- `MOVLW  l` - přesun `l` do `W`
		- `ANDLW  l` - AND `l` a `W`
		- `ADDLW  l` - součet `l` a `W`
	- bitové operace:
		- `BCF  f,b` - clearnout u `f` bit `b`
		- `BSF  f,b` - nastavit u `f` bit `b`
		- `BTFSS  f,b` - test u `f` bitu `b`; přeskočit další pokud set
		- `BTFSC  f,b` - test u `f` bitu `b`; přeskočit další pokud clear


## 4. – převody – (příklad)

- **Jak bude reprezentováno číslo (-12)\_D v pětimístné celočíselné číslicové formě: a) v doplňkovém kódu, b) v aditivním lichém kódu**
<details>
  <summary>Řešení</summary>
  
  a) 10100, b) 00011
</details>

- **Jak bude reprezentováno číslo (-11)\_D v šestimístné celočíselné číslicové formě: a) v doplňkovém kódu, b) v aditivním lichém kódu**
<details>
  <summary>Řešení</summary>
  
  a) 110101, b) 010101
</details>

- **Jak bude reprezentováno číslo (-13)\_D v šestimístné celočíselné číslicové formě: a) v doplňkovém kódu, b) v aditivním lichém kódu**
<details>
  <summary>Řešení</summary>
  
  a) 110011, b) 010011
</details>

- **Číslo zapsané v aditivním sudém kódu má tvar `0110010`. O jaké číslo v desítkové soustavě se jedná? Jak bude vypadat zápis stejného čísla v přímém kódu se znaménkem (zapsaný pomocí stejného počtu bitů)?**
<details>
  <summary>Řešení</summary>
  
  je to číslo -14, v přímém kódu `1001110`
</details>

- **Číslo zapsané v aditivním sudém kódu má tvar `1010101`. O jaké číslo v desítkové soustavě se jedná? Jak bude vypadat zápis stejného čísla v přímém kódu se znaménkem (zapsaný pomocí stejného počtu bitů)?**
<details>
  <summary>Řešení</summary>
  
  je to číslo 21, v přímém kódu `0010101`
</details>

- **(!) Číslo zapsané v 32-bitovém formátu reálného čísla podle IEEE 754 má tvar (big endian): `(C2 81 00 00)_H`. O jaké číslo se jedná (zapsané v desítkové soustavě)?**
<details>
  <summary>Řešení</summary>
  
  `C2 81 00 00` = `1100 0010 1000 0001 0000 0000 0000 0000`
  - znaménkový bit: `1`
  - exponent: `1000 0101` = $133$
  - mantisa: `000 0001 0000 0000 0000 0000` = $1 + 2^{-7} = 1.0078125$
  - $X = (-1)^1 * 2^{133-127} * 1.0078125$
  - $X = -64.5$
  
</details>

## 5. – teorie
- (2024) V čem se liší architektura signálového procesoru vůči běžnému procesoru?
	- ...
- **(!) Co víte o architektuře procesorů ISA s univerz. registry? Architekturu charakterizujte, uveďte výhody/nevýhody.**
	- todo
- **Popište výhodu technologie zpracování instrukcí mimo pořadí (out-of-order) a kde se používá.**
	- todo
- **Popište výhodu technologie spekulativního zpracování instrukcí (speculative execution) a kde se používá.**
	- todo
- (2024) Co víte o technologii Turbo Boost? K čemu slouží a kde se používá?
	- ...
- (2024) Na jakých principech je založena funkce řadiče procesoru? Uveďte výhody/nevýhody jednotlivých koncepcí.
	- ...
- **(!) Na jakých principech jsou založeny technologie SSD disků? Uveďte výhody/nevýhody.**
	- todo
- **Na jakých principech je založena funkce řadiče? Uveďte výhody/nevýhody.**
	- todo
- (2024) Paralelní víceprocesorové systémy se dělí na volně a těsně vázané. Uveďte, v čem je princip. rozdíl. Za jakých podmínek je výhodnější použití těsně vázaných systémů?
- **(!) Jaké jsou principiální možnosti řešení priorit při více zdrojích přerušení?**
	- todo
- (2024) Co více o sběrnici SPI? Naznačte princip a oblast použití.
	- ...
- **Co víte o sběrnici I^2C? Naznačte princip a oblast použití.**
	- todo
- **Co víte o sběrnici PCI Express? Naznačte princip a oblast použití.**
	- todo
- **Co víte o sběrnici USB? Naznačte princip a oblast použití.**
	- todo
- **(!) Co víte o sběrnici SAS? Naznačte princip a oblast použití.**
	- todo
- **(!) K čemu slouží impedační zakončení sběrnic? Kdy je nutné jej používat? Uveďte 1 příklad konkrétního impedačního zakončení sběrnice.**
	- todo
- **Charakterizujte symbolická pole. Kde se používají?**
	- todo
- **Co je cache, k čemu slouží, jaké znáte typy?**
	- todo
- **Co je to DMA? Naznačte princip činnosti.**
	- todo
- **Co jsou to clustery, jaké znáte typy?**
	- todo
- **Jaké znáte hlavní módy adresování? Nazačte principy.**
	- todo
- **K čemu slouží ALU, z jakých částí se skládá, čím se liší ALU běžných signálových CPU vs ALU běžných CPU?**
	- todo
- **Co víte o technologii HT (Hyper-threading) u Intel Pentium 4?**
	- todo

## Nezařazeno / nevypracováno
- Napište výkonnostní rovnici procesoru bez cache a s cache, popište veličiny.
- Na obrázku jsou znázorněny dva principy zpracování instrukcí v procesoru. Obě architektury pojmenujte a naznačte oblast použití (obrázek, `2016_1_2`)
- V čem se liší plně asociativní cache od n-cestně asociativní cache?
- Co více o sběrnici HyperTransport (princip, technologie, topologie, kde se používá)?
- Jaké jsou hlavní části (funkční bloky) grafických procesorů? Popište účel každého bloku.
- Jaké znáte typy neadresovatelných pamětí? Charakterizujte stručně typy.
- Co je architektura souboru instrukcí, co určuje, jaké znáte typy?