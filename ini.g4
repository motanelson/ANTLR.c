
grammar INI;

// Ponto de entrada para o arquivo INI
file : section* EOF ;

// Definição de uma seção no arquivo INI
section : SECTION_HEADER (pair)* ;

// Definição de um par chave-valor
pair : KEY '=' VALUE ;

// Tokens para seções, chaves e valores
SECTION_HEADER : '[' SECTION_NAME ']' ;
KEY : ~[=\r\n\[\];]+ ;
VALUE : ~[\r\n]+ ;

// Nomes de seções são alfanuméricos e podem conter alguns caracteres especiais
fragment SECTION_NAME : [a-zA-Z0-9_]+ ;

// Tokens auxiliares para ignorar espaços e lidar com comentários
COMMENT : ';' ~[\r\n]* -> skip ;
WS : [ \t\r\n]+ -> skip ;
