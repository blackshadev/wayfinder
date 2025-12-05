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
        
        var time = current.observationTime;
        if (time != null) {
           var info = Gregorian.info(time, Time.FORMAT_LONG);
           System.println("Weather observation time: " +  Lang.format("$1$-$2$-$3$ $4$:$5$:$6$", [info.year, info.month, info.day, info.hour, info.min, info.sec]));

        }
        System.println(current.observationLocationPosition.toDegrees());
        return current.windBearing;
    }
}