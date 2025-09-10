package main

import (
	"fmt"
	"os"
	"time"

	srv "wayfinder.littledev.nl/server/server"
)

func main() {
	port := getPort()
	cleanupInterval := getCleanupInterval()

	s := srv.CreateServer(":"+port, cleanupInterval)

	fmt.Println("Server running on port " + port)
	s.Start()
}

func getPort() string {
	if port := os.Getenv("PORT"); port != "" {
		return port
	}

	return "8080"
}

func getCleanupInterval() time.Duration {
	if duration := os.Getenv("CLEANUP_INTERVAL"); duration != "" {
		d, err := time.ParseDuration(duration)
		if err == nil {
			return d
		}

		fmt.Println("Invalid CLEANUP_INTERVAL, using default of 30m")
	}

	return 30 * time.Minute
}
