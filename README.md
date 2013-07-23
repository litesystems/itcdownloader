itcdownloader
=============
itcdownloader is a shell script for downloading sales report files with Auto-Ingest tool provided by Apple Inc.

Requirements
------------
 * bash
 * [Auto-Ingest tool](http://apple.com/itunesnews/docs/Autoingestion.class.zip)
 * Java 1.6+ (For Auto-Ingest tool)

Installation
------------
1. Clone itcdownloader  
```
git clone https://github.com/litesystems/itcdownloader.git
```
2. Change directory.  
```
cd itcdownloader
```
3. Put Autoingestion.class in the directory of itcdownloader.
4. Copy settings file.  
```
cp settings.sh.sample settings.sh
```
5. Edit settings.sh and set VENDOR_ID and OUTPUT_DIR.

Usage
-----
```
./itcdownloader.sh
```