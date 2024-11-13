grammar SimpleJavaScript;

// Ponto de entrada do programa
programa : instrucao* EOF ;

// Instruções possíveis
instrucao : declaracaoVariavel
          | declaracaoFuncao
          | expressao ';'
          | bloco
          ;

// Declaração de variável (let, const ou var)
declaracaoVariavel : ('let' | 'const' | 'var') ID ('=' expressao)? ';' ;

// Declaração de função
declaracaoFuncao : 'function' ID '(' parametroLista? ')' bloco ;

// Lista de parâmetros de uma função
parametroLista : ID (',' ID)* ;

// Bloco de código
bloco : '{' instrucao* '}' ;

// Expressão
expressao : atribuicao ;

// Atribuição
atribuicao : ID '=' expressao
           | condicao
           ;

// Condição e operadores lógicos básicos
condicao : comparacao (('&&' | '||') comparacao)* ;

// Comparação
comparacao : soma (('==' | '!=' | '<' | '>' | '<=' | '>=') soma)* ;

// Operações aritméticas
soma : produto (('+' | '-') produto)* ;
produto : operando (('*' | '/') operando)* ;

// Operando
operando : ID
         | numero
         | chamadaFuncao
         | '(' expressao ')'
         ;

// Chamada de função
chamadaFuncao : ID '(' argumentoLista? ')' ;

// Lista de argumentos de função
argumentoLista : expressao (',' expressao)* ;

// Tokens básicos
tipo : 'number' | 'string' | 'boolean' ;

ID : [a-zA-Z_][a-zA-Z_0-9]* ;
numero : [0-9]+ ;
WS : [ \t\r\n]+ -> skip ;

