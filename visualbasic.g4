grammar SimpleVisualBasic;

// Ponto de entrada do programa
programa : instrucao* EOF ;

// Instruções possíveis
instrucao : declaracaoVariavel
          | declaracaoFuncao
          | atribuicao
          | blocoIf
          | chamadaProcedimento
          ;

// Declaração de variável
declaracaoVariavel : 'Dim' ID ('As' tipo)? ('=' expressao)? ;

// Declaração de função
declaracaoFuncao : 'Function' ID '(' parametroLista? ')' 'As' tipo bloco 'End' 'Function' ;

// Lista de parâmetros da função
parametroLista : parametro (',' parametro)* ;
parametro : ID 'As' tipo ;

// Bloco de código para instruções compostas
bloco : (instrucao | blocoIf)* ;

// Bloco If
blocoIf : 'If' expressao 'Then' bloco ('Else' bloco)? 'End' 'If' ;

// Atribuição de valor a variáveis
atribuicao : ID '=' expressao ;

// Chamada de procedimento
chamadaProcedimento : ID '(' argumentoLista? ')' ;

// Lista de argumentos de função
argumentoLista : expressao (',' expressao)* ;

// Expressões
expressao : termo (('+' | '-') termo)* ;
termo : fator (('*' | '/') fator)* ;
fator : ID
      | numero
      | chamadaProcedimento
      | '(' expressao ')'
      ;

// Tipos de dados básicos
tipo : 'Integer' | 'String' | 'Boolean' | 'Double' ;

// Tokens básicos
ID : [a-zA-Z_][a-zA-Z_0-9]* ;
numero : [0-9]+ ;
WS : [ \t\r\n]+ -> skip ;

