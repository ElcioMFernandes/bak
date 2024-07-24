// Consultar e-mails

/*
FIND FIRST param-inspec NO-LOCK
    WHERE param-inspec.cod-estabel = "BOB" NO-ERROR.
    IF AVAIL param-inspec THEN
    DO:
        DISP param-inspec.email
        WITH WIDTH 300 3 DOWN.
    END.
*/

// Inserir e-mails

FIND FIRST param-inspec EXCLUSIVE-LOCK
    WHERE param-inspec.cod-estabel = "BOB" NO-ERROR.
    IF AVAIL param-inspec THEN
    DO:
        ASSIGN param-inspec.email = param-inspec.email + ";juliaj@tuper.com.br". 
        // ";antonio.souza@tuper.com.br;jair.souza@tuper.com.br".
    END.
