CURRENT-LANGUAGE = CURRENT-LANGUAGE.

//DEF TEMP-TABLE tt-param NO-UNDO
//    FIELD nome LIKE cadmulti.emitente.nome-emit
//    FIELD cnpj LIKE cadmulti.emitente.cgc
//    FIELD natu LIKE cadmulti.emitente.natureza
    
DEF STREAM relat.

OUTPUT STREAM relat TO U:\Elcio\temp\relat.csv NO-CONVERT.

PUT STREAM relat "Nome;".
PUT STREAM relat "CNPJ;".
PUT STREAM relat "Natureza;".
PUT STREAM relat SKIP.

FIND FIRST cadmulti.emitente
    WHERE cadmulti.emitente.cod-emitente = 259217 NO-LOCK NO-ERROR.
    
    IF AVAIL cadmulti.emitente THEN DO:
        PUT STREAM relat UNFORMATTED
            cadmulti.emitente.nome-emit ";"
            cadmulti.emitente.cgc       ";"
            cadmulti.emitente.natureza  ";"
            SKIP.
        
    END.
    
OUTPUT STREAM relat CLOSE.
