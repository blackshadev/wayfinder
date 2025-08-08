package main

import (
	"fmt"

	srv "wayfinder.littledev.nl/server/server"
)

func main() {
	s := srv.CreateServer(":8080")

	fmt.Println("Server running on 8080")
	s.Start()
}
