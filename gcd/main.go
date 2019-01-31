package main

import (
	"github.com/shuza/kubernates-go-grpc/pd"
	context "golang.org/x/net/context"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
	"log"
	"net"
)

/**
 * :=  created by:  Shuza
 * :=  create date:  29-Jan-2019
 * :=  (C) CopyRight Shuza
 * :=  www.shuza.ninja
 * :=  shuza.sa@gmail.com
 * :=  Fun  :  Coffee  :  Code
 **/

type server struct{}

func main() {
	lis, err := net.Listen("tcp", ":3000")
	if err != nil {
		log.Fatalf("Failed to listen:  %v", err)
	}

	s := grpc.NewServer()
	pb.RegisterGCDServiceServer(s, &server{})
	reflection.Register(s)
	if err := s.Serve(lis); err != nil {
		log.Fatalf("Failed to serve: %v", err)
	}

}

func (s *server) Compute(cxt context.Context, r *pb.GCDRequest) (*pb.GCDResponse, error) {
	a, b := r.A, r.B
	for b != 0 {
		a, b = b, a%b
	}

	return &pb.GCDResponse{Result: a}, nil
}
