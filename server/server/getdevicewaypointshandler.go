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

	waypoints, ok := s.devices.GetWaypoints(model.DeviceCode(code))

	if !ok {
		w.WriteHeader(http.StatusNotFound)
		return
	}

	responseWaypoints := make([]deviceWaypoint, 0, len(waypoints))
	for _, waypoint := range waypoints {
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
