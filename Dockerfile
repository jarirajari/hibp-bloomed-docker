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

ARG GOLANG=go1.15.linux-amd64.tar.gz
WORKDIR /root/go/
RUN wget https://golang.org/dl/${GOLANG} && \
  tar -xvf ${GOLANG} && \
  mv go /usr/local
RUN rm -f ${GOLANG}

# https://golang.org/doc/gopath_code.html#GOPATH
# https://github.com/golang/go/wiki/SettingGOPATH
# apps: /root/go/bin/bloom AND /root/go/bin/hibb

RUN echo "GOPATH=/root/go" >> /etc/profile.d/govars.sh && \
  echo "GOBIN=/usr/local/go/bin" >> /etc/profile.d/govars.sh && \
  echo "PATH=$PATH:/usr/local/go/bin:/root/go/bin" >> /etc/profile.d/govars.sh

RUN . /etc/profile
RUN ln -sf /usr/local/go/bin/go /usr/local/bin/go

WORKDIR /root/go/src/
RUN git clone https://github.com/jarirajari/have-i-been-bloomed.git

# Download latest database file of pawned passwords from
# https://haveibeenpwned.com/Passwords
# and rename it using the following name.
# The file MUST be in Docker context and NOT a symlink!!!
ARG DATA_FILE=pwned-passwords.txt.7z
WORKDIR /root/go/src/have-i-been-bloomed/

COPY ${DATA_FILE} ${DATA_FILE}
RUN make bloom-tool server
RUN ln -sf /root/go/bin/hibb /usr/local/bin/hibb
RUN ln -sf /root/go/bin/bloom /usr/local/bin/bloom
# Dirty hack for monitoring progress of 10+ GB files...
# RUN bash -c "while true; do echo `du -sh pwned-passwords.bloom.gz`; sleep 60;done" 2>&1 &
RUN make bloom-filter

RUN rm -f ${DATA_FILE}
RUN apt remove -y build-essential && apt clean && apt autoremove -y

ENTRYPOINT hibb


