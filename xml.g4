grammar XML;

// Ponto de entrada do documento XML
document : prolog? element EOF ;

// Prolog opcional (cabeçalho XML)
prolog : XMLDecl? misc* ;

// Declaração XML
XMLDecl : '<?xml' attribute* '?>' ;

// Espaços e declarações de instruções de processamento (PI) e comentários fora do elemento principal
misc : COMMENT | PI ;

// Elemento XML com tags de abertura e fechamento, ou uma tag vazia
element
    : OPEN tagName attribute* CLOSE content? END_OPEN tagName CLOSE   // Ex: <tag> ... </tag>
    | OPEN tagName attribute* SLASH_CLOSE                            // Ex: <tag/>
    ;

// Conteúdo de um elemento, que pode incluir texto, outros elementos ou CDATA
content : (element | Chardata | CDATA | COMMENT | PI)* ;

// Definição de atributos no elemento
attribute : Name EQ STRING ;

// Tokens para elementos básicos de XML
OPEN : '<' ;
CLOSE : '>' ;
SLASH_CLOSE : '/>' ;
END_OPEN : '</' ;
EQ : '=' ;
XMLDeclOpen : '<?xml' ;
CDATA : '<![CDATA[' .*? ']]>' ;
PI : '<?' Name (S Attribute)* S? '?>' ;

// Dados de caracteres e strings
Chardata : TEXT | WS ;
COMMENT : '<!--' .*? '-->' ;

// Tokens auxiliares
Name : [a-zA-Z_:][a-zA-Z0-9:._-]* ;
STRING : '"' .*? '"' | '\'' .*? '\'' ;
TEXT : ~[<&]+ ;
WS : [ \t\r\n]+ -> skip ;

