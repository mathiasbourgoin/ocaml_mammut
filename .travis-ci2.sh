eval `opam config env`
sudo modprobe msr
eval $(opam env) && make test
./test
