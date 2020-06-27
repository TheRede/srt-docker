FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir /build
WORKDIR /build

RUN apt update -y
RUN apt upgrade -y
RUN apt install tcl build-essential libssl-dev cmake pkg-config git zlib1g-dev -y

#SRT
RUN git clone https://github.com/Haivision/srt.git
WORKDIR /build/srt/
RUN ./configure && make && make install
RUN ldconfig /usr/local/lib/

#SRT Live Server
WORKDIR /build/
RUN git clone https://github.com/Edward-Wu/srt-live-server.git
WORKDIR /build/srt-live-server/
RUN make

#Start
WORKDIR /build/srt-live-server/bin/
CMD ["./sls", "-c", "../sls.conf"]