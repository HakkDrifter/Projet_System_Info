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
    | AffectationDef Body ; 
Definition:
    tINT tID DefinitionN tPV { if(find_s($2) == NULL){
                                    printf("Definition \n"); 
                                    symbol s_new ; 
                                    s_new.id = $2 ; 
                                    s_new.constant = 0 ; 
                                    s_new.depth = current_depth ; 
                                    s_new.init = 0 ; 
                                    add_s(s_new) ;
                                    printTable() ;   
                                }
                                else
                                {
                                    printf("%s already defined \n",$2) ; 
                                }}
    | tCONST tINT tID DefinitionN tPV { 
                                if(find_s($3) == NULL){
                                    printf("Definition CST \n"); 
                                    symbol s ; 
                                    s.id = $3 ; 
                                    s.constant = 1 ; 
                                    s.depth = current_depth ; 
                                    s.init = 0 ; 
                                    add_s(s) ;  
                                    printTable() ; 
                                }
                                else
                                {
                                    printf("%s already defined \n",$3) ;
                                }} ;  
DefinitionN:
    /* vide */
    | tVR tID DefinitionN { if(find_s($2) == NULL)
                                {  printf("Definition  \n"); 
                                symbol s ; 
                                s.id = $2 ; 
                                s.constant = 0 ; 
                                s.depth = current_depth ; 
                                s.init = 0 ; 
                                add_s(s) ;  
                                }
                                else
                                {
                                    printf("%s already defined \n",$2) ; 
                                }}
    |  tVR tCONST tID DefinitionN { if(find_s($3) == NULL)
                                { printf("Definition CST \n"); 
                                symbol s ; 
                                s.id = $3 ; 
                                s.constant = 0 ; 
                                s.depth = current_depth ; 
                                s.init = 0 ; 
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
                                    else{
                                        printf("Affectation\n"); 
                                        s->init = 1 ; 
                                        printf("COP %d %d",s->addr,indexTMPVar-1) ; 
                                        popTMPVar() ; 
                                    }
                                    
                                }
                                else
                                {
                                    printf("%s not defined \n",$1) ; 
                                }}  ; 

AffectationDef:
    tINT tID tEQ Expression tPV { if(find_s($2) == NULL)
                                { printf("AffectationDef\n"); 
                                symbol s_new ; 
                                s_new.id = $2 ; 
                                s_new.constant = 0 ; 
                                s_new.depth = current_depth ; 
                                s_new.init = 1 ;  
                                add_s(s_new) ;  
                                printf("COP %d %d",s_new.addr,indexTMPVar-1) ; 
                                popTMPVar() ; 
                                }
                                else
                                {
                                    printf("%s already defined \n",$2) ; 
                                }} ; 
    | tCONST tINT tID tEQ Expression tPV { if(find_s($3) == NULL)
                                { printf("AffectationDef CST\n"); 
                                symbol s_new ; 
                                s_new.id = $3 ; 
                                s_new.constant = 1 ; 
                                s_new.depth = current_depth ; 
                                s_new.init = 1 ; 
                                add_s(s_new) ;  
                                printf("COP %d %d",s_new.addr,indexTMPVar-1) ; 
                                popTMPVar() ; 
                                }
                                else
                                {
                                    printf("%s already defined \n",$3) ; 
                                }} ; 

Expression:
    tVALINT {
            printf("AFC %d %d \n",indexTMPVar,$1) ; 
            pushTMPVar() ; 
    } 
    | tID {
            int i = find_s($1)->addr ; 
            printf("COP %d %d \n",indexTMPVar,i) ; 
            pushTMPVar() ; 
         }
    | Expression tADD Expression {
                                popTMPVar() ; 
                                popTMPVar() ; 
                                printf("ADD %d %d %d \n",indexTMPVar,indexTMPVar, indexTMPVar+1) ;
    }
    | Expression tSUB Expression {
                                popTMPVar() ;   
                                popTMPVar() ; 
                                printf("SUB %d %d %d \n",indexTMPVar,indexTMPVar, indexTMPVar+1) ;}
    | Expression tMUL Expression {  
                                popTMPVar() ; 
                                popTMPVar() ;                               
                                printf("MUL %d %d %d \n",indexTMPVar,indexTMPVar, indexTMPVar+1) ;}
    | Expression tDIV Expression {
                                popTMPVar() ; 
                                popTMPVar() ; 
                                printf("DIV %d %d %d \n",indexTMPVar,indexTMPVar, indexTMPVar+1) ;
    }
    | tPO Expression tPF { };

Start_Block:
    tAO {current_depth++;} ; 

End_Block:
    tAF {decrementDepth();} ; 

%%

int main()
{
    indexTMPVar = 100 ; 
    yyparse();
    return 0;
}

