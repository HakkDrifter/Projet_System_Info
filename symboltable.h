typedef struct symbol
{
    char* id;
    int constant;
    int depth;
    int init;
    int val;  
} symbol;

#define SIZE 100

symbol table[SIZE];
int current_index;
int current_depth;

symbol* find_s(char * id);

/*
int is_defined(char* id) ; 
*/

void add_s(symbol var);
/*
void delete_s(char * id);
*/
void decrement_depth();
