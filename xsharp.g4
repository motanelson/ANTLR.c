grammar XSharpSimplified;

// ==========================
// Regras Principais
// ==========================
program
    : declaration* EOF
    ;

declaration
    : functionDeclaration
    | variableDeclaration
    ;

functionDeclaration
    : 'void' IDENTIFIER '(' parameterList? ')' block
    ;

parameterList
    : parameter (',' parameter)*
    ;

parameter
    : type IDENTIFIER
    ;

variableDeclaration
    : type IDENTIFIER ('=' expression)? ';'
    ;

// ==========================
// Blocos de Código
// ==========================
block
    : '{' statement* '}'
    ;

statement
    : variableDeclaration
    | expressionStatement
    | returnStatement
    | ifStatement
    | whileStatement
    ;

expressionStatement
    : expression ';'
    ;

returnStatement
    : 'return' expression? ';'
    ;

ifStatement
    : 'if' '(' expression ')' block ('else' block)?
    ;

whileStatement
    : 'while' '(' expression ')' block
    ;

// ==========================
// Expressões
// ==========================
expression
    : assignmentExpression
    ;

assignmentExpression
    : IDENTIFIER '=' expression
    | logicalOrExpression
    ;

logicalOrExpression
    : logicalAndExpression ('||' logicalAndExpression)*
    ;

logicalAndExpression
    : equalityExpression ('&&' equalityExpression)*
    ;

equalityExpression
    : relationalExpression (('==' | '!=') relationalExpression)*
    ;

relationalExpression
    : additiveExpression (('<' | '>' | '<=' | '>=') additiveExpression)*
    ;

additiveExpression
    : multiplicativeExpression (('+' | '-') multiplicativeExpression)*
    ;

multiplicativeExpression
    : unaryExpression (('*' | '/') unaryExpression)*
    ;

unaryExpression
    : ('+' | '-' | '!')? primaryExpression
    ;

primaryExpression
    : IDENTIFIER
    | literal
    | '(' expression ')'
    ;

// ==========================
// Literais e Tipos
// ==========================
literal
    : NUMBER
    | STRING
    | BOOL
    ;

type
    : 'int'
    | 'byte'
    | 'bool'
    | 'void'
    | 'char'
    ;

// ==========================
// Tokens Léxicos
// ==========================
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*
    ;

NUMBER
    : [0-9]+
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