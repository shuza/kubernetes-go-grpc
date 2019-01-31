FROM golang

COPY . /go/src/api
WORKDIR /go/src/api
RUN go get .
ENTRYPOINT go run main.go
EXPOSE 8080
