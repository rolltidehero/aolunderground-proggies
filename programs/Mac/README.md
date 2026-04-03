# Mac Hells

In the Mac AOL underground, hacking tools were called **"hells"** — the Mac equivalent of Windows "proggies." These included macro-based tools (KeyQuencer, OneClick, and RzaHell), 68k binary patchers, and other tools that exploited AOL's FDO protocol, client-trusted billing, and other design flaws in the Mac AOL client.

All hells below were extracted from the **[WhackedMac Archives Version 1.0](https://archive.org/details/The_Whacked_Mac_Archives_Version_1.0_L0pht_Heavy_Industries_Inc._1996)** CD-ROM (L0pht Heavy Industries, November 1995), path: `Pub/AOLCrap/`.

## Hells

| Hell | Author | Year | Type | Description |
|------|--------|------|------|-------------|
| [AOL4Free v4](hells/aol4free/) | Happy Hardcore | 1995 | 68k binary patcher | Exploited client-trusted billing to access all paid services for free. Includes the original .sit archive, full 68k disassembly, 9 architecture diagrams, FDO protocol docs, and Happy Hardcore's own writings. |
| [AOLAid 2.5](hells/aolaid/) | Unknown | 1995 | System extension (INIT) | Lets you download and chat at the same time on AOL 2.1. Drop onto System Folder and restart. |
| [Lith-O-Hell](hells/lithohell/) | Unknown | 1995 | KeyQuencer macros | 13 sequences: IM bomb, mail bomb, mass mail, PR squeeze, turn IMs on/off, and more. Includes keyset and documentation. |
| [MAOHELL b2](hells/maohell/) | ηeη | 1995 | KeyQuencer macros | "AOHELL for Mac" — mail bomb, IM bomb, scroll hell, hell drive scan (crashes PC A: drives via chat), credit card generator, AOL Aid. 9 sequences. |
| [NAPOhell v1.0](hells/napohell/) | mike | 1995 | KeyQuencer control panel (cdev) | Control panel-based hell with macros. Promised AOPHree 1.0 ("just like AOL4Free only better") in a future release. |
| [No Dice](hells/nodice/) | Andrew Welch / Ambrosia Software | 1995 | System extension (INIT) + C source | Automatically ignores dice rolls in AOL chat rooms by patching `_TEDispatch`. Full C source code included — patches the Toolbox trap to filter "OnlineHost" messages in "People Connection" windows. |
| [SLAYoHell v1.2](hells/slyohell/) | Unknown | 1995 | KeyQuencer macros + plug-ins | Full hell suite: 55 KeyQuencer plug-ins, ASCII art collection (14 pieces), gPaste, No Dice, documentation. Bundled with BBEdit Lite 3.0. |

## AOL Mac Client

| Client | Date | FDO Version | Description |
|--------|------|-------------|-------------|
| [America Online v2.6b15](aol26-client/) | May 1995 | **FDO88** ([proof](aol26-client/AOL26-FDO-Version-Analysis.md)) | The unpatched AOL 2.6 Mac client that AOL4Free targets. Binary analysis confirms FDO88 protocol. |
| [America Online v3.0](aol30-client/) | ~1996 | Consistent with FDO91 ([analysis](aol30-client/AOL30-FDO-Version-Analysis.md)) | VISE installers (68K + PPC). Complete rewrite: PPC shared libraries, PowerPlant framework. FDO88 error strings gone, K1/Kg tokens persist. |

## FDO Protocol Documentation

FDO ("Form Definition Opcode/Operator") is the programming language AOL used to render all client UI. The server sent FDO streams to the client, which interpreted them to draw windows, buttons, lists, and text fields. Every button contained a 6-byte dispatch that told the server what action to take when clicked.

There were two versions:
- **FDO88** (1988) — used by the Apple II, GEOS, PCAO, and Mac clients before AOL 3.0
- **FDO91** (1991) — used by the Windows client and Mac clients 3.0 and later

| Document | Description |
|----------|-------------|
| [FDO88 Manual (PDF)](hells/aol4free/FDO88_Manual_v1_1994-01_(searchable).pdf) | AOL's internal FDO88 reference, January 1994, 239 pages. Defines tokens, dispatches, MOP codes, surcharge billing, switches, and sample FDO streams. |
| [FDO88 Manual (searchable web version)](https://iconidentify.github.io/fdo88_docs/) | Browser-readable version of the FDO88 Manual with full-text search. |
| [FDO91 Manual chapters](hells/aol4free/fdo91_docs/) | 11 chapters of the FDO91 Manual (February 1998) — Introduction, Action Protocol, Async, Chat, File Transfer, Forms Manager, Host Forms Server, P3, Universal, Transfer, and Appendix A. Text and PDF. |

## Screenshots of Hells

*Screenshots courtesy of iconidentify.*

### PB (November 2, 1997)

![PB](screenshots/pb11.02.97.jpg)

### Puck (April 3, 1996)

![Puck](screenshots/puck4.3.96.jpg)

### Tang (April 13, 1996)

![Tang](screenshots/tang4.13.96.jpg)
