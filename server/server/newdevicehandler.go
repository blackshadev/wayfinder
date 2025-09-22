package server

import (
	"encoding/json"
	"net/http"
)

type newDeviceResponse struct {
	Code string `json:"code"`
}

func (s *Server) newDeviceHandler(w http.ResponseWriter, r *http.Request) {
	device, err := s.devices.New()

	if err != nil {
		s.SendJsonError(w, 500, err)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(newDeviceResponse{
		Code: string(device.Code),
	})
}
