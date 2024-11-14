grammar ANTLR;

// Ponto de entrada para a gramática ANTLR
grammarFile : grammarSpec EOF ;

// Definição da gramática
grammarSpec : grammarDecl ruleSpec* lexerRuleSpec* ;

// Declaração da gramática (ex.: `grammar Nome;`)
grammarDecl : 'grammar' ID ';' ;

// Regras de parser
ruleSpec : parserRuleSpec | lexerRuleSpec ;

// Regras de parser
parserRuleSpec : ID ':' alternative ( '|' alternative )* ';' ;

// Regras de lexer
lexerRuleSpec : TOKEN_ID ':' lexerAlternative ( '|' lexerAlternative )* ';' ;

// Alternativas de uma regra de parser
alternative : element+ ;

// Alternativas de uma regra de lexer
lexerAlternative : lexerElement+ ;

// Elementos em alternativas de parser
element : ID | STRING | '(' alternative ')' | element '*' | element '+' | element '?' ;

// Elementos em alternativas de lexer
lexerElement : TOKEN_ID | STRING | '.' | lexerElement '*' | lexerElement '+' | lexerElement '?' ;

// Tokens para identificadores e strings
TOKEN_ID : [A-Z][A-Z0-9_]* ;
ID : [a-zA-Z_][a-zA-Z0-9_]* ;
STRING : '\'' (~['\\] | '\\' .)* '\'' ;

// Operadores e símbolos auxiliares
COMMENT : '/*' .*? '*/' -> skip ;
LINE_COMMENT : '//' ~[\r\n]* -> skip ;
WS : [ \t\r\n]+ -> skip ;

