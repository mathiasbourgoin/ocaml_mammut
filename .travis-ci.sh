sudo apt-get install cmake

eval $(opam env) && opam install -y ctypes ctypes-foreign ocamlfind

git clone https://github.com/mathiasbourgoin/mammut.git && cmake && \
    make && sudo make install && cd mammut/external/libusb-1.0.9/ && \
    sudo make install
