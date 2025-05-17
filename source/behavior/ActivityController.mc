import Toybox.ActivityRecording;
import Toybox.Activity;
import Toybox.WatchUi;
import Toybox.FitContributor;
import Toybox.Lang;
import Toybox.Timer;

class ActivityController {
    private const FIELD_ID_AVG_SPEED_2S = 1;
    private const FIELD_ID_AVG_SPEED_10S = 2;
    private const FIELD_ID_AVG_SPEED_30M = 3;
    private const FIELD_ID_AVG_SPEED_60M = 4;

    private const UPDATE_TIME = 1000;

    private var settings as SettingsController;
    private var speedAggregator as SpeedAggregationProvider;

    private var session as ActivityRecording.Session? = null;
    private var field2s as FitContributor.Field? = null;
    private var field10s as FitContributor.Field? = null;
    private var field30m as FitContributor.Field? = null;
    private var field60m as FitContributor.Field? = null;

    private var updateTimer as Timer.Timer;

    function initialize(settings as SettingsController, speedAggregator as SpeedAggregationProvider) {
        self.settings = settings;
        self.speedAggregator = speedAggregator;

        self.updateTimer = new Timer.Timer();
    }

    public function start() as Void {
        if (self.session != null) {
            throw new ActivityAlreadyStarted();
        }

        var opts = self.getActivitySettings();
        self.session = ActivityRecording.createSession(opts);

        self.createField();
        self.session.start();
        self.speedAggregator.start();
        self.startUpdateValuesTimer();
    }

    private function createField() as Void {
        var speedFieldConfig = { 
            :mesgType => FitContributor.MESG_TYPE_RECORD, 
            :units => WatchUi.loadResource(self.settings.unitsSpeedRes())
        };

        self.field2s = self.session.createField(
            WatchUi.loadResource(Rez.Strings.labelAvgSpeed2s),
            FIELD_ID_AVG_SPEED_2S,
            FitContributor.DATA_TYPE_FLOAT,
            speedFieldConfig
        );

        self.field10s = self.session.createField(
            WatchUi.loadResource(Rez.Strings.labelAvgSpeed10s),
            FIELD_ID_AVG_SPEED_10S,
            FitContributor.DATA_TYPE_FLOAT,
            speedFieldConfig
        );

        self.field30m = self.session.createField(
            WatchUi.loadResource(Rez.Strings.labelAvgSpeed30m),
            FIELD_ID_AVG_SPEED_30M,
            FitContributor.DATA_TYPE_FLOAT,
            speedFieldConfig
        );

        self.field60m = self.session.createField(
            WatchUi.loadResource(Rez.Strings.labelAvgSpeed60m),
            FIELD_ID_AVG_SPEED_60M,
            FitContributor.DATA_TYPE_FLOAT,
            speedFieldConfig
        );
    }

    public function resume() as Void {
        if (self.session == null) {
            throw new ActivityNotStarted();
        }

        self.session.start();
        self.speedAggregator.start();
        self.startUpdateValuesTimer();
    }

    public function pause() as Void {
        if (self.session == null) {
            throw new ActivityNotStarted();
        }

        self.stopUpdateValuesTimer();
        self.speedAggregator.pause();

        self.session.stop();
    }

    public function discard() as Void {
        if (self.session == null) {
            throw new ActivityNotStarted();
        }

        self.stopUpdateValuesTimer();
        self.speedAggregator.reset();

        self.session.stop();
        self.session.discard();
        self.session = null;
        self.field2s = null;
        self.field10s = null;
        self.field30m = null;
        self.field60m = null;
    }

    public function save() as Void {
        if (self.session == null) {
            throw new ActivityNotStarted();
        }

        self.stopUpdateValuesTimer();
        self.speedAggregator.reset();

        self.session.stop();
        self.session.save();
        self.session = null;
        self.field2s = null;
        self.field10s = null;
        self.field30m = null;
        self.field60m = null;
    } 

    public function isStarted() as Boolean {
        return self.session != null;
    }


    public function isPaused() as Boolean {
        if (!self.isStarted()) {
            return false;
        }

        return !self.session.isRecording();
    }

    private function stopUpdateValuesTimer() as Void {
        self.updateTimer.stop();
    }

    private function startUpdateValuesTimer() as Void {
        self.updateTimer.start(method(:updateValues), UPDATE_TIME, true);
    }

    public function updateValues() as Void {
        if (self.field2s == null || self.field10s == null) {
            return;
        }

        var value = self.speedAggregator.value();
        self.field2s.setData(value.speed2s);
        self.field10s.setData(value.speed10s);
        self.field30m.setData(value.speed30m);
        self.field60m.setData(value.speed60m);
    }

    private function getActivitySettings() {
        var activityType = self.settings.activityType();
        
        switch (activityType) {
            case SettingsController.ACTIVITY_WINDSURFING:  
                return {
                    :name => "Windsurfing",
                    :sport => Activity.SPORT_WINDSURFING,
                    :subSport => Activity.SUB_SPORT_GENERIC
                };
            case SettingsController.ACTIVITY_KITESURFING:  
                return {
                    :name => "Kitesurfing",
                    :sport => Activity.SPORT_KITESURFING,
                    :subSport => Activity.SUB_SPORT_GENERIC
                };
            case SettingsController.ACTIVITY_SURFING:  
                return {
                    :name => "Surfing",
                    :sport => Activity.SPORT_SURFING,
                    :subSport => Activity.SUB_SPORT_OPEN_WATER
                };
            case SettingsController.ACTIVITY_OPENWATER_SWIMMING:  
                return {
                    :name => "Openwater Swimming",
                    :sport => Activity.SPORT_SWIMMING,
                    :subSport => Activity.SUB_SPORT_OPEN_WATER
                };
            default: 
                return {
                    :name => "Generic",
                    :sport => Activity.SPORT_GENERIC,
                    :subSport => Activity.SUB_SPORT_GENERIC
                };
        }
    }
}