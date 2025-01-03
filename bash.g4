grammar SimpleBash;

// Ponto de entrada para o script Bash
script : instrucao* EOF ;

// Instruções possíveis
instrucao : atribuicao
          | comando
          | condicionalIf
          | loopWhile
          ;

// Atribuição de variável
atribuicao : ID '=' expressao ;

// Comando Bash básico
comando : ID argumento* ';'? ;

// Argumentos para comandos
argumento : expressao ;

// Estrutura condicional if-then-else
condicionalIf : 'if' expressao 'then' script ('else' script)? 'fi' ;

// Estrutura de loop while
loopWhile : 'while' expressao 'do' script 'done' ;

// Expressão simples
expressao : ID
          | STRING
          | NUMERO
          | '$' ID // Variável
          ;

// Tokens básicos
ID : [a-zA-Z_][a-zA-Z0-9_]* ;
STRING : '"' (~["])* '"' ;
NUMERO : [0-9]+ ;
WS : [ \t\r\n]+ -> skip ;

