
grammar make;

// Ponto de entrada do Makefile, composto por múltiplos alvos e comandos
makefile : (rule | variableAssignment)* EOF ;

// Regras do Makefile
rule : targetLine command* ;

// Definição de um alvo com dependências
targetLine : target ':' dependencies? NEWLINE ;

// Definição de variáveis (ex: `CC=gcc`)
variableAssignment : NAME '=' VALUE NEWLINE ;

// Lista de dependências, separadas por espaço
dependencies : dependency (SPACES dependency)* ;

// Cada comando começa com uma tabulação
command : TAB COMMAND NEWLINE ;

// Tokens para os elementos básicos
target : NAME ;
dependency : NAME ;

// Tokens para variáveis, nomes, valores e comandos
NAME : [a-zA-Z_][a-zA-Z0-9_\\-]* ;
VALUE : ~[\r\n]+ ;       // Valor de uma variável até o fim da linha
COMMAND : ~[\r\n]+ ;     // Comando até o fim da linha

// Tokens auxiliares
TAB : '\t' ;
NEWLINE : '\r'? '\n' ;
SPACES : [ \t]+ -> skip ;
COMMENT : '#' ~[\r\n]* -> skip ;  // Ignora comentários de linha única
WS : [ \t\r\n]+ -> skip ;         // Ignora espaços em branco
