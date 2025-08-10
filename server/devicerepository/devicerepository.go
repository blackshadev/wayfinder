package devicerepository

import (
	"fmt"
	"time"

	"wayfinder.littledev.nl/server/generator"
	"wayfinder.littledev.nl/server/model"
	"wayfinder.littledev.nl/server/storage"
)

type DeviceRepository struct {
	Storage   storage.Storage[model.DeviceCode, *model.DeviceInstance]
	Generator generator.Generator[model.DeviceCode]
}

const max_tries = 20

func (ds *DeviceRepository) getUniqueDeviceCode() (model.DeviceCode, error) {
	var code model.DeviceCode
	tries := 0
	for {
		code = ds.Generator.Generate()
		if tries += 1; !ds.Storage.Has(code) {
			break
		}

		if tries > max_tries {
			return model.DeviceCode(""), fmt.Errorf("unable to generate unique device code, to many tries")
		}
	}

	return code, nil
}

func (ds *DeviceRepository) New() (*model.DeviceInstance, error) {
	code, err := ds.getUniqueDeviceCode()

	if err != nil {
		return nil, err
	}

	device := &model.DeviceInstance{
		Code:      code,
		Waypoints: []model.Waypoint{},
		Filled:    false,
		CreatedAt: time.Now(),
	}

	ds.Storage.Set(code, device)

	return device, nil
}

func (ds *DeviceRepository) Fill(code model.DeviceCode, waypoints []model.Waypoint) bool {
	if device, ok := ds.Storage.Get(code); ok && !device.Filled {
		device.Waypoints = waypoints
		device.Filled = true
		return true
	}

	return false
}

func (ds *DeviceRepository) GetWaypoints(code model.DeviceCode) ([]model.Waypoint, bool) {
	if device, ok := ds.Storage.Get(code); ok && device.Filled {
		return device.Waypoints, true
	}

	return []model.Waypoint{}, false
}
