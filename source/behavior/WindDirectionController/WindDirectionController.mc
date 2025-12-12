import Toybox.Lang;
import Toybox.Application;
import Toybox.Time;

class WindDirectionController extends WindDirectionControllerInterface {
    private var windDirection as Number?;

    private var weather as WeatherProviderInterface;
    private var sensor as SensorProviderInterface;

    function initialize(
        sensor as SensorProviderInterface,
        weather as WeatherProviderInterface
    ) {
        WindDirectionControllerInterface.initialize();

        self.weather = weather;
        self.sensor = sensor;
        self.setWindDirectionFromStorage();
    }

    public function getWindDirection() as Number? {
        return self.windDirection;
    }

    public function getRelativeWindDirection() as Number? {
        if (self.windDirection == null) {
            return null;
        }
        
        return Utils.Angles.subtract(self.windDirection, self.sensor.heading());
    }

    private function setWindDirectionFromStorage() as Void {
        var setAt = Application.Properties.getValue("windDirectionSetAt") as Number?;
        var value = Application.Properties.getValue("windDirection");

        var twoHours = new Time.Duration(2 * 60 * 60);
        var twoHoursAgo = Time.now().subtract(twoHours);
        if (value == null || setAt == null || twoHoursAgo.value() > setAt) {
            self.windDirection = self.weather.getWindDirection();
            return;
        }
        self.windDirection = value as Number;
    }

    public function shouldShow() as Boolean {
        return self.windDirection != null;
    }

    public function setForecastWindDirection() as Void {
        self.setWindDirection(self.weather.getWindDirection());
    }

    public function setWindDirection(dir as Number?) as Void {
        var time = dir != null ? Time.now().value() : null;

        Application.Properties.setValue("windDirection", dir);
        Application.Properties.setValue("windDirectionSetAt", time);
        
        self.windDirection = dir;
    }

    public function unsetWindDirection() as Void {
        self.setWindDirection(null);
    }

    public function flipWindDirection() as Void {
        if (self.windDirection != null) {
            self.setWindDirection((self.windDirection + 180) % 360);
        }
    }

    public function setWindToCurrentDirection() as Void {
        self.setWindDirection(self.sensor.heading());
    }

    public function setWindAwayFromCurrentDirection() as Void {
        self.setWindDirection((self.sensor.heading() + 180) % 360);
    }
}
