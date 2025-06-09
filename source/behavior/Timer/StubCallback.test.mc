import Toybox.Lang;

(:debug)
class StubCallback {
    private var _called as Number = 0;

    public function call() as Void {
        self._called++;
    }

    public function isCalled() as Boolean {
        return self._called > 0;
    }

    public function calledTimes() as Number {
        return self._called;
    }

    public function reset() as Void {
        self._called = 0;
    }
}