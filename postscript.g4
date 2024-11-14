
grammar SimplePostScript;

// Ponto de entrada do arquivo PostScript
programa : instrucao+ EOF ;

// Definições das instruções
instrucao : operadorPilha
          | operadorAritmetico
          | operadorLogico
          | operadorDesenho
          | atribuicao
          | controleFluxo
          | expressao
          ;

// Operações de manipulação de pilha
operadorPilha : 'dup' | 'exch' | 'pop' | 'roll' | 'copy' | 'clear' ;

// Operações aritméticas
operadorAritmetico : 'add' | 'sub' | 'mul' | 'div' | 'idiv' | 'mod' | 'neg' | 'abs' | 'sqrt' | 'sin' | 'cos' | 'atan' | 'exp' | 'ln' | 'log' ;

// Operações lógicas e comparativas
operadorLogico : 'eq' | 'ne' | 'gt' | 'lt' | 'ge' | 'le' | 'and' | 'or' | 'not' ;

// Operações de desenho (simplificado)
operadorDesenho : 'moveto' | 'lineto' | 'stroke' | 'fill' | 'newpath' | 'closepath' ;

// Atribuição e definição de variáveis
atribuicao : '/' ID 'def' ;

// Controle de fluxo (simplificado)
controleFluxo : '{' instrucao+ '}' 'if'
              | '{' instrucao+ '}' 'ifelse'
              | '{' instrucao+ '}' 'repeat'
              ;

// Expressões (podem ser valores ou variáveis)
expressao : numero
          | ID
          ;

// Tipos de dados
numero : NUMERO | '-'? NUMERO ('.' NUMERO)? ;

// Tokens
ID : [a-zA-Z_][a-zA-Z0-9_]* ;
NUMERO : [0-9]+ ;
WS : [ \t\r\n]+ -> skip ;
