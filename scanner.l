%{
#include "parser.tab.hh" // Archivo Bison
#include <string> // Para usar strings
#include <cstdlib> // Para atoi

using namespace std;

// Declaración de yylval (YYSTYPE se genera automáticamente por Bison)
extern YYSTYPE yylval;
%}


DIGIT       [0-9]+
CHAIN       [a-zA-Z_][a-zA-Z0-9_]*
INTEGER     "integer"
FLOATING    "floating"
IF          "if"
OTHERWISE   "otherwise"
WHILE       "while"
FOR         "for"
FUNCTION    "function"
RETURN      "return"

%% // Sección principal

{IF}         { return IF; }
{OTHERWISE}  { return OTHERWISE; }
{FUNCTION}   { return FUNCTION; }
{RETURN}     { return RETURN; }
{WHILE}      { return WHILE; }

{DIGIT} {
    yylval.num = atoi(yytext); // Convierte la cadena en número entero
    return NUMBER;
}

{CHAIN} {
    yylval.str = new std::string(yytext); // Asigna un nuevo std::string
    return CHAIN;
}

[ \t\n]+     {}
"//".*       {}
"/*"[^*]*"*"+([^/*][^*]*"*"+)*"/" {}

"\("         { return '('; }
"\)"         { return ')'; }
"\{"         { return '{'; }
"\}"         { return '}'; }
";"          { return ';'; }
"="          { return '='; }
"+"          { return '+'; }
"-"          { return '-'; }
"*"          { return '*'; }
"/"          { return '/'; }
.            { return yytext[0]; }

%%
int yywrap() { return 1; }
