# Laserwarp (Amstrad CPC) — Disassembly Notes

**Game:** Laserwarp / *Attaque au Laser* — Amsoft / Mikro-Gen, 1985. Vertically-scrolling
fixed shoot-'em-up; original code by Chris Hinsley.

**This revision is built from the cassette image `Laserwarp (E).cdt`,** which is a far better
source than the earlier `LASERWRP.BIN` and is what these notes now describe. The `.cdt` gives
the **complete, CRC-verified, uncracked** game; the old `.BIN` was only a partial cracked rip.

Deliverables: `LASERWARP.asm` (full annotated listing of the `&4000–&88FF` image),
`laserwarp_full.bin` (the reconstructed binary), `basic_loader.bin` (the BASIC loader), and
these notes. Tooling (`z80disasm.py`, `firmware.py`, `cdt` parser in `generate_full.py`) is
included for reproducibility.

---

## 1. Why the tape is the better source

| | Old `LASERWRP.BIN` | Tape `Laserwarp (E).cdt` |
|---|---|---|
| Coverage | ~13 KB, `&4000–&73xx` only | **Full 18,688 bytes, `&4000–&88FF`** |
| Main loop at `&75FE` | **missing** (jumped outside the file) | **present and disassembled** |
| Integrity | cracked/modified; garbled message text; `CHANY from NPS` / `Doctor Fegg` tags | **clean original; all 95 tape chunks pass CRC** |
| Loader | none | **BASIC loader included** |

The two share only the first 159 bytes (`&4000–&409E`: entry stub + sound init + envelopes);
from `&409F` on they differ almost completely, so the old file was a genuinely different,
modified build — not just a subset.

## 2. Tape structure

The CDT is a TZX 1.0 container. Data is carried in "turbo" (0x11) blocks, each CPC record
being a sync byte (`0x2C` header / `0x16` data) followed by 256-byte chunks each protected by a
16-bit CRC (CRC-16/CCITT, stored complemented). **All 95 chunks verified**, so the
reconstruction is exact. The tape holds two files:

**File 1 — BASIC loader** (type `&01`, loads at `&0170`, 2,510 bytes). It paints the title
screen — its strings include `"AND"`, `"PRESENT"`, `"L A S E R W A R P"`, `"!"` — then loads
and runs the machine-code file.

**File 2 — machine code** (type `&02`), 10 blocks loading contiguously:

```
block 1  &4000  2048      block 6  &6800  2048
block 2  &4800  2048      block 7  &7000  2048
block 3  &5000  2048      block 8  &7800  2048
block 4  &5800  2048      block 9  &8000  2048
block 5  &6000  2048      block 10 &8800   256
```

→ one image `&4000–&88FF`, total length `&4900` (18,688 bytes), matching the header's logical
length field exactly.

## 3. Run-time memory map

| Range | Size | Contents |
|---|---|---|
| `&4000–&4007` | 8 | Entry stub: `call snd_init` ; `jp main` |
| `&4008–&4064` | 93 | Sound + ink initialisation |
| `&4065–&414F` | ~235 | Sound envelopes (6 amplitude + 4 tone), sound-effect blocks, ink-setup string, `SCORE=`/`SECTION=` panel strings |
| `&4150–&6865` | ~10 KB | **Sprite & character graphics** (player, enemies, explosions) |
| `&6866–&7BC8` | ~5 KB | **Game routines** — drawing, movement, collision, scoring, and the main loop at `&75FE` |
| `&7BC9–&8881` | ~3.3 KB | **"THE MASTER" message text**, enemy names, "sheet complete" lines, UI prompts |
| `&8882–&88FF` | ~126 | Small trailing tables |

Recursive-descent from the real entry point reaches ~3.75 KB of code (20% of the image); the
remaining ~80% is graphics, text and tables — a normal ratio for a sprite-heavy 1985 CPC game.

## 4. Control flow that is now resolved

```
entry  &4000  call snd_init        ; install envelopes, program inks
              jp   main (&75FE)
main   &75FE  ld   hl,&4118        ; status-panel string
              call print_string    ; (&405B - the TXT OUTPUT loop from init)
              ld   a,&03           ; 3 lives
              ld   (&7816),a
              ld   (&726F),a
              call sub_7270        ; set up a new game / sheet
              ...
              jp   L_781A          ; enter the per-frame game loop
```

`print_string` (`&405B`) is the small routine `ld a,(hl) : cp &FF : ret z : call TXT OUTPUT :
inc hl : jr` that the init code and main loop both reuse to print `&FF`-terminated strings.
The main loop maintains lives/score/sheet state in a `&72xx–&78xx` variable block and drives
the enemy waves.

## 5. Sound initialisation (`&4008`) — unchanged and confirmed

Installs ten envelopes via the firmware (`call &BCBC` = SOUND AMPL ENVELOPE,
`call &BCBF` = SOUND TONE ENVELOPE), then prints the ink-setup string at `&40D2` (a run of
control-code `&1C` "set ink" triples) to program the 16-pen palette. Decoded envelopes:

```
Amplitude (step-count, step-size, pause):
  1 (15,255,3)  2 (15,255,5)  3 (8,1,6)  4 (7,254,40)
  5 (10,0,1)(10,255,6)(5,255,7)  6 (15,255,60)
Tone:
  1 (0,60,1)(120,3,1)  2 (0,50,1)(100,1,1)  3 (0,20,1)(100,0,1)  4 (100,1,5)
```

## 6. Firmware usage

Standard CPC 464 jumpblock: `KM INITIALISE/RESET`, `KM TEST KEY`, `KM GET JOYSTICK`,
`TXT INITIALISE`, `TXT OUTPUT`, `TXT CLEAR WINDOW`, `SCR SET MODE`, `SCR SET INK`,
`SCR SET BORDER`, `SOUND QUEUE`, `SOUND AMPL ENVELOPE`, `SOUND TONE ENVELOPE`. All referenced
entries are listed as `equ` defs at the top of the listing.

## 7. The script (now complete and clean)

The player is "Earth's greatest defender" facing **THE MASTER** across numbered "sheets". You
start with **3 lives + 1 per 10,000 points**. The enemy waves are:

> WHIRLING DERVISHES · SPACE MINES · RAMSHIPS · INTERSTELLAR POGOS · GALACTIC SPIDERS ·
> COSMIC SPINNERS · ARMOURED DROID · HYPERSPACE CHICKENS

with "Sheet *n* complete" lines and taunts between waves. The tape's text is intact, unlike the
cracked `.BIN` where these strings were corrupted. UI strings: `SCORE=`, `SECTION=`,
`PLEASE ENTER NAME`, `LEVEL (1-9)`, `PRACTICE SHEET`, and the French `VIES INFINIES (O/N) ?`.

## 8. Verification

1. **Tape CRCs** — all 95 data chunks pass CRC-16/CCITT, so the `&4000–&88FF` image is an exact
   bit-for-bit reconstruction of the original tape.
2. **Decoder self-test** — `z80disasm.py` passes 50/50 hand-checked opcode cases across every
   prefix family (CB, ED, DD/FD, DDCB), addressing modes, jumps/calls, block ops and I/O.
3. **Byte-exact round-trip** — re-concatenating every emitted instruction and every `defb`
   block reproduces the 18,688-byte image exactly.

## 9. Taking it further

- Code coverage is the flow-reachable spine (~20%); some routines are reached only through
  data-driven jump tables / `jp (hl)` dispatch that static descent doesn't follow. Seeding the
  disassembler with those table targets (or tracing in an emulator's monitor) would lift it.
- The graphics block `&4150–&6865` is raw sprite/character bitmaps; a CPC sprite viewer (mode-1
  4-colour, 2 pixels/byte) would render them.
- To rebuild a working tape/disk: re-assemble the code, `incbin` the data regions at their
  load addresses, and reproduce the BASIC loader (or just `LOAD` the binary at `&4000` and
  `CALL &4000`).
```
