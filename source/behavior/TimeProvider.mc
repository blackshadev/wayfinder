import Toybox.WatchUi;
import Toybox.Lang;

class TimeProvider {
    private var is24Hour = true;

    public function initialize() {
        updateSettings();
    }

    public function updateSettings() as Void {
        self.is24Hour = System.getDeviceSettings().is24Hour;
    }

    public function getText(format as String) as String {
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;

        if (!self.is24Hour && hours > 12) {
            hours = hours - 12;
        }

        return Lang.format(format, [hours, clockTime.min.format("%02d")]);
    }
}