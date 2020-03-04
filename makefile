all:
	yacc -d compile.y
	flex -d lexical.l
	gcc lex.yy.c y.tab.c -o compiler
	
clean:
	rm -f lex.yy.c lexer 
