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

func TestNewDeviceHandler(t *testing.T) {

	server := CreateServer("", 5*time.Minute)
	request := httptest.NewRequest("POST", "/", nil)
	response := httptest.NewRecorder()

	server.newDeviceHandler(response, request)

	assert.Equal(t, http.StatusCreated, response.Result().StatusCode)

	var responseBody newDeviceResponse
	json.NewDecoder(response.Result().Body).Decode(&responseBody)

	device, ok := server.devices.Get(model.DeviceCode(responseBody.Code))
	assert.True(t, ok)
	assert.Len(t, device.Waypoints, 0)
	assert.False(t, device.Filled)
}
