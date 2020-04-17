all:
	cd src && make

test :
	cd src && make test

runtest :
	cd src && make runtest

clean:
	cd src && make clean
	cd src/test && make clean
