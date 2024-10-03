# ARP - cv2


## Př1
- 258.125 do dvojkové
- celá část: (dělení dvěma)
    - `100000010`
- desetinná část (0.125, násobení dvěma, zapisujeme když přeteče přes 1)
    - 0.25 -> 0
    - 0.5 -> 0
    - 1.0 -> 1
- výsledek:
    - `100000010.001`

## Př2
- 1.1 do dvojkové
- celá část:
    - `1`
- deseti. část (0.1)
    - 0.2 -> 0
    - 0.4 -> 0
    - 0.8 -> 0
    - 1.6 -> 1
    - 1.2 -> 1
    - 0.4 -> 0 = perioda
- výsledek:
    - `1.00011`... (poslední 4 bity se opakují do nekonečna)
    - pokud máme jen např. 8 bitů, musíme zaokrouhlit (classics)

## Př3
- 213 + 213 v binární
    - 213 = `11010101`
- sčítání:
    ```
       11010101
    +  11010101
    = 110101010
    ```
## Vsuvka
- dvojkový kód - PC varianta
    - invertovat vše a přičíst 1
- dvojkový kód - studentská varianta
    - jít zprava a první jedničku opsat, zbytek čísla negovat
    - např. `0110` (5) -> `1010` (-5)
        - první bit určuje znam.

## Př4
- sečtěte 47 a -20 v bin
- 47 = `00101111`
- 20 = `00010100`
    - převést na -20 = `11101100`
- sčítání:
    ```
       00101111
    +  11101100
    = 100011011
    ```

## Př5
- sečtěte -100 a -20 v bin
- ?

## Vsuvka
- násobení - Boothův alg.
- logický posun vpravo
    - `1001` -> `0100`
- aritmetický posun vpravo (zanechává informaci o 1 na začátku - záporné číslo)
    - `1001` -> `1100`
- aditivní kód (čtvrtý kód po přirozeném, jedničkovém, dvojkovém)
    - použití u floatu

## Sustabulka
- převést čísla do kódů:
    - přímý
    - inverzní
    - doplňkový
    - aditivní sudý
    - aditivný lichý
- 9
    - `01001`
    - `01001`
    - `01001`
    - 9 + 2^(5-1) = 9+16 = 25 = `11001`
        - 9 ... číslo
        - 2 ... dvojková soustava
        - 5 ... počet bitů
        - -1 ... arbitrární
    - 9 + 2^(5-1)-1 = 9+16-1 = 24 = `11000`
- -9
    - `11001` (MSB určuje znaméínko)
    - `10110` (přehodíme všechny bity, MSB určuje znam.)
    - `10111` (studentův algoritmus)
    - `00111` (přičteme půlku rozsahu)
    - `00110` (přičteme půlku rozsahu - 1)
- 9/16
    - stejné čísla jako 9 (protože fixed point)
- -9/16
    - stejné čísla jako -9 (protože -||-)

## Floaty
- pohyblivá des. čárka
- bin32
    - znam mantisy (1bit), mantisa (8bit), exponent (32bit)
- bin64
    - znam. mantisy (1bit), mantisa (11bit), exponent (52bit)
- [!] floaty bývají u zkoušky zřídka

## Floaty Př.
- 258.125 = `100000010.001`
- 1) normalizovat (převést na MSB jedničku)
    - = `1.00000010001 * 2^8` (posun o 8)
- 2) ?

## Př.
- `4291 4000`(16) do dekadického floatu
- = `72.625`

## Př
- `47.0625`(10) do binárního floatu
- = `0100001001111000100000000000000`