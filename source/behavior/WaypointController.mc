import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;

class WaypointController {
    private var location as LocationProvider;
    private var sensor as SensorProvider;

    private var lastPosition as Position.Location? = null;
    private var returnWaypoint as Position.Location? = null;
    private var shouldSetReturn as Boolean = false;
    private var waypointAngle as Number? = null;
    private var headingAngle as Number? = null;
    private var relativeWaypointAngle as Number? = null;
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

        self.waypointAngle = self.calculateWaypointAngle();
        self.headingAngle = self.calculateHeadingAngle();
        self.relativeWaypointAngle = ((self.waypointAngle - self.headingAngle) + 360) % 360;
    }

    public function currentLocation() as Position.Location? {
        return self.lastPosition;
    }

    public function returnLocation() as Position.Location? {
        return self.returnWaypoint;
    }

    public function angle() as Number? {
        return self.relativeWaypointAngle;
    }

    public function absoluteAngle() as Number? {
        return self.waypointAngle;
    }

    private function calculateWaypointAngle() as Number? {
        if (self.lastPosition == null || self.returnWaypoint == null) {
            return null;
        }

        var waypointPos = self.returnWaypoint.toDegrees();
        var currentPos = self.lastPosition.toDegrees();

        var absoluteAngleInRads = Math.atan2(waypointPos[1] - currentPos[1], waypointPos[0] - currentPos[0]);
        
        return (Math.toDegrees(absoluteAngleInRads).toNumber() + 360) % 360;
    }

    private function calculateHeadingAngle() as Number? {
        return (Math.toDegrees(self.sensor.heading()).toNumber() + 360) % 360;
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
        self.waypointAngle = null;
        self.headingAngle = null;
        self.relativeWaypointAngle = null;
    }
}

