import Toybox.Lang;
import Toybox.Test;
import Toybox.Timer;

(:debug)
module WayfinderTests {
    class AppTimerTest {
        (:test)
        function testEmptyAppTimer(logger as Logger) as Boolean {
            var timer = new AppTimer(1000, new StubTimer());

            timer.call();
            timer.call();
            
            return true;
        }

        (:test)
        function testAppTimerStartsTimer(logger as Logger) as Boolean {
            var stubTimer = new StubTimer();
            var timer = new AppTimer(99, stubTimer);

            timer.start();

            Assert.isEqual(99, stubTimer.getTime());
            Assert.isEqual(true, stubTimer.isRepeat());
            
            return true;
        }

        (:test)
        function testCallsCallbacksAppTimer(logger as Logger) as Boolean {
            var timer = new AppTimer(1000, new StubTimer());
            var stubCallback = new StubCallback();
            
            Assert.isEqual(0, stubCallback.calledTimes());

            var method1 = new Method(stubCallback, :call);
            timer.add(method1);

            timer.call();
            Assert.isEqual(1, stubCallback.calledTimes());

            var method2 = new Method(stubCallback, :call);
            timer.add(method2);

            timer.call();

            Assert.isEqual(3, stubCallback.calledTimes());

            timer.remove(method1);
            timer.remove(method2);

            timer.call();

            Assert.isEqual(3, stubCallback.calledTimes());
            
            return true;
        }

        (:test)
        function testTimerCallsAppTimer(logger as Logger) as Boolean {
            var stubTimer = new StubTimer();
            var timer = new AppTimer(1000, stubTimer);
            var stubCallback = new StubCallback();
            
            Assert.isEqual(false, stubCallback.isCalled());

            var method1 = new Method(stubCallback, :call);
            timer.add(method1);

            Assert.isEqual(false, stubCallback.isCalled());

            timer.start();
            stubTimer.call();
            Assert.isEqual(true, stubCallback.isCalled());

            stubCallback.reset();
            Assert.isEqual(false, stubCallback.isCalled());
            timer.stop();
            stubTimer.call();
            Assert.isEqual(false, stubCallback.isCalled());

            return true;
        }
    }   
}