import Toybox.Lang;
import Toybox.Timer;


(:debug)
module WayfinderTests {
    class StubTimer extends Timer.Timer {
        private var _callback as Method? = null;
        private var _time as Number? = null;
        private var _repeat as Boolean? = null;

        public function initialize() {
            Timer.Timer.initialize();
        }

        public function start(callback as Method() as Void, time as Number, repeat as Boolean) as Void {
            self._callback = callback;
            self._time = time;
            self._repeat = repeat;
        }
        
        public function stop() as Void {
            self._callback = null;
            self._time = null;
            self._repeat = null;
        }

        public function call() as Void {
            if (self._callback != null) {
                self._callback.invoke();
            }
        }

        public function isRepeat() as Boolean? {
            return self._repeat;
        }

        public function getTime() as Number? {
            return self._time;
        }
    }
}