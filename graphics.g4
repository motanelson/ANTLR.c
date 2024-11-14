grammar graphics;

// Ponto de entrada para o programa, que consiste em múltiplos comandos gráficos
program : command+ EOF;

// Cada comando pode ser uma das funções gráficas suportadas
command
    : 'line' ',' INT ',' INT ',' INT ',' INT            # LineCommand
    | 'rect' ',' INT ',' INT ',' INT ',' INT            # RectCommand
    | 'fillrect' ',' INT ',' INT ',' INT ',' INT        # FillRectCommand
    | 'circle' ',' INT ',' INT ',' INT                  # CircleCommand
    | 'fillcircle' ',' INT ',' INT ',' INT              # FillCircleCommand
    | 'color' ',' INT                                   # ColorCommand
    ;

// Tokens
INT : [0-9]+;                 // Inteiro positivo
WS  : [ \t\r\n]+ -> skip;      // Ignora espaços em branco

