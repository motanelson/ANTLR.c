
grammar INI;

// Ponto de entrada para o arquivo INI
file : SECTION * EOF ;

// Definição de uma seção no arquivo INI
SECTION : COMMENTS | SECTION_HEADER |  PAIR  ;
// Definição de um par chave-valor
PAIR : KEY '=' VALUE  ;

// Tokens para seções, chaves e valores
SECTION_HEADER : '[' SECTION_NAME ']' ;
KEY : ~[=\r\n[\];]+ ;
VALUE : ~[\r\n]+ ;

// Nomes de seções são alfanuméricos e podem conter alguns caracteres especiais
fragment SECTION_NAME : [a-zA-Z0-9_]+ ;

// Tokens auxiliares para ignorar espaços e lidar com comentários
COMMENTS : ';' ~[\r\n]*  ;
WS : [\t\r\n]+ -> skip ;