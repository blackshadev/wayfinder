package server

import (
	"net/http"
)

type IndexData struct {
	Error string
}

func (s *Server) indexHandler(w http.ResponseWriter, r *http.Request) {
	s.ServeTemplate(w, "index.html", IndexData{
		Error: r.URL.Query().Get("error"),
	})
}
