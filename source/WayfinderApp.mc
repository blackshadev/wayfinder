import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class WayfinderApp extends Application.AppBase {

    public var waypoint as WaypointController;
    public var activity as ActivityController;
    public var activityInfo as ActivityInfoProvider;
    public var sensor as SensorProvider;
    public var settings as SettingsController;
    public var speedAggregator as SpeedAggregationProvider;
    public var viewController as ViewController;

    function initialize() {
        AppBase.initialize();
        self.sensor = new SensorProvider();
        self.speedAggregator = new SpeedAggregationProvider(self.sensor);
        self.settings = new SettingsController();
        self.waypoint = new WaypointController(self.sensor);
        self.activity = new ActivityController(self.settings, self.speedAggregator);
        self.activityInfo = new ActivityInfoProvider(self.activity);
        
        self.viewController = new ViewController([
            new MainView(self.waypoint, self.activityInfo),
            new SpeedView(self.waypoint, self.activityInfo, self.speedAggregator)
        ]);
        var delegate = new WayfinderDelegate(
            self.viewController,
            self.waypoint,
            self.activity,
            self.settings
        );
        self.viewController.setDelegate(delegate);
    }

    function onStart(state as Dictionary?) as Void {
        self.waypoint.start();
    }

    function onStop(state as Dictionary?) as Void {
        self.waypoint.stop();
    }

    function getInitialView() {
        return self.viewController.getView();
    }

}

function getApp() as WayfinderApp {
    return Application.getApp() as WayfinderApp;
}