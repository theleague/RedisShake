#
# Resources:
#   https://hub.docker.com/_/golang
#   https://github.com/theleague/RedisShake
#
# Reset:
#   docker stop $(docker ps -a -q)
#   docker system prune -a
#
# Setup:
#   docker build --rm -t redis-shake .
#   docker run -it --entrypoint /bin/bash redis-shake
#
# Usage:
#   ./redis-shake.linux -type=rump -conf=../conf/redis-shake.conf 

FROM golang:latest

RUN apt-get update

RUN echo "alias ll='ls -ltra --color'" >> /root/.bashrc

WORKDIR /go

COPY . .

RUN go get -u github.com/kardianos/govendor && \
    cd ./src/vendor && \
    GOPATH=`pwd`/../.. && \
    govendor sync && \
    cd ../../ && \
    ./build.sh

WORKDIR /go/bin
