import Toybox.Activity;
import Toybox.Lang;

class SensorProvider extends SensorProviderInterface {
    
    function initialize() {
        SensorProviderInterface.initialize();
    }

    public function heading() as Float? {
        var cur = Sensor.getInfo();
        return cur.heading;
    }

    public function speed() as Float? {
        var cur = Sensor.getInfo();
        return cur.speed;
    }
}