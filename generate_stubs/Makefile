all: ocaml_mammut.cmxa

# mammut.cmxa: mammut.cmx
# 	ocamlmklib -linkall -o mammut  mammut.cmx  *.o -cclib -lasmrun

ocaml_mammut.cmxa: mammut_generated.cmx mammut_stubs.o
	ocamlfind ocamlmklib -custom -linkall -package ctypes.stubs  -cclib -lmammut -cclib -lsmartgauge  -cclib -lstdc++ -cclib -lusb-1.0 generate_stubs.cmx mammut_generated.cmx mammut_stubs.o mammut.ml -o ocaml_mammut

generate_stubs.asm : generate_stubs.ml
	ocamlfind ocamlopt -cclib -lmammut -linkpkg -package ctypes.foreign,ctypes.stubs generate_stubs.ml
	./a.out && rm a.out


mammut_stubs.c: generate_stubs.asm

mammut_generated.ml: generate_stubs.asm

mammut_stubs.o: mammut_stubs.c
	ocamlfind ocamlopt  -package ctypes.stubs mammut_stubs.c  -c

mammut_generated.cmx: mammut_generated.ml
	 ocamlfind ocamlopt -I /usr/local/include/ -package ctypes.stubs -linkpkg  mammut_stubs.o -c mammut_generated.ml


test: test.ml ocaml_mammut.cmxa mammut_stubs.o libocaml_mammut.a
	ocamlfind ocamlopt  -thread -package ctypes.stubs -linkpkg -cclib -lunix -cclib -lpthread  -cclib -lstdc++  -cclib -lmammut -cclib -lsmartgauge -cclib -lusb-1.0 -I . ocaml_mammut.cmxa  test.ml -o test

install: ocaml_mammut.cmxa
	ocamlfind install mammut  mammut.cmx *.a ocaml_mammut.cmxa *.cmi  META

install_test : 
	ocamlfind ocamlopt -thread -package mammut -linkpkg test.ml -o test 

uninstall:
	ocamlfind remove mammut


clean:
	rm -f *.cm* *.o test *.asm a.out mammut_stubs.c mammut_generated.ml *.so *.a
