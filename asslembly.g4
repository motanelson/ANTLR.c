grammar NASM;

// ==========================
// Regras de entrada principais
// ==========================
program
    : line*
    ;

line
    : (labelDefinition | instruction | directive) NEWLINE
    ;

// ==========================
// Definição de Rótulo
// ==========================
labelDefinition
    : Identifier ':'
    ;

// ==========================
// Instruções Assembly
// ==========================
instruction
    : mnemonic operand (',' operand)? 
    ;

mnemonic
    : 'mov' | 'add' | 'sub' | 'mul' | 'div' 
    | 'jmp' | 'je' | 'jne' | 'jg' | 'jl'
    | 'cmp' | 'inc' | 'dec' | 'push' | 'pop'
    ;

// ==========================
// Diretivas
// ==========================
directive
    : 'section' STRING
    | 'global' Identifier
    | 'extern' Identifier
    ;

// ==========================
// Operandos
// ==========================
operand
    : register
    | immediate
    | memory
    | Identifier
    ;

register
    : 'eax' | 'ebx' | 'ecx' | 'edx' | 'esp' | 'ebp' | 'esi' | 'edi'
    ;

immediate
    : ('$'? Integer) | ('$'? Hexadecimal)
    ;

memory
    : '[' register ('+' Integer)? ']'
    ;

// ==========================
// Tokens Léxicos
// ==========================
Identifier
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

Integer
    : [0-9]+
    ;

Hexadecimal
    : '0x' [0-9a-fA-F]+
    ;

STRING
    : '"' (~["\r\n])* '"'
    ;

COMMENT
    : ';' ~[\r\n]* -> skip
    ;

Whitespace
    : [ \t]+ -> skip
    ;

NEWLINE
    : '\r'? '\n'
    ;