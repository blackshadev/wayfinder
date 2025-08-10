package server

import (
	"net/http"
)

func (s *Server) emptyHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(503)
	w.Write([]byte("Under construction"))
}
