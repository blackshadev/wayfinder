import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class MainMenuDelegate extends WatchUi.Menu2InputDelegate {
    public static const WAYPOINT_SET_ID = "waypoint_set";
    public static const SETTINGS_OPEN_ID = "settings_open";

    private var waypoint as WaypointController;
    private var settings as SettingsController;

    function initialize(waypoint as WaypointController, settings as SettingsController) {
        Menu2InputDelegate.initialize();
        self.waypoint = waypoint;
        self.settings = settings;
    }

    function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String; 
        switch (id) {
            case WAYPOINT_SET_ID:
                self.setWaypoint();
                WatchUi.popView(WatchUi.SLIDE_RIGHT);
                break;
            case SETTINGS_OPEN_ID:
                self.openSettingsMenu();
                break;
            default:
                System.println("No action for id " + id);
        }
    }

    private function setWaypoint() as Void {
        if (!self.waypoint.isSettable()) {
            return;
        }

        self.waypoint.set();
    }

    private function openSettingsMenu() as Void {
        var menuBuilder = new SettingsMenuBuilder(self.settings);

        WatchUi.pushView(
            menuBuilder.build(),
            new SettingsMenuDelegate(self.settings),
            WatchUi.SLIDE_LEFT
        );
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}