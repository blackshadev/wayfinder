import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

typedef HollowArrowOptions as {
    :stroke as Number,
    :size as Number,
    :color as ColorType,
    :offset as Number?
};

class HollowArrow extends AbstractArrow {
    private var _strokeWidth as Number;

    function initialize(options as ArrowOptions) {
        AbstractArrow.initialize(options);

        self._strokeWidth = options[:stroke];
    }

    function draw(dc as Dc) as Void {
        if (self._angle == null) {
            return;
        }

        dc.setColor(self._color, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(self._strokeWidth);

        var points = self._points;
        for (var i = 0; i < points.size(); i++) {
            var j = (i + 1) % points.size();
            dc.drawLine(points[i][0], points[i][1], points[j][0], points[j][1]);
        }
    }
}