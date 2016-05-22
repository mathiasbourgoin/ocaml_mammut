CXXFLAGS=--shared --std=c++11 -fPIC -pedantic -W -Wall 


all : mammut.cmxa mammut.cma

mammut.cmxa : mammut.cmi libmammut_stubs.so
	ocamlfind ocamlopt -a -o mammut.cmxa  -package ctypes.foreign mammut.ml  -cclib -L/usrl/local/lib -cclib -lmammut -cclib -lstdc++ 

mammut.cma : mammut.cmi libmammut_stubs.so
	ocamlfind ocamlc -a -o mammut.cma  -package ctypes.foreign mammut.ml -cclib -L. -cclib -L/usrl/local/lib -cclib -lmammut -cclib -lstdc++ 

mammut.cmi : mammut.mli
	ocamlfind ocamlc -package ctypes.foreign -c mammut.mli

mammut.mli : mammut.ml
	ocamlfind ocamlc -package ctypes.foreign -i mammut.ml > mammut.mli

libmammut_stubs.so : mammut_stubs.cpp
	g++ $(CXXFLAGS)  mammut_stubs.cpp -o $@

test.asm: test.ml mammut.cmxa
	ocamlfind ocamlopt -package ctypes.foreign -linkpkg \
	-cclib -lmammut_stubs -thread -cclib -lstdc++ -cclib -lmammut \
	mammut.cmxa test.ml -o $@


test.byte: test.ml mammut.cma
	ocamlfind ocamlc -package ctypes.foreign -linkpkg \
	-cclib -lmammut_stubs -thread -cclib -lstdc++ -cclib -lmammut \
	mammut.cma test.ml -o $@

install: mammut.cmxa mammut.cma mammut.cmi libmammut_stubs.so
	ocamlfind install mammut *.cma *.a *.cmxa *.cmi META -nodll *.so


uninstall:
	ocamlfind remove mammut



test :test.asm test.byte

clean :
	rm -rf *.so *.o test *.a *.mli
	rm -rf *.cm* *.asm *.byte
	rm -rf *~
	rm -rf \#*\#

.PHONY:clean
