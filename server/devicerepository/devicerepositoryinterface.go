package devicerepository

import "wayfinder.littledev.nl/server/model"

type DeviceRepositoryInterface interface {
	New() (*model.DeviceInstance, error)
	Cleanup()
	Count() int
	Fill(code model.DeviceCode, waypoints []model.Waypoint) bool
	Get(code model.DeviceCode) (*model.DeviceInstance, bool)
}
