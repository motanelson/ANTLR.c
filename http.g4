grammar HttpRequest;

// ==========================
// Regras principais
// ==========================
httpRequest
    : requestLine headers body? EOF // Uma requisição HTTP contém uma linha de requisição, cabeçalhos e corpo opcional
    ;

requestLine
    : HTTP_METHOD PATH HTTP_VERSION NEWLINE // Método, caminho, versão HTTP e nova linha
    ;

headers
    : (header NEWLINE)*                    // Zero ou mais cabeçalhos
    ;

header
    : HEADER_NAME ':' HEADER_VALUE         // Nome do cabeçalho seguido de valor
    ;

body
    : (.*)*                               // Corpo da requisição (texto livre)
    ;

// ==========================
// Tokens Léxicos
// ==========================
HTTP_METHOD
    : 'GET' | 'POST' | 'PUT' | 'DELETE' | 'PATCH' | 'OPTIONS' | 'HEAD'
    ;

PATH
    : '/' (~[ \r\n])*                     // Caminho da URL, começa com '/' e exclui espaços e quebras de linha
    ;

HTTP_VERSION
    : 'HTTP/' [0-9]+ '.' [0-9]+           // Versão HTTP, como HTTP/1.1 ou HTTP/2.0
    ;

HEADER_NAME
    : [a-zA-Z0-9-]+                       // Nome do cabeçalho, composto por letras, números e '-'
    ;

HEADER_VALUE
    : (~[\r\n])*                          // Valor do cabeçalho, qualquer coisa exceto quebras de linha
    ;

NEWLINE
    : '\r'? '\n'                          // Suporta quebras de linha Unix ou Windows
    ;

WHITESPACE
    : [ \t]+ -> skip                      // Ignora espaços e tabulações fora de contextos sensíveis
    ;