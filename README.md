# 🥔 Generátor výmluv

Webová stránka, která na jedno kliknutí vymyslí dokonale absurdní výmluvu.

> „Promiň, nemohl/a jsem přijít, protože robotický vysavač mi přeprogramoval budík na čínský čas.“

## Jak to funguje

Každá výmluva se poskládá ze tří náhodných dílů:

1. **začátek** („Úkol nemám, protože…“)
2. **kdo za to může** („rozzlobený holub“)
3. **co se stalo** („prohlásil můj byt za nezávislý stát.“)

Díky tomu existují stovky kombinací.

## Gramatická pravidla generátoru

Jednotlivé části se nesmí skládat pouze jako náhodné textové řetězce. Generátor musí při skládání věty hlídat českou gramatickou shodu a podle osoby nebo věci, které se věta týká, vybrat správný tvar slov.

U každé položky proto ukládej kromě textu také potřebné gramatické údaje:

- **rod:** mužský životný / mužský neživotný / ženský / střední,
- **číslo:** jednotné / množné,
- **osoba:** 1. / 2. / 3., pokud se podle ní mění sloveso,
- **pád:** potřebný tvar podstatného jména nebo zájmena podle větné konstrukce,
- **slovesné tvary:** varianty pro rody, čísla a osoby, pokud je sloveso potřebuje,
- **přídavná jména a zájmena:** musí mít stejný rod, číslo a pád jako výraz, ke kterému patří.

Generátor nejprve vybere osobu nebo původce děje a z jeho gramatických údajů následně odvodí, kterou variantu ostatních částí použít.

Například místo jedné pevné hodnoty:

```js
"prohlásil můj byt za nezávislý stát"
```

použij varianty:

```js
{
  m: "prohlásil můj byt za nezávislý stát",
  f: "prohlásila můj byt za nezávislý stát",
  n: "prohlásilo můj byt za nezávislý stát",
  pl: "prohlásili můj byt za nezávislý stát"
}
```

Původce děje zároveň nese informaci o svém rodu a čísle:

```js
{ text: "rozzlobený holub", rod: "m", cislo: "sg" }
{ text: "naštvaná kočka", rod: "f", cislo: "sg" }
{ text: "ztracené house", rod: "n", cislo: "sg" }
{ text: "rozzlobení holubi", rod: "m", cislo: "pl" }
```

Výsledek pak musí být například:

- „rozzlobený holub **prohlásil** můj byt za nezávislý stát“,
- „naštvaná kočka **prohlásila** můj byt za nezávislý stát“,
- „ztracené house **prohlásilo** můj byt za nezávislý stát“,
- „rozzlobení holubi **prohlásili** můj byt za nezávislý stát“.

Stejné pravidlo platí pro osobu, které se výmluva týká. Pokud si uživatel zvolí například mužský nebo ženský rod, musí generátor vybrat odpovídající varianty typu `nemohl / nemohla`, `byl / byla`, `udělal / udělala`, `šel / šla` apod. U množného čísla nebo jiné osoby musí obdobně změnit i osobu a číslo slovesa.

Pokud větná konstrukce vyžaduje jiný pád, nepokoušej se podstatné jméno mechanicky skloňovat pouze podle jeho koncovky. Čeština má mnoho nepravidelností. Spolehlivější je u položky uložit potřebné tvary předem, například:

```js
{
  nominativ: "rozzlobený holub",
  genitiv: "rozzlobeného holuba",
  dativ: "rozzlobenému holubovi",
  akuzativ: "rozzlobeného holuba",
  vokativ: "rozzlobený holube",
  lokal: "rozzlobeném holubovi",
  instrumental: "rozzlobeným holubem",
  rod: "m",
  cislo: "sg"
}
```

**Pravidlo pro generování věty:** nejprve určete, kdo je mluvčí a kdo je původce děje. Potom podle jejich osoby, rodu, čísla a požadovaného pádu vyberte správný tvar podstatných jmen, zájmen, přídavných jmen a sloves. Náhodně kombinujte pouze takové části, které jsou po této gramatické úpravě vzájemně slučitelné. Výsledná věta musí být před zobrazením gramaticky správná jako celek.

## Jak přidat vlastní výmluvy

Otevři `index.html` a najdi seznamy `zacatky`, `kdo` a `coSeStalo`. Novou položku nepřidávej pouze jako prostý text, pokud obsahuje slova závislá na rodu, čísle, osobě nebo pádu. Ulož také potřebná gramatická metadata a varianty tvarů podle pravidel výše.

U částí, které se gramaticky nemění, může zůstat jednoduchý textový řetězec.

## Spuštění

Stačí otevřít `index.html` v prohlížeči. Online běží zdarma přes **GitHub Pages**.
