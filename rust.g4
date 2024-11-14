grammar SimpleRust;

// Ponto de entrada para o código Rust
program : (importDecl | varDecl | funcDecl | statement)* EOF ;

// Declarações de importação
importDecl : 'use' ID ('::' ID)* '::' '*'? ';' ;

// Declaração de variáveis (let binding)
varDecl : 'let' ('mut' | 'const')? ID (':' tipo)? ('=' expression)? ';' ;

// Declaração de função
funcDecl : 'fn' ID '(' paramList? ')' ('->' tipo)? '{' statement* '}' ;

// Lista de parâmetros de função
paramList : param (',' param)* ;
param : ID ':' tipo ;

// Tipos de dados básicos
tipo : 'i32' | 'f64' | 'bool' | 'char' | '&str' | ID ;

// Instruções
statement : varDecl
          | assignment
          | funcCall
          | ifStatement
          | loopStatement
          | returnStmt
          ;

// Atribuição de valor
assignment : ID '=' expression ';' ;

// Chamada de função
funcCall : ID '(' argList? ')' ';' ;

// Lista de argumentos para chamada de função
argList : expression (',' expression)* ;

// Declaração condicional if-else
ifStatement : 'if' expression '{' statement* '}' ('else' '{' statement* '}')? ;

// Laço de repetição (for, while e loop)
loopStatement : forLoop
              | whileLoop
              | loop ;

// Laço for
forLoop : 'for' ID 'in' expression '{' statement* '}' ;

// Laço while
whileLoop : 'while' expression '{' statement* '}' ;

// Laço infinito loop
loop : 'loop' '{' statement* '}' ;

// Declaração de retorno
returnStmt : 'return' expression? ';' ;

// Expressões
expression : primary
           | expression op=('*' | '/' | '+' | '-') expression
           | expression op=('==' | '!=' | '<' | '>' | '<=' | '>=') expression
           ;

// Expressões primárias
primary : literal
        | ID
        | funcCall
        | '(' expression ')'
        ;

// Literais
literal : INT | FLOAT | STRING | CHAR | BOOL ;

// Tokens básicos
ID : [a-zA-Z_][a-zA-Z0-9_]* ;
INT : [0-9]+ ;
FLOAT : [0-9]+ '.' [0-9]+ ;
STRING : '"' (~["])* '"' ;
CHAR : '\'' . '\'' ;
BOOL : 'true' | 'false' ;
WS : [ \t\r\n]+ -> skip ;

