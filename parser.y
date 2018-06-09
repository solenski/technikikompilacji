%{
#define YYERROR_VERBOSE
#include "global.h"

void parse() {
	yyparse();
}
void yyerror (const char *s) {
	error((char*)s);
}
%}
%token NONE
%token NUM
%token DIV
%token MOD
%token ID
%token DONE 0
%%

list : expr ';' list
     | %empty
     ;
expr : expr '+' term { emit('+', NONE); }
     | expr '-' term { emit('-', NONE); }
     | term
     ;
term : term '*' factor { emit('*', NONE); }
     | term '/' factor { emit('/', NONE); }
     | term DIV factor { emit(DIV, NONE); }
     | term MOD factor { emit(MOD, NONE); }
     | factor
     ;
factor : '(' expr ')'
       | ID { emit(ID, $1); }
       | NUM { emit(NUM, $1); }
       ;
%%
