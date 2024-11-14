
grammar Registry;

// Ponto de entrada para o arquivo de registro
registryFile : header entry* EOF ;

// Cabeçalho indicando a versão do arquivo .reg
header : REG_HEADER ;

// Entrada de registro, que pode ser uma chave com vários valores
entry : keyPath ('=' value)? NEWLINE ;

// Caminho da chave entre colchetes
keyPath : '[' PATH ']' ;

// Definição de um valor (string, hexadecimal ou DWORD)
value : STRING_VALUE | HEX_VALUE | DWORD_VALUE ;

// Tokens específicos
REG_HEADER : 'REGEDIT4' ;
PATH : (~[\[\]\r\n])+ ;
STRING_VALUE : '"' (~["\r\n])* '"' ;
HEX_VALUE : 'hex:' HEX_BYTE (',' HEX_BYTE)* ;
DWORD_VALUE : 'dword:' HEX_DIGIT+ ;

// Definição de um byte hexadecimal (dois dígitos)
fragment HEX_BYTE : HEX_DIGIT HEX_DIGIT ;
fragment HEX_DIGIT : [0-9a-fA-F] ;

// Tokens auxiliares para nova linha e comentários
NEWLINE : '\r'? '\n' ;
COMMENT : ';' ~[\r\n]* -> skip ;
WS : [ \t]+ -> skip ;
