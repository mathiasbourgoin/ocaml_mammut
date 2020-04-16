all:
	cd src && make

test.asm:
	cd src/test && make test.asm

src/ocaml_mammut.cmxa:
	cd src && make ocaml_mammut.cmxa

test : src/ocaml_mammut.cmxa
	cd src/test && make test

clean:
	cd src && make clean
	cd src/test && make clean
