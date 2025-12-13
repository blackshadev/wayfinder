import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class FilledArrow extends AbstractArrow {
    function initialize(options as ArrowOptions) {
        AbstractArrow.initialize(options);
    }

    function draw(dc as Dc) as Void {
        if (self._angle == null) {
            return;
        }

        dc.setColor(self._color, Graphics.COLOR_TRANSPARENT);
        dc.fillPolygon(self._points);
    }
}