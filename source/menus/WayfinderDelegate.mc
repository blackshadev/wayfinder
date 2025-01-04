import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class WayfinderDelegate extends WatchUi.BehaviorDelegate {
    private var waypoint as WaypointController;
    private var activity as ActivityController;
    private var settings as SettingsController;
    private var viewController as ViewController;

    function initialize(
        viewController as ViewController,
        waypoint as WaypointController,
        activity as ActivityController,
        settings as SettingsController
    ) {
        BehaviorDelegate.initialize();

        self.viewController = viewController;
        self.waypoint = waypoint;
        self.activity = activity;
        self.settings = settings;
    }

    function onKey(keyEvent) {
        if (keyEvent.getKey() == WatchUi.KEY_ENTER) {
            self.doSelectKey();
        }

        return true;
    }

    function onMenu() as Boolean {
        var menuBuilder = new MainMenuBuilder(self.waypoint);

        WatchUi.pushView(
            menuBuilder.build(),
            new MainMenuDelegate(self.waypoint, self.settings),
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
        self.viewController.reset();
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