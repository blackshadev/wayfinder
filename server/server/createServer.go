package server

import (
	"html/template"
	"log"
	"net/http"
)

func CreateServer(port string) *Server {

	router := http.NewServeMux()

	server := &Server{
		port:   port,
		router: router,
	}

	server.router.Handle("GET /public/", http.StripPrefix("/public", http.FileServer(http.Dir("./public/"))))
	server.router.HandleFunc("GET /{code}", server.deviceCodeHandler)
	server.router.HandleFunc("GET /", server.indexHandler)

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
