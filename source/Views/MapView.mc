import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Lang;
import Toybox.Position;

class MapView extends WatchUi.MapTrackView {
    private var waypoint as WaypointController;
    private var settings as SettingsController;
    
    private var noLocationText as Text;
    private var arrow as Arrow;
    private var currentWaypoint as Location? = null;

    function initialize(
        waypoint as WaypointController,
        settings as SettingsController
    ) {
        MapTrackView.initialize();

        self.waypoint = waypoint;
        self.settings = settings;

        self.noLocationText = new Text({
            :offset => [0, 0],
            :font => Graphics.FONT_MEDIUM,
            :color => Utils.Colors.foreground,
            :justification => Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER,
            :text => Rez.Strings.mapNoLocation
        });

        self.arrow = new Arrow(Utils.Sizing.arrow);

        self.setMapMode(WatchUi.MAP_MODE_PREVIEW);
    }

    function onLayout(dc as Dc) as Void {
        MapTrackView.onLayout(dc);

        self.arrow.layout(dc);
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

            self.updateMapMarker();
        }

        self.arrow.setAngle(self.waypoint.absoluteAngle());
        self.arrow.draw(dc);
    }

    private function updateMapMarker() as Void { 
        if (self.currentWaypoint == null) {
            return;
        }

        self.clear();
        self.setMapMarker(new MapMarker(self.currentWaypoint));
    }

    function onShow() as Void {
        var distance = self.settings.mapZoomDistance() / 2;

        var position = Position.getInfo().position;
        var top_left = position.getProjectedLocation(Math.toRadians(315), distance);
        var bottom_right = position.getProjectedLocation(Math.toRadians(135), distance);
        self.setMapVisibleArea(top_left, bottom_right);

        self.updateMapMarker();
    }

    private function waypointIsStale() as Boolean {
        var waypoint = self.waypoint.waypointLocation();

        return waypoint != null && (
            self.currentWaypoint == null || 
            !waypoint.toGeoString(Position.GEO_DM).equals(self.currentWaypoint.toGeoString(Position.GEO_DM))
        );
    }
}
