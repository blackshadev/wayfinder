import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Lang;
import Toybox.Position;

class MapView extends WatchUi.MapTrackView {
    private var waypoint as WaypointsController;
    private var settings as SettingsControllerInterface;
    
    private var noLocationText as Text;
    private var windDirectionArrow as WindDirectionArrow;
    private var arrows as WaypointArrows;

    private var returnWaypoint as Waypoint? = null;
    private var currentWaypoint as Waypoint? = null;

    function initialize(
        waypoint as WaypointsController,
        settings as SettingsControllerInterface,
        windDirection as WindDirectionControllerInterface
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

        self.windDirectionArrow = new WindDirectionArrow(settings, windDirection, true);
        self.arrows = new WaypointArrows(settings, waypoint, true);

        self.setMapMode(WatchUi.MAP_MODE_PREVIEW);
    }

    function onLayout(dc as Dc) as Void {
        MapTrackView.onLayout(dc);

        self.arrows.layout(dc);
        self.noLocationText.layout(dc);

        self.setScreenVisibleArea(0, 0, dc.getWidth(), dc.getHeight());
    }

    function onUpdate(dc as Dc) as Void {

        if (!self.waypoint.isSettable()) {
            var color = Utils.Colors.background;
            dc.setColor(color, color);
            dc.clear();

            self.noLocationText.draw(dc);

            return;
        }

        if (self.staleWaypoints()) {
            self.currentWaypoint = self.waypoint.currentWaypoint();
            self.returnWaypoint = self.waypoint.returnWaypoint();

            self.updateMapMarker();
        }

        self.arrows.update();
        self.arrows.draw(dc);
    }

    private function updateMapMarker() as Void { 
        self.clear();

        var markers = [] as Array<MapMarker>;
        if (self.currentWaypoint != null && self.waypoint.shouldShowCurrentWaypoint()) {
            markers.add(new MapMarker(self.currentWaypoint.location()));
        }

        if (self.returnWaypoint != null && self.waypoint.shouldShowReturnWaypoint()) {
            markers.add(new MapMarker(self.returnWaypoint.location()));
        }

        if (markers.size() > 0) {
            self.setMapMarker(markers);
        }
    }

    function onShow() as Void {
        var distance = self.settings.mapZoomDistance() / 2;

        var position = Position.getInfo().position;
        var top_left = position.getProjectedLocation(Math.toRadians(315), distance);
        var bottom_right = position.getProjectedLocation(Math.toRadians(135), distance);
        self.setMapVisibleArea(top_left, bottom_right);

        self.updateMapMarker();
    }

    private function staleWaypoints() as Boolean {
        var returnWaypoint = self.waypoint.returnWaypoint();
        var currentWaypoint = self.waypoint.currentWaypoint();

        var returnWaypointChanged = self.returnWaypoint != returnWaypoint;
        var currentWaypointChanged = self.currentWaypoint != currentWaypoint;

        return returnWaypointChanged || currentWaypointChanged;
    }
}
