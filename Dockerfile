FROM debian:bullseye-slim

RUN apt-get update

RUN apt install -y build-essential
RUN apt install -y cmake
RUN apt install -y gdb gdbserver
RUN apt install -y vim
RUN apt install -y git

RUN rm -rf /var/lib/apt/lists/*
