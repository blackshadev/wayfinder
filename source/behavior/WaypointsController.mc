import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;

class WaypointsController {
    private var location as LocationProvider;
    private var sensor as SensorProvider;

    private var lastPosition as Position.Location? = null;
    private var shouldSetReturn as Boolean = false;
    private var returnWaypoint as Waypoint? = null;
    private var updateTimer as TimerSubscription;

    function initialize(location as LocationProvider, sensor as SensorProvider) {
        self.location = location;
        self.sensor = sensor;

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

        self.returnWaypoint.update(self.lastPosition, self.sensor.heading());
    }

    public function currentLocation() as Position.Location? {
        return self.lastPosition;
    }

    public function returnLocation() as Position.Location? {
        return self.returnWaypoint;
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

    public function setWaypoint() as Void {
        // Placeholder for setting the waypoint
    }

    public function setReturn() as Void {
        self.shouldSetReturn = false;
        self.returnWaypoint = self.lastPosition;
    }

    public function clear() as Void {
        self.shouldSetReturn = false;
        self.returnWaypoint = null;
    }
}

