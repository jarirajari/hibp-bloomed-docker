FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt -y update && apt -y upgrade
RUN mkdir -p /root/go/src/

RUN apt -y install nano \
  git \
  wget \
  tar \
  p7zip-full \
  build-essential \
  nano

WORKDIR /root/go/
RUN wget https://dl.google.com/go/go1.11.linux-amd64.tar.gz && \
  tar -xvf go1.11.linux-amd64.tar.gz && \
  mv go /usr/local

# https://golang.org/doc/gopath_code.html#GOPATH
# https://github.com/golang/go/wiki/SettingGOPATH

RUN echo "GOPATH=/root/go" >> /etc/profile.d/govars.sh && \
  echo "GOBIN=/usr/local/go/bin" >> /etc/profile.d/govars.sh && \
  echo "PATH=$PATH:/usr/local/go/bin" >> /etc/profile.d/govars.sh

RUN . /etc/profile

WORKDIR /root/go/src/
RUN git clone https://github.com/jarirajari/have-i-been-bloomed.git

RUN apt install -y golang-github-dcso-bloom-cli

ARG DATA_FILE=pwned-passwords-2.0.txt.7z
WORKDIR /root/go/src/have-i-been-bloomed/
RUN make
RUN rm -f ${DATA_FILE}

RUN apt remove -y build-essential && \
   apt clean && \
   apt autoremove -y

ENTRYPOINT /root/go/bin/hibb


