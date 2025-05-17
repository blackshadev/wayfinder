import Toybox.Lang;
import Toybox.Test;

module WayfinderTests {
    class FloatRingBufferTest {
        (:test)
        public function testEmptyFloatRingBuffer(logger as Logger) as Boolean {
            var buffer = new FloatRingBuffer(10, 1.0);
            Assert.isEqual(1.0, buffer.max(10));

            return true;
        }

        (:test)
        public function tetAddAndMaxWithinLimits(logger as Logger) as Boolean {
            var buffer = new FloatRingBuffer(10, 0.0);
            
            buffer.add(10.0);
            buffer.add(9.0);
            buffer.add(8.0);
            buffer.add(7.0);

            Assert.isEqual(7.0, buffer.max(1));
            Assert.isEqual(8.0, buffer.max(2));
            Assert.isEqual(9.0, buffer.max(3));
            Assert.isEqual(10.0, buffer.max(4));
            Assert.isEqual(10.0, buffer.max(5));

            return true;
        }

        (:test)
        public function testAddAndMaxOutsideLimits(logger as Logger) as Boolean {
            var buffer = new FloatRingBuffer(10, 0.0);
            
            buffer.add(50.0);
            for (var iX = 0; iX < 100; iX++) {
                buffer.add(15.0);
            }
            buffer.add(10.0);
            

            Assert.isEqual(10.0, buffer.max(1));
            Assert.isEqual(15.0, buffer.max(2));
            Assert.isEqual(15.0, buffer.max(100));

            return true;
        }

        (:test)
        public function testValues(logger as Logger) as Boolean {
            var buffer = new FloatRingBuffer(10, 0.0);
            
            for (var iX = 0; iX < 12; iX++) {
                buffer.add(11.0 + iX);
            }

            for (var iX = 0; iX < 10; iX++) {
                buffer.add(1.0 + iX);
            }

            Assert.arrayIsEqual(
                [10.0, 1.0, 6.0, 9.0, 7.0, 4.0], 
                buffer.values([0, 9, 4, 1, 3, 6])
            );

            return true;
        }
    }
}