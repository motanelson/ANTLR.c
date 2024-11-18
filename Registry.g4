
grammar Registry;

// Ponto de entrada para o arquivo de registro
registryFile : HEADER * EOF ;

// Cabeçalho indicando a versão do arquivo .reg
HEADER : COMMENTS | REG_HEADER  | ENTRY | KEYPATH ;

// Entrada de registro, que pode ser uma chave com vários valores
ENTRY :  STRING_VALUE '=' VALUE ;

// Caminho da chave entre colchetes
KEYPATH : '[' PATH ']' ;

// Definição de um valor (string, hexadecimal ou DWORD)
VALUE : STRING_VALUE | HEX_VALUE | DWORD_VALUE ;

// Tokens específicos
REG_HEADER : 'REGEDIT4' ;
PATH : (~[\t\r\n])+ ;
STRING_VALUE : '"' (~["\r\n])* '"' ;
HEX_VALUE : 'hex:' HEX_BYTE (',' HEX_BYTE)* ;
DWORD_VALUE : 'dword:' HEX_DIGIT+ ;

// Definição de um byte hexadecimal (dois dígitos)
fragment HEX_BYTE : HEX_DIGIT HEX_DIGIT ;
fragment HEX_DIGIT : [0-9a-fA-F] ;

// Tokens auxiliares para nova linha e comentários
COMMENTS : ';' ~[\r\n]*  ;
WS : [ \t\r\n]+ -> skip ;
