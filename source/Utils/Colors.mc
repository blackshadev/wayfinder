import Toybox.Graphics;

module Utils {
    var Colors as _Colors = new _Colors(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE, Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);

    class _Colors {
        public var background as ColorValue;
        public var foreground as ColorValue;
        public var greyBackground as ColorValue; 
        public var greyForeground as ColorValue; 

        function initialize(
            background as ColorValue,
            foreground as ColorValue,
            greyBackground as ColorValue,
            greyForeground as ColorValue 
        ) {
            self.background = background;
            self.foreground = foreground;
            self.greyBackground = greyBackground;
            self.greyForeground = greyForeground;
        }

        public static function switchToBlackBackground() as Void {
            Utils.Colors = new _Colors(
                Graphics.COLOR_BLACK,
                Graphics.COLOR_WHITE,
                Graphics.COLOR_DK_GRAY,
                Graphics.COLOR_LT_GRAY
            );
        }

        public static function switchToWhiteBackground() as Void {
            Utils.Colors = new _Colors(
                Graphics.COLOR_WHITE,
                Graphics.COLOR_BLACK,
                Graphics.COLOR_LT_GRAY,
                Graphics.COLOR_DK_GRAY
            );
        }
    }
}