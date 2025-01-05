import Toybox.Lang;
import Toybox.Graphics;

module Utils {
    var Fonts as _Fonts = new _Fonts();

    class _Fonts {
        private var _extraTinyFont as Graphics.FontType? = null;

        public function extraTinyFont() as Graphics.FontType {
            if (self._extraTinyFont != null) {
                return self._extraTinyFont;
            }

            self._extraTinyFont = self.getFont(
                ["NotoSans", "RobotoRegular", "RobotoCondensed"],
                20,
                Graphics.FONT_XTINY
            );

            return self._extraTinyFont;
        }

        public function getFont(face as Array<String>, size as Number, other as Graphics.FontDefinition) as Graphics.FontType {
        if (Graphics has :getVectorFont) {
            var customFont = Graphics.getVectorFont({
                :face => face,
                :size => size
            });

            if (customFont != null) {
                return customFont;
            }
        }

        return other;
    }

    private var _heightCache as Dictionary<Graphics.FontType, Number> = {};
    public function getFontHeight(font as Graphics.FontType) as Number {
        if (_heightCache[font] != null) {
            return _heightCache[font];
        }

        _heightCache[font] = Graphics.getFontAscent(font);

        return _heightCache[font];
    }
    }

    
}