grammar CSV;

// ==========================
// Regras principais do CSV
// ==========================
file
    : row+ EOF               // Um arquivo é composto por várias linhas
    ;

row
    : cell (',' cell)* NEWLINE  // Uma linha é composta por células separadas por vírgula
    ;

cell
    : TEXT                     // Célula com texto sem aspas
    | STRING                   // Célula com texto entre aspas
    |                          // Célula vazia
    ;

// ==========================
// Tokens Léxicos
// ==========================
TEXT
    : ~[",\r\n"]+              // Texto que não contém vírgulas, quebras de linha ou aspas
    ;

STRING
    : '"' ('""' | ~["\r\n])* '"'   // Texto entre aspas duplas, "" representa uma aspa dentro do texto
    ;

NEWLINE
    : '\r'? '\n'               // Nova linha, compatível com Windows (\r\n) e Unix (\n)
    ;

Whitespace
    : [ \t]+ -> skip           // Ignora espaços e tabulações fora das células
    ;