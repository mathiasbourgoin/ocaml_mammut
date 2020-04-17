# ../ocaml_mammut.cmxa:
# 	cd .. && make ocaml_mammut.cmxa

# test.asm: test.ml ../ocaml_mammut.cmxa ../mammut_stubs.o ../libocaml_mammut.a
# 	ocamlfind ocamlopt  -thread -package ctypes.stubs -linkpkg -cclib -lunix -cclib -lpthread  -cclib -lstdc++  -cclib -lusb-1.0 -cclib -lsmartgauge -cclib -lmammut -I .. ocaml_mammut.cmxa  test.ml -o test.asm

# test: test.asm
# 	./test.asm

runtest :
	dune runtest

clean:
	rm -f *.cm* *.o test *.asm a.out mammut_stubs.c mammut_generated.ml mammut_types.* types_gen.c *.so *.a
