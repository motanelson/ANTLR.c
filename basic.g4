grammar FreeBASIC;

// ==========================
// Regras de entrada principais
// ==========================
program
    : statement* EOF
    ;

// ==========================
// Declarações
// ==========================
statement
    : variableDeclaration
    | assignment
    | functionDefinition
    | subroutineDefinition
    | ifStatement
    | forLoop
    | whileLoop
    | printStatement
    ;

// ==========================
// Declaração de Variáveis
// ==========================
variableDeclaration
    : 'DIM' Identifier (AS typeSpecifier)? ('=' expression)? NEWLINE
    ;

typeSpecifier
    : 'INTEGER' | 'SINGLE' | 'DOUBLE' | 'STRING'
    ;

// ==========================
// Atribuição
// ==========================
assignment
    : Identifier '=' expression NEWLINE
    ;

// ==========================
// Definição de Função e Subrotina
// ==========================
functionDefinition
    : 'FUNCTION' Identifier '(' parameterList? ')' AS typeSpecifier NEWLINE
      statement*
      'END FUNCTION' NEWLINE
    ;

subroutineDefinition
    : 'SUB' Identifier '(' parameterList? ')' NEWLINE
      statement*
      'END SUB' NEWLINE
    ;

parameterList
    : parameter (',' parameter)*
    ;

parameter
    : Identifier AS typeSpecifier
    ;

// ==========================
// Estruturas de Controle
// ==========================
ifStatement
    : 'IF' expression 'THEN' NEWLINE statement* ('ELSEIF' expression 'THEN' NEWLINE statement*)* ('ELSE' NEWLINE statement*)? 'END IF' NEWLINE
    ;

forLoop
    : 'FOR' Identifier '=' expression 'TO' expression ( 'STEP' expression )? NEWLINE statement* 'NEXT' Identifier? NEWLINE
    ;

whileLoop
    : 'WHILE' expression NEWLINE statement* 'WEND' NEWLINE
    ;

// ==========================
// Instrução PRINT
// ==========================
printStatement
    : 'PRINT' expression NEWLINE
    ;

// ==========================
// Expressões
// ==========================
expression
    : logicalOrExpression
    ;

logicalOrExpression
    : logicalAndExpression ( 'OR' logicalAndExpression )*
    ;

logicalAndExpression
    : equalityExpression ( 'AND' equalityExpression )*
    ;

equalityExpression
    : relationalExpression (('=' | '<>' | '<' | '>' | '<=' | '>=') relationalExpression)*
    ;

relationalExpression
    : additiveExpression
    ;

additiveExpression
    : multiplicativeExpression (('+' | '-') multiplicativeExpression)*
    ;

multiplicativeExpression
    : unaryExpression (('*' | '/') unaryExpression)*
    ;

unaryExpression
    : ('+' | '-')? primaryExpression
    ;

primaryExpression
    : Identifier
    | IntegerLiteral
    | FloatingLiteral
    | StringLiteral
    | '(' expression ')'
    ;

// ==========================
// Tokens Léxicos
// ==========================
Identifier
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

IntegerLiteral
    : [0-9]+
    ;

FloatingLiteral
    : [0-9]+ '.' [0-9]*
    ;

StringLiteral
    : '"' (~["\r\n])* '"'
    ;

NEWLINE
    : '\r'? '\n'
    ;

Whitespace
    : [ \t]+ -> skip
    ;

Comment
    : '\'' ~[\r\n]* -> skip
    ;