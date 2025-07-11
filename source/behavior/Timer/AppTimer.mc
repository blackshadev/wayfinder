import Toybox.Lang;
import Toybox.Timer;

class AppTimer extends AppTimerInterface {
    public var time as Number = 0;

    private var _timer as Timer.Timer;
    private var _callbacks as Array<Method> = [];

    public function initialize(time as Number, timer as Timer.Timer) {
        AppTimerInterface.initialize();
        self._timer = timer;

        self.time = time;
    }

    public function start() as Void {
        self._timer.start(method(:call), self.time, true);
    }

    public function stop() as Void {
        self._timer.stop();
    }

    public function remove(ref as Method) as Void {
        self._callbacks.remove(ref);
    }

    public function add(ref as Method) as Void {
        self._callbacks.add(ref);
    }

    public function call() as Void {
        for (var iX = _callbacks.size() - 1; iX >= 0; iX--) {
            _callbacks[iX].invoke();
        }
    }

    public static function subscribeOnUpdate(callback as Method) as TimerSubscription {
        return new TimerSubscription(callback, getApp().updateTimer);
    }

    public static function subscribeOnSample(callback as Method) as TimerSubscription {
        return new TimerSubscription(callback, getApp().sampleTimer);
    }
}