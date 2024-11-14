grammar Lua;

// Ponto de entrada do programa, que consiste em múltiplas declarações e expressões
program : stat* EOF;

// Regras para as declarações e expressões básicas em Lua
stat
    : varDecl                        # VariableDeclaration
    | functionDecl                   # FunctionDeclaration
    | ifStat                         # IfStatement
    | whileStat                      # WhileStatement
    | expr ';'                       # ExpressionStatement
    ;

// Declaração de variável (ex: `local x = 10`)
varDecl : 'local' NAME ('=' expr)? ';' ;

// Declaração de função (ex: `function foo() end`)
functionDecl : 'function' NAME '(' paramList? ')' block 'end' ;

// Condicional `if` com suporte a `elseif` e `else`
ifStat : 'if' expr 'then' block ('elseif' expr 'then' block)* ('else' block)? 'end' ;

// Laço `while`
whileStat : 'while' expr 'do' block 'end' ;

// Lista de parâmetros para uma função
paramList : NAME (',' NAME)* ;

// Bloco de código
block : stat* ;

// Expressão (operações aritméticas básicas e parênteses)
expr
    : expr ('+' | '-') expr          # AddSubExpr
    | expr ('*' | '/') expr          # MulDivExpr
    | '(' expr ')'                   # ParenExpr
    | NUMBER                         # NumberExpr
    | NAME                           # VariableExpr
    ;

// Tokens para números, nomes e símbolos
NAME : [a-zA-Z_][a-zA-Z_0-9]*;      // Identificadores (nomes de variáveis, funções, etc.)
NUMBER : [0-9]+('.'[0-9]+)?;        // Números inteiros e floats
WS : [ \t\r\n]+ -> skip;            // Ignora espaços em branco
COMMENT : '--' ~[\r\n]* -> skip;    // Ignora comentários (linha única)

