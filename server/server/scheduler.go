package server

import (
	"log"
	"time"

	"wayfinder.littledev.nl/server/scheduler"
)

func (server *Server) initScheduler() {
	server.scheduler = scheduler.Create(10*time.Second, func() {
		log.Println("Running cleanup...")
		server.devices.Cleanup()
	})
}
