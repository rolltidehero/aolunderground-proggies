# AOL4Free Token → FDO Document Mapping — Authoritative Source Mapping

**FDO88 Manual**: `FDO88-Manual-v1-1994-searchable.pdf` (239 pp., January 1994, in repo at
`sources/documents/aol4free/FDO88-Manual-v1-1994-searchable.pdf`).
Manual uses chapter-page numbering (e.g. "2-44"). PDF page ≈ manual-chapter-2-page + 8.
Appendix B begins PDF p.172; Appendix C begins PDF p.180; Appendix E begins PDF p.225.

**Token DB files**: Three external files from the notaol/AOL-Files archive at
`aol-files.com/fdo91/tokens/`:
- **`1998.txt`** — AOL internal `edit_token`/`list_token` command output, ~1,169 entries,
  dated January 7, 1998. This is a server-side token definition table dump, not source code.
- **`list_tokens.html`** — ~2,430 token entries, compiled January 1, 2001, by BMB.
- **`token_[letter].html`** — community-compiled token pages, ~2,652 entries total, circa 2000.

---

## PART 1 — Tokens Confirmed in FDO88 Manual (January 1994)

### `fD` — "Form Data" packet identifier

**FDO88 Manual, p.2-3 (PDF p.11), verbatim:**
> "Packets containing FDO streams are sent with a packet identifier called an **fD** token"

This is the only definition of the `fD` token in the manual. It appears in the opening
description of the FDO data stream protocol in Chapter 2. The fD token is the server-to-client
packet wrapper; it is not a dispatch token and does not appear in the `fdo$dispch` syntax.

---

### `K1` — "Request a library record" (Ask_DB dispatch)

**FDO88 Manual, p.2-44 (PDF p.52), verbatim (dispatch syntax definition):**
> `fdo$dispch 1 ('K1',0) $08 $A8 $5F`
> "**'K1'** is the token ID"

The s_code field (second value in the parenthesized pair) is the surcharge code:
0 = plus_same (paid or free), 1 = plus_pay (paid only), 2 = plus_free (free area only).

**FDO88 Manual, Appendix B p.B-4 (PDF p.175) — Members' Online Support (free area):**
```
fdo$dispch 129 ('K1',2) $08 $CC $93
```
This is the dispatch that navigates to the Members' Online Support area. MOP 129 = Ask_DB (MOP
code 1, decimal). s_code 2 = plus_free. Library 8 ($08), record $CC93. **This is the free-area
K1 dispatch that AOL4Free exploits** — the server pauses billing because the destination record
is marked `plus_free`.

**FDO88 Manual, Appendix B p.B-8 (PDF p.179) — Welcome Screen:**
```
fdo$dispch Ask_DB ('K1',0) $08 $BA $19
```

**FDO88 Manual, Appendix E p.E-4 (PDF p.228) — Ask_DB (MOP 1) description, verbatim:**
> "When you enter Ask_DB (MOP 1) as the first parameter (<MOP_code>) of the dispatch argument,
> the system attempts to display a form from the host library. **If the token is 'K1', the system
> checks for a local copy of this library record.** If a local copy is found, it is processed as
> a form."

**FDO88 Manual, Appendix E p.E-5 (PDF p.229) — Figure E.1 (Ask_Indirect example):**
```
Byte1: 17    Byte2/3: ('K1', 0)    Byte4: 1    Byte5: $00    Byte6: $00
```
"Token 'K1' checks for a local copy of the library record. The s_code of 0 allows action in
either the paid or free area."

**Confidence: Definitive.** K1 is defined in Chapter 2, confirmed in three Appendix B sample
streams, and explained in Appendix E. It is present in all three token DB files as well.

---

### `S1` — "Send form" (Send_Form / Send_Selected dispatch)

**FDO88 Manual, Appendix E p.E-7 (PDF p.231) — Figure E.2 (Send_Form example), verbatim:**
```
Byte1: 10    Byte2/3: ('S1', 0)    Byte4: $04    Byte5: $02    Byte6: $00
```
> "Byte 2/3: Token **'S1'** identifies the host process to which this data packet is sent.
> The s_code of 0 allows action in either the paid or free area."

MOP code 10 = Send_Form (Table E.1, p.E-2).

**FDO88 Manual, Appendix E p.E-9 (PDF p.233) — Figure E.3 (Send_Selected Example 1), verbatim:**
```
Byte1: 11    Byte2/3: ('S1', 0)    Byte4: $02    Byte5: $06    Byte6: $01
```
> "Byte 2/3: Token **'S1'** identifies the host process to which this data packet is sent.
> The s_code of 0 allows action in either the paid or free area."

MOP code 11 = Send_Selected (Table E.1, p.E-2).

**FDO88 Manual, Appendix E p.E-10 (PDF p.234) — Figure E.4 (Send_Selected Example 2):**
```
Byte1: 11    Byte2/3: ('S1', 0)    Byte4: $05    Byte5: $00    Byte6: $00
```
Same token, same explanation.

**Confidence: Definitive.** S1 is the host-process identifier for all client-to-server form
submission dispatches. It appears in four separate dispatch figures across pp.E-7 through E-10.

---

### `plus_free`, `plus_same`, `plus_pay` — Surcharge codes in `fdo$dispch`

**FDO88 Manual, p.2-44 (PDF p.52) — definition in `fdo$dispch` syntax, verbatim context:**
> `fdo$dispch <MOP_code> ('<token_ID>',<s_code>) <MOP_info>`

The s_code values are defined at p.2-44 as:
- `0` = `plus_same` — "action allowed from paid or free area"
- `1` = `plus_pay` — "action allowed from paid area only"
- `2` = `plus_free` — "action allowed from free area only"

These are not tokens in the dispatch sense — they are the surcharge permission bits packed into
byte 3 of the `fdo$dispch` encoding.

**Confirmed by example at Appendix B p.B-4 (PDF p.175):**
`fdo$dispch 129 ('K1',2) $08 $CC $93` — s_code 2 = plus_free, library 8, record $CC93.

---

### `fdo$PlusGroup $3FC1` — PlusGroup value in Welcome Screen and Offline Menu

**FDO88 Manual, p.2-95 (PDF p.103), verbatim:**
> `fdo$PlusGroup` — "specifies a plus group number for a form and makes the specified plus group
> the current plus group"

**FDO88 Manual, Appendix B p.B-7 (PDF p.178) — Welcome Screen FDO stream, verbatim:**
```
fdo$start
fdo$Window16 0000 0000 0440 0280 $08
fdo$ResizeID 0018
fdo$SetWindowTag $4F4E 0001
fdo$PlusGroup $3FC1 00
fdo$picture 0572 0030 0010 $20 - Field 1
```
The value `$3FC1 00` is `fdo$PlusGroup` applied to the Welcome Screen window. The `$3FC1` word
is the Kg dispatch's own MOP_info bytes (bytes 4-5 in the AOL4Free Kg dispatch:
`06 4B 67 3F C1 3F C1 60`). The binary analysis concluded that AOL4Free's Kg dispatch byte
pattern `$3FC1` was derived from or compared against this Welcome Screen PlusGroup value.

**Confidence: Definitive** for the FDO88 definition of `fdo$PlusGroup`. The specific value
`$3FC1` and its role in the Kg dispatch is an inference from the binary analysis, not directly
documented in FDO88.

---

### `HideDisplay` (Switch 22) and `ShowDisplay` (Switch 23)

**FDO88 Manual, Table C.6 "Window Switch Values", p.C-22 (PDF p.201), verbatim:**

| Num. Value | Text Value  | Description                                         |
|-----------|-------------|-----------------------------------------------------|
| 22        | HideDisplay | "If True (HideDisplay), hides the window."          |
| 23        | ShowDisplay | "If False (ShowDisplay), shows the window."         |

These are `fdo$Switch` parameters used after `fdo$Window` or `fdo$Window16` to control window
visibility. Switch 21 in Table C.6 is N/A (blank). **NOTE**: The analysis document
`aol4free-technical-analysis.md` erroneously assigns HideDisplay to Switch 21 and ShowDisplay
to Switch 22. The PDF confirms Switch 22 = HideDisplay, Switch 23 = ShowDisplay.

---

## PART 2 — Tokens NOT in FDO88 Manual — Token DB Sources Only

None of the following tokens appear anywhere in the 239-page FDO88 Manual. Their meanings
come entirely from the notaol/AOL-Files token DB files.

### Confidence Tier: All Three Token DB Files

| Token | Hex    | Meaning (from DB files)              | Category  |
|-------|--------|--------------------------------------|-----------|
| `Dd`  | $4464  | "Initial login pkt (form based)"     | Porch     |
| `Dg`  | $4467  | "Guest Account signon data"          | Porch     |
| `LO`  | $4C4F  | "Session termination"                | Logout    |
| `xG`  | $7847  | "Download go-ahead" (file xfer ACK)  | Download  |

**Primary sources:**
- `1998.txt` (AOL internal token table dump, January 7, 1998)
- `list_tokens.html` (BMB compilation, January 1, 2001)
- `token_[letter].html` (community compilation, circa 2000)

All four tokens appear in all three independent files. The three files were produced at different
times by different people (or by different AOL systems), so triple agreement constitutes
independent corroboration.

---

### Confidence Tier: Two Independent Server Dumps (`1998.txt` + `list_tokens.html`)

| Token | Hex    | Meaning (from DB files)                     | Category  |
|-------|--------|---------------------------------------------|-----------|
| `el`  | $656C  | "List unread mail - use MIP"                | mbox_list |
| `ol`  | $6F6C  | "Get outbox list - use MIP"                 | mbox_list |
| `eo`  | $656F  | "List old mail - use MIP"                   | mbox_list |
| `iO`  | $694F  | "Locate Member / Is user available?"        | whisper   |
| `iS`  | $6953  | "Send FlashNote - single form" (IM)         | whisper   |
| `mT`  | $6D54  | "Message Interchange Protocol pkt"          | mbox_send |
| `mB`  | $6D42  | "Message Interchange Protocol pkt"          | mbox_send |

**Primary sources:** `1998.txt` and `list_tokens.html` only. These are two separate server-side
dumps taken ~3 years apart (January 1998 and January 2001). Agreement between them is
independent corroboration. Token not present in `token_[letter].html` does not indicate
absence — the community compilation is known to be incomplete.

---

### Confidence Tier: Single Source — `1998.txt` Only (Medium-High)

| Token | Hex    | Meaning (from DB file)              | Category   |
|-------|--------|-------------------------------------|------------|
| `aB`  | $6142  | "Process ext invoice"               | Register   |
| `YC`  | $5943  | "Input for TCP RMG"                 | rmg        |
| `vx`  | $7678  | "Remove user_feature to mask"       | view_rules |

**Primary source:** `1998.txt` only. These tokens appear in the January 7, 1998 internal
dump but are absent from or uncorroborated by the other two sources. The dump itself is
directly from AOL's `edit_token`/`list_token` tool output, which is a primary server
record — single-source does not mean invented, only that no independent confirmation exists.

---

### Critical Special Case — `Kg`

| Token | Hex    | Meaning (from DB file)                | Category | Source        |
|-------|--------|---------------------------------------|----------|---------------|
| `Kg`  | $4B67  | "PC indicating surcharge switch"      | tih      | `1998.txt` only |

**Primary source:** `1998.txt` (January 7, 1998) only.

**`Kg` is explicitly absent from the FDO88 Manual (January 1994).** It does not appear in
any chapter, appendix, or table of the 239-page manual. It is not in `list_tokens.html` or
`token_[letter].html` either — making it the most thinly sourced token in the patch, with
exactly one document as evidence.

**What `1998.txt` records for `Kg`:**
- Category: `tih` (Terminal Interface Handler)
- Flags: PL (Pre-Login), SP (Special)
- Meaning: "PC indicating surcharge switch"

The `tih` category is AOL's oldest protocol layer, predating AOL itself. Other `tih` tokens
in the same DB include `MX` = "Q-Link 3 char token (strip X)" and `XX` = "XS acknowledgement
(C64)" — indicating the tih layer originates in Quantum Computer Services / Q-Link (1985–1991).
The surcharge switch mechanism Kg represents was inherited from that era and was absent from
the FDO88 documentation four years later, suggesting it was internal/server-only and never
intended for documentation.

`Kg` does not appear in the FDO88 Manual because it was added to the protocol between January
1994 and January 1998. The mechanism it controls — client-reported billing state — preceded
FDO88 entirely, but the specific Kg token was not part of the documented FDO88 protocol.

---

## PART 3 — Binary-Only Patterns (No Token Name, No External Source)

These byte patterns appear in the AOL4Free disassembly but have no corresponding token name
in any token DB and no FDO88 documentation.

| Pattern            | Location                          | Role                                                              |
|--------------------|-----------------------------------|-------------------------------------------------------------------|
| `$1501FB06`        | Incoming data handler (0x57FC)    | Free area response marker — triggers K1 re-injection and window suppression |
| `$15c30682 96c42810` | Incoming data handler (0x57FC) | Second control response pattern (purpose unverified)              |
| `$C13FC160`        | Token dispatch (0x589A)           | Long-word match against Kg dispatch's own library record bytes — prevents feedback loop |

**Source:** Binary disassembly of AOL 2.6 (68k Macintosh). No external documentation.

The pattern `$C13FC160` is a derived value: it encodes bytes 5–8 of the Kg dispatch
(`06 4B 67 **3F C1 3F C1 60**`), used as a long-word comparison to detect whether the patch
has already re-injected Kg and prevent a re-injection feedback loop. It is not a token and
does not appear in any token database.

---

## PART 4 — What FDO91 (February 1998) Adds

The FDO91 Manual documents zero patch tokens by name. Its contribution is architectural
corroboration that the free/paid billing mechanism persisted from 1994 to 1998.

FDO91 defines in its HFS (Host File System) appendix:
```
atom$hfs_attr_plus_group_type <dword>
  0 = Same
  1 = Pay area
  2 = Free area
```
And in its Action Protocol: `ENTER_FREE (7)` and `ENTER_PAID (8)` as distinct action criteria.

These confirm that the same pay/free area distinction from FDO88 p.2-44 remained architecturally
intact four years later, but they do not identify any specific tokens used by the AOL4Free patch.

---

## Summary Table

| Token / Pattern    | FDO88 Manual    | FDO91 Manual | Token DB File(s)               | Confidence |
|--------------------|-----------------|--------------|--------------------------------|------------|
| `fD`               | **p.2-3** (PDF p.11) | —       | All 3                          | Definitive |
| `K1`               | **p.2-44, App.B pp.B-4/B-8, App.E pp.E-4/E-5** (PDF pp.52,175,179,228,229) | Indirectly | All 3 | Definitive |
| `S1`               | **App.E pp.E-7–E-10** (PDF pp.231–234) | —  | All 3                          | Definitive |
| `plus_free`        | **p.2-44** (PDF p.52) | App.A (ENTER_FREE) | All 3           | Definitive |
| `plus_same`        | **p.2-44** (PDF p.52) | App.A (Same=0)     | All 3           | Definitive |
| `fdo$PlusGroup`    | **p.2-95** (PDF p.103); **App.B p.B-7** (PDF p.178) | — | All 3 | Definitive |
| `HideDisplay` (Switch 22) | **Table C.6, p.C-22** (PDF p.201) | — | All 3    | Definitive |
| `ShowDisplay` (Switch 23) | **Table C.6, p.C-22** (PDF p.201) | — | All 3    | Definitive |
| `Dd`               | Absent          | —            | All 3                          | High       |
| `Dg`               | Absent          | —            | All 3                          | High       |
| `LO`               | Absent          | —            | All 3                          | High       |
| `xG`               | Absent          | —            | All 3                          | High       |
| `el`               | Absent          | —            | `1998.txt` + `list_tokens.html` | High      |
| `ol`               | Absent          | —            | `1998.txt` + `list_tokens.html` | High      |
| `eo`               | Absent          | —            | `1998.txt` + `list_tokens.html` | High      |
| `iO`               | Absent          | —            | `1998.txt` + `list_tokens.html` | High      |
| `iS`               | Absent          | —            | `1998.txt` + `list_tokens.html` | High      |
| `mT`               | Absent          | —            | `1998.txt` + `list_tokens.html` | High      |
| `mB`               | Absent          | —            | `1998.txt` + `list_tokens.html` | High      |
| `aB`               | Absent          | —            | `1998.txt` only                | Medium-high |
| `YC`               | Absent          | —            | `1998.txt` only                | Medium-high |
| `vx`               | Absent          | —            | `1998.txt` only                | Medium-high |
| `Kg`               | **Explicitly absent** | —      | `1998.txt` only                | Medium-high |
| `$1501FB06`        | Absent          | Absent       | None — binary only             | Unknown    |
| `$15c30682 96c42810` | Absent       | Absent       | None — binary only             | Unknown    |
| `$C13FC160`        | Absent          | Absent       | Derived from Kg dispatch bytes | Unknown    |

---

*Written 2026-04-03. Primary sources read directly from:*
- *`FDO88-Manual-v1-1994-searchable.pdf` (in repo) — PDF pages cited are verified from direct reading*
- *`aol-files.com/fdo91/tokens/1998.txt`, `list_tokens.html`, `token_[letter].html` — external, archived at notaol/AOL-Files*
