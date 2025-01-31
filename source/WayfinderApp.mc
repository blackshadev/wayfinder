import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class WayfinderApp extends Application.AppBase {

    public var waypoint as WaypointController;
    public var unitConverter as UnitConverter;
    public var activity as ActivityController;
    public var activityInfo as ActivityInfoProvider;
    public var sensor as SensorProvider;
    public var settings as SettingsController;
    public var speedAggregator as SpeedAggregationProvider;
    public var viewController as ViewController;

    function initialize() {
        AppBase.initialize();
        self.settings = new SettingsController();
        self.unitConverter = new UnitConverter(self.settings);

        self.sensor = new SensorProvider();
        self.speedAggregator = new SpeedAggregationProvider(self.sensor);
        self.waypoint = new WaypointController(self.sensor);
        self.activity = new ActivityController(self.settings, self.speedAggregator);
        self.activityInfo = new ActivityInfoProvider(self.activity);
        
        self.viewController = new ViewController(self.activity);

        var delegate = new WayfinderDelegate(
            self.viewController,
            self.waypoint,
            self.activity,
            self.settings
        );

        self.viewController.setDelegate(delegate);
        self.resetViews();
    }

    function onSettingsChanged() as Void {
        self.settings.applyFromStorage();

        self.resetViews();
    }

    private function resetViews() as Void {
        self.viewController.setViews([
            new MainView(self.waypoint, self.activityInfo, self.unitConverter),
            new SpeedView(self.waypoint, self.activityInfo, self.speedAggregator, self.unitConverter)
        ]);
        self.viewController.resetView();
    }

    function onStart(state as Dictionary?) as Void {
        self.waypoint.start();
    }

    function onStop(state as Dictionary?) as Void {
        self.waypoint.stop();
    }

    function getInitialView() as [ WatchUi.Views ] or [ WatchUi.Views, WatchUi.InputDelegates ] {
        return self.viewController.getView();
    }
}

function getApp() as WayfinderApp {
    return Application.getApp() as WayfinderApp;
}