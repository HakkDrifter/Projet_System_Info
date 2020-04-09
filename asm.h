typedef struct ASMLine
{
    char* CMD ; 
    int res ; 
    int op1 ; 
    int op2 ; 
} ASM;

#define SIZE_ASM 200


ASM tableASM[SIZE_ASM];
int currentIndexASM;
int tempLine;
int throughIf ; 

void printASMTable() ; 
void printASMInFile() ; 

int addASM(char* CMD, int res ,int op1, int op2 ) ; 

void modifyASM_JMF(int line) ; 
void modifyASM_JMF_else(int line) ; 

void modifyASM_JMP(int line) ;