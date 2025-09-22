import Toybox.Lang;
import Toybox.Position;

(:debug)
module WayfinderTests {
    class StubLocationProvider extends LocationProviderInterface {
        public function initialize() {
            LocationProviderInterface.initialize();
        }

        private var _lastPosition as Position.Location? = null;
        private var _lastPositionInfo as Position.Info? = null;
        protected var _configuration as Position.Configuration? = null;

        public function setLastPosition(position as Position.Location?) as Void {
            self._lastPosition = position;
        }

        public function getLastPosition() as Position.Location? {
            return self._lastPosition;
        }

        public function getLastPositionInfo() as Position.Info? {
            return self._lastPositionInfo;
        }

        public function getConfiguration() as Position.Configuration? {
            return self._configuration;
        }
    }
}