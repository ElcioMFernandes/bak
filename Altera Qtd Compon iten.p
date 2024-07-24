/* Defini‡Æo de vari veis */
DEFINE VARIABLE cFileName AS CHARACTER   NO-UNDO INITIAL "U:\\Elcio\\tmp\\itens.csv".
DEFINE VARIABLE cField1   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cField2   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cField3   AS DECIMAL     NO-UNDO.
DEFINE VARIABLE hInput    AS HANDLE      NO-UNDO.
DEFINE VARIABLE cLine     AS CHARACTER   NO-UNDO.

INPUT FROM VALUE(cFileName). // Abrir o arquivo CSV

IMPORT UNFORMATTED cLine. // Ignora a primeira linha (cabe‡alho)

REPEAT: // Ler e processar cada linha do arquivo
    IMPORT UNFORMATTED cLine.
    IF cLine = "" THEN LEAVE. // Se a linha for vazia termina o loop

    cField1 = ENTRY(1, cLine, ",").
    cField2 = ENTRY(2, cLine, ",").
    cField3 = DECIMAL(REPLACE(ENTRY(3, cLine, ","),".",",")).

    //FOR EACH estrutura EXCLUSIVE-LOCK
    FOR EACH estrutura NO-LOCK
        WHERE estrutura.it-codigo = cField1
        AND estrutura.es-codigo = "970114":
            DISPLAY estrutura.it-codigo estrutura.es-codigo estrutura.qtd-compon cField3.
            //ASSIGN estrutura.qtd-compon = cField3.            
    END.
END.

INPUT CLOSE. // Fecha o arquivo
