%{
    #include <stdio.h>
    #include "symboltable.h"
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
    tINT tMAIN Start_Block Body End_Block {printf("Main\n");}; 
Body:
    /* vide */
    | Definition Body
    | Affectation Body 
    | AffectationVeauLait Body ; 
Definition:
    tINT tID DefinitionN tPV { if(find_s($2) == NULL)
                                { printf("def\n"); 
                                symbol s_new ; 
                                s_new.id = $2 ; 
                                s_new.constant = 0 ; 
                                s_new.depth = current_depth ; 
                                s_new.init = 0 ; 
                                s_new.val = 0 ; 
                                add_s(s_new) ;  
                                }
                                else
                                {
                                    printf("%s already defined \n",$2) ; 
                                }}
    | tCONST tINT tID DefinitionN tPV { 
                                if(find_s($3) == NULL)
                                { printf("def\n"); 
                                symbol s ; 
                                s.id = $3 ; 
                                s.constant = 1 ; 
                                s.depth = current_depth ; 
                                s.init = 0 ; 
                                s.val = 0 ;  
                                add_s(s) ;  
                                }
                                else
                                {
                                    printf("%s already defined \n",$3) ;
                                }} ;  
DefinitionN:
    /* vide */
    | tVR tID DefinitionN { if(find_s($2) == NULL)
                                { printf("def\n"); 
                                symbol s ; 
                                s.id = $2 ; 
                                s.constant = 0 ; 
                                s.depth = current_depth ; 
                                s.init = 0 ; 
                                s.val = 0 ;  
                                add_s(s) ;  
                                }
                                else
                                {
                                    printf("%s already defined \n",$2) ; 
                                }}
    |  tVR tCONST tID DefinitionN { if(find_s($3) == NULL)
                                { printf("def\n"); 
                                symbol s ; 
                                s.id = $3 ; 
                                s.constant = 0 ; 
                                s.depth = current_depth ; 
                                s.init = 0 ; 
                                s.val = 0 ;  
                                add_s(s) ;  
                                }
                                else
                                {
                                    printf("%s already defined \n",$3) ; 
                                }} ; 
Affectation:
    tID tEQ Expression tPV{     symbol* s = find_s($1) ; 
                                if(s != NULL)
                                {
                                if(s->constant == 1 && s->init == 1)
                                {
                                    printf("%s constant already affected \n",$1) ;
                                }
                                s->init = 1 ; 
                                s->val = $3 ;  
                                }
                                else
                                {
                                    printf("%s not defined \n",$1) ; 
                                }} ; 

AffectationVeauLait:
    tINT tID tEQ Expression tPV { if(find_s($2) == NULL)
                                { printf("def\n"); 
                                symbol s_new ; 
                                s_new.id = $2 ; 
                                s_new.constant = 0 ; 
                                s_new.depth = current_depth ; 
                                s_new.init = 1 ; 
                                s_new.val = $4 ; 
                                add_s(s_new) ;  
                                }
                                else
                                {
                                    printf("%s already defined \n",$2) ; 
                                }} ; 
    | tCONST tINT tID tEQ Expression tPV { if(find_s($3) == NULL)
                                { printf("def\n"); 
                                symbol s_new ; 
                                s_new.id = $3 ; 
                                s_new.constant = 1 ; 
                                s_new.depth = current_depth ; 
                                s_new.init = 1 ; 
                                s_new.val = $5 ; 
                                add_s(s_new) ;  
                                }
                                else
                                {
                                    printf("%s already defined \n",$3) ; 
                                }} ; 

Expression:
    tVALINT {$$ = $1;} 
    | tID { $$ = find_s($1)->val ;}
    | Expression tADD Expression {$$ = $1 + $3;}
    | Expression tSUB Expression {$$ = $1 - $3;}
    | Expression tMUL Expression {$$ = $1 * $3;}
    | Expression tDIV Expression {$$ = $1 / $3;}
    | tPO Expression tPF {$$ = $2;
                          printf("res = %d \n",$$);};

Start_Block:
    tAO {current_depth++;} ; 

End_Block:
    tAF {decrement_depth();} ; 

%%

int main()
{
    yyparse();
    return 0;
}

