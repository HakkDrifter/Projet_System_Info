%{
    #include "y.tab.h"
%}
 
int e?[0-9]+
sep [ \t\n]
id [A-Za-z][A-Za-z0-9_]*

%%

"main()" {return tMAIN;}
"{" {return tAO;}
"}" {return tAF;}
"const" {return tCONST;}
"int" {return tINT;}
{int} { yylval.nb = atof(yytext);
        return tVALINT;}
"+" {return tADD;}
"-" {return tSUB;}
"*" {return tMUL;}
"/" {return tDIV;}
"=" {return tEQ;}
"(" {return tPO;}
")" {return tPF;}
";" {return tPV;}
"," {return tVR;}
"printf" {return tPRINTF;}
{sep} 
{id} { yylval.str = strdup(yytext);
       return tID;}
. {printf("Erreur\n");}

%%

int yywrap(void)
{
    return 1;
} 
