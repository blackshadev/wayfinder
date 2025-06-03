import Toybox.Lang;

class SpeedAggregatorHelper {
    public static function sampleTime(aggregator as AverageSpeedsProvider, timeInS as Number) as Void {
        for (var i = 0; i < timeInS * 2; i++) {
            aggregator.sample();
        }
    }
}