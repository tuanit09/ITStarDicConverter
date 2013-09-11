ITStarDicConverter
==================

Convert stardic data base to new format to effectively deploy onto mobiles.

This is a tool running on MAC OS to support re-formatting "Star Dictionary's" files so that they can be deployed on smart phone with minimum space occupied.
Example of mobile dictionary that use this new-format data: https://github.com/tuanit09/ITStarDictionaryReader

Purpose of new format:
- Minimize file size on mobiles.
- Support random access into compressed data (compressed data is consumed directly).

To use this tool:
- Choose "Input Folder" where exists "Star Dictionary" files (.ifo, .idx, .dict, .syn).
- Note: .dict is usually zipped in .dict.dz. Pls use command line: " gunzip -f en_vi.dict.dz -S dz" to unzip the file. My tool only accepts .dict
- Choose "Output Folder" where to save newly-formatted file.
- Click "Convert" & wait until all processes are completed (a label "dictionary parsed" is shown right beside the "Convert" button).
- Note:
  + The "ITStarDictionaryReader" application only needs "dict.itz" file (which contains all data). Other files that are created in "Output Folder" are simply the result of "Zip testing" just to make sure the process was done with no error. These files are parsed from "dict.itz" file.


LICENSE:
USE FOR THE GOODS
