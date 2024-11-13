
grammar JavaSimple;

// Regras principais
programa : classe* ;

classe : 'class' ID '{' membroClasse* '}' ;

membroClasse : metodo | variavel ;

metodo : tipo ID '(' parametroLista? ')' bloco ;

variavel : tipo ID ';' ;

parametroLista : parametro (',' parametro)* ;

parametro : tipo ID ;

bloco : '{' instrucao* '}' ;

instrucao : variavel 
          | chamadaMetodo ';'
          | retorno ';'
          | bloco ;

chamadaMetodo : ID '(' argumentoLista? ')' ;

retorno : 'return' expressao? ;

argumentoLista : expressao (',' expressao)* ;

expressao : ID
          | numero
          | chamadaMetodo ;

tipo : 'int' | 'float' | 'boolean' | 'String' | ID ;

ID : [a-zA-Z_][a-zA-Z_0-9]* ;
numero : [0-9]+ ;
WS : [ \t\r\n]+ -> skip ;
