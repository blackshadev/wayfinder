package devicerepository

import (
	"time"

	"wayfinder.littledev.nl/server/generator"
	"wayfinder.littledev.nl/server/model"
	"wayfinder.littledev.nl/server/storage"
)

type DeviceRepository struct {
	Storage   storage.Storage[model.DeviceCode, *model.DeviceInstance]
	Generator generator.Generator[model.DeviceCode]
}

func (ds *DeviceRepository) New() *model.DeviceInstance {
	code := ds.Generator.Generate()

	device := &model.DeviceInstance{
		Code:      code,
		Waypoints: []model.Waypoint{},
		Filled:    false,
		CreatedAt: time.Now(),
	}

	ds.Storage.Set(code, device)

	return device
}

func (ds *DeviceRepository) Fill(code model.DeviceCode, waypoints []model.Waypoint) bool {
	if device, ok := ds.Storage.Get(code); ok {
		device.Waypoints = waypoints
		device.Filled = true
		return true
	}

	return false
}

func (ds *DeviceRepository) GetWaypoints(code model.DeviceCode) ([]model.Waypoint, bool) {
	if device, ok := ds.Storage.Get(code); ok {
		return device.Waypoints, true
	}

	return []model.Waypoint{}, false
}
