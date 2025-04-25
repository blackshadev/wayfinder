import Toybox.Activity;
import Toybox.Lang;

class SensorProvider {
    
    function initialize() {
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