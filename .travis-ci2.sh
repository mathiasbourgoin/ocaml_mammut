sudo modprobe msr
eval $(opam env) && make test
./test
