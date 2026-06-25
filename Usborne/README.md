# Usborne Programs
We got our Amstrad CPC464 with green screen in 1985 and the first book I got was Usborne's "Write Your Own Adventure Programs".<br>

It included a listing of an example adventure game, HAUNTED HOUSE, in Microsoft BASIC with custom conversions for various popular machines ... except for the Amstrad CPC and its Locomotive BASIC ... as the book came out a year before the 464's release.<br>

I never really got the program working (I was very young and stupid) so I finally decided to rectify that by using Claude to generate a CPC version in a DSK file, and then made some minor tweaks of my own (like using UPPER$ function to accept either upper or lower case commands).<br>

## [Write Your Own Adventure Programs](/Usborne/Write_Your_Own_Adventure_Programs)
My first attempt - it seems to work quite well (thanks Claude).<br>

There's two versions:
- HOUSE1.BAS: this is the straight conversion of the original listing
- HOUSE2.BAS: this is my tweaked version that's a little more playable

The tweaks include:
- using UPPER$ function so you don't need to SHOUT commands :)
- removed the extra comma on the EXITS output (i.e. N,S,W instead of N,S,W,)
- added in the save/load/quit subroutines

## [Write Your Own Fantasy Games](/Usborne/Write_Your_Own_Fantasy_Games)
A work in progress: currently the dungeon designer is working.  The original game had three separate listings: the dungeon designer, the character creator and then the main game itself.<br>

There will be two versions of each:
- DUNGEON1.BAS: the straight conversion of the dungeon designer
- DUNGEON2.BAS: my tweaked/improved version
- CHARACTER1.BAS: the straight conversion of the character creator
- CHARACTER2.BAS: the tweaked version
- GAME1.BAS: the straight conversion of the main game
- GAME2.BAS: the tweaked version

![Dungeon of Doom level designer](/Usborne/Write_Your_Own_Fantasy_Games/DungeonOfDoom_DungeonDesigner.png)
