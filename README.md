itcdownloader
=============
itcdownloader is a shell script for downloading sales report files using the Reporter tool provided by Apple Inc.

Requirements
------------
 * bash
 * [Reporter](https://itunespartner.apple.com/assets/downloads/Reporter.zip)
 * Java 1.6+ (For Repoter)

Installation
------------
0. Clone itcdownloader 
  ```
  git clone https://github.com/ymyzk/itcdownloader.git
  ```

0. Change directory. 
  ```
  cd itcdownloader
  ```

0. Put `Reporter.jar` in the directory of itcdownloader.

0. Copy a properties file.  
  ```
  cp Reporter.properties.sample Reporter.properties
  ```

0. Edit Reporter.properties and set `UserID` and `Password`.

0. Copy a settings file.  
  ```
  cp settings.sh.sample settings.sh
  ```

0. Edit `settings.sh` and set `VENDOR_ID` and `OUTPUT_DIR`.

Usage
-----
```
./itcdownloader.sh
```

Reference
---------
- [Reporter and Autoingestion User Guide](https://help.apple.com/itc/appsreporterguide/)
