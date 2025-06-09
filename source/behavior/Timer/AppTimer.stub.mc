import Toybox.Lang;

(:debug)
module WayfinderTests {
    class StubAppTimer extends AppTimerInterface {
        private var _callbacks as Array<Method> = [];

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
    }   
}