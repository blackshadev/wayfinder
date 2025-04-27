import Toybox.Lang;

(:debug)
class SettingsControllerFake extends SettingsControllerInterface {
    private var _distance as SettingsControllerInterface.DistanceUnit;
    private var _unitsSpeed as SettingsControllerInterface.SpeedUnit;

    function initialize(
        distance as SettingsControllerInterface.DistanceUnit,
        unitsSpeed as SettingsControllerInterface.SpeedUnit
    ) {
        SettingsControllerInterface.initialize();

        self._distance = distance;
        self._unitsSpeed = unitsSpeed;
    }

    public function distance() as SettingsControllerInterface.DistanceUnit {
        return self._distance;
    }

    public function unitsSpeed() as SettingsControllerInterface.SpeedUnit {
        return self._unitsSpeed;
    }
}