FROM golang

COPY . /go/src/add
WORKDIR /go/src/add
RUN go get .
ENTRYPOINT go run main.go
EXPOSE 3000
