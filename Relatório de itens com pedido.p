DEFINE STREAM s1.
DEFINE STREAM relat.

DEFINE VAR linha AS CHAR NO-UNDO.

INPUT STREAM s1 FROM U:\Elcio\temp\cd-it.txt.
OUTPUT STREAM relat TO U:\Elcio\temp\relat-it-cd-pd.csv NO-CONVERT.

PUT STREAM relat "Item;".
PUT STREAM relat "Tem Pedido?;".
PUT STREAM relat SKIP.

def var h-acomp               as handle.

RUN utp/ut-acomp.p PERSISTENT SET h-acomp.

RUN pi-inicializar IN h-acomp(INPUT "Alterando medidas").

REPEAT :

    IMPORT STREAM s1 UNFORMATTED linha.
    
    RUN pi-acompanhar IN h-acomp("Item: " + STRING(linha)).
       
    FOR EACH ped-item NO-LOCK
        WHERE ped-item.it-codigo = linha:
        IF ped-item.cod-sit-item < 3 THEN DO:
            PUT STREAM relat UNFORMATTED 
                       ped-item.it-codigo ";" 
                      "Sim;"
                      ped-item.nr-pedcli
                      SKIP.
        END.
        ELSE DO:
            PUT STREAM relat UNFORMATTED 
                       ped-item.it-codigo ";" 
                      "NÆo;"
                      SKIP.
            LEAVE.
        END.
    END.
        
PUT STREAM relat UNFORMATTED 
    linha ";" 
    "NÆo;"
    SKIP.       
        
          


    
END.

RUN pi-finalizar IN h-acomp.

input stream s1 CLOSE.
OUTPUT STREAM relat CLOSE.






