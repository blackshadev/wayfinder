package model

import (
	"strings"
	"time"
)

type DeviceCode string

func CreateDeviceCode(code string) DeviceCode {
	return DeviceCode(strings.ToUpper(code))
}

type DeviceInstance struct {
	Code      DeviceCode
	Waypoints []Waypoint
	Filled    bool
	CreatedAt time.Time
}
