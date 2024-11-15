grammar CamelInterpreter;

// ==========================
// Regras principais
// ==========================
document
    : identifier+ EOF       // Um documento contém múltiplos identificadores
    ;

identifier
    : camelCaseIdentifier   // Pode ser um identificador camelCase
    | PascalCaseIdentifier  // Ou um identificador PascalCase
    ;

camelCaseIdentifier
    : LOWERCASE (Part)*     // Começa com letra minúscula e pode ter partes adicionais
    ;

PascalCaseIdentifier
    : UPPERCASE (Part)*     // Começa com letra maiúscula e pode ter partes adicionais
    ;

Part
    : UPPERCASE LOWERCASE*  // Uma parte começa com maiúscula, seguida de zero ou mais minúsculas
    ;

// ==========================
// Tokens Léxicos
// ==========================
fragment LOWERCASE
    : [a-z]                 // Letras minúsculas
    ;

fragment UPPERCASE
    : [A-Z]                 // Letras maiúsculas
    ;

Whitespace
    : [ \t\r\n]+ -> skip    // Ignora espaços em branco
    ;