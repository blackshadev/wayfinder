package server

import (
	"errors"
	"log"
	"net/http"
	"time"

	"wayfinder.littledev.nl/server/devicerepository"
	"wayfinder.littledev.nl/server/generator"
	"wayfinder.littledev.nl/server/model"
	"wayfinder.littledev.nl/server/scheduler"
	"wayfinder.littledev.nl/server/storage"
)

func CreateServer(addr string, duration time.Duration) *Server {

	router := http.NewServeMux()

	server := &Server{

		server: &http.Server{
			Addr:    addr,
			Handler: router,
		},
		router: router,
		devices: &devicerepository.DeviceRepository{
			Storage:   storage.CreateInternalStorage[model.DeviceCode, *model.DeviceInstance](),
			Generator: &generator.DeviceCodeGenerator{},
		},
		scheduler: scheduler.Create(duration, nil),
	}

	server.initRoutes()
	server.initScheduler()

	go server.handleSignal()

	return server
}

func (s *Server) Start() {
	s.scheduler.Start()
	if err := s.server.ListenAndServe(); !errors.Is(err, http.ErrServerClosed) {
		log.Printf("HTTP server error: %v\n", err)
	}
}

func (s *Server) Stop() {
	log.Println("Stopping...")

	s.scheduler.Stop()
	if err := s.server.Close(); err != nil {
		log.Printf("HTTP close failed: %v\n", err)
	}
}
