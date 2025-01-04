import Toybox.Lang;

class SpeedValue {
    public var current as Float;
    public var average as Float;
    public var max as Float;

    function initialize(
        current as Float,
        average as Float,
        max as Float
    ) {
        self.current = current;
        self.average = average;
        self.max = max;
    }

    public static function fromMPS(
        current as Float?,
        average as Float?,
        max as Float?
    ) as SpeedValue {
        if (current == null) {
            current = 0.0;
        }

        if (average == null) {
            average = 0.0;
        }

        if (max == null) {
            max = 0.0;
        }

        return new SpeedValue(
            current * 3.6,
            average * 3.6,
            max * 3.6
        );
    }
}