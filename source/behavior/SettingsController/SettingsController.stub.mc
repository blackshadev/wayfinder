import Toybox.Lang;

(:debug)
module WayfinderTests {
    class StubSettingsController extends SettingsControllerInterface {
        private var _distance as SettingsControllerInterface.DistanceUnit = SettingsControllerInterface.DISTANCE_METERS;
        private var _unitsSpeed as SettingsControllerInterface.SpeedUnit = SettingsControllerInterface.SPEED_KMH;
        private var _returnWaypointVisibility as SettingsControllerInterface.ReturnWaypointVisibility = SettingsControllerInterface.RETURN_WAYPOINT_NEVER;
        private var _distanceToWaypoint as Number = 100;

        function initialize() {
            SettingsControllerInterface.initialize();
        }

        public function setDistance(distance as SettingsControllerInterface.DistanceUnit) as Void {
            self._distance = distance;
        }

        public function distance() as SettingsControllerInterface.DistanceUnit {
            return self._distance;
        }

        public function setUnitsSpeed(unitsSpeed as SettingsControllerInterface.SpeedUnit) as Void {
            self._unitsSpeed = unitsSpeed;
        }

        public function unitsSpeed() as SettingsControllerInterface.SpeedUnit {
            return self._unitsSpeed;
        }

        public function setReturnWaypointVisibility(visibility as SettingsControllerInterface.ReturnWaypointVisibility) as Void {
            self._returnWaypointVisibility = visibility;
        }

        public function returnWaypointVisibility() as SettingsControllerInterface.ReturnWaypointVisibility {
            return self._returnWaypointVisibility;
        }

        public function setDistanceToWaypoint(distance as Number) as Void {
            self._distanceToWaypoint = distance;
        }

        public function distanceToWaypoint() as Number {
            return self._distanceToWaypoint;
        }
    }
}