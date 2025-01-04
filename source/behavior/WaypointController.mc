import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Lang;

class WaypointController {

    private var lastPosition as Position.Location? = null;
    private var waypoint as Position.Location? = null;
    private var shouldSet as Boolean = false;
    private var sensor as SensorProvider;
    private var curAngle as Number? = null;

    function initialize(sensor as SensorProvider) {
        self.sensor = sensor;
    }

    public function start() as Void {
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
    }

    public function stop() as Void {
        Position.enableLocationEvents(Position.LOCATION_DISABLE, null);
    }

    function onPosition(info as Position.Info) as Void {
        self.lastPosition = info.position;
        if (self.shouldSet) {
            self.set();
        }

        self.didChange();
    }

    private function didChange() as Void {
        if (self.lastPosition == null || self.waypoint == null) {
            return;
        }

        self.curAngle = self.calculateAngle();
    }

    public function angle() as Number? {
        return self.curAngle;
    }

    private function calculateAngle() as Number? {
        if (self.lastPosition == null || self.waypoint == null) {
            return null;
        }

        var waypointPos = self.waypoint.toDegrees();
        var currentPos = self.lastPosition.toDegrees();

        var absoluteAngleInRads = Math.atan2(waypointPos[1] - currentPos[1], waypointPos[0] - currentPos[0]);
        var absoluteInDegrees = (Math.toDegrees(absoluteAngleInRads).toNumber() + 360) % 360;
        var headingInDegrees = (Math.toDegrees(self.sensor.heading()).toNumber() + 360) % 360;

        return ((absoluteInDegrees - headingInDegrees) + 360) % 360;
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

