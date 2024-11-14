
grammar Math;

// Ponto de entrada da gramática
expr:   expr ('+' | '-') expr     # AddSubExpr
    |   expr ('*' | '/') expr     # MulDivExpr
    |   '(' expr ')'              # ParenExpr
    |   NUMBER                    # NumberExpr
    ;

// Tokens
NUMBER: [0-9]+('.'[0-9]+)?;  // Inteiros e floats
WS: [ \t\r\n]+ -> skip;      // Ignora espaços em branco
