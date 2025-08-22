import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;

class WayfinderApp extends Application.AppBase {

    public var waypoint as WaypointController;
    public var unitConverter as SettingsBoundUnitConverter;
    public var activity as ActivityController;
    public var activityInfo as ActivityInfoProvider;
    public var sensor as SensorProvider;
    public var location as LocationProvider;
    public var settings as SettingsController;
    public var averageSpeeds as AverageSpeedsProvider;
    public var maxAverageSpeeds as MaxAverageSpeedsProvider;
    public var viewController as ViewController;
    public var updateTimer as AppTimer;
    public var sampleTimer as AppTimer;
    public var waypointRetriever as WaypointServerRetriever;

    function initialize() {
        AppBase.initialize();

        self.updateTimer = new AppTimer(1000, new Timer.Timer());
        self.sampleTimer = new AppTimer(500, new Timer.Timer());

        self.settings = new SettingsController();
        self.unitConverter = new SettingsBoundUnitConverter(self.settings);

        self.sensor = new SensorProvider();
        self.waypointRetriever = new WaypointServerRetriever(
            new WaypointServerClient()
        );
        self.averageSpeeds = new AverageSpeedsProvider(self.sensor, new Timer.Timer());
        self.maxAverageSpeeds = new MaxAverageSpeedsProvider(self.averageSpeeds);
        self.location = new LocationProvider();
        self.waypoint = new WaypointController(self.location, self.sensor);
        self.activity = new ActivityController(
            self.settings,
            self.sampleTimer,
            self.averageSpeeds,
            self.maxAverageSpeeds,
            [
                new GpsInformationFieldFactory(self.location),
                new AverageSpeedActivityFieldFactory(self.averageSpeeds),
                new MaxAverageSpeedActivityFieldFactory(self.maxAverageSpeeds),
            ]
        );
        self.activityInfo = new ActivityInfoProvider(self.activity);
        
        self.viewController = new ViewController(
            self.activity,
            self.waypoint,
            self.activityInfo,
            self.averageSpeeds,
            self.maxAverageSpeeds, 
            self.unitConverter,
            self.settings,
            self.waypointRetriever
        );

        var delegate = new WayfinderDelegate(
            self.viewController,
            self.waypoint,
            self.activity,
            self.settings
        );

        self.viewController.setDelegate(delegate);
    }

    function onSettingsChanged() as Void {
        self.settings.applyFromStorage();
        
        self.viewController.resetView();
    }

    function onStart(state as Dictionary?) as Void {
        self.location.start();
        self.updateTimer.start();
        self.sampleTimer.start();
    }

    function onStop(state as Dictionary?) as Void {
        self.location.stop();
        self.updateTimer.stop();
        self.sampleTimer.stop();
    }

    function getInitialView() as [ WatchUi.Views ] or [ WatchUi.Views, WatchUi.InputDelegates ] {
        return [self.viewController.getView(), self.viewController.getDelegate()];
    }
}

function getApp() as WayfinderApp {
    return Application.getApp() as WayfinderApp;
}