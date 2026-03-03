# Info
Historic Vault of Programs and code that interface with AOL and AIM

Let's repopulate the Gibson!

Please contribute your files to this repository!

Brought to you by the AOL Underground Podcast:
[AOL Underground Podcast](https://aolunderground.com)

Thank you to:
* Len from Lens Hell
* https://web.archive.org/web/20220321112058/http://kadeklizem.com/AOL%20Progs%20ARCHIVE.rar
* http://www.aciddr0p.net/
* https://koin.org
* https://progs.rexflex.net/
* https://github.com/darcfx/darcfx-submissions
* https://github.com/raysuelzer/ProgzRescue

# Missing Proggies
Currently looking for these proggies

* Guide Punt by Stoney  - A program I made, I'd really like to find this.  I believe it was guide.exe.
* Magenta by ReDxKinG - Recently version 2.0 was found (in this archive), however we are still looking for the latest version
* Reset 1.0 by skribe (TOSers/termer/account reseter)
* 1-888'd by skribe (TOSers/termer/account reseter)
* Macro studio by i88i (level9.zip ?)
* Gemini Macro by anubis
* Macro house
* Pup Tool by Pen (puptool.zip)

## commiting large amount of files

FYI if you ever try to commit a lot of zip files you will probably run in to errors.

A way around that is to use the included file:
```
gcommitfile.sh <filename>
```

### Example Use
Recursively commiting all files in current directory:

```
find . -exec gcommitfile.sh {} \;
```

Recursively commiting all files in current directory but omiting directory "unsorted-zip":

```
find . -not -path "./unsorted-zip/*" -exec gcommitfile.sh {} \;
```


# Directory Details

## oldscool_windows_tools
Tools compatible with Windows XP (many later versions are not)

* 7zip - 7z2107.exe (decompression)
* autoruns.exe - See what starts with system (Sysinternals tool)
* TweakUiPowertoySetup.exe - *Awesome tool to tweak the GUI of Windows XP*
* ProcessExplorerNT.zip - task manager on steroids (Sysinternal tool)
* Notepad ++ - npp.7.9.2.Installer.exe
* WinCDEmu-4.1.exe - *Use this to mount ISO or IMGs*
* winhex.zip - Hex editor

# Other
Items unrelated to programming/proggies or windows tools

* nfos.zip - Old warez scene nfo files

## programming

Mostly Visual Baisc files for interacting with AOL and AIM

## programs
Compiled AOL AND AIM programs used to interact with AOL.  Also known as Proggies.

### 🎉 Repository Reorganization (2026)

This repository has been reorganized for better discoverability! Changes include:
- **Duplicate Detection:** Merged archives containing identical .exe files
- **Version Tagging:** Proggies now organized by AOL version compatibility (2.5, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0)
- **Enhanced Metadata:** Program names, authors, dependencies, and passwords extracted
- **Searchable Interfaces:** Multiple ways to find what you need
- **API-Based Version Detection:** Accurate version detection using actual AOL API signatures ([Learn More](docs/AOL_VERSION_DETECTION.md))

### Finding Proggies

**Search Tools:**
- [proggie-index.html](proggie-index.html) - Interactive web search (recommended)
- [proggie-index.md](proggie-index.md) - Browse by category with markdown tables
- [proggie-index.txt](proggie-index.txt) - Greppable tab-delimited file

**Old Links Broken?**
- Check [REDIRECTS.md](.github/REDIRECTS.md) to find where files moved
- View original structure: switch to `archive-original` branch

**Want to Help?**
- See [NEEDS_REVIEW.md](NEEDS_REVIEW.md) for proggies needing version verification
- Submit corrections via issues or pull requests

### Automated List Updates
The proggie list is automatically updated via GitHub Actions whenever new files are added. Contributors don't need to manually update the list - just add your proggies and push!

To manually update the list locally:
```bash
make update-list
```

