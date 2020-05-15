all:
	cd src && dune build

test :
	cd test && make test

runtest :
	cd test && make runtest

clean:
	cd src && dune clean
	cd test && dune clean
