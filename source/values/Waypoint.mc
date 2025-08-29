import Toybox.Position;
import Toybox.Lang;

class Waypoint {
    private var _location as Position.Location;
    private var _absoluteAngle as Number? = null;
    private var _relativeAngle as Number? = null;

    function initialize(location as Position.Location) {
        self._location = location;
    }

    function getLocation() as Position.Location {
        return self._location;
    }

    function angle() as Number? {
        return self._relativeAngle;
    }

    function absoluteAngle() as Number? {
        return self._absoluteAngle;
    }

    function update(currentLocation as Position.Location, currentHeading as Float?) as Void {
        self._absoluteAngle = self.calculateAbsoluteWaypointAngle(currentLocation);
        
        if (currentHeading != null) {
            self._relativeAngle = self.calculateRelativeWaypointAngle(currentLocation, currentHeading);
        }
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