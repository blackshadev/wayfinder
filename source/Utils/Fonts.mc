import Toybox.Lang;
import Toybox.Graphics;

module Utils {

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

    var _heightCache as Dictionary<Graphics.FontType, Number> = {};
    public function getFontHeight(font as Graphics.FontType) as Number {
        if (_heightCache[font] != null) {
            return _heightCache[font];
        }

        _heightCache[font] = Graphics.getFontAscent(font);

        return _heightCache[font];
    }
}