package server

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"

	"github.com/stretchr/testify/assert"
	"wayfinder.littledev.nl/server/model"
)

func TestGetDeviceWaypointsHandlerNotFoundForNonExistingDevice(t *testing.T) {
	server := CreateServer("", 5*time.Minute)
	request := httptest.NewRequest("POST", "/", nil)
	request.SetPathValue("code", "1234")
	response := httptest.NewRecorder()

	server.getDeviceWaypointsHandler(response, request)

	assert.Equal(t, http.StatusNotFound, response.Result().StatusCode)
}

func TestGetDeviceWaypointsHandlerNotFoundForNotFilledDevice(t *testing.T) {
	server := CreateServer("", 5*time.Minute)
	device, _ := server.devices.New()

	request := httptest.NewRequest("POST", "/", nil)
	request.SetPathValue("code", string(device.Code))
	response := httptest.NewRecorder()

	server.getDeviceWaypointsHandler(response, request)

	assert.Equal(t, http.StatusNotFound, response.Result().StatusCode)
}

func TestGetDeviceWaypointsHandlerInvalidData(t *testing.T) {
	server := CreateServer("", 5*time.Minute)
	request := httptest.NewRequest("POST", "/", nil)
	response := httptest.NewRecorder()

	server.getDeviceWaypointsHandler(response, request)

	assert.Equal(t, http.StatusBadRequest, response.Result().StatusCode)
}

func TestGetDeviceWaypointsHandler(t *testing.T) {
	server := CreateServer("", 5*time.Minute)
	device, _ := server.devices.New()
	server.devices.Fill(device.Code, []model.Waypoint{
		{
			Latitide:  21.,
			Longitude: 12.,
		},
	})

	request := httptest.NewRequest("POST", "/", nil)
	request.SetPathValue("code", string(device.Code))
	response := httptest.NewRecorder()

	server.getDeviceWaypointsHandler(response, request)

	assert.Equal(t, http.StatusOK, response.Result().StatusCode)

	var responseData waypointDeviceResponse
	json.NewDecoder(response.Result().Body).Decode(&responseData)

	assert.Equal(t, waypointDeviceResponse{
		Waypoints: []deviceWaypoint{
			{
				Latitude:  21.,
				Longitude: 12.,
			},
		},
	}, responseData)
}
