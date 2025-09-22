package server

import (
	"net/http"

	"wayfinder.littledev.nl/server/devicerepository"
	"wayfinder.littledev.nl/server/scheduler"
)

type Server struct {
	server    *http.Server
	router    *http.ServeMux
	scheduler *scheduler.Scheduler
	devices   devicerepository.DeviceRepositoryInterface
}
