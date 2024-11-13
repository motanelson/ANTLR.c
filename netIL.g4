grammar SimpleIL;

// Ponto de entrada para o código IL
programa : (cabecalho | declaracaoClasse | metodo)* EOF ;

// Cabeçalho do arquivo (opcional)
cabecalho : '.assembly' ID '{' '}' ;

// Declaração de classe
declaracaoClasse : '.class' 'public'? ID '{' (campo | metodo)* '}' ;

// Declaração de campo (variável de classe)
campo : '.field' 'public' tipo ID ';' ;

// Declaração de método
metodo : '.method' ('public' | 'private')? tipo ID '(' parametroLista? ')' '{' instrucao* '}' ;

// Lista de parâmetros do método
parametroLista : parametro (',' parametro)* ;
parametro : tipo ID ;

// Instruções
instrucao : chamadaMetodo
          | atribuicao
          | operadorBinario
          | retorno
          ;

// Chamada de método
chamadaMetodo : 'call' tipo ID '(' argumentoLista? ')' ;

// Atribuição de valor
atribuicao : 'ldloc' NUMERO ';' | 'stloc' NUMERO ';' ;

// Operador binário
operadorBinario : ('add' | 'sub' | 'mul' | 'div') ';' ;

// Declaração de retorno
retorno : 'ret' ';' ;

// Lista de argumentos para chamada de método
argumentoLista : expressao (',' expressao)* ;

// Expressão
expressao : ID | NUMERO | chamadaMetodo ;

// Tipos de dados
tipo : 'int32' | 'float32' | 'bool' | 'string' ;

// Tokens básicos
ID : [a-zA-Z_][a-zA-Z_0-9]* ;
NUMERO : [0-9]+ ;
WS : [ \t\r\n]+ -> skip ;

