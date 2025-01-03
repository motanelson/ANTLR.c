grammar SimpleCSharp;

// Ponto de entrada do programa
programa : classe* ;

// Definição de classe
classe : 'class' ID '{' membroClasse* '}' ;

// Membros da classe (métodos ou variáveis)
membroClasse : metodo | variavel ;

// Declaração de método
metodo : tipo ID '(' parametroLista? ')' bloco ;

// Declaração de variável
variavel : tipo ID ';' ;

// Lista de parâmetros do método
parametroLista : parametro (',' parametro)* ;

// Definição de parâmetro
parametro : tipo ID ;

// Bloco de código
bloco : '{' instrucao* '}' ;

// Instrução dentro de um bloco
instrucao : variavel 
          | chamadaMetodo ';'
          | retorno ';'
          | bloco ;

// Chamada de método
chamadaMetodo : ID '(' argumentoLista? ')' ;

// Declaração de retorno
retorno : 'return' expressao? ;

// Lista de argumentos
argumentoLista : expressao (',' expressao)* ;

// Expressão básica
expressao : ID
          | numero
          | chamadaMetodo ;

// Tipos de dados primitivos e objetos
tipo : 'int' | 'float' | 'bool' | 'string' | ID ;

// Tokens básicos
ID : [a-zA-Z_][a-zA-Z_0-9]* ;
numero : [0-9]+ ;
WS : [ \t\r\n]+ -> skip ;

