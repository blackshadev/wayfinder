class MaxAverageSpeedsProvider {
    private var averageSpeeds as AverageSpeedsProviderInterface;

    private var maxAvgSpeed as MaxAverageSpeedValues;

    function initialize(averageSpeeds as AverageSpeedsProviderInterface) {
        self.averageSpeeds = averageSpeeds;
        self.maxAvgSpeed = MaxAverageSpeedValues.empty();
    }

    public function reset() as Void {
        self.maxAvgSpeed = MaxAverageSpeedValues.empty();
    }

    public function update() as Void {
        var values = self.averageSpeeds.value();

        if (values == null) {
            return;
        }

        self.maxAvgSpeed = self.maxAvgSpeed.combine(values);
    }

    public function value() as MaxAverageSpeedValues {
        return self.maxAvgSpeed;
    }    
}