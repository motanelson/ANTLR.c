grammar SSLSimplified;

// ==========================
// Regras principais
// ==========================
sslMessage
    : clientHello
    | serverHello
    | certificateMessage
    | keyExchange
    | finishedMessage
    | encryptedMessage
    ;

clientHello
    : 'CLIENT_HELLO' VERSION CIPHERSUITE_LIST RANDOM NEWLINE
    ;

serverHello
    : 'SERVER_HELLO' VERSION CIPHERSUITE RANDOM NEWLINE
    ;

certificateMessage
    : 'CERTIFICATE' PEM_BLOCK NEWLINE
    ;

keyExchange
    : 'KEY_EXCHANGE' ENCRYPTED_KEY NEWLINE
    ;

finishedMessage
    : 'FINISHED' HASH NEWLINE
    ;

encryptedMessage
    : 'ENCRYPTED_MESSAGE' PAYLOAD NEWLINE
    ;

// ==========================
// Tokens Léxicos
// ==========================
VERSION
    : [0-9]+ '.' [0-9]+       // Versão SSL/TLS, como 1.2 ou 1.3
    ;

CIPHERSUITE
    : [a-zA-Z0-9_-]+          // Nome do conjunto de cifras, como AES256-GCM-SHA384
    ;

CIPHERSUITE_LIST
    : CIPHERSUITE (',' CIPHERSUITE)*  // Lista de cifras separadas por vírgulas
    ;

RANDOM
    : [a-fA-F0-9]{64}         // Valor aleatório hexadecimal (32 bytes)
    ;

PEM_BLOCK
    : '-----BEGIN CERTIFICATE-----' .*? '-----END CERTIFICATE-----' // Bloco PEM simplificado
    ;

ENCRYPTED_KEY
    : [a-zA-Z0-9+/=]+         // Chave criptografada em base64
    ;

HASH
    : [a-fA-F0-9]{64}         // Resumo criptográfico hexadecimal (32 bytes)
    ;

PAYLOAD
    : .*                      // Mensagem cifrada (texto livre ou codificado)
    ;

NEWLINE
    : '\r'? '\n'
    ;

WHITESPACE
    : [ \t]+ -> skip          // Ignora espaços e tabulações fora do conteúdo relevante
    ;