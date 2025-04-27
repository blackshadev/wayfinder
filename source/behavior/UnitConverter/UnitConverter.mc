import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;

class UnitConverter extends UnitConverterInterface {
    private var _settings as SettingsControllerInterface;
    
    function initialize(settings as SettingsControllerInterface) {
        UnitConverterInterface.initialize();

        self._settings = settings;
    }

    function speedFromMS(ms as Float?) as Float? {
        if (ms == null) {
            return null;
        }

        switch (self._settings.unitsSpeed()) {
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

    function distanceFromMeters(meters as Float?) as Float? {
        if (meters == null) {
            return null;
        }

        switch (self._settings.distance()) {
            case SettingsControllerInterface.DISTANCE_METERS:
                return meters / 1000;
            case SettingsControllerInterface.DISTANCE_MILES:
                return meters * 0.000621371192;
        }

        throw new NotImplemented();
    }

}

