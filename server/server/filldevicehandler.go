package server

import (
	"encoding/json"
	"errors"
	"net/http"

	"wayfinder.littledev.nl/server/model"
)

type deviceWaypoint struct {
	Latitude  float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
}

type fillDeviceRequest struct {
	Waypoints []deviceWaypoint `json:"waypoints"`
}

func (s *Server) fillDeviceHandler(w http.ResponseWriter, r *http.Request) {
	code := r.PathValue("code")
	if code == "" {
		s.SendJsonError(w, http.StatusBadRequest, errors.New("Missing path parameter code"))
		return
	}

	var fillDeviceData fillDeviceRequest
	err := json.NewDecoder(r.Body).Decode(&fillDeviceData)

	if err != nil {
		s.SendJsonError(w, http.StatusBadRequest, err)
		return
	}

	waypoints := make([]model.Waypoint, 0, len(fillDeviceData.Waypoints))
	for _, waypoint := range fillDeviceData.Waypoints {
		waypoints = append(waypoints, model.Waypoint{
			Latitide:  waypoint.Latitude,
			Longitude: waypoint.Longitude,
		})
	}

	found := s.devices.Fill(model.CreateDeviceCode(code), waypoints)

	if !found {
		w.WriteHeader(http.StatusNotFound)
		return
	}

	w.WriteHeader(http.StatusCreated)
}
