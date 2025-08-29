import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;
import Toybox.Application.Storage;

class WaypointsController {
    private const STORAGE_KEY = "wayfinder_waypoints";

    private var location as LocationProvider;
    private var sensor as SensorProvider;

    private var lastPosition as Position.Location? = null;
    private var shouldSetReturn as Boolean = false;
    private var returnWaypoint as Waypoint? = null;
    private var currentWaypoint as Waypoint? = null;
    private var waypoints as Array<Waypoint> = [];
    private var updateTimer as TimerSubscription;

    function initialize(location as LocationProvider, sensor as SensorProvider) {
        self.location = location;
        self.sensor = sensor;

        self.loadWaypoints();
        self.updateTimer = AppTimer.onUpdate();
        self.updateTimer.start(method(:update));
    }

    public function update() as Void {
        self.lastPosition = self.location.getLastPosition();
        if (self.shouldSetReturn) {
            self.setReturn();
        }

        if (self.lastPosition == null || self.returnWaypoint == null) {
            return;
        }

        self.currentWaypoint.update(self.lastPosition, self.sensor.heading());
    }

    public function currentLocation() as Position.Location? {
        return self.lastPosition;
    }

    public function returnLocation() as Position.Location? {
        return self.returnWaypoint.getLocation();
    }

    public function isSet() as Boolean {
        return self.returnWaypoint != null;
    }

    public function isSettable() as Boolean {
        return self.lastPosition != null;
    }

    public function autoSet() as Void {
        if (self.isSet()) {
            return;
        }

        if (!self.isSettable()) {
            self.shouldSetReturn = true;
            return;
        }

        self.setReturn();
    }

    public function angle() as Number? {
        if (self.returnWaypoint == null) {
            return null;
        }
        
        return self.returnWaypoint.angle();
    }

    public function absoluteAngle() as Number? {
        if (self.returnWaypoint == null) {
            return null;
        }
   
        return self.returnWaypoint.absoluteAngle();
    }

    public function setWaypoints(waypoints as Array<Waypoint>) as Void {
        self.waypoints = waypoints;
        self.saveWaypoints();

        if (waypoints.size() > 0) {
            self.currentWaypoint = waypoints[0];
        }
    }

    public function setWaypoint() as Void {
        self.setWaypoints([new Waypoint(self.lastPosition)]);
    }

    public function setReturn() as Void {
        self.shouldSetReturn = false;
        self.returnWaypoint = new Waypoint(self.lastPosition);
    }

    public function clear() as Void {
        self.shouldSetReturn = false;
        self.returnWaypoint = null;
    }

    private function loadWaypoints() as Void {
        var storedWaypoints = Storage.getValue(STORAGE_KEY) as Array<Array<Double>>?;

        if (storedWaypoints == null || !(storedWaypoints instanceof Array)) {
            return;
        }

        var waypoints = [];
        for (var i = 0; i < storedWaypoints.size(); i++) {
            if (!Waypoint.isValidArray(storedWaypoints[i])) {
                continue;
            }

            waypoints.add(Waypoint.fromArray(storedWaypoints[i]));
        }

        self.waypoints = waypoints;
    }

    private function saveWaypoints() as Void {
        var storableWaypoints = [] as Array<Array<Double>>;
        for (var iX = 0; iX < self.waypoints.size(); iX++) {
            storableWaypoints.add(self.waypoints[iX].toArray());
        }
        Storage.setValue(STORAGE_KEY, storableWaypoints);
    }
}

