#include "asm.h"
#include<string.h>
#include <stdio.h>
#include <stdlib.h>

void printASMTable(){
    printf("ASMTable : \n") ; 
    for(int i = 0 ; i < currentIndexASM ; i++)
    {
            if(tableASM[i].op1 == -1){
                printf("%s %d  \n",tableASM[i].CMD,tableASM[i].res) ; 
            }
            else if(tableASM[i].op2 == -1){
                printf("%s %d %d \n",tableASM[i].CMD,tableASM[i].res,tableASM[i].res,tableASM[i].op1) ; 
            }
            else{
                printf("%s %d %d %d \n",tableASM[i].CMD,tableASM[i].res,tableASM[i].op1, tableASM[i].op2) ; 
            }
    }
}

void printASMInFile(){

    FILE* f = fopen("ouput.txt","w") ; 

    if ( f != NULL)
    {
        for(int i = 0 ; i < currentIndexASM ; i++){
            
            if(tableASM[i].op1 == -1){
                fprintf(f, "%s %d  \n",tableASM[i].CMD,tableASM[i].res) ; 
            }
            else if(tableASM[i].op2 == -1){
                fprintf(f, "%s %d %d \n",tableASM[i].CMD,tableASM[i].res,tableASM[i].res,tableASM[i].op1) ; 
            }
            else{
                fprintf(f, "%s %d %d %d \n",tableASM[i].CMD,tableASM[i].res,tableASM[i].op1, tableASM[i].op2) ; 
            }
            
            
        }

        fclose(f) ; 
    }
}

int addASM(char* CMD, int res ,int op1, int op2 ){
    ASM a ;
    a.CMD = CMD ;
    a.res = res ;
    a.op1 = op1 ;
    a.op2 = op2 ;

    //printf("%s %d %d %d \n",CMD,res,op1,op2) ;

    tableASM[currentIndexASM] = a ; 
    currentIndexASM++ ; 

    return currentIndexASM-1 ; 
}   

void modifyASM_JMF(int line){
    tableASM[line].op1 = currentIndexASM ; 
    //printf(" %s %d %d \n", tableASM[line].CMD,tableASM[line].res,tableASM[line].op1) ; 
}

void modifyASM_JMF_else(int line){
    tableASM[line].op1 += 1 ; 
    //printf(" %s %d %d \n", tableASM[line].CMD,tableASM[line].res,tableASM[line].op1) ; 
}

void modifyASM_JMP(int line){
    tableASM[line].res = currentIndexASM ; 
    //printf(" %s %d  \n", tableASM[line].CMD,tableASM[line].res) ; 
}