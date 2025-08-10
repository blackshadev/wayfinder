package server

import (
	"net/http"

	"wayfinder.littledev.nl/server/devicerepository"
)

type Server struct {
	port    string
	router  *http.ServeMux
	devices devicerepository.DeviceRepositoryInterface
}
