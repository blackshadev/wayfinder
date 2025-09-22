import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;

class UnitConverter {
    const YARDS_IN_METER = 1.0936133;
    const METERS_IN_KILOMETER = 1000.0;
    const METERS_IN_MILES = 1609.344;

    const KNOTS_IN_MS = 1.94384449;
    const MPH_IN_MS = 2.23693629;
    const KMH_IN_MS = 3.6;

    public function speedFromMS(ms as Float?, target as SettingsControllerInterface.SpeedUnit) as Float? {
        if (ms == null) {
            return null;
        }

        switch (target) {
            case SettingsControllerInterface.SPEED_KMH:
                return ms * KMH_IN_MS;
            case SettingsControllerInterface.SPEED_MS:
                return ms;
            case SettingsControllerInterface.SPEED_MPH:
                return ms * MPH_IN_MS;
            case SettingsControllerInterface.SPEED_KNOTS:
                return ms * KNOTS_IN_MS;
        }

        throw new NotImplemented();
    }

    public function distanceFromMeters(meters as Float?, target as SettingsControllerInterface.DistanceUnit) as Float? {
        if (meters == null) {
            return null;
        }

        switch (target) {
            case SettingsControllerInterface.DISTANCE_METERS:
                return meters / METERS_IN_KILOMETER;
            case SettingsControllerInterface.DISTANCE_MILES:
                return meters / METERS_IN_MILES;
        }

        throw new NotImplemented();
    }

    public function smallDistanceFromMeters(meters as Float?, target as SettingsControllerInterface.DistanceUnit) as Float? {
        if (meters == null) {
            return null;
        }

        switch (target) {
            case SettingsControllerInterface.DISTANCE_METERS:
                return meters;
            case SettingsControllerInterface.DISTANCE_MILES:
                return meters / YARDS_IN_METER;
        }

        throw new NotImplemented();
    }
}

