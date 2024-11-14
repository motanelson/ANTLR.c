grammar ExcelXML;

// ==========================
// Regras principais
// ==========================
document
    : element* EOF
    ;

element
    : openTag content? closeTag
    ;

content
    : (element | text)*
    ;

// ==========================
// Tags principais do Excel XML
// ==========================
openTag
    : '<' tagName (attribute)* '>'
    ;

closeTag
    : '</' tagName '>'
    ;

// ==========================
// Tags, Atributos e Texto
// ==========================
tagName
    : 'workbook' | 'sheet' | 'row' | 'cell' | 'data' // Principais tags de Excel XML simplificado
    ;

attribute
    : AttributeName '=' '"' AttributeValue '"'
    ;

// ==========================
// Tokens Léxicos
// ==========================
text
    : TEXT
    ;

AttributeName
    : [a-zA-Z_:][a-zA-Z0-9_:]*
    ;

AttributeValue
    : ~["<>\r\n]+
    ;

TEXT
    : ~[<>]+
    ;

// Ignora espaços e quebras de linha fora de tags
WS
    : [ \t\r\n]+ -> skip
    ;