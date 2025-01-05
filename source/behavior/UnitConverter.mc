import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;

class UnitConverter {
    private var _settings as SettingsController;
    
    function initialize(settings as SettingsController) {
        self._settings = settings;
    }

    function speedFromMS(ms as Float?) as Float? {
        if (ms == null) {
            return null;
        }

        switch (self._settings.unitsSpeed()) {
            case SettingsController.UNITS_SPEED_KMH:
                return ms * 3.6;
            case SettingsController.UNITS_SPEED_MS:
                return ms;
            case SettingsController.UNITS_SPEED_MPH:
                return ms * 2.23693629;
        }

        throw new NotImplemented();
    }

    function distanceFromMeters(meters as Float?) as Float? {
        if (meters == null) {
            return null;
        }

        switch (self._settings.distance()) {
            case SettingsController.UNITS_DISTANCE_METERS:
                return meters / 1000;
            case SettingsController.UNITS_DISTANCE_MILES:
                return meters * 0.000621371192;
        }

        throw new NotImplemented();
    }

}

