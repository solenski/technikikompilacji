prog : main.o parser.o emitter.o error.o symbol.o lexer.o init.o
	gcc main.o parser.o emitter.o error.o symbol.o lexer.o init.o -o prog

main.o : main.c global.h 
	gcc -c main.c

parser.c parser.h: global.h 
	bison -o parser.c parser.y --defines=parser.h

parser.o : parser.c global.h
	gcc -c parser.c

emitter.o : emitter.c global.h parser.h
	gcc -c emitter.c

error.o : error.c global.h
	gcc -c error.c

symbol.o : symbol.c global.h
	gcc -c symbol.c

lexer.c: global.h parser.h
	flex -o lexer.c lexer.l

lexer.o : lexer.c global.h  

	gcc -c lexer.c

init.o : init.c global.h
	gcc -c init.c

clean:
	rm -rf init.o lexer.c lexer.o symbol.o error.o emitter.o parser.o main.o parser.c parser.h prog

