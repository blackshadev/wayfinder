package server

import (
	"encoding/json"
	"log"
	"net/http"
	"text/template"
)

func (s *Server) ServeTemplate(w http.ResponseWriter, view string, data any) {
	templates := template.Must(template.ParseFiles("views/_layout.html", "views/"+view))
	err := templates.ExecuteTemplate(w, view, data)
	if err != nil {
		log.Fatalln(err)
	}
}

type apiError struct {
	Error string `json:"error"`
}

func (s *Server) SendJsonError(w http.ResponseWriter, statuscode int, err error) {
	s.SendJsonResponse(w, statuscode, apiError{
		Error: err.Error(),
	})
}

func (s *Server) SendJsonResponse(w http.ResponseWriter, statuscode int, data any) {
	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(statuscode)
	json.NewEncoder(w).Encode(data)
}
