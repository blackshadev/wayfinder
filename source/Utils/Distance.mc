
import Toybox.Position;
import Toybox.Lang;
import Toybox.Math;

module Utils {
    class Distance {
        private static const R = 6371000; // Radius of the earth in meters

        /**
         * Calculates the distance in meters between two geographical points 
         * using the Haversine formula.
         */
        public static function between(pointA as Location, pointB as Location) as Float {
            var degreesA = pointA.toDegrees();
            var degreesB = pointB.toDegrees();

            var lat1 = deg2rad(degreesA[0]);
            var lon1 = deg2rad(degreesA[1]);
            var lat2 = deg2rad(degreesB[0]);
            var lon2 = deg2rad(degreesB[1]);

            var dlat = lat2 - lat1;
            var dlon = lon2 - lon1;

            var a = Math.pow(Math.sin(dlat / 2), 2) +
                Math.cos(lat1) * Math.cos(lat2) * Math.pow(Math.sin(dlon / 2), 2);
            var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
            var distance = R * c;

            return distance.toFloat();
        }

        /**
         * Calculates the distance in meters between two geographical points 
         * using the Equirectangular approximation.
         */
        public static function betweenApprox(pointA as Location, pointB as Location) as Float {
            var degreesA = pointA.toDegrees();
            var degreesB = pointB.toDegrees();

            var lat1 = deg2rad(degreesA[0]);
            var lon1 = deg2rad(degreesA[1]);
            var lat2 = deg2rad(degreesB[0]);
            var lon2 = deg2rad(degreesB[1]);

            var x = (lon2 - lon1) * Math.cos((lat1 + lat2) / 2);
            var y = lat2 - lat1;
            var distance = Math.sqrt(x * x + y * y) * R;
            return distance.toFloat();
        }


        private static function deg2rad(deg as Double) as Double {
            return deg * (Math.PI / 180);
        }
    }
}