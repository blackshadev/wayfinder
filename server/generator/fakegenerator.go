package generator

import (
	"wayfinder.littledev.nl/server/model"
)

type FakeGenerator struct {
	Code    []model.DeviceCode
	Current int
}

func (fake *FakeGenerator) SetReturnValue(code model.DeviceCode) {
	fake.Code = []model.DeviceCode{code}
	fake.Current = 0
}

func (fake *FakeGenerator) SetReturnValues(codes []model.DeviceCode) {
	fake.Code = codes
	fake.Current = 0
}

func (fake *FakeGenerator) Generate() model.DeviceCode {

	code := fake.Code[fake.Current]

	if fake.Current+1 < len(fake.Code) {
		fake.Current += 1
	}

	return code
}
