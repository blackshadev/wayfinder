package server

import (
	"encoding/json"
	"net/http"
)

type fillDeviceWaypoint struct {
	Latitude  float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
}

type fillDeviceRequest struct {
	Code      string               `json:"code"`
	Waypoints []fillDeviceWaypoint `json:"waypoints"`
}

func (s *Server) fillDeviceHandler(w http.ResponseWriter, r *http.Request) {
	var fillDeviceData fillDeviceRequest
	err := json.NewDecoder(r.Body).Decode(&fillDeviceData)

	if err != nil {
		s.SendApiError(w, 400, err)
		return
	}

	w.WriteHeader(http.StatusAccepted)
}
