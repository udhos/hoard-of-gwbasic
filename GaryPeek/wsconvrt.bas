100 CLS
110 PRINT "   WSCONVRT - Wordstar conversion utility    12/24/95"
120 PRINT
130 PRINT "1. Convert a file created in Wordstar document mode to"
140 PRINT "   a file that is more or less a regular ASCII file:"
150 PRINT "   1. Deletes the named file with the extension BAK if it exists"
160 PRINT "   2. Creates a temporary file with the extension TMP"
170 PRINT "   3. Renames the original file with the extension BAK"
180 PRINT "   4. Renames the temporary file to the original file name"
190 PRINT
200 PRINT "2. Used after the above conversion to convert the file with" 
210 PRINT "   or without page numbering to one that can be printed" 
220 PRINT "   using the DOS command TYPE filename >PRN command."
230 PRINT "   (Creates a new file with the extension TMP.)"
240 PRINT
250 PRINT "3. Used after the above conversion to print the temporary" 
260 PRINT "   file, then delete the temporary file." 
270 PRINT "   (Uses the DOS command TYPE filename.TMP >PRN command."
280 PRINT
290 PRINT "   ESCape to Exit"
300 PRINT
310 PRINT "   (Hit 1, 2, 3, or ESCape) ";
320 LOCATE ,,1
330 REM ---------------
500 CONVERSION$=INKEY$:IF CONVERSION$="" THEN 500
510 IF CONVERSION$=CHR$(27) THEN CLS:END
520 IF CONVERSION$="1" THEN GOSUB 1000
530 IF CONVERSION$="2" THEN GOSUB 2000
540 IF CONVERSION$="3" THEN GOSUB 3000
550 GOTO 100
560 REM ---------------
1000 GOSUB 4000:REM GET FILE NAME
1010 IF FIN$="" THEN RETURN
1020 ON ERROR GOTO 1400
1030 KILL FBAK$
1040 ON ERROR GOTO 0
1050 PRINT:PRINT FBAK$+" deleted..."
1060 T=TIMER
1070 IF TIMER<T+2 THEN 1070
1080 PRINT:PRINT
1090 LOCATE ,,0
1100 REM ------------- CONVERT LOOP
1200 IF EOF(1) THEN 1300
1210 A$=INPUT$(1,#1)
1220 A=ASC(A$):A=(A AND 127):B$=CHR$(A)
1230 IF B$=CHR$(10) THEN 1250
1240 PRINT B$;
1250 PRINT #2,B$;
1260 GOTO 1200
1270 REM ------------- ALMOST DONE
1300 CLOSE
1310 PRINT:PRINT
1320 NAME FIN$ AS FBAK$
1330 NAME FTEMP$ AS FIN$
1340 RETURN
1350 REM ------------- BAK FILE NOT FOUND
1400 RESUME 1410
1410 GOTO 1080
1420 REM -------------------------------------------------------------------
2000 IF FIN$<>"" THEN 2040
2010 GOSUB 4000:REM GET FILE NAME
2020 IF FIN$="" THEN RETURN
2030 GOTO 2060
2040 OPEN FIN$ FOR INPUT AS #1
2050 OPEN FTEMP$ FOR OUTPUT AS #2
2060 CLS
2070 PRINT "Create print file "+FTEMP$+" with adjusted margins -":PRINT 
2080 PRINT "Add page numbers similar to Wordstar print function? (Y, N, or ESCape) ";
2090 LOCATE ,,1
2100 REM ---------------
2200 PGNUM$=INKEY$:IF PGNUM$="" THEN 2200
2210 IF PGNUM$=CHR$(27) THEN RETURN
2220 IF PGNUM$="y" THEN PGNUM$="Y"
2230 IF PGNUM$="n" THEN PGNUM$="N"
2240 IF PGNUM$<>"Y" AND PGNUM$<> "N" THEN 2200
2250 REM ---------------
2300 PRINT:PRINT
2310 LOCATE ,,0
2320 PGNUM=1
2330 LINENUM=0
2340 PRINT
2350 PRINT #2,""
2360 IF PGNUM$="Y" THEN 2390
2370   PRINT
2380   PRINT #2," "
2390 IF EOF(1) THEN 2550
2400   LINE INPUT #1,I$
2410   LINENUM=LINENUM+1
2420   II$=SPACE$(7)+I$
2430   PRINT II$
2440   PRINT #2,II$
2450   IF LINENUM<55 THEN 2390
2460   IF PGNUM$="N" THEN 2520
2470     PRINT:PRINT:PRINT
2480     PRINT #2,"":PRINT #2,"":PRINT #2,""
2490   PRINT SPACE$(38);STR$(PGNUM);
2500   PRINT #2,SPACE$(38);STR$(PGNUM);
2510   PGNUM=PGNUM+1
2520   PRINT:PRINT "<FF>":PRINT
2530   PRINT #2, CHR$(12);
2540 GOTO 2330
2550 IF PGNUM$="N" THEN 2590
2560 FOR A=1 TO 58-LINENUM:PRINT:PRINT #2,"":NEXT A
2570 PRINT SPACE$(38);STR$(PGNUM);
2580 PRINT #2,SPACE$(38);STR$(PGNUM);
2590   PRINT:PRINT "<FF>":PRINT
2600   PRINT #2, CHR$(12);
2610 CLOSE
2620 RETURN
2630 REM ----------------- PRINT "FILENAME.TMP" ---------------------
3000 IF FIN$<>"" THEN 3100
3010 CLS
3020 PRINT "Enter file name (including extension if used): ";
3030 LOCATE ,,1
3040 LINE INPUT FTEMP$
3050 IF FTEMP$="" THEN RETURN
3060 REM -----
3100 ON ERROR GOTO 3300
3110 OPEN FTEMP$ FOR INPUT AS #1
3120 CLOSE
3130 ON ERROR GOTO 0
3140 CLS
3150 PRINT "sending "+FTEMP$+" to printer..."
3160 SHEL$="TYPE "+FTEMP$+" >PRN"
3170 SHELL SHEL$:REM DOS MUST HAVE COMMAND.COM IN THE PATH
3180 PRINT:PRINT "Print another copy? (Y or N) ";
3190 LOCATE ,,0
3200 REM ---------------
3210 AGAIN$=INKEY$:IF AGAIN$="" THEN 3210
3220 IF AGAIN$="y" OR AGAIN$="Y" THEN 3140
3230 IF AGAIN$="N" OR AGAIN$="n" THEN 3240
3235 GOTO 3210
3240 KILL FTEMP$
3250 PRINT:PRINT FTEMP$+" deleted..."
3260 FIN$=""
3270 T=TIMER
3280 IF TIMER<T+2 THEN 3280
3290 RETURN
3295 REM -----
3300 RESUME 3310
3310 ON ERROR GOTO 0
3320 BEEP
3330 PRINT "File not found":PRINT
3340 GOTO 3020
3350 REM ----------- GET FILE NAMES AND OPEN FILES -----------
3360 REM ----------- FOR THE 2 CONVERSION ROUTINES -----------
4000 CLS
4010 PRINT "Enter file name (including extension if used): ";
4020 LOCATE ,,1
4030 LINE INPUT FIN$
4040 IF FIN$="" THEN RETURN
4050 I=INSTR(FIN$,".")
4060 IF I=0 THEN FEXT$=FIN$+".$$$":I=LEN(FIN$)+1:GOTO 4090
4070 IF I=1 THEN RETURN
4080 IF I>=2 THEN FEXT$=FIN$
4090 FTEMP$=LEFT$(FEXT$,I-1)+".TMP"
4100 FBAK$=LEFT$(FEXT$,I-1)+".BAK"
4110 ON ERROR GOTO 4200
4120 OPEN FIN$ FOR INPUT AS #1
4130 ON ERROR GOTO 0
4140 OPEN FTEMP$ FOR OUTPUT AS #2
4150 RETURN
4160 REM -----
4200 RESUME 4210
4210 ON ERROR GOTO 0
4220 BEEP
4230 PRINT "File not found":PRINT
4240 GOTO 4010
