import Toybox.Lang;
import Toybox.Timer;

class TimerSubscription {
    private var _method as Method;
    private var _timer as AppTimer;

    function initialize(method as Method, timer as AppTimer) {
        self._method = method;
        self._timer = timer;
    }

    public function stop() as Void {
        self._timer.remove(self._method);
    }

    public function start() as Void {
        self._timer.add(self._method);
    }
}