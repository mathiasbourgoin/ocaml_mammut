all: mammut.cmxa

mammut.cmxa: mammut_generated.cmx mammut_stubs.o test.ml
	ocamlfind ocamlopt  -thread -package ctypes.stubs  -cclib -lunix -cclib -lpthread  -cclib -lstdc++  mammut_generated.cmx generate_stubs.cmx mammut_stubs.o  -cclib -lmammut -cclib -lsmartgauge -cclib -lusb-1.0 -a mammut.ml -o mammut.cmxa

generate_stubs.asm : generate_stubs.ml
	ocamlfind ocamlopt -cclib -lmammut -linkpkg -package ctypes.foreign,ctypes.stubs generate_stubs.ml
	./a.out && rm a.out


mammut_stubs.c: generate_stubs.asm

mammut_generated.ml: generate_stubs.asm

mammut_stubs.o: mammut_stubs.c
	ocamlfind ocamlopt  -package ctypes.stubs mammut_stubs.c  -c

mammut_generated.cmx: mammut_generated.ml
	 ocamlfind ocamlopt -I /usr/local/include/ -package ctypes.stubs -linkpkg  mammut_stubs.o -c mammut_generated.ml


test: test.ml mammut.cmxa
	ocamlfind ocamlopt  -thread -package ctypes.stubs -linkpkg -cclib -lunix -cclib -lpthread  -cclib -lstdc++   -cclib -lmammut -cclib -lsmartgauge -cclib -lusb-1.0 mammut.cmxa test.ml -o test

install: mammut.cmxa
	ocamlfind install mammut  mammut.a mammut.cmxa mammut.cmi META -nodll

install_test :
	ocamlfind ocamlopt -package mammut -linkpkg  -thread  -o test test.ml

uninstall:
	ocamlfind remove mammut


clean:
	rm -f *.cm* *.o test *.asm a.out mammut_stubs.c mammut_generated.ml *.a
