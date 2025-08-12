package server

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestFillDeviceHandlerReturns400OnInvalidData(t *testing.T) {
	t.Run("Invalid json", func(t *testing.T) {
		request := httptest.NewRequest("POST", "/", strings.NewReader(`{"waypoints":[{"latitude":}]}`))
		request.SetPathValue("code", "1234")
		response := httptest.NewRecorder()

		server := CreateServer("")
		server.fillDeviceHandler(response, request)

		assert.Equal(t, http.StatusBadRequest, response.Result().StatusCode)
	})

	t.Run("Missing path parameter", func(t *testing.T) {

		request := httptest.NewRequest("POST", "/", strings.NewReader(`{"waypoints":[]}`))
		response := httptest.NewRecorder()

		server := CreateServer("")
		server.fillDeviceHandler(response, request)

		assert.Equal(t, http.StatusBadRequest, response.Result().StatusCode)
	})
}

func TestFillDeviceHandlerForNonExistingDevice(t *testing.T) {

	server := CreateServer("")
	server.devices.New()

	request := httptest.NewRequest("POST", "/", strings.NewReader(`{"waypoints":[{"latitude":12,"longitude":21}]}`))
	request.SetPathValue("code", "1234")
	response := httptest.NewRecorder()

	server.fillDeviceHandler(response, request)

	assert.Equal(t, http.StatusNotFound, response.Result().StatusCode)
}

func TestFillDeviceHandler(t *testing.T) {

	server := CreateServer("")
	device, _ := server.devices.New()

	request := httptest.NewRequest("POST", "/", strings.NewReader(`{"waypoints":[{"latitude":12,"longitude":21}]}`))
	request.SetPathValue("code", string(device.Code))
	response := httptest.NewRecorder()

	server.fillDeviceHandler(response, request)

	assert.Len(t, device.Waypoints, 1)
	assert.Equal(t, 12., device.Waypoints[0].Latitide)
	assert.Equal(t, 21., device.Waypoints[0].Longitude)

	assert.Equal(t, http.StatusCreated, response.Result().StatusCode)
}
