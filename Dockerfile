FROM ubuntu:18.10
MAINTAINER Mathias Bourgoin <mathias.bourgoin@gmail.com>
RUN  apt-get -yq update

RUN  apt-get -yq install --no-install-recommends        \
     --allow-downgrades --allow-remove-essential        \
     --allow-change-held-packages                       \
     sudo pkg-config git build-essential                \
     software-properties-common unzip curl              \
     libx11-dev tar apt-utils m4 dirmngr gpg-agent      \
     libffi-dev emacs-nox wget && apt-get -yq update


RUN useradd -ms /bin/bash mammut && echo "mammut:mammut" | chpasswd && adduser mammut sudo
USER mammut
WORKDIR /home/mammut
CMD /bin/bash

RUN git clone https://github.com/mathiasbourgoin/mammut.git
RUN cd mammut && cmake && make && sudo make install && \
    cd mammut/external/libusb-1.0.9/ && sudo make install


RUN  git clone https://gitlab.com/MBourgoin/ocaml_mammut.git && chown -R mammut /home/mammut/ocaml_mammut

WORKDIR ocaml_mammut/
RUN dockerscripts/install_ocaml.sh

WORKDIR generate_stubs/
USER mammut
CMD /bin/bash



RUN eval $(/home/spoc/opam env) && make install

RUN eval $(/home/spoc/opam env) && make install_test


USER root
RUN mv /home/mammut/opam /usr/bin/opam
USER mammut

WORKDIR /home/mammut

