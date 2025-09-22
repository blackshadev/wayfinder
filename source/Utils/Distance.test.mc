import Toybox.Position;
import Toybox.Lang;
import Toybox.Test;

(:debug)
module WayfinderTests {
    module Utils {
        (:debug)
        class DistanceTest {
            
            (:test)
            function testDistanceBetweenBerlinParis(logger as Logger) as Boolean {
                var berlin = new Position.Location({
                    :latitude => 52.52437,
                    :longitude => 13.41053,
                    :format => :degrees
                }); // Berlin
                var paris = new Position.Location({
                    :latitude => 48.85341,
                    :longitude => 2.3488,
                    :format => :degrees
                }); // Paris

                var distance = $.Utils.Distance.between(berlin, paris);
                Assert.isApproxEqual(878397, distance, 1);

                var approxDistance = $.Utils.Distance.betweenApprox(berlin, paris);
                Assert.isApproxEqual(879686, approxDistance, 1);

                return true;
            }

            (:test)
            function testDistanceBetweenSchelpAndHaven(logger as Logger) as Boolean {
                var schelp = new Position.Location({
                    :latitude => 52.315129,
                    :longitude => 5.161948,
                    :format => :degrees
                }); // Schelp
                var haven = new Position.Location({
                    :latitude => 52.3350759,
                    :longitude => 5.2013739,
                    :format => :degrees
                }); // Haven

                var distance = $.Utils.Distance.between(schelp, haven);
                Assert.isApproxEqual(3.49, distance / 1000, 0.05);

                var approxDistance = $.Utils.Distance.betweenApprox(schelp, haven);
                Assert.isApproxEqual(3.49, approxDistance / 1000, 0.05);

                // On small scale both methods should yield similar results
                Assert.isApproxEqual(distance, approxDistance, 0.1);

                return true;
            }
        }
    }
}