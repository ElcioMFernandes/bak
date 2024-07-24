DEFINE STREAM s1.
DEFINE STREAM relat.

DEFINE VAR linha AS CHAR NO-UNDO.

INPUT STREAM s1 FROM U:\Elcio\temp\cd-it.txt.
OUTPUT STREAM relat TO U:\Elcio\temp\relat-it-cd-pd.csv NO-CONVERT.

PUT STREAM relat "Item;".
PUT STREAM relat "Pedido".
PUT STREAM relat SKIP.

REPEAT:
    IMPORT STREAM s1 UNFORMATTED linha.

    DEF VAR cont AS INT.
    ASSIGN cont = 0.
    
    FOR EACH ped-item NO-LOCK WHERE ped-item.it-codigo = linha:
        IF ped-item.cod-sit-item < 3 THEN DO:
            ASSIGN cont = cont + 1.
            PUT STREAM relat UNFORMATTED 
                ped-item.it-codigo ";" 
                "Sim;"
                ped-item.nr-pedcli
                SKIP.
        END.                                                          
    END.
    IF cont = 0 THEN DO:
        FIND FIRST ITEM WHERE item.it-codigo = linha EXCLUSIVE-LOCK NO-ERROR.
            IF AVAIL ITEM THEN DO:
                    ASSIGN mgcad2.ITEM.fm-cod-com = "CON".
            END.
    END.
END.

INPUT STREAM s1 CLOSE.
OUTPUT STREAM relat CLOSE.
