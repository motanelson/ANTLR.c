
grammar SimpleGambasLang;

// Ponto de entrada para o programa
program : statement* EOF ;

// Instruções
statement : varDecl
          | assignment
          | funcDecl
          | ifStatement
          | forLoop
          | funcCall
          | returnStmt
          ;

// Declaração de variável (exemplo: "DIM x AS INTEGER")
varDecl : 'DIM' ID 'AS' tipo ;

// Atribuição (exemplo: "x = 10")
assignment : ID '=' expression ;

// Declaração de função (exemplo: "PUBLIC FUNCTION Add(a AS INTEGER, b AS INTEGER) AS INTEGER")
funcDecl : 'PUBLIC' 'FUNCTION' ID '(' paramList? ')' ('AS' tipo)? NEWLINE statement* 'END' 'FUNCTION' ;

// Lista de parâmetros para função
paramList : param (',' param)* ;
param : ID 'AS' tipo ;

// Tipos de dados
tipo : 'INTEGER' | 'FLOAT' | 'STRING' | 'BOOLEAN' ;

// Declaração condicional If (exemplo: "IF x > 10 THEN ... END IF")
ifStatement : 'IF' expression 'THEN' NEWLINE statement* 'END' 'IF' ;

// Laço For (exemplo: "FOR i = 1 TO 10 ... NEXT")
forLoop : 'FOR' ID '=' expression 'TO' expression NEWLINE statement* 'NEXT' ;

// Chamada de função (exemplo: "Call Add(5, 10)")
funcCall : ID '(' argList? ')' ;

// Lista de argumentos para chamada de função
argList : expression (',' expression)* ;

// Declaração de retorno (exemplo: "RETURN x")
returnStmt : 'RETURN' expression ;

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
literal : INT | FLOAT | STRING | BOOL ;

// Tokens básicos
ID : [a-zA-Z_][a-zA-Z0-9_]* ; // Identificadores
INT : [0-9]+ ;                // Inteiros
FLOAT : [0-9]+ '.' [0-9]+ ;    // Floats
STRING : '"' (~["])* '"' ;     // Strings
BOOL : 'TRUE' | 'FALSE' ;      // Booleanos
NEWLINE : '\r'? '\n' ;         // Nova linha
WS : [ \t]+ -> skip ;          // Espaços em branco
