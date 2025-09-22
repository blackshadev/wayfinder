package server

import (
	"log"
)

func (server *Server) initScheduler() {
	server.scheduler.SetFunction(func() {
		oldSize := server.devices.Count()
		server.devices.Cleanup()
		newSize := server.devices.Count()
		log.Printf("Removed %d devices during cleanup. %d devices remaining\n", oldSize-newSize, newSize)
	})
}
