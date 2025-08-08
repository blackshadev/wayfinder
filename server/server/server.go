package server

import (
	"net/http"
)

type Server struct {
	port   string
	router *http.ServeMux
}
