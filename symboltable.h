typedef struct symbol
{
    char* id;
    int constant;
    int depth;
    int init;
    int addr ; 
} symbol;


#define SIZE 200

// SYMBOL 

symbol table[SIZE];
int current_index;
int current_depth;

symbol* find_s(char * id);

void add_s(symbol var);

void printInFile(char* s) ; 
/*
void delete_s(char * id);
*/
void decrementDepth();

void printTable() ; 


// TMP var 

int indexTMPVar  ;  

void pushTMPVar() ; 

void popTMPVar() ; 

