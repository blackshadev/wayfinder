package main

import (
	"fmt"
	"net/http"
)

func main() {
	router := http.NewServeMux()

	router.Handle("GET /public/", http.StripPrefix("/public", http.FileServer(http.Dir("./public/"))))

	fmt.Println("Webserver running on 8080")
	http.ListenAndServe(":8080", router)
}
