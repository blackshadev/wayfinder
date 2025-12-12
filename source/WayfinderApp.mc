import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;

class WayfinderApp extends Application.AppBase {

    private var waypoint as WaypointsController;
    private var unitConverter as SettingsBoundUnitConverter;
    private var activity as ActivityController;
    private var activityInfo as ActivityInfoProvider;
    private var sensor as SensorProvider;
    private var location as LocationProvider;
    private var settings as SettingsController;
    private var averageSpeeds as AverageSpeedsProvider;
    private var maxAverageSpeeds as MaxAverageSpeedsProvider;
    private var viewController as ViewController;
    private var updateTimer as AppTimer;
    private var sampleTimer as AppTimer;
    private var waypointRetriever as WaypointServerRetriever;
    private var weatherProvider as WeatherProviderInterface;
    private var windDirectionController as WindDirectionControllerInterface;

    function initialize() {
        AppBase.initialize();

        self.updateTimer = new AppTimer(1000, new Timer.Timer());
        self.sampleTimer = new AppTimer(500, new Timer.Timer());

        AppTimer.setTimers(self.updateTimer, self.sampleTimer);

        self.settings = new SettingsController();
        self.unitConverter = new SettingsBoundUnitConverter(self.settings);

        self.sensor = new SensorProvider();
        self.weatherProvider = new GarminWeatherProvider();
        self.windDirectionController = new WindDirectionController(self.sensor, self.weatherProvider);

        self.averageSpeeds = new AverageSpeedsProvider(self.sensor, new Timer.Timer());
        self.maxAverageSpeeds = new MaxAverageSpeedsProvider(self.averageSpeeds);
        self.location = new LocationProvider();
        self.waypoint = new WaypointsController(
            self.location, 
            self.sensor, 
            new WaypointStorage(),
            self.settings,
            self.unitConverter
        );
        
        self.waypointRetriever = new WaypointServerRetriever(
            new WaypointServerClient(),
            self.waypoint
        );

        self.activity = new ActivityController(
            self.settings,
            self.sampleTimer,
            self.averageSpeeds,
            self.maxAverageSpeeds,
            [
                new GpsInformationFieldFactory(self.location),
                new AverageSpeedActivityFieldFactory(self.averageSpeeds),
                new MaxAverageSpeedActivityFieldFactory(self.maxAverageSpeeds),
            ],
            self.weatherProvider
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
            self.windDirectionController
        );

        var delegate = new WayfinderDelegate(
            self.viewController,
            self.waypoint,
            self.activity,
            self.settings,
            self.waypointRetriever,
            self.windDirectionController
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