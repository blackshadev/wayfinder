import Toybox.Lang;
import Toybox.Test;

module WayfinderTests {
    class FloatRingBufferTest {
        (:test)
        public function testEmptyFloatRingBuffer(logger as Logger) as Boolean {
            var buffer = new FloatRingBuffer(10);

            Assert.arrayIsEqual([0.0, 0.0, 0.0, 0.0], buffer.values([0, 1, 9, 5]));
            Assert.isEqual(0.0, buffer.value(6));

            return true;
        }

        (:test)
        public function testValues(logger as Logger) as Boolean {
            var buffer = new FloatRingBuffer(10);
            
            for (var iX = 0; iX < 12; iX++) {
                buffer.add(11.0 + iX);
            }

            for (var iX = 0; iX < 10; iX++) {
                buffer.add(1.0 + iX);
            }

            Assert.arrayIsEqual(
                [10.0, 1.0, 6.0, 9.0, 7.0, 4.0, 9.0], 
                buffer.values([0, 9, 4, 1, 3, 6, 11])
            );

            return true;
        }

        (:test)
        public function testReset(logger as Logger) as Boolean {
            var buffer = new FloatRingBuffer(10);
            
            for (var iX = 0; iX < 10; iX++) {
                buffer.add(11.0);
            }

            buffer.reset();
            Assert.isEqual(0.0, buffer.value(2));

            return true;
        }
    }
}