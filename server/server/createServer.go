package server

import (
	"encoding/json"
	"html/template"
	"log"
	"net/http"

	"wayfinder.littledev.nl/server/devicerepository"
	"wayfinder.littledev.nl/server/generator"
	"wayfinder.littledev.nl/server/model"
	"wayfinder.littledev.nl/server/storage"
)

func CreateServer(port string) *Server {

	router := http.NewServeMux()

	server := &Server{
		port:   port,
		router: router,
		devices: &devicerepository.DeviceRepository{
			Storage:   storage.CreateInternalStorage[model.DeviceCode, *model.DeviceInstance](),
			Generator: &generator.DeviceCodeGenerator{},
		},
	}

	server.router.Handle("GET /public/", http.StripPrefix("/public", http.FileServer(http.Dir("./public/"))))
	server.router.HandleFunc("GET /", server.indexHandler)
	server.router.HandleFunc("GET /{code}/", server.mapHandler)
	server.router.HandleFunc("POST /api/device/", server.newDeviceHandler)
	server.router.HandleFunc("POST /api/device/{code}/", server.fillDeviceHandler)
	server.router.HandleFunc("GET /api/device/{code}/", server.getDeviceWaypointsHandler)

	return server
}

func (s *Server) Start() {
	http.ListenAndServe(s.port, s.router)
}

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
