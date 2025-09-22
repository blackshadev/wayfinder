import Toybox.Lang;
import Toybox.Application.Storage;

class WaypointStorageInterface {
    public function loadWaypoints() as Array<Waypoint> {
        throw new NotImplemented();
    }

    public function saveWaypoints(waypoints as Array<Waypoint>) as Void {
        throw new NotImplemented();
    }

    public function clear() as Void {
        throw new NotImplemented();
    }
    
}
