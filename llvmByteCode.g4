grammar SimpleLLVMIR;

// Ponto de entrada para o código LLVM IR
programa : (cabecalho | declaracaoGlobal | declaracaoFuncao)* EOF ;

// Declaração de cabeçalho (opcional)
cabecalho : 'source_filename' '=' STRING ;

// Declaração global (variável global)
declaracaoGlobal : '@' ID '=' 'global' tipo valorInicial ;

// Declaração de função
declaracaoFuncao : 'define' tipo '@' ID '(' parametroLista? ')' '{' instrucao* '}' ;

// Lista de parâmetros de função
parametroLista : parametro (',' parametro)* ;
parametro : tipo ID ;

// Instruções
instrucao : atribuicao
          | operadorBinario
          | chamadaFuncao
          | controleFluxo
          | retorno
          ;

// Atribuição
atribuicao : ID '=' instrucaoAtribuicao ;

instrucaoAtribuicao : 'alloca' tipo
                    | 'load' tipo ',' tipo '*' ID
                    | 'store' tipo valor ',' tipo '*' ID
                    ;

// Operações aritméticas e lógicas
operadorBinario : ID '=' binOp tipo valor ',' valor ;

binOp : 'add' | 'sub' | 'mul' | 'udiv' | 'sdiv' | 'and' | 'or' | 'xor' ;

// Chamada de função
chamadaFuncao : 'call' tipo '@' ID '(' argumentoLista? ')' ;

// Lista de argumentos
argumentoLista : valor (',' valor)* ;

// Controle de fluxo (exemplo: br e condicional)
controleFluxo : 'br' ('label' ID | 'i1' valor ', label' ID ', label' ID)
              | 'label' ID ':' ;

// Retorno da função
retorno : 'ret' tipo valor? ;

// Tipos básicos
tipo : 'i32' | 'i64' | 'float' | 'double' | 'void' ;

// Valores
valorInicial : valor | 'zeroinitializer' ;
valor : ID | NUMERO ;

// Tokens básicos
ID : [a-zA-Z_][a-zA-Z0-9_]* ;
NUMERO : [0-9]+ ;
STRING : '"' (~["])* '"' ;
WS : [ \t\r\n]+ -> skip ;

