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

%token <str> CHAIN
%token <num> NUMBER
%token IF OTHERWISE FUNCTION RETURN WHILE

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
    CHAIN '=' NUMBER ';'
    {
        cout << "Asignación: " << *$1 << " = " << $3 << endl;
        delete $1; // Libera la memoria asignada al identificador
    }
    | IF '(' condition ')' '{' block '}' OTHERWISE '{' block '}'
    {
        cout << "Condicional ejecutada con 'otherwise'." << endl;
    }
    | FUNCTION CHAIN '(' ')' '{' block '}'
    {
        cout << "Definición de función: " << *$2 << endl;
        delete $2;
    }
    | RETURN NUMBER ';'
    {
        cout << "Retorno: " << $2 << endl;
    }
    ;

condition:
    CHAIN
    {
        cout << "Evaluando condición: " << *$1 << endl;
        delete $1;
    }
    ;

block:
    statement_list
    ;

%%
int main() {
    return yyparse();
}
