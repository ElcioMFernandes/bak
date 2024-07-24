// Alterar
FIND FIRST cadmulti.emitente EXCLUSIVE-LOCK
    WHERE cadmulti.emitente.nome-abrev = "FRISOLDAS1" NO-ERROR.
IF AVAILABLE cadmulti.emitente THEN DO:
    ASSIGN cadmulti.emitente.nr-mesina = 999.
END.

// Consulta
FIND FIRST cadmulti.emitente NO-LOCK
    WHERE cadmulti.emitente.nome-abrev = "FRISOLDAS1" NO-ERROR.
IF AVAILABLE cadmulti.emitente THEN DO:
    DISPLAY cadmulti.emitente.nr-mesina FORMAT ">>>>9".
END.
