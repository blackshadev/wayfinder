import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;

class UnitConverter {
    public function speedFromMS(ms as Float?, target as SettingsControllerInterface.SpeedUnit) as Float? {
        if (ms == null) {
            return null;
        }

        switch (target) {
            case SettingsControllerInterface.SPEED_KMH:
                return ms * 3.6;
            case SettingsControllerInterface.SPEED_MS:
                return ms;
            case SettingsControllerInterface.SPEED_MPH:
                return ms * 2.23693629;
            case SettingsControllerInterface.SPEED_KNOTS:
                return ms * 1.94384449;
        }

        throw new NotImplemented();
    }

    public function distanceFromMeters(meters as Float?, target as SettingsControllerInterface.DistanceUnit) as Float? {
        if (meters == null) {
            return null;
        }

        switch (target) {
            case SettingsControllerInterface.DISTANCE_METERS:
                return meters / 1000;
            case SettingsControllerInterface.DISTANCE_MILES:
                return meters * 0.000621371192;
        }

        throw new NotImplemented();
    }
}

