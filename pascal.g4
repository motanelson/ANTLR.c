grammar FreePascal;

// ==========================
// Regras de entrada principais
// ==========================
program
    : 'program' Identifier ';' block '.' EOF
    ;

block
    : variableDeclarationPart procedureAndFunctionDeclarationPart statementPart
    ;

// ==========================
// Declarações de Variáveis
// ==========================
variableDeclarationPart
    : 'var' variableDeclaration+ 
    ;

variableDeclaration
    : Identifier (',' Identifier)* ':' typeSpecifier ';'
    ;

typeSpecifier
    : 'integer' | 'real' | 'string' | 'boolean'
    ;

// ==========================
// Declarações de Procedimentos e Funções
// ==========================
procedureAndFunctionDeclarationPart
    : (procedureDeclaration | functionDeclaration)*
    ;

procedureDeclaration
    : 'procedure' Identifier formalParameterList? ';' block ';'
    ;

functionDeclaration
    : 'function' Identifier formalParameterList? ':' typeSpecifier ';' block ';'
    ;

formalParameterList
    : '(' formalParameter ( ';' formalParameter )* ')'
    ;

formalParameter
    : Identifier (',' Identifier)* ':' typeSpecifier
    ;

// ==========================
// Parte de Instruções
// ==========================
statementPart
    : 'begin' statementSequence 'end'
    ;

statementSequence
    : statement (';' statement)*
    ;

statement
    : assignmentStatement
    | procedureCallStatement
    | ifStatement
    | whileStatement
    | forStatement
    | writeStatement
    ;

assignmentStatement
    : Identifier ':=' expression
    ;

procedureCallStatement
    : Identifier '(' expressionList? ')'
    ;

ifStatement
    : 'if' expression 'then' statement ('else' statement)?
    ;

whileStatement
    : 'while' expression 'do' statement
    ;

forStatement
    : 'for' Identifier ':=' expression ('to' | 'downto') expression 'do' statement
    ;

writeStatement
    : 'write' '(' expressionList ')'
    ;

// ==========================
// Expressões
// ==========================
expressionList
    : expression (',' expression)*
    ;

expression
    : simpleExpression (relationalOperator simpleExpression)?
    ;

simpleExpression
    : term (addingOperator term)*
    ;

term
    : factor (multiplyingOperator factor)*
    ;

factor
    : Identifier
    | IntegerConstant
    | RealConstant
    | StringConstant
    | 'true'
    | 'false'
    | '(' expression ')'
    | 'not' factor
    ;

relationalOperator
    : '=' | '<>' | '<' | '<=' | '>' | '>='
    ;

addingOperator
    : '+' | '-' | 'or'
    ;

multiplyingOperator
    : '*' | '/' | 'and' | 'div' | 'mod'
    ;

// ==========================
// Tokens Léxicos
// ==========================
Identifier
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

IntegerConstant
    : [0-9]+
    ;

RealConstant
    : [0-9]+ '.' [0-9]+
    ;

StringConstant
    : '\'' (~['\r\n])* '\''
    ;

Whitespace
    : [ \t\r\n]+ -> skip
    ;

Comment
    : '//' ~[\r\n]* -> skip
    | '{' .*? '}' -> skip
    ;