import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;

class WaypointsController {
    private var _location as LocationProvider;
    private var _sensor as SensorProvider;
    private var _waypointStorage as WaypointStorage;

    private var _lastPosition as Position.Location? = null;
    private var _shouldSetReturn as Boolean = false;
    private var _returnWaypoint as Waypoint? = null;
    private var _currentWaypoint as Waypoint? = null;
    private var _waypoints as Array<Waypoint> = [];
    private var _updateTimer as TimerSubscription;

    function initialize(
        location as LocationProvider, 
        sensor as SensorProvider,
        waypointStorage as WaypointStorage
    ) {
        self._location = location;
        self._sensor = sensor;
        self._waypointStorage = waypointStorage;

        self._waypoints = self._waypointStorage.loadWaypoints();

        self._updateTimer = AppTimer.onUpdate();
        self._updateTimer.start(method(:update));
    }

    public function update() as Void {
        self._lastPosition = self._location.getLastPosition();
        if (self._lastPosition == null) {
            return;
        }

        if (self._shouldSetReturn) {
            self.setReturn();
        }

        if (self._returnWaypoint == null) {
            return;
        }

        self._returnWaypoint.update(self._lastPosition, self._sensor.heading());
    }

    public function returnWaypoint() as Waypoint? {
        return self._returnWaypoint;
    }

    public function isSet() as Boolean {
        return self._returnWaypoint != null;
    }

    public function isSettable() as Boolean {
        return self._lastPosition != null;
    }

    public function autoSet() as Void {
        if (self.isSet()) {
            return;
        }

        if (!self.isSettable()) {
            self._shouldSetReturn = true;
            return;
        }

        self.setReturn();
    }

    public function setWaypoints(waypoints as Array<Waypoint>) as Void {
        self._waypoints = waypoints;
        self._waypointStorage.saveWaypoints(waypoints);

        if (waypoints.size() > 0) {
            self._currentWaypoint = waypoints[0];
        }
    }

    public function setWaypoint() as Void {
        if (!self.isSettable()) {
            return;
        }
    
        self.setWaypoints([new Waypoint(self._lastPosition)]);
    }

    public function setReturn() as Void {
        if (!self.isSettable()) {
            return;
        }
    
        self._shouldSetReturn = false;
        self._returnWaypoint = new Waypoint(self._lastPosition);
    }

    public function clear() as Void {
        self._shouldSetReturn = false;
        self._waypoints = [];
        self._returnWaypoint = null;
        self._currentWaypoint = null;
        self._waypointStorage.clear();
    }
}
