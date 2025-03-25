refrescar archivos:

bison -d --defines=parser.tab.hh -o parser.cpp parser.y
flex -o scanner.cpp scanner.l
g++ -o my_compiler scanner.cpp parser.cpp -lfl
