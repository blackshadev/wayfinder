import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;

class WaypointController {
    private var location as LocationProvider;
    private var sensor as SensorProvider;

    private var lastPosition as Position.Location? = null;
    private var waypoint as Position.Location? = null;
    private var shouldSet as Boolean = false;
    private var waypointAngle as Number? = null;
    private var headingAngle as Number? = null;
    private var relativeWaypointAngle as Number? = null;
    private var updateTimer as TimerSubscription;

    function initialize(location as LocationProvider, sensor as SensorProvider) {
        self.location = location;
        self.sensor = sensor;

        self.updateTimer = AppTimer.subscribeOnUpdate(method(:update));
        self.updateTimer.start();
    }

    public function update() as Void {
        self.lastPosition = self.location.getLastPosition();
        if (self.shouldSet) {
            self.set();
        }

        if (self.lastPosition == null || self.waypoint == null) {
            return;
        }

        self.waypointAngle = self.calculateWaypointAngle();
        self.headingAngle = self.calculateHeadingAngle();
        self.relativeWaypointAngle = ((self.waypointAngle - self.headingAngle) + 360) % 360;
    }

    public function currentLocation() as Position.Location? {
        return self.lastPosition;
    }

    public function waypointLocation() as Position.Location? {
        return self.waypoint;
    }

    public function angle() as Number? {
        return self.relativeWaypointAngle;
    }

    public function absoluteAngle() as Number? {
        return self.waypointAngle;
    }

    private function calculateWaypointAngle() as Number? {
        if (self.lastPosition == null || self.waypoint == null) {
            return null;
        }

        var waypointPos = self.waypoint.toDegrees();
        var currentPos = self.lastPosition.toDegrees();

        var absoluteAngleInRads = Math.atan2(waypointPos[1] - currentPos[1], waypointPos[0] - currentPos[0]);
        
        return (Math.toDegrees(absoluteAngleInRads).toNumber() + 360) % 360;
    }

    private function calculateHeadingAngle() as Number? {
        return (Math.toDegrees(self.sensor.heading()).toNumber() + 360) % 360;
    }

    public function isSet() as Boolean {
        return self.waypoint != null;
    }

    public function isSettable() as Boolean {
        return self.lastPosition != null;
    }

    public function autoSet() as Void {
        if (self.isSet()) {
            return;
        }

        if (self.isSettable()) {
            self.set();
            return;
        }

        self.shouldSet = true;
    }

    public function set() as Void {
        self.shouldSet = false;
        self.waypoint = self.lastPosition;
    }
}

