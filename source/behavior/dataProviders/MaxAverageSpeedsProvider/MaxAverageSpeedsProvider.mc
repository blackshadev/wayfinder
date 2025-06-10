class MaxAverageSpeedsProvider {
    private var averageSpeeds as AverageSpeedsProviderInterface;

    private var maxAvgSpeed as MaxAverageSpeedValues;

    private var timer as TimerSubscription;

    function initialize(averageSpeeds as AverageSpeedsProviderInterface) {
        self.averageSpeeds = averageSpeeds;
        self.maxAvgSpeed = MaxAverageSpeedValues.empty();

        self.timer = AppTimer.subscribeOnSample(method(:update));
    }

    public function start() as Void {
        self.timer.start();
    }

    public function pause() as Void {
        self.timer.stop();
    }

    public function reset() as Void {
        self.pause();
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