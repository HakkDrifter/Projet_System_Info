#include"symboltable.h"
#include<string.h>
#include <stdio.h>

symbol* find_s(char* id)
{
    int current_closest_index;
    int current_closest_depth = 0;
    int found = 0 ; 

    for(int i = 0;  i < current_index; i++)
    {
        if(strcmp(table[i].id, id) == 0)
        {
            printf("%d",i) ; 
            found = 1 ; 
            if(table[i].depth > current_closest_depth && table[i].depth < current_depth)
            {
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

/*
int is_defined(char* id) 
{
    for(int i = 0;  i < current_index; i++)
    {
        if(strcmp(table[i].id, id) == 0 && table[i].depth == current_depth)
        {
            return 1 ; 
        }
    }

    return 0 ; 
}
*/

void add_s(symbol var)
{
    table[current_index] = var;
    current_index++ ; 
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
void decrement_depth()
{
    current_depth-- ; 
/*
    for (int i = current_index ; i>1; i--)
    {      
        if (table[i-1].depth == current_depth)    
        {
            //table[i-1] = NULL;
        }
        else
        {
            break;
        }
    }
    */
}

