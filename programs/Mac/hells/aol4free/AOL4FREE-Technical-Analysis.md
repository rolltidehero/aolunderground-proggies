# AOL4Free: Complete Technical Analysis

## What It Was

AOL4Free was a binary patcher for the Macintosh AOL 2.5/2.6 client software, written by Nicholas Ryan (handle: **Happy Hardcore**) and first released June 12, 1995. It allowed users to access all of AOL's paid services — chat, email, file downloads, web browsing — without being charged the $3/hour usage fee. The $10/month base fee was unaffected.

The patcher modified four files: the main AOL application and three Online Tools (`Chat`, `File Transfer`, and `Mail`). It did not modify the Online Database, so account information was preserved.

## How AOL's Protocol Worked

### Tokens

AOL's client-server communication used a **token language**. A token is a 2-character code identifying the type of message. Every action in AOL — clicking a button, opening an area, sending a message — sent a token from the client to the server.

Key tokens:

| Token | Name | Direction | Purpose |
|-------|------|-----------|---------|
| `Dd` | Signon | Client → Server | Sends screen name and password to authenticate |
| `K1` | Request a library record | Client → Server | Requests a specific area's content by library record address |
| `Kg` | Surcharge switch | Client → Server | Directly changes billing state (used for email/IM operations) |
| `S1` | Send form | Client → Server | Sends user-entered form data (chat messages, search queries, etc.) |
| `fD` | Form data | Server → Client | Packet containing FDO commands to draw a window (buttons, lists, text fields) |
| `HideDisplay` | Hide window | Server → Client | FDO switch command telling the client to hide a window |
| `ShowDisplay` | Show window | Server → Client | FDO switch command telling the client to show a hidden window |

### The 6-Byte Dispatch

Every button in AOL contained a 6-byte dispatch structure that was sent to the server when clicked:

```
Byte 1:     MOP code (what action to take)
Bytes 2-3:  Token (2-letter code) + billing flag (2-bit surcharge code)
Bytes 4-6:  Three subparameters (usually a library record address)
```

The **billing flag** (called `s_code` or "surcharge code" in AOL's internal documentation) had three values:

| Flag | Value | Meaning |
|------|-------|---------|
| `plus_same` | 0 | Action works in paid or free areas — no billing change |
| `plus_pay` | 1 | Action only allowed in paid areas |
| `plus_free` | 2 | Action only allowed in free areas — triggers billing pause |

### Free Areas

AOL had "free areas" — Member Services, Customer Service, billing help — where the usage meter was paused. When a user clicked a button with the `plus_free` billing flag:

1. Client sends `K1` with `plus_free` flag to the server
2. Server pauses billing
3. Server sends the free area window content (`fD` packet)
4. Server sends `HideDisplay` commands telling the client to hide all other windows
5. Client obeys — hides chat, email, downloads; only the free area window is visible
6. When user clicks "Exit Free Area," client sends an exit dispatch, server resumes billing, client shows hidden windows via `ShowDisplay`

**The design flaw:** Step 4-5 was enforced entirely by the client. The server sent `HideDisplay` as a request, but never verified the client actually hid the windows. The server also continued serving paid content (chat, email, files) even while billing was paused — it never checked.

## How AOL4Free Worked

The patched client made three modifications:

### 1. Injected a free-area token after most outgoing tokens

Every time the client sent most tokens to the server, the patch sent a free-area dispatch afterward. This kept billing paused after nearly every action. However, the injection was selective — certain tokens (login `Dd`, guest signon `Dg`, logout `LO`, download ACK `xG`) were deliberately skipped, and email/IM tokens used a different dispatch token (`Kg`, a surcharge switch) instead of `K1`. Some injections were deferred to the next event loop cycle rather than sent immediately.

From Happy Hardcore's documentation:
> *"Every time you send certain tokens to the host, a 'free area' token is sent right afterwards. It works like this: you go to keyword 'Rockline', but as soon as you get there, AOL4Free tells the host to go to the free area."*

The token flow for v1–v3 looked like this:

```
Normal client:   Dd → (signon)
                 K1 → (Chat Rooms)
                 S1 → (chat message)

Patched client:  Dd → K1(free) → (signon, then immediately pause billing)
(v1-v3 only)     K1 → K1(free) → (Chat Rooms, then immediately pause billing)
                 S1 → K1(free) → (chat message, then immediately pause billing)
```

**Note:** v4 fixed the `Dd → K1(free)` sequence — see "v4: The Stealth Fix" below.

### 2. Intercepted and suppressed the Free Area window

Since the server sent the Member Services window content every time it received the free-area `K1`, the patched client intercepted this response and discarded it. Without this, the Free Area window would pop up on screen after every single action.

> *"AOL4Free conveniently intercepts the Free Area window information (so you don't get the damn window constantly being re-displayed)"*

### 3. Ignored `HideDisplay` commands

The server sent `HideDisplay` switch commands with every free-area response, telling the client to hide all other windows. The patched client ignored these commands, so chat, email, and download windows remained open and functional.

> *"[AOL4Free] stops your 'Rockline' window from being closed."*

### Why billing resumed and had to be re-paused

From Happy Hardcore:
> *"It turned out that whenever you go somewhere, or send a chat message or an IM, the host resumes billing."*

This is why the free-area injection had to happen after **most** outgoing tokens — not just once. The server re-enabled billing whenever it processed a new action from the user. The injected free-area dispatch (`K1` for most tokens, `Kg` for email/IM) immediately paused it again.

### Special cases

- **IMs and Email:** These were the only two activities AOL had partially "protected." Binary analysis of v4 reveals the actual mechanism: instead of using `K1` (which navigates to a free area), the patch sent a separate `Kg` dispatch token — a "surcharge switch" inherited from the Q-Link era — that directly changed the billing state without navigating anywhere. The email tokens (`el`, `ol`, `eo`) and IM tokens (`iO`, `iS`) all triggered `Kg` instead of `K1`.
- **Long emails and USENET posts:** No free tokens were sent during these to avoid overwhelming the server. Users could be charged for time spent posting very long messages.
- **Downloads:** Download speed was unaffected by AOL4Free. However, downloading while doing other things slowed both down because of the constant free-token injection.

> *"To stop AOL4Free, they would have to make fundamental changes in the way their system runs... they must trust your client to [close windows]. There's no way the guys in Virginia can come over and 'force' your Macintosh to close that chat window."*

## How AOL Detected v1–v3 Users

### The CMis Bug

The `K1(free)` injection had a fatal flaw during signon. The `Dd` token (screen name + password) was followed by an injected `K1(free)` before the user was fully authenticated. The server's terminal handler logged this as a **`CMis` error** — a holding area update arriving with a mismatched session ID, because the user wasn't fully logged in yet.

AOL engineer **David Lippke** discovered this in August 1995. From the leaked internal email (dated August 31, 1995):

> *"Heh heh heh .. looks like we've got a reliable AOL4FREE detector. If you filter the log for 'CMis' you'll come up with what seems to be a reliable list of AOL4FREE users. The CMis message is being output by the terminal handler when it gets a holding area update carried in by a q_context that doesn't have the same UID as the stored q_context. These updates are all coming in from Library with the last token being set to Dd."*

> *"Knowing that AOL4FREE sends in constant K1s and that K1 is marked pre-login, I hypothesized that the thing must start sending in the swarms of K1 tokens BEFORE the user is fully logged in --- and, sure enough, when you look at the billing history of these folks, they pretty much all look normal until June (when AOL4FREE came out) and then they started racking up 1000s of minutes of free time and almost no paid time."*

### AOL's planned response

The leaked email chain showed AOL planned to hand screen names to the Secret Service for prosecution. From May Liang (AOL legal):

> *"What we need is a list of screen names only (no member names or addresses — those need to be subpoenaed) of the aol4free people. We then should get verification from TOS and then hand them over to the Secret Service."*

From Barry Appelman (AOL engineer):

> *"These people are idable as stealing time. I think we have enough to go forward with legal action."*

## v4: The Stealth Fix (September 13, 1995)

v4 made one simple change: **stop sending `K1(free)` after `Dd` during signon.**

The `Dd` token was sent alone, exactly like a normal client. The free-area `K1` injection resumed only after signon completed. No more `CMis` errors in the server logs.

From Happy Hardcore:
> *"v4 is modified so that it doesn't send the free token after 'Dd'. Users of v4 are totally Stealth... they 'look' just like normal AOL users. The ONLY way for AOL to identify them as AOL4Free users would be to record their entire sessions... but with hundreds of thousands of mac users, how would they pick out suspects?"*

He also noted that AOL could theoretically comb billing records for users with disproportionate free time, but argued this wasn't feasible for privacy and technical reasons.

## Version History

| Date | Version | Changes |
|------|---------|---------|
| Jun 12, 1995 | Beta 1 | First public release |
| Jun 21, 1995 | Beta 2 | Fixed IM available button bug; tweaked for AOL's Free Help window changes |
| Jul 1, 1995 | Beta 3 | Changed free area invocation method; added timing routines for IM/chat issues |
| Jul 1, 1995 | Beta 4 | Fixed bug preventing screen name creation/deletion |
| Jul 10, 1995 | Final 2.5 | First beta-tested release; fixed memory management bugs causing invisible chats |
| Aug 4, 1995 | 2.6 v1 | Ported to AOL 2.6; added free web; extended free-area technique to all tokens |
| Aug 8, 1995 | 2.6 v2 | Fixed IM billing hole (testing IMs to self masked the bug) |
| Aug 26, 1995 | 2.6 v3 | New free token to counter AOL's detection; tightened code; added mailbomber |
| Sep 13, 1995 | 2.6 v4 | **Stealth version** — stopped sending K1 after Dd to avoid CMis detection; added Guide Room Bugger |

## The Files (from WhackedMac CD)

This directory contains the actual AOL4Free v4 distribution, extracted from the **WhackedMac Archives Version 1.0** CD-ROM published by L0pht Heavy Industries, Inc. in late 1995.

```
AOL4FREE2.6v4.sit                    ← Original StuffIt archive (70KB)
AOL4FREE2.6v4/                       ← Extracted contents
├── AOL4Free2.6 v4 Docs              ← Happy Hardcore's documentation (resource fork, 76KB)
├── Install AOL4Free2.6 v4           ← The patcher binary (resource fork, 31KB)
├── Remove AOL4Free2.6 v4            ← De-installer (resource fork, 29KB)
└── Mailbomb Folder/
    ├── ReadMe!!!                     ← Mailbomber documentation
    └── UltraBomb Macro               ← KeyQuencer macro for rapid mail sending
```

Note: The main executables show 0 bytes because their code lives in classic Mac resource forks, which are stored as extended attributes on modern macOS. The data fork sizes from the original HFS image were: Docs = 76,142 bytes (resource), Install = 31,385 bytes (resource), Remove = 29,308 bytes (resource).

## Cross-Reference: FDO88 Manual

The FDO88 Manual (AOL's internal "Form Definition Opcode" programming language reference, January 1994, 239 pages) confirms the token infrastructure that AOL4Free exploited:

| AOL4Free Concept | FDO88 Manual Reference |
|-----------------|----------------------|
| Token = 2-character code | Page 2-3: "Each data packet is marked with a token which is a two byte character" |
| `K1` token | Pages 2-45, E-4: Used in Ask_DB dispatches to fetch area content |
| `S1` token | Pages E-7 through E-10: Used in Send_Form and Send_Selected dispatches |
| `fD` token | Page 2-3: "Packets containing FDO streams are sent with a packet identifier called an fD token" |
| `plus_free` billing flag | Page 2-44: "plus_free — Action allowed from free area only" |
| `plus_same` billing flag | Page 2-44: "plus_same — Action allowed from paid or free area" |
| `HideDisplay` command | Table C.6, switch 22: "If True (HideDisplay), hides the window" (p.C-22) |
| `ShowDisplay` command | Table C.6, switch 23: "If False (ShowDisplay), shows the window" (p.C-22) |
| Free area prompt | Page 2-44: "Are you certain you want to enter this free area? Any chat and gateway windows will be closed." |
| Client-side enforcement | Page 2-44: "the client software will offer to either cancel the dispatch or to change the surcharge status" |
| 6-byte dispatch structure | Page 2-43: `fdo$dispch <MOP_code> (<token><s_code>) <MOP_info>` |
| Signon form | Appendix B, Sample Stream 4: Sign On button uses `Private_Event $0000 $0E $00 $00` |

The FDO88 Manual documents the client-side form language. The host-side token list — the "complete listing of all of the tokens recognized by the AOL host" that Ryan mentions finding in a secret area — was a separate document not included in the FDO88 Manual.

## Sources

1. **Happy Hardcore's AOL4Free v4 documentation** — distributed with the software, preserved at [aolwatch.com/aol4free.htm](https://www.aolwatch.com/aol4free.htm)
2. **Happy Hardcore's essay (1997)** — 30KB first-person account, preserved at [aolunderground.com](https://aolunderground.com/happy-hardcore-essay-aol4free/)
3. **FDO88 Manual, v1 (January 1994)** — "America Online FDO88 Manual, Release 1.0" — 239-page internal AOL document (OCR'd from PDF scan)
4. **WhackedMac Archives Version 1.0 CD-ROM** — L0pht Heavy Industries, Inc., 1995 — contains the actual AOL4Free v4 binary
5. **Leaked AOL internal emails** — David Lippke, Barry Appelman, May Liang (August-September 1995) — embedded in the aolwatch.com documentation
6. **AOL-Files.com archives** — FDO tutorials by Tau and BMB, preserved at [koin.org](https://koin.org/files/aol.aim/aol/fdo/tutorial/tutorial___tokens.htm) and [mazur-archives](http://mazur-archives.s3.amazonaws.com/aol-files/fdo91/tutorial_lesson01.html)
7. **Deceptio's Lair** — Modern reverse-engineering of AOL's FDO and P3 protocols at [deceptio.org](https://deceptio.org/re/fdo/)
8. **Wired article** — "AOL4FREE Culprit Tells His Tale" by David Cassel, April 22, 1997

---

*Compiled 2026-04-01.*
