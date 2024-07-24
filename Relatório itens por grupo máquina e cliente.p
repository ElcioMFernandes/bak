CURRENT-LANGUAGE = CURRENT-LANGUAGE.

DEFINE STREAM relatorio.
// Cria��o da stream para o relat�rio

OUTPUT STREAM relatorio TO U:\Elcio\relat-item-gm-cliente.csv NO-CONVERT.
// Sa�da da stream relat�rio em um arquivo CSV e NO-CONVERT para n�o modificar os caract�res

PUT STREAM relatorio "C�digo do Item;"
                     "Descri��o do Item;"
                     "Grupo M�quina;"
                     "C�digo do Cliente;"
                     "Nome abreviado;"
// Inserindo os cabe�alhos na stream com o PUT

                     SKIP.
                     // Pulando uma linha da stream com SKIP

FOR EACH ITEM NO-LOCK
// La�o de repeti��o(FOR EACH) de leitura(NO-LOCK) na tabela item

    WHERE ITEM.cod-estabel = "103"
    // Onde o c�digo do estabelecimento da tabela item for igual a 103
    
    AND ITEM.cod-obsoleto = 1:
    // E o c�digo obsoleto da coluna cod-obsoleto for igual a 1

        FIND FIRST operacao
        // Procurando pela primeira opera��o que atenda ao WHERE
        
            WHERE operacao.it-codigo = ITEM.it-codigo
            // Onde, o item c�digo da tabela opera��o for igual ao c�digo do item na tabela item
            
            AND (operacao.gm-codigo = "625" OR operacao.gm-codigo = "626")
            // E o c�digo do grupo m�quina for igual a 625 ou 626
            
            NO-LOCK NO-ERROR.
            // NO-LOCK somente para a leitura e NO-ERROR para caso n�o encontrar no FIND FIRST n�o dar erro

        IF AVAIL operacao THEN DO:
        // Se encontrado uma opera��o ent�o fa�a
        
            FOR EACH item-cli NO-LOCK
            // La�o de repeti��o na tabela item-cli somente como leitura
            
                WHERE item-cli.it-codigo = ITEM.it-codigo:
                // Onde o c�digo do item dentro da tabela item-cli seja igual ao c�digo do item na tabela item
                
                PUT STREAM relatorio UNFORMATTED
                // Sa�da da stream relatorio com UNFORMATTED para n�o desconfigurar
                
                                    ITEM.it-codigo        ";"
                                    ITEM.desc-item        ";"
                                    operacao.gm-codigo    ";"
                                    item-cli.cod-emitente ";"
                                    item-cli.nome-abrev   ";"
                                    // Inserindo os registros no CSV
                                    
                                    SKIP.
                                    // Pulando uma linha
                
            END.
        END.
END.

OUTPUT STREAM relatorio CLOSE.
// Fechando a stream relat�rio
