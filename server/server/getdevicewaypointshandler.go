package server

import (
	"encoding/json"
	"errors"
	"net/http"

	"wayfinder.littledev.nl/server/model"
)

type waypointDeviceResponse struct {
	Waypoints []deviceWaypoint `json:"waypoints"`
}

func (s *Server) getDeviceWaypointsHandler(w http.ResponseWriter, r *http.Request) {
	code := r.PathValue("code")
	if code == "" {
		s.SendJsonError(w, http.StatusBadRequest, errors.New("code path value most be supplied"))
		return
	}

	device, ok := s.devices.Get(model.CreateDeviceCode(code))

	if !ok || !device.Filled {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusNotFound)
		json.NewEncoder(w).Encode(waypointDeviceResponse{
			Waypoints: []deviceWaypoint{},
		})
		return
	}

	responseWaypoints := make([]deviceWaypoint, 0, len(device.Waypoints))
	for _, waypoint := range device.Waypoints {
		responseWaypoints = append(responseWaypoints, deviceWaypoint{
			Latitude:  waypoint.Latitide,
			Longitude: waypoint.Longitude,
		})
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(waypointDeviceResponse{
		Waypoints: responseWaypoints,
	})
}
