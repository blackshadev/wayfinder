import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;

module Utils {
    var Offsets = new _Offsets();

    class _Offsets {
        private const INSTINCT_3_SOLAR = "006-B4585-00";
        private const INSTINCT_2X_SOLAR = "006-B4394-00";
        private const INSTINCT_2S_SOLAR = "006-B3889-00";
        private const INSTINCT_2_SOLAR = "006-B3888-00";

        public var tl as Graphics.Point2D = [0, 0];
        public var tr as Graphics.Point2D = [0, 0];
        public var bl as Graphics.Point2D = [0, 0];
        public var br as Graphics.Point2D = [0, 0];
        
        function initialize() {
            var settings = System.getDeviceSettings();
            var w = settings.screenWidth;

            if (w < 264) {
                self.setAll(10);
            } else {
                self.setAll(15);
            }

            var shouldOffsetTopRightForSolarDevices = [
                INSTINCT_2_SOLAR,
                INSTINCT_2S_SOLAR,
                INSTINCT_2X_SOLAR,
                INSTINCT_3_SOLAR
            ].indexOf(settings.partNumber) > -1;

            if (shouldOffsetTopRightForSolarDevices) {
                self.tr = [self.tr[0] + 18, self.tr[1] - 30];
            }
        }

        private function setAll(pos as Number) as Void {
            self.tl = [-pos, -pos];
            self.tr = [pos, -pos];
            self.bl = [-pos, pos];
            self.br = [pos, pos];
        }
    }
}