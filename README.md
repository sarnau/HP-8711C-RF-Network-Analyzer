# HP 8711C RF Network Analyzer

HP 8711C RF Network Analyzer Reverse Engineering and Hacks

I have done some work with Ghidra to look into the firmware ROM. I've also added the documentation I could found and schematics.


## Adding keyword option without opening the device

There are hacks in the internet, which requires to remove the boot rom, patch it and reflash it. This is not necessary with the 4.5 firmware, because it supports entering the option keyword.

Select 'System Options' => 'System Config' => 'Options Setup'

![Options Installed](./img/IMG_1830.jpg)

Now select 'Install Option':

![Enter option keyword](./img/IMG_1831.jpg)

Then you see this:

![New Options Installed](./img/IMG_1834.jpg)

After a reboot the system shows the options as well:

![Options after reboot](./img/IMG_1839.jpg)

I've written an ANSI-C application and a python script to generate a code for a given serial number of the device:

- `HP option code generator.py`
- `HP option code generator.c`
