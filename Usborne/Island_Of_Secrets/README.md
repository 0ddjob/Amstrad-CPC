# Island of Secrets — Amstrad CPC Conversion Guide

A reference for porting the type-in listing to **Amstrad Locomotive BASIC** (CPC 464/664/6128).
You type the program in from your own copy of the book; apply these rules as you go. The book's
left-margin symbols mark the lines that differ per machine — those are the lines this guide is about.

There is no Amstrad column in the book, so the CPC equivalents below are worked out from how the
generic/Spectrum versions behave.

---

## 1. Global rules (apply everywhere)

| Book construct | CPC (Locomotive BASIC) | Notes |
|---|---|---|
| `LET A=...` | `A=...` (drop `LET`) | Optional on the CPC. Keep `LET` if you'd rather match the book exactly — it's valid either way. |
| `DEF FNR(Z)=INT(RND(1)*Z)+1` | `DEF FNR(Z)=INT(RND*Z)+1` | CPC `RND` already returns 0–<1. (`RND(1)` also works.) Random integer 1…Z. |
| `DEF FNP(Z)=POS` | `DEF FNP(Z)=POS(#0)` | CPC `POS` needs a stream argument. Returns the cursor **column** (1–40). |
| `DEF FNS(Z)=Y-(E/C4+.1)` | unchanged | Uses Y/E/C4 globals; fine as-is. |
| machine-specific clear-screen | `CLS` | Wherever the book's clear routine is called. |
| `PRINT TAB(c)` used for layout | `LOCATE c,r` (or keep `TAB`) | See §2. |

**`O`/`0` and `I`/`1`:** the book warns about these — they bite hardest in the data lines. When in
doubt, capital-letter variables (`L`, `O`, `R`, `Y`) vs digits.

---

## 2. Screen, colour, cursor

- **Mode:** it's a 40-column text adventure → `MODE 1`.
- **Colour:** pick your palette once at start, e.g. a parchment look:
  `MODE 1:INK 0,0:INK 1,26:INK 2,6:INK 3,24:BORDER 0:PAPER 0:PEN 1`
  (black paper, white text; inks 2/3 spare for highlights). Adjust to taste.
- **Status line** (STRENGTH / WISDOM / TIME at the top): the book positions fields with `TAB`/home
  tricks tuned to each machine's width. On the CPC, place each field explicitly:
  `LOCATE 1,1:PRINT"STRENGTH = ";INT(Y);` … `LOCATE 24,1:PRINT"WISDOM = ";X` etc.
  The `G$` "row of dashes" separator string is just text — keep it.
- **Don't rely on TAB(0) wrapping** to start a new line (some machines do this; the CPC's behaviour
  differs). Use `LOCATE` for anything that must land in an exact spot.

---

## 3. Keyboard

- Command line: `INPUT E$` — fine as-is.
- Any single-key tests: wrap with `UPPER$(INKEY$)` so they work without CAPS LOCK.

---

## 4. The one structural change: computed `RESTORE`

The describe-location routine builds a DATA line number and jumps to it:
`D = D*10 + LR : RESTORE D : READ A$` (with `LR` ≈ 2860, so it targets the room-description DATA
block at that line). **Locomotive BASIC's `RESTORE` only accepts a *literal* line number** — `RESTORE D`
is a `Syntax error` on the CPC. This is the only change that needs real restructuring.

**Fix — pre-load the room/action DATA into an array once, then index it.**

At init (after the DIMs), read every room-description DATA block into a string array. If those blocks
run from the first room line `Lfirst` in steps of 10 for `N` rooms:

```
DIM RM$(N)
RESTORE Lfirst              ' literal line number — allowed
FOR I=1 TO N:READ RM$(I):NEXT I
```

Then replace the describe routine's `RESTORE D:READ A$` with a direct index. Because `D=D*10+LR`:

```
A$=RM$((D-LR)/10)
```

For any **other** computed `RESTORE` that uses a *constant* offset (e.g. the one near 4110,
`RESTORE LR+1230`), you don't need an array — just compute the constant yourself and write the
**literal**: `RESTORE 4090` (i.e. 2860+1230). Only the *variable* `RESTORE D` needs the array.

> Tip: keep a scrap of paper mapping `D` values → room line numbers as you type the DATA, so you can
> confirm `(D-LR)/10` lands on the right block.

---

## 5. Word-wrap printer

The book prints a description one character at a time and breaks at a space once the cursor passes a
margin: `IF E$=" " AND FNP(Z)>Z THEN PRINT`. On the CPC:

- `FNP(Z)` → `POS(#0)` (see §1).
- `Z` is your **wrap column**. For MODE 1, set `Z=36` at init (breaks a few columns before the edge).
  `Z` is also passed as the dummy argument to `FNP`/`FNS`, but those ignore it — only line ~730 uses
  `Z` as the threshold, so one value (36) serves both jobs.
- The rest of the print loop is unchanged.

(The CPC also auto-wraps text windows, but the manual break-on-space gives cleaner word breaks — keep it.)

---

## 6. Save / load game (the `"ISDATA"` feature)

The book uses `SAVE "ISDATA" DATA L()` / `LOAD "ISDATA" DATA L()` (and `F()`). The CPC has **no
array save/load** verb, so stream the elements yourself. With `L()` and `F()` dimensioned to 52:

**Save:**
```
OPENOUT"ISDATA"
FOR I=0 TO 52:PRINT #9,L(I):NEXT I
FOR I=0 TO 52:PRINT #9,F(I):NEXT I
CLOSEOUT
```

**Load:**
```
OPENIN"ISDATA"
FOR I=0 TO 52:INPUT #9,L(I):NEXT I
FOR I=0 TO 52:INPUT #9,F(I):NEXT I
CLOSEIN
```

Match the loop bounds to the book's actual `DIM L(...)`/`DIM F(...)`. Numbers round-trip cleanly
through `PRINT #`/`INPUT #`.

---

## 7. The encoded data strings (type, don't convert)

The packed "code" strings (decoded with `ASC(MID$(...))-offset`) and the binary-flag strings are
**machine-independent data** — no CPC change needed. But they must be typed *character-perfect*,
including every `~ % \ ; / *` etc., or the decode produces garbage. Type them slowly and use the
book's own checks: flag strings come in groups of four `0`/`1`s; watch `O` vs `0`. These are the lines
most worth re-reading aloud against the book.

---

## 8. Quick conversion table

| Book | CPC |
|---|---|
| `INT(RND(1)*Z)+1` | `INT(RND*Z)+1` |
| `POS` | `POS(#0)` |
| `RESTORE <variable>` | pre-load DATA → array, index it (§4) |
| `RESTORE <const expr>` | `RESTORE <literal line>` |
| `SAVE/LOAD "x" DATA a()` | `OPENOUT`/`OPENIN` + `PRINT#`/`INPUT#` loop (§6) |
| machine clear-screen | `CLS` |
| `TAB(c)` for absolute layout | `LOCATE c,r` |
| `PEEK(screen)` / `POS` wrap test | `POS(#0)` |
| `LET` | (drop, or keep — your choice) |

---

## 9. Order of work that worked well for the other games

1. Type the **init / DIM / DEF FN** and the **DATA** first (including the encoded strings) and check
   them hard — most "won't run" bugs live here.
2. Add the **main loop + parser**, then the **subroutines** a block at a time, `RUN`-testing after each.
3. Save often. Build a `.dsk` when it's stable — I can do that, verify it round-trips, and add a
   README launcher, exactly like the other titles.

When you hit a line you can't get to behave on the CPC, paste me that line (or the routine around it)
and I'll work out the Locomotive BASIC equivalent with you.
