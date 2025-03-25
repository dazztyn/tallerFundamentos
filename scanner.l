%{
#include "parser.tab.hh" // Archivo generado por Bison
#include <string>
#include <cstdlib> // Para atoi

using namespace std;

// Declaración de yylval (YYSTYPE se genera automáticamente por Bison)
extern YYSTYPE yylval;
%}

DIGIT [0-9]+
ID [a-zA-Z_][a-zA-Z0-9_]*
%%
{DIGIT} {
    yylval.num = atoi(yytext); // Convierte la cadena en número entero
    return NUMBER;
}
{ID} {
    yylval.str = new std::string(yytext); // Asigna un nuevo std::string
    return IDENTIFIER;
}
[ \t\n]+ { /* Ignorar espacios en blanco */ }
.        { return yytext[0]; }
%%
int yywrap() { return 1; }
