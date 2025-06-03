import Toybox.ActivityRecording;
import Toybox.FitContributor;

class MaxAverageSpeedActivityFieldFactory extends ActivityFieldFactory {
    private var maxAverageSpeeds as MaxAverageSpeedsProvider;

    function initialize(maxAverageSpeeds as MaxAverageSpeedsProvider) {
        ActivityFieldFactory.initialize();
        
        self.maxAverageSpeeds = maxAverageSpeeds;
    }

    public function create(session as Session) as ActivityField {
        return new MaxAverageSpeedActivityField(session, self.maxAverageSpeeds);
    }
}