%{
	#include "global.h"
	#include "parser.h"
	char lexbuf[BSIZE];
	int lineno = 1;
	int tokenval = NONE;
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
	sscanf(yytext, "%d", &tokenval);
	return NUM;
}

int install_id() {
	int p = lookup(yytext);
	if(p == 0)
		p = insert(yytext, ID);
	tokenval = p;
	return symtable[p].token;
}

int install_anyother() {
	tokenval = NONE;
	return yytext[0];
}

int lexan() {
	return yylex();
}