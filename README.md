# Rom T102 Disassembly

This is a little hobby project aiming to recreate a fully documented assembly source listing of the OS-rom in the TRS 80 Model 102 portable computer.

The starting point of this project is the excellent work done by Ken Pettit, John Hogerhuis, Jerome Vernet and Stephen James Hurd, who maintain the [Virtual T](https://sourceforge.net/projects/virtualt/) emulator. This includes a documented disassembly of the Model 100 (the predecessor of the 102). In addition to this Ken has made an even more extensively documented version in 2013.

In this project, I'm merging the disassembly of the 102 OS-rom (which includes bug fixes) with the documented versions of the 100 OS-rom.

Based on this documented T102 OS-rom disassembly, a new version will be constructed with labels and even more documentation, that can be assembled back into an OS-rom image that is identical to the original rom.

## Goals

The goals of this project are:

* to create fully functional and 'working' source code (documentation) of this historically significant machine (the M100 and T102), which famously was the last project for which Bill Gates (with Jey Suzuki) himself wrote and tested a big part of the OS and system software. In addition to this the M100 is considered to be (one of) the first true laptop computers. Here's in interview with Bill Gates about the M100: http://www.nausicaa.net/~lgreenf/bill.htm;
* to form the basis for experimentation with custom OS-Roms that can be used in VirtualT or in the actual hardware using the [REX Classic](http://bitchin100.com/wiki/index.php?title=REXclassic). This hardware extension allows replacement of the OS ROM with a custom rom image in flash memory;
* to facilitate the study of the internal workings of computers using a non-trivial, real-life use-case that is small and simple enough to be understood by a single person.

## Tools of the trade

The following tools are used on this project:

* *My trusty T102 with REXClassic and Cleuseau/ROM2 opt-rom*: There is nothing like using the real thing to quickly run a hex-dump or disassembly (using the Cleuseau/ROM2 opt-rom);
* *VirtualT*: this emulator includes an IDE, Assembler, Dis-assembler, Debugger and Monitor. These are indispensable in testing whether the new assembler source code reproduces the exact identical ROM image;
* *[Visual Studio Code](https://code.visualstudio.com/)*: This excellent editor is used as the main editor for the assembly files. It helps greatly with the editing, but also allows quick navigation and documentation previews on all addresses and labels in the source code. The built-in diff tool has been instrumental in merging the M100 documentation to the T102 dissassembly;
** *[Intel 8080 Macro-Assembler](https://marketplace.visualstudio.com/items?itemName=mborik.i8080-macroasm) plugin*: this plugin does syntax highlighting which helps a lot.

## Standing on the shoulders of giants

This project is only possible because of the previous (and current) work of a lot of people. This includes:

* *[Tandy, Kyocera and Microsoft](https://en.wikipedia.org/wiki/TRS-80_Model_100)*: who created the original machine;
* *[VirtualT](https://sourceforge.net/projects/virtualt/)*: the above mentioned emulator;
* *[Model T Doc Garden](http://bitchin100.com/wiki/index.php?title=Model_T_DocGarden)*: a wiki devoted to the M100 and related computers;
* *[Club 100](http://www.club100.org/)*: a community site also devoted to the M100 and related computers;
* *[Club 100 mailing list](http://www.club100.org/list.html)*: the mailing list, where a dedicated group of enthusiasts discuss anything related to these machines;

Books:

* *'Model 100 ROM Functions (700-2245)' by RadioShack*: a book that documents all the ROM functions provided by the M100/T102 OS rom.
* *'Inside The TRS-80 Model 100' by Carl Oppedahl (ISBN: 0-938862-31-6)*: a great book that documents the internal workings of these machines to great detail.
* *Intel 8080/8085 Assembly Language Programming, by RadioShack/Intel*: a book containing all you need to know to learn coding in 8080/8085 assembler.



 
