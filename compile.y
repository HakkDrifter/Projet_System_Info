%{
    #include <stdio.h>
    int yylex();
    void yyerror(char * str){printf("%s\n",str);};
%}
%union{
    int nb;
    char * str;
}
%token tMAIN tINT tEQ tPF tPO tAF tPV tVR tAO tADD tSUB tMUL tDIV tPRINTF tCONST
%token <str> tID
%token <nb> tVALINT
%type  <nb> Expression
%left tADD tSUB
%left tMUL tDIV
%right tEQ
%%
%start File;
File:
    Main {printf("File\n");}; 
Main:
    tINT tMAIN tAO Body tAF {printf("Main\n");}; 
Body:
    /* vide */
    | Definition Body
    | Affectation Body 
    | tINT Affectation Body {printf("Body\n");}; 
Definition:
    tINT tID DefinitionN tPV {printf("def\n");}; 
DefinitionN:
    /* vide */
    | tVR tID DefinitionN {printf("DefN\n");}; 
Affectation:
    tID tEQ Expression tPV{ 
                            printf("Affect\n");}; 
Expression:
    tVALINT {$$ = $1;} 
    | tID
    | Expression tADD Expression {$$ = $1 + $3;}
    | Expression tSUB Expression {$$ = $1 - $3;}
    | Expression tMUL Expression {$$ = $1 * $3;}
    | Expression tDIV Expression {$$ = $1 / $3;}
    | tPO Expression tPF {$$ = $2;
                          printf("res = %d",$$);};
%%

int main()
{
    yyparse();
    return 0;
}

