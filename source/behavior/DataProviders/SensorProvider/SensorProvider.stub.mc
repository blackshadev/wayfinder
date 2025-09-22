import Toybox.Activity;
import Toybox.Lang;

(:debug)
module WayfinderTests {
    class StubSensorProvider extends SensorProviderInterface {
        private var _heading as Float = 0.0;
        private var _speed as Float = 0.0;

        function initialize() {
            SensorProviderInterface.initialize();
        }

        public function setHeading(heading as Float) as Void {
            self._heading = heading;
        }

        public function heading() as Float? {
            return self._heading;
        }

        public function setSpeed(speed as Float) as Void {
            self._speed = speed;
        }

        public function speed() as Float? {
            return self._speed;
        }
    }
}