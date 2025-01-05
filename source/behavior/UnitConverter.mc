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

}

