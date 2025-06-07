import Toybox.ActivityRecording;
import Toybox.Activity;
import Toybox.WatchUi;
import Toybox.FitContributor;
import Toybox.Lang;
import Toybox.Timer;

class ActivityController {
    private var settings as SettingsController;
    private var averageSpeeds as AverageSpeedsProvider;
    private var activityFieldFactories as Array<ActivityFieldFactory>;
    private var activityFields as Array<ActivityField> = [];

    private var session as ActivityRecording.Session? = null;


    function initialize(settings as SettingsController, averageSpeeds as AverageSpeedsProvider, activityFieldFactories as Array<ActivityFieldFactory>) {
        self.settings = settings;
        self.averageSpeeds = averageSpeeds;
        self.activityFieldFactories = activityFieldFactories;
    }

    public function start() as Void {
        if (self.session != null) {
            throw new ActivityAlreadyStarted();
        }

        var opts = self.getActivitySettings();
        self.session = ActivityRecording.createSession(opts);

        self.activityFields = [];
        for (var iX = 0; iX < self.activityFieldFactories.size(); iX++) {
            self.activityFields.add(self.activityFieldFactories[iX].create(session));
        }

        self.resume();
    }

    public function resume() as Void {
        if (self.session == null) {
            return;
        }

        self.session.start();
        self.averageSpeeds.start();
        
        for (var iX = 0; iX < self.activityFieldFactories.size(); iX++) {
            self.activityFields[iX].start();
        }
    }

    public function pause() as Void {
        if (self.session == null) {
            return;
        }

        for (var iX = 0; iX < self.activityFieldFactories.size(); iX++) {
            self.activityFields[iX].stop();
        }
        self.averageSpeeds.pause();
        self.session.stop();
    }

    public function discard() as Void {
        if (self.session == null) {
            return;
        }

        for (var iX = 0; iX < self.activityFieldFactories.size(); iX++) {
            self.activityFields[iX].stop();
            self.activityFields[iX].reset();
        }

        self.averageSpeeds.reset();
        self.session.stop();
        self.session.discard();

        self.activityFields = [];
        self.session = null;
    }

    public function save() as Void {
        if (self.session == null) {
            return;
        }

        for (var iX = 0; iX < self.activityFieldFactories.size(); iX++) {
            self.activityFields[iX].stop();
        }

        self.averageSpeeds.reset();

        self.session.stop();
        self.session.save();
        self.session = null;

        self.activityFields = [];
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