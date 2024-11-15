grammar RubySimplified;

// ==========================
// Regras principais
// ==========================
program
    : statement* EOF              // Um programa é uma sequência de declarações
    ;

statement
    : expressionStatement         // Declarações baseadas em expressões
    | methodDefinition            // Definições de métodos
    | classDefinition             // Definições de classes
    ;

expressionStatement
    : expression NEWLINE          // Expressão seguida de nova linha
    ;

methodDefinition
    : 'def' IDENTIFIER '('? parameterList? ')?' NEWLINE statement* 'end' NEWLINE
    ;

classDefinition
    : 'class' IDENTIFIER NEWLINE statement* 'end' NEWLINE
    ;

// ==========================
// Expressões
// ==========================
expression
    : literal                     // Literais (números, strings, etc.)
    | variableReference           // Referência a variáveis
    | functionCall                // Chamadas de função
    | binaryExpression            // Operações binárias
    ;

// ==========================
// Literais
// ==========================
literal
    : NUMBER                      // Número literal
    | STRING                      // String literal
    ;

// ==========================
// Variáveis e Funções
// ==========================
variableReference
    : IDENTIFIER                  // Nome de uma variável
    ;

functionCall
    : IDENTIFIER '(' argumentList? ')' // Nome da função seguido de argumentos opcionais
    ;

// ==========================
// Operações e Argumentos
// ==========================
binaryExpression
    : expression BINARY_OPERATOR expression
    ;

parameterList
    : IDENTIFIER (',' IDENTIFIER)*
    ;

argumentList
    : expression (',' expression)*
    ;

// ==========================
// Tokens Léxicos
// ==========================
NUMBER
    : [0-9]+                      // Números inteiros
    ;

STRING
    : '"' (~["\r\n])* '"'         // Strings entre aspas duplas
    ;

IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*      // Nomes de variáveis, métodos e classes
    ;

BINARY_OPERATOR
    : '+' | '-' | '*' | '/' | '==' | '!=' | '<' | '>' // Operadores binários
    ;

NEWLINE
    : '\r'? '\n'                  // Quebra de linha
    ;

WHITESPACE
    : [ \t]+ -> skip              // Ignora espaços e tabulações
    ;