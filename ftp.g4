grammar FTPSimplified;

// ==========================
// Regras principais
// ==========================
ftpCommand
    : userCommand
    | passCommand
    | cwdCommand
    | pwdCommand
    | listCommand
    | retrCommand
    | storCommand
    | quitCommand
    ;

userCommand
    : 'USER' SPACE IDENTIFIER NEWLINE
    ;

passCommand
    : 'PASS' SPACE PASSWORD NEWLINE
    ;

cwdCommand
    : 'CWD' SPACE PATH NEWLINE
    ;

pwdCommand
    : 'PWD' NEWLINE
    ;

listCommand
    : 'LIST' (SPACE PATH)? NEWLINE
    ;

retrCommand
    : 'RETR' SPACE PATH NEWLINE
    ;

storCommand
    : 'STOR' SPACE PATH NEWLINE
    ;

quitCommand
    : 'QUIT' NEWLINE
    ;

// ==========================
// Tokens Léxicos
// ==========================
IDENTIFIER
    : [a-zA-Z0-9_.-]+
    ;

PASSWORD
    : .+  // Qualquer sequência de caracteres até o fim da linha
    ;

PATH
    : '/'? (~[ \r\n])*  // Caminhos que podem começar com '/' e não contêm espaços ou quebras de linha
    ;

SPACE
    : ' '
    ;

NEWLINE
    : '\r'? '\n'
    ;

WHITESPACE
    : [ \t]+ -> skip    // Ignora espaços e tabulações fora dos comandos
    ;