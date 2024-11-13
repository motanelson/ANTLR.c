
grammar SimpleHTMLCSS;

// Ponto de entrada do documento HTML
documento : elemento+ EOF ;

// Definição de um elemento HTML básico
elemento : tagAbertura (elemento | texto | estilo)* tagFechamento
         | elementoVazio
         ;

// Tags de abertura e fechamento
tagAbertura : '<' TAG (atributo)* '>' ;
tagFechamento : '</' TAG '>' ;

// Elemento vazio (auto-fechamento)
elementoVazio : '<' TAG (atributo)* '/>' ;

// Texto dentro de um elemento HTML
texto : TEXT ;

// Atributos de uma tag HTML
atributo : ATTR '=' '"' valor '"' ;
valor : TEXT | NUMERO ;

// Elemento de estilo CSS embutido dentro de uma tag <style>
estilo : '<style>' regraCSS* '</style>' ;

// Regras CSS
regraCSS : seletor '{' declaracaoCSS* '}' ;

// Seletor de CSS (identifica o elemento ao qual o estilo se aplica)
seletor : TAG | '.' ID | '#' ID ;

// Declarações de CSS
declaracaoCSS : propriedade ':' valorCSS ';' ;

// Propriedades CSS (simplificadas)
propriedade : 'color'
            | 'background-color'
            | 'font-size'
            | 'margin'
            | 'padding'
            | 'width'
            | 'height' ;

// Valores CSS simplificados
valorCSS : TEXT | NUMERO | '#' HEX | 'px' | '%' ;

// Tokens básicos
TAG : [a-zA-Z][a-zA-Z0-9]* ;
ATTR : [a-zA-Z_:][a-zA-Z0-9_-]* ;
ID : [a-zA-Z_][a-zA-Z0-9_-]* ;
TEXT : ~[<>"'=]+ ;
NUMERO : [0-9]+ ;
HEX : [a-fA-F0-9]+ ;
WS : [ \t\r\n]+ -> skip ;
