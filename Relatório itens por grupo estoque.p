DEFINE VARIABLE cod-item       AS CHARACTER NO-UNDO.
DEFINE VARIABLE desc-item      AS CHARACTER NO-UNDO.
DEFINE VARIABLE norma-item     AS CHARACTER NO-UNDO.
DEFINE VARIABLE norma-item-aco AS CHARACTER NO-UNDO.
DEFINE VARIABLE largura-item   AS DECIMAL   NO-UNDO.
DEFINE VARIABLE espessura-item AS DECIMAL   NO-UNDO.
DEFINE VARIABLE situacao-item  AS CHARACTER NO-UNDO.
DEFINE VARIABLE csv-line       AS CHARACTER NO-UNDO.

OUTPUT TO VALUE("U:\Elcio\tmp\itens-por-ge.csv").

PUT UNFORMATTED "Item;Descricao;Norma;Norma Aco/Prod;Largura;Espessura;Situacao" SKIP.

FOR EACH mgcad2.ITEM WHERE mgcad2.ITEM.ge-codigo = 5 NO-LOCK:
    ASSIGN cod-item      = mgcad2.ITEM.it-codigo
           desc-item     = mgcad2.ITEM.desc-item.

    CASE mgcad2.ITEM.cod-obsoleto:
        WHEN 1 THEN
            ASSIGN situacao-item = "Ativo".
        WHEN 2 THEN
            ASSIGN situacao-item = "Obsoleto Ordens Autom ticas".
        WHEN 3 THEN
            ASSIGN situacao-item = "Obsoleto Todas as ordens".
        WHEN 4 THEN
            ASSIGN situacao-item = "Totalmente Obsoleto".
        OTHERWISE
            ASSIGN situacao-item = "Desconhecido".
    END CASE.

    FOR EACH mgesp.exten-item WHERE mgesp.exten-item.it-codigo = cod-item NO-LOCK:
        ASSIGN norma-item     = mgesp.exten-item.norma
               largura-item   = mgesp.exten-item.largura
               espessura-item = mgesp.exten-item.espessura
               norma-item-aco = mgesp.exten-item.norma-aco.
    END.

    ASSIGN csv-line = cod-item + ";" + desc-item + ";" + norma-item + ";" + norma-item-aco + ";" + STRING(largura-item) + ";" + STRING(espessura-item) + ";" + situacao-item.
    PUT UNFORMATTED csv-line SKIP.
END.

OUTPUT CLOSE.
