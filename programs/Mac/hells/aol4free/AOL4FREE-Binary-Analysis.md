# AOL4Free v4: Binary Disassembly Analysis

## Method

Extracted `AOL4FREE2.6v4.sit` (MacBinary II + StuffIt) using `unar` on Linux. Parsed the
AppleDouble resource fork of `Install AOL4Free2.6 v4.rsrc` to recover all Mac resource types.
Found the patch data in custom `ZAP ` resources and patch site maps in `ZIS#` resources.
Disassembled the 68k machine code using Capstone (M68K mode) with addresses reconstructed
from the ZIS# patch site offsets.

The patcher modifies four files: America Online v2.6 (main app), Chat, File Transfer, and Mail
(Online Tools). The critical patches are in the `P3` CODE segment (AOL's protocol handler),
the `Events` segment (event loop), and the `File Transfer` tool.

---

## Patch Architecture

The P3 CODE segment receives 4 patches totaling 460 bytes:

| Site | CODE Offset | Size | Purpose |
|------|------------|------|---------|
| 1 | `0x1ABA` | 4 bytes | `BRA.W $57FC` — redirects incoming data handler |
| 2 | `0x56A4` | 4 bytes | `JSR $589A(PC)` — hooks outgoing token dispatch |
| 3 | `0x56CE` | 4 bytes | `BRA.W $5866` — intercepts HideDisplay commands |
| 4 | `0x57FC` | 448 bytes | Main code block (all new logic) |

The first three sites replace single instructions with branches/calls into the 448-byte code block at `0x57FC`.

---

## The Two Free-Area Dispatch Tokens

Two 8-byte dispatch data blocks are embedded in the code. The first byte ($06) is a **length prefix** (6 bytes of dispatch payload follow), NOT a MOP code. This was proven by the Menus patch which constructs an "MR" dispatch with the same $06 prefix — MR uses Ask_DB (MOP 1/2), not Send_DB (MOP 6).

### K1 Dispatch (address `0x5890`)

```
Hex: 06 4B 31 40 61 42 71 69
      │  └──┘  │  └──────────┘  │
      │  "K1"  │  parameters    │ extra
      len=6    $40              $69
```

- **Token:** `K1` — **"Request a library record"** (confirmed: notaol/AOL-Files DB, category: Library)
- **Function:** Navigates to a free area — the server pauses billing because the destination is marked free
- **Parameters:** `$40 61 42 71 69` — library record address (specific free area unverified)
- **cf. FDO88 Appendix B:** `fdo$dispch 129 ('K1',2) $08 $CC $93` = Members' Online Support (plus_free)
- Used for: general free-area injection (most tokens, event loop, file transfers)

### Kg Dispatch (address `0x5982`)

```
Hex: 06 4B 67 3F C1 3F C1 60
      │  └──┘  └──┘  └──────┘  │
      │  "Kg"  $3FC1  params    │ extra
      len=6   (PlusGroup?)     $60
```

- **Token:** `Kg` — **"PC indicating surcharge switch"** (confirmed: notaol/AOL-Files DB, category: tih, flags: PL, SP)
- **Function:** Directly tells the host to **switch the billing/surcharge state** — does NOT navigate to an area
- **$3FC1:** Matches the PlusGroup value from `fdo$PlusGroup $3FC1 00` in the Welcome Screen and Offline Menu FDO streams (FDO88 Manual, Appendix B). PlusGroup "specifies a plus group number for a form and makes the specified plus group the current plus group" (FDO88 p.2-95). The `$3FC1` value likely identifies the free billing group.
- **Note:** `Kg` does NOT appear in the FDO88 Manual (January 1994). It was likely added to the protocol between 1994 and 1995.
- Used for: email and IM operations only (which AOL had partially protected)

---

## Token Decision Table

When the patched client is about to send any token to AOL's servers, the code at `0x589A` reads the 2-byte token from the outgoing packet at `1(A4)` and compares it against a hardcoded list:

### Group 1 — SKIP injection (no free-area token sent)

| Token | Hex | Branch | Confirmed Meaning (source: notaol/AOL-Files DB) |
|-------|-----|--------|---------|
| `Dd` | `$4464` | `→ 0x591E` | **Initial login pkt (form based)** — THE v4 STEALTH FIX |
| `Dg` | `$4467` | `→ 0x591E` | **Guest Account signon data** (category: Porch) |
| `LO` | `$4C4F` | `→ 0x591E` | **Session termination** (category: Logout) |
| `xG` | `$7847` | `→ 0x591E` | **Download go-ahead** — file transfer ACK (category: Download) |
| `vx` | `$7678` | `→ 0x591E` | **Remove user_feature to mask** (category: view_rules; checked at 0(A4)) |

These tokens set the `'i'` flag at low memory `$5` and return. **No K1 or Kg is sent.** This is how v4 avoids the `CMis` detection — by never injecting a free-area request during the signon sequence.

The code also checks for the long word `$C13FC160` at `4(A4)` — this matches the Kg dispatch's own library record, preventing a re-injection feedback loop.

### Group 2 — DEFERRED K1 injection (via event loop)

| Token | Hex | Branch | Confirmed Meaning |
|-------|-----|--------|---------|
| `mT` | `$6D54` | `→ 0x592A` | **Message Interchange Protocol pkt** (category: mbox_send) |
| `YC` | `$5943` | `→ 0x592A` | **Input for TCP RMG** (category: rmg) |

These set the `'3'` flag at low memory `$6` and the `'i'` flag. The K1 dispatch is NOT sent immediately. Instead, the Events handler picks up the `'3'` flag on the next event loop iteration and sends K1 then — a **deferred injection** to avoid timing issues.

### Group 3 — IMMEDIATE Kg injection (email/IM)

| Token | Hex | Branch | Confirmed Meaning |
|-------|-----|--------|---------|
| `el` | `$656C` | `→ 0x5950` | **List unread mail - use MIP** (category: mbox_list) |
| `ol` | `$6F6C` | `→ 0x5950` | **Get outbox list - use MIP** (category: mbox_list) |
| `eo` | `$656F` | `→ 0x5950` | **List old mail - use MIP** (category: mbox_list) |
| `iO` | `$694F` | `→ 0x5950` | **Locate Member / Is user available?** (category: whisper) |

These call `SendDispatch()` with the **Kg** dispatch (not K1). This matches Happy Hardcore's documentation: *"IMs and Email were the only two activities AOL had partially 'protected.'"* A different free-area token was needed for these operations.

### Group 4 — CONDITIONAL Kg injection

| Token | Hex | Branch | Confirmed Meaning |
|-------|-----|--------|---------|
| `iS` | `$6953` | `→ 0x595E` | **Send FlashNote - single form** (category: whisper) — i.e. Instant Message |

Sends Kg only if the `'3'` flag is NOT already set. Then sets both `'3'` and `'i'` flags. This prevents duplicate injection if a deferred injection is already pending.

### Group 5 — Special flag manipulation

| Token | Hex | Branch | Confirmed Meaning |
|-------|-----|--------|---------|
| `aB` | `$6142` | `→ 0x598C` | **Process ext invoice** (category: Register) — billing/registration |
| `mB` | `$6D42` | `→ 0x59A6` | **Message Interchange Protocol pkt** (category: mbox_send) |

- `aB`: Sets `'i'` flag. If bytes at `6(A4)` are NOT `"qi"`, also sets `'U'` flag at `$4`.
- `mB`: Sets `'i'` flag only if `$7` contains `'w'`.

### Default — NO match

If the token doesn't match any of the above: **returns unchanged** (no injection from this function). The injection for normal tokens happens via the Events handler and File Transfer handler, not here.

---

## Event Loop Injection (ZAP 'Events')

Patched into the `Events` CODE segment. On every event loop iteration:

```asm
0x0fb2:  jsr    $5a30(pc)       ; call original event handler
0x0fb6:  nop
0x0fb8:  nop
0x0fba:  jsr    $5a1a(pc)       ; call another original handler
0x0fbe:  nop
0x0fc0:  nop
0x0fc2:  pea    -$2ab0(a5)      ; push some AOL data pointer
0x0fc6:  jsr    $1cea(a5)       ; call AOL EventHandler routine
0x0fca:  move.b $6.w, d0        ; read '3' flag
0x0fce:  cmp.b  #$33, d0        ; is it '3'?
0x0fd2:  bne    $0fe2           ; if not, skip
0x0fd4:  move.b #$0, $6.w       ; clear '3' flag
0x0fda:  pea    K1_data(pc)     ; push K1 dispatch data
0x0fde:  jsr    $efa(a5)        ; SendDispatch() → SEND K1 FREE-AREA TOKEN
0x0fe2:  rts
```

**This is the primary injection mechanism for most tokens.** Any token that sets the `'3'` deferred flag (directly or via other handlers) triggers K1 injection here on the next event cycle.

---

## File Transfer Injection (ZAP 'File Transfer')

Patched into the File Transfer Online Tool:

```asm
0x0004:  pea    K1_data(pc)     ; push K1 dispatch data
0x0008:  jsr    $efa(a5)        ; SendDispatch() → SEND K1 FREE-AREA TOKEN
0x000c:  move.b d7, d0
0x000e:  movem.l -$15a(a6), d7/a3-a4
0x0014:  unlk   a6
0x0016:  rts
```

Sends K1 on every file transfer operation.

---

## Incoming Data Interception (0x57FC)

The handler at patch site 1 intercepts incoming server data:

1. **Extends/clears a buffer** (up to 127 extra bytes) to prevent overflow
2. **Checks for the free area response marker** `$1501FB06` at the start of the data:
   - If found: calls the original `ProcessIncoming()`, then immediately sends **K1** to re-enter the free area, then returns to normal code flow at `0x1ABE`
   - This is how the **Free Area window is suppressed** — the response is processed (so the server thinks the client received it) but the client immediately re-requests the free area
3. **Checks the 'U' flag** at `$4`: if set to `'U'` ($55), clears it
4. **Checks for another data pattern** `$15c30682 96c42810` — possibly a second control response

---

## HideDisplay Suppression (0x5866)

Patch site 3 intercepts the `HideDisplay` FDO switch command (Window Switch 22, FDO88 Table C.6 p.C-22):

```asm
0x5866:  move.b -$3d65(a5), d0  ; read AOL internal flag
0x586a:  beq    $5886           ; if zero, skip entirely (not in free area)
0x586c:  move.b $5.w, d0        ; read 'i' flag
0x5870:  cmp.b  #$69, d0        ; is it 'i'?
0x5874:  bne    $587e           ; if not, send K1
0x5876:  move.b #$0, $5.w       ; clear 'i' flag
0x587c:  bra    $5886           ; SKIP the HideDisplay — windows stay open
0x587e:  pea    K1_data(pc)     ; otherwise, push K1 dispatch
0x5882:  jsr    $efa(a5)        ; SendDispatch() — re-enter free area
0x5886:  movem.l (a7)+, ...     ; restore registers
0x588e:  rts
```

When the server sends `HideDisplay` (telling the client to close all windows except the free area):
- If the `'i'` flag is set: **ignores the command** — chat, email, download windows remain visible
- If `'i'` is not set: sends another K1 to re-enter the free area

---

## Low Memory Flag System

AOL4Free stores 4 bytes of global state in the 68k reset vector area (`$0004`–`$0007`), which is dead memory on a running Macintosh:

| Address | Flag | ASCII | Set By | Consumed By | Purpose |
|---------|------|-------|--------|-------------|---------|
| `$4` | `'U'` | $55 | `aB` handler | Incoming data handler | Action button state |
| `$5` | `'i'` | $69 | Most token handlers | HideDisplay suppressor | "Injection marker" — prevents re-injection |
| `$6` | `'3'` | $33 | `mT`, `YC`, `iS` handlers | Events loop handler | "Deferred injection" — triggers K1 on next event |
| `$7` | `'w'` | $77 | (external/read-only) | `mT`, `YC`, `mB` handlers | Conditional check (possibly "web active" flag) |

---

## Complete Token Flow

### Normal browsing (e.g., entering a chat room):

```
Client sends: K1 (Chat Rooms)
  → Token dispatch hook at 0x589A
  → K1 doesn't match any special case → default return
  → Events handler checks '3' flag → if set, sends K1(free) → billing paused
```

### Signon (the v4 stealth fix):

```
Client sends: Dd (screen name + password)
  → Token dispatch hook at 0x589A
  → Matches 'Dd' → sets 'i' flag, returns WITHOUT sending K1(free)
  → No CMis error in server logs
  → Next token after signon completes → resumes normal injection
```

### Sending an IM:

```
Client sends: iO (IM outgoing)
  → Token dispatch hook at 0x589A
  → Matches 'iO' → sends Kg(free) immediately → billing paused for IM
  → Server sends free area response
  → Incoming handler intercepts $1501FB06 → suppresses window, re-sends K1
```

### Server sends HideDisplay after free area entry:

```
Server sends: HideDisplay (FDO switch 21)
  → Patch site 3 redirects to 0x5866
  → Checks 'i' flag at $5
  → If 'i' set → IGNORES HideDisplay → windows stay open
  → Chat, email, downloads remain visible despite billing being paused
```

---

## Confirmation of Technical Analysis Claims

| Claim from Documentation | Binary Evidence |
|--------------------------|-----------------|
| "K1(free) sent after every outgoing token" | Events handler sends K1 when '3' flag is set; File Transfer sends K1 directly |
| "v4 stops sending K1 after Dd" | Token table at 0x589A: `Dd` branches to 0x591E which ONLY sets flag, no dispatch |
| "Intercepts Free Area window" | Incoming handler checks for `$1501FB06` marker, calls ProcessIncoming then re-enters free area |
| "Ignores HideDisplay commands" | Patch site 3 at 0x56CE redirects to 0x5866 which skips HideDisplay (Switch 22) when 'i' flag set |
| "IMs and Email needed special handling" | Tokens `el`, `ol`, `eo`, `iO`, `iS` all use the **Kg** ("surcharge switch") dispatch instead of K1 |
| "AOL4Free... immediately re-entering free area" | Both incoming handler (0x5856) and HideDisplay handler (0x587E) call `SendDispatch()` with K1 data |

## Cross-Reference: FDO88 Manual Discrepancies

| Item | AOL4FREE-Technical-Analysis.md | FDO88 Manual (Jan 1994) | Status |
|------|-------------------------------|------------------------|--------|
| HideDisplay switch | "Table C.6, switch 21" | **Switch 22** (p.C-22); switch 21 = N/A | **ERROR in tech analysis** |
| ShowDisplay switch | "Table C.6, switch 22" | **Switch 23** (p.C-22) | **ERROR in tech analysis** |
| Dispatch format | "6-byte dispatch" | 6-byte dispatch: MOP(1) + packed_token_scode(2) + MOP_info(3) | Confirmed; internal format is unpacked |
| Token+s_code packing | Not described | char1 << 1, char2 << 2 \| s_code (verified against Appendix B samples) | **New finding** |
| K1 token meaning | "Fetch area" | "Request a library record" (Ask_DB, MOP 1) | Confirmed |
| Kg token | "Different free area" | **Not in FDO88 Manual** — added post-1994. Confirmed as "PC indicating surcharge switch" from notaol/AOL-Files DB | **Major finding** |
| $3FC1 value | Not analyzed | PlusGroup $3FC1 in Welcome Screen and Offline Menu (Appendix B, p.B-2/B-7). fdo$PlusGroup "specifies a plus group number for a form" (p.2-95) | **Probable connection** to Kg dispatch data |

## Token Meanings — Source Provenance

Token meanings are from the notaol project's compiled token database, which aggregates **three distinct sources** with different authority levels:

### Source 1: `1998.txt` — AOL Internal Server Dump (January 7, 1998)

**This is a genuine dump of AOL's internal Stratus host token table**, generated using the `edit_token` / `list_token` commands. It was obtained and published by the AOL-Files community via the Wayback Machine (`aol-files.com/fdo91/tokens/1998.txt`). It contains ~1,169 tokens with categories, flags, and descriptions.

**The `Kg = "PC indicating surcharge switch"` definition comes exclusively from this source.** It is categorized as `tih` (Terminal Interface Handler) with flags `PL` (Platform) and `SP` (Special). Other tokens in the `tih` category include Q-Link era references:
- `MX` = "Q-Link 3 char token (strip X)"
- `XX` = "XS acknowledgement (C64)" — referencing the Commodore 64
- `PD` = "PC requests circular dump"
- `S#` = "Speed indication"

This places `Kg` in the **earliest stratum of the AOL protocol**, dating back to Quantum Computer Services / Q-Link (1985-1991). The surcharge switch mechanism predates AOL itself.

**`Kg` does NOT appear in Sources 2 or 3** — it was never independently documented by the community, consistent with it being an internal/server-side token.

### Source 2: `list_tokens.html` — Server Dump (January 1, 2001)

A later server dump obtained by BMB (aol-files.com operator). Contains ~2,430 tokens but without flags. Newer categories like `a2k_search` (AOL 2000) confirm this is from the AOL 5.0/6.0 era.

### Source 3: `token_*.html` — Community-Compiled Database (~2000)

Per-letter HTML pages with ~2,652 token entries including argument values and form IDs. Community-contributed descriptions. Copyright 2000 by AOL-Files / Tau Productions.

### Confidence Assessment

| Token | Source | Authority |
|-------|--------|-----------|
| `Dd`, `Dg`, `LO`, `xG` | All three sources | High — independently confirmed |
| `el`, `ol`, `eo`, `iO`, `iS`, `mT`, `mB` | Sources 1 and 2 (server dumps) | High — two independent server dumps |
| `aB`, `YC`, `vx` | Source 1 (1998 server dump) | Medium-high — single authoritative source |
| **`Kg`** | Source 1 only (1998 server dump) | **Medium-high — single source, but it's a genuine server dump, not community guesswork** |
| `K1`, `S1`, `fD` | FDO88 Manual + all sources | Definitive |

### Additional Cross-References: FDO91 Manual (February 1998)

The FDO91 Manual (Host Forms Server chapter, koin.org/files/aol.aim/aol/fdo/manuals/hfs.pdf) **independently confirms** the plus group billing mechanism:

```
atom$hfs_attr_plus_group_type <dword>
  0 = Same
  1 = Pay area
  2 = Free area
```

Example from the manual: `atom$hfs_attr_plus_group_number <34>` with `atom$hfs_attr_plus_group_type <2>` (free area). This confirms the surcharge system persisted from FDO88 (1994) through FDO91 (1998).

The FDO91 Action Protocol also documents `ENTER_FREE (7)` and `ENTER_PAID (8)` as action criteria, confirming the free/paid area switching mechanism at the form level.

### Token Flag Meanings

From the third agent's research, confirmed by AOL4Free documentation:
- **PL = Pre-Login** — tokens that can be sent before the user is fully authenticated. The AOL4Free docs state "K1 is marked pre-login," and both K1 and Dd carry the PL flag.
- **SP** — likely "Special" or "Sign-on Process" — appears on login-related tokens
- **tih = Terminal Information Handler** — confirmed as a real AOL server-side process by NINA Wiki's architecture page. Controls client-host communications. The Kg token's tih category places it in AOL's oldest protocol layer, inherited from Q-Link/Quantum Computer Services (1985-1991).

---

*Disassembled from `AOL4FREE2.6v4.sit`, Happy Hardcore's stealth release of September 13, 1995.*
*Analysis performed 2026-04-01/02 using unar, Python struct, and Capstone 68k disassembler on Linux.*
*Cross-referenced against FDO88 Manual v1 (January 1994, 239 pages) and notaol token database.*
