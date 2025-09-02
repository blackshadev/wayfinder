import Toybox.WatchUi;
import Toybox.Lang;

class SettingsMenuBuilder {
    private var settings as SettingsController;

    function initialize(settings as SettingsController) {
        self.settings = settings;
    }

    public function build() as WatchUi.Menu2 {
        var menu = new WatchUi.Menu2({ :title => Rez.Strings.settingsTitle });

        menu.addItem(
            new MenuItem(
                Rez.Strings.settingsActivityType,
                self.settings.activityTypeRes(),
                SettingsMenuDelegate.ACTIVITY_UPDATE,
                {}
            )
        );

        menu.addItem(
            new MenuItem(
                Rez.Strings.settingsUnitsSpeed,
                self.settings.unitsSpeedRes(),
                SettingsMenuDelegate.UNITS_SPEED_UPDATE,
                {}
            )
        );

        menu.addItem(
            new MenuItem(
                Rez.Strings.settingsUnitsDistance,
                self.settings.unitsDistanceRes(),
                SettingsMenuDelegate.UNITS_DISTANCE_UPDATE,
                {}
            )
        );


        menu.addItem(
            new MenuItem(
                Rez.Strings.settingsBackground,
                self.settings.backgroundRes(),
                SettingsMenuDelegate.BACKGROUND_UPDATE,
                {}
            )
        );

        menu.addItem(
            new MenuItem(
                Rez.Strings.settingsDistanceToWaypoint,
                self.settings.distanceToWaypointRes(),
                SettingsMenuDelegate.DISTANCE_TO_WAYPOINT_UPDATE,
                {}
            )
        );

        menu.addItem(
            new MenuItem(
                Rez.Strings.settingsArrowSize,
                self.settings.arrowSizeRes(),
                SettingsMenuDelegate.ARROW_SIZE_UPDATE,
                {}
            )
        );

        menu.addItem(
            new MenuItem(
                Rez.Strings.settingsReturnWaypointVisibility,
                self.settings.returnWaypointVisibilityRes(),
                SettingsMenuDelegate.RETURN_WAYPOINT_VISIBILITY_UPDATE,
                {}
            )
        );

        if (WatchUi has :MapTrackView) {
            menu.addItem(
                new MenuItem(
                    Rez.Strings.settingsMapZoomDistance,
                    self.settings.mapZoomDistanceRes(),
                    SettingsMenuDelegate.MAP_ZOOM_DISTANCE_UPDATE,
                    {}
                )
            );
        }

        return menu;
    }

    
}