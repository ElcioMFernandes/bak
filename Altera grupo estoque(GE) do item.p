FIND FIRST mgcad2.ITEM WHERE mgcad2.ITEM.it-codigo = "18390".
IF AVAILABLE mgcad2.ITEM THEN
DO:
    ASSIGN mgcad2.ITEM.ge-codigo = 1.
END.
