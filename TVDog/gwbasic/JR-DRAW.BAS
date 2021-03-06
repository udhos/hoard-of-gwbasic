10 GOTO 650
15 'loop
20 LET K$ = INKEY$
25 IF K$ >=CHR$(97) THEN K$ = CHR$(ASC(K$)-32)
30 IF K$ = "1" THEN C%=1
35 IF K$ = "2" THEN C%=2
40 IF K$ = "3" THEN C%=3
45 IF K$ = "4" THEN C%=4
50 IF K$ = "5" THEN C%=5
55 IF K$ = "6" THEN C%=6
60 IF K$ = "7" THEN C%=7
65 IF K$ = "8" THEN C%=8
70 IF K$ = "9" THEN C%=9
75 IF K$ = "0" THEN C%=10
80 IF K$ = "!" THEN C%=11
85 IF K$ = "@" THEN C%=12
90 IF K$ = "#" THEN C%=13
95 IF K$ = "$" THEN C%=14
100 IF K$ = "%" THEN C%=15
105 IF K$ = "^" THEN C%=0
110 IF K$ = "F" THEN GOSUB 195 'fill option
115 IF K$ = "D" THEN GOSUB 520 'diagonal menu
120 ON KEY(11) GOSUB 235 'up arrow
125 ON KEY(12) GOSUB 285  'left arrow
130 ON KEY(13) GOSUB 315  'right arrow
135 ON KEY(14) GOSUB 345 'down arrow
140 IF K$ = "S" THEN GOSUB 440 'get size of line
145 IF K$ = "C" THEN GOSUB 480 'circle menu
150 IF K$ = "L" THEN GOSUB 500 'line menu
155 IF K$ = "Q" THEN GOSUB 685 'quit the program
160 IF K$ = "A" THEN GOSUB 540 'get angle
165 IF K$ = "R" THEN GOSUB 575 'get radius
170 IF K$ = "B" THEN GOSUB 215  'blank workspace
175 IF K$ = "E" THEN GOSUB 395 'ellipse
180 ON KEY(1) GOSUB 610 'utility menu
185 ON KEY(10) GOSUB 630 'start the program
190 GOTO 15
195 'gosub fill with paint
200 IF M%=1 OR M%=2 OR M%=3 THEN 205 ELSE 210
205 PAINT STEP (+1,+1),C%:DRAW "bm-1,-1"
210 RETURN
215 'gosub blank workspace
220 IF M%=4 THEN 225 ELSE 230
225 CLS
230 RETURN
235 'gosub 500 - up arrow
240 IF M%=1 THEN DRAW "c=c%;ta-=a%;u=s%;"
245 IF M%=3 AND A%=0 THEN DRAW "c=c%;ta-=a%;e=s%;"
250 IF M%=3 AND A% <> 0 THEN DRAW "c=c%;ta-=a%;u=s%;"
255 IF M%=2 THEN GOSUB 265 'growing circles
260 RETURN
265 'gosub - growing circles
270 R% = R% + 5:IF R% > 100 THEN R% = 100
275 CIRCLE STEP (+0,+0),R%,C%
280 RETURN
285 'gosub 600 - left arrow
290 IF M%=1 THEN DRAW "c=c%;ta-=a%;l=s%;"
295 IF M%=3 AND A%=0 THEN DRAW "c=c%;ta-=a%;h=s%;"
300 IF M%=3 AND A% >< 0 THEN DRAW "c=c%;ta-=a%;l=s%;"
305 IF M% = 2 THEN CIRCLE STEP (+0,+0),R%,C%
310 RETURN
315 'gosub 700 - right arrow
320 IF M%=1 THEN DRAW "c=c%;ta-=a%;r=s%;"
325 IF M%=3 AND A% = 0 THEN DRAW "c=c%;ta-=a%;f=s%;"
330 IF M%=3 AND A% >< 0 THEN DRAW "c=c%;ta-=a%;r=s%;"
335 IF M% = 2 THEN CIRCLE STEP (+0,+0),R%,C%
340 RETURN
345 'gosub 800 - down arrow (lines)
350 IF M%=1 THEN DRAW "c=c%;ta-=a%;d=s%;"
355 IF M%=3 AND A%=0 THEN DRAW "c=c%;ta-=a%;g=s%;"
360 IF M%=3 AND A% >< 0 THEN DRAW "c=c%;ta-=a%;d=s%;"
365 IF M% = 2 THEN GOSUB 375 'shrinking circles
370 RETURN
375 'gosub - shrinking circle
380 R% = R% - 5
381 IF R% <= 0 THEN R% = 5
385 CIRCLE STEP (+0,+0),R%,C%
390 RETURN
395 'gosub ellipse
400 IF M%=2 THEN 405 ELSE 435
405 CIRCLE STEP (+0,+0),R%,C%,,,E%/10
410 IF E% >= 1 AND E% < 13 THEN E% = E% + 1
415 IF E%  >= 13 AND E% <= 25 THEN E% = E% + 5
420 IF E%  >= 25 AND E% <= 75 THEN E% = E% + 25
425 IF E%  >= 75 AND E% <= 178 THEN E% = E% + 50
430 IF E% >= 178 THEN E% = 1
435 RETURN
440 'gosub get length
445 IF M%=1 OR M%=3 THEN 450 ELSE 475
450 LOCATE 23,2:PRINT "                                      ";
455 LOCATE 23,2:PRINT "Type size (1-50) and press ENTER";:INPUT S%
457 IF S% > 50 THEN S% = 50
458 IF S% < 1 THEN S%=1
460 IF M%=1 THEN GOSUB 500  'return to line menu
465 IF M%=3 THEN GOSUB 520  'return to diagonal menu
475 RETURN
480 'gosub 1000 - circle menu
485 IF M%=1 OR M%=2 OR M%=3 OR M%=4 THEN 490 ELSE 495
490 LOCATE 23,2:PRINT CHR$(24);CHR$(27);CHR$(25);CHR$(26);CHR$(35);"R)ad,E)lpse,F)ill,L)ine,D)iag,Fn1";:M%=2
495 RETURN
500 'gosub 2000 - line menu
505 IF M%=1 OR M%=2 OR M%=3 OR M%=4 THEN 510 ELSE 515
510 LOCATE 23,2:PRINT CHR$(24);CHR$(27);CHR$(25);CHR$(26);CHR$(35);" S)ize, F)ill, D)iag, Cir, Fn1   ";:M%=1:A%=0
515 RETURN
520 'gosub 3000 - diagonal menu
525 IF M%=1 OR M%=2 OR M%=3 OR M%=4 THEN 530 ELSE 535
530 LOCATE 23,2:PRINT CHR$(24);CHR$(27);CHR$(25);CHR$(26);CHR$(35);" S)ize,A)ng,F)ill,L)ine,C)ir,Fn1 ";:M%=3
535 RETURN
540 'gosub 3500 - get angle
545 IF M%=3 THEN 550 ELSE 570
550 LOCATE 23,2:PRINT "                                      ";
555 LOCATE 23,2:PRINT "Type angle (0-90) and press ENTER";:INPUT A%
560 GOSUB 520 'return to diagonal menu
565 IF A% = 45 OR A%>90 OR A%<0 THEN A%=0
570 RETURN
575 'gosub 3500 - get radius
580 IF M%=2 THEN 585 ELSE 605
585 LOCATE 23,2:PRINT "                                      ";
590 LOCATE 23,2:PRINT "Type radius(5-100)and press ENTER";:INPUT R%
595 GOSUB 480 'return to circle menu
600 IF R% > 100 THEN R% = 100
602 IF R% < 5 THEN R% = 5
605 RETURN
610 'gosub - utility menu
615 IF M%=1 OR M%=2 OR M%=3 THEN 620 ELSE 625
620 LOCATE 23,2:PRINT " B)lank, L)ine, D)iag, C)ircle, Q)uit ";:M%=4
625 RETURN
630 'gosub start
635 IF M%=0 THEN 640 ELSE 645
640 CLS:GOSUB 620
645 RETURN
650 CLS:KEY OFF:CLEAR,,,32768!:SCREEN 5
655 KEY(11) ON:KEY(12) ON:KEY(13) ON:KEY(14) ON:KEY(1) ON:KEY(10) ON
660 VIEW (1,175)-(318,190),,4:VIEW (1,1)-(318,165),,1
665 LOCATE 6,17:PRINT "JrDraw":LOCATE 8,19:PRINT "by":LOCATE 10,14:PRINT "Robert Bedick":LOCATE 11,11:PRINT "803 E. Pleasant St.":LOCATE 12,11:PRINT "Milwaukee, WI 53202"
670 LOCATE 23,10:PRINT "Press Fn-10 to start"
675 M%=0:A%=0:S%=1:C%=15:R%=5:E%=1
680 GOTO 15
685 'gosub quit
690 IF M%=4 THEN 695 ELSE 700
695 VIEW (0,0)-(319,199):CLS:END
700 RETURN
=1:C%=15:R%=5:E%=1
680 GOTO 15
685 'gosub quit
690 IF M%=4 THEN 695 ELSE                                                                                                                                