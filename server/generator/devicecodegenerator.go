package generator

import (
	"math/rand"

	"wayfinder.littledev.nl/server/model"
)

type DeviceCodeGenerator struct{}

const device_code_alphabeth = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
const device_code_length = 4

var alphabeth_size = len(device_code_alphabeth)

func (dcg *DeviceCodeGenerator) Generate() model.DeviceCode {
	code := make([]byte, device_code_length)

	for i := range code {
		number := rand.Intn(alphabeth_size)
		code[i] = device_code_alphabeth[number]
	}

	return model.DeviceCode(code)
}
