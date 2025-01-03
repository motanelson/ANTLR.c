
grammar SimpleAWK;

// Ponto de entrada para o programa AWK
program : (patternAction | statement)* EOF ;

// Bloco de padrão-ação
patternAction : (pattern)? '{' statement* '}' ;

// Padrões (simples para BEGIN e END)
pattern : 'BEGIN' | 'END' | expression ;

// Declarações
statement : assignment
          | funcCall
          | printStatement
          | ifStatement
          | whileLoop
          | forLoop
          ;

// Atribuição de valor (exemplo: "x = 10")
assignment : ID '=' expression ;

// Chamada de função (exemplo: "print", "length(s)")
funcCall : ID '(' (expression (',' expression)*)? ')' ;

// Instrução print (exemplo: "print $1, $2")
printStatement : 'print' (expression (',' expression)*)? ;

// Declaração condicional If (exemplo: "if (x > 10) { ... }")
ifStatement : 'if' '(' expression ')' '{' statement* '}' ('else' '{' statement* '}')? ;

// Laço While (exemplo: "while (i < 10) { ... }")
whileLoop : 'while' '(' expression ')' '{' statement* '}' ;

// Laço For (exemplo: "for (i = 1; i <= 10; i++) { ... }")
forLoop : 'for' '(' assignment ';' expression ';' assignment ')' '{' statement* '}' ;

// Expressões
expression : primary
           | expression op=('*' | '/' | '+' | '-') expression
           | expression op=('==' | '!=' | '<' | '>' | '<=' | '>=') expression
           ;

// Expressões primárias
primary : literal
        | variable
        | funcCall
        | '(' expression ')'
        ;

// Variáveis ($ para campos e identificadores comuns)
variable : '$' INT        // Campo, como $1, $2, ...
         | ID             // Variável de usuário
         ;

// Literais
literal : INT | FLOAT | STRING | BOOL ;

// Tokens básicos
ID : [a-zA-Z_][a-zA-Z0-9_]* ; // Identificadores
INT : [0-9]+ ;                // Inteiros
FLOAT : [0-9]+ '.' [0-9]+ ;   // Flutuantes
STRING : '"' (~["])* '"' ;    // Strings
BOOL : 'true' | 'false' ;     // Booleanos
WS : [ \t\r\n]+ -> skip ;     // Espaços em branco (ignorar)
