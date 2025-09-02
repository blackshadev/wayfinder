import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Lang;
import Toybox.Position;

class MapView extends WatchUi.MapTrackView {
    private var waypoint as WaypointsController;
    private var settings as SettingsController;
    
    private var noLocationText as Text;
    private var arrow as Arrow;
    private var returnWaypoint as Waypoint? = null;

    function initialize(
        waypoint as WaypointsController,
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

        self.arrow = new Arrow({
            :size => settings.arrowSizeValue(),
            :color => Graphics.COLOR_DK_BLUE
        });

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
            self.returnWaypoint = self.waypoint.returnWaypoint();

            self.updateMapMarker();
        }

        self.arrow.setAngle(self.returnWaypoint.absoluteAngle());
        self.arrow.draw(dc);
    }

    private function updateMapMarker() as Void { 
        if (self.returnWaypoint == null) {
            return;
        }

        self.clear();
        self.setMapMarker(new MapMarker(self.returnWaypoint.location()));
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
        var waypoint = self.waypoint.returnWaypoint();

        return waypoint != null && (
            self.returnWaypoint == null || 
            !waypoint.location().toGeoString(Position.GEO_DM).equals(
                self.returnWaypoint.location().toGeoString(Position.GEO_DM)
            )
        );
    }
}
