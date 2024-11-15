grammar FSharpSimplified;

// ==========================
// Regras principais
// ==========================
program
    : statement* EOF
    ;

statement
    : functionDefinition
    | valueDefinition
    | expression
    ;

// ==========================
// Definição de Função
// ==========================
functionDefinition
    : 'let' 'rec'? IDENTIFIER parameterList '=' expression
    ;

parameterList
    : IDENTIFIER*
    ;

// ==========================
// Definição de Valor
// ==========================
valueDefinition
    : 'let' IDENTIFIER '=' expression
    ;

// ==========================
// Expressões
// ==========================
expression
    : ifExpression
    | mathExpression
    | functionCall
    | IDENTIFIER
    | literal
    ;

// ==========================
// Expressão Condicional
// ==========================
ifExpression
    : 'if' expression 'then' expression ('else' expression)?
    ;

// ==========================
// Operações Matemáticas
// ==========================
mathExpression
    : expression operator=('*' | '/' | '+' | '-') expression
    ;

// ==========================
// Chamada de Função
// ==========================
functionCall
    : IDENTIFIER argumentList
    ;

argumentList
    : expression+
    ;

// ==========================
// Literais
// ==========================
literal
    : NUMBER
    | STRING
    | BOOL
    ;

// ==========================
// Tokens Léxicos
// ==========================
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*
    ;

NUMBER
    : [0-9]+ ('.' [0-9]+)?
    ;

STRING
    : '"' (~["\r\n])* '"'
    ;

BOOL
    : 'true' | 'false'
    ;

WHITESPACE
    : [ \t\r\n]+ -> skip
    ;

COMMENT
    : '//' ~[\r\n]* -> skip
    ;