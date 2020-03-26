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

/*
void delete_s(char * id)
{
    for(int i = 0;  i < SIZE; i++)
    {
        if(strcmp(table[i].id, id) == 0 && table[i].depth == current_depth)
        {
            table[i] = NULL;
        }
    }
}
*/
void decrementDepth()
{
    current_depth-- ; 

}


// TMP var 

void pushTMPVar(){
    symbol s ; 
    s.id = "" ; 
    table[indexTMPVar] = s;   
    indexTMPVar++ ; 
}

void popTMPVar(){
     
    indexTMPVar-- ; 

}



