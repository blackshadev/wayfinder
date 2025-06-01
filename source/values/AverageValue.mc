import Toybox.Lang;

class AverageValue {
    public var value as Float;
    public var isComplete as Boolean;

    function initialize(speed as Float, isComplete as Boolean) {
        self.value = speed;
        self.isComplete = isComplete;
    }

    public static function empty() as AverageValue {
        return new AverageValue(0.0, false);
    }

    public static function fromSample(
        value as Float,
        sampleCount as Number,
        targetSampleCount as Number
    ) as AverageValue {
        var isComplete = sampleCount >= targetSampleCount;
        return new AverageValue(value, isComplete);
    }
}