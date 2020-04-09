#include"symboltable.h"
#include<string.h>
#include <stdio.h>
#include <stdlib.h>

symbol* find_s(char* id)
{
    int current_closest_index;
    int current_closest_depth = -1;
    int found = 0 ; 
    
    for(int i = 0;  i < current_index; i++)
    {
        if(strcmp(table[i].id, id) == 0)
        {
            if(table[i].depth > current_closest_depth && table[i].depth <= current_depth)
            {
                found = 1 ; 
                current_closest_index = i;
                current_closest_depth = table[i].depth ; 
                
            }
        }
    }
    
    if(found == 1)
    {
        return &table[current_closest_index];
    }
    else
    {
        return NULL ; 
    }
    
}


void add_s(symbol var)
{
    if(current_index >= 100)
    {
        return ; 
    }

    var.addr = current_index ; 
    table[current_index] = var;   
    current_index++ ; 
}

void printTable()
{
    printf("Table : \n") ; 
    for(int i = 0 ; i < current_index ; i++)
    {
        printf("%s \n",table[i].id) ; 
    }
}

void printInFile(char* s){

    FILE* f = fopen("ouput.txt","w") ; 

    if ( f != NULL)
    {
        char * line = strcat(s,"\n") ;  

        fprintf(f, line) ; 

        fclose(f) ; 
    }
}


void decrementDepth()
{
    
    // printf("\n DECREMENT DEPTH  \n") ; 
    for(int i = current_index-1 ; i >= 0 ; i--){
        
        //  printf("CURRENT DEPTH %d | ELEMENT DEPTH %d \n",current_depth,table[i].depth ) ; 
        if(table[i].depth == current_depth){
            symbol s ; 
            table[i] = s ; 
            
        }
        else{
            break ; 
        }
    }

    current_depth-- ; 

}


// TMP var 

void pushTMPVar(){
    symbol s ; 
    s.id = "" ; 
    table[indexTMPVar] = s;   
    //printf("INDEX %d \n",indexTMPVar) ; 
    indexTMPVar++ ; 
}

void popTMPVar(){
     
    indexTMPVar-- ; 
    //printf("INDEX POP %d \n",indexTMPVar) ; 

}



