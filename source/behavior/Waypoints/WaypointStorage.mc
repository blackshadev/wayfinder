import Toybox.Lang;
import Toybox.Application.Storage;

class WaypointStorage {
    private const STORAGE_KEY = "wayfinder_waypoints";

    public function loadWaypoints() as Array<Waypoint> {
        var storedWaypoints = Storage.getValue(STORAGE_KEY) as Array<Array<Double>>?;

        if (storedWaypoints == null || !(storedWaypoints instanceof Array)) {
            return [];
        }

        var waypoints = [];
        for (var i = 0; i < storedWaypoints.size(); i++) {
            if (!Waypoint.isValidArray(storedWaypoints[i])) {
                continue;
            }

            waypoints.add(Waypoint.fromArray(storedWaypoints[i]));
        }

        return waypoints;
    }

    public function saveWaypoints(waypoints as Array<Waypoint>) as Void {
        var storableWaypoints = [] as Array<Array<Double>>;
        for (var iX = 0; iX < waypoints.size(); iX++) {
            storableWaypoints.add(waypoints[iX].toArray());
        }
        Storage.setValue(STORAGE_KEY, storableWaypoints);
    }

    public function clear() as Void {
        Storage.deleteValue(STORAGE_KEY);
    }
}