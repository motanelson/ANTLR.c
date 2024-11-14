grammar SimpleGo;

// Ponto de entrada para o código Go
program : (importDecl | varDecl | funcDecl | statement)* EOF ;

// Declarações de importação
importDecl : 'import' STRING ;

// Declaração de variáveis
varDecl : 'var' ID (':' tipo)? ('=' expression)? ;

// Declaração de função
funcDecl : 'func' ID '(' paramList? ')' (tipo | 'void')? '{' statement* '}' ;

// Lista de parâmetros da função
paramList : param (',' param)* ;
param : ID ':' tipo ;

// Tipos de dados
tipo : 'int' | 'float64' | 'string' | 'bool' | ID ;

// Instruções
statement : varDecl
          | assignment
          | funcCall
          | ifStatement
          | forLoop
          | returnStmt
          ;

// Atribuição de valor
assignment : ID '=' expression ;

// Chamada de função
funcCall : ID '(' argList? ')' ;

// Lista de argumentos para chamada de função
argList : expression (',' expression)* ;

// Declaração condicional if-else
ifStatement : 'if' expression '{' statement* '}' ('else' '{' statement* '}')? ;

// Laço for
forLoop : 'for' expression '{' statement* '}' ;

// Declaração de retorno
returnStmt : 'return' expression? ;

// Expressões
expression : primary
           | expression op=('*' | '/' | '+' | '-') expression
           | expression op=('==' | '!=' | '<' | '>' | '<=' | '>=') expression
           ;

// Expressões primárias
primary : '(' expression ')'
        | ID
        | literal ;

// Literais (números, strings, bool)
literal : INT | FLOAT | STRING | BOOL ;

// Tokens básicos
ID : [a-zA-Z_][a-zA-Z0-9_]* ;
INT : [0-9]+ ;
FLOAT : [0-9]+ '.' [0-9]+ ;
STRING : '"' (~["])* '"' ;
BOOL : 'true' | 'false' ;
WS : [ \t\r\n]+ -> skip ;

