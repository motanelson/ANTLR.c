grammar SimplePython;

// Ponto de entrada para o programa Python
program : statement+ EOF ;

// Declarações
statement : varDecl
          | assignment
          | funcDecl
          | ifStatement
          | whileLoop
          | forLoop
          | printStatement
          | returnStmt
          | NEWLINE
          ;

// Declaração de variável (exemplo: "x = 10")
varDecl : ID '=' expression NEWLINE ;

// Atribuição de valor (exemplo: "x = 10")
assignment : ID '=' expression NEWLINE ;

// Declaração de função (exemplo: "def add(a, b): ...")
funcDecl : 'def' ID '(' paramList? ')' ':' NEWLINE INDENT statement* DEDENT ;

// Lista de parâmetros para função
paramList : param (',' param)* ;
param : ID ;

// Estruturas de controle
ifStatement : 'if' expression ':' NEWLINE INDENT statement* DEDENT ('elif' expression ':' NEWLINE INDENT statement* DEDENT)* ('else' ':' NEWLINE INDENT statement* DEDENT)? ;
whileLoop : 'while' expression ':' NEWLINE INDENT statement* DEDENT ;
forLoop : 'for' ID 'in' expression ':' NEWLINE INDENT statement* DEDENT ;

// Instrução print (exemplo: "print(x)")
printStatement : 'print' '(' expressionList ')' NEWLINE ;

// Declaração de retorno (exemplo: "return x")
returnStmt : 'return' expression? NEWLINE ;

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

// Chamada de função
funcCall : ID '(' argList? ')' ;

// Lista de argumentos para chamada de função
argList : expression (',' expression)* ;

// Lista de expressões para print
expressionList : expression (',' expression)* ;

// Literais
literal : INT | FLOAT | STRING | BOOL ;

// Tokens básicos
ID : [a-zA-Z_][a-zA-Z0-9_]* ; // Identificadores
INT : [0-9]+ ;                // Inteiros
FLOAT : [0-9]+ '.' [0-9]+ ;   // Floats
STRING : '"' (~["])* '"' ;    // Strings entre aspas duplas
BOOL : 'True' | 'False' ;     // Booleanos

// Controle de indentação
INDENT : '\t' ;               // Identação (simplesmente um caractere de tabulação)
DEDENT : '\b' ;               // Dedent (para simplificação, usamos um caractere arbitrário)
NEWLINE : '\r'? '\n' ;        // Nova linha

// Ignora espaços em branco (exceto para indentação)
WS : [ \r\n\t]+ -> skip ;

