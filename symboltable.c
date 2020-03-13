#include"symboltable.h"
#include<string.h>

symbol find_s(char* id)
{
    int current_closest_index;
    int current_closest_depth = 0;
    for(int i = 0;  i < SIZE; i++)
    {
        if(strcmp(table[i].id, id) == 0)
        {
            if(table[i].depth > current_closest_depth && table[i].depth < current_depth)
            {
                current_closest_index = i;
                current_closest_depth = table[i].depth
            }
        }
    }
    return table[current_closest_index];
}

void add_s(symbol var)
{
    table[current_index] = var;
}

void delete_s(char * id)
{
    for(int i = 0;  i < SIZE; i++)
    {
        if(strcmp(table[i].id, id) == 0 && table[i].depth == current_depth)
        {
            table[i] = null;
        }
    }
}

void decrement_depth()
{
    for (int i = current_index ; i>1; i--)
    {      
        if (table[i-1].depth == current_depth)    
        {
            table[i-1] = null;
        }
        else
        {
            break;
        }
    }
}

