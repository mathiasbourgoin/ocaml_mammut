all:
	cd c && make

test :
	cd test && make test

runtest :
	cd test && make runtest

clean:
	cd c && make clean
	cd c/test && make clean
