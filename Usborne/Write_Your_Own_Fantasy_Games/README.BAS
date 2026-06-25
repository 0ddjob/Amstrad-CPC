10 REM ********************************
20 REM ** README for Dungeon of Doom **
30 REM ********************************
40 MODE 1:INK 0,0:INK 1,26:BORDER 0:PAPER 0:PEN 1:CLS
50 PRINT:PRINT"Usborne's DUNGEON OF DOOM for Amstrad"
60 PRINT"*************************************"
70 PRINT"'Write Your Own Fantasy Games'"
80 PRINT"By Les Howarth & Cheryl Evans"
90 PRINT"Designed by Iain Ashman"
100 PRINT"Published 1984, ISBN 0-86020-834-6"
110 PRINT:PRINT"Amstrad version by Claude with tweaks"
120 PRINT"by Brett Hallen, June 2026"
130 PRINT:PRINT"Finally after more than 40 years since"
140 PRINT"we got our 464 and this book, I can run it!"
150 PRINT:PRINT"There are three parts:"
160 PRINT"[1] DUNGEON - design the dungeons"
170 PRINT"[2] CREATOR - generate your hero"
180 PRINT"[3] GAME - the actual game"
190 PRINT:PRINT"Choose one to run ..."
200 G$=INKEY$:IF G$="" THEN GOTO 200
210 IF G$="1" THEN RUN"DUNGEON2.BAS"
220 IF G$="2" THEN RUN"CREATOR1.BAS"
230 IF G$="3" THEN RUN"GAME1.BAS"
240 END
