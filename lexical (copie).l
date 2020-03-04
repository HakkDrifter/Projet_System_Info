int e?[0-9]+
sep [ \t\n]
id [A-Za-z][A-Za-z0-9_]*

%%

"main()" {printf("Debut main\n");}
"{" {printf("Debut Bloc\n");}
"}" {printf("Fin Bloc\n");}
"const" {printf("Une constante\n");}
"int" {printf("Le type int\n");}
{int} {printf("un entier\n");}
"+" {printf("add\n");}
"-" {printf("sub\n");}
"*" {printf("mul\n");}
"/" {printf("div\n");}
"=" {printf("affectation\n");}
"(" {printf("parenthèse ouvrante\n");}
")" {printf("parenthèse fermante\n");}
";" {printf("fin d'une instruction");}
"," {printf("virgoule\n");}
"printf" {printf("fonction print\n");}
{sep} {printf("Un separateur\n");}
{id} {printf("id\n");}
. {printf("Erreur\n");}

%%

int yywrap(void)
{
    return 1;
} 

int main()
{
    while(yylex() != 0);
    return 0;
}
