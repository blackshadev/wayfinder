import Toybox.Lang;
import Toybox.Test;

(:debug)
module WayfinderTests {
    class TimerSubscriptionTest {
        (:test)
        function testTimerSubscription(logger as Logger) as Boolean {
            var stubCallback = new StubCallback();
            var stubTimer = new StubAppTimer();

            var method = new Method(stubCallback, :call);
            var sub = new TimerSubscription(method, stubTimer);

            Assert.isEqual(false, stubTimer.contains(method));

            sub.start();
            Assert.isEqual(true, stubTimer.contains(method));

            sub.stop();
            Assert.isEqual(false, stubTimer.contains(method));

            return true;
        }
    }
}