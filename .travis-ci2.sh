eval `opam config env`
export CXX=g++-4.8
sudo modprobe msr
cd generate_stubs && make test
#sudo ./test
