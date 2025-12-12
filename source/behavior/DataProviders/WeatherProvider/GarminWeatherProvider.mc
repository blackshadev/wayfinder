import Toybox.Weather;
import Toybox.Lang;
import Toybox.Time;

class GarminWeatherProvider extends WeatherProviderInterface {
    public function initialize() {
        WeatherProviderInterface.initialize();
    }

     public function getWindDirection() as Number? {
        var current = Weather.getCurrentConditions();
        if (current == null) {
            return null;
        }

        return current.windBearing;
    }
}