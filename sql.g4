grammar SQLSimplified;

// ==========================
// Regras principais
// ==========================
sqlStatement
    : selectStatement
    | insertStatement
    | updateStatement
    | deleteStatement
    ;

// ==========================
// SELECT Statement
// ==========================
selectStatement
    : 'SELECT' columnList 'FROM' tableName whereClause? EOF
    ;

// ==========================
// INSERT Statement
// ==========================
insertStatement
    : 'INSERT' 'INTO' tableName '(' columnList ')' 'VALUES' '(' valueList ')' EOF
    ;

// ==========================
// UPDATE Statement
// ==========================
updateStatement
    : 'UPDATE' tableName 'SET' assignmentList whereClause? EOF
    ;

// ==========================
// DELETE Statement
// ==========================
deleteStatement
    : 'DELETE' 'FROM' tableName whereClause? EOF
    ;

// ==========================
// Componentes Comuns
// ==========================
columnList
    : IDENTIFIER (',' IDENTIFIER)*
    ;

valueList
    : literal (',' literal)*
    ;

assignmentList
    : IDENTIFIER '=' literal (',' IDENTIFIER '=' literal)*
    ;

whereClause
    : 'WHERE' condition
    ;

condition
    : expression (COMPARISON_OPERATOR expression)?
    ;

// ==========================
// Expressões
// ==========================
expression
    : IDENTIFIER
    | literal
    ;

// ==========================
// Literais
// ==========================
literal
    : STRING
    | NUMBER
    ;

// ==========================
// Tokens Léxicos
// ==========================
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*      // Nomes de tabelas e colunas
    ;

STRING
    : '\'' (~['\r\n'] | '\\\'')* '\'' // Strings entre aspas simples
    ;

NUMBER
    : [0-9]+ ('.' [0-9]+)?        // Números inteiros e decimais
    ;

COMPARISON_OPERATOR
    : '=' | '<>' | '<' | '>' | '<=' | '>='
    ;

WHITESPACE
    : [ \t\r\n]+ -> skip          // Ignora espaços, tabulações e quebras de linha
    ;