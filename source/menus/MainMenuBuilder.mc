import Toybox.WatchUi;
import Toybox.Lang;

class MainMenuBuilder {
    private var waypoint as WaypointController;

    function initialize(waypoint as WaypointController) {
        self.waypoint = waypoint;
    }

    public function build() as WatchUi.Menu2 {
        var menu = new WatchUi.Menu2({:title=>"Wayfinder"});

        var noLocationLabel = null as ResourceId?;
        if (!self.waypoint.isSettable()) {
            noLocationLabel = WatchUi.loadResource(Rez.Strings.menu_set_waypoint_no_location);
        }

        menu.addItem(
            new MenuItem(
                WatchUi.loadResource(Rez.Strings.menu_set_waypoint),
                noLocationLabel,
                MainMenuDelegate.WAYPOINT_SET_ID,
                {}
            )
        );

        menu.addItem(
            new MenuItem(
                WatchUi.loadResource(Rez.Strings.menu_open_settings),
                null,
                MainMenuDelegate.SETTINGS_OPEN_ID,
                {}
            )
        );

        return menu;
    }
}