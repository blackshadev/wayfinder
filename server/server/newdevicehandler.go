package server

import (
	"encoding/json"
	"net/http"
)

type newDeviceResponse struct {
	Code string `json:"code"`
}

func (s *Server) newDeviceHandler(w http.ResponseWriter, r *http.Request) {
	device := s.devices.New()

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(newDeviceResponse{
		Code: string(device.Code),
	})
}
