import Toybox.Lang;

(:debug)
module WayfinderTests {
    class StubAppTimer extends AppTimerInterface {
        private var _callbacks as Array<Method> = [];

        private var _time as Number = 1000;

        function initialize() {
            AppTimerInterface.initialize();
        }

        public function add(ref as Method) as Void {
            _callbacks.add(ref);
        }

        public function remove(ref as Method) as Void {
            _callbacks.remove(ref);
        }

        public function contains(ref as Method) as Boolean {
            return _callbacks.indexOf(ref) > -1;
        }

        public function tick() as Void {
            for (var iX = _callbacks.size() - 1; iX >= 0; iX--) {
                _callbacks[iX].invoke();
            }
        }

        public function setTime(time as Number) as Void {
            self._time = time;
        }

        public function start() as Void {}
        public function stop() as Void {}

        public function time() as Number {
            return self._time;
        }
    }   
}