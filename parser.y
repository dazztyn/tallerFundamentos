%{
#include <iostream>
#include <string>

using namespace std;

// Declaración de la función de análisis léxico
extern int yylex();
void yyerror(const char *s) {
    cerr << "Error: " << s << endl;
}
%}

%union {
    std::string *str; // Para identificadores
    int num;          // Para números
}

%token <str> IDENTIFIER
%token <num> NUMBER

%code requires {
    #include <string>
}

%%
program:
    statement_list
    {
        cout << "Compilación completada con éxito." << endl;
    }
    ;

statement_list:
    statement
    | statement_list statement
    ;

statement:
    IDENTIFIER '=' NUMBER ';'
    {
        cout << "Asignación: " << *$1 << " = " << $3 << endl;
        delete $1; // Libera la memoria asignada al identificador
    }
    ;
%%
int main() {
    return yyparse();
}
