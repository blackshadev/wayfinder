package devicerepository

import "wayfinder.littledev.nl/server/model"

type DeviceRepositoryInterface interface {
	New() (*model.DeviceInstance, error)
	Fill(code model.DeviceCode, waypoints []model.Waypoint) bool
	GetWaypoints(code model.DeviceCode) ([]model.Waypoint, bool)
	Get(code model.DeviceCode) (*model.DeviceInstance, bool)
}
