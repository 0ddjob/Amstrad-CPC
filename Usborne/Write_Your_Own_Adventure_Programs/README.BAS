10 REM ******************************
20 REM ** README for Haunted House **
30 REM ******************************
40 MODE 1:INK 0,0:INK 1,26:BORDER 0:PAPER 0:PEN 1:CLS
50 PRINT:PRINT"Usborne's HAUNTED HOUSE for Amstrad CPC"
60 PRINT"***************************************"
70 PRINT"'Write Your Own Adventure Programs'"
80 PRINT"By Jenny Tyler & Les Howarth"
90 PRINT"Designed by Roger Priddy"
100 PRINT"Published 1983, ISBN 0 86020 741 2"
110 PRINT:PRINT"Amstrad version by Claude with tweaks"
120 PRINT"by Brett Hallen, June 2026."
130 PRINT:PRINT"Finally, 41 years after we got our 464"
140 PRINT"and I got this book, I can run it on"
150 PRINT"my trusty 464."
160 PRINT:PRINT"There are two versions:"
170 PRINT"[1] HOUSE1 = direct conversion"
180 PRINT"[2] HOUSE2 = tweaks & improvements"
190 PRINT:PRINT"Choose one to run ..."
200 G$=INKEY$:IF G$="" GOTO 200
210 IF G$="1" THEN RUN"HOUSE1.BAS"
220 IF G$="2" THEN RUN"HOUSE2.BAS"
230 END
