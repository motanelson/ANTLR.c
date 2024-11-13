
grammar SimpleJavaBytecode;

// Ponto de entrada para o código bytecode
programa : (cabecalho | declaracaoClasse | metodo)* EOF ;

// Cabeçalho do arquivo (opcional)
cabecalho : '.source' STRING '.class' ID '.super' ID ;

// Declaração de classe
declaracaoClasse : '.class' modificador* ID '{' (campo | metodo)* '}' ;

// Modificadores de acesso (public, private, etc.)
modificador : 'public' | 'private' | 'protected' | 'static' | 'final' ;

// Declaração de campo (variável de classe)
campo : '.field' modificador* tipo ID ;

// Declaração de método
metodo : '.method' modificador* tipo ID '(' parametroLista? ')' '{' instrucao* '}' '.end' 'method' ;

// Lista de parâmetros do método
parametroLista : parametro (',' parametro)* ;
parametro : tipo ID ;

// Instruções
instrucao : load
          | store
          | const
          | operadorBinario
          | chamadaMetodo
          | retorno
          | controleFluxo
          ;

// Instruções de carregamento (load)
load : 'iload' NUMERO ';'
     | 'aload' NUMERO ';'
     ;

// Instruções de armazenamento (store)
store : 'istore' NUMERO ';'
      | 'astore' NUMERO ';'
      ;

// Instruções de constantes (const)
const : 'iconst_' NUMERO ';'
      | 'ldc' NUMERO ';'
      ;

// Operações aritméticas
operadorBinario : ('iadd' | 'isub' | 'imul' | 'idiv') ';' ;

// Chamada de método
chamadaMetodo : 'invokevirtual' ID '/' ID '(' parametroLista? ')' tipo ';' ;

// Retorno de método
retorno : 'return' ';' | 'ireturn' ';' | 'areturn' ';' ;

// Controle de fluxo
controleFluxo : 'goto' rotulo ';'
              | 'ifeq' rotulo ';'
              | 'ifne' rotulo ';'
              ;

// Rótulos para controle de fluxo
rotulo : 'L' NUMERO ;

// Tipos de dados primitivos e objetos
tipo : 'int' | 'float' | 'double' | 'long' | 'void' | 'boolean' | ID ;

// Tokens básicos
ID : [a-zA-Z_][a-zA-Z0-9_/]* ;
STRING : '"' (~["])* '"' ;
NUMERO : [0-9]+ ;
WS : [ \t\r\n]+ -> skip ;
