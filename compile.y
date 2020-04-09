%{
    #include <stdio.h>
    #include "symboltable.h"
    #include "asm.h"
    int yylex();
    void yyerror(char * str){printf("%s\n",str);};
%}
%union{
    int nb;
    char * str;
}
%token tMAIN tINT tEQ tIF tELSE tWHILE tPF tPO tAF tPV tVR tAO tADD tSUB tMUL tDIV tPRINTF tCONST tEQEQ tSUP tINF 
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
    | AffectationDef Body 
    | If 
    | If_Else 
    | While ;  

If:
    tIF tPO Expression tPF { 
                            tempLine = addASM("JMF",indexTMPVar-1,-1,-1) ; 
                            popTMPVar();}
    Start_Block Body End_Block { 
        modifyASM_JMF(tempLine) ; 
    } ; 
If_Else:
    If tELSE { 
        modifyASM_JMF_else(tempLine) ; 
        tempLine = addASM("JMP",-1,-1,-1) ; 
    }
    Start_Block Body End_Block {
        modifyASM_JMP(tempLine) ; 
    }; 

While: 
    tWHILE tPO { 
        loopLine = currentIndexASM ; 
        }
    Expression tPF { 
                            tempLine = addASM("JMF",indexTMPVar-1,-1,-1) ; 
                            popTMPVar();}
    Start_Block Body End_Block {
        addASM("JMP",loopLine,-1,-1) ; 
        modifyASM_JMF(tempLine) ; 
    } ;

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
                                        addASM("COP",s->addr,indexTMPVar-1,-1) ; 
                                        popTMPVar() ; 
                                    }
                                    
                                }
                                else
                                {
                                    popTMPVar() ; 
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
                                addASM("COP",s_new.addr,indexTMPVar-1,-1) ; 
                                popTMPVar() ; 
                                }
                                else
                                { 
                                    
                                    printf("%s already defined \n",$2) ; 
                                    popTMPVar() ; 
                                }} ; 
    | tCONST tINT tID tEQ Expression tPV { if(find_s($3) == NULL)
                                { printf("AffectationDef CST\n"); 
                                symbol s_new ; 
                                s_new.id = $3 ; 
                                s_new.constant = 1 ; 
                                s_new.depth = current_depth ; 
                                s_new.init = 1 ; 
                                add_s(s_new) ;  
                                addASM("COP",s_new.addr,indexTMPVar-1,-1) ; 
                                popTMPVar() ; 
                                }
                                else
                                {
                                    printf("%s already defined \n",$3) ; 
                                    popTMPVar() ; 
                                }} ; 

Expression:
    tVALINT {
            addASM("AFC",indexTMPVar,$1,-1) ; 
            pushTMPVar() ; 
    } 
    | tID {
            int i = find_s($1)->addr ; 
            addASM("COP",indexTMPVar-1,i,-1) ; 
            pushTMPVar() ; 
         }
    | Expression tADD Expression {
                                popTMPVar() ; 
                                popTMPVar() ; 
                                pushTMPVar() ;
                                addASM("ADD",indexTMPVar-1,indexTMPVar-1,indexTMPVar) ; 
    }
    | Expression tSUB Expression {
                                popTMPVar() ;   
                                popTMPVar() ; 
                                pushTMPVar() ;
                                addASM("SUB",indexTMPVar-1,indexTMPVar-1,indexTMPVar) ; }
    | Expression tMUL Expression {  
                                popTMPVar() ; 
                                popTMPVar() ;       
                                pushTMPVar() ;                        
                                addASM("MUL",indexTMPVar-1,indexTMPVar-1,indexTMPVar) ; }

    | Expression tDIV Expression {
                                popTMPVar() ; 
                                popTMPVar() ; 
                                pushTMPVar() ;
                                addASM("DIV",indexTMPVar-1,indexTMPVar-1,indexTMPVar) ; 
    }
    | tPO Expression tPF { };
    | Expression tSUP Expression {
                                popTMPVar() ; 
                                popTMPVar() ; 
                                pushTMPVar() ;
                                addASM("SUP",indexTMPVar-1,indexTMPVar-1,indexTMPVar) ; 
    }
    | Expression tINF Expression {
                                popTMPVar() ; 
                                popTMPVar() ; 
                                pushTMPVar() ;
                                addASM("INF",indexTMPVar-1,indexTMPVar-1,indexTMPVar) ; 
    }
    | Expression tEQEQ Expression {
                                popTMPVar() ; 
                                popTMPVar() ; 
                                pushTMPVar() ;
                                addASM("EQU",indexTMPVar-1,indexTMPVar-1,indexTMPVar) ; 
    }

Start_Block:
    tAO {current_depth++;} ; 

End_Block:
    tAF {
        decrementDepth();
        } ; 

%%

int main()
{
    indexTMPVar = 100 ; 
    yyparse();
    printASMTable() ; 
    printASMInFile() ; 
    return 0;
}

