import Toybox.Activity;
import Toybox.Lang;

class SensorProvider extends SensorProviderInterface {
    
    function initialize() {
        SensorProviderInterface.initialize();
    }

    public function heading() as Number? {
        var cur = Sensor.getInfo();
        if (cur.heading == null) {
            return null;
        }

        return (Math.toDegrees(cur.heading).toNumber() + 360) % 360;
    }

    public function speed() as Float? {
        var cur = Sensor.getInfo();
        return cur.speed;
    }
}