grammar DirectoryTree;

// ==========================
// Regras principais
// ==========================
tree
    : entry+ EOF            // A árvore é composta por múltiplas entradas
    ;

entry
    : directory             // Cada entrada pode ser um diretório
    | file                  // Ou um arquivo
    ;

directory
    : INDENT? DirectoryName NEWLINE subtree? // Diretório com possível conteúdo aninhado
    ;

subtree
    : INDENT entry+         // Subárvore com entradas indentadas
    ;

file
    : INDENT? FileName NEWLINE  // Arquivo sem conteúdo aninhado
    ;

// ==========================
// Tokens Léxicos
// ==========================
DirectoryName
    : [a-zA-Z0-9_.-]+       // Nome do diretório (letras, números, pontos e traços)
    ;

FileName
    : [a-zA-Z0-9_.-]+       // Nome do arquivo (letras, números, pontos e traços)
    ;

INDENT
    : '\t'                  // Tabulação para indicar nível de aninhamento
    ;

NEWLINE
    : '\r'? '\n'            // Quebra de linha compatível com Windows (\r\n) e Unix (\n)
    ;

// Ignora espaços em branco fora da indentação
WS
    : [ \r\n]+ -> skip
    ;