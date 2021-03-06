%{
	#include "global.h"
	#include "parser.h"
	char lexbuf[BSIZE];
	int lineno = 1;
%}

delim 		[\t ]
nl 		[\n]
ws 		{delim}+
letter 		[A-Za-z]
digit 		[0-9]
id 		{letter}({letter}|{digit})*
number		{digit}+

%option noyywrap

%%
{ws}		{}
{nl}		{lineno++;}	
{number}	{return install_num();}
{id}		{return install_id();}
<<EOF>> 	{return DONE;}	
.		{return install_anyother(); }
%% 


int install_num() {
	sscanf(yytext, "%d", &yylval);
	return NUM;
}

int install_id() {
	int p = lookup(yytext);
	if(p == 0)
		p = insert(yytext, ID);
	yylval = p;
	return symtable[p].token;
}

int install_anyother() {
	yylval = NONE;
	return yytext[0];
}

int lexan() {
	return yylex();
}
