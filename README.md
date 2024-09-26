# ARP
- u zkoušky výkonnost PC, vzorečky (Amdahlův zákon -> zrychlení [S_overall]) (1. přednáška na cvičení)

## Př1
- 5000000 1takt
- 1000000 2takt
- 1000000 3takt
    - Ic = 7*10^6
    - Nclk = (5+2+3)*10^6 = 10*10^6
- f = 100MHz
- MIPS = ?
- =====
- Tcpu = Nclk/f = 0.1s
- MIPS = Ic/Tcpu * 10^-6 = 70

## Př2
- vztah Tnew/Told
    - neboli 1/nová rychlost Tnew
- P1 = 11% | + 0x
- P2 = 18% | + 5x
- P3 = 23% | + 20x
- P4 = 48% | + 1.6x
- Tnew = 11/100 + 18/100\*1/5 + 23/100\*1/20 + 48/100\*10/16
- Snew = Tnew^-1 = 2,19

## Př3
- 1/((1-0.8)+(0.8/2))
- S = 1,67

## Př4
- stejně jako 3, akorát se změní části co se zrychlují

## Př5
- rozdělit příklad na dvě části, stejně jako Př3/4

## Př6
- MIPS:
    - 80/4 = 20 MIPS
- MOPS:
    - počet operací v instrukci * MIPS
    - = 9*20 = 180 MOPS

## Př7
- 32%... 2
- 45%... 5
- 23%... 6
- 1/(0.32/2+0.45/5+0.23/6) =~ 3.47

## Př8
- S = 10/5 = 2
- E (účinnost) = S/P = 2/4 = 0.5 => 50%