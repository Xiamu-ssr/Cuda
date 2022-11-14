.PHONY: clean demo *.o

CFLAGS = -Wall -O2 -fopenmp -lpthread -std=c++11

demo : solve.o main.o
	g++ -o demo solve.o main.o -lcudart -lcuda

main.o : main.cpp
	g++ $(CFLAGS) -c -o main.o main.cpp

solve.o : solve.cu solve.h
	nvcc -c -o solve.o solve.cu

clean :
	rm -rf demo *.o
