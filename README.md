databases-aggregator
====================

Internally used script for automagic downloading database backups.
We use scp to download those files.

Usage
====================
Avaiable options 
-o, --output_dir=DIRECTORY_PATH          Directory, where downloaded files are stored. Current directory by default.
-c, --configuration_dir=DIRECTORY_PATH	Directory, with configuration files. By default current directory. All files with conf suffix are loaded as configuration.

Configuration file syntax
====================
Each row defines one file to download: 


`User<TAB>Host<TAB>File`  
or you can also define host port:  
`User<TAB>Host:port<TAB>File`  


Comments begins with # characters. 
