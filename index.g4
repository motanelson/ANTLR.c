grammar SimpleCustomLang;

// Ponto de entrada para o código da linguagem
program : line* EOF ;

// Definição de uma linha, que pode ser uma operação, definição de variável ou sub-rotina
line : operacao
     | variavel
     | subrotina
     ;

// Definição de uma operação (exemplo: "mul,a,b")
operacao : 'mul' ',' ID ',' ID
         | 'add' ',' ID ',' ID
         | 'sub' ',' ID ',' ID
         | 'div' ',' ID ',' ID
         ;

// Definição de variável (exemplo: "integer,i,0")
variavel : 'integer' ',' ID ',' INT ;

// Definição de sub-rotina (exemplo: "sub,main")
subrotina : 'sub' ',' ID ;

// Tokens básicos
ID : [a-zA-Z_][a-zA-Z0-9_]* ; // Identificadores
INT : [0-9]+ ;               // Inteiros
WS : [ \t\r\n]+ -> skip ;    // Espaços em branco (ignorar)

