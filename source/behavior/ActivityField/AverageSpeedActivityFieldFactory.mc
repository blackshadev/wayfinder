import Toybox.ActivityRecording;
import Toybox.FitContributor;

class AverageSpeedActivityFieldFactory extends ActivityFieldFactory {
    private var averageSpeeds as AverageSpeedsProvider;

    function initialize(averageSpeeds as AverageSpeedsProvider) {
        ActivityFieldFactory.initialize();
        
        self.averageSpeeds = averageSpeeds;
    }

    public function create(session as Session) as ActivityField {
        return new AverageSpeedActivityField(session, self.averageSpeeds);
    }
}