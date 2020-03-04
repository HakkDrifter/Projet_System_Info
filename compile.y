%{
    #include <stdio.h>
    int yylex();
    void yyerror(char * str){printf("%s\n",str);};
%}

%token tMAIN tINT tEQ tID tPF tPO tAF tPV tVR tAO tVALINT tADD tSUB tMUL tDIV tPRINTF tCONST

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
    tID tEQ Expression tPV{printf("Affect\n");}; 
Expression:
    tVALINT 
    | tID
    | Expression tADD Expression
    | Expression tSUB Expression
    | Expression tMUL Expression
    | Expression tDIV Expression {printf("Expression\n");} ;
%%

int main()
{
    yyparse();
    return 0;
}

