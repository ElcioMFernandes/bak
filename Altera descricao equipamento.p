DEFINE VARIABLE current-line    AS CHARACTER FORMAT "x(12)" NO-UNDO.
DEFINE VARIABLE new-description AS CHARACTER FORMAT "x(250)" NO-UNDO.

INPUT FROM "U:\Elcio\tmp\eqpt.txt".

REPEAT:
    ASSIGN new-description = "".
    IMPORT UNFORMATTED current-line.
    IF current-line = ? THEN LEAVE.

    FIND FIRST mgcad2.equipto EXCLUSIVE-LOCK
        WHERE mgcad2.equipto.cd-equipto = current-line NO-ERROR.
    
    IF AVAILABLE mgcad2.equipto THEN DO:
        ASSIGN new-description = "TOG - " + mgcad2.equipto.descricao.
        ASSIGN mgcad2.equipto.descricao = new-description.
        DISPLAY mgcad2.equipto.cd-equipto mgcad2.equipto.descricao WITH WIDTH 300 .        

    END.
    ELSE DO:
        MESSAGE current-line VIEW-AS ALERT-BOX.
    END.
END.

INPUT CLOSE.
