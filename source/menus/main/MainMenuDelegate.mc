import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class MainMenuDelegate extends WatchUi.Menu2InputDelegate {
    public static const WAYPOINTS_OPEN_ID = "waypoints_open";
    public static const SETTINGS_OPEN_ID = "settings_open";
    public static const ABOUT_OPEN_ID = "about_open";
    public static const WINDDIRECTION_OPEN_ID = "winddirection_open";

    private var waypoint as WaypointsController;
    private var settings as SettingsController;
    private var waypointRetriever as WaypointServerRetriever;
    private var windDirectionController as WindDirectionControllerInterface;

    function initialize(
        waypoint as WaypointsController,
        settings as SettingsController,
        waypointRetriever as WaypointServerRetriever,
        windDirectionController as WindDirectionControllerInterface
    ) {
        Menu2InputDelegate.initialize();
        self.waypoint = waypoint;
        self.settings = settings;
        self.waypointRetriever = waypointRetriever;
        self.windDirectionController = windDirectionController;
    }

    function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String; 
        switch (id) {
            case WAYPOINTS_OPEN_ID:
                self.openWaypointsMenu();
                break;
            case SETTINGS_OPEN_ID:
                self.openSettingsMenu();
                break;
            case ABOUT_OPEN_ID:
                self.openAboutMenu();
                break;
            case WINDDIRECTION_OPEN_ID:
                self.openWindDirectionMenu();
                break;
            default:
                System.println("No action for id " + id);
        }
    }

    private function openWindDirectionMenu() as Void {
        var menuBuilder = new WindDirectionMenuBuilder(self.windDirectionController);
        WatchUi.pushView(
            menuBuilder.build(),
            new WindDirectionMenuDelegate(self.windDirectionController),
            WatchUi.SLIDE_LEFT
        );
    }

    private function openSettingsMenu() as Void {
        var menuBuilder = new SettingsMenuBuilder(self.settings);

        WatchUi.pushView(
            menuBuilder.build(),
            new SettingsMenuDelegate(self.settings),
            WatchUi.SLIDE_LEFT
        );
    }

    private function openWaypointsMenu() as Void {
        var menuBuilder = new WaypointsMenuBuilder(self.waypoint);

        WatchUi.pushView(
            menuBuilder.build(),
            new WaypointsMenuDelegate(self.waypoint, self.waypointRetriever),
            WatchUi.SLIDE_LEFT
        );
    }

    private function openAboutMenu() as Void {
        var menuBuilder = new AboutMenuBuilder();

        WatchUi.pushView(
            menuBuilder.build(),
            new AboutMenuDelegate(),
            WatchUi.SLIDE_LEFT
        );
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        getApp().onSettingsChanged();
    }
}