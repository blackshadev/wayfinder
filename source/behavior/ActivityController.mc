import Toybox.ActivityRecording;
import Toybox.Activity;
import Toybox.FitContributor;
import Toybox.Lang;
import Toybox.Timer;

class ActivityController {
    private const UPDATE_TIME = 1000;

    private var settings as SettingsController;
    private var speedAggregator as SpeedAggregationProvider;

    private var session as ActivityRecording.Session? = null;
    private var field2s as FitContributor.Field? = null;
    private var field10s as FitContributor.Field? = null;
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

        var opts = getActivitySettings();
        self.session = ActivityRecording.createSession(opts);

        var speedFieldConfig = { :mesgType => FitContributor.MESG_TYPE_RECORD, :units => "MPS" };
        self.field2s = self.session.createField("max speed 2s", 1, FitContributor.DATA_TYPE_FLOAT, speedFieldConfig);
        self.field10s = self.session.createField("max speed 10s", 2, FitContributor.DATA_TYPE_FLOAT, speedFieldConfig);

        self.session.start();
        self.speedAggregator.start();
        self.startUpdateValuesTimer();
    }

    public function resume() as Void {
        if (self.session == null) {
            throw new ActivityNotStarted();
        }

        self.session.start();
        self.startUpdateValuesTimer();
    }

    public function pause() as Void {
        if (self.session == null) {
            throw new ActivityNotStarted();
        }

        self.stopUpdateValuesTimer();
        self.speedAggregator.stop();

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

    public function updateValues() as Void 
    {
        if (self.field2s == null || self.field10s == null) {
            return;
        }

        var value = self.speedAggregator.value();
        self.field2s.setData(value.speed2sMPS());
        self.field10s.setData(value.speed10sMPS());
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