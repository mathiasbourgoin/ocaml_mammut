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
	ocamlfind ocamlopt  -package ctypes.foreign mammut.cmxa -cclib libmammut_stubs.so -cclib -lmammut -cclib -lstdc++ -linkpkg  -thread  -o test test.ml
	sudo LD_LIBRARY_PATH=. ./test


install_test :
	ocamlfind ocamlopt   -package ctypes.foreign,mammut -cclib `ocamlfind query mammut`/libmammut_stubs.so -linkpkg  -thread  -o test test.ml

doc: mammut.cmi mammut.mli
	mkdir -p doc
	ocamlfind ocamldoc -package ctypes.foreign -html -d doc mammut.ml


install: mammut.cmxa mammut.cma mammut.cmi libmammut_stubs.so
	ocamlfind install mammut *.cma *.a *.cmxa *.cmi META -nodll *.so


uninstall:
	ocamlfind remove mammut



clean :
	rm -rf *.so *.o test *.a *.mli
	rm -rf *.cm* *.asm *.byte
	rm -rf *~
	rm -rf \#*\#

.PHONY:clean doc
