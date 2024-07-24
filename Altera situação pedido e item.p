FOR EACH ped-venda EXCLUSIVE-LOCK
    WHERE ped-venda.nr-pedcli = "1687731/RO" AND
          ped-venda.nome-abrev = "JMDAGUARDA":
    UPDATE cod-sit-ped WITH WIDTH 200.
    FOR EACH ped-item OF ped-venda:
        DISP it-codigo.
        UPDATE cod-sit-item WITH WIDTH 200.
    END.
END.
