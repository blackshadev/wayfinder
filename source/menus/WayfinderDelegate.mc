import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class WayfinderDelegate extends WatchUi.BehaviorDelegate {
    private var waypoint as WaypointsController;
    private var activity as ActivityController;
    private var settings as SettingsController;
    private var waypointRetriever as WaypointServerRetriever;
    private var viewController as ViewController;
    private var windDirectionController as WindDirectionControllerInterface;

    function initialize(
        viewController as ViewController,
        waypoint as WaypointsController,
        activity as ActivityController,
        settings as SettingsController,
        waypointRetriever as WaypointServerRetriever,
        windDirectionController as WindDirectionControllerInterface
    ) {
        BehaviorDelegate.initialize();

        self.viewController = viewController;
        self.waypoint = waypoint;
        self.activity = activity;
        self.settings = settings;
        self.waypointRetriever = waypointRetriever;
        self.windDirectionController = windDirectionController;
    }

    function onKey(keyEvent) {
        if (keyEvent.getKey() == WatchUi.KEY_ENTER) {
            self.doSelectKey();
        }

        return true;
    }

    function onMenu() as Boolean {
        var menuBuilder = new MainMenuBuilder();

        WatchUi.pushView(
            menuBuilder.build(),
            new MainMenuDelegate(self.waypoint, self.settings, self.waypointRetriever, self.windDirectionController),
            WatchUi.SLIDE_LEFT
        );

        return true;
    }

    function onNextPage() as Boolean {
        self.viewController.next();
        return true;
    }
    
    function onPreviousPage()  as Boolean {
        self.viewController.previous();
        return true;
    }

    function onBack()  as Boolean {
        self.viewController.back();

        return true;
    }

    private function doSelectKey() as Void {
        if (!self.activity.isStarted()) {
            self.doStart();
        } else {
            self.doStop();
        }
    }

    private function doStart() as Void {
        self.activity.start();
        self.waypoint.autoSet();

        WatchUi.requestUpdate();
    }

    private function doStop() as Void {
        var menuBuilder = new ActivityMenuBuilder(self.activity);

        WatchUi.pushView(
            menuBuilder.build(),
            new ActivityMenuDelegate(self.activity),
            WatchUi.SLIDE_RIGHT
        );
    }
}