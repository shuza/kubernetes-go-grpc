FROM golang

COPY . /go/src/gcd
WORKDIR /go/src/gcd
RUN go get .
ENTRYPOINT go run main.go
EXPOSE 3000
