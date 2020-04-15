all: ocaml_mammut.cmxa

# mammut.cmxa: mammut.cmx
# 	ocamlmklib -linkall -o mammut  mammut.cmx  *.o -cclib -lasmrun

ocaml_mammut.cmxa: mammut_generated.cmx mammut_stubs.o mammut_types.cmx
	ocamlfind ocamlmklib -custom -linkall -package ctypes.stubs  -cclib -lmammut_static -cclib -lsmartgauge  -cclib -lstdc++ -cclib -lusb-1.0 mammut_types.cmx generate_types.cmx generate_stubs.cmx mammut_generated.cmx mammut_stubs.o mammut.ml -o ocaml_mammut

generate_stubs.asm : generate_stubs.ml mammut_types.cmx generate_types.cmx
	ocamlfind ocamlopt -cclib -lmammut_static -linkpkg -package ctypes.foreign,ctypes.stubs generate_types.cmx mammut_types.cmx generate_stubs.ml
	./a.out && rm a.out

generate_types.asm : generate_types.ml
	ocamlfind ocamlopt -cclib -lmammut_static -linkpkg -package ctypes.foreign,ctypes.stubs generate_types.ml
	./a.out && rm a.out


mammut_stubs.c: generate_stubs.asm

mammut_types.c: generate_types.asm

mammut_generated.ml: generate_stubs.asm


mammut_types.ml: mammut_types.c
	ocamlfind ocamlopt  -package ctypes.stubs -linkpkg mammut_types.c -o a.out
	./a.out > mammut_types.ml && rm a.out

mammut_types.cmx: mammut_types.ml
	ocamlfind ocamlopt -package ctypes.foreign,ctypes.stubs mammut_types.ml -c


mammut_stubs.o: mammut_stubs.c
	ocamlfind ocamlopt  -package ctypes.stubs mammut_stubs.c  -c

mammut_generated.cmx: mammut_generated.ml mammut_types.cmx
	 ocamlfind ocamlopt -I /usr/local/include/ -package ctypes.stubs -linkpkg  mammut_stubs.o -c mammut_generated.ml mammut_types.cmx


test.asm: test.ml ocaml_mammut.cmxa mammut_stubs.o libocaml_mammut.a
	ocamlfind ocamlopt  -thread -package ctypes.stubs -linkpkg -cclib -lunix -cclib -lpthread  -cclib -lstdc++  -cclib -lusb-1.0 -cclib -lsmartgauge -cclib -lmammut -I . ocaml_mammut.cmxa  test.ml -o test.asm

test: test.asm
	./test.asm

install: ocaml_mammut.cmxa
	ocamlfind install mammut  mammut.cmx *.a ocaml_mammut.cmxa *.cmi  META

install_test :
	ocamlfind ocamlopt -thread -package mammut -linkpkg test.ml -o test

uninstall:
	ocamlfind remove mammut


clean:
	rm -f *.cm* *.o test *.asm a.out mammut_stubs.c mammut_generated.ml mammut_types.* types_gen.c *.so *.a
