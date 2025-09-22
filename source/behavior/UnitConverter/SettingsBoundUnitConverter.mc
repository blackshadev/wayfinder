import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;

class SettingsBoundUnitConverter extends BoundUnitConverterInterface {
    private var _settings as SettingsControllerInterface;
    private var _converter as UnitConverter;
    
    function initialize(settings as SettingsControllerInterface) {
        BoundUnitConverterInterface.initialize();

        self._settings = settings;
        self._converter = new UnitConverter();
    }

    public function speedFromMS(ms as Float?) as Float? {
        return self._converter.speedFromMS(ms, self._settings.unitsSpeed());
    }

    public function distanceFromMeters(meters as Float?) as Float? {
        return self._converter.distanceFromMeters(meters, self._settings.distance());
    }
    
    public function smallDistanceFromMeters(meters as Float?) as Float? {
        return self._converter.smallDistanceFromMeters(meters, self._settings.distance());
    }
}

