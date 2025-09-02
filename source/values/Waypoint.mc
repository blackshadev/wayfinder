import Toybox.Position;
import Toybox.Lang;

class Waypoint {
    private var _location as Position.Location;
    private var _distance as Float? = null;
    private var _absoluteAngle as Number? = null;
    private var _relativeAngle as Number? = null;

    public static function isValidArray(data as Array<Double>) as Boolean {
        return data instanceof Array 
            && data.size() == 2 
            && data[0] instanceof Double 
            && data[1] instanceof Double;
    }

    public static function fromArray(data as Array<Double>) as Waypoint {
        var location = new Position.Location({
            :latitude => data[0],
            :longitude => data[1],
            :format => :degrees
        });

        return new Waypoint(location);
    }

    function initialize(location as Position.Location) {
        self._location = location;
    }

    public function location() as Position.Location {
        return self._location;
    }

    public function angle() as Number? {
        return self._relativeAngle;
    }

    public function absoluteAngle() as Number? {
        return self._absoluteAngle;
    }

    public function distance() as Float? {
        return self._distance;
    }

    public function update(currentLocation as Position.Location, currentHeading as Float?) as Void {
        self._distance = Utils.Distance.betweenApprox(currentLocation, self._location);
        self._absoluteAngle = self.calculateAbsoluteWaypointAngle(currentLocation);
        
        if (currentHeading != null) {
            self._relativeAngle = self.calculateRelativeWaypointAngle(currentLocation, currentHeading);
        }
    }

    public function toArray() as Array<Double> {
        var degs = self._location.toDegrees();

        return [
            degs[0],
            degs[1],
        ];
    }

    private function calculateAbsoluteWaypointAngle(currentLocation as Position.Location) as Number {
        var waypointPos = self._location.toDegrees();
        var currentPos = currentLocation.toDegrees();

        var absoluteAngleInRads = Math.atan2(waypointPos[1] - currentPos[1], waypointPos[0] - currentPos[0]);

        return (Math.toDegrees(absoluteAngleInRads).toNumber() + 360) % 360;
    }

    private function calculateRelativeWaypointAngle(currentLocation as Position.Location, currentHeading as Float) as Number? {
        var absoluteWaypointAngle = self.calculateAbsoluteWaypointAngle(currentLocation);
        var headingAngle =  (Math.toDegrees(currentHeading).toNumber() + 360) % 360;

        return (absoluteWaypointAngle - headingAngle + 360) % 360;
    }
}