import Toybox.Graphics;
import Toybox.Lang;

typedef TextOptions as {
    :offset as Graphics.Point2D,
    :font as FontType,
    :color as ColorType,
    :justification as TextJustification or Number,
    :text as String or ResourceId or Null
};

class Text extends RelativeComponent {
    private var _position as Graphics.Point2D = [0, 0];
    private var _text as String = "";
    private var _justification as TextJustification or Number;
    private var _color as ColorType;
    private var _font as FontType;

    function initialize(options as TextOptions) {
        RelativeComponent.initialize();
        
        self._offset = options[:offset];
        self._font = options[:font];
        self._color = options[:color];
        self._justification = options[:justification];

        if (options[:text] != null) {
            self.setText(options[:text]);
        }
    }

    function setText(text as String or ResourceId) as Void {
        if (text instanceof ResourceId) {
            text = WatchUi.loadResource(text);
        }
        self._text = text;
    }

    function calculateTextWidth(dc as Dc) as Number {
        return dc.getTextWidthInPixels(self._text, self._font);
    }

    function layout(dc as Dc) as Void {
        var centerX = dc.getWidth() / 2;
        var centerY = dc.getHeight() / 2;
        
        self._position = [
            centerX + self._offset[0],
            centerY + self._offset[1]
        ];
    }

    function draw(dc as Dc) as Void {
        dc.setColor(self._color, Graphics.COLOR_TRANSPARENT);
        dc.drawText(self._position[0], self._position[1], self._font, self._text, self._justification);
    }

    function height() as Number {
        return Utils.Fonts.getFontHeight(self._font);
    }
}