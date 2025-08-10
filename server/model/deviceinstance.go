package model

import (
	"time"
)

type DeviceCode string

type DeviceInstance struct {
	Code      DeviceCode
	Waypoints []Waypoint
	Filled    bool
	CreatedAt time.Time
}
