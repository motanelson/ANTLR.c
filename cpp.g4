grammar CPP;

// ==========================
// Regras de entrada principais
// ==========================
compilationUnit
    : (declaration | functionDefinition | classDefinition)* EOF
    ;

// ==========================
// Declarações
// ==========================
declaration
    : typeSpecifier declarator ';'
    ;

typeSpecifier
    : 'int' | 'float' | 'char' | 'void' | 'double' | 'bool' | Identifier
    ;

declarator
    : Identifier
    ;

// ==========================
// Definição de Funções
// ==========================
functionDefinition
    : typeSpecifier Identifier '(' parameterList? ')' compoundStatement
    ;

parameterList
    : parameter (',' parameter)*
    ;

parameter
    : typeSpecifier declarator
    ;

// ==========================
// Definição de Classes
// ==========================
classDefinition
    : 'class' Identifier '{' classMember* '}'
    ;

classMember
    : declaration
    | functionDefinition
    ;

// ==========================
// Estruturas de Controle
// ==========================
compoundStatement
    : '{' statement* '}'
    ;

statement
    : expressionStatement
    | compoundStatement
    | selectionStatement
    | iterationStatement
    | jumpStatement
    ;

expressionStatement
    : expression? ';'
    ;

selectionStatement
    : 'if' '(' expression ')' statement ('else' statement)?
    ;

iterationStatement
    : 'while' '(' expression ')' statement
    | 'for' '(' expression? ';' expression? ';' expression? ')' statement
    ;

jumpStatement
    : 'return' expression? ';'
    ;

// ==========================
// Expressões
// ==========================
expression
    : assignmentExpression
    ;

assignmentExpression
    : logicalOrExpression ('=' assignmentExpression)?
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
    : Identifier
    | Constant
    | '(' expression ')'
    ;

// ==========================
// Tokens Léxicos
// ==========================
Identifier
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

Constant
    : IntegerConstant
    | FloatingConstant
    | CharacterConstant
    ;

IntegerConstant
    : [0-9]+
    ;

FloatingConstant
    : [0-9]+ '.' [0-9]* (('e' | 'E') ('+' | '-')? [0-9]+)?
    ;

CharacterConstant
    : '\'' . '\''
    ;

Whitespace
    : [ \t\r\n]+ -> skip
    ;

Comment
    : '//' ~[\r\n]* -> skip
    | '/*' .*? '*/' -> skip
    ;