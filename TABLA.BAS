    CLS
    DIM nombre(10) AS STRING, puntos(10) AS INTEGER
    OPEN "LISTA" FOR INPUT AS #1
    INPUT "   PUNtos:       ", PUNT
    INPUT "   nombre:        ", NOMB$
    cont = 0
    DO WHILE cont < 10
        cont = cont + 1
        PRINT cont
        INPUT #1, reg1, REG2$
        nombre(cont) = REG2$
        puntos(cont) = reg1
    LOOP
    cont = 0
REP:
    cont = cont + 1
    IF PUNT < puntos(cont) GOTO REP
    FOR A = cont TO 10
    AUXN$ = nombre(A)
    AUXP = puntos(A)
    nombre(A) = NOMB$
    puntos(A) = PUNT
    NOMB$ = AUXN$: PUNT = AUXP
    NEXT A
    CLOSE #1
   
    OPEN "LISTA" FOR OUTPUT AS #1
    FOR A = 1 TO 10
    WRITE #1, puntos(A), nombre(A)
    NEXT A
    CLOSE #1
    'Imprime el archivo en la pantalla.
    OPEN "LISTA" FOR INPUT AS #1
    CLS
    PRINT "Datos en archivo:": PRINT
    DO WHILE NOT EOF(1)
        INPUT #1, reg1, REG2$   'Lee datos del archivo.
        PRINT reg1, REG2$       'Imprime los datos en la pantalla.
    LOOP
    CLOSE #1
    

