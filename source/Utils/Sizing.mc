import Toybox.System;
import Toybox.Lang;

module Utils {
    var Sizing = new _Sizing();

    class _Sizing {
        enum Size {
            Small,
            Normal
        }

        public var offset as Number;
        public var spacing as Number;
        public var spacingL as Number;
        public var arrow as Number;

        public var size as Size; 

        function initialize() {
            var settings = System.getDeviceSettings();
            var w = settings.screenWidth;
            var shape = settings.screenShape;
            
            if (w < 264) {
                self.size = Small;
                self.spacing = 0;
                self.spacingL = 5;
                self.offset = 10;
                self.arrow = 20;
            } else {
                self.size = Normal;
                self.spacing = 5;
                self.spacingL = 10;
                self.offset = 15;
                self.arrow = 30;
            }

        }
    }
}