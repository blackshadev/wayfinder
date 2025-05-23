import Toybox.ActivityRecording;
import Toybox.FitContributor;

class AverageSpeedActivityFieldFactory extends ActivityFieldFactory {
    private var speedAggregator as SpeedAggregationProvider;

    function initialize(speedAggregator as SpeedAggregationProvider) {
        ActivityFieldFactory.initialize();
        
        self.speedAggregator = speedAggregator;
    }

    public function create(session as Session) as ActivityField {
        return new AverageSpeedActivityField(session, self.speedAggregator);
    }
}