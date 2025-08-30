import Toybox.ActivityRecording;
import Toybox.Activity;
import Toybox.Lang;
import Toybox.WatchUi;

class ViewController {
    private const VIEW_MAIN = 0;
    private const VIEW_AVG_SPEED = 1;
    private const VIEW_MAX_AVG_SPEED = 2;
    private const VIEW_MAP = 3;

    private var views as Array<Number> = [VIEW_MAIN, VIEW_AVG_SPEED, VIEW_MAX_AVG_SPEED];
    private var viewCache as Array<WatchUi.Views?> = [null, null, null, null];
    private var iX as Number = 0;
    private var dir as Number = 0;
    private var activity as ActivityController;
    private var waypoint as WaypointsController;
    private var activityInfo as ActivityInfoProvider;
    private var averageSpeeds as AverageSpeedsProvider;
    private var maxAverageSpeeds as MaxAverageSpeedsProvider;
    private var unitConverter as SettingsBoundUnitConverter;
    private var settings as SettingsController;

    private var delegate as WayfinderDelegate? = null;

    function initialize(
        activity as ActivityController,
        waypoint as WaypointsController,
        activityInfo as ActivityInfoProvider,
        averageSpeeds as AverageSpeedsProvider, 
        maxAverageSpeeds as MaxAverageSpeedsProvider, 
        unitConverter as SettingsBoundUnitConverter,
        settings as SettingsController
    ) {
        self.activity = activity;
        self.waypoint = waypoint;
        self.activityInfo = activityInfo;
        self.averageSpeeds = averageSpeeds;
        self.maxAverageSpeeds = maxAverageSpeeds;
        self.unitConverter = unitConverter;
        self.settings = settings;

        if (WatchUi has :MapTrackView) {
            self.views.add(VIEW_MAP);
        }
    }

    function setDelegate(delegate as WayfinderDelegate) as Void {
        self.delegate = delegate;
    }

    function back() as Void {
        if (self.iX == 0) {
            self.confirmExitMenu();
            return;
        }

        self.reset();
    }

    function confirmExitMenu() as Void {
         var menuBuilder = new ExitMenuBuilder(self.activity);

        WatchUi.pushView(
            menuBuilder.build(),
            new ExitMenuDelegate(self.activity),
            WatchUi.SLIDE_LEFT
        );
    }

    function reset() as Void {
        if (self.iX == 0) {
            return;
        }

        self.iX = 0;

        WatchUi.switchToView(
            self.getView(),
            self.getDelegate(),
            self.backAnimation()
        );
    }

    function next() as Void {
        self.iX = (self.iX + 1) % self.views.size();
        self.dir = 1;

        WatchUi.switchToView(
            self.getView(),
            self.getDelegate(),
            WatchUi.SLIDE_UP
        );
    }

    function previous() as Void {
        self.iX = self.iX - 1;
        if (self.iX < 0) {
            self.iX = self.views.size() + self.iX;
        }

        self.dir = -1;

        WatchUi.switchToView(
            self.getView(),
            self.getDelegate(),
            WatchUi.SLIDE_DOWN
        );
    }

    public function resetView() as Void {
        self.viewCache = [null, null, null, null];

        WatchUi.switchToView(
            self.getView(),
            self.getDelegate(),
            WatchUi.SLIDE_IMMEDIATE
        );

        WatchUi.requestUpdate();
    }

    private function backAnimation() as WatchUi.SlideType {
        if (self.dir == -1) {
            return WatchUi.SLIDE_UP;
        }

        return WatchUi.SLIDE_DOWN;
    }

    function getView() as WatchUi.Views {
        if (self.viewCache[self.iX] != null) {
            return self.viewCache[self.iX];
        }

        var view = self.createView();
        // self.viewCache[self.iX] = view;
        return view;
    }

    private function createView() as WatchUi.Views {
        switch (self.views[self.iX]) {
            case VIEW_AVG_SPEED:
                return new AverageSpeedView(self.waypoint, self.activityInfo, self.averageSpeeds, self.unitConverter, self.settings);
            case VIEW_MAX_AVG_SPEED:
                return new MaxAverageSpeedView(self.waypoint, self.activityInfo, self.maxAverageSpeeds, self.unitConverter, self.settings);
            case VIEW_MAP:
                return new MapView(self.waypoint, self.settings);
            case VIEW_MAIN: 
            default:
                return new MainView(self.waypoint, self.activityInfo, self.unitConverter, self.settings);
        }
    }

    function getDelegate() as WatchUi.InputDelegates {
        return self.delegate;        
    }
}