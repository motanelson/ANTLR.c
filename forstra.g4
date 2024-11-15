grammar FortranSimplified;

// ==========================
// Regras principais
// ==========================
program
    : statement* EOF              // Um programa Fortran é uma sequência de declarações
    ;

statement
    : assignmentStatement         // Atribuições
    | ifStatement                 // Condicional
    | doLoop                      // Loop DO
    | subroutineCall              // Chamadas de sub-rotinas
    | declarationStatement        // Declarações de variáveis
    ;

// ==========================
// Declarações e Atribuições
// ==========================
declarationStatement
    : TYPE_SPECIFIER variableList NEWLINE
    ;

assignmentStatement
    : IDENTIFIER '=' expression NEWLINE
    ;

// ==========================
// Controle de Fluxo
// ==========================
ifStatement
    : 'IF' '(' condition ')' 'THEN' NEWLINE statement* 'END IF' NEWLINE
    ;

doLoop
    : 'DO' IDENTIFIER '=' expression ',' expression (',' expression)? NEWLINE statement* 'END DO' NEWLINE
    ;

// ==========================
// Chamadas de Sub-rotinas
// ==========================
subroutineCall
    : 'CALL' IDENTIFIER '(' argumentList? ')' NEWLINE
    ;

// ==========================
// Expressões e Condições
// ==========================
expression
    : literal
    | IDENTIFIER
    | expression BINARY_OPERATOR expression
    | '(' expression ')'
    ;

condition
    : expression RELATIONAL_OPERATOR expression
    ;

// ==========================
// Variáveis e Argumentos
// ==========================
variableList
    : IDENTIFIER (',' IDENTIFIER)*
    ;

argumentList
    : expression (',' expression)*
    ;

// ==========================
// Literais
// ==========================
literal
    : NUMBER                      // Literais numéricos
    | STRING                      // Literais de string
    ;

// ==========================
// Tokens Léxicos
// ==========================
TYPE_SPECIFIER
    : 'INTEGER' | 'REAL' | 'DOUBLE PRECISION' | 'CHARACTER' | 'LOGICAL'
    ;

RELATIONAL_OPERATOR
    : '==' | '/=' | '>' | '>=' | '<' | '<='
    ;

BINARY_OPERATOR
    : '+' | '-' | '*' | '/' | '**'
    ;

IDENTIFIER
    : [a-zA-Z][a-zA-Z0-9_]*       // Identificadores válidos
    ;

NUMBER
    : [0-9]+ ('.' [0-9]+)?        // Números inteiros e reais
    ;

STRING
    : '\'' (~['\r\n])* '\''
    ;

NEWLINE
    : '\r'? '\n'
    ;

WHITESPACE
    : [ \t]+ -> skip              // Ignora espaços e tabulações
    ;