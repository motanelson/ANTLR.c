grammar RTF;

// ==========================
// Regras principais do RTF
// ==========================
document
    : group+ EOF 
    ;

group
    : '{' content '}'
    ;

content
    : (control | text | group)*
    ;

// ==========================
// Controle e Texto
// ==========================
control
    : '\\' (controlWord | controlSymbol)
    ;

controlWord
    : Word (Number)?
    ;

controlSymbol
    : Symbol
    ;

text
    : Text
    ;

// ==========================
// Tokens Léxicos
// ==========================
Word
    : [a-zA-Z]+
    ;

Number
    : '-'? [0-9]+
    ;

Symbol
    : [~{}\\ \r\n\t]  // qualquer caractere que não seja {, }, \, ou espaços em branco
    ;

Text
    : (~[{}\\ \r\n\t])+  // texto sem formatação, ignorando caracteres de controle
    ;

Whitespace
    : [ \t\r\n]+ -> skip
    ;