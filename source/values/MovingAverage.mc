import Toybox.Lang;

class MovingAverage {
    private var limit as Number;
    private var totalSum as Float = 0.0;
    private var count as Number = 0;

    function initialize(limit as Number) {
        self.limit = limit;
    }

    public function add(newValue as Float, oldValue as Float) as Void {
        if (self.count < self.limit) {
            self.count += 1;
        }

        self.totalSum = (self.totalSum - oldValue) + newValue;
    }

    public function value() as AverageValue {
        if (count == 0) {
            return AverageValue.empty();
        }

        return AverageValue.fromSample(
            self.totalSum / self.count, 
            self.count, 
            self.limit
        );
    }


    public function reset() as Void {
        self.count = 0;
        self.totalSum = 0.0;
    }
}