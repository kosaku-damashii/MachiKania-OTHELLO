REM OTHELLO.BAS

USECLASS TSC2046

USEGRAPHIC 5
CLS
TSC2046::INIT(3,0)
REM TSC2046::MINMAX()
WHILE 1
 Z=KEYS()
 IF Z==0 THEN BREAK
WEND

T=1
N=8
WHILE 1
 CLS
 GOSUB PRTTRN,T
 GOSUB DRWGRD
 GOSUB PRTEXP

 WHILE 1
  Z=KEYS()
  IF Z!=0 THEN BREAK
 WEND
 REM START KEY
 IF Z==16 THEN 
  GOSUB PRTSTA
  BREAK
 ENDIF
 REM FIRE KEY
 IF Z==32 THEN
  T=-T
 ENDIF
 IF Z==1 THEN N=N+2
 IF Z==2 THEN N=N-2
 IF Z==8 THEN N=N+2
 IF Z==4 THEN N=N-2
 IF N<4  THEN N=4
 IF N>16 THEN N=16
 WAIT 30
WEND

DIM P(N+1,N+1)
FOR X=0 TO N+1
 FOR Y=0 TO N+1
  P(X,Y)=0
 NEXT
NEXT

X=N/2
Y=N/2
P(X,Y)=1
P(X+1,Y+1)=1
P(X+1,Y)=-1
P(X,Y+1)=-1

CLS
GOSUB DRWGRD
GOSUB DRAWP

WHILE 1
 CURSOR 31,8
 PRINT "White:  "
 CURSOR 31+6,8
 PRINT W
 CURSOR 31,9
 PRINT "Black:  "
 CURSOR 31+6,9
 PRINT B

 IF (W+B)>=(N*N) THEN
  COLOR 6
  CURSOR 31,12
  IF     W>B THEN 
   PRINT "White WiN"
  ELSEIF B>W THEN
   PRINT "Black WiN"
  ELSE
   PRINT "DRAW GAME"
  ENDIF 
 WHILE KEYS()==0:WEND
  BREAK
 ENDIF


 GOSUB PRTTRN,T
 CURSOR 31,3
 PRINT "X="
 CURSOR 31,4
 PRINT "Y="


 IF T==1 THEN
  WHILE 0==TSC2046::POLLING()
   Z=KEYS()
   IF Z==32 THEN
    GOSUB PRTSKP
    WHILE 0!=KEYS():WEND
    T=-T
    GOSUB PRTTRN,T
    BREAK
   ENDIF
  WEND
  IF Z==32 THEN CONTINUE
  WHILE 1==TSC2046::TOUCH():WEND
  X=(TSC2046::lastx-D)/U+1
  Y=(TSC2046::lasty-D)/U+1
 ELSE
  FOR X=1 TO N
   FOR Y=1 TO N
    G=GOSUB(CHKDSC,X,Y)
    IF G==1 THEN BREAK
   NEXT
   IF G==1 THEN BREAK
  NEXT
  IF G==0 THEN
   GOSUB PRTSKP
   SOUND TRNSND
   WAIT 60
   T=-T
   GOSUB PRTTRN,T
   CONTINUE
  ENDIF
  WAIT 30
 ENDIF
 G=0


 CURSOR 31+2,3
 REM X=VAL(INPUT$())
 IF X<1 OR X>N THEN CONTINUE
 PRINT X
 CURSOR 31+2,4
 REM Y=VAL(INPUT$())
 IF Y<1 OR Y>N THEN CONTINUE
 PRINT Y


 IF P(X,Y)==0 THEN 
 
  IF P(X-1,Y-1)==0 AND P(X-1,Y)==0 AND P(X-1,Y+1)==0 AND P(X  ,Y-1)==0 AND P(X  ,Y)==0 AND P(X  ,Y+1)==0 AND P(X+1,Y-1)==0 AND P(X+1,Y)==0 AND P(X+1,Y+1)==0 THEN 
   GOSUB PRTERR
   CONTINUE
  ENDIF

  G=0

  REM DOWN/LEFT
  V=Y
  FOR I=X-1 TO 1 STEP -1
   V=V-1
   IF V<1 THEN BREAK
   IF P(I,V)!=0 THEN
    IF P(I,V)==T THEN
     FOR K=I+1 TO X-1
      V=V+1
      P(K,V)=T
      G=1
     NEXT
     BREAK
    ENDIF
   ELSE
    BREAK
   ENDIF
  NEXT

  REM DOWN/RIGHT
  V=Y
  FOR I=X+1 TO N
   V=V-1
   IF V<1 THEN BREAK
   IF P(I,V)!=0 THEN
    IF P(I,V)==T THEN
     FOR K=I-1 TO X+1 STEP -1
      V=V+1
      P(K,V)=T
      G=1
     NEXT
     BREAK
    ENDIF
   ELSE
    BREAK
   ENDIF
  NEXT

  REM UP/LEFT
  V=Y
  FOR I=X-1 TO 1 STEP -1
   V=V+1
   IF V>N THEN BREAK
   IF P(I,V)!=0 THEN
    IF P(I,V)==T THEN
     FOR K=I+1 TO X-1
      V=V-1
      P(K,V)=T
      G=1
     NEXT
     BREAK
    ENDIF
   ELSE
    BREAK
   ENDIF
  NEXT

  REM UP/RIGHT
  V=Y
  FOR I=X+1 TO N
   V=V+1
   IF V>N THEN BREAK
   IF P(I,V)!=0 THEN
    IF P(I,V)==T THEN
     FOR K=I-1 TO X+1 STEP -1
      V=V-1
      P(K,V)=T
      G=1
     NEXT
     BREAK
    ENDIF
   ELSE
    BREAK
   ENDIF
  NEXT

  REM LEFT
  FOR I=X-1 TO 1 STEP -1
   IF P(I,Y)!=0 THEN
    IF P(I,Y)==T THEN
     FOR K=I+1 TO X-1
      P(K,Y)=T
      G=1
     NEXT
     BREAK
    ENDIF
   ELSE
    BREAK
   ENDIF
  NEXT

  REM RIGHT
  FOR I=X+1 TO N
   IF P(I,Y)!=0 THEN
    IF P(I,Y)==T THEN
     FOR K=I-1 TO X+1 STEP -1
      P(K,Y)=T
      G=1
     NEXT
     BREAK
    ENDIF
   ELSE
    BREAK
   ENDIF
  NEXT

  REM UP
  FOR J=Y-1 TO 1 STEP -1
   IF P(X,J)!=0 THEN
    IF P(X,J)==T THEN
     FOR L=J+1 TO Y-1
      P(X,L)=T
      G=1
     NEXT
     BREAK
    ENDIF
   ELSE
    BREAK
   ENDIF
  NEXT

  REM DOWN
  FOR J=Y+1 TO N
   IF P(X,J)!=0 THEN
    IF P(X,J)==T THEN
     FOR L=J-1 TO Y+1 STEP -1
      P(X,L)=T
      G=1
     NEXT
     BREAK
    ENDIF
   ELSE
    BREAK
   ENDIF
  NEXT


  IF G=1 THEN 
   P(X,Y)=T
   CURSOR 31+2,3
   PRINT X
   CURSOR 31+2,4
   PRINT Y
   SOUND OKSND
   T=-T
  ELSE
   GOSUB PRTERR
  ENDIF

 ELSE
  GOSUB PRTERR
 ENDIF
 GOSUB DRAWP
WEND

END

LABEL OKSND
DATA $31000,1

LABEL NGSND
DATA $83000,1

LABEL TRNSND
DATA $52000,1

LABEL DRWGRD
 D=0
 U=(SYSTEM(23)-D)/N
 BOXFILL D,D,D+U*N,D+U*N,4+8
 FOR X=0 TO N-1
  LINE D+U*X,D+U*0,D+U*X,D+U*N-1,0
 NEXT
 FOR Y=0 TO N-1
  LINE D+U*0,D+U*Y,D+U*N-1,D+U*Y,0
 NEXT
RETURN


LABEL DRAWP
 W=0:B=0
 FOR X=1 TO N
  FOR Y=1 TO N
   IF P(X,Y)==1  THEN 
    GOSUB PIECE,X,Y,7
    W=W+1
   ELSEIF P(X,Y)==-1 THEN
    GOSUB PIECE,X,Y,0
    B=B+1
   ENDIF
  NEXT
 NEXT
RETURN


LABEL PRTEXP
 VAR X,Y
 X=31
 Y=3

 CURSOR 31,Y
 PRINT CHR$($1E);CHR$($1C);":Grid +"
 CURSOR 31,Y+1
 PRINT CHR$($1F);CHR$($1D);":Grid -"
 CURSOR 31,Y+3
 PRINT "FIRE:"
 CURSOR 31,Y+4
 PRINT " Change"
 CURSOR 31,Y+6
 PRINT "Press"
 CURSOR 31,Y+7
 PRINT " START"
RETURN


LABEL PIECE
 CIRCLEFILL D+(ARGS(1)-1)*U+U/2,D+(ARGS(2)-1)*U+U/2,U/2-2,ARGS(3)
RETURN


LABEL PRTTRN
 VAR X,Y
 X=31
 Y=1
 CURSOR X,Y
 IF ARGS(1)==1 THEN
  PRINT "[White]"
 ELSE
  PRINT "[Black]"
 ENDIF
RETURN


LABEL PRTERR
 VAR X,Y
 X=31
 Y=15
 CURSOR X,Y
 PRINT "ERROR!"
 SOUND NGSND
 WAIT 60
 CURSOR X,Y
 PRINT "      "
RETURN


LABEL PRTSTA
 VAR X,Y
 X=31
 Y=15
 CURSOR X,Y
 PRINT "GAME"
 CURSOR X,Y+1
 PRINT "START"
 WAIT 60
 CURSOR X,Y+2
 PRINT "    "
 CURSOR X,Y+3
 PRINT "     "
RETURN


LABEL PRTSKP
 VAR X,Y
 X=31
 Y=15
 CURSOR X,Y
 PRINT "SKIP"
 WAIT 60
 CURSOR X,Y
 PRINT "    "
RETURN


LABEL CHKDSC
 VAR X,Y,G,V,K,I,J
 X=ARGS(1)
 Y=ARGS(2)


 G=0

 IF P(X,Y)!=0 THEN RETURN 0


 IF P(X-1,Y-1)==0 AND P(X-1,Y)==0 AND P(X-1,Y+1)==0 AND P(X  ,Y-1)==0 AND P(X  ,Y)==0 AND P(X  ,Y+1)==0 AND P(X+1,Y-1)==0 AND P(X+1,Y)==0 AND P(X+1,Y+1)==0 THEN RETURN 0


 REM DOWN/LEFT
 V=Y
 FOR I=X-1 TO 1 STEP -1
  V=V-1
  IF V<1 THEN BREAK
  IF P(I,V)!=0 THEN
   IF P(I,V)==T THEN
    FOR K=I+1 TO X-1
     V=V+1
     G=1
    NEXT
    BREAK
   ENDIF
  ELSE
   BREAK
  ENDIF
 NEXT


 REM DOWN/RIGHT
 V=Y
 FOR I=X+1 TO N
  V=V-1
  IF V<1 THEN BREAK
  IF P(I,V)!=0 THEN
   IF P(I,V)==T THEN
    FOR K=I-1 TO X+1 STEP -1
     V=V+1
     G=1
    NEXT
    BREAK
   ENDIF
  ELSE
   BREAK
  ENDIF
 NEXT

 REM UP/LEFT
 V=Y
 FOR I=X-1 TO 1 STEP -1
  V=V+1
  IF V>N THEN BREAK
  IF P(I,V)!=0 THEN
   IF P(I,V)==T THEN
    FOR K=I+1 TO X-1
     V=V-1
     G=1
    NEXT
    BREAK
   ENDIF
  ELSE
   BREAK
  ENDIF
 NEXT

 REM UP/RIGHT
 V=Y
 FOR I=X+1 TO N
  V=V+1
  IF V>N THEN BREAK
  IF P(I,V)!=0 THEN
   IF P(I,V)==T THEN
    FOR K=I-1 TO X+1 STEP -1
     V=V-1
     G=1
    NEXT
    BREAK
   ENDIF
  ELSE
   BREAK
  ENDIF
 NEXT

 REM LEFT
 FOR I=X-1 TO 1 STEP -1
  IF P(I,Y)!=0 THEN
   IF P(I,Y)==T THEN
    FOR K=I+1 TO X-1
     P(K,Y)=T
     G=1
    NEXT
    BREAK
   ENDIF
  ELSE
   BREAK
  ENDIF
 NEXT

 REM RIGHT
 FOR I=X+1 TO N
  IF P(I,Y)!=0 THEN
   IF P(I,Y)==T THEN
    FOR K=I-1 TO X+1 STEP -1
     G=1
    NEXT
    BREAK
   ENDIF
  ELSE
   BREAK
  ENDIF
 NEXT

 REM UP
 FOR J=Y-1 TO 1 STEP -1
  IF P(X,J)!=0 THEN
   IF P(X,J)==T THEN
    FOR L=J+1 TO Y-1
     G=1
    NEXT
    BREAK
   ENDIF
  ELSE
   BREAK
  ENDIF
 NEXT

 REM DOWN
 FOR J=Y+1 TO N
  IF P(X,J)!=0 THEN
   IF P(X,J)==T THEN
    FOR L=J-1 TO Y+1 STEP -1
     G=1
    NEXT
    BREAK
   ENDIF
  ELSE
   BREAK
  ENDIF
 NEXT

RETURN G
