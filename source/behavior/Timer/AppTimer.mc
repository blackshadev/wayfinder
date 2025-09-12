import Toybox.Lang;
import Toybox.Timer;

class AppTimer extends AppTimerInterface {
    public var _time as Number = 1000;

    private var _timer as Timer.Timer;
    private var _callbacks as Array<Method> = [];

    public function initialize(time as Number, timer as Timer.Timer) {
        AppTimerInterface.initialize();
        self._timer = timer;

        self._time = time;
    }

    public function time() as Number {
        return self._time;
    }

    public function start() as Void {
        self._timer.start(method(:call), self._time, true);
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

    public static var updateTimer as AppTimerInterface = new EmptyAppTimer();
    public static var sampleTimer as AppTimerInterface = new EmptyAppTimer();

    public static function setTimers(update as AppTimerInterface, sample as AppTimerInterface) as Void {
        AppTimer.updateTimer = update;
        AppTimer.sampleTimer = sample;
    }

    (:debug)
    public static function mockTimers() as WayfinderTests.StubAppTimer {
        var timer = new WayfinderTests.StubAppTimer();
        
        AppTimer.setTimers(timer, timer);
        
        return timer;
    }

    public static function resetTimers() as Void {
        var emptyTimer = new EmptyAppTimer();
        AppTimer.setTimers(emptyTimer, emptyTimer);
    }

    public static function onUpdate() as TimerSubscription {
        return new TimerSubscription(AppTimer.updateTimer);
    }

    public static function onSample() as TimerSubscription {
        return new TimerSubscription(AppTimer.sampleTimer);
    }
}