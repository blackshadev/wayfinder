import Toybox.Lang;
import Toybox.Application.Storage;

(:debug)
module WayfinderTests {
    class MockWaypointStorage extends WaypointStorageInterface {
        private var _savedWaypoints as Array<Waypoint>? = null;
        private var _cleared as Boolean = false;
        private var _loadedWaypoints as Array<Waypoint> = [];

        public function initialize() {
            WaypointStorageInterface.initialize();
        }

        public function setLoadedWaypoints(waypoints as Array<Waypoint>) as Void {
            self._loadedWaypoints = waypoints;
        }

        public function loadWaypoints() as Array<Waypoint> {
            return self._loadedWaypoints;
        }

        public function saveWaypoints(waypoints as Array<Waypoint>) as Void {
            self._savedWaypoints = waypoints;
        }

        public function hasSavedWaypoints(expected as Array<Waypoint>) as Boolean {
            if (expected.size() != self._savedWaypoints.size()) {
                return false;
            }

            for (var iX = 0; iX < expected.size(); iX++) {
                if (!expected[iX].equals(self._savedWaypoints[iX])) {
                    return false;
                }
            }

            return true;
        }

        public function clear() as Void {
            self._cleared = true;
        }

        public function isCleared() as Boolean {
            return self._cleared;
        }

        public function reset() as Void {
            self._savedWaypoints = [];
            self._cleared = false;
            self._loadedWaypoints = [];
        }

    }
}