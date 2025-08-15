package server

import "net/http"

func (server *Server) initRoutes() {
	server.router.Handle("GET /public/", http.StripPrefix("/public", http.FileServer(http.Dir("./public/"))))
	server.router.HandleFunc("GET /", server.indexHandler)
	server.router.HandleFunc("GET /{code}/", server.mapHandler)
	server.router.HandleFunc("POST /api/device/", server.newDeviceHandler)
	server.router.HandleFunc("POST /api/device/{code}/", server.fillDeviceHandler)
	server.router.HandleFunc("GET /api/device/{code}/", server.getDeviceWaypointsHandler)
}
