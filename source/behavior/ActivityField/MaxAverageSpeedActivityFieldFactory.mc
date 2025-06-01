import Toybox.ActivityRecording;
import Toybox.FitContributor;

class MaxAverageSpeedActivityFieldFactory extends ActivityFieldFactory {
    private var speedAggregator as SpeedAggregationProvider;

    function initialize(speedAggregator as SpeedAggregationProvider) {
        ActivityFieldFactory.initialize();
        
        self.speedAggregator = speedAggregator;
    }

    public function create(session as Session) as ActivityField {
        return new MaxAverageSpeedActivityField(session, self.speedAggregator);
    }
}