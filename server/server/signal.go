package server

import (
	"os"
	"os/signal"
	"syscall"
)

func (s *Server) handleSignal() {
	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, syscall.SIGINT, syscall.SIGTERM)
	<-sigChan

	s.Stop()
}
