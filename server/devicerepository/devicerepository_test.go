package devicerepository_test

import (
	"testing"
	"time"

	"wayfinder.littledev.nl/server/devicerepository"
	"wayfinder.littledev.nl/server/generator"
	"wayfinder.littledev.nl/server/model"
	"wayfinder.littledev.nl/server/storage"

	"github.com/stretchr/testify/assert"
)

func TestNew(t *testing.T) {
	codegenerator := &generator.FakeGenerator{}
	repo := &devicerepository.DeviceRepository{
		Storage:   storage.CreateInternalStorage[model.DeviceCode, *model.DeviceInstance](),
		Generator: codegenerator,
	}

	expectedCode := model.DeviceCode("1234")
	codegenerator.SetReturnValue(expectedCode)
	device, _ := repo.New()

	assert.Equal(t, expectedCode, device.Code, "Device code should be equal")
	assert.False(t, device.Filled, "New Device should be not be filled")
	assert.Empty(t, device.Waypoints, "New device should have empty waypoints")
}

func TestNewErrorsAfterTooManyRetries(t *testing.T) {
	codegenerator := &generator.FakeGenerator{}
	repo := &devicerepository.DeviceRepository{
		Storage:   storage.CreateInternalStorage[model.DeviceCode, *model.DeviceInstance](),
		Generator: codegenerator,
	}

	expectedCode := model.DeviceCode("1234")
	codegenerator.SetReturnValue(expectedCode)
	repo.New()
	_, err := repo.New()

	assert.NotNil(t, err)
}

func TestNewShouldGenerateUntilUniqueCodeFound(t *testing.T) {
	codegenerator := &generator.FakeGenerator{}
	repo := &devicerepository.DeviceRepository{
		Storage:   storage.CreateInternalStorage[model.DeviceCode, *model.DeviceInstance](),
		Generator: codegenerator,
	}

	expectedCode1 := model.DeviceCode("1234")
	expectedCode2 := model.DeviceCode("4444")
	expectedCode3 := model.DeviceCode("6666")

	codegenerator.SetReturnValues([]model.DeviceCode{
		expectedCode1,
		expectedCode1,
		expectedCode1,
		expectedCode2,
		expectedCode1,
		expectedCode1,
		expectedCode1,
		expectedCode3,
	})
	device1, _ := repo.New()
	device2, _ := repo.New()
	device3, _ := repo.New()

	assert.Equal(t, expectedCode1, device1.Code)
	assert.Equal(t, expectedCode2, device2.Code)
	assert.Equal(t, expectedCode3, device3.Code)
}

func TestFill(t *testing.T) {
	codegenerator := &generator.FakeGenerator{}
	devices := storage.CreateInternalStorage[model.DeviceCode, *model.DeviceInstance]()
	repo := &devicerepository.DeviceRepository{
		Storage:   devices,
		Generator: codegenerator,
	}

	code := model.DeviceCode("1234")
	device := &model.DeviceInstance{
		Code:      code,
		Waypoints: []model.Waypoint{},
		Filled:    false,
		CreatedAt: time.Now(),
	}

	devices.Set(code, device)

	newWaypoints := []model.Waypoint{
		{Latitide: 52.31485032979573, Longitude: 5.162200927734376},
		{Latitide: 52.31306532681562, Longitude: 5.201854705810548},
		{Latitide: 52.33427070823140, Longitude: 5.206317901611328},
	}

	ok := repo.Fill(code, newWaypoints)

	assert.True(t, ok)

	assert.True(t, device.Filled)
	assert.Equal(t, device.Waypoints, newWaypoints)
}

func TestFillFailsOnAlreadyFilled(t *testing.T) {
	codegenerator := &generator.FakeGenerator{}
	devices := storage.CreateInternalStorage[model.DeviceCode, *model.DeviceInstance]()
	repo := &devicerepository.DeviceRepository{
		Storage:   devices,
		Generator: codegenerator,
	}

	code := model.DeviceCode("1234")
	device := &model.DeviceInstance{
		Code:      code,
		Waypoints: []model.Waypoint{},
		Filled:    true,
		CreatedAt: time.Now(),
	}
	devices.Set(code, device)

	ok := repo.Fill(code, []model.Waypoint{})

	assert.False(t, ok)
}

func TestFillFailsOnUnknownCode(t *testing.T) {
	codegenerator := &generator.FakeGenerator{}
	devices := storage.CreateInternalStorage[model.DeviceCode, *model.DeviceInstance]()
	repo := &devicerepository.DeviceRepository{
		Storage:   devices,
		Generator: codegenerator,
	}

	code := model.DeviceCode("1234")

	ok := repo.Fill(code, []model.Waypoint{})

	assert.False(t, ok)
}

func TestGetWaypoints(t *testing.T) {
	codegenerator := &generator.FakeGenerator{}
	devices := storage.CreateInternalStorage[model.DeviceCode, *model.DeviceInstance]()
	repo := &devicerepository.DeviceRepository{
		Storage:   devices,
		Generator: codegenerator,
	}

	code := model.DeviceCode("1234")
	newWaypoints := []model.Waypoint{
		{Latitide: 52.31485032979573, Longitude: 5.162200927734376},
		{Latitide: 52.31306532681562, Longitude: 5.201854705810548},
		{Latitide: 52.33427070823140, Longitude: 5.206317901611328},
	}

	device := &model.DeviceInstance{
		Code:      code,
		Waypoints: newWaypoints,
		Filled:    true,
		CreatedAt: time.Now(),
	}
	devices.Set(code, device)

	waypoints, ok := repo.GetWaypoints(code)

	assert.True(t, ok)
	assert.Equal(t, newWaypoints, waypoints)
}

func TestGetWaypointsFailsForNotFilledDevices(t *testing.T) {
	codegenerator := &generator.FakeGenerator{}
	devices := storage.CreateInternalStorage[model.DeviceCode, *model.DeviceInstance]()
	repo := &devicerepository.DeviceRepository{
		Storage:   devices,
		Generator: codegenerator,
	}

	code := model.DeviceCode("1234")
	newWaypoints := []model.Waypoint{
		{Latitide: 52.31485032979573, Longitude: 5.162200927734376},
		{Latitide: 52.31306532681562, Longitude: 5.201854705810548},
		{Latitide: 52.33427070823140, Longitude: 5.206317901611328},
	}

	device := &model.DeviceInstance{
		Code:      code,
		Waypoints: newWaypoints,
		Filled:    false,
		CreatedAt: time.Now(),
	}
	devices.Set(code, device)

	waypoints, ok := repo.GetWaypoints(code)

	assert.False(t, ok)
	assert.Equal(t, []model.Waypoint{}, waypoints)
}

func TestCleanup(t *testing.T) {

	fakeDevices := []*model.DeviceInstance{
		{
			Code:      "0001",
			Waypoints: []model.Waypoint{},
			Filled:    false,
			CreatedAt: time.Now().Add(-time.Hour).Add(-time.Second),
		},
		{
			Code:      "0002",
			Waypoints: []model.Waypoint{},
			Filled:    false,
			CreatedAt: time.Now().Add(-time.Minute),
		},
		{
			Code:      "0003",
			Waypoints: []model.Waypoint{},
			Filled:    false,
			CreatedAt: time.Now().Add(24 * -time.Hour),
		},
		{
			Code:      "0004",
			Waypoints: []model.Waypoint{},
			Filled:    false,
			CreatedAt: time.Now().Add(30 * -time.Minute),
		},
		{
			Code:      "0005",
			Waypoints: []model.Waypoint{},
			Filled:    false,
			CreatedAt: time.Now().Add(66 * -time.Minute),
		},
		{
			Code:      "0006",
			Waypoints: []model.Waypoint{},
			Filled:    false,
			CreatedAt: time.Now(),
		},
	}

	storage := storage.CreateInternalStorage[model.DeviceCode, *model.DeviceInstance]()

	for _, device := range fakeDevices {
		storage.Set(device.Code, device)
	}

	repo := &devicerepository.DeviceRepository{
		Storage:   storage,
		Generator: &generator.DeviceCodeGenerator{},
	}

	repo.Cleanup()

	assert.Len(t, repo.Storage.Values(), 3)
	assert.True(t, repo.Storage.Has(model.DeviceCode("0004")))
	assert.True(t, repo.Storage.Has(model.DeviceCode("0002")))
	assert.True(t, repo.Storage.Has(model.DeviceCode("0006")))

	assert.False(t, repo.Storage.Has(model.DeviceCode("0001")))
	assert.False(t, repo.Storage.Has(model.DeviceCode("0003")))
	assert.False(t, repo.Storage.Has(model.DeviceCode("0005")))

}
