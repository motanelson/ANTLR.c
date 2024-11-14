grammar ARM;

// Ponto de entrada do programa, composto por várias instruções
program : instruction* EOF;

// Definição das instruções
instruction
    : movInstr             # MovInstruction
    | addInstr             # AddInstruction
    | subInstr             # SubInstruction
    | mulInstr             # MulInstruction
    | cmpInstr             # CompareInstruction
    | bInstr               # BranchInstruction
    ;

// Instruções de movimentação (ex: `MOV R0, R1`)
movInstr : 'MOV' REGISTER ',' operand ;

// Instruções aritméticas
addInstr : 'ADD' REGISTER ',' REGISTER ',' operand ;        // `ADD R0, R1, R2` ou `ADD R0, R1, #5`
subInstr : 'SUB' REGISTER ',' REGISTER ',' operand ;        // `SUB R0, R1, R2` ou `SUB R0, R1, #5`
mulInstr : 'MUL' REGISTER ',' REGISTER ',' REGISTER ;       // `MUL R0, R1, R2`

// Instrução de comparação (ex: `CMP R0, R1`)
cmpInstr : 'CMP' REGISTER ',' operand ;

// Instruções de desvio (branch)
bInstr : 'B' LABEL ;                                        // `B label`

// Operandos: pode ser um registrador ou um valor imediato
operand : REGISTER | immediate ;

// Imediato (valor numérico literal, ex: `#10`)
immediate : '#' INT ;

// Definição de registradores
REGISTER : 'R' [0-9]+ ;     // Registradores R0, R1, R2, ...

// Definição de rótulos para saltos
LABEL : [a-zA-Z_][a-zA-Z_0-9]* ;    // Identificadores para rótulos

// Tokens auxiliares
INT : [0-9]+ ;              // Inteiros
WS : [ \t\r\n]+ -> skip ;   // Ignora espaços em branco
COMMENT : '@' ~[\r\n]* -> skip ; // Ignora comentários linha única (ex: `@ comentário`)

