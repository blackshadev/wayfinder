import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate {
    public static const ACTIVITY_UPDATE = "activity_update";
    public static const UNITS_SPEED_UPDATE = "units_speed_update";
    public static const UNITS_DISTANCE_UPDATE = "units_distance_update";
    public static const BACKGROUND_UPDATE = "background_update";
    public static const MAP_ZOOM_DISTANCE_UPDATE = "map_zoom_distance_update";

    public static const DISTANCE_TO_WAYPOINT_UPDATE = "distance_to_waypoint_update";
    public static const ARROW_SIZE_UPDATE = "arrow_size_update";

    public static const RETURN_WAYPOINT_VISIBILITY_UPDATE = "return_waypoint_visibility_update";

    private var settings as SettingsController;

    function initialize(settings as SettingsController) {
        Menu2InputDelegate.initialize();
        
        self.settings = settings;
    }

    function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String; 

        switch (id) {
            case ACTIVITY_UPDATE:
                self.settings.toggleActivityType();
                item.setSubLabel(self.settings.activityTypeRes());
                return;
            case UNITS_SPEED_UPDATE:
                self.settings.toggleUnitsSpeed();
                item.setSubLabel(self.settings.unitsSpeedRes());
                return;
            case UNITS_DISTANCE_UPDATE:
                self.settings.toggleUnitsDistance();
                item.setSubLabel(self.settings.unitsDistanceRes());
                return;
            case BACKGROUND_UPDATE:
                self.settings.toggleBackground();
                item.setSubLabel(self.settings.backgroundRes());
                return;
            case MAP_ZOOM_DISTANCE_UPDATE:
                self.settings.toggleMapZoomDistance();
                item.setSubLabel(self.settings.mapZoomDistanceRes());
                return;
            case DISTANCE_TO_WAYPOINT_UPDATE:
                self.settings.toggleDistanceToWaypoint();
                item.setSubLabel(self.settings.distanceToWaypointRes());
                return;
            case ARROW_SIZE_UPDATE:
                self.settings.toggleArrowSize();
                item.setSubLabel(self.settings.arrowSizeRes());
                return;
            case RETURN_WAYPOINT_VISIBILITY_UPDATE:
                self.settings.toggleReturnWaypointVisibility();
                item.setSubLabel(self.settings.returnWaypointVisibilityRes());
                return;
        }
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}