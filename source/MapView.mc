import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Lang;
import Toybox.Position;

class MapView extends WatchUi.MapTrackView {
    private var waypoint as WaypointController;
    // private var updateTimer as Timer.Timer;
    private var noLocationText as Text;
    private var currentWaypoint as Location? = null;

    function initialize(waypoint as WaypointController) {
        MapTrackView.initialize();

        // self.updateTimer = new Timer.Timer();
        self.waypoint = waypoint;

        self.noLocationText = new Text({
            :offset => [0, 0],
            :font => Graphics.FONT_MEDIUM,
            :color => Utils.Colors.foreground,
            :justification => Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER,
            :text => Rez.Strings.mapNoLocation
        });

        self.setMapMode(WatchUi.MAP_MODE_PREVIEW);
    }

    function onLayout(dc as Dc) as Void {
        MapTrackView.onLayout(dc);

        self.noLocationText.layout(dc);

        self.setScreenVisibleArea(0, 0, dc.getWidth(), dc.getHeight());
    }

    function onUpdate(dc as Dc) as Void {

        if (!self.waypoint.isSet()) {
            var color = Utils.Colors.background;
            dc.setColor(color, color);
            dc.clear();

            self.noLocationText.draw(dc);

            return;
        }

        if (self.waypointIsStale()) {
            var waypoint = self.waypoint.waypointLocation();

            self.currentWaypoint = waypoint;
            var top_left = waypoint.getProjectedLocation(Math.toRadians(315), 1000);
            var bottom_right = waypoint.getProjectedLocation(Math.toRadians(135), 1000);

            self.clear();
            self.setMapVisibleArea(top_left, bottom_right);
            self.setMapMarker(new MapMarker(waypoint));
        }
    }

    private function waypointIsStale() as Boolean {
        var waypoint = self.waypoint.waypointLocation();

        return waypoint != null && (
            self.currentWaypoint == null || 
            !waypoint.toGeoString(Position.GEO_DM).equals(self.currentWaypoint.toGeoString(Position.GEO_DM))
        );
    }
}
