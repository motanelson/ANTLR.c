
grammar SimplePHP;

// Ponto de entrada para o programa PHP
program : ('<?php' statement* '?>')* EOF ;

// Declarações
statement : varDecl
          | assignment
          | funcDecl
          | ifStatement
          | whileLoop
          | forLoop
          | echoStatement
          | returnStmt
          ;

// Declaração de variável (exemplo: "$x = 10;")
varDecl : VARIABLE '=' expression ';' ;

// Atribuição (exemplo: "$x = 10;")
assignment : VARIABLE '=' expression ';' ;

// Declaração de função (exemplo: "function add($a, $b) { return $a + $b; }")
funcDecl : 'function' ID '(' paramList? ')' '{' statement* '}' ;

// Lista de parâmetros para função
paramList : param (',' param)* ;
param : VARIABLE ;

// Estruturas de controle
ifStatement : 'if' '(' expression ')' '{' statement* '}' ('else' '{' statement* '}')? ;
whileLoop : 'while' '(' expression ')' '{' statement* '}' ;
forLoop : 'for' '(' assignment? ';' expression? ';' assignment? ')' '{' statement* '}' ;

// Instrução echo (exemplo: "echo $x;")
echoStatement : 'echo' expressionList ';' ;

// Declaração de retorno (exemplo: "return $x;")
returnStmt : 'return' expression? ';' ;

// Expressões
expression : primary
           | expression op=('*' | '/' | '+' | '-') expression
           | expression op=('==' | '!=' | '<' | '>' | '<=' | '>=') expression
           ;

// Expressão primária
primary : literal
        | VARIABLE
        | funcCall
        | '(' expression ')'
        ;

// Chamada de função
funcCall : ID '(' argList? ')' ;

// Lista de argumentos para chamada de função
argList : expression (',' expression)* ;

// Lista de expressões para echo
expressionList : expression (',' expression)* ;

// Literais
literal : INT | FLOAT | STRING | BOOL ;

// Tokens básicos
VARIABLE : '$' [a-zA-Z_][a-zA-Z0-9_]* ; // Variáveis em PHP começam com '$'
ID : [a-zA-Z_][a-zA-Z0-9_]* ;           // Identificadores
INT : [0-9]+ ;                          // Inteiros
FLOAT : [0-9]+ '.' [0-9]+ ;             // Flutuantes
STRING : '"' (~["])* '"' ;              // Strings entre aspas
BOOL : 'true' | 'false' ;               // Booleanos
WS : [ \t\r\n]+ -> skip ;               // Espaços em branco (ignorar)
